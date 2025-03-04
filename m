Return-Path: <linux-kernel+bounces-545792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D556A4F16E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC133A83B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0276279334;
	Tue,  4 Mar 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EFVkRpry"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA527932E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130741; cv=none; b=eUt3aY7trzGuV15yY0iz4kXsMBpNfGTwSlbnp+/McM37i+6ODrqnRTTh1aRVQ/fArLLATawlNayUYOaNeu4B2YZq6SgnGOvDHzWqJN95o3AvayMwH2I4Dpb5aqwXcejM3lcagg1wSYRSElNRt66689U63v/fOZUPD3j+9CpbcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130741; c=relaxed/simple;
	bh=pNZ41KXmEyGcQ0U9vKGTDaSQEberX4OAJolAWO3dXtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImAo6ENv0ylGW9Bd8SY8xVxoM5gki802uhb1zLiv0w3TmgCGe6CljNeKJtx6Flxv1WZTFsJ88tXzGZIH2ileokeND2zd49DawhyCRhj53BY9g3Jd362GJYTHa2qoHisHAmIoPoplkYGXsVBGUBbQaBlw2GUaYtgizR+mv0ewcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EFVkRpry; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2234bec7192so107862545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 15:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741130739; x=1741735539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9+kNeFYDGfQUIEiA3/LTIWTyD2ND+tACupT0yBEy/k=;
        b=EFVkRprytM0xw2mts+2VaQKnWwmdQdPrHMu7Ei9s49L1Z+uhVkxZZABEmQGq2CJ4P6
         17bZZV/0z9m3LjhNjMttEF6pbxhCE57XHWqSZMxlCPdUJuwd6cuBVWG4dtRrb6BN/lLn
         +COliTsPS7zKZ8D81iIPajMHJyCiggUZRirwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130739; x=1741735539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9+kNeFYDGfQUIEiA3/LTIWTyD2ND+tACupT0yBEy/k=;
        b=wjCwk9MAiib6dCBhThVykAsx1p7gPm5Ti6U3oI7tSwWlN6ieJdhNy9YAilOZ7lrsWH
         +sUx+Py9d9SzB1aMcY6Mg/PZktyLW61/BDsn+5ZwFSTOFLnBXSt55SFxFWXFS109EUEA
         ke+Wxp2P6iDPbZqv93O4T/x0FEvRjIB5H8BngfJccmj1ojGXfxGByzP7yULOCf89WnWs
         eI6aPDHWrek14BGxzAeP1CZRjmnh9i7ElPjaiq2HDC57RKFRMeTDCRUb7o9ke/cWGd4q
         6XDO68SxgY4PpeMyZE26l5HcfC7weYwpPhdeNwvIQq4De9gXFOHbPNW1U+gTw/zYGKyK
         IfNw==
X-Forwarded-Encrypted: i=1; AJvYcCWtHh5E8DbOjaj+yWWwSOBv1P6MjzWpU3J4E26ru9Gqk+gYqGbLlkFaYDIMZa7D+i13olPTW8MbEFuA8yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJGvcED7ySO+UDt4zqNIq5XYQuKCHkEYuQtRHqQ8eZfKB7UFx
	oXVY3JqMT0MVjH2+QpYL42xXHCSs8DxRm/sZXQ+ZgKXekxYQqvBtMaTlcss3rn/2ljP8FF2KLKU
	cYKpxBNue7HQYc/KJaemM/Ejo88JihXIpNP+KUtuKxegDOw==
X-Gm-Gg: ASbGncu4lgqB4EI1Kn0tv8lHHBUrgtP6pWpMP9EeuqFGDd9IBFeok2w5noS25Dz4dvz
	1boaC0f9YGmnh4wY6An/Ql3Ud0448OCSyu2lCHPVLUv/QSLeNNfqcvvL8/FJr2Pw495hnRs9xsN
	9al8sDJjh66X9FPJOCVOU7exPmVQmAIuUNF8M5n2gRDO7BxOjGbNYwopUdYg==
