Return-Path: <linux-kernel+bounces-435214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED19E748E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80281887147
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AE20E6FA;
	Fri,  6 Dec 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/VEJKui"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBC20E6EA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499324; cv=none; b=H2r9mSnk0aGj4m9EJYQX5Z/63yyLW+5r61PbfQCo1PlmkuL0MhDyNx80CwNLnmwFesaypZusjVHmWgHTXRwQ2dMItoNDSAQO+/b54eb2qFToTV0OC7QpWHLB3MySrmAiELhfwwebvQsZM8yqn9/9GjcIKxeJk8HO9vAfWeZ81Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499324; c=relaxed/simple;
	bh=XHP0Ybq3YKVwaB9eMvH5J031HnUE4tP0x0o6Orl0z3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8zw7Rf0JgW4Q0hAnilZezWN1lVJ3Wa5t/Gm2QMaTNzlnHythVrAeW7tujJRlNQAxvcBR6mvhTLIt7N9JmUdqcn/e0Ba/gEbjH3n4m/t9R6cNRFMHnF4zmNeI0wpmCbrI/Z6nYhs4nArdb6Oszoe4e9Wkoy4f7pCz/VF3vlW6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/VEJKui; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e388503c0d7so2162950276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733499322; x=1734104122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0sRbFkRj8M6BXgVsrQT0c/w9l9OLU/m4B/p5b2B8OyI=;
        b=e/VEJKuiKIljHsTxe05K31ZSqi3YPwKvQcVfMV3tfHAEmSNEKmUY0Wgu4se9Y1Xv+S
         a0Vg+nQZ1Pr/XItDzdP5SSitFAa0HfPc3inIc8r9gb6UxfecDkIxurFu9UBXyFR8Uajx
         B3XpWBfRbAW/5cP/42b13JzdEyD6u5BNGboHyxJzYQdqlIoI4f9ZN221TjKyeKwyfCao
         zXQ5RdGrBukaSeBue/0k7gDr6yfqNMoGdsIR4KaS6pV5GB8P4n1p8qWYFBE5HooLZBxb
         +ZcsEV5D+YSWq6EYZqH6ynD0Svuy54Oq+KsBDiMQmcnAmYH59PDHS8vHMA/iY//TxCYm
         t4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499322; x=1734104122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sRbFkRj8M6BXgVsrQT0c/w9l9OLU/m4B/p5b2B8OyI=;
        b=jrIdkYEEH9PjpZ8XPx4OoiGsk7M5TnRL6Vb7fYGcK3vV2/Gx9kNN2M3PJzTMFCJL9D
         eAaEJrKTNekyHjn3sV/rCjw/6XzfJv+S1q+HRKbusDycTzUgVwj+tZuCambRnXsFaI/K
         YYBmzd3HNEYmAkWZdZgGcKwC8ejknC0OAXaYRkiFcf4GL9E2rpnEc5Nn6BsLt0FCtq0k
         UtZ5MeO4seX3JNWqVYokgvgOqTCySk+9mA3dpUYNAptIZebhcKYWfbfQ/ZuWjdHkBJOf
         ihaVdYWN7K+kE2O3Iw3neKF3gvSmriLhhn/0YGaunoRaLC4HAS0zaLqlvcMD7UHjF2pW
         5onA==
X-Forwarded-Encrypted: i=1; AJvYcCWCZdWk2ID6cv8axrvHtG5Cdf/0muqitJRJQ8HvTRz/JRyUfMGJr5FO/oBYpKbWZGg4NAosjpsGJOlr8mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEmcNOz0PLDsMrscl3HT8cW+opchLAUODAhdrkjQ+E09Ffhz1
	GB0xoppH1BUvB9Rus2IELG25S2gaV+gzdoKIX8FAOXQZdMSD9OGR+D82WmshUg42z3U/MBgNOSM
	3luNlHj/tXuqaTqykeKl0kMlQBdTpA04jXzX1
X-Gm-Gg: ASbGnctjvwRtUw/WjBBzRQKPL75HrBBFNdrUFdOalvB4LC/FG0QtlqLUNJOIkcqAX56
	fz574p7TlSikJlXRBpJ++pIFSZwO5p2Q5f+p9NkQG6SJGaU7J7UOQfjJLQvs=
X-Google-Smtp-Source: AGHT+IFuZLFtzwRg+JRsBwQ/3EqqNsFYlGwoB9FyffJ+nGfAGob1JrXtERHFpnUBC6hMDQmk7UEWhzC5bKsJcXfTiVo=
X-Received: by 2002:a05:6902:2491:b0:e30:e39b:9d72 with SMTP id
 3f1490d57ef6-e3a0b0be842mr3543484276.16.1733499321601; Fri, 06 Dec 2024
 07:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206152032.1222067-1-bgeffon@google.com> <20241206152032.1222067-2-bgeffon@google.com>
In-Reply-To: <20241206152032.1222067-2-bgeffon@google.com>
From: Marco Vanotti <mvanotti@google.com>
Date: Fri, 6 Dec 2024 12:34:43 -0300
Message-ID: <CADMPHGvA+6A+eRG74Xqx5rnLUvq7CFu=p5+YhEfN6oS=S_g6wQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mremap: Fix new_addr being used as a hint with MREMAP_DONTUNMAP
To: Brian Geffon <bgeffon@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004ffffd06289bc3b8"

