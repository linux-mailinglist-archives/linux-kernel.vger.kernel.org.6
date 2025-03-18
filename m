Return-Path: <linux-kernel+bounces-565680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76842A66D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B853B1F60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E91EF379;
	Tue, 18 Mar 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2FgQ+fO"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723D1A08A8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284954; cv=none; b=FN2rfLaW9nQ1FfqzKWHRNxTPLzLMst7eHnfZYlHAYGxs6Cdq90dq2IUoQKIQ130LkiCcsW+b64n4Hy4mssPY4Xrdv4GjBVPCT0zTninBN5ERJKo6RsIkRH3rRCMXahPCc8mPQIjyn7ZBy1h+85rQ8W0FC+t5aR185/AvGDzNQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284954; c=relaxed/simple;
	bh=OJhKJD4keJbrZmD+RDot0mHFvd3x/g+YArzam5Sqi/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mG6tJynOIcGHCwb32qSqv3pcfd1Vv2P2kQ6710SUCE7gbOfCUaJmg2SwSaUK8tqcb3zVp3U7ELAks+VPzUtI0Q/5xSZMRQPL925sSxz9y0ChAA3vQ1clhz+aCASGrLYBIbEujQyZTDnCkbwsq8vhPUseE0/1EoendzDQjkGESeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2FgQ+fO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso44292966d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742284949; x=1742889749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJhKJD4keJbrZmD+RDot0mHFvd3x/g+YArzam5Sqi/s=;
        b=h2FgQ+fO06bq3KhnqexeiypVGkrirM3tRZvYTyxySxtUZzw/CG4HNiOXfNHb75isNB
         Le2TkJfUV62ppiwDlly3PyPGJPXzEyMmyewlWM2GTahorGyb0W2kPWuPE4NEpq+EsjSy
         nJgNJ72Jyq7nlGVuxRCbPjQku/M8jim4jpnN3melSiJ+4Sz1AqR8DsorV73vftcY0uCm
         49a3I/6JXPWseEBjZxgTKQr9LqJbJz2zY33Xl3+71Vr7xA9/uVvi3zHUHdFJ5V69yTzT
         0DbqaUKjO9kT0W6HdVrkRO7RRLz02t3Iyqb2fqWbQtn2vLESqR8nzQOSa0TQKIamzlO2
         3A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284949; x=1742889749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJhKJD4keJbrZmD+RDot0mHFvd3x/g+YArzam5Sqi/s=;
        b=bPGlkknu+fuc6C3cyDLrCGCPWHPcpFnErzofgFlTaZ9jPeZGGCZELC86IeR3j0iSA/
         ZSxpoDRJeBeu3NRvUe6teyJ+NCMBYZEjikj4JycpKs/g4wJFSCT5NfimE7mllimysmlG
         iG+lsYSDsnEX//XxOhKL4Wjzow1qM7l9cE6/hpM9ede7gbkWq+nyMAG11IxZH3UeMQwi
         tUd6iOxLGaEX36+mUYgrV/MYOruLLvYCYliHsgHMMRW5Le4smf4dq6sfWCpulZEB3zzN
         JVQKKhcYpqUUA2+6ldIzH26TCx+CuvvgoHQpl1clciwwNKaihrpoM7s2ZaNRoD4RWk7w
         pKeA==
X-Forwarded-Encrypted: i=1; AJvYcCWm/9E6LGfvc3RI93dWpNzuT5P93hvVCDbC95hAVCBLUpA3nz6sKhz889NDh2rDFJVPiZCIqxSawJRnM4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmB1Fyg4l68cMSuRaxykBkTHWWD4VLp91uaBhB/K217GPl6Z19
	hfNmJrRQm0pIT/XdeY6mtyqHID08lN1XV1GU5zP3OsOFuVZ9HzNjQn2xvCbJV5/TZVZdgoMVNXq
	1/tKPzlMJqAMohm9PPXDjvc2sTfCfBVBz03vY
X-Gm-Gg: ASbGncsxYqatiDIBJvvIH49pF8Nzvzbe9pMZO0gD6K2Zcu47VNVWw1yfx/tLgzrTjPC
	H+BNZoHs3k1WuBS4ruthjVNnFw3S2bvzwAKcgLCR7oVj9l7qTi4vziRXlQMDsN/qG4H4f7ZGRGj
	p+L15FLXXLrAzpNREhBIX+1DQVr1EvIKqT5QOixA==
