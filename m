Return-Path: <linux-kernel+bounces-372646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7A9A4B68
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB0B22DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 05:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C51D798B;
	Sat, 19 Oct 2024 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLYOxVgE"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F071CCB38
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317276; cv=none; b=c165e+0MnyBEhMrYFM0FLBtZYqbvdLOtHXQP0MGS5CoNN6TYoA3k0oWSL51Z5uCZJQ2ggVu+aFhiSOVOIMiidP9Ow3gJerqnI4NmxAG7UF/cAG8YlyzSdjB1SWcZ8i+nfiouryCsHruOzAqup9x1nxYM1aTKiSd+i/x+F58qEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317276; c=relaxed/simple;
	bh=C9sPC4FxEGLmIjr/8xIho6bd+yPfi2poWk1ZbVG6GVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBkdhXOvYABlzUM/tvBUNo8ENYZoWGKc3AcImKUqjjl7unCm02Y6X99D9ufi2nOhTxf097D12xTFISiPA7OgxAlKMs4ylgFZ7XvoCc8xVM/a3dfwsTHsguDjcNYNj7G7am7WDybLpJOq4sLNOdW8kqjzwvnTvktShg5h4+L+jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLYOxVgE; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b150dc7bc0so190204185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729317273; x=1729922073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0E+60/tHMITKXGhpojhDK1PTvA6JqABmRjxkHlS0J4=;
        b=cLYOxVgEMxavPFzeD6sTDZstw7QapiPkyyD9iO79KaV1MJy6TD4kbiVUMunmK5KWpu
         EKRUq0XHz6wZnqezcP3ylQVlLoLvvHU5IP6ZTeULDMOMaSo/03CD3u5aVpCvPvqo6jUw
         A2Couir+6CgCCMpkrU2jg3wMrBb8UpVzVs2QIYzpika5wfbzZiJ8u7LAMWEL3q7u5K1E
         Z2RSF+aXD9Zm1cJv5rv4IQ6HkvGj8IMcpm+xOATwGCi21PKyn9RpFEkGqp4qRE5SQK4N
         aAfNCzOBGhy9lrY1T+HaBTSJ5XqTW7U5juLS7nhKfhz4EoQu3wAatjTmuqnEIPXUqNJc
         A3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729317273; x=1729922073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0E+60/tHMITKXGhpojhDK1PTvA6JqABmRjxkHlS0J4=;
        b=RZIuusl2PkISDppCUbym1AVJ+mGZ8wJR2Oqv1TSW+BgYai1fxi/8BNyI6uxKe8G3Pz
         SJFA3r91aOLDIdg4r5T/E1sx40NHqNlattUxK3rmt8zOiKueiMTQMEp6OBRcXCLFgxTg
         F/A5GzM0TRtgHpkXuwOLZwC+jbYGzL5QW5qXFNBOIKQQobiMuYyjpfj/huzKdmo9A8yI
         j6uX1csYFJzEjrlmxzK7kzMrTEoamp1HC5g1ls8vzi34joqj8F6kgJ/mzvRy1qd9qaFY
         x2STZE3zfaaK6vF3rWs9PYxTDVVXGHvv20aUzI2hCfBBNCeYlyzLuyQu85K/8+untr76
         Pxbg==
X-Forwarded-Encrypted: i=1; AJvYcCUGaAsw7Hwq/zHD8PxAjbI+BRzzOECWmNQphe8KDuZ/MwDHcDHb7sWDxEsbp2T/HsxzVOjdNnMQmfTkuF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRrIj818vQDqKNnd0OSnj7Kklk7bLCcB4x9x2zDuWSkzJ0nye
	x5glRQPZLlxnJPyj7Xp6UB7PBht6/rUOczEN1e7UeJY1AXt1sWlw/CY5h95mDnzEvzeVuQHeNYS
	pyI2mB0i0RyBspJ8mfMA/7IgwS44kHKWBFlD+
X-Google-Smtp-Source: AGHT+IGmO8jNZKQmZviqF9ZrtvR4vUsw3MnJDxt1DvMGWUWGlkgItaPlO3tGbpKayXM2Mn6TUJhKJlyqyiOmUhigSdE=
X-Received: by 2002:a05:6214:4290:b0:6cb:f7d0:f627 with SMTP id
 6a1803df08f44-6cde16650ddmr68072616d6.46.1729317272512; Fri, 18 Oct 2024
 22:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017231007.1500497-2-davidgow@google.com>
