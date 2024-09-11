Return-Path: <linux-kernel+bounces-325650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED48975CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D914A1C220D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF61547ED;
	Wed, 11 Sep 2024 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RfaGnicj"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02014143C5D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091259; cv=none; b=DZ8VBNpuKAOOPrEQPLzuy7Eolm2YJXYmZY6+c9EGYOsgA87OjKG+OceaF/Zc4pDpfbDctJtG/1AQ0JMriA0BM3vZRHMyFTm/UhSpEHFg5UZIyI90keRCHQZf7RHuLoA9P69bnPB+oqsTaGtfO77TguCDXy8EItNJqE7PE0uY2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091259; c=relaxed/simple;
	bh=O1BcEWFOEHympGBO7ne5OzW2dAUwUiB9XHv7eNUwCqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUheiLdnCS8b8TRL0uPK45T9RQSbNlOrrZ5P+ZdMP1m4wUgMzNMwtnSm3v9wSF2sFOSSLUH8nY9hKkxuIBDNziP7aLPFWG+rlpw1roRkwOqPTDsfGixgPgz92T2IqYcNjYsHnLNgGq4E9yvg/I7rdWHKX99ymLjmxZRxoDPcHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RfaGnicj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so310991e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726091256; x=1726696056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rCQT/bNdR7QGdyTMHwSOSCQ2s9FNRP44K2OR1u79/jM=;
        b=RfaGnicjPUVkhN5RmYikUWXgo/R828xNKan0ETjKPE5bsHNbQa6C9XQ75adhyK8YJ+
         Tw63BAX3SAVAotUQ05KkGq4p8kulBgFsEjPCu2FibgQdSmvTPk6SYvA52vNATcVZCn6Z
         q5Iiu0SIpNrmxFRZDa3g2ItUt6rYPvF/skX4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726091256; x=1726696056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCQT/bNdR7QGdyTMHwSOSCQ2s9FNRP44K2OR1u79/jM=;
        b=I5gpvNPx5cXQin0dakD9VyRakeV0X2kDYhlHp6M2tr92LdlBP2c36/mIT4GMCPOs3C
         sxeH4wDTs7YEVDQu9ifxnKYpYoYOCiVJhIWfrSB1+UCM2dl8LGdT5j0dxmd1VVRbBAlT
         MCIWPanoRaoM8aJBPGoKX7zCQqCTslqbC60mMCa0Wv3HF+JK4YEDUVlNW5DEJMNkd9in
         F+BxMrv6pPFPI1yIxF3ZrKJ5y8RtAAxCgRNxJwDDpTQHVf7RJlHHSLtisz7D7qt7e4GA
         UVSMwN+uKhq5Krquqi2Coz+5uT5Wu/ify1JwP1ZF8VRzsdMQSsJV/iXsrFx7aq57sPuo
         PLLw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2+NF0gkYU43VaEIiT0RSP6sFV2aW+n88/6LRj+r3TixNBU29Tlu7Yei5iKNk4hX+RvUlYBaEkYmKZlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5VMl4MYI0MeQEEhKAb2pxHjjyMpnZNtn8irk9Zn9uhOhmckUg
	Fu1uA+FdY+o8HYPGoXiUwX3vxSbcyMocVex5zaxOIx6eHuDuu42QFAv/NY7ntdeAgqSezfa44VN
	wnmiFEj303BYaP1dDgEd2jdZNPYwCt2vigjMhEYMq5ubJawI=
X-Google-Smtp-Source: AGHT+IFPNBpsSFvxXXQsJ+xVic2Tv4+sg27DDAEt3qkAFhhh/JGG71toq2mjUwSUXxr5/XTJhB1P90oLg1HgDU46gu0=
X-Received: by 2002:a05:6512:3ca9:b0:536:5522:3ca9 with SMTP id
 2adb3069b0e04-53678fb752fmr372403e87.10.1726091255422; Wed, 11 Sep 2024
 14:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240906225435.707837-1-florian.fainelli@broadcom.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 11 Sep 2024 17:47:23 -0400
Message-ID: <CA+-6iNxYwyfATMUq+nJfH_a08tdx_HT3k_d0fNS8f8-khghTfQ@mail.gmail.com>
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-serial@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000312a2f0621def03a"

--000000000000312a2f0621def03a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:54=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The write to RP2_GLOBAL_CMD followed by an immediate read of
> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
> however by then the device is already in reset and cannot respond to a
> memory cycle access.
>
> On platforms such as the Raspberry Pi 4 and others using the
> pcie-brcmstb.c driver, any memory access to a device that cannot respond
> is met with a fatal system error, rather than being substituted with all
> 1s as is usually the case on PC platforms.
>
> Swapping the delay and the read ensures that the device has finished
> resetting before we attempt to read from it.
>
> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 ca=
rds")
> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/tty/serial/rp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
> index 4132fcff7d4e..8bab2aedc499 100644
> --- a/drivers/tty/serial/rp2.c
> +++ b/drivers/tty/serial/rp2.c
> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, uns=
igned int asic_id)
>         u32 clk_cfg;
>
>         writew(1, base + RP2_GLOBAL_CMD);
> -       readw(base + RP2_GLOBAL_CMD);
>         msleep(100);
> +       readw(base + RP2_GLOBAL_CMD);

Since the assumed purpose of the readw() was to flush the writew(),
would it make sense to add a barrier after the writew()?

Regards,
Jim Quinlan
Broadcom STB/CM

>         writel(0, base + RP2_CLK_PRESCALER);
>
>         /* TDM clock configuration */
> --
> 2.43.0
>

--000000000000312a2f0621def03a
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDK7fJMncldKIi/cGWxv8zx7CiydCfw
+ODBOREvMb9WezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA5
MTEyMTQ3MzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAAOJrWP9PtqC6Rhb/2Fbvn+vYqRnz7yDWCC69UtTkI1zxfah3
5cb4fh2FW2Qi8GFhLeWyczbha54gOr3Aop8h+5S+AEUMOdYPulD47iFw0PN/26gRWVVKUxwXRpFj
ruW5JYy1h3EMIwIsemElZ2e3w+psl7EH0+3xmGHMBcZq+ymLsCqPszi5iiReE9U3LGd98wPfHWHQ
RSHPjfmbOEVS5txyx6tdUheAgxJcCfsRbancxhq7y16UE+qHu1/CipexTz8T1YondA5IqSjJGNt5
G04aQpwY6NTtUVJUmKZajfEx1W9a9Cplw2c9DIYQLKEc1JyVAQXFpev0ZyciXCVTcg==
--000000000000312a2f0621def03a--

