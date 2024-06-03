Return-Path: <linux-kernel+bounces-199763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA58FA588
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB21B1C239EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A113C912;
	Mon,  3 Jun 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oexfyiWu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FB522E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453791; cv=none; b=AAM6wU6yg2bqW10PoM3H4NreyVE/kJdRWRvC+OVU2Da+OsvPJaO2RgjtlrFZfz5UCcq3IFwEDEgxW82n8e+cV9pCvQwDuwSq5EOOt9SYT/qvltlQ/t3jIoW6BQaQhMXz3ziXuWl/qseiFrc6tjs2wAGf2Lf06mgfZiIEH+lxzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453791; c=relaxed/simple;
	bh=5f9a0R2mCrPvkK7KpP8RCriUj65yzs0VJ4Rq1HprCHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBVzfa/CrDHZpaEkUEKFs1TCZS+pvPYKFNtdPfEocgeE4LoOyrzNha/08ViFabUo7fI9P0Ib1zBXbrBXOyL6QvtRYaiWVGqxUvc/rkRNIyra6T9e95dAYRmJnLdKfaM29kJknjSBpFDSZzAxRkwzn/rI06n0U0Kr+1QGJDkmdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oexfyiWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A0C2BD10;
	Mon,  3 Jun 2024 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717453791;
	bh=5f9a0R2mCrPvkK7KpP8RCriUj65yzs0VJ4Rq1HprCHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oexfyiWuBGQ+/9Cg8ujHUG6B0riV65lkBjuEnePYZNcLjEyO+CI5qux2nR6ft7A5Q
	 SXf7EZOnCmdmXC6OjEb7gZS7uQ+V6jY5UaKKgliYT0zquOr7UHIOUAfjxMaWHrIU0D
	 ddvNEn0UfprFqMKm6zYhRg8gazeTZWCpa9E1YlbESM8vyNeF4TprsELiTfnjUr7fW2
	 dEzh1yaZAyklVjzntj8Vfsjm6z2crenrg34Y3ZRGYf0o++JdxPDI6hBMhzQBE4PmEU
	 FHwQEws761kLwQ0G/ujr8U9tDNbH7aONIevDfdpYQbqcEQbEe58WoX742hcdBkWV59
	 08DJQcL/ECTAg==
Date: Mon, 3 Jun 2024 15:29:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
	Qingqing.Zhuo@amd.com, hamza.mahfooz@amd.com, chenhuacai@kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Increase frame-larger-than warning limit
Message-ID: <20240603222948.GB1802995@thelio-3990X>
References: <20240530145741.7506-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530145741.7506-2-palmer@rivosinc.com>

Hi Palmer,

On Thu, May 30, 2024 at 07:57:42AM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I get a handful of build errors along the lines of
> 
>     linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: error: stack frame size (2352) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
>     static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
>                 ^
>     linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1724:6: error: stack frame size (2096) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>     void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>          ^

Judging from the message, this is clang/LLVM? What version? I assume
this showed up in 6.10-rc1 because of commit 77acc6b55ae4 ("riscv: add
support for kernel-mode FPU"), which allows this driver to be built for
RISC-V. Is this allmodconfig or some other configuration?

> as of 6.10-rc1.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index c4a5efd2dda5..b2bd72e63734 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -62,9 +62,9 @@ endif
>  
>  ifneq ($(CONFIG_FRAME_WARN),0)
>  ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> -frame_warn_flag := -Wframe-larger-than=3072
> +frame_warn_flag := -Wframe-larger-than=4096
>  else
> -frame_warn_flag := -Wframe-larger-than=2048
> +frame_warn_flag := -Wframe-larger-than=3072
>  endif
>  endif
>  
> -- 
> 2.45.1
> 

