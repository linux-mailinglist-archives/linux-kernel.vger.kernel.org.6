Return-Path: <linux-kernel+bounces-552369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E786A57923
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A991890699
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65A1A264A;
	Sat,  8 Mar 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1g7Wa0QG"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84918FC84
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741421581; cv=none; b=Apt5z+Rp+upjWuQO6CgI58iOy78vbaEFDY+6uE0J9e/BKqluAFAGTyTV9DEtoQAJcefMjeK6G/TecqV8b2meKo2EiNxkP21ryHPYyFAnHd7k5IzyprEHsbIbI3l00wPfX4aT+5aiVPapGARFLZYc7XWvVk1XimXQMIZ0DUM6MGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741421581; c=relaxed/simple;
	bh=Qdgns2tt4dzMBZRXOpnGZoKO/0yAkUIZKUOqcGQkpeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZa/2y/bjFroXRtOsMGSn660CKd7WdiCd8vSTO2bavtPraRmZ0dvYjk8LJjpvpuTzY1Fm0bsPPGU4SoDmc0bsP1AYlqTEuCOsX+ZliUsUkkrk2x7kgjMisjTbZ1fbG0NRwcD3zDGcTM9giy5hUXHnX3vBaYaKagJRYAjlAv+BY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1g7Wa0QG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8ffa00555so13175036d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741421579; x=1742026379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H96XAlULFBfAFQ/n5/73tD8Qjl6oki8N6psChXwQQF8=;
        b=1g7Wa0QGcYbQlDRGl8GBP9L3+uxY5Vd+ACCK+SrDr31OF7g5maqXskoon0a/mGhDwf
         qZbv5okcm6TvWz6+h8axMO7kGeXKPI4a/WbjrHMxUxpXjXgMyfV+4/USlNJLYGRbF9U7
         AX5cNBN2bykDFY0mliba5RNjDWOcGT08sRXQ4/i7wj2BPPxMX/i1aKy7hmJmdrfGPlpA
         TBRSxlCLkNbxFs8Zk6tDUI1pCswITm1gaGBRsaauldHTzLu61BsPNYNA9C373As54v76
         2vEftFIchmgmBgT/isW/ECwCR7vXx8bW3Lc9S6ctKWeU76Gor5v47DWLchUPOZkBbA8D
         eoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741421579; x=1742026379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H96XAlULFBfAFQ/n5/73tD8Qjl6oki8N6psChXwQQF8=;
        b=szOV2dX8VUuKoXij0fg9aSZKx3gIoOs9xhzwMbwmLq+YQmpuYH0rH+s5w/kvqDlrBP
         I2GFjPqwzGmQGrP34aADRfavYVg+7oDMSwfqX9jrhG2xzzubj1y7Owh+xc2ln+LeHUSZ
         qYNZKj4VC4PQOiny9wsaK789GD81bCwQj28mS5Xn9GZ3FWdx9lWQnspOLQjVZxEX4MEu
         mG1ZGkNmK0460AUCR3PtD6znlQwRu7w5IIhzVS5lnD8KywCCCW4lP1XVc0I9qUic6acT
         EW4dDbg1pNAoAic63U6ci2eVpJNi70KDClJpwjYHDUPkGLHKSi50MxwAGN21wkfrP6T3
         ZEdA==
X-Forwarded-Encrypted: i=1; AJvYcCVx+FW6MOLOMvfC7xCLRu9HT9FgNi5E+lYkTaD42XTn1VdhWUBZ8VFweS8do68YZFT8UUgqdSfQfUZWG4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHWK7gSkTpsn5EvrRF4U9RCzado9Pp37tFVVJueYpitx+58bF
	xqGpRMHT/yLQlVpVLUbYP9znpO3H3MkQW7hFnZ9Wp1i6U4J2QFQ09BV/SHgsh5FrVYbM0bojT1F
	x94XJ45b/D7P3BAGVTkwcAIAD9Tqokiy0W5Cg
X-Gm-Gg: ASbGncsfcrnaeI3MM/+gRHCCFH68o4a8t1LK5eg5Q68gD3Gaas0eJOgUJVr4rgqS7La
	/KPykdLWyvRNpiWobJhBdNrhCZoxDEN2GR6LqWk8m/pVM7LWliWMBkS8IYr+tsumj1VQvkDVVjq
	9ZtV+q4jINysw+e7Z4YF7bqRUc1X8=
