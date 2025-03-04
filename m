Return-Path: <linux-kernel+bounces-545215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A68A4EA65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9902189B316
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622D25F979;
	Tue,  4 Mar 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cNAyR/YF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD180250C16
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109862; cv=none; b=b9BYQPGDioq1MXX+HikdwonpPIorYcGPcOEWyOJOTkKdUhSDIEiWC/WjPQuSi2aZuKImKl/zt07PAeBfK6nb6FxPaSg3qt9F/Z6xzpo9SnMf6FofKCzHs1Mr1EdMOGZznihTKLsRTCdBKhQRt4Y4Ryx/PJxt9W3Ma/jTDf8V0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109862; c=relaxed/simple;
	bh=j6j6tiE/WYUHyo5PKNLw1bznqQzCJUGhG40tZtFrH2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja6NDlEgVbD2D7EOPEQ0pyqt7RPp1MeyYkP80mTPxACQi2FAecrI487XWMQR5AycXt5uV29TiW+wNrw0vEowb11Dy1xFAWcK7WK1AfX7XNwMqc5jZUvS4rQ7bRCw1SnLvoOVKKrzms39Fvy436hErReDE7LsE+n66wC0Q7BG54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cNAyR/YF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54955222959so4566457e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741109859; x=1741714659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WX13cw9J42HPhCCHD/kZkAZMxtGs4avLvTK5D0GGJb4=;
        b=cNAyR/YFfPQI8ZaBHm06OCb3vHxPffufudvBvs7Oh5Ankt30ZT2Pk0SQZTUZApKieR
         7yJDLkzFn98ZYwy6AEuYaSmmguSu3DaIGGtnmmssOmZ1hnSncfo40bmuR4AOykgfYmLH
         zwWL+2/Gnq4p+k22rHjaIGYTogU8aKODKiKpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109859; x=1741714659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WX13cw9J42HPhCCHD/kZkAZMxtGs4avLvTK5D0GGJb4=;
        b=LKD7eocqI8oLGgcsV/buA4cJjXCp9NPktaU1/KKwENwsTlo5zhg+n9rDQSO7YjJ2YS
         fy/FuouLH+8mH07zbxGxeMYJVK3s+1cgBajGwR9E0efYItZIEzpeOv7k3kIof3y1cOMn
         7Y56DjqysAKXKmIgfmMHtA8nU3xL3edZQ9ScAqx9E18iq05VUIIZaAkfHZjXi7/Upsi5
         sE3i9tnloMoPPYRGl1abYg1Oi2c7MxRh6APiYP6aqvD7pBG6V5jxUg9Utk/wFtNm8XVb
         5FW4l6sCy3qr078/zte5TzmezBin0dv0cf8Gwg8vg22nn9izdmeM6CEYJb/04fJ9KIM0
         dpag==
X-Forwarded-Encrypted: i=1; AJvYcCW3txxZCd13vcCKgp88IK9LUi1j6aBhhyUD5OIsU2ZqRWT8/RpXJVWYRoX2dB9WqVjTAfqA9fp1QqB3X6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVJr8BRmcm2oGx8jEGLjRDwieRFQXMehCbU8F1tz08TFWr/vg
	DOiaUF1py9hR3eKs652Wf+sfkf55l5tfjFtRAzaa+iXVnGZjDhmCx9J5gP6t5Pr4g0hlmMoqgkE
	tNFSSvkaRYjoHBlBR+FrrJdIyCJKnVoiHAO+G
X-Gm-Gg: ASbGncs5JbUkRQLGGAOAlN6dVxgOw/PIwK+vSySUD+uDvitPWnm7dhE1DSyl9s4d2GT
	Asms9YXxYokcLuetCrwrl/qKeUZs3r/DC2WOy1OL6cTUdVxN++0y8ptw3tYCed9R2VOchEb08vF
	8BB4ngqytKwbuIrkM6fObdh3Csa3Q=
