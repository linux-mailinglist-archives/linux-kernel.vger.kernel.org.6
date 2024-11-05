Return-Path: <linux-kernel+bounces-396121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE39BC819
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168C0B21E84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4081C7608;
	Tue,  5 Nov 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i64nlyum"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A881E89C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795826; cv=none; b=QVZAPog8bWRBMNVVx0yXqvFO4JZWKMkSwVlNnErpJHYNJsHYmdtdWnH+EbLp+PRE5LE0Ovq+UlfpCwYd1kM0bYuEgiVcdIe+8S6Gpt6RJzG2XMpZ7KzvMbmzlkzuP3LpWrPWfIVGB1kUORBu9XMFz9OYUYVEA2aXJ/UYbC/fIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795826; c=relaxed/simple;
	bh=U5nYfpD5nAYes/+++ITij8c/wuM3vysT6IWg3KlStV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExOjvoT/ihcTRlCDuHeEJbRGyPreuuJsxyEHWwchvYr2/06QgOHy3z8NapIdyHyFTuFrgyRVyBkycWBMAIOrrUfWizAhjCOKnXCPOhDV27ofDA/yn7f3zvBQdc5LovXVn/36gkbBmuW+XBhFFGSDY1APUWSGXkRwAuVYXrjytrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i64nlyum; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d18dff41cdso32318946d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730795823; x=1731400623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZHWGFf44Yt8Ws0iXygQ+kUVUlzh7YECvaGWGnUGsxU=;
        b=i64nlyummKuEWqaJFN0tN0agWRW4sEJH1skoG0bSPG2uzz16Wuo+SH4iwgVaR0Uvaa
         Q96OvT3W3oxtCvRG4wBv3H12Fit7hIFl6DdMA5kUHKOoXLpE82A4VF8e8lHWsbqRNqtV
         LW5jVU+7hPRXZiet4WtQa2BefkEaDDMFnnxFl/xRjzLzyfXxlVG2Zfj86cnYmG6xZQtQ
         Feg03acGtZ5wZAI9GS9z2jWB8PBh/fOCGalqODPSrgAUtbNua/7/GH8RA0TSjv0Yr3e0
         mmjwX5E2h8fIheLV/OcwTzCNaAwSOaKkcckNe2i0x0jnuz7vIpjNf4kpaKVZk13sQUqX
         QWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795823; x=1731400623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZHWGFf44Yt8Ws0iXygQ+kUVUlzh7YECvaGWGnUGsxU=;
        b=UHbB0t/4Ov4FQB19b30s7IK7IFsJLVn35let0FZU8GnI8bilTKGgaPm4vWEZOpvXYs
         nATIyATPWv418WLyyaI1HFH0pN2MKLUj+OTmLeYzwCwNKzJLgg6PeAQDi32rHhlJmjps
         aY8vQP4OEEbkq/c9A5MxsECGHPSUI147aM4RyO9UoLxYU93ZE4Mn/P7wzaswlEK1/HJz
         L9zMAXJn22DMx479pvjcKdgXxrzHY9F9ygpphoI+Hu21vS+mhNTYdEDo0CRcdVKqnH0Z
         E5aRGsp2UmHRFD//aT+HIG8yzVulv/lqTlaoFY90pQodjPRULB/4esVriRXvukxBj8vv
         YNwA==
X-Forwarded-Encrypted: i=1; AJvYcCUyx6EKjlKBIfFm7A77qsy2ofdyzBfa+imV6QfecwqhjlqqJflIaJHsa6aTWuhbgPdRhK/ZxI2BKgibxL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUye5yNWQfoNDikUshWv+rIEnlyR1zzYyARbXi39HX+sseAVZi
	oauR/4MwSL36+UP1DNlGTceXTKIddgPWDZUvCsvxDWzBMdnYlwuHZnFU7Vo60tFFyL0g0D0/wNs
	LmkJe3ykX91iXQ48WFkZ0QwgdmZu3W0YcWve1
