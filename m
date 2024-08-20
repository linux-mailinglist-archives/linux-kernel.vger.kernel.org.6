Return-Path: <linux-kernel+bounces-293439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D1957F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD413283D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F91898E8;
	Tue, 20 Aug 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2q70F6C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A1188CD6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138530; cv=none; b=V9GtjbnK0Sk1RChdq6DuwXIhIIPxT+pUaVJoAaPCqYTsIy52lZPwLmRsjjfItJAFbXSgs5+rk8Vl7rTEdCkYHvasvl16+5goFSsmNsRtqukbnVCE7gZW7lVU58n7CCjUpDYTtz1gV/HNA739tODRPXugRZTo3iMLLHAos1aKO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138530; c=relaxed/simple;
	bh=CwAJcF6bJ+g48Ud2pzdceQkOvdF0s36dJmUP+WwsYDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8xtk5LhhARy/t9aotzHOWhpzwSu7omO57uOK4IYUhByd7qmK9sxbmEys1E0oreQnBczlaAKIrircheEFV+4SXdaZMtD1+3xhoDbiF1Upd4hFl2PX4lTEgfBlXPhdMIeld6PYVXIKr02VLBDvbL5Fr+6Ix2Ryh9bU7nTswkEVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2q70F6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724138527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASIEWrzHXogS2+yni6jFmR1o/WYm2ANcxSxU4DhoyQc=;
	b=F2q70F6C6i4n2LFBptboSqzVFALyoTAy9csRmXhdSSn6o46l1t446t4axzzVjswKXLxAVn
	wddazw23VQL2/fyuBqWC8gtZSMHhkE/GrQGruUaGLqhpwQgdQznFQV9t8afYWSNfcT/VK8
	w/AUoDlvjS0G6DTMzHAPkzkjJwDELAQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-p_lFiewMM-altJ-TAR_IFw-1; Tue, 20 Aug 2024 03:22:04 -0400
X-MC-Unique: p_lFiewMM-altJ-TAR_IFw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4290cc01eb3so9507265e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138523; x=1724743323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASIEWrzHXogS2+yni6jFmR1o/WYm2ANcxSxU4DhoyQc=;
        b=HMngf8GcxyC00n0rHgeQvWYjgF8aLdxOQezqsUAoM+7jmeu2ujwRTgi0QnwzQZimB6
         dZosMVGknQn0NJ9E1fVuCobBVKTcfzd1fjLl0uPOjrUhk5xflC+YknnJnYZ8ggICItoa
         Onfmba36ffURMRXOKilYjLXCFHYDBb2WS8vT3hLTh7cN+L5NKZI69xHUT4a0PmMR8rHX
         MtBZqFEUNQ7m+z03bcxZcvs2yuXyBHVqg9mv6ojkDR8TZ2EDu13XbBD2KTkcbTE0CqCC
         oer2fv0WGZHLava+69iCc8rgZ5/DWcckVO5/VfwPi64PbQqjpsm2xCtQezeHp2yax+Tu
         bN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvT4Yjyu/yTTu+fm1+v/ujzK+baRn7ySeltleZi116XnwfvB7HLcvCdA7SXvdS+1FFv023vVGMbhKXlhyFIegqloZE5E1/KeZYLCqR
X-Gm-Message-State: AOJu0YxAHhJecmrOvhLC6Clv/AYvTigkuKo1dNxCOI6lTmCX2KSnW3rf
	3JtulRWdJEl73OK1PUDsCzTpTu2+so1OeTalo8qe9uxbK2D1KwUIZSXm0iHumTcQyK13zGEZz+6
	Ut4LjpM9uH3RTbXGL4EcGyWHCV2LQXiWVlE1DMLZYCi8EhoDenPaPWgEWwBIzPA==
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr55367795e9.0.1724138522939;
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtu6sXluOG26PWy70qwsbDcaM81TTK+UTUTvyjs1U84scjqTgJELEGk3SrTeSIfdGLnjJpqA==
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr55367605e9.0.1724138522431;
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429eeadfafbsm130634445e9.47.2024.08.20.00.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
Message-ID: <267a021781f59d6efe798dbca63f29dd25359f2d.camel@redhat.com>
Subject: Re: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>, Damien Le
 Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 09:22:00 +0200
In-Reply-To: <20240819165148.58201-6-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-6-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 18:51 +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>=20
> In mtip32xx, these functions can easily be replaced by their
> respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's call to pcim_iounmap_regions() is not necessary, because
> it's
> invoked in the remove() function. Cleanup can, hence, be performed by
> PCI devres automatically.
>=20
> Replace pcim_iomap_regions() and pcim_iomap_table().
>=20
> Remove the call to pcim_iounmap_regions().
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/block/mtip32xx/mtip32xx.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c
> b/drivers/block/mtip32xx/mtip32xx.c
> index c6ef0546ffc9..c7da6090954e 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
> =C2=A0	int rv;
> =C2=A0	unsigned long timeout, timetaken;
> =C2=A0
> -	dd->mmio =3D pcim_iomap_table(dd->pdev)[MTIP_ABAR];
> +	dd->mmio =3D pcim_iomap(dd->pdev, MTIP_ABAR, 0);
> +	if (!dd->mmio)
> +		return -ENOMEM;
> =C2=A0
> =C2=A0	mtip_detect_product(dd);
> =C2=A0	if (dd->product_type =3D=3D MTIP_PRODUCT_UNKNOWN) {
> @@ -3726,9 +3728,9 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Map BAR5 to memory. */
> -	rv =3D pcim_iomap_regions(pdev, 1 << MTIP_ABAR,
> MTIP_DRV_NAME);
> +	rv =3D pcim_request_region(pdev, 1, MTIP_DRV_NAME);

That's a bug here, btw.
Should be MTIP_ABAR instead of 1.

Will fix in v2.

P.

> =C2=A0	if (rv < 0) {
> -		dev_err(&pdev->dev, "Unable to map regions\n");
> +		dev_err(&pdev->dev, "Unable to request regions\n");
> =C2=A0		goto iomap_err;
> =C2=A0	}
> =C2=A0
> @@ -3849,7 +3851,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0		drop_cpu(dd->work[2].cpu_binding);
> =C2=A0	}
> =C2=A0setmask_err:
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> +	pcim_release_region(pdev, MTIP_ABAR);
> =C2=A0
> =C2=A0iomap_err:
> =C2=A0	kfree(dd);
> @@ -3925,7 +3927,6 @@ static void mtip_pci_remove(struct pci_dev
> *pdev)
> =C2=A0
> =C2=A0	pci_disable_msi(pdev);
> =C2=A0
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> =C2=A0	pci_set_drvdata(pdev, NULL);
> =C2=A0
> =C2=A0	put_disk(dd->disk);


