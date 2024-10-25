Return-Path: <linux-kernel+bounces-381368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFC9AFE26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213991C2244C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D91D4171;
	Fri, 25 Oct 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdpAvD1w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5B1D2793
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848389; cv=none; b=X15f4Jrsfv71c5xEGKSEgpqbJ1KQZF88mKZkSdN0025Ejw0TruQ+fcque+5fhzd0Je5Po+Cq+PIf5Xe7T5zPcAC2pDNbHuyhvHFEJqpbvnvdLC7T2/7uEuLXZ2pnDkh0qSR0rBm8WJGB9KihGCYY4Pzjjj1cBqU2nfCkSnJe5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848389; c=relaxed/simple;
	bh=/yWsiDoSdlppm0K6tEYQdyTQtrffn9nxLRavWmNKpW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X43ceZPfT03nu/YgNgltXggwSCiDsZE9lHGBkYW9ifQT5W4wqXb6tlTK42864NlFzW/eFrtHi5SmljMEc+rpojNlS0Ix73iR945YFQrDwF/RXUN7ATLUEVmNmgg2aa71wKR7bBdIjrYopC7Q4hEjLyeAlcSBBjeKAj0qMS83oBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdpAvD1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729848386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vft52JmzTiczAkz0JTeV2gs/f2qmNtZvbi4AAtbyLkQ=;
	b=CdpAvD1w/rzZADMSkSHzAuRP7QPLreN6+PrLavw/QIm04Y+g6/Ic7AeVtc7VpdsGBrac87
	EYCXgXVsbmVFrlzUL6Mpd4jPOaeclCLbTBB7AkG4WrT+7Zk+FUf7GN+n1i+Wex1M5yDUBg
	5zfEu0GgiwPPsCcG2fg/hl99Zy6Mvo8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-3Ov_TIREMG2zpP_Ql7KPXQ-1; Fri, 25 Oct 2024 05:26:21 -0400
X-MC-Unique: 3Ov_TIREMG2zpP_Ql7KPXQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso13426565e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729848380; x=1730453180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vft52JmzTiczAkz0JTeV2gs/f2qmNtZvbi4AAtbyLkQ=;
        b=EL1rYJGZk+NhcQHpzmW5jBQ3JqDIlr8/ra0YOYuDEVh/Y0/2+LO5Zt2IDOfHFu5/U1
         k/G3lY/0RBRdK/VdZcYr+JuMC3ovR1CL3Bpa1y6fxEEdzzXPMpz8bwUSwyhtZ5SyJdYH
         7fyVZiWzGVHWNrtWfoVhyi0ZOz4QJybV4QsIvvU0hnUYTbOsDbpnVW5VG8IJvK0vm77A
         qFAsT4N2wBDINQcAYu9PTUuEMaIZlDiFni/8brS3PYR74lQu3L60B9u4znobxd5Aa7+5
         YAjcToAQw880Y8MlF6sOWcgzdJqE4Yx9H5+KiN9+wB7BSdGxJqwiV5iAgeisi+2Xz6VB
         A8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXRQie1U+37TPMtXNn4v6kOjK306RCNJ/Z3O/3JEhhXaJii9aaOVs6QD78i3N91Ts2Icu1FZD/pJYaEmkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnyr+leZL7p2tTHyC8qc2u9IX1TfjfOdUNAZ8/eZoVAgNKmBiw
	cQgpe739ZQuPXJ9LKDud9pPkbHgJqb0jL/FrQS2F9RZ8MWR3Zmg1U9Us/MoTv50G/Dnt/+Nrm+k
	kzUZoQ4D4APWYohZjvRnpQq+JecbCvrUI/aik04I2C9J+f+oBCUhmPm4PoL9+tw==
X-Received: by 2002:a05:600c:3b05:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4318424d1f6mr77148445e9.34.1729848380310;
        Fri, 25 Oct 2024 02:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERugywjqAp5mpBy60KpzrMcSUOWGQ9K6FvvVevRSQRlDJcDbOEdtHW3IktibMs0Ql+3/BNCQ==
