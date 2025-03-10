Return-Path: <linux-kernel+bounces-554474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD606A59835
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FAC188DFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93E22D4DD;
	Mon, 10 Mar 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFd9FhJa"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036422B59D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618330; cv=none; b=rzupSNIqbB1R8EKrnxnuSxHMDVdJupz+JYjH8CiURpw9Yg73s+Q/lvIV771MXlyxsdabOkhsjpbWkwR1jFtMwdr1Myu8dCWt2dwk9UFuABINK4vk+MJ1xpE2KcT43Wonnayh190b9mCu/7H0DFioklKDVx2MoCiHQL0BICpMGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618330; c=relaxed/simple;
	bh=La8fa582+cudZWU7EBZb+kiU11zXIyrob0PJV2PXjfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ6Rt04nlaGxwV2HoSNcm/0/zEOM7EJ2lrTvDcSqKDCU5BNvEAHYuQ/44Ym1BPdtkhOaFavt+S70cVucHkboz20n4MnsmcubAG3bNZZuYaqQVNmThQR5529tdr0VP1cHNa1cn1pyAYmorKVRyL9LD6nzm1X3flwIezfDWzLARs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFd9FhJa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so25444445e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741618327; x=1742223127; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJhmOti6S9aSxHFcfgWlRYy87Ur6fs4aWozpDuFk45g=;
        b=KFd9FhJapk9LSPrTSWPYVYrj9OPaxtDOWFbamAr2nAK3v58lTN7B1G/K5ZL/s6+++r
         Ej66R0z7uvendhA6TlVMinoHfN91/7IQfe36jmXtlxy62nz44IqciyX6wdOLXT0dIOkj
         59kDKpM7uYwhvFNKmFd/4qv8kevkUtZq1xhGXaNMZYvmvyIUHd6mBTJYdkyBo//EDdEX
         7dS41EdawFpgPDo7Av8GqU1gbK2iqC+O6YjxlXVpZDkUP1SBBZ94U+beNZx9e5ngdl3T
         R4PA32rtAdERI02fVx4CEnQYQr+qhb5QgFIwheqvM/c1Sek1g0esxv+hXFD6Aal95DQS
         9hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618327; x=1742223127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJhmOti6S9aSxHFcfgWlRYy87Ur6fs4aWozpDuFk45g=;
        b=eTFv6gWUyp19AVFLoP4D4cZmCl6izOQOST5gQq5hUsYMMPCQVUyQRa4ssN7MTg0dT3
         91yFdc6RWyP4bGDWnzAD48kh2Zmm9H/j/XIuOUpuoBFVJ49Fp6Y0ugBnxyuxasZybN9w
         S3a1sy7wG66u3NzLck+14tubgz4I/QVGZr5V6q7sr0GRpzUcr/0zUrFcvMGlrH0Qoxvf
         +SOTo7S+aRoKoaB8LRMs2aSRs1LhpwmCGmJDKdV4gF/TQSLhhWGUgGYUoEz8kDT0n8ba
         6UDCh8Bnk24n1ybH1VufBJ7Acfc4oDkLHe1O0Tg90MR2Hc/DbrOd9ZOCBRaVbr9sDtZm
         K9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXEEi11CxZQvAuuPpwZFs9xUjygRiUX2mmEB4vfUCp7Ji0syKOiGuMcBdgG5S7h17n2e66owRJbuVfqEJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePhM8A64y/KfLzIwcW9Kk9W+xFGTu/O3CU26snM70bx9HStH4
	x0o0nQ0hOULnpbLtRvMLS6flFZsGZXvDKMCPGXrWckcm/RN3vakpldiL5NvqK/o=
X-Gm-Gg: ASbGncsXWBXt/RBPZZUK/fItjlhsnM9Tqk2Ut7KlREGRxFT65YVxZ+yiVE+kRBaUXjn
	ugQIeOiLdEmaI/UHR8DbWV893KTsHhSU/Qo7k9mW4NOKREu0Iw4cxEQnERVTQpaylXEDrj52DKa
	+eHr/1zybrO+Ayb+VC74M62jiVzzT5mmTEwDSYwNzp3/UqRLgtOO0ELSrRGgmayLJWMVqPa2nWh
	r9mnwYLRHe4eECaZ7cKrc/3brXWvXCGuubv5SE7IZWIsv8yBV7s8nrA5170I8saOpgO8funj1nf
	f/T3IQDzm7M+i45UMxeSGKXsGjTLl1Q0NPwh2pSCPAzI5ymhLw==
X-Google-Smtp-Source: AGHT+IEWXxlykPP+DK6XBhySTuz9TVLUo/1Ocj0YrcVL3sXXqxgbc5YK7TpnRor10s4o+P6MhNGnfg==
X-Received: by 2002:a05:600c:1c2a:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43c5a5e9074mr106986775e9.5.1741618327226;
        Mon, 10 Mar 2025 07:52:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cef25f075sm63882915e9.28.2025.03.10.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:06 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:52:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Patil Rajesh Reddy <Patil.Reddy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/pmf: fix cleanup in
 amd_pmf_init_smart_pc()
Message-ID: <4a14c0a5-d6f8-4df9-b947-a0d3c3ef02b3@stanley.mountain>
References: <43ad5358-f5b2-4cfc-85b4-e7ab8c7cf329@stanley.mountain>
 <32c6c456-94f0-f077-040c-09f67d60953a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32c6c456-94f0-f077-040c-09f67d60953a@linux.intel.com>

On Mon, Mar 10, 2025 at 02:43:51PM +0200, Ilpo Järvinen wrote:
> On Mon, 10 Mar 2025, Dan Carpenter wrote:
> 
> > There are a couple problems in this code:
> > 
> > First, if amd_pmf_tee_init() fails then the function returns directly
> > instead of cleaning up.  We cannot simply do a "goto error;" because
> > that would lead to a double free.  I have re-written this code to
> > use an unwind ladder to free the allocations.
> 
> Thanks Dan,
> 
> Could you please amend this with the information of what is getting 
> double freed, it took considerable amount of time for me to figure out.
> I assume it's ->fw_shm_pool ?
> 

Yes, that's it.  Sure, I can re-write that.

> > Second, if amd_pmf_start_policy_engine() fails on every iteration though
> > the loop then the code calls amd_pmf_tee_deinit() twice which is also a
> > double free.  Call amd_pmf_tee_deinit() inside the loop for each failed
> > iteration.  Also on that path the error codes are not necessarily
> > negative kernel error codes.  Set the error code to -EINVAL.
> 
> Maybe I should start to consistently reject any attempt to use 
> cleanup/deinit helper functions instead of a proper rollback. It 
> seems a pattern that is very prone to errors like this.

I do not like deinit functions.  They are so hard to review.  But I
detected this bug because of a Smatch warning:

drivers/platform/x86/amd/pmf/tee-if.c:540 amd_pmf_init_smart_pc() warn: missing unwind goto?

regards,
dan carpenter


