Return-Path: <linux-kernel+bounces-283574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA594F67E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A741F24991
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537D189BA2;
	Mon, 12 Aug 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E09VxtXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23416EB7A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486578; cv=none; b=jdQZzIGUWve2rwxWRmLN/Q5W+0MRCNkc4Ue0Sj5q59jwHQIVHCqbe/yLkO0oB7hChFdXVdFpxUoVE8ZFt8/5yoSgbMQcwa3iatUjrE8OAg7pKfEpbAGxM6TE1DAgOsDe5X2AeLiNHPi+9sp3b4vVQqwMZiuMleI6Ma+do3FHaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486578; c=relaxed/simple;
	bh=w4mmnkbUQyC+3Ff/oXNqR2TgwvhhjDG3ND1sxdUTW2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DaH2GSYAoycCpoDlBkGKFFJ7F1teHmxIGi66k+Gz/gGfm0F2B6W9AK/I0DRdlGFeLAkXBHnz4fhP6eVHAkmfE83V0XyCRhVNdeS4NbuahlPl1wpx/0xDsL/O0jB3cuw7qSs9rArgL4Zgz3WAZzz5TsmUJ5QqNKyPCuOvvCxB5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E09VxtXW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdkF0C2zVbB066Bu4nbcfORzCEZVZFrzFyLmGHaFIHU=;
	b=E09VxtXWVAlUB18WkHRbP/FP0ma+0aOoOOI1OmVKxwyXbaAXJ1iXQxFD7JGHa06LcGkiQX
	Wtd+TjsPxfd9rmL6FhJMVIosZuuohW/E34D8DxGiWS2kixszbkvWDVuZQ5+xkgCFpsy4dN
	Xwnh2E5kl41Kfq1apl9XqOBcClgp9vM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-YjE62a6VNmeLalEc4yy2DA-1; Mon, 12 Aug 2024 14:16:11 -0400
X-MC-Unique: YjE62a6VNmeLalEc4yy2DA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so8923255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486570; x=1724091370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdkF0C2zVbB066Bu4nbcfORzCEZVZFrzFyLmGHaFIHU=;
        b=HJssXIvPkfkBanGeqJLN05a4XHn0pqG1rHExQQ0an72XEI30zkJdVzNp6jCo5ioPTY
         UoMS9GdyrXe3nUny0wpyJePD7dBsJ/i7VN2CFxAfJO5e3feUs32KEI1v/w82a9QQhr0E
         cXSkJc5V77OiF0rEEqTBGqsy/Qrje2XRcGTUIARhPRwrtC+JTFLqKKsaMMPro19o4/Um
         N451JTquuPyK4lNp+m3QJx1d7D4+UI4hlTA2WWUK4Kz67Xq+LQ/I6bFoQeZZ4/c3IAIX
         CEzT/P2lKzo+lPAqCdNcbyJxyKaIKFLh2CdOpZgbkD/Gu1vyTMdcF2Gi4XLNqsj02X+g
         8cBg==
X-Forwarded-Encrypted: i=1; AJvYcCW8uohE0HTvTBIUti+8JLgDTOvL65YjF4fUc/AX0Xwr+xVAZaw7ltL+Y+qOYFxkvYFPx7vBVvTKdXeP/cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLz2NznhpQZgH6LNVbV1fRSRvZHHIQ9H49XW/KhMTsLwdEGiD
	8qjNwHK8a8EXiiOvZlPeBi2sgWeifoNB5dDQMkv4C7dlJlnmnvsmCGS0VkGH+NhgAu6cWzcpfgy
	biHx4jGCLocNc9Ywr9RoxNBCKy3wZHOyxWvK/U4UVjF/v+e+UdGrBrfuOKuSScVwu24hbdg==
X-Received: by 2002:a05:6000:1f89:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-3716ccd6d04mr588785f8f.2.1723486570225;
        Mon, 12 Aug 2024 11:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4syqNza/9kyyQE6dwwthidXy5tZvgm37dWORCESuvttYgk7Yi7KbYqY7kGz7zl7a7deUuQ==
