Return-Path: <linux-kernel+bounces-322690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6E972C56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A551F25782
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10F1862BD;
	Tue, 10 Sep 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JdkJ2CDj"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40251850A4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957594; cv=none; b=lXgjO1tA7133h9ny/4iCiRSm8rMgJhz2feH5tT40lw3QG+dRIn9G4bouVvxhO5i6Dsiotp4GkXHPz5sHOBFGOtMWHftsfSlAQSygIonvACvb3sbM/M/PRUR5SDewCo6azUnWiLwqdHLvaS7RSXqbHqYwsWIi6dHxido1I5zUlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957594; c=relaxed/simple;
	bh=7xdQmMSKYrDJGbSskn3dT6TqNR1sxSKKi82ysDHcBc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEp3Ylwm6jJX9xu7WPAzIIofo/6WOe2FlRChyXQYrIhq39Dwb7SFzKCyjDpCfIRiIKoAmo0zK710z8cE5kndRGUEeFy0hFuwnC/JLKJbPZ42aeWMsOaFvrx0g4sc4OfW3zbubhJGEYiwDQvvCoZ9C0TSfUQWCvLi+fQdMc9czGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JdkJ2CDj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so452201e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725957591; x=1726562391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmtz3T09OLu5bu2ryKlZnUyo7sEVsIlO2XJBha3NoJM=;
        b=JdkJ2CDjFfOPewpwiHYdCG0erZ+keAFrR2i2C3v1gPOqe1Q+iDsTNKIqROl3/lRUTb
         2MaoWfsqcfrJfYOavkc+uwBgDPi24g5img9nVreUOZR2Zv2x9WSyk6ljpfo9R4To0o2o
         D7gIB4Vho/SViRkRFeJKycAlGYR7n8kkKulvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957591; x=1726562391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmtz3T09OLu5bu2ryKlZnUyo7sEVsIlO2XJBha3NoJM=;
        b=SK7aSYQZtN1KZyi+oC/UgDEZx6EHv3Oa9hEmn6C93hGtbroeyRVKsq5Dxtgnw7DBvK
         C7QqvAho+7RCIrwABV9tOPtQeeJscw14OxhsOPPpwIFftaPc0q1CbG9XJKNCnf6N/wGj
         3g2DtN/fk/2EfWgrP2aL98D8lfac7CObMYV7AW0rdDXWTK84CaU+161z9kIPthNxsEr+
         m/56tsembcBMOkBsXDuPOyKNquOtkPyNK13n0kL4KI3bn30gHV5PQ6AaTO5qhhd+AxKe
         4Sf4jMMb0022IL2bAexJwdwhsTeyiPFEYwPlTrkk+zd/lDJ1j13Dk6mYdVPE4+5kniRA
         hh4w==
X-Forwarded-Encrypted: i=1; AJvYcCXi6I0SlVbpzFIh+9zQyZ/OABkY1CMU/7YTsAnmDgO+fthaFp6PO3aGwHX4a8SaHkZSonXjXfWEruNrImA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0HUg8aveUIWcH7GhzNJ224fAU3hHgseb0sr8ONl/zXl2HQ2e
	Ycv7BeKPtJPa5zaT2xXz3bAL3RZftURPkKp8HtPMW+S5Oa4dAHnvAZ7dk/PtjhFOiz8PUdRyIvp
	r6meZzQVcOl5DDN8yZ35IQGGhXOUQe1Y8dpTD
X-Google-Smtp-Source: AGHT+IEz+kYsGxbleMYs9U1Tm9Et7mOJ/LfxNeo0wDfSU4TSao91FeAyZODetK1syzh0EUEKilqIFvFIkepFbASRebI=
X-Received: by 2002:a05:6512:3ba5:b0:533:901:e455 with SMTP id
 2adb3069b0e04-536587a545emr9944947e87.2.1725957590451; Tue, 10 Sep 2024
 01:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910075942.1270054-1-shaojijie@huawei.com> <20240910075942.1270054-12-shaojijie@huawei.com>
In-Reply-To: <20240910075942.1270054-12-shaojijie@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Sep 2024 14:09:37 +0530
Message-ID: <CAH-L+nP2oy4Haw1+8Jy3GGgphxBii8m2zD03FXbC0SeR7QdhQg@mail.gmail.com>
Subject: Re: [PATCH V9 net-next 11/11] net: add ndo_validate_addr check in dev_set_mac_address
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, sudongming1@huawei.com, 
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com, 
	andrew@lunn.ch, jdamato@fastly.com, horms@kernel.org, 
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, 
	salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001f0bb80621bfd1f9"

--0000000000001f0bb80621bfd1f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 1:36=E2=80=AFPM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
> If driver implements ndo_validate_addr,
> core should check the mac address before ndo_set_mac_address.
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> ChangeLog:
> v2 -> v3:
>   - Use ndo_validate_addr() instead of is_valid_ether_addr()
>     in dev_set_mac_address(), suggested by Jakub and Andrew.
>   v2: https://lore.kernel.org/all/20240820140154.137876-1-shaojijie@huawe=
i.com/
> ---
>  net/core/dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 22c3f14d9287..00e0f473ed44 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9087,6 +9087,11 @@ int dev_set_mac_address(struct net_device *dev, st=
ruct sockaddr *sa,
>                 return -EOPNOTSUPP;
>         if (sa->sa_family !=3D dev->type)
>                 return -EINVAL;
> +       if (ops->ndo_validate_addr) {
> +               err =3D ops->ndo_validate_addr(dev);
> +               if (err)
> +                       return err;
> +       }
[Kalesh] It would be better to move this code after
netif_device_present() check. Minor nit and there will not be any
functional impact.
>         if (!netif_device_present(dev))
>                 return -ENODEV;
>         err =3D dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
> --
> 2.33.0
>


--=20
Regards,
Kalesh A P

--0000000000001f0bb80621bfd1f9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIGcMoCdaYZXw4bvU6qTtha0BuX6T1sJeMFssmQjZ01xIMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxMDA4Mzk1MVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAw99v102zF
ScJy8QrlAwGDpkis9sfLy/+jymzWvcMX+DLMIGtrKF/ioAElz05lflFv+cq3F2gnQz5X1ZW1aJ48
AiaJGvsUwRNsqq9zjhh+2r9hwAbSSo0pay9QN49r22gOKvtDpUVciKg6bt/u6RW5Sh5vV4KYxLB2
OKAr9EzF/8K2eiiGpbrEIptTPWps77Lk/gMjGg6pEwJFw8v1M2+sOayoG5NVrLjuVonTXelOUWdW
cqwpP/Jw11GzUZ7hmcxS2et8jLtnMSWab1wX3z1k/mh7nUgHim8l/nCo6gCZOdoQZhDlEL+gfFFG
M1CVBgI6/PZYmDvc0mn7j4vfDe+M
--0000000000001f0bb80621bfd1f9--

