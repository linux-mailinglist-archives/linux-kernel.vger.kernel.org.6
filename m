Return-Path: <linux-kernel+bounces-255214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C07933D89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E563C1C2188F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE71802AA;
	Wed, 17 Jul 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mw438NpL"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113991802B2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222462; cv=none; b=nVQRMJnjgLUNhsa5iztxL51wT3OXKOmeGL8qd98wsOZvNvsnEURQlXffmSI3tH8lnxoXglGo8Se0iSAYuqtMPqFaOJMVFV2xbfFA31XAPfnSHy8E2GxFDh31uX+VwEonj5MVSkhIl2DXHJ3vjFfjGOOJseCiVgyYdmBIeQF1fBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222462; c=relaxed/simple;
	bh=s9xnu2eRel19I+4OlZr5Dl0otmP24pROr/CDMj+5gSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+bPvkVUTHHh7RvQIo1fCgrlQ2ZZbnPu96TZKuqOpqXFEPP0mTpSCgmZ8trlVN4TK5/o8umnYxUs4xSOpRIbsXPjrlqxzTBal4p+kcbOaO4/5BSmk5FqvSS4+OSXgHuN0w2v/C4BA8aKYyfHSpNa5093r2ZvYeHIDzSh/oPYdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mw438NpL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so7497158e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721222458; x=1721827258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y6j0VJdrHWSeSUdASe2FHmSrYux+1IzNJt5S3ALUTE=;
        b=Mw438NpL3V5eUEawPcaNaRSTLW+mQINyjeBSQne/o01V1ozoXODKNjg5Mihxo5o9PW
         qnORTP48SE6Vln29CguNsfM3eZ5BafnpI+Q84rHyzeLcsK5jXBMJrYp0Q5Ht6kNOLYVs
         OKwnjxjkcg215QQhNR1zHLHScQVEohHR71Na8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222458; x=1721827258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y6j0VJdrHWSeSUdASe2FHmSrYux+1IzNJt5S3ALUTE=;
        b=jbL1iFE7OxDnEk3w6FaPICox+jGx9/EL6cDYE7x9DC7GC8t5I/dpOjZz+x4raNxhun
         3mg/LC+luriOAUdDiDy6CIJgj9u802BaCvgT0pyaPZYKmF3mgDFwZvKSlRpx9AixyzT6
         soFCzi1xHQ3qmuWtSUTaj920UZS0GipBb+VyViZ4zAgp9ndjqwE0VahIwgK2NRrqs/3A
         rZR2zlby7FNpixC6q+iIx5gOymguUZICD8vB0ZTI0W1WuUkbLEjBZAuJiDTCrYQuPdIc
         7fGt3XKNN9fsPKTTtpHGt+b6yHU5Qr7tAj7Cp2ucEGN25CQ79xOkgUfEHrbaggNBSyye
         LvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWckZ8aoOQKpgHipbD5eLicF7VfyKK03iKg4jjpg+o5ufxy+sFbUXi/CZvbxlBlsOOFRmqgb/luGFmdWclQB9fMOQm5uChoUcJsSYXe
X-Gm-Message-State: AOJu0YxD9LLbxzbxBY4/ZscpwhfkRizawunI5XP8OG3Bcgl8JYUy+aGx
	OPAl7Uo9q2p7IZUficJAtE+9zg/Vr1kdk+pUrexaP9nUooT0bJAUiPQy5BQZ7qee65rig4fyeUs
	ZAfnKzgEyLi9NewX2Le0g6I5epN8r5vZOWzkd
X-Google-Smtp-Source: AGHT+IGw07aGQMyH20Cg08i8dwwUzV0NWThSiIPvPyPALpbVw+jawTEYniJ9SRqqx3LMsYwTDJT3q16wnw9NG/XNLFU=
X-Received: by 2002:a05:6512:304f:b0:52c:def3:44b with SMTP id
 2adb3069b0e04-52ee53f5fbamr1148892e87.31.1721222457998; Wed, 17 Jul 2024
 06:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-2-james.quinlan@broadcom.com> <d20be2d3-4fdd-48ca-b73e-80e8157bd5b2@kernel.org>