X-Received: by 2002:a05:6000:1f89:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-3716ccd6d04mr588770f8f.2.1723486569679;
        Mon, 12 Aug 2024 11:16:09 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d02:8a00:2d28:15cf:9c1d:ae3d? (200116b82d028a002d2815cf9c1dae3d.dip.versatel-1u1.de. [2001:16b8:2d02:8a00:2d28:15cf:9c1d:ae3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750393asm111238125e9.1.2024.08.12.11.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:16:09 -0700 (PDT)
Message-ID: <70a70c74be9ba1a6ae6297ac646fa82600d9296c.camel@redhat.com>
Subject: Re: [PATCH v2 04/10] crypto: marvell - replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org
Date: Mon, 12 Aug 2024 20:16:07 +0200
In-Reply-To: <Zrow42L9dYC6tSZr@smile.fi.intel.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
	 <20240805080150.9739-6-pstanner@redhat.com>
	 <Zrow42L9dYC6tSZr@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Yo Andy!

On Mon, 2024-08-12 at 18:57 +0300, Andy Shevchenko wrote:
> (Reduced Cc list a lot)
>=20
> On Mon, Aug 05, 2024 at 10:01:31AM +0200, Philipp Stanner wrote:
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions()
>=20
> Missing period at the end.

ACK

>=20
> ...
>=20
> > - /* Map PF's configuration registers */
> > - err =3D pcim_iomap_regions_request_all(pdev, 1 <<
> > PCI_PF_REG_BAR_NUM,
> > - =C2=A0=C2=A0=C2=A0=C2=A0 OTX2_CPT_DRV_NAME);
> > + err =3D pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
> > =C2=A0 if (err) {
> > - dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
> > + dev_err(dev, "Couldn't request PCI resources 0x%x\n", err);
> > =C2=A0 goto clear_drvdata;
> > =C2=A0 }
>=20
> I haven't looked at the implementation differences of those two, but
> would it
> be really an equivalent change now?

Well, if I weren't convinced that it's 100% equivalent I weren't
posting it :)

pcim_iomap_regions_request_all() already uses
pcim_request_all_regions() internally.

The lines you quote here are not equivalent to the old version, but in
combination with the following lines the functionality is identical:
   1. Request all regions
   2. ioremap BAR OTX2_CPT_BAR_NUM

>=20
> Note, the resource may be requested, OR mapped, OR both.

Negative, that is not how pcim_iomap_regions_request_all() works. That
overengineered function requests *all* PCI BARs and ioremap()s those
specified in the bit mask.

If you don't set a bit, you'll request all regions and ioremap() none.
However you choose to use it, it will always request all regions and
map between 0 and PCI_STD_NUM_BARS.


> In accordance with the
> naming above I assume that this is not equivalent change with
> potential
> breakages.

The nasty thing of us in PCI is that you more or less already use the
code above anyways, because in v6.11 I reworked most of
drivers/pci/devres.c, so pcim_iomap_regions_request_all() uses both
pcim_request_all_regions() and pcim_iomap() in precisely that order
already.

The only hypothetical breakages which are not already in v6.11 anyways
I could imagine are:
 * Someone complaining about changed error codes in case of failure
 * Someone racing between the calls to pcim_request_all_regions() and
   pcim_iomap(). But that's why the region request is actually there in
   the first place, to block off drivers competing for the same
   resource. And AFAIU probe() functions don't race anyways.

Anything I might have overlooked?

P.

>=20
>=20
> > - cptpf->reg_base =3D pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> > + /* Map PF's configuration registers */
> > + cptpf->reg_base =3D pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
> > + if (!cptpf->reg_base) {
> > + err =3D -ENOMEM;
> > + dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", err);
> > + goto clear_drvdata;
> > + }
>=20
> (Yes, I see this).
>=20
> ...
>=20
> > --- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> > +++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
>=20
> Ditto. here.
>=20