X-Google-Smtp-Source: AGHT+IEznYceGsjjTiB88T6Jrdmo0BdN0iShKH5S68YVElUCr8WM6U09nAFI/eguF9xsQVmCsMKMr2ItgVP8iPjd6qU=
X-Received: by 2002:a17:902:e541:b0:220:f449:7419 with SMTP id
 d9443c01a7336-223f1c66c97mr15866225ad.7.1741130739540; Tue, 04 Mar 2025
 15:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304215637.68559-1-linux@treblig.org>
In-Reply-To: <20250304215637.68559-1-linux@treblig.org>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Tue, 4 Mar 2025 15:25:28 -0800
X-Gm-Features: AQ5f1JqBPSpYq0BUOw62xgw4nLMhNrYoD47X9UE-6-hfoK2kNdY06lYEgiYfNOE
Message-ID: <CAF+opq3UOEAJvjT1rvwkqX5MYNbaxksSU0Dtg+jXgE5u9DH0=g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/vmw_pvrdma: Remove unused pvrdma_modify_device
To: linux@treblig.org
Cc: bryan-bt.tan@broadcom.com, jgg@ziepe.ca, leon@kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000040e845062f8c976c"

--00000000000040e845062f8c976c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:56=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> pvrdma_modify_device() was added in 2016 as part of
> commit 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
> but accidentally it was never wired into the device_ops struct.
>
> After some discussion the best course seems to be just to remove it,
> see discussion at:
> https://lore.kernel.org/all/Z8TWF6coBUF3l_jk@gallifrey/
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

