Return-Path: <linux-kernel+bounces-441684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AF49ED280
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCAB289C37
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7E1D6DDA;
	Wed, 11 Dec 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3s4iGSZu"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1838DE9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935616; cv=none; b=alzMoMHm63s3vuvz35YS6aXNN01Eg0Htn2rwdQGgyB/Qwjfiel88PeMgbBLGBfLLSjzHxsye7EknpGhDIdPaJJxpCxaro2djlT+VlRpaFOGqnBBvCQ910t3aJ6dCl0ms6JyuPOGCK02aKaI23yvM+OZr/acnzl08mbk/g47jsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935616; c=relaxed/simple;
	bh=Jvh9m2eR58tWwYOd1spsTd4SgwQ/NF6KLcHWGyeuio4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmAcBFZAVloCxtheKySp4lmpr3sfREe2Ux6LzJu/vYAnITq/hzfK0k6evYcn1v8ERMMjTIzIt88y0l1bI1hHaVybPuJAq6sJFgqdxEnupAsfZQt/t3izend1+SHQ/0oJpMSc5jHiFLt8C2wy9RgwAhlWrzDluUAsT8jO1WGrVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3s4iGSZu; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e399e904940so5397665276.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733935614; x=1734540414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lf5DeGd1KGvRHPAl6oCPopiiLWk62kqkSqUUB0+G7x8=;
        b=3s4iGSZuqDVjvu97Le84FaHgrp+BcWWiZFMuWCDZTHl1errljGgV+kdLNthGd2Hp2F
         xmBuxgoYCCKw+MDe/7Cy34HmTBnUs1AXa5kvBWkKn7Od4Gk86vuhYa9hz7tjYfZ7f8xY
         rOImV00+uvAQdexz1+jTMBTBLE1pu5zz3L4A94WKuceYOacbJ3MB7UUgStd2QpbA0MAV
         /iC/EewkBJ4QDULM9lG3rFMkq/Q5BFl23uEYD17UqlrrzAH+fRZcFlXlt6b3dJzE1Dqs
         mF5krhMaKAJJxtLL/IoRAOphNTBSRPL6BVnU9cesjhflbfzhqsfuT/+oDy9yjt2En0Lj
         uyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935614; x=1734540414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf5DeGd1KGvRHPAl6oCPopiiLWk62kqkSqUUB0+G7x8=;
        b=nKxYWbq+EKpQysr1crRqJZ6nlEybtCFE8Jy9l9R4v7I1DVPbSZ+ybMxHjBkvqilvaI
         UY2Gkqnw81BnJah1puRK4gO9MztMobM7McUpe5UOlH+z43qMRPH+9pzDAzaIyaWtBh7Y
         wDvZoJQDYQaQFrulbaUB9x6h9p93mZdmNeSyVZKBSWjQdFb44p5idoLPfjIA4zfav5m/
         9aGxNUBdTIjpuovbkdsNcwfsqi/Wq3uA+D3zoGa0CsUlGhHsCBYvarlBwCXyFSaVwRlI
         B0v6obXaeuhfTKytAG080cRNelND6Xt9WkGEl2Xb0gC7Yeuyduqz7pt6RGRNRzIHCP9h
         Kv5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6kQfGeyOsnB+scH5S+b4GC7CSeOcOKh8w+QJotBdAT2hW8g56ik33nLBJLkYiWiUYTl/YD6kjEDEyke4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vSfSyBbYCKZhqD1hY65jPMfCMej5XyGp36Ih10mMuDjtzR3V
	JD7meMpYINbisRqu3GGl+ZTPYrzVisAXdPcxANQK6YDQB6vmQKu4JITPbEI6FWJiLvAtSc1qyRY
	EWbGXc3xyaQbCzvU4grUceecM8mmyhuTT3PHE4lNTOpHD8Yb5sHUrH1rexOXZ
X-Gm-Gg: ASbGncsYXox1678zQAzXp4RtMj7/9qs6+1s98hzVj1fUe2GpzrWTBIHUhFgZD9YVqI+
	5w1jCQOCbkQRjev0e+dPtc1m0vjf5N9eI926nU6D1Vv3shs9TxEU34SXVczY6