X-Google-Smtp-Source: AGHT+IFUPXhnq4qtIizBNVFn0r5GMD9v9f2hAnQu5XH6SXd4uR9c3Cfnu+X1rfKNnkX+50J3Zzld+tjex2udVLwnOW4=
X-Received: by 2002:a05:6214:3d05:b0:6cb:e52c:c8e6 with SMTP id
 6a1803df08f44-6d185709c77mr444596386d6.31.1730795823357; Tue, 05 Nov 2024
 00:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com> <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com>
In-Reply-To: <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com>
From: David Gow <davidgow@google.com>
Date: Tue, 5 Nov 2024 16:36:52 +0800
Message-ID: <CABVgOSmBpDxR_6xQWSqMuBjvtQW=ATkGgrWsSygReKYdov1GJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: enable hardware acceleration when available
To: Tamir Duberstein <tamird@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000043eb5d0626264eed"

--00000000000043eb5d0626264eed
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Nov 2024 at 20:10, Tamir Duberstein <tamird@gmail.com> wrote:
>
> Use KVM or HVF if supported by the QEMU binary and available on the
> system.
>
> This produces a nice improvement on my Apple M3 Pro running macOS 14.7:
>
> Before:
> ./tools/testing/kunit/kunit.py exec --arch arm64
> [HH:MM:SS] Elapsed time: 10.145s
>
> After:
> ./tools/testing/kunit/kunit.py exec --arch arm64
> [HH:MM:SS] Elapsed time: 1.773s
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Thanks a lot.

I finally managed to dig up an arm64 machine and test this, and I can
reproduce the performance improvement.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_kernel.py       | 3 +++
>  tools/testing/kunit/qemu_configs/arm64.py | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 61931c4926fd6645f2c62dd13f9842a432ec4167..3146acb884ecf0bcff94d5938535aabd4486fe82 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -123,6 +123,9 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                                 '-append', ' '.join(params + [self._kernel_command_line]),
>                                 '-no-reboot',
>                                 '-nographic',
> +                               '-accel', 'kvm',
> +                               '-accel', 'hvf',
> +                               '-accel', 'tcg',
>                                 '-serial', self._serial] + self._extra_qemu_params
>                 # Note: shlex.join() does what we want, but requires python 3.8+.
>                 print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
> diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
> index d3ff27024755411441f910799be30399295c9541..5c44d3a87e6dd2cd6b086138186a277a1473585b 100644
> --- a/tools/testing/kunit/qemu_configs/arm64.py
> +++ b/tools/testing/kunit/qemu_configs/arm64.py
> @@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
>                            qemu_arch='aarch64',
>                            kernel_path='arch/arm64/boot/Image.gz',
>                            kernel_command_line='console=ttyAMA0',
> -                          extra_qemu_params=['-machine', 'virt', '-cpu', 'max,pauth-impdef=on'])
> +                          extra_qemu_params=['-machine', 'virt', '-cpu', 'max'])
>
> --
> 2.47.0
>

--00000000000043eb5d0626264eed
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgLw9osv+Io9/K7Kaqkdzf8agFO3p1
J0yGgZdU8S1FOv0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTA1MDgzNzAzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJu0fQN65Me44LnzUwa+a2h+Ry/uIiSiBXfBlz4vYVEYhlrC
BIboJYu6P9c4P2/YVujWklHCQq0eXEDDIQAW6OLMsyZlq5K1B+N3cunA8OfE8rNwdywSMXeE60fP
uplj2fcyedoKWzGSMuWEQggfssuukK1cUrzPZo+RmWMLAAzRxf4DXTgFuuXB7C67dFtLfxR1pHUz
1/23MK50zsYmjowgu4tqiNNPNr9YJYLC6cVDuP+vvMDcwmKE8nMPN6DOt3/il8ngTxQcppiu4RVK
Idd+vtvmDsHaEdUO45efaeKeYhSloKQXCKGyyZtHN13dtUZjbLOqNxVBsZH2OUCNf5c=
--00000000000043eb5d0626264eed--