> ---
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 28 -------------------
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 --
>  2 files changed, 30 deletions(-)
>
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/in=
finiband/hw/vmw_pvrdma/pvrdma_verbs.c
> index 9f54aa90a35a..bcd43dc30e21 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> @@ -237,34 +237,6 @@ enum rdma_link_layer pvrdma_port_link_layer(struct i=
b_device *ibdev,
>         return IB_LINK_LAYER_ETHERNET;
>  }
>
> -int pvrdma_modify_device(struct ib_device *ibdev, int mask,
> -                        struct ib_device_modify *props)
> -{
> -       unsigned long flags;
> -
> -       if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
> -                    IB_DEVICE_MODIFY_NODE_DESC)) {
> -               dev_warn(&to_vdev(ibdev)->pdev->dev,
> -                        "unsupported device modify mask %#x\n", mask);
> -               return -EOPNOTSUPP;
> -       }
> -
> -       if (mask & IB_DEVICE_MODIFY_NODE_DESC) {
> -               spin_lock_irqsave(&to_vdev(ibdev)->desc_lock, flags);
> -               memcpy(ibdev->node_desc, props->node_desc, 64);
> -               spin_unlock_irqrestore(&to_vdev(ibdev)->desc_lock, flags)=
;
> -       }
> -
> -       if (mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID) {
> -               mutex_lock(&to_vdev(ibdev)->port_mutex);
> -               to_vdev(ibdev)->sys_image_guid =3D
> -                       cpu_to_be64(props->sys_image_guid);
> -               mutex_unlock(&to_vdev(ibdev)->port_mutex);
> -       }
> -
> -       return 0;
> -}
> -
>  /**
>   * pvrdma_modify_port - modify device port attributes
>   * @ibdev: the device to modify
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/in=
finiband/hw/vmw_pvrdma/pvrdma_verbs.h
> index 4b9edc03d73d..fd47b0b1df5c 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> @@ -356,8 +356,6 @@ int pvrdma_query_pkey(struct ib_device *ibdev, u32 po=
rt,
>                       u16 index, u16 *pkey);
>  enum rdma_link_layer pvrdma_port_link_layer(struct ib_device *ibdev,
>                                             u32 port);
> -int pvrdma_modify_device(struct ib_device *ibdev, int mask,
> -                        struct ib_device_modify *props);
>  int pvrdma_modify_port(struct ib_device *ibdev, u32 port,
>                        int mask, struct ib_port_modify *props);
>  int pvrdma_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)=
;
> --
> 2.48.1
>

--00000000000040e845062f8c976c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
R/NZ5tTafc0SyuWmEVyFR825FbSoi1HwMkY1/lsU/2Ny0PK1+9WamuvV11QKd2dN0bYDXrT9uWC/
Cw+IDnr+5S21lWL9xM3S7htf+QjbSezM58DicE0QLGoXIYZ98zGOum91sMMgq2YfQKCVeOcD/7SL
0tftIn9SftUtPTeRab5qssPI8Aqo18uk3WxLqQRQv57jHWDis/0CAwEAAaOCAdkwggHVMA4GA1Ud
DwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGG
LWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBc
MAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNVHR8EOjA4
MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmww
IwYDVR0RBBwwGoEYdmlzaG51LmRhc2FAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSDkmQlbsGdC/WLbyB/
f4VlMvD+ozANBgkqhkiG9w0BAQsFAAOCAgEAYv4/sGMrazXrWECSGMFJ6YIDir3jLsYCcD/xTMfS
bXSiWFQ/ZiFLbxfVV9JJKkkKR29ow0Eo1fBaZMCDhnax7746XJn6qJ0Iz5MyLKFB2DKt3UO2q1PB
+wh73XKXTx6FDnbFRDjtyam6uKjknIMrZcFVTyFwUiY9zKz5pK40OPx4ZzdWxOCKMnCblGOiqvS+
gHpKXHRfCd9Ul1teGR1+muz+L7fJfrx9WUBNDFFIhwZEevLSVo7wIoyT2PG0fIk2yjKCFOT3CVVy
E5LT/kzQHjq7Y36GeUxozu21FbrNYm4Ivlh1OV9suNl/3iN1j9kFAdgg/8QXh9USKmg2zaS/S9lc
1YYUOS+Epg0WBwhAwWtVym636KWqu4Esgz2XWX1260rHG0sIxkdxzvBwsUYpf3e1axBlOHHr1Jz+
vDtQVeBUS7fBAVDWnBJrKNn+jseGnpcqBDQSSNq1kB44XhKZFApne6lKSCqYkE3qXnr7Dp0CXm+G
pPoyxqxotis4l4Dl4A3btCkYLp/dzOS00M71f185BKufW7S/16rj/jVUzgz2AjGvM/OC0SWvGoB2
tDdyBMmW1/0xK5rKGnmfM07/k8agfS2J6eI1iWB35m1Ni2SoCoLGoLlvUA4OhexyRqMTTjyllKtA
0Z9TF7kzBYUx8Qa7zfaTaIsVorChiSjphpgxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgwcY9XKjV0+TQvViOkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IIkZW/ay5R2BRdPYdYCTgj/Q0oWEWJDud1nXBaXlo2mvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMwNDIzMjUzOVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKNvILpFGrWFuY6R37ghd7uPLjy9LGp/UrPE
POPnobHqS3ujMlEmSoRfr2yxscgcawXmGbzY3ULBZOxNrEJ394M1MF9BIz+1TbY6VaVyogbEGSBM
VlyVl3k/56iR8TL5jfgwj/YE/Ux3Q6m3FCl63NBkktg45btli84W3EF6HhsdSdm32e4Prpa0AeMa
IpmuAIj/GN2YgH1CDFL3Jlm4atz3e9MQ2OZKTTF8oDUol8nNhCwbFUcNCbRXXux245kgwLeISZF/
A5MtgPXt9YQoiAIRw+k1gO9cNaNdbs530qTmavnNDLiA5WBDdLQhxd+4PLOglQblIk+aQg4bz3Ht
R9Y=
--00000000000040e845062f8c976c--

