Return-Path: <linux-kernel+bounces-524029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3904A3DE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6873C19C4FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06721FE45B;
	Thu, 20 Feb 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="f7c0XOqT"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FB1FCFD2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064655; cv=none; b=ansyjbrY3WaVWR4q902hhMFm+VkZ/nYTSwpS1zudVYKvvpmg8Kdtf35wS76k1X2O6kCOYohE1UGViIIJR5mCA1aDcPV7GEanq9udDeMoUw4r/Q0X4UjxR8rgFTQLm0EfylPsnEDBMKPswGLCmCPrbyliGd0Yp1Rba0h06hAzwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064655; c=relaxed/simple;
	bh=P0iL1ed1wNflMW0E42G2MgHAm9SEY1NPeHARBn5PyFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft3d74iTyRMYciOHZnlxe/C2ISIe1uhPXP25eWTOZOvsPF0TnCUcNdHjOyV0PKWosZYcxEhhKn0Fc26AkEiciGDMTxkHINusb+z0jbdLoUBgXMAITZgcAsrokc2IDhFS+irR6jcQHjuGvz0k3jcWbwHEHhKExkSbAicdeVxzzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=f7c0XOqT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0ade6036aso207547985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740064652; x=1740669452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bT7wEbyY1NyR2XOZMCsNefoHjaTOzZ5cgeVIHxgcfE8=;
        b=f7c0XOqTGg3O2wyFxioCsewI0pRGyOAwRFIdkk9Dx/keRDhkwi/yKU58q1cU/UJ2xk
         7sYfZx2TJm2d/qK9kNxEt+549pdRvZF4c3MsYHFOZNetOQkK172sP5LVTQlWe0rXSQsi
         HbA8A+tn5tKy8zK4SLGxhOfYcJCJDEEYX+o76VzBgBOmqlZt/gvqNyCiqOwdQUsilzAy
         VhO2CGCVKOpE+lfW0EkV0KV5/jmELnvmYsfS5gsVDJeBkNuKOszGTbJLUIrzj8xwc28J
         3wqDvQ4KN06K1wlQYy0JU+bbf+Ts+axj2Ua67Qe17Xhr1nJbVsnUO3sdsILICsSDWPGU
         lmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064652; x=1740669452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT7wEbyY1NyR2XOZMCsNefoHjaTOzZ5cgeVIHxgcfE8=;
        b=fOmo5kqOdDcHWSZXrNQhPWHZCID7q/knxV7kTOMu2x2YpFBjTPOweFvjlgdOBEFJyV
         uwKVtirKuu6P2RmDojEzcBHu/qd4CklS3NUIZBHMNL5gbr2ZvpbvmgdhqayCoCDz0COA
         vMC47HidDKOZBjvY7YaNSGUiicaSW1ln2R5GPGZZ3E4/2lTcoeE6s2/MPxAMcr0PwOPE
         8idgALDFwah2qCQRm7ckSfhquqy5kIcvF5OFxM9yWmFeKtFI26/OQVQE5ucWKmAP3Ncq
         Kh8CgmDfnWf3yrGchzWEoIhKQclL1rP5pfIuEtnWkGBpDin83NWl46alofnN/wCwyWFc
         FrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXADh9Ci6yg6sEt2NNsH5JMOJjhv8PK47de408m4RBMkTjTPzfdE3ZTL5TgNlq+AC1GYwxKF+SMxknneOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGjxvRnqPf2iNf0yYAGboUsF7VAPvZi+WM3wGQex7nkPw08nH
	pi+wgZ0b3TwHYFef+luqhbDKycFtMWFgQecpraEaNUuyeTIKW09BeWYeYCa2IXE=
X-Gm-Gg: ASbGncsEJjCmubtkKQlHGbSR/FwC3SdIFk5a+zquddvsBGAM2TBpjRqOdFbFfTSdMvh
	UcVizLNTrcjMtyMF1Axf6mL8w3s3xexKC6aT02B9bduslOqSGzQYPmhpAYFxvMW1tTU3e8iyvAy
	TbDwxc1II40Ny3Z+NZMwiL+QcJ7wsly7WW8d5hD3KRReMsl1/17jwIaOr8oxlv9aCCgehcCigYL
	87fcweJDGRseSwKfcnD5nZWLwoAXses0Lr1mqgzkZYTDLXCR0+6zlSQ3lB/VT3Pyh1Q8fHdrohq
	NTESSlvX/FikTapa1QA7pWsgEt9FZPMIEvRTpOFnuxI8TAmLAIIY7Dq+ax+cXl7+lawRzFUPUw=
	=
