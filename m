Return-Path: <linux-kernel+bounces-203117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBD58FD6AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6180C1C251EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B701527BF;
	Wed,  5 Jun 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wbHxux/A"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CCFBFD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616527; cv=none; b=F477LYRqQ+2zGkd53hZREXCJG+/QkNqtPqOxfAXZanRTrb6xBklaRHClSxFzjUH8WgGLOnRs29wQjyARzz7A9vEvYyr+eiwYBmKzlNNCuj6x1RwGj8eJDqTil5nIitmEPowzrEEQFhuf1yO8LiH2yOWyhRv7JSDItzqkOKSZ+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616527; c=relaxed/simple;
	bh=BkLjiawwOQEAVWftagmoBVsL5Q/uu5hCoju8LwKBppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qw6BfD8SZLF3OwqUdgZ2c8KYafwNAKVRTHg458C4ovWm8b0gMFVZfR8TieSyYKiIbMLgkW/dg/3A1l/0Xu8zKhYgDCSalulwJ8Mm+y7D8h5HeO3Jxv7Ftl+ap87O2oS2scS5dPfxf5NKdRwXwEcm36eYIsWM3hltdmetICK4QTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wbHxux/A; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c1a5913777so164944a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717616525; x=1718221325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Iqln3pU608Iw9vzO5mExR0F6HHdjBJu68DaW17wMtg=;
        b=wbHxux/A2Fo1mxdnGotFBzhtQVF0ahw58e5TyXIrFmtmdsuRD46ZPr6PU6iWvru6Et
         Z8kRCPzMnt9HfjoZR1a83mlACEEqdZ5dpHmJPUcKC2+wJe061+sVrioBItQ59uRdfw18
         bGC/UaDlc5JlMN7IbgkK1f41FJMuA+S7jmekPLSrmELvinD4khMsTqkQe7a6TOaSflq7
         9nhfxJojNQXOVzw7sFKKN0AQ+GbUw93b8xrHazJydFjbYexlpGbmDiMtm1+74NfBMXUW
         14i9OL46kuZ0sGH9n3Wqb9s39fNUjDpGWdc4fI2ps/dHIY98vCjLaIPnC76OFvTQEZ4p
         82Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616525; x=1718221325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Iqln3pU608Iw9vzO5mExR0F6HHdjBJu68DaW17wMtg=;
        b=O0Z95xOOKo1qA9AJUOWllVHgqh2krYZDJ2MO2krbppOyBxf18aUjSbDP9Y2UKJkjKh
         UcoPAq1GV15BhiZfpsrgG4m6vtaqm1pE6+D7+j455ospweZhvpdw281IWqzIYP1W0sJ7
         CxHykNPoK61d702ZYJbUQeByI26FxnHp9pVcKaJ8ZnDFkQKgSvbjVa4Zay5s4JcjGcKX
         0QWOTu6v5vWmi3/gQC70/Yu6jGhFnC3Wobadd0EvrYi7MnQOT4WV2QF/nzXOvQKk4L69
         XIkF8pLcRPJQpM8Zc7cZtoPPBfu8S///lZkCVZPzbbNNjdXMXkmcabAWkTU/rbqMPa3q
         iLDg==
X-Forwarded-Encrypted: i=1; AJvYcCVhHUGD1I0nd3gB4afBIeWTSfGaF8hGvuv3BRZj0TFqYJhrcbWsE/hOY6x1a5UwX9MlhWX+OYWgHNiQu3HOSuzHcvUMiNBHbHXM7nm+
X-Gm-Message-State: AOJu0Yz5xoEMlR1Signh1Q6cyeb3WLaESEylzpRR452Lq65PJw9iNUgQ
	fkHyNMb+Fg/6nvhlJO+yHHa2QkavB+tz4Wtf2Z/Mb7BJjyLzcohDWH6Jy3I+rZwCWeQ0udRRLfZ
	N5HTCmiDSvnoF7WC04ecjq4+UwxeVmbucT5DIIg==
X-Google-Smtp-Source: AGHT+IFxkkjp3fqK9lU0wtMgPlDRTY2Cd2wIkY8GxicXToEgBWVNk+WJY3GzgNmNfvvI5PceIdD3ucHY/8b9z28EL74=
X-Received: by 2002:a17:90a:b297:b0:2c1:948b:6f2c with SMTP id
 98e67ed59e1d1-2c27db5ce10mr3938026a91.39.1717616525310; Wed, 05 Jun 2024
 12:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716578450.git.tjeznach@rivosinc.com> <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240603-d622cdac0016f1f854bf2b4c@orel>
In-Reply-To: <20240603-d622cdac0016f1f854bf2b4c@orel>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 5 Jun 2024 12:41:53 -0700
Message-ID: <CAH2o1u4mU2fs7p+J7pqeBSRRPb1SFZh=8UXzXCsJneTHMxVVgw@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:59=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Fri, May 24, 2024 at 12:34:42PM GMT, Tomasz Jeznach wrote:
> ...
> > +static struct platform_driver riscv_iommu_platform_driver =3D {
> > +     .probe =3D riscv_iommu_platform_probe,
> > +     .remove_new =3D riscv_iommu_platform_remove,
>
> Hi Tomasz,
>
> I think we should also support .shutdown (just turn the IOMMU off?),
> otherwise the IOMMU driver reports EBUSY and fails to initialize when
> rebooting.
>
> Same comment for the PCI driver.
>

I've been testing patches with added shutdown handlers, also looking
at reboot notifier hooks. In both cases, devices actively running DMA
traffic at system shutdown (eg. storage) might be affected by
too-early IOMMU disable call. This topic was already brought up in the
discussion [1] about kexec reboot flow.

In this series I'd prefer to keep the IOMMU active during shutdown,
and prepare the RISC-V IOMMU shutdown sequence implementation as a
separate series, as it will involve more risc-v reboot rework to
guarantee ordering of the shutdown callbacks. In a normal reboot
cycle, firmware/hardware reset should bring IOMMU to known
out-of-reset state anyway.

[1] https://lore.kernel.org/linux-iommu/059ae516-aed4-4836-a2ca-aff150ff428=
d@arm.com/

Best,
- Tomasz

> Thanks,
> drew

