Return-Path: <linux-kernel+bounces-387109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979F9B4C08
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7BD28102D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AEC2071E1;
	Tue, 29 Oct 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NttamxeF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377C206E81
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211773; cv=none; b=L+N4FDmMPmGw3qpnW58neDX7Q9Pf/jzK4Efaqrjh+uKj7+CsRzk9dJkhUSNlMO+e7ftsTt1ctpI0JboUQHndAzKNbSE9sHcm3KmBIRArS4fD+9+RSaSykN6utcO6LHk6YSPGM3WyngV4zFKq6Q25yYS8Fa8HGX3U57RgSypo+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211773; c=relaxed/simple;
	bh=M+W2XTTR3kCOGxWhrowr9gB0FJc6922cKRJ/vFKn84k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reeO22Zyc8/T5BYbJgNdXNYM5yWFa+ID7oAGEE58HThDl7/Wmt77xu63/QppaztaGFUpcnLcZ+euiQg6F53goGaEUxWHJ0pEq9xLz7SzYOtBf9jhsdRrDQmvu7M6AAFmLVLXs9ohpBZfrYH+WNiG1M1VdKozsZIWwnBTgb/sD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NttamxeF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fbbadf83so7139327e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730211769; x=1730816569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8pdY0x5FudAMHuKTdQrCj0+8pxZtwIAbOzP6D9Tnp8=;
        b=NttamxeFa/jSE/+44zEPsisNtOi3O4fMsWLs1SBWaRC/yLvJEEaY2zdcdI2fh4bJw2
         o7KDfPqU6+i2QAt5wGQFpep2C9Y6Pq65xS/4x1vEcOvaT0NzWi9jpmnpOkLqtBCjOjT+
         eEJgYOwkMu3p3BXUXaufeaYWIW+ixocZ1HR78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211769; x=1730816569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8pdY0x5FudAMHuKTdQrCj0+8pxZtwIAbOzP6D9Tnp8=;
        b=e04fzZV05Vxpuh4qbHSKDotp05hFb8FO3X3RSMYxgLCXWJ+3PuSj36m75tgTZo669R
         k6P/Vtc37XNzWlp2US/TV/xVJHP2qDQhSfuVELrrcAnrhgyTOb+neYv2DCjg8ei0mFrC
         DQyIhIrW93U444jiA/3Rxxp36JN2+9cohVvEXqa9HWVWjAY6FZX03XgZ00XQTOgoAFJ5
         I3QXVsiTbCXC3bvmc0yirhEY1Yiw91x8GjHaKBrY/kXqlV3+r2Iv2suu8WL+lNcChWmu
         J5c/ze8KLQmtmUuJlWK+o/37yVLnLeN+EUTCQhtud2vLz9+/o/vbOX/6/FXT0yEkJ8yY
         2RsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzFMwjwyIQ+oLDWXqUfK035sICRQmRvRzA8wcyhbPn5MKEK5b/A53HNfPtcSwgFPQxDx3WeaZ7G2Q8eSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aXWIl9rHIXFwESkh3a4UqZGYZCdAfyzIuGLZs20rv0dn7H/y
	aaqLaeq1iDI/is7gXZArp7bAk8FU2jHbXe8qNaoDP05QLAu3cZa+BFgU+6/Rrq8vYqmvtXKOTuT
	fMfV8EsD2sEAo7xbjHkpJP8+gAVgl+wrRTVv+
X-Google-Smtp-Source: AGHT+IGkr8MjB0w2FKKulsb1mbM3Z3Ctxudp06iI9MsvkQnaBAbWdHvXahix1vs8y2CGjUjC7Y54/ZyntYRHfUgLtp4=
X-Received: by 2002:a05:6512:3baa:b0:53a:a26:5690 with SMTP id
 2adb3069b0e04-53b348e57d1mr5026278e87.34.1730211769047; Tue, 29 Oct 2024
 07:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018182247.41130-1-james.quinlan@broadcom.com>
 <20241018182247.41130-2-james.quinlan@broadcom.com> <20241021190334.GA953710-robh@kernel.org>
 <77d3a1a9-c22d-0fd3-5942-91b9a3d74a43@quicinc.com> <954d6c11-ab4e-485f-8152-94bf38625f9c@broadcom.com>
 <36ec01f4-c0fb-188e-06e9-10c7360a8ef0@quicinc.com>
In-Reply-To: <36ec01f4-c0fb-188e-06e9-10c7360a8ef0@quicinc.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 29 Oct 2024 10:22:36 -0400
Message-ID: <CA+-6iNx1SA9iiECS1O=cwkcu2KWcPvvB7Zvm7=SR3F5m9nv+fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e80cb606259e512e"

