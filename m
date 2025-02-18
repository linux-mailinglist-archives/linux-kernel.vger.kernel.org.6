Return-Path: <linux-kernel+bounces-518724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD061A393C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D223B136D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193A1B87D3;
	Tue, 18 Feb 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xk0j4y5B"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8521B4250
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863782; cv=none; b=kum3Y3SzoUpPg3zt3dAmY1SDoPqs3c20hR1izvQQLN7TOEMhmGgjDLEkUj3dxPTkVFS3sF55qNWe474BCZByCwYCQ64LQj6OTZcWuBoilwMzYQjhzsveeX/aqhyf05Jo/UghvJBxtbgs/ChOa6yZM1bjYTPUUlNa60HWV+DivZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863782; c=relaxed/simple;
	bh=nspfy04LmDoeju8DUR1Kchlgyo4BoXF8GF3qsk2VR9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgDF04eCe2c3s9x4ZQ/K/Ps0SumcLvgGwGHODsM2cB3c/Xct1tnJjr749WEHO8gzNvbEPlkJ8rbYaAlyAqtQn9wlW5T6dl/O0bFcFuQ1Xxu6r7WETSm3R1DXA+ppq+/L8/fc65cYXToqK8gAOs/DAjEXOaRTkZx5kQ/6KlwqJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xk0j4y5B; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd049b5428so44361086d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739863779; x=1740468579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdv2DqBPrimZwbMzDiWajvEtd0goKRjUCF8RVv+Vp48=;
        b=xk0j4y5B1Ohw+QcRTZi7GJZe1cEWK274Xu1CTzt3PePthAEOkG93eK7CZcPUOfc0ka
         Q6nK5IFT5RkNcsMq//JsqCGyLocmqJ0TYgpWZIWDGTFyQ5OCbtgO6nxa0yM8cmTJByu1
         qfow/Btw0axilkhksFN40joNnlgJ2xBmwUDuyjchIf2fSohtU6k7YU4LXQTwNS+ikn3x
         ixzS6tWJrsEmV1yqPy4aVFzY+hfPxgm7aUXTGibG1Pue/GHlqWPx/Ycpg+jYY+P0TWH7
         Iye2ROzFNqkhxk2H4MjsVq1IQcXQo6eminhUC6Qcr5slmqg0GInm0+DmijH51qSoxXDy
         TkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739863779; x=1740468579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kdv2DqBPrimZwbMzDiWajvEtd0goKRjUCF8RVv+Vp48=;
        b=klxQJrUB6KNLgxL2zLzrofEXF+JxGQCLGpsHKsYsCqvOfGC6CbbYiHWp4tmLJTof+l
         l5KoOSpspDSGb9mEyZJmCkiTtZIu+1lwmMwfb5APS4DMbH4xmiJbSozmmHoyqKev4lwk
         q9YQAuIaNyd3Z3Zj9+NQuCm7Xno1TCc8FFX3dAu+NZop8FsRSfVvc5AuZWwaemUcq+zP
         +VVAf6ghR2bqowexlE0xymUW/rSIOe+4vK+QwBvIkIh+uLffbPZGaehPNadzSIr/UUjm
         ifUg3EgjLJ2kNU8rUV6xy2aZs1g+Gj+Th3iWhLkhhXpAJajqhMaW4/bW0BLM6X9AFdgr
         Ou5g==
X-Forwarded-Encrypted: i=1; AJvYcCURfMokuKFLvLqKvb2Dmo5E2HqYZYHgTyrkwF0JhiLFDWpzwm+IhGLxvomkfdtkOWg+Y+Y8KeAZ9XC1a0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPscej7L+hpz0e6CbyNUkVfXewdMFuXKq9IioRuvmeDKjT29/v
	AzIT8EZ0TJMe3yAGJU/OLCFdJcGHq4CyF4p4rbkyQAqLS4e7vNYCaaa+k2XFmHeUrlEFvvBtDVr
	/AlEfydtBpcmkk19ZvyLlC7Lxtr7lqdzMW+vI
X-Gm-Gg: ASbGncueXV+54qCq8iMSKsDevR56vD1KVHRiXRJ+NsgFAL3LxqJskDwyZbVhCWZVlJB
	0Un8evNj6UnRvfS1MXJoDACpnnB9+mT49OKVSaHvY4LCQlLHHn6XkmcP6K9mgQ1p2kMn6GxBmuQ
	==
X-Google-Smtp-Source: AGHT+IGuezCMWsCPE9g7FSck1C8EvVEcQwzCboDd4puWooNEzvCStZod6Lh5GdCvlyZEseN0/xLuPbzRnWohBEuGudI=
X-Received: by 2002:a05:6214:d07:b0:6e6:62fb:3503 with SMTP id
 6a1803df08f44-6e66ccbcb4cmr141989586d6.12.1739863779102; Mon, 17 Feb 2025
 23:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-kunit-gdb-v1-1-faedfd0653ef@google.com>
