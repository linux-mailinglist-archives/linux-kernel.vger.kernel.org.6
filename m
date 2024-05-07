Return-Path: <linux-kernel+bounces-171582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B38BE5F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C722A282821
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA36BB2F;
	Tue,  7 May 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZzMMVH1n"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F775490F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092290; cv=none; b=d6v/LU3rDoZILBkUwtXUdU18NsANi5ZUCkUwce0t/b43yebi/AeQrhNIRFIZTpRTCn95iwDCc9Np3OPuDmEDyau7EmKtpxIgRAp+uWjvlhndZNZKJDnqZegAhNi5qKOpGLwKQx5WbORkUAkTvB5C1NPdr88d4/NcizUTrkZ7884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092290; c=relaxed/simple;
	bh=pXSdvU0OK8lYHajFVrns2qE/es0E1ZSyzQNWhrEYMKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f7qQo9wwRjlDqjLAmjpnZm//IhqauWOB30EXXk7YmiE+SYSQfXYUn+60xAdBCYfFTYxBP9FO0VDDEw6gdCnnErmt5p3ly2TSq0Lx3zjOg/6iT6tPaiy9Nat3rhfitcV+ldOJa7GpAxeJ/lkRs3p/wOmZkmRefutws8FM1dXhts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZzMMVH1n; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7dad81110cfso175968039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715092287; x=1715697087; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52KNTDLC+obpAk96hd5D+rzNIt3oW/ikIeIzud7iogo=;
        b=ZzMMVH1nqZfyHfadWKhzxJ2xnFw8YlaZgWrAY7Xar5xLRTZyHFv+jn8prwRUZwg7Zw
         jozMj1IwQew9pWyQI+gfhpvX1IqK2SJRoB21Ac0eyVbkDc2ieyohRNmO0xlUUZvyG/F2
         5Z/YSComXynbtlwufvynSwL/Kn2JeFpJzU0bJjfsb4Iugcp2oI/LkHPwrTbI4kHO3qeA
         8fJKRwrxfkyQUkUO0V6Z9/lQMqxqMJ5GaJWug7aHvTgal0UrP5Q19TFXOd502cztr56+
         MdNPzxlh788t2HU5Dkh8VfQtugJyndMka1uDvDA7NsHS7ILEBOc8uR1fFkEYHNZD1jgv
         JYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092287; x=1715697087;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52KNTDLC+obpAk96hd5D+rzNIt3oW/ikIeIzud7iogo=;
        b=nxfyG0Z4b18rHfUkpma5TFfEgbpCYLm3g3eo8NbDQH+fvy5nLxI8nJWVKUfnhOfshF
         f3qvPz6NsVfrsOHVhp3ZjDWzl61NV/XAGHtOVj6oDtQMDZVKZ6YJxn751ly+AABeKeuj
         dE7oCc5cBZR3muqLZrqX5vkaxBR7I1nV5c4EJqufxmY7J0aF823gWiKcGf1LBpO9BLDH
         pxoqv9fAokakUcAsRWiFqZtCDrbWLnzI2F6GNvU1WSzOGwFo9EGIXwSkM22xsE4apL91
         pfT9jLSckN5UpHZWj0EfNcYJG69tkQUonn+4PGgjvPUOT9i2Eho0F5XD9GYf/FXTqpxM
         jtGg==
X-Forwarded-Encrypted: i=1; AJvYcCWLBWMu/qXg33pNwv/jMO0J+KuXGixsQ1UdwqoZ2FUI1Gi//mmphlCgpQbQvi4PeC2hFtu1I3vVZyRCBWqLIDpGiHXpGAJLv/USh+2X
X-Gm-Message-State: AOJu0YxaEw5FUIyXs06l/ZIISeaT4Znfvi8AWUi+wwNwmkPN3+u/+nmL
	DuMVK1AKxePJSHWiPwZlKkI5OfGVGav1F4zsrPuo3OGrNe96E5IjUQNsPRiPcjh/XTQuM2BcR5u
	C47boNFb7iMH1b3wSI0jJ8tS3a6RfDb405nMECA==
X-Google-Smtp-Source: AGHT+IEU8/ZDsdl/a7pEUPUlhakyqhjOEDxLMywsFoH1yLJG3Zk35gTxil1EaJWuOYewmxGhIrFPsYoBYaM/+RK6ekE=
X-Received: by 2002:a6b:ea02:0:b0:7e1:7d63:887 with SMTP id
 m2-20020a6bea02000000b007e17d630887mr3645808ioc.18.1715092287669; Tue, 07 May
 2024 07:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715072254.git.zong.li@sifive.com>
In-Reply-To: <cover.1715072254.git.zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 22:31:16 +0800
Message-ID: <CANXhq0rmSpDrZji7de7iz4TSJ-6Fp6_e1ZagsGYRcHAo6n9THg@mail.gmail.com>
Subject: Re: [RFC 0/6] RISC-V IOMMU HPM and nested IOMMU support
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:07=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> This series includes RISC-V IOMMU hardware performance monitor and
> nested IOMMU support. It also introduces operations for the g-stage
> table, which are required for nested IOMMU.
>
> This patch set is implemented on top of the RISC-V IOMMU v4 series [1],
> and it will be submitted as an RFC until the RISC-V IOMMU has been
> merged. Additionally, it will be updated as needed when a new version
> of the RISC-V IOMMU series is posted.
>
> [1] link: https://lists.infradead.org/pipermail/linux-riscv/2024-May/0537=
08.html
>
> Zong Li (6):
>   iommu/riscv: Add RISC-V IOMMU PMU support
>   iommu/riscv: Support HPM and interrupt handling
>   iommu/riscv: support GSCID
>   iommu/riscv: support nested iommu for getting iommu hardware
>     information
>   iommu/riscv: support nested iommu for creating domains owned by
>     userspace
>   iommu/riscv: support nested iommu for flushing cache
>
>  drivers/iommu/riscv/Makefile     |   4 +-
>  drivers/iommu/riscv/iommu-bits.h |  22 ++
>  drivers/iommu/riscv/iommu-pmu.c  | 477 ++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.c      | 481 +++++++++++++++++++++++++++++--
>  drivers/iommu/riscv/iommu.h      |   8 +
>  include/uapi/linux/iommufd.h     |  39 +++
>  6 files changed, 1002 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/iommu/riscv/iommu-pmu.c
>
> --
> 2.17.1
>

Please drop this one, I have resent this series by removing the
'--thread=3Dshadow' option from format-patch, as it causes RFC 5322
compliance issues, and also correct the subject of the series.
Thanks.

