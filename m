Return-Path: <linux-kernel+bounces-289226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58B95435B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03CD1F25068
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30514B087;
	Fri, 16 Aug 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0BJthpU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1014A4FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794458; cv=none; b=YregLK7gkv3T0kjFfRj3z8G+KknA9Gr/OiZgMdRuADJkG9L/0duJ07FJzbQ2iohP3rrg9icI9fAdZNJG+mbbJ0dFIpeKK3KQNsbhClGTbuS2IrXReb1jkMU5q+V/23lnyFtwiRCqmy3ZYPBVVqR4iWXrdYm+Bbr5v8bvy9ZOGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794458; c=relaxed/simple;
	bh=qD1OFtO/qJnrvrml5wouhVG92sWSwTSTNw43wCV9uTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7TxVYLNYb6iEhE4Fg56AZwcK75QNTVXQylQSogOJ+O/UiYz7Mo2MzqgNRsFsL+IJy24xM5Nfz1Fy1Oerm63pyXT0VfWdsK1lDLZbsuwugVDBUAS2TIFUt4CynftphY5QZWRozVYu37yzaXs7HDWOJ9WO+mX+3uGYsiBMfW78VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0BJthpU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723794455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3+oGBurxqhUAn+LlCI73zSVN83RLmsnyOF7xPiqQ+Q=;
	b=S0BJthpULQMIN5oV52yutXh6vJd/N/NnH3VdyIlN1b9Yf6HixciZ058peWMaR3xsYhDD1k
	+fzmwQ+Q1JHCU8eqGR7RAc8ExIOEDwAPoBMrALvAqcp77OuB76LivUDvQD/N6kreNYHiDf
	4wPplR7ZLupfuXjTVjbxwCmHLmfOUCA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-2TsM3b78P7ig1F3l4Y7KwA-1; Fri, 16 Aug 2024 03:47:33 -0400
X-MC-Unique: 2TsM3b78P7ig1F3l4Y7KwA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4267378f538so2897825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723794452; x=1724399252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3+oGBurxqhUAn+LlCI73zSVN83RLmsnyOF7xPiqQ+Q=;
        b=sGF/2HR2ztwZrYFVOWQr2nD2O8/l8CBN5Wflo+8eyDPz78uBuvt3OjwDnR6kBhVrK0
         QabWE9nbKO2NyuV7InS/IgToqjXH96JKPW6UlJS5nR3agXwkdVfggNaWbwyhpdQ6XMd6
         14zw3PyCDLbu3eEVLCCP5Sz2W3QKzDnBJnL/n3SNQT3t/7xtcpyg6UAS8aU17DNhtiL7
         e5s1cHaGgU3jfbnFPUuBDKppvD8C/ty0K9SrybgjAsuWJno5JBXH76J2m7Hq9cIRA9Gt
         ivUG+unvUaLiBffpYWrD+ATRC64HkNr02o8Fmq6kNwB0GsToMffkBl/86WDtuU+2/R1N
         Mdug==
X-Forwarded-Encrypted: i=1; AJvYcCV0Q9QQujQdHLT+W3jxB07Aws1RwjdfB3WjlTaKSPVs84Q3IDTa4guuy/JD9Ow4rQbOg+HrAg28A2NZLIxJmWef48b6WHAzJA3kQLOH
X-Gm-Message-State: AOJu0YwTj6pVC12+W31bmDSW5gyLSo8dybegNEMrXfp53wirEuYA4Qbn
	JqWQLFVW3H4FN8AoistbJ4exJ7+mO2nnraoNFmCxugw8ZFEFjbWMrARj8EiACYEOTZMp/7ov1KB
	WuaGs0evLhuKdNWm5ZruLOCOII+/PDj/MG6XI9bSlk+S9c90cBAth6VZdSLzDsg==
X-Received: by 2002:a5d:5984:0:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-3719431dfc0mr769781f8f.1.1723794451954;
        Fri, 16 Aug 2024 00:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4ozEjfAOD0QEHHeHPcUnNdfIQxp3r757L0yb57BkQvFFuPL+ahHJVAq23k76NL2WjLdZVw==
X-Received: by 2002:a5d:5984:0:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-3719431dfc0mr769766f8f.1.1723794451492;
        Fri, 16 Aug 2024 00:47:31 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a35fsm3034918f8f.59.2024.08.16.00.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:47:31 -0700 (PDT)