In-Reply-To: <20250121-kunit-gdb-v1-1-faedfd0653ef@google.com>
From: David Gow <davidgow@google.com>
Date: Tue, 18 Feb 2025 15:29:26 +0800
X-Gm-Features: AWEUYZkp3myCmGtgAoVGs1PAsj22rRaz253Tvgn6ryp35woYhYGT31Aw7DSxbRA
Message-ID: <CABVgOSmwVL-eX7RFJygP1ys6xa9XnGrfd2N5vB+_kw-FTJpAgQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Build GDB scripts
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000089f818062e659a85"

--00000000000089f818062e659a85
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jan 2025 at 21:01, Brendan Jackman <jackmanb@google.com> wrote:
>
> Following a similar rationale as commit e4835f1da425f ("kunit: tool:
> Build compile_commands.json"), make a common developer tool available by
> default for KUnit users.
>
> Compared to compile_commands.json, there is a little more work to be
> done to build the GDB scripts. Is it enough to affect development cycle
> duration? Unscientific evaluation:
>
> rm -rf .kunit; time tools/testing/kunit/kunit.py build --kunitconfig ./lib/kunit/.kunitconfig --jobs 96
>
> Without this patch it took 14.77s, with this patch it took 14.83. So,
> although `make scripts_gdb` is pretty slow, presumably most of that is
> just the overhead of running Kbuild at all, actually building the
> scripts is approximately free.
>
> Note also, to actually get the GDB scripts the user needs to enable
> CONFIG_SCRIPTS_GDB, but building the scripts_gdb target without that is
> still harmless.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

I'm happy with this for now, particularly since we're already doing
this for compile_commands.json, but I also think that this is a
symptom of the KUnit configuration story being insufficient. Not
really a problem for scripts_gdb, for which (as you mention)
CONFIG_SCRIPTS_GDB still needs to be set, but it'd be nice to support
this in a more generic way going forward. (The qemu_config python
scripts come close, but the .kunitconfig files definitely won't.)

Regardless, this is a distinct improvement for now, so:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_kernel.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index e76d7894b6c5195ece49f0d8c7ac35130df428a9..33b5f7351cbb5d0be240cb52db2bc1fa94aeb75e 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -72,8 +72,8 @@ class LinuxSourceTreeOperations:
>                         raise ConfigError(e.output.decode())
>
>         def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
> -               command = ['make', 'all', 'compile_commands.json', 'ARCH=' + self._linux_arch,
> -                          'O=' + build_dir, '--jobs=' + str(jobs)]
> +               command = ['make', 'all', 'compile_commands.json', 'scripts_gdb',
> +                          'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
>                 if make_options:
>                         command.extend(make_options)
>                 if self._cross_compile:
>
> ---
> base-commit: 521d60e196ecb215f425e04e9ab33e02beaffbe3
> change-id: 20250121-kunit-gdb-b27315b4f2d8
>
> Best regards,
> --
> Brendan Jackman <jackmanb@google.com>
>

--00000000000089f818062e659a85
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
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAHAzCnLVtRkCgyqhFEoeKYw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTAxMTAxODI1
MTFaFw0yNTA3MDkxODI1MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoH0MspP58MiGTPha+mn1WzCI23OgX5wLB
sXU0Br/FkQPM9EXOhArvxMOyFi0Sfz0HX20qlaIHxviaVNYpVMgmQO8x3Ww9zBVF9wpTnF6HSZ8s
ZK7KHZhg43rwOEmRoA+3JXcgbmZqmZvLQwkGMld+HnQzJrvuFwXPlQt38yzNtRjWR2JmNn19OnEH
uBaFE7b0Pl93kJE60o561TAoFS8AoP4rZFUSqtCL7LD2JseW1+SaJcUhJzLxStodIIc6hQbzOQ/f
EvWDWbXF7nZWcQ5RDe7KgHIqwT8/8zsdCNiB2WW7SyjRRVL1CuoqCbhtervvgZmB3EXbLpXyNsoW
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
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgQPL7TCaOiSW0fdVm/q7IUa/wat3Y
hlet3qeAG2aS+n8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjE4MDcyOTM5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAOb8FIzi3uizP2+yVt9bYIvzgXpuMG1TUt3Q11vwRQLqsvG
ebFAuLhTXmzWlAuUJToC2DOerds74/nSqpzAgifX+A6eAm8c+a1iNPTRMHsTfBHyrMAh3MJkvDoP
5n0N3qIgL90/+28qloSUi0NRvsVQIEYYs+KeJnu0xZTI7jodYOl6+uz5Hke47ps70GjG/s6Ml48S
MyPHB11FATPJfkaQJ6rKGzlUvmhm2skFvC5xiV3h+xoSuhWIUARNuCX0uOpYw8UvQVZarfWujkAm
EFJufvFGdg/p1tWKpgPUM8pFIxTihWtNrRPygMS5za+7tTv6/B9HL9onY6F4qBuuWos=
--00000000000089f818062e659a85--