X-Received: by 2002:a05:600c:3b05:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4318424d1f6mr77148205e9.34.1729848379884;
        Fri, 25 Oct 2024 02:26:19 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2de5:ba00:738a:c8da:daac:7543? (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56eda3sm42611775e9.31.2024.10.25.02.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:26:19 -0700 (PDT)
Message-ID: <933083faa55109949cbb5a07dcec27f3e4bff9ec.camel@redhat.com>
Subject: Re: [PATCH] PCI: Restore the original INTX_DISABLE bit by
 pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 11:26:18 +0200
In-Reply-To: <20241024155539.19416-1-tiwai@suse.de>
References: <20241024155539.19416-1-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2024-10-24 at 17:55 +0200, Takashi Iwai wrote:
> pcim_intx() tries to restore the INTX_DISABLE bit at removal via
> devres, but there is a chance that it restores a wrong value.
> Because the value to be restored is blindly assumed to be the
> negative
> of the enable argument, when a driver calls pcim_intx() unnecessarily
> for the already enabled state, it'll restore to the disabled state in
> turn.

It depends on how it is called, no?

// INTx =3D=3D 1
pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct

---

// INTx =3D=3D 0
pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong

Maybe it makes sense to replace part of the commit text with something
like the example above?

> =C2=A0 Also, when a driver calls pcim_intx() multiple times with
> different enable argument values, the last one will win no matter
> what
> value it is.

Means

// INTx =3D=3D 0
pcim_intx(pdev, 0); // orig_INTx =3D=3D 1, INTx =3D=3D 0
pcim_intx(pdev, 1); // orig_INTx =3D=3D 0, INTx =3D=3D 1
pcim_intx(pdev, 0); // orig_INTx =3D=3D 1, INTx =3D=3D 0

So in this example the first call would cause a wrong orig_INTx, but
the last call =E2=80=93 the one "who will win" =E2=80=93 seems to do the ri=
ght thing,
dosen't it?

>=20
> This patch addresses those inconsistencies by saving the original
> INTX_DISABLE state at the first devres_alloc(); this assures that the
> original state is restored properly, and the later pcim_intx() calls
> won't overwrite res->orig_intx any longer.
>=20
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")

That commit is also in 6.11, so we need:

Cc: stable@vger.kernel.org # 6.11+

> Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =C2=A0drivers/pci/devres.c | 18 ++++++++++++++----
> =C2=A01 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index b133967faef8..aed3c9a355cb 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -438,8 +438,17 @@ static void pcim_intx_restore(struct device
> *dev, void *data)
> =C2=A0	__pcim_intx(pdev, res->orig_intx);
> =C2=A0}
> =C2=A0
> -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> device *dev)
> +static void save_orig_intx(struct pci_dev *pdev, struct
> pcim_intx_devres *res)
> =C2=A0{
> +	u16 pci_command;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> +	res->orig_intx =3D !(pci_command & PCI_COMMAND_INTX_DISABLE);
> +}
> +
> +static struct pcim_intx_devres *get_or_create_intx_devres(struct
> pci_dev *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> =C2=A0	struct pcim_intx_devres *res;
> =C2=A0
> =C2=A0	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> @@ -447,8 +456,10 @@ static struct pcim_intx_devres
> *get_or_create_intx_devres(struct device *dev)
> =C2=A0		return res;
> =C2=A0
> =C2=A0	res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> GFP_KERNEL);
> -	if (res)
> +	if (res) {
> +		save_orig_intx(pdev, res);

This is not the correct place =E2=80=93 get_or_create_intx_devres() should =
get
the resource if it exists, or allocate it if it doesn't, but its
purpose is not to modify the resource.

> =C2=A0		devres_add(dev, res);
> +	}
> =C2=A0
> =C2=A0	return res;
> =C2=A0}
> @@ -467,11 +478,10 @@ int pcim_intx(struct pci_dev *pdev, int enable)
> =C2=A0{
> =C2=A0	struct pcim_intx_devres *res;
> =C2=A0
> -	res =3D get_or_create_intx_devres(&pdev->dev);
> +	res =3D get_or_create_intx_devres(pdev);
> =C2=A0	if (!res)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	res->orig_intx =3D !enable;

Here is the right place to call save_orig_intx(). That way you also
won't need the new variable struct device *dev above :)

Thank you,
P.


> =C2=A0	__pcim_intx(pdev, enable);
> =C2=A0
> =C2=A0	return 0;


