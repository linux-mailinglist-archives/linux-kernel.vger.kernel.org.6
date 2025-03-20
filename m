Return-Path: <linux-kernel+bounces-569463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A7A6A350
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E657C165D29
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE125221DBD;
	Thu, 20 Mar 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTHIyN+k"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF62222C9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465300; cv=none; b=l2bsIC3aYDU/JUbPDQtsmsiegGv0OuqS1cl/kMVmSX2mXheV3+LuuwT1kq+VYmgg/VGgFpxbn6Cs61mIWYD1RLAgG/bcgZQm2xHXajW5EuCtlJ/GaT/ka53vA9hRwSw5vT6WGW7VlnBnTEUTmErORtJHkOes7S1SQ5X8Dt9+WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465300; c=relaxed/simple;
	bh=dVfmwKxTUQ6W+Xk6rURZaTD5J5vAinvloYHBn+HW6TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XS+GneG2qF30TpYN2FdZ1Ko2Bwy4TadD4NICeR+fRs/i8X2V47FKpBdbpC6VRNXKceSiZ9Y5s0qVTIV/LcF0P0DmbLZ90No09fgPje6oy8g02j5hBcMh6AywTwd/RgxcuNl+q/ztYGAAD+6XSKRGTH7x37CVPe6GFJV4nfg6kIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTHIyN+k; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3c4ff7d31so106046085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742465298; x=1743070098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IU69pi/dUA8qHWej6lIPNBORb5sMvBEuF7dt1TqWiGI=;
        b=nTHIyN+kU72F7ANNI0XjZTsOkdBn2El1IpKFe3n4vXh7RDoF2B8UtPzMg9Nvi0E4rA
         nzyojtqKC2WJQBVMKVi3vueEsGZpFi7rMHKNEGhN8lJgpIqKfea+BpaA2ltiQiA+sghk
         qjTTQLyolv3GY7Cp7IT3fKL7IcL8RL6UBLClMUGyEPV/9Fpqent1NK4DPxeloJKHaN5/
         xkfcrDeefGPGDSC8ylUDM23FvIPAHcxrKJyADB80J71mqVhDK7XmVKwf/ge5gIYa6VrU
         bgsgm0CBhaqVPgTSNZxBF7UpmyTQS3wBOTXXU0uMRfAHcubHLy9xaSWGRqFKaScI1Dfj
         8w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465298; x=1743070098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IU69pi/dUA8qHWej6lIPNBORb5sMvBEuF7dt1TqWiGI=;
        b=qYn4PlTP7BrUJbiRaoK24IgKm4v5QpAtqTrfc3C3RGEMxyeZCVzqFfztIcQ9lAu7HE
         RcsCFMB8b0kDThP0bmcSnX90yNU5MCrwvazakF92NglIWqp49OBw/W/N/1IgI2751RJk
         fQQQu4xcliMWThzgVy6Jzid+jfuEclKUd1lwy0bIdbmz1lSjE868S+9TUGBMa5F3K37U
         FJl8HW66hkNBUmrCHmS1namKeh+tNYEq8YTMEDz1VjVjZqEhYAuPHb0YNqeHDImqfaRh
         gHL9tzQu4jXKgo+rE9JmAUPeNx0yBMTKDSGMnjKZZuh2s9AGk6vmdeqBN9Yw5z/afoPL
         OC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWb88I80e4/TxFpp8U6MfQ+osSm81FZGBVDdwdRKTrtaVeb/bKvcOKqjQIYc9VJinnxRTsIVW4zUJZuB1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+28drI8QosZ/nuJQqic0RfyZTEFWlgZ1a5I9vIXszbSQWdJ1
	g7MOTHUexhSx0ib2Rf3CD8VTUng6AvLWCrKHT2A8OHWY9JzqpjRiBaW/jffdixhzDHRhIlnx5HX
	xercDKV9j+duRNw2Sqe/rIN9DwAa9XL2Bx2Cl
