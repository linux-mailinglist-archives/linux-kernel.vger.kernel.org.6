Return-Path: <linux-kernel+bounces-201033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F65B8FB865
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A3B286CB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94E148829;
	Tue,  4 Jun 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Y28Tz/MN"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5D13CFA3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517066; cv=none; b=iNIHszPyR68xN76oSoNNESPPmm5o77hy+clsbOLVdD2bNmdhVD32pbR+Ywrbc2iNbxYvO+PmadSWB8kFsHjkI7tuSVWMZ0zXMLsyg7pWVLcQvaVt9lBGZ1ee75eibe+Ia4y9F+dxcYYqYJdQoTVA5B96bViiBlHQOV2m1eeEKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517066; c=relaxed/simple;
	bh=ZTDPHfz+ZLKFkaS9Uj2wyZOe/rzR+Q30+9E9A39ICy0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=f46yX/cRmJytrb4opLwIXWdVLHwbX3DF9ERQaSYxo8eC/cPuDBRuYOtHh7vaYMBSF1pXRl7eVBDBcZnGZ/rKIleiirFTYgSVy+mt62HgaWQ7hwZtiLQzSGps6FnOwjS0DAKsFQW/YcWiRRPFN78MI6gsbfk4QehmFNEIlL/od1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Y28Tz/MN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f62fae8c1aso37458435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717517064; x=1718121864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2gKQIHSX9mPWT/OX1hOPZ0VNPVmzrzMvvwZ15iSblg=;
        b=Y28Tz/MNaYgL2mlPaKmzq2RVokZ2fK3yQ1vYjGxTBIeud4ovKENnVXorG0TqDxcSTT
         mfHKS5mY8SHRNrWKFWy8Z/q/qszcQXg6qSRt36Ns0ImhjlDzzc5UIrbLzWPJp9DIs5FE
         ureXeWor0CBlmIwH9eKASV+uuW4gIYXkYxl8K95lovZH+l2xxBk7Na1DtOVjSmbdlsag
         wvs9T4jj7kzcBXLu3GZ894ftQD8khMyWl+WO9uQOB/Wv1wk99Xhi8miXhaIYy5MlyesA
         0VjFeUe0fu75qZyR4NTMNXEY8HsOXxJxtRXkd5nMLPfWjmxz4l98PYw37cuiiJ9kgQUZ
         Aw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517064; x=1718121864;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2gKQIHSX9mPWT/OX1hOPZ0VNPVmzrzMvvwZ15iSblg=;
        b=eGCOU5Rz4Q64/FZx/PG4qAiZcWU4LgQrEv/Bj4QmcDclS0nHiyWLfZEjrRha+lDSzw
         Y/PB1wFVUfkMUGGudlbxJPeV2yQdMKxlw/C5HfaJYPr73F5fb/y9tqumf+uppsI67eRD
         +YDbcYsQL99D705CvA647Oal2AT7HRZgBPKamq9xBgM+/9xEvaHn9cblwc8Wi/CSqSH+
         atCtaucefoFxBV+6va/ZbPcC7KRXMUEWwEjHw5QuTp9L/XBP9amw56jSZzHSnPPyf45u
         4tvpftHdsGLs4Cj6HB8j97nbPKOkwZGJoqhqNp9tXjdFg7XXGo1anN6kv6AvBvptg0UH
         RpeA==
X-Forwarded-Encrypted: i=1; AJvYcCX8IAab65Ornv8giccKsn2G5d+Xw+APvZpibkpqzYnlxcckoixCnbMFZBlowK2X4B2tcBDf3ifoY68RVwmmapYS3V21KW1hD2ZGyG5x
X-Gm-Message-State: AOJu0YxnLu7lP+5RrDnbe0HZ79UW+0rUlbBJE74UxLkUMOiXO11oIC6H
	vErWSruyvHhUS7BHdhKaGpfjpzC/ACYHxO7INdLf5bxNa4/ANEGSnzDDLbxmau8=
X-Google-Smtp-Source: AGHT+IFk2/CHkCYOgoIKNRsQIUaLysshP8KYOXeegGgQt9s1XMcyvOM8xjJ+kaYxNqLDHalCVqGY9A==
X-Received: by 2002:a17:902:d507:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f6370a0cd6mr163627915ad.52.1717517063799;
        Tue, 04 Jun 2024 09:04:23 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dcc5sm85466225ad.26.2024.06.04.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:04:23 -0700 (PDT)
Date: Tue, 04 Jun 2024 09:04:23 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Jun 2024 09:04:21 PDT (-0700)
Subject:     Re: [PATCH] drm/amd/display: Increase frame-larger-than warning limit
In-Reply-To: <20240603222948.GB1802995@thelio-3990X>
CC: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
  Rodrigo.Siqueira@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
  daniel@ffwll.ch, Qingqing.Zhuo@amd.com, hamza.mahfooz@amd.com, chenhuacai@kernel.org,
  amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: nathan@kernel.org
Message-ID: <mhng-f1fc5ef0-9e72-4b12-9a28-145bbc8938d8@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 15:29:48 PDT (-0700), nathan@kernel.org wrote:
> Hi Palmer,
>
> On Thu, May 30, 2024 at 07:57:42AM -0700, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> I get a handful of build errors along the lines of
>>
>>     linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: error: stack frame size (2352) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
>>     static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
>>                 ^
>>     linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1724:6: error: stack frame size (2096) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>>     void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>>          ^
>
> Judging from the message, this is clang/LLVM? What version?

Yes, LLVM.  Looks like I'm on 16.0.6.  Probably time for an update, so 
I'll give it a shot.

> I assume
> this showed up in 6.10-rc1 because of commit 77acc6b55ae4 ("riscv: add
> support for kernel-mode FPU"), which allows this driver to be built for
> RISC-V.

Seems reasonable.  This didn't show up until post-merge, not 100% sure 
why.  I didn't really dig any farther.

> Is this allmodconfig or some other configuration?

IIRC both "allmodconfig" and "allyesconfig" show it, but I don't have a 
build tree sitting around to be 100% sure.

>> as of 6.10-rc1.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index c4a5efd2dda5..b2bd72e63734 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -62,9 +62,9 @@ endif
>>
>>  ifneq ($(CONFIG_FRAME_WARN),0)
>>  ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
>> -frame_warn_flag := -Wframe-larger-than=3072
>> +frame_warn_flag := -Wframe-larger-than=4096
>>  else
>> -frame_warn_flag := -Wframe-larger-than=2048
>> +frame_warn_flag := -Wframe-larger-than=3072
>>  endif
>>  endif
>>
>> --
>> 2.45.1
>>

