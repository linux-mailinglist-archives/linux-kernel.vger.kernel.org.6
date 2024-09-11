Return-Path: <linux-kernel+bounces-325219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8A975657
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0160C1C20B05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEEC1A2633;
	Wed, 11 Sep 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QlrV6BCH"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D162C859
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066965; cv=none; b=tqRhZZIEk/COw5FfgI6XeDBkve0+d5dm+KPemee0TmAZN6gL8bsPlSKCVrR4sG9DY3WzFMGtwIPfmTh/TN9FKtRkoWQFMIl86AIDgjH3RcKn9XmY0biC4Y7vNbZbCAvU1MTp9Shb5jcLfBos9URFii2gOXC8d+oL83aOJBynSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066965; c=relaxed/simple;
	bh=Dy9LwFOsH9nhkKTnNbj10qJbprEog7frPZoauzSw/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJaF99KggA8zxPiMdBJ83ie6wKaO3lSYf4oZMhzDiLPFPWQS6MzM15zwkha3ZdEJVyBQ2auo0xGZQMJSJuIVWmzS7zm9J8Hfx6Q0514TGZ63ZVYmc8Di8Z3TEcfndkDvpkjmGbaC0oPskiozHSawodJJ1gviNJNthGtJUE78RTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QlrV6BCH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so6629096e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726066961; x=1726671761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9a5K4OiECRS+CdwJR1Rcer2J5XTp67mRx69lc26KkUc=;
        b=QlrV6BCHGIex7TBTyunK9KYJQMT+KKrQZ8kH+6xrFGBF4dbAtET1fvBU9ZQTip9EqF
         m37QsMac0LV/JiP0f56tCiSwKylqIrrG6exkdkk5TDiwbg+FZxyLT4c/elhaumILUvf2
         0/BNBnfZUx+ovV0lHT+ymxsN4aAN/oVYx8Q20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066961; x=1726671761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a5K4OiECRS+CdwJR1Rcer2J5XTp67mRx69lc26KkUc=;
        b=Kmx8CMP6URu4dl6QJmYI7HV+T+IA4pMJvFSx72i2xSVUJ6G3gND5zhJzFLrolajEjP
         /rWp8njkqg9Msijdd2Y6jb2ZoYt8jrwYCN/qksnHqGefBvCKH5/U7aHxmQLUofDMi0Ho
         FFRonySmS2b10IUzs1BY7uiCjYReyN6iS5ePtZuc1qsj9M8hZ0CoTPpx2He9zturcwMi
         NDTALFIaoYEthmTe5fBLKJm2bsrv/UJhMvcc5YYswgOpnoi2JSXqCN9b3qu84/NPrhYD
         MyjPN1ysbLNxiwEx1JayQaK5mwkJTU0zNH4D8xnqG/ZGBIwo9ooUZOfWEchy9+9ibNB5
         Mkug==
X-Forwarded-Encrypted: i=1; AJvYcCWgjDgTjgs4dttg21C+yR6BiHuroUObScJBI00Wvs1N1INhBBobMVQLDWUlNmWOLTBe0WYniI+oeC0QLtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywno1QFhjOYe/v7NQcBolkTr2hs0lrwNVDroOKl8d2LIxWGVqd5
	WxgViU4JLSw61N5UwXZyNa8kGewOcPNS06Dg+hK3zDEjBWxr/BuNbFMPnTie6S8jOTURMZQD5xK
	MZeu6MCQC2bZ28jjJGnNaDOYpeEOlsFH/uczN
X-Google-Smtp-Source: AGHT+IG69oXhiGRrIX2XRCejYiL7y4otoQq5gBo4fl++x9WJ791bNJ/nrsBjC2Y5+zYrlSwBbIXRimnVIodByXwad6Q=
X-Received: by 2002:a05:6512:3503:b0:52e:be2c:4b05 with SMTP id
 2adb3069b0e04-536587abebbmr12920894e87.21.1726066960509; Wed, 11 Sep 2024
 08:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911025058.51588-1-qianqiang.liu@163.com> <20240911134436.GA628842@bhelgaas>
 <ZuGhcdPGCjhQKiii@iZbp1asjb3cy8ks0srf007Z>
In-Reply-To: <ZuGhcdPGCjhQKiii@iZbp1asjb3cy8ks0srf007Z>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 11 Sep 2024 11:02:28 -0400
Message-ID: <CA+-6iNw4TiKtH4OWiAHpGC1KK_R3bkBQoBqxdNF2oh1vDrh8fA@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Fix control flow issue
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	florian.fainelli@broadcom.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001fe6fd0621d94889"

--0000000000001fe6fd0621d94889
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 9:56=E2=80=AFAM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
>
> On Wed, Sep 11, 2024 at 08:44:36AM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 11, 2024 at 10:50:59AM +0800, Qianqiang Liu wrote:
> > > The type of "num_inbound_wins" is "u8", so the less-than-zero
> > > comparison of an unsigned value is never true.
> >
> > I think this was fixed slightly differently but with the same effect;
> > please check this to make sure:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/driver=
s/pci/controller/pcie-brcmstb.c?h=3Dcontroller/brcmstb#n1034
> >
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/cont=
roller/pcie-brcmstb.c
> > > index 55311dc47615..3e4572c3eeb1 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1090,9 +1090,11 @@ static int brcm_pcie_setup(struct brcm_pcie *p=
cie)
> > >     u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_=
MASK);
> > >     writel(tmp, base + PCIE_MISC_MISC_CTRL);
> > >
> > > -   num_inbound_wins =3D brcm_pcie_get_inbound_wins(pcie, inbound_win=
s);
> > > -   if (num_inbound_wins < 0)
> > > -           return num_inbound_wins;
> > > +   ret =3D brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   num_inbound_wins =3D (u8)ret;
> > >
> > >     set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
> > >
> > > --
> > > 2.39.2
> > >
>
> Yes, they have the same effect.

Qianqiang's fixup has the slight advantage of keeping the var a u8,
which is what a reviewer wanted in the first place.
I found it surprising that  "if (u8var < 0)" does not cause a compiler
warning, but it appears that W=3D1 does not include "-Wtype-limits".
That's no excuse for this mistake, of course :-(


Thanks and regards,
Jim Quinlan Broadcom STB/CM

>
> --
> Best,
> Qianqiang Liu
>

--0000000000001fe6fd0621d94889
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC5GCXO9IJYpWC9YYWpxwBLT0OOyF72
scE6MLR5NJLpWTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA5
MTExNTAyNDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAnTKHel56NJmtIArcn4NO8ojU7q4tQc9ysG3BQY7YzR3jk2+A
lSvxJ6krZGpTFEeV1aqdQQmtWwT/8D2nbcSyMXSVfXXU4RG7aXESZV0Gnea039ouEi2nQgSGJzsW
dgEJpqkUuzEqd3vLLsNVyCO14DoY1QmQP7CPvRXgU81lEZOnoOJpHXjsXhmSXpDgZN1M6prumwJj
XpzLscF6vG8WopmpqunfuBN5MLsaEQUK+W3aTc3PI6kw8j86AK8diLyjxkrUaRkwhrF7nZWNaler
mmyuhIEas1pCQQQ3RPSfBzzfA6R2q8QS1Z8FnAPWdWksrkAiTDrQhmsb4BdwrhxQtQ==
--0000000000001fe6fd0621d94889--

