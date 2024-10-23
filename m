Return-Path: <linux-kernel+bounces-378023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246F9ACA26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705AE1C2172A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635D1AB6F1;
	Wed, 23 Oct 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TlbF2BZv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC311AAE31
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687099; cv=none; b=TxiaEyhJHb8i5J3XIh0zq+N8ebizLM6/M+MZvJwRF5OzxPAQIEtlJZ02oknR9bN8lfysC/pVEgReeS6G4FSkQppiEMEMXD3T9wXw1wsg1M5KVAt/+1tRGI+ChhZywkIUNC7Fm5bvNcZ+c3ADpuvtlCjaQUeM2x0K2Fqa6HWOUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687099; c=relaxed/simple;
	bh=Pu2nrpOTouRjv0rl8mdMkLOx1mu2ZRdyvoO9H1ikB6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzmqVzJwjjoXpJjEprknNLFztd8AyIRBGKQiXmjINaue7qfTvwdSAaPbso4MT+kerQBptIYWTc1De3rDQSZRSzDub5axJRzAXlxfsY1HfdOTb4DarTeGPJYLQmEJB6O/dbJo32oIKPSuOPXPOCQ4+u5rdiW+csbQmlXAxHFm4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TlbF2BZv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so74559105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729687095; x=1730291895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmNJ4njEEpOrmBT0rUaUQn7lrkfzlys5UMDexBH3nfs=;
        b=TlbF2BZvj0fRCX15aRi0H+gR0EKgk6brNcAKy5QBwoBokwzRGKm0PToXPYfHtvz216
         acmiAGGGF1ZpeTRlrGlUrgfa4p8rJkPMKjaZYdne6+igHtOT7nMBgLb/tR06ZkqdaV/M
         nQ2Fce9FN3EJfhfcAR1GAKhYoDveoQJSp2/D+okG5XhyeQLTulp0M+D3+MwZLsrJqlSR
         z0n1VEWRds2fzJKHi+dIHoS7LiGGMFNwvyrz61gq01i0cWp+wjy1y9yICscceEnvcEFv
         0/36HZwCD0YlmxNXXE9D74tnPCddjHEP3yZZbafE2h09zsArs/Am/Tjmx9TJjCm0luRC
         HAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687095; x=1730291895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmNJ4njEEpOrmBT0rUaUQn7lrkfzlys5UMDexBH3nfs=;
        b=MukLvP3++V0i6q8w+qwNwpVJBjr50k8PUDdMGvWEhh2Ea2C/zCpuCfngzqvZlYj7JM
         0XUhTT12UjQstgciDpc9tTGxK2IPBG0QgvZFdrbXE7WYOegak98IwMnCe364F7vQofUz
         tCjLiJpgmp1MdwknFfBXH/bvnYBD/Q5Ryi+7s56uKA1b4/I3Q5Jos35Xl/OnydbzxifR
         fUuIeE2hWlSLdyzi/3fUdvmM3h6FGX7Vqaa07OlTG7dzdkgPXVa8iQT32+CWN+rwKGE6
         L+p5O1jE5sntnACOy+Eu6q0C2G6gWcRoFczaPZHXkWXU2U9JAb1hzeo58lbXGsFtNewL
         LAiA==
X-Forwarded-Encrypted: i=1; AJvYcCWrfAkSV/DDHqtlfjd8a1iTVIs5w7M/ZE8mfJemA8wQKPP8U27PcK4ggypdMlPBiX7FqELAsk2ClMlWNfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHChl1g7voKCt6+huQLPNut/mbjBmJ33BOfv0AcSo7O+lYA/yd
	T1ULpMwOt/CCEX8Qr99F12cEPGfHHuc0of9hdRGfaNd7Ahjh6KpxkMYRv5+MRTw=