X-Google-Smtp-Source: AGHT+IF6N8vwOQ96UWylhlRr8FRba/nYJlSYE3yE4mdgjIxA5ohkyrAaivms93hJYIRn18O7beh8woCjA4bWTIN44w4=
X-Received: by 2002:a05:6902:2206:b0:e3a:235a:4da3 with SMTP id
 3f1490d57ef6-e3da0d5c17dmr65414276.24.1733935613799; Wed, 11 Dec 2024
 08:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com> <20241210213050.2839638-2-bgeffon@google.com>
In-Reply-To: <20241210213050.2839638-2-bgeffon@google.com>
From: Marco Vanotti <mvanotti@google.com>
Date: Wed, 11 Dec 2024 13:46:17 -0300
Message-ID: <CADMPHGtENiESdnHsoMCsVA2FNBg4jLS4kMZJfGOmvv7=9k_+HA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: mremap: Fix new_addr being used as a hint
 with MREMAP_DONTUNMAP
To: Brian Geffon <bgeffon@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005bf88a0629015879"

--0000000000005bf88a0629015879
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:31=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
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
> This patch only fixes the behavior that was inadvertently added
> with MREMAP_DONTUNMAP.
>
> v2:
>   - Addressed comment from Marco Vanotti to consolidate these checks
>     into existing MREMAP_FIXED blocks.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Reported-by: Marco Vanotti <mvanotti@google.com>
Reviewed-By: Marco Vanotti <mvanotti@google.com>
> ---
>  mm/mremap.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 60473413836b..62aec72bbe42 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -912,16 +912,6 @@ static unsigned long mremap_to(unsigned long addr, u=
nsigned long old_len,
>         unsigned long ret;
>         unsigned long map_flags =3D 0;
>
> -       if (offset_in_page(new_addr))
> -               return -EINVAL;
> -
> -       if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> -               return -EINVAL;
> -
> -       /* Ensure the old/new locations do not overlap */
> -       if (addr + old_len > new_addr && new_addr + new_len > addr)
> -               return -EINVAL;
> -
>         /*
>          * move_vma() need us to stay 4 maps below the threshold, otherwi=
se
>          * it will bail out at the very beginning.
> @@ -940,6 +930,25 @@ static unsigned long mremap_to(unsigned long addr, u=
nsigned long old_len,
>                 return -ENOMEM;
>
>         if (flags & MREMAP_FIXED) {
> +               /*
> +                * Two non-mutually exclusive paths can land in mremap_to=
, MREMAP_FIXED
> +                * and MREMAP_DONTUNMAP which are called from mremap(). I=
n the case of
> +                * MREMAP_FIXED we must validate the new_addr to ensure t=
hat the new
> +                * address is valid. In the case of MREMAP_DONTUNMAP with=
out MREMAP_FIXED
> +                * a new address is specified as a hint, just like it wou=
ld be in the
> +                * case of mmap. In this second case we don't need to per=
form any checks
> +                * because get_unmapped_area() will align new_addr, just =
like it would in
> +                * the case of mmap.
> +                */
> +               if (offset_in_page(new_addr))
> +                       return -EINVAL;
> +
> +               if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len=
)
> +                       return -EINVAL;
> +
> +               /* Ensure the old/new locations do not overlap */
> +               if (addr + old_len > new_addr && new_addr + new_len > add=
r)
> +                       return -EINVAL;
>                 /*
>                  * In mremap_to().
>                  * VMA is moved to dst address, and munmap dst first.
> --
> 2.47.0.338.g60cca15819-goog
>

--0000000000005bf88a0629015879
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
pTANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgwD+aCwRK6A4xbNbVvyHXh4chlzCX
vmumTUGMreySrvAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MjExMTY0NjU0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAF+C5XjPvg+TylCjWs3PfPxwpCpUcwN6J1EioOmJadmQt+no
NiV67AdlEhuWUVR9pR46iCDfxBoWrgz+llVC4qmikYYBiOSMhb1EzkN80KhRPNFjg+UaIzehpgMh
UV+lmrMpGsIU61EQyf/W0TXqhKf1b4qW2rC1ayryMHuUf8NTOrl1QR7hH6+wFo6TN+tkUwQchv8d
2bTUfTc4iAVdofpjj5cC26sLkfz6I40fewGzn42aBgX34P36hMFc8e9Cjs9yWDFgulfYIT1v807a
2mBOfCXIK+kDFvOLuzfEObZrEzAZRtoDMveXnuQVIBdbtUznm6UvXJnW11wdvA3HUcE=
--0000000000005bf88a0629015879--