X-Google-Smtp-Source: AGHT+IF34bowB9DnchLGS1HtrhOPM6MA5sLsMtlmKCJ+4KJc1I+Faaxr0PpHxAFDrO2ZmG1WIsTFnpfDwGMLlWa3afI=
X-Received: by 2002:ad4:5ba4:0:b0:6d8:a39e:32a4 with SMTP id
 6a1803df08f44-6eaeaa62062mr257331636d6.25.1742284948609; Tue, 18 Mar 2025
 01:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316061429.817126-1-contact@antoniohickey.com> <20250316061429.817126-9-contact@antoniohickey.com>
In-Reply-To: <20250316061429.817126-9-contact@antoniohickey.com>
From: David Gow <davidgow@google.com>
Date: Tue, 18 Mar 2025 16:02:15 +0800
X-Gm-Features: AQ5f1JoyDgkyKfSn2ILKRx7lYGdBI8Zv__hsqi5zf37jqkfPw4u53_aSqKYCX5A
Message-ID: <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
To: Antonio Hickey <contact@byte-forge.io>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Antonio Hickey <contact@antoniohickey.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007d86600630995385"

--0000000000007d86600630995385
Content-Type: text/plain; charset="UTF-8"

On Sun, 16 Mar 2025 at 14:20, Antonio Hickey <contact@byte-forge.io> wrote:
>
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---

Thanks, Antonio.

So this looks fine, but it's also a bit annoying, as the remaining
KUnit/Rust integration patches[1] were recently updated to use
`addr_of_mut!()`, so either this patch, or those, will need updating.

In general, I think changes such as those in this series are going to
get progressively more prone to conflicts as Rust is adopted by other
subsystems, as the 'rust' tree won't be the only one carrying changes
which could be affected. Maybe in the future it'd make sense to split
these up into a series which enables the new feature, and only then
put the warnings in place in the next version?

In the KUnit case in particular, since the patches haven't actually
been merged yet, we have three options:
- Merge this into rust-next, and send out a new version of the KUnit
patches which depend on it, which then are also carried in rust-next,
or delayed (again) to 6.16. I suspect given how close to the merge
window we are, the delay is more likely.
- Merge the KUnit changes as-is (either into rust-next or
kselftest/kunit), and send out a new version of this series which also
updates it (probably in 6.16, but maybe sooner if everything goes via
rust-next).
- Merge both, and accept that there'll be some clippy errors until a
follow-up patch fixing them is sent and merged.

As someone with a vested interest in the KUnit changes, and at best a
mild academic interest in the addr_of_muit!() deprecation, my
preferences are with the latter two options. (I'd also, in general,
whinge that the frequency of new Rust versions / warnings is high
enough that it's taking a not insignificant portion of the limited
time I have working on Rust things to understand and deal with the
churn.)

Regardless, apart from the minor irritation of having to learn yet
another new syntax, I have no objections to this patch in particular.

Reviewed-by: David Gow <davidgow@google.com>

Thanks (and sorry for the grumpiness: don't take it personally),
-- David

[1]: https://lore.kernel.org/rust-for-linux/20250307090103.918788-1-davidgow@google.com/

--0000000000007d86600630995385
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgbW0wDv8MxuJgkskbbt7IUunJFrIN
XG4ql/hgZR/dmx8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzE4MDgwMjI5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAQ0lfhqtQBRad/bJb8DhiA6qgXZBOer2EYv517emWEW2CIl2ppC58FG65OHhAxYj9
ql8Bd24peRIhWRxcHiEEBqzEK2pMvHBdNCX0ScagGJfkupF+emZuahAbh3WLTMyVx2fw5oCSeGq4
snelKEetKtZ5Ecur3jIEN6ubgKZBQ8K4cjpVpNLSpB+Xdwps5DqpBfwI1zFqhUXVqjc0wYTC6qKz
+3+naCGFTlSegv+hK4Pf3dbZNNDQ/E3hBrssi/lJUy0W2e9H32oimIdQKkZYXroWUrcWLJiwbkib
qRBYxrDg9RrR6aXg1NsF1ymWQEa3KhWC1f9pb0b5ANDK9j1LNA==
--0000000000007d86600630995385--

