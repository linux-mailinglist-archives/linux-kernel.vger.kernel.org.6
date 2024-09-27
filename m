Return-Path: <linux-kernel+bounces-341262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00849987D64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857841F24043
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B41714D7;
	Fri, 27 Sep 2024 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UapLlHdS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C589443
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409501; cv=none; b=r9rXMv9k1VGJbvHY4mZJyHxUQwj65/dOQrPNcyk1U2dDKaP99FI5H6Gs0p7eA14qfQ5i4vqQ+4qfIDxlMAH1ANLUZ/KSJQ4gxdiTFT5MF7JFuMsh/ngacorjz7/eKqkf79fXD3l7M04mXOt9Yg4aIOWwux25nDx38qc6KbrHZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409501; c=relaxed/simple;
	bh=m2WjPx+omuCoeX43r0BzsGtdbTjjr2LOVSn8iTQk5OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5EKIC7dkbxvM0fZvcymvyReogrhQk+srlYZI0EVC5sBRfy/RU+ULRgruX5sV//nVFt98WswWqsJfuwh6LQ+e0y2xMGfQh30HidwF8HS6apwdmJT7LyWaNg/Y5w7rqZZlvM7jrOYz7OsrbY41DlPIVHyhO1o/BIbai57UIuv6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UapLlHdS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2dee9d86f4dso1487042a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727409498; x=1728014298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhL2VI4lcmrpbkcUw9CSLY6ddW6dBLnjaQ7YUSo8ylw=;
        b=UapLlHdSdobONFIeoZh0jXSKz4oZNZcprbqu8XVZzgw1Do5pI2dBcw9so+YMWu3XM/
         ObchY6USsnNrhjQANZaRbcam/PVdsauFpz5DHFKqZVy997+6syyzHHqt6DgEv0IDT7uc
         cx4hYjlujb7fAEdHSNDUuxWYyhHeiM0G5NAkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409498; x=1728014298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhL2VI4lcmrpbkcUw9CSLY6ddW6dBLnjaQ7YUSo8ylw=;
        b=jEc3WMB70qqZln/vgbSazAnK7GP221/W0E4j22FOEzUp6cnyvh1FQL9ifz4JyCc9xo
         ASoTIZ1MPMtagLlo1V2UxRhttTMkusY0oFKGVdsZcURjwmlxCqXQASIwpc9e46JRrfmZ
         bnIB3E23gkUphbTSRwbWFG1h/+RDhZNYrx4z6Tu1ohWJKfIJKCrJHdJIAtYxIAUmYg5+
         viPAbs/Ub/Ja1FIgZJPDtz2Xhdh+mOw2tbzjadvl5ThT0sRud+sgZKQ8TDdXwoI2RreV
         dwr5+F4Qiaqu0IP9fMAcu1vfSrvqg5z9r5o4DeDqtuIcaTvstoYlM6ouq4ZTrqv1rXzT
         PDJw==
X-Forwarded-Encrypted: i=1; AJvYcCUpJsaIG58AQrSUUtq8FkvYLOjJEJgJxbKylBBfgoPEZGRq9Tcnni5tZrK44SQZgSYJFcJlcr7yUl9dXCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElMwMdd0gsghFELzdznTIZK0yFhKCVQaZyyaWt1BI1r92C24d
	t9E+Hv6lc6P0wjbO1DRJeL3TlQfDoa5RJo5Sq7zLnBMg2O3OPZN3Puo9gXV43IU0DPygQXUd88q
	OjAqpFRg013K179le+jVjlUbunkhZZ7c1ZpHi
X-Google-Smtp-Source: AGHT+IFMcjux4lTfAVKMJb0r7MH5SQ/+gKRB6Aa2v+WySiXUU1lWt7pj6o1F1iKHWi3d00zoPQlKqZ5Btg9Wkn7khvA=
X-Received: by 2002:a17:90b:46d1:b0:2dd:4d3f:45ad with SMTP id
 98e67ed59e1d1-2e0b8ecafbbmr2132279a91.38.1727409497664; Thu, 26 Sep 2024
 20:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162048.16208-1-jdamato@fastly.com> <20240925162048.16208-2-jdamato@fastly.com>
In-Reply-To: <20240925162048.16208-2-jdamato@fastly.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 27 Sep 2024 09:28:05 +0530
Message-ID: <CALs4sv3K7Jz=ktXPefM+kAX+nmyDnJQhXafaBSCpyuap1FtaRA@mail.gmail.com>
Subject: Re: [RFC net-next v2 1/2] tg3: Link IRQs to NAPI instances
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000085e5b1062311dde4"

--00000000000085e5b1062311dde4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:51=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Link IRQs to NAPI instances with netif_napi_set_irq. This information
> can be queried with the netdev-genl API.
>
> Compare the output of /proc/interrupts for my tg3 device with the output =
of
> netdev-genl after applying this patch:
>
> $ cat /proc/interrupts | grep eth0 | cut -f1 --delimiter=3D':'
>  331
>  332
>  333
>  334
>  335
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json=3D'{"ifindex": 2}'
>
> [{'id': 149, 'ifindex': 2, 'irq': 335},
>  {'id': 148, 'ifindex': 2, 'irq': 334},
>  {'id': 147, 'ifindex': 2, 'irq': 333},
>  {'id': 146, 'ifindex': 2, 'irq': 332},
>  {'id': 145, 'ifindex': 2, 'irq': 331}]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 378815917741..ddf0bb65c929 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -7413,9 +7413,10 @@ static void tg3_napi_init(struct tg3 *tp)
>  {
>         int i;
>
> -       netif_napi_add(tp->dev, &tp->napi[0].napi, tg3_poll);
> -       for (i =3D 1; i < tp->irq_cnt; i++)
> -               netif_napi_add(tp->dev, &tp->napi[i].napi, tg3_poll_msix)=
;
> +       for (i =3D 0; i < tp->irq_cnt; i++) {
> +               netif_napi_add(tp->dev, &tp->napi[i].napi, i ? tg3_poll_m=
six : tg3_poll);
> +               netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec=
);
> +       }
>  }
>
>  static void tg3_napi_fini(struct tg3 *tp)
> --
> 2.25.1
>

Thank you. LGTM. You can use Reviewed-by: Pavan Chebbi
<pavan.chebbi@broadcom.com>

--00000000000085e5b1062311dde4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG4e8bXteYOtxFAWnZVfhYBwb1eS+qY6
DImcTK6k8nZBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDky
NzAzNTgxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA7b6retcSq7SUu0nHaiUI+c+I0hf/nEMVNX4kxG7BSRLEUYDIi
Zvb7CEpHZZR7JgikBnpfTWM3kz3Q9EAr1p+I8D9MgeE7pXdGPWEwEBXRchvhQwGIY2ZYXFX5e3s9
QOmD7jeLAb0SjHD/BNjYhDvKHK0uMZ82fdsS20/YN9WqEr1vuDF+9BsfJfZcpYXP/MZAD44oRZRI
ZNZLwcjVAPQPCqBhVkjmD5gKBVirosF6BrxtQYAs+B3fAUFcDkc1louSxThA3JERrqnK4K4PJJD4
0G3AmTtz5DxB7uyjKqImZbCBiPvNlXe0xN39/BuKzknuFFXehtk9wJS72N5tnrOL
--00000000000085e5b1062311dde4--

