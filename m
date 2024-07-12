Return-Path: <linux-kernel+bounces-250239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C306192F595
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E631C2204F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEB13D538;
	Fri, 12 Jul 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V13ioZGH"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9A567D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765900; cv=none; b=glSAmknKZIUFz+RNJnDdZ6ZjguakxkEEyQCs6qR283wLd5FcC4Zkt/aGUy9ldbiSI8b5BKuVzsQzjVmFaVVlYX360rgIPnFcDYw8ypG9dvC87PQFyRk98//Dh6dBsT8LHmyGFCKgzmnoeiyXdowp8xug+GCPbHgC57UrZ6Bwy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765900; c=relaxed/simple;
	bh=f5NygRcMG6twAUOgyfS6hW55fWgYPzP3H27lqLAVqPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRDeiWgstP1CGbzjutg/+SSm4Yvz55elS+LDt5N7oGTQUOTrtg31qc7gGSxziP0yXoGHV1I/aY919pD08oMavN9fcfTw2rJxCw0rH+WDiMpGT8t4v8jgVflV8YK+iD9TsBqTv00VI8hlYKHcf/5t1pg0KNkHcnv9Ha8r4EnkNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V13ioZGH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447f8aa87bfso203461cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720765898; x=1721370698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbZy6oG6LoMz/FIRHm6B/R/SktcIFyAwmfoizc2xd/o=;
        b=V13ioZGHJRnDTEE4i5ooqJR84Cy5LJybrCR3tFD5Aa3wmVaC+E0XkSKkuxuFn6CRbl
         up4XX9IKGz4h9hmzST1BP8ZoXC8+vbIzAWqenWHhCeY0vG7YWjISTHrCqXHnDPYDgUnm
         0P7HBUpjPmaOV1Vymu464jy8Q8e4690JzGf+09sPPXAiL3NzkJtC1rsz5ztRp2s22IS7
         1M8G2V6lB2xluyFN4O2Gtqlp0DJzfo9p56WGFyMFuH/tC7ZCeyNJ0cmIY+kp0aa+x0np
         OnE2w3GA9YJRX9x5V8Z6ih0JdUJcoarhlewdNcMKXqvnAe1HmPVuedJJfTf9IQEXEvaV
         AMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720765898; x=1721370698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbZy6oG6LoMz/FIRHm6B/R/SktcIFyAwmfoizc2xd/o=;
        b=IWUjxaFikoUvHCn4p2H3tPKYIFD/rKFuIga8mqe742RsLGiYSs0M2BpltCS5HFwY0N
         opebKcVX+F7PKPb/M3/uPTTSwW6UoI0gBw6d0T4NhZjuHQvOf/hULuVuFl3LUqR7L4vb
         sstNMTjA+2aCbkp6st+JsX658o/JUQ5omYst504XGa8RyC5gy9Xei3xVt0upqEvjUDLn
         zTyJ+ayM4lkhvII6OQzsncRZrdr4MlYD6B24OpRLZqZNmh/Zb66YxbPCWOJkMhjQZkba
         CCms4pc+TLPVq/U5Vm8rTxxvuEA2D4Bvt7SlSBAuKUaTilyCZkpKawlr+lDwPR4ep1bE
         v5+w==
X-Forwarded-Encrypted: i=1; AJvYcCXRL7pQThsPG6GSqccFD2nz6fTdkfgYdZAovU1pgWgZNBCvCP+yEJP+yif6iXfWxHWEj/pHApze4cYddfxMpG3YFKxM+sBYAGwh7osA
X-Gm-Message-State: AOJu0Yyy4bZIKvWwbno/IWxwuBs76zOXy0AVhQWmzjY/AKFNfH3VLcqV
	D+J2V6G1nYJNuHFLMZ0gRhffsvurRNUJj4y4HqribyX5tJlUBBVUjbBGKsFgexfHbMVUTCeDt81
	EzkmNw5hUdjPqIvDNNrm2VA1fpX51EVbH4VoC
X-Google-Smtp-Source: AGHT+IHudazI3OhmszQv7TNeQIwVmUchUQWwuWIwQfbE7Bg6jPVm8CjypSd+eY8i7HoxtMndWrJN8df+YumquTraajg=
X-Received: by 2002:ac8:6bd5:0:b0:447:d81a:9320 with SMTP id
 d75a77b69052e-44e758fbba9mr2016931cf.20.1720765898093; Thu, 11 Jul 2024
 23:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com> <20240711193931.109771-1-ericchancf@google.com>
