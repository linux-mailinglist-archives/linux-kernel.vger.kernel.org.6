Return-Path: <linux-kernel+bounces-544476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405A2A4E1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386C83BB64A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB3263F4F;
	Tue,  4 Mar 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHPhV/4i"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E25425E837
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099219; cv=pass; b=gQR1ho/xUC9U4od2xyB4Z9IazYA5IrpeHVZf9alaHAQWKppLBZJsBm9A2TACRbnG5b60FRdSfYNWizW48P9qL6Q4qkDKNwSARpnUG08T+Sz0Yfz26UALovk7bf1OpafQqPT/++HcK1hkcO01v4Tip//qhL0Bj3maER3iVLTJ/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099219; c=relaxed/simple;
	bh=G9APMeQdymAEahfy3Dj+Uz/s4tn8OkfL0M5xvxvc9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbRLgNrSp2RA5yqegU0vMyN3F2ZksLTy0csREQNYKPA3lll7ucy/m9L6ELD3FqjsmljYgAP/Yjd+zkL/SYbpMUSfAI37NPDJf3FvdUtcPi9DGJBCL0FM4QImqNslW0zPlCmR62eywbTipoSUj0rG90Dxve7fYS+qM1MGmUQR2wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHPhV/4i; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id CB7D340CF13F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:40:15 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dbD4MZhzFx2H
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:38:32 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 97FD64272A; Tue,  4 Mar 2025 17:38:25 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHPhV/4i
X-Envelope-From: <linux-kernel+bounces-541561-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHPhV/4i
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 24D4C4206A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:25:28 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id CFDFC2DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:25:27 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63F6176FD6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641C1F4635;
	Mon,  3 Mar 2025 11:19:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF631F2BA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000780; cv=none; b=OXzKs1IQz9eIm9/AlcN1NDwBB0e8PkU4BrSV6uicMtmxTby8nvBRmybK4u89beiAf70nOheckzLaidHeC/pPT/Eb4YEM8685zbFpE6WpizxPCQ5fw2f0U9i0FSURj+7mSciPeD/zkQR6pSj20dn1MlpGi6Ns53gbU7LaCZr8Wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000780; c=relaxed/simple;
	bh=G9APMeQdymAEahfy3Dj+Uz/s4tn8OkfL0M5xvxvc9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjMINWAYekDikzk6ukS78E9kvpo2Nc4JTFPBT7kHCNuw6jehlTAP0d1FZmTQOKWSd+vQVDVLonDP1KWV3Lof1KmSCOu/WQx315XjRnKGrwng2o79CPsfvxw4Q3mEX/nPTXWjRCE53SL9/NGHzqNMr0tZ/A/z8t7wDNgBzrj8iGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHPhV/4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB1C4CED6;
	Mon,  3 Mar 2025 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741000779;
	bh=G9APMeQdymAEahfy3Dj+Uz/s4tn8OkfL0M5xvxvc9kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHPhV/4iZfWIKwhi4s7Jsgg8YJvkxGm22sqRAe0n9eZbwqhJhd1FV3btFCHsN7LFl
	 ZqMmQ4oXklikhQBfXbvupLM6kQ0Ro/Nvcw2yusj07qQq6MmJ9agt2QVS824X6Lzp8Z
	 MRgiBMYsAskPu+aAI2pk78GxwLf8+1/LHAKARoIe4oQ64Ew3ALkLC8q4/z0vii82ap
	 R6erjcSkd4sknS0LqJbtncE8QyLWxkL9EjJaEvhuTGcEnsq7nwYMFElstdUrnHDD8T
	 cpiqEjnI1ODuzziJgGVynb/J4xVHHzjOrZ5K5oedDslRDM8TOXB7pbC/5X8rlt1kho
	 MPUyRjNvFsQig==
Date: Mon, 3 Mar 2025 12:19:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, lucas.demarchi@intel.com
Subject: Re: [PATCH v2 19/24] perf: Simplify perf_mmap() control flow
Message-ID: <Z8WQPds5x8-9ABOm@gmail.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.350989371@infradead.org>
 <932e26ff-0654-442e-b6a9-166a7da03fd7@amd.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932e26ff-0654-442e-b6a9-166a7da03fd7@amd.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dbD4MZhzFx2H
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703930.30376@J/kYJvvkyCi3/karR9zsog
X-ITU-MailScanner-SpamCheck: not spam


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> Hi Peter,
> 
> Minor nit below:
> 
> > +			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
> > +				/*
> > +				 * Raced against perf_mmap_close(); remove the
> > +				 * event and try again.
> > +				 */
> > +				ring_buffer_attach(event, NULL);
> > +				mutex_unlock(&event->mmap_mutex);
> > +				goto again;
> > +			}
> > +
> 
> here ...
> 
> > +			rb = event->rb;
> > +			goto unlock;
> > +		}
> > +
> > +		user_extra = nr_pages + 1;
> >  	} else {
> >  		/*
> >  		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> > @@ -6723,47 +6758,9 @@ static int perf_mmap(struct file *file,
> >  
> >  		atomic_set(&rb->aux_mmap_count, 1);
> >  		user_extra = nr_pages;
> > -
> > -		goto accounting;
> >  	}
> >  
> > -	/*
> > -	 * If we have rb pages ensure they're a power-of-two number, so we
> > -	 * can do bitmasks instead of modulo.
> > -	 */
> > -	if (nr_pages != 0 && !is_power_of_2(nr_pages))
> > -		return -EINVAL;
> > -
> > -	if (vma_size != PAGE_SIZE * (1 + nr_pages))
> > -		return -EINVAL;
> > -
> > -	WARN_ON_ONCE(event->ctx->parent_ctx);
> > -again:
> > -	mutex_lock(&event->mmap_mutex);
> > -	if (event->rb) {
> > -		if (data_page_nr(event->rb) != nr_pages) {
> > -			ret = -EINVAL;
> > -			goto unlock;
> > -		}
> > -
> > -		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
> > -			/*
> > -			 * Raced against perf_mmap_close(); remove the
> > -			 * event and try again.
> > -			 */
> > -			ring_buffer_attach(event, NULL);
> > -			mutex_unlock(&event->mmap_mutex);
> > -			goto again;
> > -		}
> > -
> >  		/* We need the rb to map pages. */
> 
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This comment should also go up. Keeping it here is misleading.

Yeah, I did that in the conflict resolution (which conflicted in this 
very area), so the end result in tip:perf/core (or tip:master) should 
be fine as-is, correct?

Thanks,

	Ingo


