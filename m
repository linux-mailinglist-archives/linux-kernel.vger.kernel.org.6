Return-Path: <linux-kernel+bounces-544504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290DA4E227
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC4617D017
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493125DD04;
	Tue,  4 Mar 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L2RxW0Cf"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6321D00D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099794; cv=none; b=VMyKKBBjIm9BnN3V/CUGXsCbkDRQSHkKbVnLIEyUGpHlHAAUPngNyFvog+UBYuoFVTOtB7HEfojsTdTi8BWj8XdWmN0dHWnNQUo5Krebz39z5SDsBZ5F2wDObcWIVPOqXZACHZ5YZOxzdCVOrRS13gpxaKNEXzGOzoQ4JN8jbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099794; c=relaxed/simple;
	bh=6D/LX+vmuGWYchdGVokuPGRV3A6I+tSAVw8LFztzQ2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrR2Z6MuSa9hjTZjCEsa5+9kuslRp1HogvFtKdCvslCh3WZc4jonQn54lPr0GXSQOPU9aGah47LNt8fNjmk4ZtC9dnoCO6gHX2kygtfbMmt856OIh6elPNx3sLzhPHxuGL5El3RPVGMnU+tCrORdi84OI54jirUhi+rCF46y5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L2RxW0Cf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bb184ab24so24589561fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741099791; x=1741704591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZbB4gSYcUpoIHnGOMl2cbKS/gp28ToCgg4gkA+JNs0=;
        b=L2RxW0CfbEoQ6Y8xN4kmGz2M037rYInxtH2pdMuXL93CPEsrSmQ/poMCabGVim7x9z
         Oo8lvzpHIzYLaNzqYGDE9Aqk7PDnXrnF45DNaNqiKGI4AdgsAykc3cBUUzN+N+FkjyLG
         xJmeFR3ANvucX3gJ1IRM2mmTnsbVVzrJ04A0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099791; x=1741704591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZbB4gSYcUpoIHnGOMl2cbKS/gp28ToCgg4gkA+JNs0=;
        b=ivMXboCWxAW90PVOmHG07QyLGWXL7QqS+5JLk94O7xJx7UvSFZ+WCfk1fLW6+USEWL
         DUWmWuTIK9OzDefMyOD8HOzWDtBxwRSUzwDE1E1DAH+IE9bpJH0980Vf/fXa9iH/GB6V
         QU9Amh16da99cYUbZ3cQ6A9eptpI/6Zkd+maH0F8WyO7FsWIzVCy5qcDyvZnCcTubZ5S
         iatJt5ecy05/exxTyR4VqjXEjA34J6VjTNAlF9i72rIrG3P9q8fedwYs0leXP53tl3t2
         RLy8h7//H89y/VZBP5MJsMXKSbmQ0Eup9QwiY+hz+A8bud1nqE1FXvcOxrj0RMBh8qRd
         lt0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjvL3OPfGAfy+50Czj8r6gzmrY1slH13GP2qQckc5uxMNv3x0cE8KcXojQzJGnNH92+ndIowiEPwdTA8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzgd+fz+bfDs8rwCCi34OL+7RhQUCI3Flqkxy8uFvbdwH/Rhwz
	lKoF5RzYkRef32YYJYgv4e6YHMdqyRO1BsbzA5wGBH/78AYd4jHPrn8HbDdMMyMYFxspP2qv8Ef
	7E0m7gsL4uEQq+KKXgRHEU+hSJN5ooCfX3nYN
X-Gm-Gg: ASbGncstfX/sweqF/7oDc4Dmyh6mmj8UbKaYit3Qpqxu6KYjwYFbyA+0Z//DEuYwRjo
	k25CvZz8V4dOj2kNgyL+SECSEZMUjkajJrWf6LA19dmYnw05I9d++bdXSAa8+y7bT7kTfq0MlSz
	25jCkVcod3WT3+lB23stFxHsNNQSI=
X-Google-Smtp-Source: AGHT+IHT8xHIWz+CS+B5AAIuL0QVtzKBELXi0oZfqO7wx4AboX3Wol6OSm8Jwyi5CLhlIV069PNfoKDRZJ75ye1NquU=
X-Received: by 2002:a2e:bc12:0:b0:30b:cd68:b6a9 with SMTP id
 38308e7fff4ca-30bcd68b99amr9825951fa.11.1741099790679; Tue, 04 Mar 2025
 06:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214173944.47506-5-james.quinlan@broadcom.com> <20250303184011.GA172021@bhelgaas>
In-Reply-To: <20250303184011.GA172021@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 4 Mar 2025 09:49:36 -0500
X-Gm-Features: AQ5f1JoZGguPAuGjSIp2xcULmnzh0Lid1o8GOqyc1c0urPUti-NPnDDD--wsp1M
Message-ID: <CA+-6iNwsCzf30a0vbgStqA+DCyBnk3bGwoXNv0UNYOThE1Us6Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000090c63c062f8562a3"

--00000000000090c63c062f8562a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 1:40=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> > If regulator_bulk_get() returns an error, no regulators are created and=
 we
> > need to set their number to zero.  If we do not do this and the PCIe
> > link-up fails, regulator_bulk_free() will be invoked and effect a panic=
.
> >
> > Also print out the error value, as we cannot return an error upwards as
> > Linux will WARN on an error from add_bus().
> >
> > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators =
from DT")
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index e0b20f58c604..56b49d3cae19 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
> >
> >               ret =3D regulator_bulk_get(dev, sr->num_supplies, sr->sup=
plies);
> >               if (ret) {
> > -                     dev_info(dev, "No regulators for downstream devic=
e\n");
> > +                     dev_info(dev, "Did not get regulators; err=3D%d\n=
", ret);
> > +                     pcie->sr =3D NULL;
>
> Is alloc_subdev_regulators() buying us something useful?  It seems
> like it would be simpler to have:
>
>   struct brcm_pcie {
>     ...
>     struct regulator_bulk_data supplies[3];
>     ...
>   };
>
> I think that's what most callers of devm_regulator_bulk_get() do.

Ack.

Jim Quinlan
Broadcom STB/CM
>
> >                       goto no_regulators;
> >               }
> >
> > --
> > 2.43.0
> >

--00000000000090c63c062f8562a3
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDtTiW3sw7DVcyKucvCWyYuM05ZktTK
vq5MxzAEF/qYhjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTAz
MDQxNDQ5NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAR4/n6oh2wRkMrA7ESlGO4iDG30e/MkKh0hzsae0ZYKGwh9Zg
ludz9cXFwVhxViBNp1I8assfeOeUTNhLI4F90Rw5BSouml7kxTUpjS/hPSWNpilaoNbEAtU68LIY
PJRMvsN1AR8/qW3npFb7jyeLMr3963Z/J7pbVtHXKA+AeF2eV7Sz2vIf/Q77lKobMWoPMNJwNPmW
7IGuWSEJkGjZw9hcEov6Cfb0xsSJoqOYjvM4SUcpDFvnsxXA+DdWgxsfcK3esGyk1YADxanrrBvc
jVrFl4K7teainGrikaSHaPOd7WGCx8VzYFTInRZeO3t3AeZAvr4bUzYclYHSPx0jrQ==
--00000000000090c63c062f8562a3--

