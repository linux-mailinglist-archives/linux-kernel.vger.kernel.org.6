Return-Path: <linux-kernel+bounces-534960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31118A46D47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CA93B0412
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12E2222C6;
	Wed, 26 Feb 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ln525usp"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E442755F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604744; cv=none; b=JNe0rCuZkTiO54rV/xXIRxeNtZsmC1BHOe1k+gJAYOmUfVy9olKfXF9CGddb1vEMVXtZaWDvY6k6mnQSVmiBRourHMoQWcM1NUZ3zuv2BvleZZ/4islk33+ze1GfTy+uFAC3IdJ9YAWycZIM7vbVkr8GlQhVkDLXu7aSc2vcAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604744; c=relaxed/simple;
	bh=ETF+TZfWOwr2E7TzI3GDXoo/fBu+FHHrLxMs/U5ICQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+BShk18DeNvW08/wv6Ddwne8wFqN8YjuPQei7Y7PHgC74qYe6BdOTSNcCy9aUamRv6ll0g87wFT/6zIMVA+B9lTb8VxP9koUes/CnvKHcTj+8Wxg7NYeH5rSVD+dGZs9UUxssy45+9cssvZuBjQOlnoyrNSsOs9Zkvb4RBrxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ln525usp; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855a1f50a66so5694239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740604741; x=1741209541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZbQT0VE61svKMbdd+Gr8k060Ven1mqK+4ryvXWXDro=;
        b=Ln525usp7KoTN7H4sfOBBkw1W60iqc4eiCeP8pWnL6eXL9Bc5Ou9ZsXIVcclrTk21p
         5e+rnENKoXnGBzzvKkDd1PqlZq3m1nzs6EGPgNJo//fcDb8BE8BwYqqyg0eNzeB0i7wg
         N3G1vO5GqsdIjUZ3AIX8KrQXG0Jp8sW2a3jxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604741; x=1741209541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZbQT0VE61svKMbdd+Gr8k060Ven1mqK+4ryvXWXDro=;
        b=HRYXSHFs71KPvE6vsu7+Rv1vLAZUelLCuRcpCRnbbrEQE9I43+uIji1QMllbA9Yt4L
         YSsYcq1Sf6Ux99S40p0kgcvl8eNVtaV8DJgpC8iV3jzfJvke4lybUH5yjNGJ83wiZvre
         /K0rtYWXpU2HPu0963riZZHF4xmQ5J3HPo2OPXtgtzZPsr12TUlwNeYBSveB58D+BjhJ
         CsVLk7w2z28hm/hYe4/uvlkuakrFlUFr7mSSM5/+10Wnv19xSw0WmoB5vcl8XF4RD11p
         rk8rhFYeQ6nNNplVigQUZYUiSw3x4U3gbOuBWK13L/qjP6IQW6jS02mSh4cWLlQCBz2u
         F6fg==
X-Forwarded-Encrypted: i=1; AJvYcCX06N+9cfwDTcFz2VZe8X+XxnMlj0gvm9lOinJYzUN2wwJU0FbhLV5Otq1yY5qHuiL3TY+xZi6oq668+2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVF5MOYxurWc7zDSKZDo4xeaIskPIC6h931RWB467mWnGhfiGA
	GjHDo1lQ4PvMhhgtozpJ+pX7TbIw2819aT8UrEhjrt6pHMtuT4EN6Iyg7ltslBE=
X-Gm-Gg: ASbGnctc5nc2GoWnYMMzoF/6QUfLdLzcjCypQcV6ZRUixseGf9nx9VsNqNDW3XS9YU9
	/wQfgk1PuYBjqTfXY5lnK+BnLAse5VCReEy4vInQUU46fWrXm/m8Rfdn8GMqUPRqYWPgI6QhvEn
	E6so0bX0kbi4Y7YtZtUN9GfaNfpD8xdH2FuqJ3Kij1sasSpgnrz35RppOHmIdTWDIyNnyHdcwJ3
	S8BiDlXNwnuY6n7JOFE/p2sVr1a25PyccGvBo0pXqACDgvoAsE2VEHr9iEKPS1hFcCpytLEP6h0
	9VdrSuy6/0pHfLvQRwVD0N4nOO10SPupeAgb
