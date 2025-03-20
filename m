Return-Path: <linux-kernel+bounces-569142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026BFA69F09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8CE3BB6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D01DE4E0;
	Thu, 20 Mar 2025 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fQeTh+Jb"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB41B6CE5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444943; cv=none; b=XDMKGcGdkFflIE8qmE5ANFE3JfMHYVsNiVLdrzP81xsFYMkO8Mirm0GCZirvrJ7MrfiuWhBHh/Qg6nhvHPFe1szsNSKHKN4uubYSdEtvCkTZeJqL4oLqWLUACXFUbgPsEEbnTEaIbb+DAhu7NWgg74pxkp4Te/WjrC5vo6LLQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444943; c=relaxed/simple;
	bh=5zjaH+LM4GvZY+W9t8POpWlwcqRNw1ejvwK/3+S74zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDUkk3lvGwam94mw8f+LMMsij0+veS+MCvAAZEUzWREKie5Vv/Yh7a92yTkeP6KvwfL20NGZswma6eoa/WFI/gpJCF8Jt+eOt9wU29iBlfpJWJFiOTM4eHwjvaXlq45V8KcFVe+LNJnfJ/yP6u3jGQYoMbvl2ncRxlwdwsYgPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fQeTh+Jb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240b4de12bso6396145ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742444941; x=1743049741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txhdBjCtZVmg0ZxgSh2LDZ+BN116nwb85i16HxyFd/8=;
        b=fQeTh+JbVeknYG7vahtidDbYWPn9uM0yCdYdeGKTFz2vyHxDlcGbJJoHrJU24xpLod
         FvtLsOltb1nyKxma4FZt3tCAMq7SFV2QOlxuP+76DcjBHlul0CPUSEM5Fc73KPFbIC9q
         KjP/258oqN1oSuucanEyRBsgZjl4kAOCGtFYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742444941; x=1743049741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txhdBjCtZVmg0ZxgSh2LDZ+BN116nwb85i16HxyFd/8=;
        b=bEN0ZcZw6XyDG7xQKBfuC2rOxjKyOe+zCED5hn6k/kxclsPcAnJjrp/xeu98k/+2JT
         jPwayIwwzAKYW/iU9ibjd01wPvuQDUE+kIpKiFL6dra0MKsy86tTbl2Ut2MfNSQ/BDWf
         aVypFkddpz5jezKD+7QeZg2KqMXhilYP1XKHvEJMiKN7gAFZFl7qpxmVTWIqukmFJeSo
         o1O3n7Oj00y5XZw1U8847K4e+GcjchGezyc8zkqWePcGFxHOyxJWiZM4i+PH12rMtMos
         FwVZHiD1JoWOb7PehftZzH5Gsb3fbU/tAs/9G0mXTspIZvSIh7aWX9F0Xg+szAPxmvGF
         srLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8rIsLUqX26Ot29myB5zVNEnp46DLCsLffR9gcZIsB7Ge34rzbALHYNDdlc0J20PHrAzHLxnPCYpVFIVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAC7TznXzg7CDdRdM0M2HrInHYhvwNkVUeM7ky4aUhWkIptul2
	2tSk7jT8nhuKShCAxAjYmKoq1Sci0YBs1JkDhVy7PfH22LXbQI/8r6hYmQc1J3br94A0u9PeAaY
	+QGd0QnMdsxNwd2EZxFUXfOvdyCSnHrt9OFQz
X-Gm-Gg: ASbGncuLTD+IPWS/u/vpmmu41WTBlfgaVmRVPeRaW3tpyqatM/48qVvfbzaBTi0bbLG
	Ba+K7Vjw0Edvjas1jQHZteRWJy3bdoFffy1VCiFSMeZxAqyD3huwoviIUjr4ovy4S9Oj1q/PSea
	gOTolliJAR4BBsMiQEpq2jybMKpZg=
X-Google-Smtp-Source: AGHT+IGO7F6d+S/aBVLLYG0OuU3XLDmBE33AHztpyDLkaCcLeR3liUvazLer9Ozmf9DF21TygWabODHjeZDtMreRxEk=
X-Received: by 2002:a17:902:d487:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-22649a7ff75mr67363965ad.43.1742444941412; Wed, 19 Mar 2025
 21:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1742412199-159596-1-git-send-email-tariqt@nvidia.com> <1742412199-159596-3-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742412199-159596-3-git-send-email-tariqt@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 20 Mar 2025 09:58:50 +0530
X-Gm-Features: AQ5f1Jr-veMPc9rh01a9q7KWJ_jiBXrvYBg7AmNxleEcwEwUL3EwOwxssaNgSCw
Message-ID: <CAH-L+nME7jMSXqVuUqQosoQms7SmdoXdk0x3Re0qhLTS9FAUFw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5e: Use right API to free bitmap memory
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Mark Zhang <markzhang@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cadc650630be93a4"

--000000000000cadc650630be93a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:56=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> w=
rote:
>
> From: Mark Zhang <markzhang@nvidia.com>
>
> Use bitmap_free() to free memory allocated with bitmap_zalloc_node().
> This fixes memtrack error:
>   mtl rsc inconsistency: memtrack_free: .../drivers/net/ethernet/mellanox=
/mlx5/core/en_main.c::466: kfree for unknown address=3D0xFFFF0000CA3619E8, =
device=3D0x0
>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--000000000000cadc650630be93a4
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
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIH6Gq0xoAHeZRJmVE01WzlOXIR/YsADxzkHZ6ZtyxfwBMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMyMDA0MjkwMVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABS9g+bTeh6ih1pbAKodKVDKLPFk
5hyKUjA+bM+CbrIGE6NKSLusvztmyXt1prWsAzsIY2UPUDPUnr65bC0bSJHTeq6C7mB3ESKD5bOW
xc2uaWruYl7ITK6zVa+oQKdtH9ceaVt2WI3DREqhUObk7J/K6sauxjCHwVuwpIT2RTRkYXGj16TT
px+IeB+pbLIjyzD+AtKBNMYNPY0LUivi+zrQu7v/zmmTcIkzbDlqp9kYRlwzybPUzYFJlSc9p73L
QcM26/jc/OjfEfHTYfvIbQSnSfxK23FVdM0qKlhlWoXTqkY4uqkt5j83BEpmlS99PBvY+W02m0WH
7aqzkPGTlek=
--000000000000cadc650630be93a4--