X-Google-Smtp-Source: AGHT+IFEvaEt508ZqXpALfvO8BSsPc1mq8mVN8QU2yBaJIoYVt6b+a0GOubHuoCGMmfjx1dXbPfw2Q==
X-Received: by 2002:a05:600c:45cb:b0:431:44aa:ee2e with SMTP id 5b1f17b1804b1-4318413209emr18520915e9.4.1729687094847;
        Wed, 23 Oct 2024 05:38:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bdeb4asm15171225e9.15.2024.10.23.05.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:38:14 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:38:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: add test cases of stack_order
 sysfs interface
Message-ID: <ZxjuNBidriSwWw8L@pathway.suse.cz>
References: <20241011151151.67869-1-zhangwarden@gmail.com>
 <20241011151151.67869-2-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011151151.67869-2-zhangwarden@gmail.com>

On Fri 2024-10-11 23:11:51, Wardenjohn wrote:
> Add selftest test cases to sysfs attribute 'stack_order'.
> 
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>
> ---
>  .../testing/selftests/livepatch/test-sysfs.sh | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
> index 05a14f5a7bfb..71a2e95636b1 100755
> --- a/tools/testing/selftests/livepatch/test-sysfs.sh
> +++ b/tools/testing/selftests/livepatch/test-sysfs.sh
> @@ -5,6 +5,8 @@
>  . $(dirname $0)/functions.sh
>  
>  MOD_LIVEPATCH=test_klp_livepatch
> +MOD_LIVEPATCH2=test_klp_callbacks_demo
> +MOD_LIVEPATCH3=test_klp_syscall
>  
>  setup_config
>  
> @@ -131,4 +133,76 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching transition
>  livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH"
>  
> +start_test "sysfs test stack_order read"

s/read/value/

> +
> +load_lp $MOD_LIVEPATCH
> +
> +check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"

The access rights should be rather tested in the 1st test in
test-sysfs.sh. We do not need to check it repeatedly here.

> +check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
> +
> +load_lp $MOD_LIVEPATCH2
> +
> +check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"

Same here...

> +check_sysfs_value  "$MOD_LIVEPATCH2" "stack_order" "2"
> +
> +load_lp $MOD_LIVEPATCH3
> +
> +check_sysfs_rights "$MOD_LIVEPATCH3" "stack_order" "-r--r--r--"
> +check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "3"
> +
> +disable_lp $MOD_LIVEPATCH2
> +unload_lp $MOD_LIVEPATCH2
> +
> +check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
> +check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
> +check_sysfs_rights "$MOD_LIVEPATCH3" "stack_order" "-r--r--r--"
> +check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "2"
> +
> +disable_lp $MOD_LIVEPATCH3
> +unload_lp $MOD_LIVEPATCH3
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH

Otherwise, it looks good to me.

Just to make it clear, I suggest to do the following changes:

diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 71a2e95636b1..e44a051be307 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -21,6 +21,8 @@ check_sysfs_rights "$MOD_LIVEPATCH" "enabled" "-rw-r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "enabled" "1"
 check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
 check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
+check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
+check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
 check_sysfs_rights "$MOD_LIVEPATCH" "transition" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "transition" "0"
 check_sysfs_rights "$MOD_LIVEPATCH" "vmlinux/patched" "-r--r--r--"
@@ -133,29 +135,24 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
-start_test "sysfs test stack_order read"
+start_test "sysfs test stack_order value"
 
 load_lp $MOD_LIVEPATCH
 
-check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
 
 load_lp $MOD_LIVEPATCH2
 
-check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH2" "stack_order" "2"
 
 load_lp $MOD_LIVEPATCH3
 
-check_sysfs_rights "$MOD_LIVEPATCH3" "stack_order" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "3"
 
 disable_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH2
 
-check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
-check_sysfs_rights "$MOD_LIVEPATCH3" "stack_order" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "2"
 
 disable_lp $MOD_LIVEPATCH3


With the above changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Please, try to send the next version together with the patch adding
the "stack_order" attribute.

Best Regards,
Petr