--000000000000e80cb606259e512e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:17=E2=80=AFAM Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 10/29/2024 12:21 AM, James Quinlan wrote:
> > On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
> >>
> >>
> >> On 10/22/2024 12:33 AM, Rob Herring wrote:
> >>> On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
> >>>> Support configuration of the GEN3 preset equalization settings, aka =
the
> >>>> Lane Equalization Control Register(s) of the Secondary PCI Express
> >>>> Extended Capability.  These registers are of type HwInit/RsvdP and
> >>>> typically set by FW.  In our case they are set by our RC host bridge
> >>>> driver using internal registers.
> >>>>
> >>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>>> ---
> >>>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12
> >>>> ++++++++++++
> >>>>   1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git
> >>>> a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>>> b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>>> index 0925c520195a..f965ad57f32f 100644
> >>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>>> @@ -104,6 +104,18 @@ properties:
> >>>>       minItems: 1
> >>>>       maxItems: 3
> >>>>   +  brcm,gen3-eq-presets:
> >>>> +    description: |
> >>>> +      A u16 array giving the GEN3 equilization presets, one for
> >>>> each lane.
> >>>> +      These values are destined for the 16bit registers known as th=
e
> >>>> +      Lane Equalization Control Register(s) of the Secondary PCI
> >>>> Express
> >>>> +      Extended Capability.  In the array, lane 0 is first term,
> >>>> lane 1 next,
> >>>> +      etc. The contents of the entries reflect what is necessary fo=
r
> >>>> +      the current board and SoC, and the details of each preset are
> >>>> +      described in Section 7.27.4 of the PCI base spec, Revision 3.=
0.
> >>>
> >>> If these are defined by the PCIe spec, then why is it Broadcom specif=
ic
> >>> property?
> > Yes, I will remove the "brcm," prefix.
> >>>
> >> Hi Rob,
> >>
> >> qcom pcie driver also needs to program these presets as you suggested
> >> this can go to common pci bridge binding.
> >>
> >> from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
> >> of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
> >> through P10) and where as data rates of 64.0 GT/s use different class =
of
> >> presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
> >> have optional preset hints (Table 4-24).
> >>
> >> And there is possibility that for each data rate we may require
> >> different preset configuration.
> >>
> >> Can we have a dt binding for each data rate of 16 byte array.
> >> like gen3-eq-preset array, gen4-eq-preset array etc.
> >
> > Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
> >
> > Keep in mind that this is an RFC; I have a backlog of commit submission=
s
> > before I can submit the code that uses this DT property.  If you
> > (Krishna) want to submit something now I'd be quite happy to go with
> > that.  I don't believe it is acceptable to submit a bindings commit w/o
> > code that uses it (if I'm incorrect I'll be glad to do a V2).
> >
> Hi Jim,
>
> I submitted a pull request for this. if you have any other suggestions
> or if we need to have any other details we can update this pull request.
> https://github.com/devicetree-org/dt-schema/pull/146


Hi Krishna,
Thanks for doing this.   However, why a u8 array?  The registers are
defined as u16 so it would be more natural to use a u16 array, each
entry giving
all of the data for a single lane.  In our implementation we read a
u16 and we write it to the register -- what advantage is there by
using a u8 array?

Also if there are 16 lanes, you will need 32 maxItems, correct?

Regards,
Jim Quinlan
Broadcom STB/CM
>
>
>
> - Krishna Chaitanya.
> > Regards,
> >
> > Jim Quinlan
> > Broadcom STB/CM
> >
> >>
> >> - Krishna Chaitanya
> >>>> +
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> >>>
> >>> minItems: 1
> >>> maxItems: 16
> >>>
> >>> Last I saw, you can only have up to 16 lanes.
> >>>
> >>> Rob
> >>>
> >

--000000000000e80cb606259e512e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbgYJKoZIhvcNAQcCoIIQXzCCEFsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3FMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU0wggQ1oAMCAQICDEjuN1Vuw+TT9V/ygzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE3MTNaFw0yNTA5MTAxMjE3MTNaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0ppbSBRdWlubGFuMSkwJwYJKoZIhvcNAQkB
FhpqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAKtQZbH0dDsCEixB9shqHxmN7R0Tywh2HUGagri/LzbKgXsvGH/LjKUjwFOQwFe4EIVds/0S
hNqJNn6Z/DzcMdIAfbMJ7juijAJCzZSg8m164K+7ipfhk7SFmnv71spEVlo7tr41/DT2HvUCo93M
7Hu+D3IWHBqIg9YYs3tZzxhxXKtJW6SH7jKRz1Y94pEYplGQLM+uuPCZaARbh+i0auVCQNnxgfQ/
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAuKOXNiFPpiYE8WQxF3MbvATJhip8A
4L6vprYRsg9/rDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDEw
MjkxNDIyNDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAfrhkbo3z47nJej8jCc0NqUGg4Xt/Ie8nqehSx9Nvvdg3ckNB
HemT8TY0zTrR/sX2NkoL3NaeCkkJzyewA90oWijlqrblPKsANP5T1sdQQUBqzX/bSH+8VHVGjQlb
CHMoogCPykZnAVNCyQUyBAvY3Ep+FE84PkEmvBvoi+KJUUgaSNmObeYng6GS4/1yyXH/5zwAosIc
PhFRyNOmuTAv8TX+yx44zKE4QyN3NEdqSD5NtB0VwdmSCZfi1Oa0aIna0QnkXd1cfi/al7nlnVMm
zLEncaWs3Sn1rikoC02PRYcup548pEGkaWRWf0142v7HXoQjHLZoQVBTkbjhF5b/kA==
--000000000000e80cb606259e512e--

