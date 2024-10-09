Return-Path: <linux-kernel+bounces-357572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6189972D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC141C2232F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1361E0083;
	Wed,  9 Oct 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qpmnluQG"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA01DFD80
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494034; cv=none; b=gXjhJY4bX7216esg9Yfcm66ACeKT34gr3xo5r2YzdNJaKVR4WTpMTcytj4HtQpDDnXV4NHREiXA8sP3m7fXWXvogdM7l/c/uPIUcD5DfEOH2CmqqxDGLvzrpvZ/OL4uhgPTPK6FBB/v1BfXcMiNzyeLWsQ1GtdFaVV9D9QJlbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494034; c=relaxed/simple;
	bh=klMNfne84d1kgkHC4atcIfdIjejvE4rVNstBvQFCWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjgKAPXzpza5G56+RXPqMQ5fHy5YUk6lUK5adodAkOZZ3JqCuHElfURAuOCkt4SocP8tfHQ/pa8C1peijMYeukH/+v63mWn1Qk7Gi6sOntB3dIMkEygB31e4qLaDob6jQgACm1bsdjNkAZ748fr91obuZZtVm6osoxYCRF/EM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qpmnluQG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9f98f2147so2646233a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728494032; x=1729098832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUJ9rnG2uJ0j7bwfLc8ihegGzcRS1BQcJMo5xx5rPvM=;
        b=qpmnluQGthP+JZpYp/wf9jFrHqgfd5E4vPB5mn4K37r87DlKCTvOMH96/P2cV6LxVN
         5BDehINgCN/GJEVs6rn3pZluioSSL3Ya9ZPUSR+7NnG4eqYmyDTIlANNZeJsmj21tTVz
         9P5d4IB8d1pz0ARCRYwCgpJIgvDKtiHI8Wkf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494032; x=1729098832;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUJ9rnG2uJ0j7bwfLc8ihegGzcRS1BQcJMo5xx5rPvM=;
        b=pIv5WyMzXCdleYAaVcj42xnBNHSpmXfSFs0wpOKH7YltjKAG4mgby4A3WYmu7PRPI2
         4FFidR1Pp5efaI0or0Lx1DXW7S7mqI6Vtfw0/QT6EBOVXiW/KRXGB8y8R++SD7Vd3F8q
         n0P4kIJnUftor9iWN49sTN0RG4/cqyaBJE0z0/sRP4VVSIDpWjJTx3L16fJD9hlkCOca
         eN+AjA2fD0oPIZX9eA5snCP1rSxNNLbhL5qJB8u6PZBvDdgz+oIaVMEjzD9Axk/jOUM/
         K4EJ1Bn5eFK+VOdGT/y/oNKTyo4UvnE27GLzT5nFwnfu6n+jU7ZnDoGVy/ktqtRSdr3Z
         kHcA==
X-Forwarded-Encrypted: i=1; AJvYcCVXCHupXUSZR2b0zWIL1pmfOIMlas/kgqWegAYE5vRgN8TJbC+kjCtoJA7xEl52E2e8C0wc4HFIpKyThD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8IlvFBYiwSGfhQ97t+vFz5ZB5VscFQ1TGRNlNFJmf2wJ1wPc
	r5rEALJ1EBDrfRr/kqdbaqpUTShX4T85v0EBmMLxXA564amUku8dYR3ofN/Sgyw=
X-Google-Smtp-Source: AGHT+IGCxMaZ1teuexWUVBV5sBk+xGYqduyCYApVj9E/JdnEvtvGwcwBKdd3sP443QuWLbWgg5eCfA==
X-Received: by 2002:a17:90a:9e6:b0:2e2:b45e:88b7 with SMTP id 98e67ed59e1d1-2e2b45e89a4mr2237542a91.26.1728494032134;
        Wed, 09 Oct 2024 10:13:52 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55ffa00sm1944174a91.21.2024.10.09.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:51 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:13:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next 0/2] igc: Link IRQs and queues to NAPIs
Message-ID: <Zwa5zdhtxlqJxIj7@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
 <87h69ntt23.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h69ntt23.fsf@intel.com>

On Mon, Oct 07, 2024 at 04:03:00PM -0700, Vinicius Costa Gomes wrote:
> Joe Damato <jdamato@fastly.com> writes:
> 
> > Greetings:
> >
> > This is an RFC to get feedback before submitting an actual series and
> > because I have a question for igc maintainers, see below.
> >
> > This series addss support for netdev-genl to igc so that userland apps
> > can query IRQ, queue, and NAPI instance relationships. This is useful
> > because developers who have igc NICs (for example, in their Intel NUCs)
> > who are working on epoll-based busy polling apps and using
> > SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
> > queues.
> >
> > See the commit messages of each patch for example output I got on my igc
> > hardware.
> >
> > My question for maintainers:
> >
> > In patch 2, the linking should be avoided for XDP queues. Is there a way
> > to test that somehow in the driver? I looked around a bit, but didn't
> > notice anything. Sorry if I'm missing something obvious.
> >
> 
> From a quick look, it seems that you could "unlink" the XDP queues in
> igc_xdp_enable_pool() and (re-)link them in igc_xdp_disable_poll().

That approach seems reasonable to me, but I am not an igc expert by
any means :)

I checked and it seems that igc_xdp_enable_pool and
igc_xdp_disable_poll are only called while RTNL is held, which is
good because netif_queue_set_napi uses ASSERT_RTNL.
 
> Or just the existence of the flag IGC_RING_FLAG_AF_XDP_ZC in the rings
> associated with the queue is enough?

I didn't notice that flag, thanks for pointing that out.

It might be better to go the link/unlink route as you described
above, though.

> I still have to take a better look at your work to help more, sorry.

No worries, thanks for taking a look.

I'll implement what you suggested above and send another RFC.