Message-ID: <94a378e6c2d442e0e7ae06fbd496d02983f9baaa.camel@redhat.com>
Subject: Re: [PATCH] ata: Replace deprecated PCI devres functions
From: Philipp Stanner <pstanner@redhat.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
 <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pstanner@redhat.com
Date: Fri, 16 Aug 2024 09:47:29 +0200
In-Reply-To: <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
References: <20240812084839.37580-2-pstanner@redhat.com>
	 <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 20:32 +0300, Sergey Shtylyov wrote:
> On 8/12/24 11:48 AM, Philipp Stanner wrote:
>=20
> > The ata subsystem uses the PCI devres functions pcim_iomap_table()
> > and
> > pcim_request_regions(), which have been deprecated in commit
> > e354bb84a4c1
> > ("PCI: Deprecate pcim_iomap_table(),
> > pcim_iomap_regions_request_all()").
> >=20
> > These functions internally already use their successors, notably
> > pcim_request_region(), so they are quite trivial to replace.
> >=20
> > However, one thing special about ata is that it stores the iomap
> > table
> > provided by pcim_iomap_table() in struct ata_host. This can be
> > replaced
> > with a __iomem pointer table, statically allocated with size
> > PCI_STD_NUM_BARS so it can house the maximum number of PCI BARs.
> > The
> > only further modification then necessary is to explicitly fill that
> > table, whereas before it was filled implicitly by
> > pcim_request_regions().
> >=20
> > Modify the iomap table in struct ata_host.
> >=20
> > Replace all calls to pcim_request_region() with ones to
> > pcim_request_region().
>=20
> =C2=A0=C2=A0 Huh? :-)
> =C2=A0=C2=A0 Besides, I'm not seeing pcim_request_region() anywhere in th=
is
> patch...

Ah, typo. pcim_iomap_regionS() is being replaced.

>=20
> > Remove all calls to pcim_iomap_table().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> [...]
> > =C2=A0drivers/ata/ata_piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+---
> > =C2=A0drivers/ata/libata-sff.c=C2=A0=C2=A0=C2=A0 | 50 +++++++++++++++++=
+++++++++++++---
> > ----
> > =C2=A0drivers/ata/pata_atp867x.c=C2=A0 | 13 ++++++----
> > =C2=A0drivers/ata/pata_hpt3x3.c=C2=A0=C2=A0 |=C2=A0 8 +++---
> > =C2=A0drivers/ata/pata_ninja32.c=C2=A0 | 10 ++++----
> > =C2=A0drivers/ata/pata_pdc2027x.c | 11 ++++----
> > =C2=A0drivers/ata/pata_sil680.c=C2=A0=C2=A0 | 11 ++++----
> > =C2=A0drivers/ata/pdc_adma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++=
+----
> > =C2=A0drivers/ata/sata_inic162x.c | 10 +++-----
> > =C2=A0drivers/ata/sata_mv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 +++---
> > =C2=A0drivers/ata/sata_nv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 +++---
> > =C2=A0drivers/ata/sata_promise.c=C2=A0 |=C2=A0 7 +++---
> > =C2=A0drivers/ata/sata_qstor.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++---
> > =C2=A0drivers/ata/sata_sil.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+---
> > =C2=A0drivers/ata/sata_sil24.c=C2=A0=C2=A0=C2=A0 | 20 ++++++++-------
> > =C2=A0drivers/ata/sata_sis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++=
+---
> > =C2=A0drivers/ata/sata_svw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++=
++---
> > =C2=A0drivers/ata/sata_sx4.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++=
+++---
> > =C2=A0drivers/ata/sata_via.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31 +++++++=
+++++++---------
> > =C2=A0drivers/ata/sata_vsc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+---
> > =C2=A0include/linux/libata.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+++-
> > =C2=A021 files changed, 163 insertions(+), 102 deletions(-)
>=20
> =C2=A0=C2=A0 I did review all the changes, not just PATA drivers.

Thx