In-Reply-To: <20241017231007.1500497-2-davidgow@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 19 Oct 2024 13:54:18 +0800
Message-ID: <CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com>
Subject: Re: [PATCH] um: Fix misaligned stack in stub_exe
To: Benjamin Berg <benjamin.berg@intel.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c3feaa0624ce0dab"

--000000000000c3feaa0624ce0dab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 at 07:10, David Gow <davidgow@google.com> wrote:
>
> The stub_exe could segfault when built with some compilers (e.g. gcc
> 13.2.0), as SSE instructions which relied on stack alignment could be
> generated, but the stack was misaligned.
>
> This seems to be due to the __start entry point being run with a 16-byte
> aligned stack, but the x86_64 SYSV ABI wanting the stack to be so
> aligned _before_ a function call (so it is misaligned when the function
> is entered due to the return address being pushed). The function
> prologue then realigns it. Because the entry point is never _called_,
> and hence there is no return address, the prologue is therefore actually
> misaligning it, and causing the generated movaps instructions to
> SIGSEGV. This results in the following error:
> start_userspace : expected SIGSTOP, got status =3D 139
>
> Don't generate this prologue for __start by using
> __attribute__((naked)), which resolves the issue.
>
> Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
> Signed-off-by: David Gow <davidgow@google.com>
> ---


Okay, it turns out this breaks clang:
arch/um/kernel/skas/stub_exe.c:84:2: error: non-ASM statement in naked
function is not supported

And, looking into it, gcc's docs are not encouraging here either:
https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html

This attribute allows the compiler to construct the requisite function
declaration, while allowing the body of the function to be assembly
code. The specified function will not have prologue/epilogue sequences
generated by the compiler. Only basic asm statements can safely be
included in naked functions (see Basic Asm =E2=80=94 Assembler Instructions
Without Operands). While using extended asm or a mixture of basic asm
and C code may appear to work, they cannot be depended upon to work
reliably and are not supported.

My gut feeling is that the "correct" way of doing this is to use an
actual crt implementation for __start. I managed to get it working
with nolibc on x86_54, but the sheer amount of hackery involved was
not exactly encouraging. There are a lot of conflicts between the
different headers for a start.

The other "correct" way would be to rewrite __start in assembly, which
is annoying as it'd be architecture specific, so need a separate
32-bit version.

The less-correct-but-working-here way, which I'm tempted by for now,
is to get rid of __attribute__((naked)) and just use
__attribute__((force_arg_align_pointer)). That's probably the best way
of fixing the stack issue, but obviously won't fix any other issues
which could arise from __start playing loose with the rules.

My current plan is to send out a v2 with force_arg_align_pointer next
week, unless someone has a more brilliant idea.

Cheers,
-- David


>
> See the discussion here:
> https://lore.kernel.org/linux-um/c7c5228e9de1e79dc88b304e28d25f5ffd7e36dd=
.camel@sipsolutions.net/T/#m90c1c5b6c34ebaaa043b402e97009c5825fd158a
>
> ---
>  arch/um/kernel/skas/stub_exe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_ex=
e.c
> index 04f75c577f1a..722ce6267476 100644
> --- a/arch/um/kernel/skas/stub_exe.c
> +++ b/arch/um/kernel/skas/stub_exe.c
> @@ -79,7 +79,7 @@ noinline static void real_init(void)
>         __builtin_unreachable();
>  }
>
> -void _start(void)
> +__attribute__((naked)) void _start(void)
>  {
>         char *alloc;
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

--000000000000c3feaa0624ce0dab
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg4FwZdB4bJ6qLaO9dZ5tG4s3U4aeb
2pMvhPcgu4H6EzIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDE5MDU1NDMzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBALYfYLgnV9GYwaUlBsaT4gCq0pB1sH8qv4O37XOq7GqbXGbU
eRePNwfrnl97OKYsPphJIWv6aM+cOaBcEbU+GnRrN3v4uwJKHF8CNYgnFWfErPW+RxmOFj+l/c7f
wP7xpsYpt/q9vGWPwa3eB3YvzppSOGkby9ArFN69fhxR5K5+Djce7oirEdY2ZCm5zDUgY6VC9em7
/uYh58HiGAjQFxfRfDUyXV/Rz9+sxSk2Lxx9AtFdAyVHIvOtuZbWfaKk5Rih8O5Ca5FbMuwxQWqS
R7aLLk4dJC4R5zhmWlFJ93Gvt6mEtbpYrocE8s7UMo5dGBUX828iG26/E0/px4teXBM=
--000000000000c3feaa0624ce0dab--