X-Gm-Gg: ASbGncuaYTvVIF76wo0eC2SAcMr70gT0rLcaXO9Pu+zmlH37kDKlaL7P/IoCvxI4A4n
	GfSzWltGcbPoQIixbEK1YRfxcIFCpRN0ljocuZqEQ9lae19naI0luc6dthAT8fxmNG29mdAkXn3
	wMr7ed6p1uePYdoOjpbXUYPEXkPp1LgqOnRM1+RQ==
X-Google-Smtp-Source: AGHT+IHNHvi1OxSnPrLFNmw5dmuwTMMwqoIjBnDxrgnFKGjsdg4Jx5u06WGbT/5/IdUBKEP9OkKavDsPS8jHoSsjaEc=
X-Received: by 2002:a05:6214:19ef:b0:6eb:2fd4:30b0 with SMTP id
 6a1803df08f44-6eb3529c7a5mr30459746d6.13.1742465297817; Thu, 20 Mar 2025
 03:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319223351.1517262-1-rmoar@google.com>
In-Reply-To: <20250319223351.1517262-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 20 Mar 2025 18:08:04 +0800
X-Gm-Features: AQ5f1JrKagi6lyT6_3_6AgKu9TAOexv8n4TuQ5ZqStfRZLJFLDxDVlwilWNcT20
Message-ID: <CABVgOS==Ot+L2Hsc_b841e6DcqyK1PUhWqK2+e_gqdWUpghkiw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix count of tests if late test plan
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000250df80630c35174"

--000000000000250df80630c35174
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 06:33, Rae Moar <rmoar@google.com> wrote:
>
> Fix test count with late test plan.
>
> For example,
>   TAP version 13
>   ok 1 test1
>   1..4
>
> Returns a count of 1 passed, 1 crashed (because it expects tests after
> the test plan): returning the total count of 2 tests
>
> Change this to be 1 passed, 1 error: total count of 1 test
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_parser.py    | 4 ++++
>  tools/testing/kunit/kunit_tool_test.py | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index da53a709773a..c176487356e6 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -809,6 +809,10 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                 test.log.extend(parse_diagnostic(lines))
>                 if test.name != "" and not peek_test_name_match(lines, test):
>                         test.add_error(printer, 'missing subtest result line!')
> +               elif not lines:
> +                       print_log(test.log, printer)
> +                       test.status = TestStatus.NO_TESTS
> +                       test.add_error(printer, 'No more test results!')
>                 else:
>                         parse_test_result(lines, test, expected_num, printer)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 5ff4f6ffd873..bbba921e0eac 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -371,8 +371,8 @@ class KUnitParserTest(unittest.TestCase):
>                 """
>                 result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
>                 # Missing test results after test plan should alert a suspected test crash.
> -               self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
> -               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, crashed=1, errors=1))
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=2))
>
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
>         return kunit_parser.LineStream(enumerate(strs, start=1))
>
> base-commit: 2e0cf2b32f72b20b0db5cc665cd8465d0f257278
> --
> 2.49.0.395.g12beb8f557-goog
>

--000000000000250df80630c35174
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg+Ok+O9MyNAWBwSnKBqT5wc2uoD2/
4BwPpu81ZSRyvccwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzIwMTAwODE4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAfqpbVT2Y3R/Dsq1wdgo2M50zBd7I6sRZmzFI/zLgEuO9b3biYLL/ldYNq5SdgKzx
w6M/+xo7ut3//fFHf0DkQUl7ok2DRqZHc9uf8z6xG5TKbYzwntmxomZHu8Iujip52sCuK1ugfWx6
LaYG9dJrOXQnnNgiOxSrvuQdB65mTIMwdND/+JWe6lvHcNM1Ob2w96LA7oeyGhp++Q8zhBb0dg8V
EMQ/nRN3AWk+T7Yj1bbUhQXzqpnauppWgLtP14HS3E/98Xpy+Vt/ngtx8spEWlJYG2d/Bd5g9zEb
GwufkhPTXcdtqEQROZWcJfhN8eUP4hHvtxI51Wr5miH1TYsS4Q==
--000000000000250df80630c35174--

