Return-Path: <linux-kernel+bounces-531453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD20A440A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E145219C1655
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240826980F;
	Tue, 25 Feb 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XYb+W9mW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DD269830
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489692; cv=none; b=dz0E13UghLdB9i1VbUN1sNUIxfWJzEqhrWeCdD5LweWhF5iHnS4uPvstGuoalVmZnqPn/EJiiL6lvRMQchJnbUwvB6N9QTKTv6b8M49VoldPB9AKIpuqOLT+DYyOoqFWlBpqfAkHwpxKgdp62hivBvrteHpQemLClgfmmPyUA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489692; c=relaxed/simple;
	bh=EKfvaWu2ka37WW8F0h2KYY49IMP3AggspE68tEh5NyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeCNlby0kbX49T4kSRw0w0oUPQiysUiL29micxwEc0SQPz5z9/E9Vzs6sd+07L6ZkZXW8AV3Ifi+CdgIUfqr/wEhMNh8eRmK3qOj2E/07YT6R8sq3CvVChvS3WIxRTqPws1zKRhdKSmWexKI0HHlifYs3/SBPa4iiDzO87MCwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XYb+W9mW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so10493669a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740489689; x=1741094489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQVKtrjGZwLtff10MUIe65eAbx+c/HuPXdtieDwyBWE=;
        b=XYb+W9mW5/XiFovow1zsn3pgOqbgVxXlDt1R4P9Jc45eCzJTmY3MDIAUnvW5SBJh2I
         dI/ctEYQBXycve0KTRIieD6oCB31Ws5J1bOHAzAN7hfZ4rQOMIoLjjSVsGDfN9IxWbfx
         ow1rZqg1mxMUc+NZEjLZzdO3YL5mGd6/ruRMlZQpcXZXJ020TsO6hTsXAk6upWPe0mvl
         coP97WPldBizCEbq2IhTthtzh0F5bhHfP7BhK67TFPM/57EyX7wYHsgym0+9xnxqCq3w
         YnP3z9125KELvzFNGMNo+wvkfaBhUqArJNmsrPrzsTY4lyJhmvhG+uSAoyRryulCgjyS
         dAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489689; x=1741094489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQVKtrjGZwLtff10MUIe65eAbx+c/HuPXdtieDwyBWE=;
        b=P5gA2HCmhNu1C5r0acHegK+Y3rc72xfbthiSn4VLjAYQsWBipTHGBSP+q0uc03CA32
         8x2uK9BhUH8X4dfDdx4fZXXVCRSwACbSHi4quIWGtNJpwSKSR+44FWtEMLWEm1I5f4Bh
         s7/xqysPKURgiKAGLNgx4Gtx6TU18Lxtw9cf5KLhjx62Wm0xHvEdniEV1hTl7udWikG3
         LKllA4OHNpcOmJYx5LepneksYgWLHkK0rsMSLW155pRo4vQZIjiUGNdwP9ZPzs5NEh2G
         ZN6xhtdPbQd4y61Pt0zGzxjVcaURfPZ6OyS+1RI0l5yknkfC/RdIDDJzVnG/Pv/wdw3q
         ltIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXNTCnsokN0aXaj+ihzUzHcVY3PTWhBwZY8jiqZdhebTbMQ/a/VGFk89cA8WsGce2iugMg4J4BKFy/7D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrh1Zkt/k0GFIwYxynbv7c1rxxLW5kRgzqfy5hohr/JcgmmMtJ
	ij0u6UORP7Xg7efoVhHOjH19dfk4bk57hbSklH4jzvlwKd7NnvTd/kktTnpYYsiDwweSN6xPgVO
	eFNv2iT9zGKX4CRtU6fEaeEQK+xDCGZyLmfmGZw==
X-Gm-Gg: ASbGncsKbvN7gHZdo8/QmxmpNY22jkX9pAyZgFJfQa7i2Lrjt4pefT4lp7FmNP/sq8+
	FCBlJ3SFw7KAM9VMgv++1Bk15nJaDd+QFA6WXOAsfZyKI9frQQziwik1e1UYvzHFOedfr0RYx5P
	qKEpKjlRw=
X-Google-Smtp-Source: AGHT+IHJkGd46dH3GhCaZutb0iaa6Lqsb3O4IVtqX+tibBa3OYAt9wbckem9uhCu/SR6U7PagHj5+YL5qKc1+qd4mo0=
X-Received: by 2002:a05:6402:520d:b0:5dc:7fbe:7310 with SMTP id
 4fb4d7f45d1cf-5e44448119amr3305792a12.6.1740489688864; Tue, 25 Feb 2025
 05:21:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250115024024.84365-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 25 Feb 2025 14:21:17 +0100
X-Gm-Features: AQ5f1JrDelDcQ-WOsXduy79VlvN3oYPWPp4dCnEMKBs6m15M4RAQ60--X73WfXY
Message-ID: <CAHVXubhapunBD_+cZ=WeEp9GPJec795xOWSnMKmh_iSH09r2Yw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Enable Zicbom in usermode
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: ajones@ventanamicro.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

On Wed, Jan 15, 2025 at 3:40=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> v1/v2:
> There is only the first patch: RISC-V: Enable cbo.clean/flush in usermode=
,
> which mainly removes the enabling of cbo.inval in user mode.
>
> v3:
> Add the functionality of Expose Zicbom and selftests for Zicbom.
>
> v4:
> Modify the order of macros, The test_no_cbo_inval function is added
> separately.
>
> v5:
> 1. Modify the order of RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE in hwprobe.rst
> 2. "TEST_NO_ZICBOINVAL" -> "TEST_NO_CBO_INVAL"
>
> Yunhui Cui (3):
>   RISC-V: Enable cbo.clean/flush in usermode
>   RISC-V: hwprobe: Expose Zicbom extension and its block size
>   RISC-V: selftests: Add TEST_ZICBOM into CBO tests
>
>  Documentation/arch/riscv/hwprobe.rst        |  6 ++
>  arch/riscv/include/asm/hwprobe.h            |  2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
>  arch/riscv/kernel/cpufeature.c              |  8 +++
>  arch/riscv/kernel/sys_hwprobe.c             |  6 ++
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
>  6 files changed, 78 insertions(+), 12 deletions(-)
>
> --
> 2.39.2
>

So a v6 needs to be sent with:

- the fix for hwprobe_ext0_has() reported by kernel test robot
- a rebase on top of 6.14 since patch 2 will conflict with
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0

Do you think you can do that soon so that it gets merged in 6.15? The
patchset received a lot of RB so it would be too bad to miss this
release.

Thanks,

Alex

