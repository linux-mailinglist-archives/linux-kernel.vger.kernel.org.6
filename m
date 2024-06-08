Return-Path: <linux-kernel+bounces-206992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E11901119
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B836A282DDB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE5D520;
	Sat,  8 Jun 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3VeDDb7"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFE176FDB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838436; cv=none; b=gxGPe7vnUx0zylzcjsBaiy0xqs98gZSozjXcARyRZduow69Bxlz3U6DLLypfDMOPrStPdCpg8fkKHnrnEugIVqc/jSSC/u60igyBmSOmh71OPSFykivnraZawxP9+roxzNleoeMd0MbAokTYAL0aLfDwVcIQB+Yv1OmSQA6Sm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838436; c=relaxed/simple;
	bh=snavFfIl1Y1+N76j9MsVh5hMmHOME2Qhb6Az4o4wENA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnRvNOi3y77mt8S3FHrXNdi466dMoycSnYImwXezbYuCy/xtTOthSlaEmsORJaTj+s0jmreHmvw6bMTXzQm1h9A3KrsozToB4DHwzubAA5s8bi47U1HPynzkd3ltfuxYvTSz1MNNyxkhiITxBdLtFIBauKzfLWTIZzLJqoCg4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3VeDDb7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4400cc0dad1so215691cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717838434; x=1718443234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9hLvgGbdz2bFIVZOaJRQud68pjvewH12g/6zgLurjo=;
        b=p3VeDDb7M2lni5Gt02VflKEuRBFnyKjjt4DIISacbnJHhua3Nscbpy9+nop0u4nLvK
         HaIDVKTj2gRPRmUW9jxxbY8gCi6ChkDbOMmLnsWXNFCxVjftDWtTX7tHVnVchxJW+bhL
         4wb7dt19N4AOTjIhhs9GejQKYg8M+y1QfVEUEf7xMv3xs3Cy4Xh0+KkwXxFL3qEW1t48
         i8zLP9smh4FjvKnZHyZC5q9CRd4DYhZVJS2VUq6dCCV/+dTSE7u1yLdnoqeJbpKJyUaJ
         +gle2m3juQRomy0nLA62fK1TBHWa7VVgEqhxQ5H32yp7L1XQqz71D0+8IByHkk5KrTNG
         r9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838434; x=1718443234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9hLvgGbdz2bFIVZOaJRQud68pjvewH12g/6zgLurjo=;
        b=HjWO4T9hYuBkewT9OMLJPzCK9U+FhUq7zfbniHojcNnxqfbFsG0ZHa+ku72LoNFM5U
         03sx7jUaL/WYhywWEwd0ej9/964ermxqQwqKaqnlW9WCGUk8WPCs0teDaxRJ0BplV8jy
         Wqmv2HWq48jYWq59ax28Nv4OWm3Ed1YARjLw0RDvYuAHDNiD7WBRl6xBwZ4qBRjLE8Qv
         QJCaIZFu77/W0XdRI+w47Hz8ZyBU/292f670TsZGJK6waErWERiw0nQHScGdgMekuurs
         f4cNBVNxM0yn3WvEnKSPIV1hF0uYGPwopodoLVPedaDe6qkIHL1egqL5lKFjqA8rJbwW
         iDPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzSvPppdTLT64eCf3Cdggm7q6+j5SRTCAO0Zr4wAeQvW8y6NiZw0NJUP0uU54+9Y5YVtRqIyertypNeq5CCSW4O1tJg1PlX8TT+Xl3
X-Gm-Message-State: AOJu0YwK71nbYJmMRzPdsDm7SY7AfcxGn2BzeQzGdRaoW6+hfHddyEkn
	o1vcm0WXOZzZ+I4eQGYVFkNm7WqI7cGBzB5NJz0/riVh2tuIy8vrHLKX+NuObORuQhl0VcFog32
	a56n4Yv0ka5j8yuyn/Cuo0HXSUzxqLoVvXOdk
X-Google-Smtp-Source: AGHT+IEkZaWubzFqUaW+MugQhideaEywgmWtl92Zcv3vR+wIhbNAGbxlNJdK119TvsaE5ioU7IvtjMap0ZQDtCwF78Y=
X-Received: by 2002:a05:622a:5104:b0:43f:dbfc:1f1b with SMTP id
 d75a77b69052e-44056453d50mr1884271cf.18.1717838433976; Sat, 08 Jun 2024
 02:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com> <20240604123204.10412-3-ivan.orlov0322@gmail.com>
In-Reply-To: <20240604123204.10412-3-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 17:20:22 +0800
Message-ID: <CABVgOSkHzgp34wYaQbk2gq-fNZtW_G5X6+Mf1Z6Ty3vPrCeL-g@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: kunit-test: Remove stub for log tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac55de061a5d6d93"

--000000000000ac55de061a5d6d93
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> Since now we are exporting string-stream functions into the KUnit
> namespace, we can safely use them in kunit-test when it is compiled as
> a module as well. So, remove the stubs used when kunit-test is compiled
> as a module. Import the KUnit namespace in the test.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Nice to see these finally work for modules!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/kunit-test.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index e3412e0ca399..42178d5a97d1 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -577,12 +577,6 @@ static struct kunit_suite kunit_resource_test_suite = {
>         .test_cases = kunit_resource_test_cases,
>  };
>
> -/*
> - * Log tests call string_stream functions, which aren't exported. So only
> - * build this code if this test is built-in.
> - */
> -#if IS_BUILTIN(CONFIG_KUNIT_TEST)
> -
>  /* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
>  KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>
> @@ -637,17 +631,6 @@ static void kunit_log_newline_test(struct kunit *test)
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
>  }
> -#else
> -static void kunit_log_test(struct kunit *test)
> -{
> -       kunit_skip(test, "Log tests only run when built-in");
> -}
> -
> -static void kunit_log_newline_test(struct kunit *test)
> -{
> -       kunit_skip(test, "Log tests only run when built-in");
> -}
> -#endif /* IS_BUILTIN(CONFIG_KUNIT_TEST) */
>
>  static struct kunit_case kunit_log_test_cases[] = {
>         KUNIT_CASE(kunit_log_test),
> @@ -871,4 +854,5 @@ kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
>                   &kunit_current_test_suite, &kunit_device_test_suite,
>                   &kunit_fault_test_suite);
>
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
>  MODULE_LICENSE("GPL v2");
> --
> 2.34.1
>

--000000000000ac55de061a5d6d93
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
hvcNAQkEMSIEIH7NJ742icCQpj8jDMTSBHagTZ3u0IIm4bCQAmy8APbFMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA5MjAzNFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMuX3V
u9ZDxlh3ob9CxC0W0ghnM7S9uHXeX3slxr2UtD7WVSAk2RMwcjhnaL8LvBHRV6nU/62xx0dlH4oh
GcFhlbD1XQBYF+Fm0tHfBSVEOa6WXC06uB4aQtVP/CNqTm3EUCweospzwoUE8Q4nfLxGadgHmhMr
O/nby+rxoKyWTdqioSTyI0IDWOPLmrb9tdZ612b1ElEvPhGTPxGSXMTeHr9ME+BVxHkfc6/1L/yd
B4ibhA2BCcXx4NG7HM2jI0FEMcMbdOE/DG3nITGTNDeatJywd4gU32QRImWmAPgsDhxMDbma80Qw
otOINH9bdHZNLk7YXvU5ybpHdYBw0id5
--000000000000ac55de061a5d6d93--

