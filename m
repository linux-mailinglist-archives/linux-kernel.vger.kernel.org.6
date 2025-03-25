Return-Path: <linux-kernel+bounces-575206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F5A6F417
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DB33AA6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F913255E2C;
	Tue, 25 Mar 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FI6FF7W5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BC1F0E31
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902354; cv=none; b=CvRwoh/U3LVIzZMuGffo1PJh+6khYS+W4AuAIrpFsRi4zA00RxkuGyQWuMzsvmzzlb92t3uKupiSrc3sllxYYV0NVUFXbYUnZJSQy9PR9q3kdWluUfLi63OUcPuF1Ir1JgyEHVCs0SAUCkGq4TbQWWL9kn1RVBA9KNuXbCVAHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902354; c=relaxed/simple;
	bh=pLt36G8wzYS308hePFvWcTj/mP1iMuzUm3GgVjUFZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0AtVjUPmmnyVXKVuLxJM5QsieB+KC64dohgC5CHJSQ9S57SmoVaREKnYL+XTDi3H7w7ny16OM7DsopFKwxdGlUQsvJYDFZuoItyLdZ8HDvcSYGNmCPaEBEa6iWdxCmjRx0YNRjsadcaX7/IJygvc2nNYx7Pwhcr9bonOzJfGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FI6FF7W5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742902351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLTjIkAEyVDfqSLVGRyd4Pw4GfqI4jhl0z3ueIuaXQc=;
	b=FI6FF7W595N6VooJex7ukVJyVqLA0fRcyCtiLUPSYRc58L7G2leRxfsNkfQCgnqhn4Shi2
	iqDzeui3JcKxRzuY4PqWC6AnSN6MXLax0b2FMC51i05UoNRFQlBXbL6f7RpQVmL3B59Va2
	qD8P6RCTYfbRumUNy50hmvrTCPmbvUE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-x0VVr2t6OBeXA_E2AThOog-1; Tue,
 25 Mar 2025 07:32:29 -0400
X-MC-Unique: x0VVr2t6OBeXA_E2AThOog-1
X-Mimecast-MFC-AGG-ID: x0VVr2t6OBeXA_E2AThOog_1742902347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8CC11955D84;
	Tue, 25 Mar 2025 11:32:26 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6ABE1801769;
	Tue, 25 Mar 2025 11:32:23 +0000 (UTC)
Date: Tue, 25 Mar 2025 12:32:21 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
Message-ID: <Z-KURRE_Gr72Xv_n@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320200306.1712599-1-jstultz@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Mar 20, 2025 at 01:03:00PM -0700, John Stultz wrote:
> +static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
> +				  enum timekeeping_adv_mode mode,
> +				  unsigned int *clock_set)

> +	 * Also reset tk::ntp_error as it does not make sense to keep the
> +	 * old accumulated error around in this case.
> +	 */

I'm not sure if I still understand the timekeeping code correctly, but
that doesn't seem right to me. At least the comment should explain why
it does not make sense to keep the NTP error.

Resetting the NTP error causes a small time step. An NTP/PTP client
can be setting the frequency very frequently, e.g. up to 128 times per
second and the interval between updates can be random. If the timing
was right, I suspect it could cause a measurable drift. The client
should be able to compensate for it, but why make its job harder by
making the clock less predictable. My expectation for the clock is
that its frequency will not change if the same (or only slightly
different) frequency is set repeatedly by adjtimex().

> +	if (mode == TK_ADV_FREQ) {
> +		timekeeping_forward(tk, tk->tkr_mono.cycle_last + offset);
> +		tk->ntp_error = 0;
> +		return 0;
> +	}

-- 
Miroslav Lichvar