X-Google-Smtp-Source: AGHT+IGB5PU06Y3+NVN5AaXvml5buB1GoBNvSGx0K3x/KoXznP1orjTaf4i1ZFyYv5k4+8WUqOIKTIcgcHulgE4moDo=
X-Received: by 2002:a05:6214:76c:b0:6e4:2872:45f5 with SMTP id
 6a1803df08f44-6e900669eaamr86507076d6.25.1741421578718; Sat, 08 Mar 2025
 00:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306182009.2255241-1-rmoar@google.com>
In-Reply-To: <20250306182009.2255241-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Mar 2025 16:12:45 +0800
X-Gm-Features: AQ5f1JpVaxLH8aHAhJxFW4elT-YPwp7Oyz5AZDS1h5YSVoM2iPQhHPhuIBJGLCQ
Message-ID: <CABVgOS=jWjWJ_yPCp3suqSZj=bq8ugvZzJhgipCWLzYMS_DnGA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Fix bug in parsing test plan
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a1b0bd062fd04e71"

--000000000000a1b0bd062fd04e71
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 02:20, Rae Moar <rmoar@google.com> wrote:
>
> A bug was identified where the KTAP below caused an infinite loop:
>
>  TAP version 13
>  ok 4 test_case
>  1..4
>
> The infinite loop was caused by the parser not parsing a test plan
> if following a test result line.
>
> Fix this bug to correctly parse test plan line.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good. I agree with Brendan that this probably should have a
test, but I'm happy to take that as a follow-up if you prefer.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Changes since v1:
> - Remove error reported when test plan is missing.
>
>  tools/testing/kunit/kunit_parser.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 29fc27e8949b..da53a709773a 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -759,7 +759,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                 # If parsing the main/top-level test, parse KTAP version line and
>                 # test plan
>                 test.name = "main"
> -               ktap_line = parse_ktap_header(lines, test, printer)
> +               parse_ktap_header(lines, test, printer)
>                 test.log.extend(parse_diagnostic(lines))
>                 parse_test_plan(lines, test)
>                 parent_test = True
> @@ -768,13 +768,12 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                 # the KTAP version line and/or subtest header line
>                 ktap_line = parse_ktap_header(lines, test, printer)
>                 subtest_line = parse_test_header(lines, test)
> +               test.log.extend(parse_diagnostic(lines))
> +               parse_test_plan(lines, test)
>                 parent_test = (ktap_line or subtest_line)
>                 if parent_test:
> -                       # If KTAP version line and/or subtest header is found, attempt
> -                       # to parse test plan and print test header
> -                       test.log.extend(parse_diagnostic(lines))
> -                       parse_test_plan(lines, test)
>                         print_test_header(test, printer)
> +
>         expected_count = test.expected_count
>         subtests = []
>         test_num = 1
>
> base-commit: 0619a4868fc1b32b07fb9ed6c69adc5e5cf4e4b2
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

--000000000000a1b0bd062fd04e71
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgX1iqNa8pXyamSXxZY3BMs8PbeEAU
piSHVG7fNGKlIDwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzA4MDgxMjU5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAAC1CVY064HTXXJiCnW96Zx/UGvO4LfVU1uPzHP9lOG3KXq+YyLyZzVuh2GbU21Li
AxHIheRjyp5GHUUncMTlPZwydvZutE3Xu1eLsLlZoyStH9L+SvppTTIBlnYe1GL40W1wCvuv6TRB
MBERuC6IYfDzkk6Z4gaWYzGRotuKMWu0zwtaPwLXlqobhcfu5f9BaoMetmRLAzeSjKOLh+GjxbdS
nmczkD+pOMmnXV0cL/cyJ7Il46SHAwcB6n5a2x2kNl8tumMoHvzJqN+v34htdIe7yokfuuVXiNzl
tEdDVCqr3AcLlb+ssgZbI8fFECT2wxJPVqGxaubT9CFarGHPtw==
--000000000000a1b0bd062fd04e71--

