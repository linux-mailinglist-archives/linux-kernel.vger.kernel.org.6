Return-Path: <linux-kernel+bounces-398779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CCD9BF5F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044EC1C21519
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A46203704;
	Wed,  6 Nov 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="02HoL1jw"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FB25765
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919669; cv=none; b=GIVKyNPS9X/oVLbUcHz0bnzJ7LO/82ijZL3r0gTWIUM8aeXFEXBUFk36ht/v5OkRAXruH9HQd7yWssSUPyVqaj4D2hmXOT/ZLAvHQzqQE6P/x7fgZKHINysr1vgqiymSmsdo4B9364iQaXnZJdQFAQY5uyn68HWMSKAXDXLBbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919669; c=relaxed/simple;
	bh=5hdQupgsH4RLCWd2NxZg727/NPUBjS2vG2y9B6bJEKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKOGEXRpulVwuL33Tr7Cmoc8qCL8DmKGbVf5Rbqd4k35QrMdLZjfClktoNMLm9RrMxpR5Ybhq7E4qPCgTRDLZfpMqruCpRSlEDuCAYol5iEhNyMx5eIe/NGNVDDXkVf3rRzajemLtSYkVAMARRxoNxnMspDtt1fIU3rSbHrClGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=02HoL1jw; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a6bba54722so728975ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730919666; x=1731524466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nokwy9FNt4uthy8MIjfBTH5T/UpMOLuozVjuYdrWGao=;
        b=02HoL1jwC/UrAjysk1jWZ9eKyJP066H5wJ/mOTuPH1++oLIXd3MNE0dZF0TQ0ZGuTX
         DTDRQjGfVDaaKBv8/GS1Fh/TkBF63e0NS2V2hlBkZEzeFNzJ1l+BsqlVPClyomHwbyKp
         zB1zj91mQQ+94+6JcaMwtzjulzWxB4BWJ963N4Aa+gJEkpAD9v8g+wdSB2ZbQ81yaQzx
         ebmJMt77gCSGPafe8+9umUSk7D6R4Xzv0hR4BX28aB6RN21D9GBFZX1IlBQA6GY0wTeG
         IuPwGMgpPHMu7RI+dTxZ3R6Pz/mYyw3X6emOzLCnAnSRYZIMuff/LH7khlCfOfypgMG8
         ZPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919666; x=1731524466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nokwy9FNt4uthy8MIjfBTH5T/UpMOLuozVjuYdrWGao=;
        b=u3lvIwJ2MSKWdhKaV6sAVkG7+WCuyh5BpEQ8aPrePQCHb7rdx9moNFPDwZ0mMc/8C1
         W2LuunuevTWMth9prp6gwhSy+q3XkUEmvTIlLkxGQP73XV0ziC72JplpWYWthOqkWIcA
         13ciZgdoxVXyfJJLXf+zi+NWEBkBur9Vl+sFUekhOIaV5UwXYXX2TYy+bxuefq1uEAIW
         MwqnLcTVmzh7D2bMPSRHSoAu7ilkZY16AiHV4ezzPdxaETlWVx+oArzCbVR4duyZzWiP
         uUx0NIm9oCOZk4nHsii48jiUvn7oekQE7Vb79b5rB+ysUgYRzbR+nDYIqCSarfjrUgFx
         5NRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC0kDhjHY1or/VPVk9S2n5fDw15Hqoj3BKs2ryTPk0uvpe5gwxd73b+DinmAXBueBqUOjRranh0KptXkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yNSOW+KQWyv/zHcJ7weD4nOLwEGIVGmELAh06HwFXGT7Uap+
	Hc4D0s1Ei/QF0TnVTsMdJtyQYKxWLqBsrZB0ZUOqBB1BAUJKa8eMRszg61HfOpxNYm/FwAWoWJQ
	+byV9qQqC5ZZvateybxc6oZv+8Zx24CdlC9Xf+g==
X-Google-Smtp-Source: AGHT+IGKLw+vtB22wIL6ge+rYJfG2yKicRc2L7oxp3S9z+BUnDn7CDGeMTTQTITBq0NYmM5cY0+xV814s8EnnG1ZsZw=
X-Received: by 2002:a05:6e02:1568:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6b25813e9mr226176725ab.2.1730919666151; Wed, 06 Nov 2024
 11:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106175102.219923-4-ajones@ventanamicro.com> <20241106175102.219923-5-ajones@ventanamicro.com>
In-Reply-To: <20241106175102.219923-5-ajones@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 6 Nov 2024 11:00:55 -0800
Message-ID: <CAH2o1u5ttY+0d4v8U=H-PwLUHZo5uMxxCQ5NAXudOQvUUMcpfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/riscv: Free irq vectors on pci remove
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:51=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> riscv_iommu_pci_probe() calls pci_alloc_irq_vectors() which
> states pci_free_irq_vectors() must be called on cleanup.
>
> Fixes: 68682e9578fb ("iommu/riscv: Add RISC-V IOMMU PCIe device driver")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/iommu/riscv/iommu-pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-=
pci.c
> index c7a89143014c..25a27e627a0e 100644
> --- a/drivers/iommu/riscv/iommu-pci.c
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -99,6 +99,7 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev=
)
>         struct riscv_iommu_device *iommu =3D dev_get_drvdata(&pdev->dev);
>
>         riscv_iommu_remove(iommu);
> +       pci_free_irq_vectors(pdev);
>  }
>
>  static const struct pci_device_id riscv_iommu_pci_tbl[] =3D {
> --
> 2.47.0
>

Andrew, interrupt release call pci_free_irq_vectors() should already
be called by device
managed resources framework, with unwind action callback pcim_msi_release()=
.

Callback is registered during vectors allocation:
 pci_alloc_irq_vectors_affinity()
  __pci_enable_msix_range()
   pci_setup_msi_context()
    pcim_setup_msi_release()

This driver enables device resources management with initial call to
pcim_enable_device().

Are there any conditions / testing sequence the release function is not cal=
led?

Thanks,
- Tomasz

