Return-Path: <linux-kernel+bounces-537377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398EA48B15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4581B16C94F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA7027128E;
	Thu, 27 Feb 2025 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVL2s01x"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD287225775
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693993; cv=none; b=XkeKSnmhZdsQ27rlF6ubsvqQjmLb6owjpvHa+9kfgxf5mWjDTK5vuEc+Fy975rPUfINrSKrza3CgQAwVaslFNoaNZh6T5HTS/KY79MUfKoyEHTflyN9kYUlCojAS7wWXZlcQhUATcTGl+n5aLWvkRBUzec9cpQS+mIBTfUDtPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693993; c=relaxed/simple;
	bh=5Q9dXnV2OU7GlUBrJYgNHKi5rIDnxJLNS92uttMHlkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3P40mZ4ZW/xg+xKJcLLCH+bmUlC4sJ4nxpfLS3ucCgVMR0VUrJyYrA2Jx/qSUyHAxsmlIS/6zKpbFjfV+F9KzPY2bXxEGEX/HiyAPKy6GTLGacraJrhCl/sZuNQZXI81WqM9YpQza0ujd0ILm6t3rfqTkkPeUJFNj2lwgVkTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVL2s01x; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f1dd5b80so20361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740693990; x=1741298790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exaIoQIbo874p+9B0DlQldEF7QdZ2qt5VRBLmXNOHJ4=;
        b=XVL2s01x8m09zH2U38ooIbtExojRJ5d9NSDwdDrkIURaoV8cV9aU0e6lcuLbHfpz0B
         Rh0Mg7tG7Yssl7zVPjAKbsDnk/kGptD0ry2U0Z7mRzsgDaPcDVrX68wq5Ez6uuaxST+E
         xvRSQ+lFz+Dzyg/cKmNNnuCwIhxFWyO5bBEoIy2urkto5DV3Des/0c6+UO3rxa259TL9
         /0AGsQ/16zVydm0hrmjiUotmQ2QCXHgzEtRzSiKyiTPh+kY1BXwE96tR7sbsm4pq6KnK
         zOwihvK7wyE1HftoHnNHxezHDjLzo866BhaoATjy5G4+PDnOjcbm+OC5DmE3MtlLkSQZ
         HSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693990; x=1741298790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exaIoQIbo874p+9B0DlQldEF7QdZ2qt5VRBLmXNOHJ4=;
        b=V/lmaplGwmDoFhzVeeVamJ7oXKdk0CwU42lCGqHcE5Au49rOg7Px9eOelflWQ6t92U
         GpkUt91wFuVuqJJBFRsYqsHIKtqu9WGa1e54vVyeAh0eLpgGu8c2PBcn2mdRHuBhfFqO
         aMj1Vhrrfpt8gOBNyNZdHdiLJsmSLbjQQ1ke2D28WybQaH330nBG9zn98vVHhhquAkhg
         0+fDOnLJdkOUOO8jqhnMCIhOdVwCMOdOBblr4NUk2ujPTlrgGn4GrVmGWy2+CcBh3RXL
         kdE82fjedJVfEsu4oDZIiA4OmtViHUMc/v+udXfn0jk3yeqikOMtC0I3f1Toj5BpnpYK
         kEig==
X-Forwarded-Encrypted: i=1; AJvYcCXkGYeJeZT71cGrgEB3dLVgeobWSv4lzql8N5B8DBJU6zxMcQ7XaXxFCDjq/sFY0Q8x1lR+mvDGMtTvDHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOcdcJkqpClw+kZCaV5CSmQhK12vsgGJwBZMwkIJNiv4vGgIu
	NceBYKUgUWd+DoV0QfTxp+NIAyS1WIqWlBVyaHINm7F9wSVVS2uIaGgphov7oES1fucf4LYlFW1
	Uo6H1Ryx/m/O9VsiNfafgsRMxrG4T6yWVd/ei
X-Gm-Gg: ASbGncvZiMiMdWVzHLp6XFFOVa3kK56bmww36BIPfJYsP63zg8SFcXy1hmerhUx38h8
	6YIJvSCumBUxatUDRqffNRr1F/rbPmilMLoXaWjjR+5S2uOjarcq6Cjxh+97pRQZFnmnei31LHO
	kC2X5xWviWdGGkk7hThNe8PYGE+Bu2fEYgBiRKOg==