--0000000000004ffffd06289bc3b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:20=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
rote:
>
> Two non-mutually exclusive paths can land in mremap_to, MREMAP_FIXED
> and MREMAP_DONTUNMAP which are called from mremap(). In the case of
> MREMAP_FIXED we must validate the new_addr to ensure that the new
> address is valid. In the case of MREMAP_DONTUNMAP without MREMAP_FIXED
> a new address is specified as a hint, just like it would be in the
> case of mmap. In this second case we don't need to perform any checks
> because get_unmapped_area() will align new_addr, just like it would in
> the case of mmap.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Reported-by: Marco Vanotti <mvanotti@google.com>
> ---
>  mm/mremap.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 60473413836b..286ffdb883df 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -912,15 +912,27 @@ static unsigned long mremap_to(unsigned long addr, =
unsigned long old_len,
>         unsigned long ret;
>         unsigned long map_flags =3D 0;
>
> -       if (offset_in_page(new_addr))
> -               return -EINVAL;
> +       /*
> +        * Two non-mutually exclusive paths can land in mremap_to, MREMAP=
_FIXED
> +        * and MREMAP_DONTUNMAP which are called from mremap(). In the ca=
se of
> +        * MREMAP_FIXED we must validate the new_addr to ensure that the =
new
> +        * address is valid. In the case of MREMAP_DONTUNMAP without MREM=
AP_FIXED
> +        * a new address is specified as a hint, just like it would be in=
 the
> +        * case of mmap. In this second case we don't need to perform any=
 checks
> +        * because get_unmapped_area() will align new_addr, just like it =
would in
> +        * the case of mmap.
> +        */
A few lines below we also check for MREMAP_FIXED before calling
do_unmap, can't we do the validation there?
> +       if (flags & MREMAP_FIXED) {
> +               if (offset_in_page(new_addr))
> +                       return -EINVAL;
>
> -       if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> -               return -EINVAL;
> +               if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len=
)
> +                       return -EINVAL;
>
> -       /* Ensure the old/new locations do not overlap */
> -       if (addr + old_len > new_addr && new_addr + new_len > addr)
> -               return -EINVAL;
> +               /* Ensure the old/new locations do not overlap */
> +               if (addr + old_len > new_addr && new_addr + new_len > add=
r)
> +                       return -EINVAL;
> +       }
>
>         /*
>          * move_vma() need us to stay 4 maps below the threshold, otherwi=
se
> --
> 2.47.0.338.g60cca15819-goog
>

--0000000000004ffffd06289bc3b8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
dse5AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNtdmFub3R0aUBnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFLnoaPhnYXx5
pj5LfE9mu0kpE3fkMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQDQ
RDODjaJ7Sb/dqzbTZr/xcacY7QyDvKjrNfBPa33/WilRhBboYY4FOF7645JjBi1lgILfYG0xaSzX
E8BoWb8YNSnJ537eMDSz71KBsIisoEiVGuQ+dAl9dpb7mpJoN33HAYdhHjjHopTg64v7GG0mHiSI
KDJiDvh/p6AX2GLPqh9pFojEEwmUJ7DA7fO3e5//PNKYJxR3Rozw34nVP3W73S/xh6h3skYX8j21
XonJ/b1fjEKh52XqsyTOaE1VYuoKW3H36t8S5AG6pLxMWljM27Wg+nViRg0kGWuryJfmjQQwJtzm
msjSHemKMeufSQ25XIJ/sSjQbgJj32wjRgOISUea6p+TC2kkvTKZCOHoKy3u+JvUtvTF1r21N4Ml
ZU066dYKa1oAfNWm9pyy79xr7UtiMOGTjepILioA7xPljuFpCTKFreDjBl1q9y6PLHfmzazJ3Zna
pOD0O2El81W12dxmFvODQmfBAE6r8IVD94FKgrrv6PHnroFYLkyYOoXyy4khQmqxRsNpgxGkJRRW
hN0zokj+sl6k2AQ3kpY0jGHX1I/Q7YMwjCYXX3cMPvDDB+Z1X8U/1MMhKnmNCNiwocEeY7NALbzz
WoscHXUz4AfS9fQp6ajna/gsWvqjUzs+or538lKoev6Ady0Jzxlo2XdNJK2vLDit2yI4FqYCnDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAeWUamp5nfwjqzpGndHP
pTANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgl27RjW9XUqrGDfHJE5alFGaAOSdf
Xh08g07M3FJ7XlcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MjA2MTUzNTIyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBABxRee5Vrn6B6n8FKWobEcgBGgG5RR8TF0Oa+VhnoQdlIIsg
NDM6HGPfzxO9KFRr7J/VeVZyH7Rn9iZPnEThUn1DVsVF63lmjBcSrTu9HVdNtGTZx1HyT1FqCd0l
PbFTmcOEbLgIHFWZdkkkE8f2PPrWcu3T9xsCs+PrMgiiDodjDkFi0TbARWGzhG+X7f+Twq9Vw7ca
yOYvFTgTgMlIDKrfXwVifOegIEFwQi6rBwxdYavgHe4HqK1heGDQjLUpawJrO+SBNVW0n23qx+Ic
81aBnoAtp6nngojiFEAPbThgHRL2F+tREPz9z5+bsYDxUsVprn8OPyJC5Drk2l5vBGo=
--0000000000004ffffd06289bc3b8--

