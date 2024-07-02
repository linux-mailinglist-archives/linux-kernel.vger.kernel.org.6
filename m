Return-Path: <linux-kernel+bounces-237650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31878923C1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF75C2879A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607215B0F4;
	Tue,  2 Jul 2024 11:10:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E91591ED;
	Tue,  2 Jul 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918628; cv=none; b=FSs83FVZCTpU630M1nZNiKjSScYmUVK9PuBp3/Jqkez1P/hX1mxwttDizPiyMeRX7APkeuAm++wQCsfgH1c+m6A3pOtmFbrdprhh/7EqyZAH4NNx40t3A28PsZ2oM9fYkrHXmnsThbqmzvXp2hyW/FYyXakPwLtuaSF34NK7cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918628; c=relaxed/simple;
	bh=rTaJ0w6/itfmt4ygZvgEm2Q6+AQjMGYbtw9tNRjtlu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfwn8xRzEHEqS7Vgvmndow3+2IWFhPg6TyU7whMID3fFN+ahE/8HgMRxrMcpjO7/LtNIjUbGeH7Mlg4IipKWkJSc34GwbOMOB7Az/cjGD2M9KjQvURn203c4hjWlNqYlOibADqx13eso+TSFIqtv5j5Y+DCFg6aurljvkpVGZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72550339;
	Tue,  2 Jul 2024 04:10:50 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E7013F762;
	Tue,  2 Jul 2024 04:10:24 -0700 (PDT)
Date: Tue, 2 Jul 2024 12:10:21 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH 2/3] Track basic SCMI statistics
Message-ID: <ZoPgHRl8FUo9-Xvz@pluto>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
 <20240701142851.1448515-3-luke.parkin@arm.com>
 <ZoLWH9-JPFQB4YSu@pluto>
 <490bb053-f2dd-4c6a-a976-c8d21d66eb4c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490bb053-f2dd-4c6a-a976-c8d21d66eb4c@arm.com>

On Tue, Jul 02, 2024 at 10:57:23AM +0100, Luke Parkin wrote:
> > Ok, so IMO, this is the main core thing to rework in this series: the
> > "counting" operation/block should be defined as a macro so that it can
> > be fully compiled out when STATS=n, because these are counters
> > incremented on the hot path for each message, not just once in a while,
> > so the above if(IS_ENABELD()) now will be there and evaluated even when
> > STATS=n.
> >
> > Something like:
> >
> > 	#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
> > 	#define SCMI_LOG_STATS(counter)			\
> > 		<your magic here> 			\
> > 	#else
> > 	#define SCMI_LOG_STATS(counter)
> > 	#endif
> >
> > .... I have not thought it through eh...so it could be radically
> > different...the point is ... the counting machinery should just
> > disappear at compile time when STATS=n
> 
> Hey Cristian, Unless I've missed something, It looks like IS_ENABLED() does do
> what you ask for.
> In Documentation/process/coding-style.rst:1168 it reccomends using IS_ENABLED
> for conditional compilation over #if and #ifdef, saying that the compiler will
> constant-fold the conditional away.

Yes indeed, it will be compiled out anyway, forgot that despite having
it used myself a few lines below :D .... but from the readability standpoint,
given that we will sprinkle this all over the code, wont be much clearer to
conditionally define once for all an inline function (like mentioned at the
start of that coding-style.rst paragraph) or a macro in a header (like common.h)
to wrap the atomic_inc

#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
static inline void scmi_log_stats(atomic_t *cnt)
{
	atomic_inc(cnt);
}
#else
static inline void scmi_log_stats(atomic_t *cnt) { }
#endif

and then just call it plainly wherever it needs, knowing that the compiler
will equally compile it out all-over when STATS=n.

ifdeffery is discouraged in the code flow but it is acceptable to define
alternative nop fucntions in a header.

Also because in some of the callsite you handle 2 stats with some ifcond
(conditional on the IS_ENABLED that is good) and that could be a problem,
but those calls can be split and placed alone where that some condition is
already check normally as in as an example in scmi_handle_response():

	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {                           
                scmi_clear_channel(info, cinfo);
                complete(xfer->async_done);
+		scmi_log_stats(&info->stats.dlyd_response_ok);
	} else {                                                                 
                complete(&xfer->done);                                           
+		scmi_log_stats(&info->stats.response_ok);
        }                                    

...what do you think, am I missing something else ?

Thanks,
Cristian