In-Reply-To: <d20be2d3-4fdd-48ca-b73e-80e8157bd5b2@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 17 Jul 2024 09:20:45 -0400
Message-ID: <CA+-6iNwvShkUwgQ5iTqa53gX1RtOMcDACPOJtqKm6zWCXN6Rtg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: PCI: Cleanup of brcmstb YAML and
 add 7712 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000374d41061d7155cc"

--000000000000374d41061d7155cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:51=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 16/07/2024 23:31, Jim Quinlan wrote:
> > o Change order of the compatible strings to be alphabetical
> >
> > o Describe resets/reset-names before using them in rules
> >
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>

I'm sorry Krzysztof, but AFAICT I paid attention to all of your comments an=
d
tried to answer them as best as I could.  Please do not resort to a
form letter; if
you think I missed something(s) please oblige me and say what it is rather =
than
having  me search for something that you know and I do not.

>
> > o Add minItems/maxItems where needed.
> >
> > o Change maintainer: Nicolas has not been active for a while.  It also
> >   makes sense for a Broadcom employee to be the maintainer as many of t=
he
> >   details are privy to Broadcom.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 26 ++++++++++++++-----
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 11f8ea33240c..692f7ed7c98e 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Brcmstb PCIe Host Controller
> >
> >  maintainers:
> > -  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > +  - Jim Quinlan <james.quinlan@broadcom.com>
> >
> >  properties:
> >    compatible:
> > @@ -16,11 +16,11 @@ properties:
> >            - brcm,bcm2711-pcie # The Raspberry Pi 4
> >            - brcm,bcm4908-pcie
> >            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> > -          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> >            - brcm,bcm7216-pcie # Broadcom 7216 Arm
> > -          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> > +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> >            - brcm,bcm7425-pcie # Broadcom 7425 MIPs
> >            - brcm,bcm7435-pcie # Broadcom 7435 MIPs
> > +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> >
> >    reg:
> >      maxItems: 1
> > @@ -95,6 +95,18 @@ properties:
> >        minItems: 1
> >        maxItems: 3
> >
> > +  resets:
> > +    minItems: 1
> > +    items:
> > +      - description: reset for external PCIe PERST# signal # perst
> > +      - description: reset for phy reset calibration       # rescal
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    items:
> > +      - const: perst
> > +      - const: rescal
>
> There are no devices with two resets. Anyway, this does not match one of
> your variants which have first element as rescal.

The 4908 chip exclusively uses the "perst" reset, and the  7216 chip
exclusively uses the "rescal" reset.   The rest of the chips use zero
resets.   All together, there are two resets.

You are the one that wanted me to first list all resets at the top,
and refer to them by the conditional rules.

What am I missing here?

Regards,
Jim Quinlan
Broadcom STB/CM
>
> Best regards,
> Krzysztof
>

--000000000000374d41061d7155cc
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDbpvhRIJcG+QRFkfRqEOU5/rkIkS9Q
wufC6S0dhQvcpzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTcxMzIwNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAC1QfLGkC/xEg52wFD0fQ+JcjB+Vrgl2aImvvtNH9iZbtZ40n
ybqcvYghsXyEgbmLSwuHPElGbRdYe5AOQpB9X9Doj0aMK+Sfy0O3EK/hNBblGFvq5ocmdDyhyDZr
1EYdv3Qlb9cej6cEh8jfDeT0hhhbeM2MgbMT+0nmIJLs1s826syXlqRdDIGbPQ30JQdN8l978n2h
FUYsFqj9twRVDBvDSMwcbGJH5jsgU0dRGmvJWjQMDvkR7dJx8gtfUGvOJ0heaHLeVz4b/c/GfFmK
fC47bhtGQ35Hal85r3+9WgEfiVT2zuPhphi1hSYXjMFRU2svblnOx9LwcKcqfWiDBA==
--000000000000374d41061d7155cc--