X-Google-Smtp-Source: AGHT+IHg/BsbrgiJltrFchrlWBr0v+eZMH3MictkWOtFDu7d/SE6nIbG1gWpAIgUIS6K/fYcfLTKKQ==
X-Received: by 2002:a05:6602:13d4:b0:855:9c88:7894 with SMTP id ca18e2360f4ac-857c18025c7mr464165939f.11.1740604740789;
        Wed, 26 Feb 2025 13:19:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c550a7sm33193173.48.2025.02.26.13.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:19:00 -0800 (PST)
Message-ID: <51fc3603-bad8-4ff7-9e72-88858812e3cc@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] selftests: vDSO: parse_vdso: Make compatible
 with nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/25 04:44, Thomas Weißschuh wrote:
> For testing the functionality of the vDSO, it is necessary to build
> userspace programs for multiple different architectures.
> It is additional work to acquire matching userspace cross-compilers with
> full C libraries and then building root images out of those.
> The kernel tree already contains nolibc, a small, header-only C library.
> By using it, it is possible to build userspace programs without any
> additional dependencies.
> For example the kernel.org crosstools or multi-target clang can be used
> to build test programs for a multitude of architectures.
> While nolibc is very limited, it is enough for many selftests.
> With some minor adjustments it is possible to make parse_vdso.c
> compatible with nolibc.
> As an example, vdso_standalone_test_x86 is now built from the same C
> code as the regular vdso_test_gettimeofday, while still being completely
> standalone.
> Also drop the dependency of parse_vdso.c on the elf.h header from libc and only
> use the one from the kernel's UAPI.
> 
> While this series is useful on its own now, it will also integrate with the
> kunit UAPI framework currently under development:
> https://lore.kernel.org/lkml/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de/
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Provide a limits.h header in nolibc
> - Pick up Reviewed-by tags from Kees
> - Link to v1: https://lore.kernel.org/r/20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de
> 
> ---
> Thomas Weißschuh (16):
>        MAINTAINERS: Add vDSO selftests
>        elf, uapi: Add definition for STN_UNDEF
>        elf, uapi: Add definition for DT_GNU_HASH
>        elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK
>        elf, uapi: Add type ElfXX_Versym
>        elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
>        tools/include: Add uapi/linux/elf.h
>        selftests: Add headers target
>        tools/nolibc: add limits.h shim header
>        selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_ehdr
>        selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
>        selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers
>        selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX
>        selftests: vDSO: vdso_test_gettimeofday: Clean up includes
>        selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc
>        selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc
> 
>   MAINTAINERS                                        |   1 +
>   include/uapi/linux/elf.h                           |  38 ++
>   tools/include/nolibc/Makefile                      |   1 +
>   tools/include/nolibc/limits.h                      |   7 +
>   tools/include/uapi/linux/elf.h                     | 524 +++++++++++++++++++++
>   tools/testing/selftests/lib.mk                     |   5 +-
>   tools/testing/selftests/vDSO/Makefile              |  11 +-
>   tools/testing/selftests/vDSO/parse_vdso.c          |  19 +-
>   tools/testing/selftests/vDSO/parse_vdso.h          |   1 -
>   .../selftests/vDSO/vdso_standalone_test_x86.c      | 143 +-----
>   .../selftests/vDSO/vdso_test_gettimeofday.c        |   4 +-
>   11 files changed, 590 insertions(+), 164 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20241017-parse_vdso-nolibc-e069baa7ff48
> 
> Best regards,

Here is my Ack for this series to go through vDSO or x86 tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

