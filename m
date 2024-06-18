Return-Path: <linux-kernel+bounces-220146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4AB90DD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C33A1F249A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6991741F8;
	Tue, 18 Jun 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="xC4Qi3Cz"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BF1741CF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742339; cv=none; b=CXtgf4z9EmibNeSXa1t0T2UhTg0REofsZPsQ9ZqpE2kaHWG3vGq/LWl44+gpm7AyaR0JoHCZEWXVoIYQU4pTzeof49Mtzs5Gf0K0UM8cZdqSFQ4x357kF1mtPcDcyDG8CpK6UM1mGL0LfStVKTWA516rImTKcMZ1oJo3bOYRWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742339; c=relaxed/simple;
	bh=8oNrbsJDUFi2arQpoa8E9JtxUyxztZ4m37R7NbDLcBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUqqmG1okc2AYSSli+Nq0tK85Y9Sx/bRSXKo6zoWvqRKZNBBB7otDqwpiaIBOF0wgw499tRg9s32NPa4Zr8oxpo4eETR7opVjDk5fW2rvRnZ1carahmj5tlAhk73wFpmh/DxAlJchSkMrr1auiarSRtjSlu9HIQizgCVcImMpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=xC4Qi3Cz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37613975e20so2843185ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718742336; x=1719347136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQhc1tsGSf/rNyW7LBFRXj7br5aBpicaH2yUEpkeax4=;
        b=xC4Qi3CzN0n/65xRGX3g60MG0yennwhcCjN44Cc9S8Z0iAISaMM2KxK6CdzHjWrfS4
         HE6rpoEWf2+G7fWo+X6sLiSRiIaFpGZZ+L0j9NFeiDjfti/5zFz5HbzSA0LU2/SDWrqv
         nw2rcr73NUCv2D/Axv0mp9sOLW+5xWY9g4dBEPDUGt59E0ZW5iRGOJroEt0TW3RJovMx
         FNaYCXWhqdVL2fLjM9qR8D8cyHbiuKqAxuYMJJ3UEP6cHypzu3dbP9OoZRV2J9xcguPh
         vxOP2SZrcx9N+z0O78a7UKILJA5i4BlQxuQKNDZL0IRkumkdrvJ44zsP4K4cX7ZPTb0j
         gV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742336; x=1719347136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQhc1tsGSf/rNyW7LBFRXj7br5aBpicaH2yUEpkeax4=;
        b=LZUsoKFERLWqMSW4tjDLweyKuy45zZZzi0m/jr0HHk6vDRYHytvP7uixsqdUgyx1ZE
         mkn1cGEfCVIPdEKZ1/z/smLZBPE2yiTkw8/JF6BRZmCZmaxXveuznAOBUopCVyb70+et
         Sk1k0vrKQ2QU8SD5oNNfY65qPmBg7TZz7ItVyp/a7nwqfywWN2t5Exe6XrqFCBAnufVD
         53rF0DD88eQO1wHHYXgmxgr0Fj7TM7X1YBA/4zVPtLB6JOqOtRUcYYa3IehSPsS/kaYp
         mncGt9vcf7qB9E9fyXbPOLpMe+XI5dCkp4brac2nA07+688IWITLw5EmUDgjs4IOzCx2
         bwLw==
X-Forwarded-Encrypted: i=1; AJvYcCWr+tnE5y1mLMAdD86K2KOxIM9qd6D3cFI6IgZIRX/1PZk17vzyrJL2CUHRIv/rqcIlbZAQQZuZt085pZSn+B5f+ucENtucEk14hXjf
X-Gm-Message-State: AOJu0YzzJ57aJhYEte//RaY5oOeLzv5mJ1LRRDhDR22Bf/rtXIf3CiKw
	LnWiEWo0SJtJ24uDIre8AaUn1Nwp1B6+mipsV3BZ2x12KTpHM7E2tq+gThh14q8=
X-Google-Smtp-Source: AGHT+IHoJT1oMZwvIoV4Bftj499G+4TSIa9T4NEJOxqAqW/MxiIzVA6CWXBDsjwnR6+dLu4QLUTFLw==
X-Received: by 2002:a05:6e02:138d:b0:375:c394:4344 with SMTP id e9e14a558f8ab-3761d7084a2mr7438245ab.21.1718742336400;
        Tue, 18 Jun 2024 13:25:36 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d8b45132sm22438025ab.73.2024.06.18.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:25:36 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:25:33 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: mario.limonciello@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH V2 RFC] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnHtPbszYT8afOOk@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>

acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter

The _OSC is supposed to contain a bit indicating whether the hardware
supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
be considered absent. This results in severe single-core performance
issues with the EEVDF scheduler on heterogenous-core Intel processors.

To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
enabled. This allows CPPC to be properly detected even if not "enabled" by
_OSC, allowing users with problematic hardware to obtain decent single-core
performance.

Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

---

V1 -> V2: Rewrite to work in cpc_supported_by_cpu.

RFC: I have not yet tested this patch to ensure it functions properly,
 nor have I attempted to compile it against mainline. My system takes
 a couple of hours or so to build a kernel, and I'd like to submit this
 for feedback now and test once it's sent.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..af2d8973ba3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2063,6 +2063,12 @@
 			could change it dynamically, usually by
 			/sys/module/printk/parameters/ignore_loglevel.
 
+	ignore_osc_cppc_bit
+			Assume CPPC is present and ignore the CPPC v2 bit from
+			the ACPI _OSC method. This is useful for working
+			around buggy firmware where CPPC is supported, but
+			_OSC incorrectly reports it as being absent.
+
 	ignore_rlimit_data
 			Ignore RLIMIT_DATA setting for data mappings,
 			print warning at first misuse.  Can be changed via
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ff8f25faca3d..7346a25e68ce 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -11,6 +11,14 @@
 
 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
 
+static bool ignore_osc_cppc_bit;
+static int __init parse_ignore_osc_cppc_bit(char *arg)
+{
+	ignore_osc_cppc_bit = true;
+	return 0;
+}
+early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
+
 bool cpc_supported_by_cpu(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
@@ -24,6 +32,10 @@ bool cpc_supported_by_cpu(void)
 			return true;
 		return boot_cpu_has(X86_FEATURE_CPPC);
 	}
+
+	if (ignore_osc_cppc_bit) {
+		return true;
+	}
 	return false;
 }
 