X-Google-Smtp-Source: AGHT+IG1rJFrfiErv1L0BH8ZXpdfN5KFcuiSpX43XZSrCsBflYFgWd7IJTSIHk/2gw4qW1vhdByGdw==
X-Received: by 2002:a05:620a:4687:b0:7b6:d7be:2e4 with SMTP id af79cd13be357-7c0c229bd0cmr480083285a.26.1740064651343;
        Thu, 20 Feb 2025 07:17:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bc8819bsm508356785a.74.2025.02.20.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:17:30 -0800 (PST)
Date: Thu, 20 Feb 2025 10:17:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, keescook@chromium.org,
	gregory.price@memverge.com, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: Extend syscall_user_dispatch test to
 check allowed range
Message-ID: <Z7dHid-IL7OAPmUa@gourry-fedora-PF4VCD3F>
References: <cover.1739894594.git.dvyukov@google.com>
 <5e105b1382cd43d05f1d3a80958e4f50f32144c8.1739894594.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e105b1382cd43d05f1d3a80958e4f50f32144c8.1739894594.git.dvyukov@google.com>

On Tue, Feb 18, 2025 at 05:04:36PM +0100, Dmitry Vyukov wrote:
> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> index b0969925ec64c..fa40e46e6d3e9 100644
> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
... snip ...
> @@ -110,31 +111,15 @@ TEST(bad_prctl_param)
>  	/* PR_SYS_DISPATCH_ON */
>  	op = PR_SYS_DISPATCH_ON;
>  
> -	/* Dispatcher region is bad (offset > 0 && len == 0) */
> -	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
> -	EXPECT_EQ(EINVAL, errno);
> -	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
> -	EXPECT_EQ(EINVAL, errno);
> +	/* All ranges are allowed */
> +	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
> +	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));

A 0 length is ambiguous and nonsensical in every other context, not sure
why you'd allow it here.

... snip ...

> +bool test_range(unsigned long offset, unsigned long length)
> +{
> +	nr_syscalls_emulated = 0;
> +	if (prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, offset, length, &glob_sel))
> +		return false;

This creates an ambiguous failure state for your test. Is it failing
because the range is bad or because you didn't intercept a syscall?

Better to be more explicit here. It makes it difficult to understand
what each individual test is doing at a glance.

> +	SYSCALL_DISPATCH_ON(glob_sel);
> +	return syscall(MAGIC_SYSCALL_1) == MAGIC_SYSCALL_1 && nr_syscalls_emulated == 1;
> +}
> +
> +TEST(dispatch_range)
> +{
> +	ASSERT_EQ(0, setup_sigsys_handler());
> +	ASSERT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel));
> +	SYSCALL_DISPATCH_ON(glob_sel);
> +	ASSERT_EQ(MAGIC_SYSCALL_1, syscall(MAGIC_SYSCALL_1));
> +	TH_LOG("syscall_addr=0x%lx", syscall_addr);
> +	EXPECT_FALSE(test_range(syscall_addr, 1));
> +	EXPECT_FALSE(test_range(syscall_addr-100, 200));
> +	EXPECT_TRUE(test_range(syscall_addr+1, 100));
> +	EXPECT_TRUE(test_range(syscall_addr-100, 100));
> +	/* Wrap-around tests for everything except for a single PC. */
> +	EXPECT_TRUE(test_range(syscall_addr+1, -1));
> +	EXPECT_FALSE(test_range(syscall_addr, -1));
> +	EXPECT_FALSE(test_range(syscall_addr+2, -1));

If you are planning to include 0 as an allowed length, you need to
demonstrate what it does.

> +	SYSCALL_DISPATCH_OFF(glob_sel);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