>=20
> [...]
> > diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> > index 250f7dae05fd..d58db8226436 100644
> > --- a/drivers/ata/libata-sff.c
> > +++ b/drivers/ata/libata-sff.c
> [...]
> > @@ -2172,8 +2173,41 @@ int ata_pci_sff_init_host(struct ata_host
> > *host)
> > =C2=A0			continue;
> > =C2=A0		}
> > =C2=A0
> > -		rc =3D pcim_iomap_regions(pdev, 0x3 << base,
> > -					dev_driver_string(gdev));
> > +		/*
> > +		 * In a first loop run, we want to get BARs 0 and
> > 1.
> > +		 * In a second run, we want BARs 2 and 3.
> > +		 */
> > +		if (i =3D=3D 0) {
> > +			io_tmp =3D pcim_iomap_region(pdev, 0,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[0] =3D io_tmp;
> > +
> > +			io_tmp =3D pcim_iomap_region(pdev, 1,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[1] =3D io_tmp;
> > +		} else {
> > +			io_tmp =3D pcim_iomap_region(pdev, 2,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[2] =3D io_tmp;
> > +
> > +			io_tmp =3D pcim_iomap_region(pdev, 3,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[3] =3D io_tmp;
> > +		}
> > +
>=20
> =C2=A0=C2=A0 Ugh... Why you couldn't keep using base (or just i * 2) and =
avoid
> such code duplication?

I mean, this would at least make it perfectly readable what's being
done.

I guess we could do something like this, maybe with a comment explining
what is going on:

for_each_set_bit(j, 0x3 << base, PCI_STD_NUM_BARS) {
	host->iomap[j] =3D pcim_iomap_region(pdev, j, drv_name);
	if (IS_ERR(host->iomap[j])) {
		rc =3D PTR_ERR(host->iomap[j]);
		break;
	}
}

if (rc) {
	dev_warn(gdev,


Unless you've got a better idea?

Tell me which version you'd prefer.

>=20
> [...]
> > diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> > index abe64b5f83cf..8a17df73412e 100644
> > --- a/drivers/ata/pata_sil680.c
> > +++ b/drivers/ata/pata_sil680.c
> > @@ -360,15 +360,16 @@ static int sil680_init_one(struct pci_dev
> > *pdev, const struct pci_device_id *id)
> > =C2=A0	/* Try to acquire MMIO resources and fallback to PIO if
> > =C2=A0	 * that fails
> > =C2=A0	 */
> > -	rc =3D pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR,
> > DRV_NAME);
> > -	if (rc)
> > +	mmio_base =3D pcim_iomap_region(pdev, SIL680_MMIO_BAR,
> > DRV_NAME);
> > +	if (IS_ERR(mmio_base)) {
> > +		rc =3D PTR_ERR(mmio_base);
> =C2=A0=C2=A0		goto use_ioports;
>=20
> =C2=A0=C2=A0 The code under that label ignores rc, no?
>=20
> [...]
> > diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> > index a482741eb181..d115f6f66974 100644
> > --- a/drivers/ata/sata_sx4.c
> > +++ b/drivers/ata/sata_sx4.c
> > @@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev
> > *pdev,
> > =C2=A0	struct ata_host *host;
> > =C2=A0	struct pdc_host_priv *hpriv;
> > =C2=A0	int i, rc;
> > +	void __iomem *io_tmp;
>=20
> =C2=A0=C2=A0 I'd suggest to call it base or s/th...
>=20
> [...]
> > diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> > index 57cbf2cef618..73b78834fa3f 100644
> > --- a/drivers/ata/sata_via.c
> > +++ b/drivers/ata/sata_via.c
> > @@ -457,6 +457,7 @@ static int vt6420_prepare_host(struct pci_dev
> > *pdev, struct ata_host **r_host)
> > =C2=A0{
> > =C2=A0	const struct ata_port_info *ppi[] =3D { &vt6420_port_info,
> > NULL };
> > =C2=A0	struct ata_host *host;
> > +	void __iomem *iomem;
>=20
> =C2=A0=C2=A0 Call it base, maybe?
>=20
> [...]
> > @@ -486,6 +488,7 @@ static int vt6421_prepare_host(struct pci_dev
> > *pdev, struct ata_host **r_host)
> > =C2=A0	const struct ata_port_info *ppi[] =3D
> > =C2=A0		{ &vt6421_sport_info, &vt6421_sport_info,
> > &vt6421_pport_info };
> > =C2=A0	struct ata_host *host;
> > +	void __iomem *iomem;
>=20
> =C2=A0=C2=A0 Here as well...

ACK, will provide better naming in v2.


Regards,
P.


>=20
> [...]
>=20
> MBR, Sergey
>=20


