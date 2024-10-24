Return-Path: <linux-kernel+bounces-379470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E299ADF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F09A28A5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520AF1B3946;
	Thu, 24 Oct 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VAR3QYng"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0D1B0F16
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758060; cv=none; b=D2lXi8dSyeeXpezHd3zQcuTyShu6oK2tSdR4LcbLUKOfrxk84y90h1kpa00lg8dgChvyk0BZ6+puZkDWLXvN2da1GU945sgNC84LhwVYTDTmhw2iJ/fYVDMypMdVQs9NMZICU2HTHyscvyP16lAJeo883/cJjb14MtlDH+dGxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758060; c=relaxed/simple;
	bh=mKG+emQRV1DyZn74gYnOgMb9nlYigftCeEICRCOHpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCQfoDzcKthqN3587I6InWgmiyzHVkvtBejWC6cp9mC4q5JhBXxngEnY/EixZijRjfHJa6fkpq9wjLx2XkCIreKJvDea1JoOO11uT3kYmCPZ+k16KHYSBQNR2wouygtttrwWb/uXqrpQWdCHU13yUlI4B1kxTadut58HGFAHcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VAR3QYng; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315baec681so6438775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729758056; x=1730362856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8E/DqGz7VCwtU5gl7bt7J+sBxvJkxJvY71TRgOhyb8w=;
        b=VAR3QYngMWrcLGiF5n0Zb7bNSLXS0uc84RNDqRYFHULT5x4lMPhTnX3HZFljBccVxL
         U5Ziaqrs4UQ0XbBT9Ir8L0U8lb4Nc2ov4shFxhkgT3iUq1EGsSDvd5P40ufqEk+SHA80
         FxpCXn13FUxgfy8N3cZGPR3+eEgC+iy3BZ2dwsdS8i913U/0mkV3p4opF2AzEc4UGmjn
         7Bn4W/aylu2ZQT+omo9/CwjOc4XpTZY9CCVpKZ+3cveNLFbB3ASfCKsZ2neQxwBcDxSd
         +3u/b+xYzo++tFkoL9BhLp0vHLSxJYPAfg4G9qiJgK4JhlVsWz8ek6xCvxWxBol0aN3a
         b+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758056; x=1730362856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E/DqGz7VCwtU5gl7bt7J+sBxvJkxJvY71TRgOhyb8w=;
        b=lAnSHJX+AMwoYmkHf3VcfqB+O+P3ctAudhneMA8J+eP2WVXhd0IqkyXh3rxkYKHBkZ
         8Dnr4UZIxEvbfzBpwQHSrSRSLm1B3+iSma8+Kd/hjXH2xloTdsHmlgnIJYF9tyMQoWZp
         NFq3LCeKxC7lupC3sPY3e7GhbYR1OTly+FyDcjPXA4axZ7Mz7hxC+KzDGrWOwBJptTAJ
         5E6Pndab4hOpfell4IjAni105PRB1Xuz7KOKAsv6WBRcs1gsxiTMBsuiLurx4qW8YLDd
         cfQU25xWeQM7xTDdjr/O25QQTxkoiA4RkhsPq+xosziho+soXEFB0Lk9M1VxK5wRU45z
         DDzA==
X-Forwarded-Encrypted: i=1; AJvYcCVLvpBnSDbv246yOP1gbgs8y6/WUOrQQ+vPZ/Mf0i1Ax6wFQg1qInsyQTL8hJAjsoI9K92HAegwn82g36U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJuJN9+SL+yspS4KBCL9ZS2FCRieT9+T+nuJvJxs6DtcThIzf
	mUYIMRSaZHuLoZe0CJTsJmBzlcqLqwmzGgmBiOrZv+nm9FThGa9CkH7X44xMuyacP0KIdYiGCgL
	O
X-Google-Smtp-Source: AGHT+IFg9M2vjj4H31ptfBIKjKvfeR/9yhzgbdkHKDNE/24WihrjrX4qy6Mt6B2DPgOZYyMMZahB1w==
X-Received: by 2002:a05:600c:1386:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-4318c707399mr8683175e9.19.1729758056556;
        Thu, 24 Oct 2024 01:20:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bde204sm37989985e9.14.2024.10.24.01.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:20:56 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:20:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] selftests: livepatch: add test cases of stack_order
 sysfs interface
Message-ID: <ZxoDZhpEX_M-vuRP@pathway.suse.cz>
References: <20241024044317.46666-1-zhangwarden@gmail.com>
 <20241024044317.46666-2-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024044317.46666-2-zhangwarden@gmail.com>

On Thu 2024-10-24 12:43:17, Wardenjohn wrote:
> Add selftest test cases to sysfs attribute 'stack_order'.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>
> ---
>  .../testing/selftests/livepatch/test-sysfs.sh | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
> index 05a14f5a7bfb..718027cc3aba 100755
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
> @@ -21,6 +23,8 @@ check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
>  check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"

Sigh, you moved it from some reason. My proposed diff added
"stack_order" here between "replace" and "transition" to follow
the alphabetical order.

>  check_sysfs_rights "$MOD_LIVEPATCH" "transition" "-r--r--r--"
>  check_sysfs_value  "$MOD_LIVEPATCH" "transition" "0"
> +check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
> +check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
>  check_sysfs_rights "$MOD_LIVEPATCH" "vmlinux/patched" "-r--r--r--"
>  check_sysfs_value  "$MOD_LIVEPATCH" "vmlinux/patched" "1"

After fixing the alphabetical order:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I could fix the ordering when pushing the patch.

Best Regards,
Petr