X-Google-Smtp-Source: AGHT+IFCXZFFz0Qr9Bn+vPW76IXSgxIIcYhvmaG26JciGcJcXdooiPAyC0ue5u0m8xkWA6DxwQsGjXOac7XlagvPfZ8=
X-Received: by 2002:a05:6512:1597:b0:545:2c6a:ff6 with SMTP id
 2adb3069b0e04-5497d335f3bmr9845e87.16.1741109858860; Tue, 04 Mar 2025
 09:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com> <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
 <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com> <20250304165808.t46fh6fwpardheup@thinkpad>
In-Reply-To: <20250304165808.t46fh6fwpardheup@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 4 Mar 2025 12:37:26 -0500
X-Gm-Features: AQ5f1JoahOtxBk2AsgJoK_1V07TvIHoQEQtwyJ8TiLgA9gqQ9he3xCI95-EFxic
Message-ID: <CA+-6iNw2i=4KVr+VYOxacWpP7Pw0E5mDwKY1i9_6V_hjxu9neQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config
 space access
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ad30e9062f87ba84"

--000000000000ad30e9062f87ba84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:58=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Mar 04, 2025 at 11:37:14AM -0500, Jim Quinlan wrote:
> > On Tue, Mar 4, 2025 at 10:08=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 12:39:34PM -0500, Jim Quinlan wrote:
> > > > The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of th=
e
> > > > map_bus methods used these constants, the other used different cons=
tants.
> > > > Fortunately there was no problem because the SoCs that used the lat=
ter
> > > > map_bus method all had the same register constants.
> > > >
> > > > Remove the redundant constants and adjust the code to use them.  In
> > > > addition, update EXT_CFG_DATA to use the 4k-page based config space=
 access
> > > > system, which is what the second map_bus method was already using.
> > > >
> > >
> > > What is the effect of this change? Why is it required? Sounds like it=
 got
> > > sneaked in.
> >
> > Hello,
> > There is no functional difference with this commit -- the code will
> > behave the same.  A previous commit set up the "EXT_CFG_DATA" and
> > "EXT_CFG_INDEX" constants in the offset table but one of the map_bus()
> > methods did not use them, instead it relied on old generic #define
> > constants.  This commit uses them and gets rid of the old #defines.
> >
>
> My comment was about the change that modified the offset of EXT_CFG_DATA.=
 This
> was not justified properly.

Okay, got it.  You are referring to (for example)
-      [EXT_CFG_DATA]          =3D 0x9004,
+       [EXT_CFG_DATA]          =3D 0x8000,

We have two ways of accessing the config space: (1) by writing a full
index and reading a  designated register (0x9004) and (2) by writing
the index and then reading from a 4k register region (0x8000 +
offset).  We previously used (1).  An update was made to use (2) but
instead of updating EXT_CFG_DATA from 0x9004 to 0x8000,
PCIE_EXT_CFG_DATA (0x8000) was used by the code of one of the map_bus
methods.

This commit changes the code in the offending map_bus method to use
the offset table for (2) and updates the offset table EXT_CFG_DATA to
its proper value.

If you want me to expand the commit message with the above text I can do th=
at.

Regards,
Jim Quiinlan
Broadcom STB/CM

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--000000000000ad30e9062f87ba84
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
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDmf8zs2btLMj7lTZac0vsv+mqT2B2a
dcvRr35rLhZiSTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTAz
MDQxNzM3MzlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQBuUgpioFM3axEH1W05+trbr0KDB3oCbTZ3Kz+YkrblIVoScnq3Yo34zsPl+KdGdFRz
eBX97DfxTYEa9c6FyEHHW40sGq406YFtnfYSOf79coQml5TwlpzX2lY+HPkuAo+P+2x2n9ymCDaH
plnEaJLDSQq02ntMkAKHBVKyfXG3yWvv9MHMwryfBHu2HeRG7ClfD2doy1ezrI7h66ycvVlhSd5s
HeSzXLIPaGOemYi5WBkcjinapBC01Q0noF+a6OYsAYDgSMuy2+if6oBreCyyBIl+q6PlYTyXZeDw
ZQt4k9wdHLB8dHGWH2QWEORq25LUJGmyON4jltAcl1Spp2Ek
--000000000000ad30e9062f87ba84--

