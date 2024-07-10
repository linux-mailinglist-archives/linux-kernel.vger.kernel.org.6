Return-Path: <linux-kernel+bounces-247316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5992CDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF321F254DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA3A18FC6D;
	Wed, 10 Jul 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HQjvGWke"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C818FA3B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602496; cv=none; b=BQPuIEm+1h9vLBzyA9N8Nwu/QwJg6qmPyNUHINHlQGp+J4Sv5TnQ+RlnpjKpS5GRKms/IhLZsWTSak+xMZn1Lvi8M0pjoGfYPW+oYJ+qThBcqONIxXrtLsQ7SJci7yyM1e7liow18+8X8nwG9kZ+0GkQfh1AfVf1u+vZnNuqGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602496; c=relaxed/simple;
	bh=UlSl0HAEebBFXQlGSCLVIn9K+rknP/hIF7FgNfDWwWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCTyPcRTvwwhVrBKcmfRXH5zWHH5fvvEIN7xQupIoyHa2nBSPTWEH72stTDQEVi6VOdcEmSZYyBRm5tPZQei9+gPYywl/TwPj5/J4e23JZbE9h/DoCP9GZzK9d9HdWoWuzHAQxbw3JafYNZmB7Hlk7FNVjbsdm6uuQYQLfJ4Rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HQjvGWke; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so6347512e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720602493; x=1721207293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sLrx/J40c0JtCbA7H8idsHcqtxfKzn8Nkzqc4M0cE7Q=;
        b=HQjvGWkeZB5izCWmIY4xywTKm1l7HT3unRBW2ViSfV2MbMwfD7sfMzO2OqYY7EDBvQ
         blDYuK2ydmRs9weoUPY3ltQxuJpOuqyB5KMpFUKrclJqcM6fv+zkiDHDLAejjVSJIq0/
         MxOYO2yZnxVaMgiewgNZD3a34f9q0eR1VFTBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602493; x=1721207293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLrx/J40c0JtCbA7H8idsHcqtxfKzn8Nkzqc4M0cE7Q=;
        b=QjIWWVWeiCb2kU1uXys7dvwqwQnLCxEpmXntg4dSt7OsIGlcMSRrnFlOlZtN4iH9jZ
         IfzOzekynfb4Vf3O0ySIiIxn1dR0v21MR1qDIol3hjcpBrIuPqlWuqgcRpgSbGNruaW9
         YodVtfQUmI/orNeBlJbEMnEKPKK0bfWGUz5IP+4JeC8yxbyXh7oWkYFJIhFDzgkrBvVC
         ItGlS0KwdtZ9k/rd2ueQM9cy0c6EmCXqGXcojPnO2Sof1nk5GvVM4ICbZ4FprspiHgHO
         Y8QSCyFYUTLj76Q/G51BXWrPXGqvPVUOV4z+5an8GqldC6t+QrfSU/ggwOYByzx+glQM
         44Sw==
X-Forwarded-Encrypted: i=1; AJvYcCULpDiWqCZfVnWHsYE9uoMMKL1LmbSR4woAhzdJD8QWVQ0KhxnXjM0LaWiNOEaOwbCjrTDHVMtkhZIAxcX3hpm+KV+VHUVzjf4i9tll
X-Gm-Message-State: AOJu0YyDEQE50Z2TrOzh8LvwHFv1TdAP4bHTDgGLlST4wV4euh4BFXZZ
	v5Ol4B7DfHoYlD7H0WxtLk5rY/iz/fHQElM9JE5xUdZLwC+jhvVjvBk2WKcFpqNPIHO6CqJmhpb
	kf8Tjxm6IJu4GVH0a/6l7hN2zsFAN/fMsL6hq
X-Google-Smtp-Source: AGHT+IEQTXm0HJ4WyEIpLTqj+IqmKduMB5XnrsejyyE++fUZgd6Enri3IldLNZW684Al8d1jT6PAKTeBzO8XeAU6Cig=
X-Received: by 2002:a05:6512:b1d:b0:52c:952a:67da with SMTP id
 2adb3069b0e04-52eb99d4aeemr3566077e87.55.1720602492657; Wed, 10 Jul 2024
 02:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710075127.2274582-1-schalla@marvell.com> <20240710075127.2274582-5-schalla@marvell.com>
In-Reply-To: <20240710075127.2274582-5-schalla@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 10 Jul 2024 14:38:00 +0530
Message-ID: <CAH-L+nOJjwbdvyi5ReBUyPKbMO4JRitF1vdjdavEZcSxZuXuzQ@mail.gmail.com>
Subject: Re: [PATCH net,v2,4/5] octeontx2-af: fix issue with IPv6 ext match
 for RSS
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com, 
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com, 
	ndabilpuram@marvell.com, Kiran Kumar K <kirankumark@marvell.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000662906061ce0fca4"

--000000000000662906061ce0fca4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:24=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> From: Kiran Kumar K <kirankumark@marvell.com>
>
> While performing RSS based on IPv6, extension ltype
> is not being considered. This will be problem for
> fragmented packets or packets with extension header.
> Adding changes to match IPv6 ext header along with IPv6
> ltype.
>
> Fixes: 41a7aa7b800d ("octeontx2-af: NIX Rx flowkey configuration for RSS"=
)
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>

Thanks for making the change. LGTM
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 00af8888e329..19fe3ed5c0ee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -3864,6 +3864,9 @@ static int get_flowkey_alg_idx(struct nix_hw *nix_h=
w, u32 flow_cfg)
>         return -ERANGE;
>  }
>
> +/* Mask to match ipv6(NPC_LT_LC_IP6) and ipv6 ext(NPC_LT_LC_IP6_EXT) */
> +#define NPC_LT_LC_IP6_MATCH_MSK ((~(NPC_LT_LC_IP6 ^ NPC_LT_LC_IP6_EXT)) =
& 0xf)
> +
>  static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_c=
fg)
>  {
>         int idx, nr_field, key_off, field_marker, keyoff_marker;
> @@ -3990,7 +3993,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey=
_alg *alg, u32 flow_cfg)
>                                         field->bytesm1 =3D 15; /* DIP,16 =
bytes */
>                                 }
>                         }
> -                       field->ltype_mask =3D 0xF; /* Match only IPv6 */
> +                       field->ltype_mask =3D NPC_LT_LC_IP6_MATCH_MSK;
>                         break;
>                 case NIX_FLOW_KEY_TYPE_TCP:
>                 case NIX_FLOW_KEY_TYPE_UDP:
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--000000000000662906061ce0fca4
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
AQkEMSIEIEf0r281IewbDuHqKvbUfvAVfQLCbadTkS8IP2utEcg9MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMDA5MDgxM1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBztzjSqxyH
dfbALrmEIz+sISVsQZVQSje5rqKXlW7AmEHkl4LA8LpmGz52PU33pjdAfQM00dUMSvTg2Z8tC80Z
0TsoXK60uDsny8CnQSycLUIWN81uzf825RmaUnIkWj2J++PjxnX1BTbu/LWJnuMTR5rJyImmFrM5
V2sEGeydhlXDvuP0nmipDDgC0lxRkLdLK3q/6UTtk2Ttxa4PPOM6dU0clTSy/COKSeCYwbYoIbLR
oAiP63fiOJcSrwVVDhLV0wSyqtfYEWF3LCcKEcv9sEqdwc0UkAkdEGPbmUAbvfAZUh9gK96/kkur
mrd5EA5Dsr3/spDAJWReFEJwpris
--000000000000662906061ce0fca4--

