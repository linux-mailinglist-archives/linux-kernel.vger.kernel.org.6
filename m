Return-Path: <linux-kernel+bounces-510105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F13BA31841
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D551665FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092AC268C57;
	Tue, 11 Feb 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WdQmW4ly"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA632267AEE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310617; cv=none; b=uG2LNqjlFv5Pu4bIgKA+StCzzlV5YWTBnwQNM8qf6g/oBcaw46EjxUsRPHu3CPCEkWiBaqGIPE3/PLpbCvCEyjKsjjf2EFnR6SMiB4mPN7Gwy8hU1hn5j9nrFKITPn+2gDw/tYNhI+e6UYAhYLoEX9tNx/1DaDY0DAHbwp3su+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310617; c=relaxed/simple;
	bh=/Gjj0FJ2NFXtfVVBBvxbJPyj3u2xcZLvshJ0yY8/o80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fleTCFb2GLMxGILeRb2XsJlAGzv31PWYeBQn1RRpVsUd9dB3vTzArocdlOxGaf0HX9dDU1CuG6VQBQvB9lxjiFASQI6pF0AkObGSmT+nWBVIElVciD0AKmnZTmZiHHR7RcEWwpvab0onLTaVCsmHOKW5S9Ep6hZRjvdx6wCcv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WdQmW4ly; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso5588818a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739310612; x=1739915412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nnOlzfac4gYu8/znCoo76rKXNxGs7JUWN96pk2ECaY=;
        b=WdQmW4lyhUNwqhvAe/Oj1FLsZKPjmIf033mooiHVo8CZ1DjMlIjY8tIUAsSeYZWqfe
         zAbjSB7sI1GCctx8t2AVAXbn7GE8a+LEgDtYKruTfnwadZlG4Jucm9ZIREt8ZRpcA3Zx
         gESOH5yTMYwP9WNAKORSGEnKR+fYeryQJjTtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739310612; x=1739915412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nnOlzfac4gYu8/znCoo76rKXNxGs7JUWN96pk2ECaY=;
        b=JVxDRgl4YhZkY2Zt5sWuis/B8NCnmdrkXaL2f2JNw4mM48S6la+NgR0AkRIXlPwpvY
         O8zZgaRKhZL6ls+TLOqOcnRjGo/inVBjo6dnV9fQP/6cvfn69yZdvixmRC19IDyK1Kld
         9N9dyYEE1hHkt2RRWSy1IpNTDci9d6VvSAQBJOpxblP5YxjxxReqSsOZZNU4woD0MJV0
         P+l18629JLrxL9QUshxjJNhpOCxJmRqgMlpVEw8Wqd7g5sKh/1nKeR8l1UTW+mniNObo
         ciBTmuqupm636y2EuOYJP8IlzXrqjzClaF8fYaDIpEL0Wsuii1z/GsO1QoHNQJS5Ui82
         wURQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3g2qMvANcpd6GDgXOYGZBACesWXwkneGyWXwKwerPCEp/h2KhWru7Rs47wef5qo+mH5Yyv+lA/1J4DxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mBFsveXB6+tWGBPxUzxLCqXc543t31G5IPcSj/LoFhe4EVa3
	EMw3Wa4gmlK2CoYNwBPIKcftvRscqW/cVX+ojWlERARgYLHtIYpbNItpKw24e+D5ebio5cUKOX8
	o42wzdePY5Pufu9WgLpvrZO1nWf+ChjSdATeX
X-Gm-Gg: ASbGncsWKrsKQBpLR1UAuJBSyM73opFdQ4o/XpW/VsGuCol7Gt1vxKbhOB6qFDTP0nO
	CYgqe6TpVSA3iBio+aFU5Sr37YYgSHOGtLY/1zgzuEtgQbJLwGFn4BWeRxfaIFBm6QLl3HWNR5Q
	==
X-Google-Smtp-Source: AGHT+IEzvdTZ+3wC0JFomO+Y1YcTp3JMALq7QICio9ze2LjI5UWqTTzlxPG97BiGyYin/NtNxUDFynl62Ff5J1FY1fc=
X-Received: by 2002:a17:907:6e91:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-ab7f347aaf2mr50256766b.35.1739310612150; Tue, 11 Feb 2025
 13:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211152658.1094-1-vulab@iscas.ac.cn>
In-Reply-To: <20250211152658.1094-1-vulab@iscas.ac.cn>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 11 Feb 2025 13:50:00 -0800
X-Gm-Features: AWEUYZlJqZ96vEuKDUCMsd8-UPzDZ02JbqtPzsALouB03yo92Anu8Iuy1KGd6xk
Message-ID: <CACKFLikfW2yLUmZpJPE=npeUi-LBaDyNFVVPt_FA+4bYdhvEEQ@mail.gmail.com>
Subject: Re: [PATCH] tg3: Check return value of tg3_nvram_lock before
 resetting lock
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000378cd7062de4cf7f"

--000000000000378cd7062de4cf7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:27=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> The current code does not check the return value of tg3_nvram_lock before
> resetting the lock count (tp->nvram_lock_cnt =3D 0). This is dangerous
> because if tg3_nvram_lock fails, the lock state may be inconsistent,
> leading to potential race conditions or undefined behavior.
>
> This patch adds a check for the return value of tg3_nvram_lock. If the
> function fails, the error is propagated to the caller, ensuring that
> the lock state remains consistent.
>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 9cc8db10a8d6..851d19b3f43c 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -9160,7 +9160,9 @@ static int tg3_chip_reset(struct tg3 *tp)
>         if (!pci_device_is_present(tp->pdev))
>                 return -ENODEV;
>
> -       tg3_nvram_lock(tp);
> +       err =3D tg3_nvram_lock(tp);
> +       if (err)
> +               return err;

It is correct not to check the return value here since we are about to
reset the chip.  The nvram lock is a hardware arbitration lock that is
granted by the hardware.  If the hardware is in a bad state, we may
not get the lock but we should still proceed to reset.  A few lines
below this we reset the tp->nvram_lock_cnt to 0 so it is safe.

--000000000000378cd7062de4cf7f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEXFQiBL1KvNsYmT3Cv0bk6hhnvfjpQ8
03eCBam28pY4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIx
MTIxNTAxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAocveK3vct7udWabwpYKIaR1LaffIvWY34JHwuxxbf4+G3YrMN
vLSqqOXWyGunSGQrWgMYN0n0HQ7qBaDnegW2K+Fi8/87oEbSXeieV2MItgpIVhzCDYZ0439REttN
E3zPo+u73s3VJL+6A6suQDpIckrPmiDo5WxaupeUMZ+sTpShgNXUstYj2tUml1V2F5wmvlDQIoos
GCzkm4Ux5wWvAVi771t1gu59wb1KScay/7zs8yvnhfHdQvpkDtbnm5+A/OurintmBiVD88c8cYsg
2Zf0851YIy4//CigNHC7lVVlfs1BIrWFWszvXn7ROTkoDgml3LSJm0aPIXzpgddr
--000000000000378cd7062de4cf7f--