X-Google-Smtp-Source: AGHT+IFpvl7aZXExG5hgmgTkv/JU8rJKQ04ySfj4maggC5ukM4GdGwcgmDYXokKyoHEJUAkBvZC3g4Y6GTYUgYzvl0w=
X-Received: by 2002:a05:622a:1a8a:b0:471:eab0:ef21 with SMTP id
 d75a77b69052e-474bd0d397dmr161991cf.13.1740693990253; Thu, 27 Feb 2025
 14:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
In-Reply-To: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Thu, 27 Feb 2025 14:06:18 -0800
X-Gm-Features: AQ5f1JrgX1HCGO9jxqsT5pan3n3q7ChIHAUS1azxaXTIyAjrLA-6lzFR0u6BIGk
Message-ID: <CAMGD6P2ewVZyZU26QRbhjn1ZEMHGnFhgCHq9dZyWw91R9jixnw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Cedric Xing <cedric.xing@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Dan Middleton <dan.middleton@linux.intel.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 7:23=E2=80=AFPM Cedric Xing <cedric.xing@intel.com>=
 wrote:
>
> NOTE: This patch series introduces the Measurement Register (MR) ABI, and
> is a continuation of the RFC series on the same topic [1].
>
> This patch series adds a unified interface to the TSM core, allowing TVM
> (TEE VM) guest drivers to expose measurement registers (MRs) as attribute=
s
> (files) in sysfs. With this interface, applications can read and write
> (extend) MRs like regular files, enabling usages like configuration
> verification (e.g., verifying a TVM's configuration against digests store=
d
> in static/immutable MRs like MRCONFIGID on TDX or HOSTDATA on SEV) and
> runtime measurements (e.g., extending the measurement of a container imag=
e
> to an RTMR before running it).
>
> Patches included in this series:
>
> - Patch 1 adds TSM APIs for TVM guest drivers to register/expose MRs
>   through sysfs.
> - Patch 2 provides a sample module demonstrating the usage of the new TSM
>   APIs.
> - The remaining patches update the TDX guest driver to expose TDX MRs
>   through the new TSM APIs.
>
> [1]: https://lore.kernel.org/linux-coco/20241210-tsm-rtmr-v3-0-5997d4dbda=
73@intel.com/
>
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> ---
> Changes in v2:
> - Added TSM_MR_MAXBANKS Kconfig option
> - Updated Kconfig dependency for TSM_REPORTS
> - Updated comments in include/linux/tsm.h
> - Updated drivers/virt/coco/tsm-mr.c to use `IS_BUILTIN()` for determinin=
g
>   if static buffer addresses can be converted to GPAs by `virt_to_phys()`
> - Renamed function `tdx_mcall_rtmr_extend()` -> `tdx_mcall_extend_rtmr()`
> - Link to v1: https://lore.kernel.org/r/20250212-tdx-rtmr-v1-0-9795dc49e1=
32@intel.com
>
> ---
> Cedric Xing (4):
>       tsm: Add TVM Measurement Register support
>       tsm: Add TSM measurement sample code
>       x86/tdx: Add tdx_mcall_extend_rtmr() interface
>       x86/tdx: Expose TDX MRs through TSM sysfs interface
>
>  Documentation/ABI/testing/sysfs-kernel-tsm |  20 ++
>  MAINTAINERS                                |   3 +-
>  arch/x86/coco/tdx/tdx.c                    |  36 +++
>  arch/x86/include/asm/shared/tdx.h          |   1 +
>  arch/x86/include/asm/tdx.h                 |   2 +
>  drivers/virt/coco/Kconfig                  |  17 +-
>  drivers/virt/coco/Makefile                 |   2 +
>  drivers/virt/coco/tdx-guest/Kconfig        |  24 +-
>  drivers/virt/coco/tdx-guest/tdx-guest.c    | 115 +++++++++
>  drivers/virt/coco/{tsm.c =3D> tsm-core.c}    |   6 +-
>  drivers/virt/coco/tsm-mr.c                 | 383 +++++++++++++++++++++++=
++++++
>  include/linux/tsm.h                        |  65 +++++
>  samples/Kconfig                            |  13 +
>  samples/Makefile                           |   1 +
>  samples/tsm/Makefile                       |   2 +
>  samples/tsm/tsm_mr_sample.c                | 107 ++++++++
>  16 files changed, 789 insertions(+), 8 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250209-tdx-rtmr-255479667146
>
> Best regards,
> --
> Cedric Xing <cedric.xing@intel.com>
>
>
Tested-by: Jianxiong Gao <jxgao@google.com>
I have verified that the patchset works on Google Cloud.

--=20
Jianxiong Gao

