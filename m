Return-Path: <linux-kernel+bounces-271396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D622944DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC1DB22E98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394821A4876;
	Thu,  1 Aug 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3mQpYtN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C531A4870
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521218; cv=none; b=s/HyyOW1xpT937mTgsrRbtRM/Q0X0EQPxJCBMKWg0L8gtGK4ydvsPNmmlEoI+EfEfkfY5DYOepiFONFkCkBHdjb1ALVCja9cpIfARf6Us9m4T4p0kiK/XRGf0AQKkTl8CKKX0+L4ozepxEfu07TyZ/8u/XnYt03PnMSGVPS5f0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521218; c=relaxed/simple;
	bh=bz3wKeF8rsjmjXrGrtC9eTN/ZKuBFkTMUakuVj5aqKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4zArGESijibEQFsEeBhOexUk0g19JspTvRu+SujNjkDDJz8vYlOwM3SnfPd/eKGUufD6dsKqIz+/FsFSY2Ix91jjArjMcnEEQxYWSGjnAyOoMT27vubOsA0CArLtA/1J23eoRK+RJimtIz1Mej9bAT5b2emXU4WJ2Kz+3voo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3mQpYtN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722521216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NtpgAPFp+k8BUIgugrTLAvk4bvPd8UTPqZtLDxDKKxg=;
	b=I3mQpYtNnDzolpHgtotE/DmEvPhV9ZGbsdb29lzDHLmDVZxoTd7duqQcMpeDG9Wbc5KOCW
	5AGL2bdwl4/MVaI9Qgb1U5eBSRQVrFQ37HahK1hu79i1d1I61333vT/ns4/ozWJhdnopqV
	1cD+Waavae/uYjoKP3mbvWk+QvMHZ+M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-PwqJlKqZN-yuHHxW4zmYrA-1; Thu,
 01 Aug 2024 10:06:50 -0400
X-MC-Unique: PwqJlKqZN-yuHHxW4zmYrA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EB7D1955D4B;
	Thu,  1 Aug 2024 14:06:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DE9561955D48;
	Thu,  1 Aug 2024 14:06:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 16:06:46 +0200 (CEST)
Date: Thu, 1 Aug 2024 16:06:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
Message-ID: <20240801140639.GE4038@redhat.com>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801082407.1618451-1-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/01, Liao Chang wrote:
>
> @@ -2276,22 +2277,25 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>  	int err = 0;
>  
>  	uprobe = utask->active_uprobe;
> -	if (utask->state == UTASK_SSTEP_ACK)
> +	switch (utask->state) {
> +	case UTASK_SSTEP_ACK:
>  		err = arch_uprobe_post_xol(&uprobe->arch, regs);
> -	else if (utask->state == UTASK_SSTEP_TRAPPED)
> +		break;
> +	case UTASK_SSTEP_TRAPPED:
>  		arch_uprobe_abort_xol(&uprobe->arch, regs);
> -	else
> +		fallthrough;
> +	case UTASK_SSTEP_DENY_SIGNAL:
> +		set_tsk_thread_flag(current, TIF_SIGPENDING);
> +		break;
> +	default:
>  		WARN_ON_ONCE(1);
> +	}

Liao, at first glance this change looks "obviously wrong" to me.

But let me read this patch more carefully and reply on weekend,
I am a bit busy right now.

Thanks,

Oleg.