In-Reply-To: <20240711193931.109771-1-ericchancf@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Jul 2024 14:31:27 +0800
Message-ID: <CABVgOS=bcvRoDfGxv6dvEirGAGpXPs921iH12w9x9TEob6NDbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: Rename KUNIT_ASSERT_FAILURE to
 KUNIT_FAIL_AND_ABORT for readability
To: Eric Chan <ericchancf@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001fcfca061d07087f"

--0000000000001fcfca061d07087f
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 03:39, Eric Chan <ericchancf@google.com> wrote:
>
> Both KUNIT_FAIL and KUNIT_ASSERT_FAILURE defined to KUNIT_FAIL_ASSERTION
> with different tpye of kunit_assert_type. The current naming of
> KUNIT_ASSERT_FAILURE and KUNIT_FAIL_ASSERTION is confusing due to their
> similarities. To improve readability and symmetry, renames
> KUNIT_ASSERT_FAILURE to KUNIT_FAIL_AND_ABORT. Makes the naming
> consistent, with KUNIT_FAIL and KUNIT_FAIL_AND_ABORT being symmetrical.
> Additionally, an explanation for KUNIT_FAIL_AND_ABORT has been added to
> clarify its usage.
>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---

I like this much better, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/input/tests/input_test.c |  2 +-
>  include/kunit/assert.h           |  2 +-
>  include/kunit/test.h             | 13 ++++++++++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
> index 2fa5b725ae0a..9711ced180b8 100644
> --- a/drivers/input/tests/input_test.c
> +++ b/drivers/input/tests/input_test.c
> @@ -31,7 +31,7 @@ static int input_test_init(struct kunit *test)
>         ret = input_register_device(input_dev);
>         if (ret) {
>                 input_free_device(input_dev);
> -               KUNIT_ASSERT_FAILURE(test, "Register device failed: %d", ret);
> +               KUNIT_FAIL_AND_ABORT(test, "Register device failed: %d", ret);
>         }
>
>         test->priv = input_dev;
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 24c2b9fa61e8..9cc86a402c34 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -60,7 +60,7 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
>   * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
>   * @assert: The parent of this type.
>   *
> - * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
> + * Represents a simple KUNIT_FAIL/KUNIT_FAIL_AND_ABORT that always fails.
>   */
>  struct kunit_fail_assert {
>         struct kunit_assert assert;
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87a232421089..774c42721412 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1193,7 +1193,18 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> -#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
> +/**
> + * KUNIT_FAIL_AND_ABORT() - Always causes a test to fail and abort when evaluated.
> + * @test: The test context object.
> + * @fmt: an informational message to be printed when the assertion is made.
> + * @...: string format arguments.
> + *
> + * The opposite of KUNIT_SUCCEED(), it is an assertion that always fails. In
> + * other words, it always results in a failed assertion, and consequently
> + * always causes the test case to fail and abort when evaluated.
> + * See KUNIT_ASSERT_TRUE() for more information.
> + */
> +#define KUNIT_FAIL_AND_ABORT(test, fmt, ...) \
>         KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
>
>  /**
> --
> 2.45.2.993.g49e7a77208-goog
>

--0000000000001fcfca061d07087f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIEo4wi5EcC95LDeHxSSJuTeI1csD/t8IG5mlBu8Q0/riMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMjA2MzEzOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCKiSLv
0KaWDRtHBFC6f8VgKvcx6uhJ/yng9Ri8fx95Bta2qupwcc22VYkGimEVzTiQV0S5RCmSsZ/EBB0O
Xw1lny5UEzCzPCJQIq5Dwzo8JNLXPhvHRwRmsrHgXtMb6qvZucaW+YSc8SbDu1XGU8QhWwp6KqfZ
kRGChV1UlnwJT9KFfgLyijU0ilNHxFLmp3JIY/FkOeipJ56u6iV7sciY5LXp9+RII9o0Ch8R0+sU
HoWagc6SlTZH3B07DtDUH5XO/FLR/HgZ8w2srpPu3EFz4yb9o4bM2PdFX8iRWr3CI42szEBVlNyH
3TGbuk5nuB6XxhoM5EKGYmtRNKmrxw3p
--0000000000001fcfca061d07087f--

