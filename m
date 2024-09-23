Return-Path: <linux-kernel+bounces-331743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606D97B0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2531F2276A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A0156883;
	Tue, 17 Sep 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="tInRlTsU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE14C66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579716; cv=none; b=KzbG3Ha4F6vhXMhZXDkM0waXweGSjXlgwiQP8dN1mndhG755PsxEOr06SszfGe3krRMYZenjHzvWUMLk7Fp1ue9Szxtv5k50HIgideN++JzZ9tYR4nvGgkGrvp2DoacxeoLSY+qR2kf/JTmbxVdnAx4ZaQO7IpsK9wdTvg1zs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579716; c=relaxed/simple;
	bh=z/QlTYHj16cG15b0556RWiV9m/fJsfLUu7T9utUH3Mo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ALz0LpdZ0kW7jYBAa57SPUy59dfPDRe6PPhlE8lXMa8uRZNhzIEsfTtIQ4bMPX6s/VpVPZJIKCRyoHwfTXxfLfUyZQXhjDshzd3FdpteatJ8DEr5z9Q7LHfvM73FRbCoQs9jzX7C/41eLE3rHJsAoeNCmHXbD09LSI+v4IWpmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=tInRlTsU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71971d20ad9so762175b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726579714; x=1727184514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSjVIhSmfJ0CyaIM/a3SSB+ZCJQA5N7E16cyTDPSeoc=;
        b=tInRlTsUc8zkkekyHrwxTnE66V0D1bKJc0KcnjOolKj43ibAPgFxJSg2k8OgXEh4pi
         HK02RvUQyw4w18kJ0/qoA8IjXslivxW3tmYZqOTSslxPPCfKRwnnMNtpuSFJZ9Ag7ar2
         59VFe2RIGv034jUXS1GBsvLs/bZ1pKQ6fOfjPQEa9odwAhSe55DpVq+d2db7gD0hs7Ps
         hq85D7Vnx5WAPUxdR9pP/S4XRJ6R4ltZBfoX2M5b43/kdkEojCuBIMIa8lmK1b3acg3P
         X5gR1n5PEQGj42RqJ0/skCgNKqGTCweYdSJwI56NOsCd9UUsOtZJV4DC4aqj2MN6qvux
         Mbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579714; x=1727184514;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSjVIhSmfJ0CyaIM/a3SSB+ZCJQA5N7E16cyTDPSeoc=;
        b=JYcbR0S/2WY4lgv+U9hdaz683f8xKT7i8z5kh77GN21iMKr5W4kJu25+cWFJFFF6yn
         XNHCpEzs1ElYyy6gO/fhigHy9M8+0zOyas0xLVRNE7pnwGHA2gTCP5ra9/d6iD7H8NDJ
         B1TpUYHH5cgawZthSXLhdUYQ0tjB6k7Wm2PKDc+SKs0Dq1XhSN0w8DwL4QuAgkHW+n2n
         a4fRYQjzDFWQGMuyPXUiIj/sHYwRf86NyEzP82VKiK3AaukfGO0E8hfupMp8+wwG9Ry6
         cEMZJ1NK/AsQ2xDhpKd+7y9M2TQa88DGwgkzPa3InZAFXQ78Z8ud6jEsqUBmRVEEm8/L
         tbRg==
X-Forwarded-Encrypted: i=1; AJvYcCV8jsVY+LRqLNkF2Pk5YagCoAM48DlNyyFdGr+c5eIGWdSo1k52tZbqCKipzgTGWloCzZ/adZtYIMZZ4rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYckbmc4MtLixCan79BmwsXKt7+l5Xn0X4r/n+e+qMnXCW7ivT
	YDivXua49S5TsYuLx6JaEkNENHrENMwOLB1SjWTh+KkJ5HhCsDy2gIsbk2jIGzg=
X-Google-Smtp-Source: AGHT+IEDqJbKpA6LAn7lxbzNxohHyNQyKe4VpZi839U/YbK8TEHIC3wtGjjJt3DVKNnGqc0aqDaaDA==
X-Received: by 2002:a05:6a00:854:b0:718:d94b:4b with SMTP id d2e1a72fcca58-71936a2f634mr25905784b3a.6.1726579713896;
        Tue, 17 Sep 2024 06:28:33 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9809esm5146960b3a.39.2024.09.17.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:28:33 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:28:33 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 06:28:26 PDT (-0700)
Subject:     Re: [PATCH v2 5/7] RISC-V: configs: enable I2C_DESIGNWARE_CORE with I2C_DESIGNWARE_PLATFORM
In-Reply-To: <20240903142506.3444628-6-heikki.krogerus@linux.intel.com>
CC: andi.shyti@kernel.org, jarkko.nikula@linux.intel.com,
  andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org,
  linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: heikki.krogerus@linux.intel.com
Message-ID: <mhng-c9a63485-1f83-48c6-8840-accd5f97d237@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 03 Sep 2024 07:25:04 PDT (-0700), heikki.krogerus@linux.intel.com wrote:
> The dependency handling of the Synopsys DesignWare I2C
> adapter drivers is going to be changed so that the glue
> drivers for the PCI and platform buses depend on
> I2C_DESIGNWARE_CORE.
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/riscv/configs/defconfig                   | 1 +
>  arch/riscv/configs/nommu_k210_defconfig        | 1 +
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 0d678325444f..a644a798f602 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -157,6 +157,7 @@ CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_HW_RANDOM_JH7110=m
>  CONFIG_I2C=y
>  CONFIG_I2C_CHARDEV=m
> +CONFIG_I2C_DESIGNWARE_CORE=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_I2C_MV64XXX=m
>  CONFIG_I2C_RIIC=y
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index af9601da4643..87ff5a1233af 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -58,6 +58,7 @@ CONFIG_I2C=y
>  # CONFIG_I2C_COMPAT is not set
>  CONFIG_I2C_CHARDEV=y
>  # CONFIG_I2C_HELPER_AUTO is not set
> +CONFIG_I2C_DESIGNWARE_CORE=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_SPI=y
>  # CONFIG_SPI_MEM is not set
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index dd460c649152..95cbd574f291 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -50,6 +50,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_I2C=y
>  CONFIG_I2C_CHARDEV=y
>  # CONFIG_I2C_HELPER_AUTO is not set
> +CONFIG_I2C_DESIGNWARE_CORE=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_SPI=y
>  # CONFIG_SPI_MEM is not set

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

(based on the rest of the thread I'm assuming you're taking these all 
together, which seems saner to me)

