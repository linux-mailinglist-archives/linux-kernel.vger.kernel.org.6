Return-Path: <linux-kernel+bounces-334972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE697DF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265841C20A03
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DDC153820;
	Sat, 21 Sep 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTCsEOtm"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B63B784
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726954697; cv=none; b=ToSSBnQRwYi9ezyK7nH7DtaytR2BZ1NsSq8U7Dx5P4Bi65RUmnbikA4ZH9vKGx3yyc/4+ITONKy4VGpeFyT3oKW/hXBvg/h9YXlXhI4rOy/PJt0MB6ekwvx6CLG9KKi2xE3lXYWzpJ4IUiQCZKtM3ndvl4cs0KLG1ugXZJQPM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726954697; c=relaxed/simple;
	bh=w4QVQfgcQgyQag7yRriIMpHEU+g3Vei+Zb1KtY1LFDU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XImpD0CV3pWtG5L4GPRuKG8sRIgRNr27zrTxEaAlgt8XiHgq7ib8Y4n+ep6TNGYDjAu4GSncMJzvhI8QCzjfxM34AdzEYIJYEgbWy43mAIQrR7jEWNbvWvLGdls7oLB6+I/+vvcTaOzUcyphRyzvVuQBQYp2WVLwgmtc71c2asY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTCsEOtm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c180d123so1829264f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726954694; x=1727559494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3NvfYzNTbShONnVCdHDTbFQyqAeYG2kYoflrACZYBo=;
        b=mTCsEOtm6pB0VGwNSiSR8gO3/Tv01pJqt4sfm/HDo2wV1CfSKuN+clmscqDWSvOIoF
         QL96DUQrFPu3uvgx4XIzq39ps2cOnNYQaqOPlsyS6IFo3c7kj+fCb87aNNlA8ygDONJA
         zjdABo+9we/kahqxxE3ANxqaKFDG2b977Wmju3IxO1Ow7aHxUXILaX+k+3++pg7mvVkz
         RlJZLzoloZMrMzpdHMAzJbAnWQbEWr2aY9PNLVaB/uOlXyoaurwwYNHZmr+I2LepgUPG
         KFYRnKBfLUOVW4d4sLX9J3yMlpQNe6rQk5xIWlugYk5imgfzQ1SdZhaCrO4ORnnmkM5G
         p0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726954694; x=1727559494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3NvfYzNTbShONnVCdHDTbFQyqAeYG2kYoflrACZYBo=;
        b=gRhq3jCHtkLaVh6V4adv5KstbZfr/iVjIss0IbkIBBJWkF6GivDJXl1Rta4m40cpmI
         WOTcnDxrwwHLdWoUfuOA9ngIjfaibedYM7O9GnnnLhS9cgwt9/ZQKBSymt/XCdUHqA7M
         QJHd8J47ak+SDubFr7pRFXvw4MYezlvvK2IDnCWGwfwGOGjADVcMnqqov6jtEDA4qsOg
         HiJX+S9lDRGOi2ETmi0gtNvQ1ES3wSX5GK+uFBMnzywixCY5fT4VWySfYipuWndA/rjV
         9RwhvbntsJuLiHnmiNDchZpTLrRt9WSMojue6lbDUvArD/Lw4YI7mLa+ONTDA4gx5Mh0
         0Zlw==
X-Forwarded-Encrypted: i=1; AJvYcCVlj+7CVx0wVMw1R05yqjxcpeNcAvA0KsPiB+IHJfs++8EAU+fhe1aA9uwnwhAHWaD4pxG7RdxO6zEVO7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcjbANZj3HL3/uNS1RhXOmHZRoTOSj5kq7aEbws5wqYdE4adL
	MFiHV//B8Ntm/4yLqyjwF2er8e3bvog2u/MfHFW+u0H6u3SlWoTF
X-Google-Smtp-Source: AGHT+IGuwmNtuv5s0KBf/5MOagUyi+noF7gBM3ufjDQmyedeLb5ag210gMRGfI2bqhMDjmZuQsp3NA==
X-Received: by 2002:a05:6000:1f06:b0:374:bb34:9fd2 with SMTP id ffacd0b85a97d-37a4234d22emr3184769f8f.36.1726954693703;
        Sat, 21 Sep 2024 14:38:13 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f06a4sm20737328f8f.23.2024.09.21.14.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 14:38:12 -0700 (PDT)
Message-ID: <cff2b9b064c22e185bad42010ded7e1559fe672f.camel@gmail.com>
Subject: Re: [PATCH 1/4] soc: marvell: Add a general purpose RVU PF driver
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com, 
	ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org, 
	nikita.shubin@maquefel.me, vkoul@kernel.org, cyy@cyyself.name, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com
Date: Sat, 21 Sep 2024 23:38:32 +0200
In-Reply-To: <20240920112318.2722488-2-agaur@marvell.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-2-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Anshumali!

On Fri, 2024-09-20 at 16:53 +0530, Anshumali Gaur wrote:
> Resource virtualization unit (RVU) on Marvell's Octeon series of
> silicons maps HW resources from the network, crypto and other
> functional blocks into PCI-compatible physical and virtual functions.
> Each functional block again has multiple local functions (LFs) for
> provisioning to PCI devices.
> RVU supports multiple PCIe SRIOV physical functions (PFs) and virtual
> functions (VFs). And RVU admin function (AF) is the one which manages
> all the resources (local functions etc) in the system.
>=20
> Functionality of these PFs and VFs depends on which block LFs are
> attached to them. Depending on usecase some PFs might support IO
> (ie LFs attached) and some may not. For the usecases where PF
> doesn't (need to) support IO, PF's driver will be limited to below
> functionality.
> 1. Creating and destroying of PCIe SRIOV VFs
> 2. Support mailbox communication between VFs and admin function
> =C2=A0=C2=A0 (RVU AF)
> 3. PCIe Function level reset (FLR) for VFs
>=20
> For such PFs this patch series adds a general purpose driver which
> supports above functionality. This will avoid duplicating same
> functionality for different RVU PFs.
>=20
> This patch adds basic stub PF driver with PCI device init logic and
> SRIOV enable/disable support.
>=20
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---
>=20

[]

> diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h b/drivers/soc/marvel=
l/rvu_gen_pf/gen_pf.h
> new file mode 100644
> index 000000000000..4cf12e65a526
> --- /dev/null
> +++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell Octeon RVU Generic Physical Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +
> +#define RVU_PFFUNC(pf, func)=C2=A0=C2=A0=C2=A0 \
> +	((((pf) & RVU_PFVF_PF_MASK) << RVU_PFVF_PF_SHIFT) | \
> +	(((func) & RVU_PFVF_FUNC_MASK) << RVU_PFVF_FUNC_SHIFT))
> +
> +struct gen_pf_dev {
> +	struct pci_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *p=
dev;
> +	struct device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *dev;
> +	void __iomem		*reg_base;
> +	int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pf;
> +	u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_vfs;
> +};

The above struct has strange indentation with tabs and spaces.

--=20
Alexander Sverdlin.


