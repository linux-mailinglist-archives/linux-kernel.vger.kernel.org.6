Return-Path: <linux-kernel+bounces-287568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5695296E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5881F23450
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919E177999;
	Thu, 15 Aug 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tScpLZ39"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F481448FD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703990; cv=none; b=HTtHSTtaPJLNEyn0+29eNfunixgWD2QfrJFspk36tqPPB9UC0aPzBhV5LFVdJN+XGwYKs5jnPvcFBbpTxfjdYuNCsgdhrs9HZo8kGjbxz3E0lnqGvHithMiN0b6khKIKAwDHdMgF0yMLgFeJ5YHTGXa0xw3Jdn7ha09haom8g98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703990; c=relaxed/simple;
	bh=ofboGTk7Zi5bRne3eXQi4FNEA1q5CQ/5MTTobpcQ9wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcCPJMKxtqkTPUbM+eu81HPL/uGg/HbGdQZwoQgHJRoxF70Coji3kpZ9OIbZcD7uoqMKAw7i9VgFzry2lqqQL8FVjOB+QfWfmniWZKk5CSAE1rX3czSFhpuZ8hlKquQLYVJWlbUFWo0bnwRiTL5Jsjkxio1KPSTClY9njR0+Gsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tScpLZ39; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093f3a1af9so357481a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723703988; x=1724308788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbaMLK+XQjhH4yV/bFgYN8cKYTQ+/DDzMgI6nWFCLPo=;
        b=tScpLZ39htsCCgBM3HzepiiUyU7U412ahe0rdfaGiRXKRbdIwX/6+HF/4osxLxVh3s
         wAR2gfm3GidPZHO90W3ESGXeuZb6At8AcXiz1G1enpm02JZQdRTJ35WPHxM6wUDm38Ov
         56ICnRIx961meAn1sgHYjOEbhSd9X5AIRbH/6PjmxOYEaTXfFxjuyhUUheehPhsLZVCR
         ajAYvYaYl7Ub9jv+FUF6KwjNBFa2CA1WX1BlhjDSHy5Z0OQUYvmjCnyvTIh83VwByxfo
         a8czRCTFWG1LrkTpPTS2eINGnoix1gsnaenok9CsQdi0CpdXjipA1xfLEleTS+QfwRsX
         S2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723703988; x=1724308788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbaMLK+XQjhH4yV/bFgYN8cKYTQ+/DDzMgI6nWFCLPo=;
        b=LP9HxffUO3yGVgt4SQ0oMvbZNT/VfyzDX6h1szyPvv0RXoWusc7qAQtQrBhectb8rC
         GnrMC3KWI7mTJuv3I0bzV0TMq5RJSL2fYKjN1NAWUKTDcn0pm94J4wjowctf+5s8xnEV
         fT6rJ8OApAB9TPkmkoq68+0zTV7sxIKcdARolS35PDrOWYlrZsn0L0ufg579kzW9FpVp
         CdDqH/xhpueDYL7+RoWK/qOtiKXbHUQqWUK3xfiEdM7aYuuoXSZ52N2s/nOkBJ9Md9h3
         Zhjmu6UsqPgRlem9aCM/4z2Mm2/4TA1ji/Nx5i0b57VFgqLopbS210wsJKk+tuNyvYXH
         waOw==
X-Forwarded-Encrypted: i=1; AJvYcCV7QffD57oOH41WACsEQwjWdjBvtrzGWwvglZ/sMtvMx+yumDu5h+mGvoDvtV711N9Gp5Lx6g2HBB58U4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguLj8h8q5rSRY8t1aDT1XDl7BCnZQIpOeO0f8u39i6dsN6lC0
	Phdu3Y/6Xbm5c3jG70AcFfvaM06pigERYwsL3lMjqxC9nIYZFnEwTiX2X16xSgBvMQOKWLCbC9a
	MDaOZK8Z2RH8D1k4iwMtfRkPawXXZHgQ66J60
X-Google-Smtp-Source: AGHT+IFImIaPAUYQzr8PF6bkEdWd5/hDadwEyZbDoQt/62xTHr8zVvGiRtNrC91ziyD6IoKBgFtg6pWMoqUG9Pxdb3E=
X-Received: by 2002:a05:6358:2908:b0:1ad:10eb:cd39 with SMTP id
 e5c5f4694b2df-1b1aad68251mr611057555d.26.1723703987597; Wed, 14 Aug 2024
 23:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 15 Aug 2024 14:39:35 +0800
Message-ID: <CABVgOSm5SNAaYg61kEntXLtNS=u5foFeGRb+3AcUagmLpQGQ0Q@mail.gmail.com>
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: akpm@linux-foundation.org, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, erhard_f@mailbox.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eb3527061fb31b32"

--000000000000eb3527061fb31b32
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 08:04, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> The 'device_name' array doesn't exist out of the
> 'overflow_allocation_test' function scope. However, it is being used as
> a driver name when calling 'kunit_driver_create' from
> 'kunit_device_register'. It produces the kernel panic with KASAN
> enabled.
>
> Since this variable is used in one place only, remove it and pass the
> device name into kunit_device_register directly as an ascii string.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Thanks -- we've got plans to add support for non-constant strings
here, but the first version had some issues, and (Kees -- correct me
if I'm wrong) there doesn't seem to be any need to have this be
dynamically allocated.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/overflow_kunit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index f314a0c15a6d..2abc78367dd1 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -668,7 +668,6 @@ DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
>
>  static void overflow_allocation_test(struct kunit *test)
>  {
> -       const char device_name[] = "overflow-test";
>         struct device *dev;
>         int count = 0;
>
> @@ -678,7 +677,7 @@ static void overflow_allocation_test(struct kunit *test)
>  } while (0)
>
>         /* Create dummy device for devm_kmalloc()-family tests. */
> -       dev = kunit_device_register(test, device_name);
> +       dev = kunit_device_register(test, "overflow-test");
>         KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
>                                "Cannot register test device\n");
>
> --
> 2.34.1
>

--000000000000eb3527061fb31b32
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
hvcNAQkEMSIEILB9N74Sjao34XlaFa/T1uhHO8Qo0VVU/REQWK8j2A1XMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgxNTA2Mzk0OFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAmjG6W
n6+kRURu0TevEP5O7J6WTemcAuClFW5ZqxHccnBsPBh14iM8vQ9oPiyCeL8brBwct9SgjzRivDqI
9xfGGy7R3FQEBAW1rqSX6br45SS4IedI3ZK4A0ofHfZK68tAyGhDp77ZET1LPzQevCFxU3Jg6LJU
JVy2CpaKHbgLce2BKhB1FsMm0HwFttqC2GUHSi6EsVo3N9VYIdXRoT8dYxsjyAOt5kTawThx0BqG
YfijWikt4PZfPSElq2H5UbnR2Tij4FHorXCFrP5AAemkAANtnMbnVABEEsvZp/8qVJnnFeHVbW2H
U9qVhBtZbq8J50fK9bgIdETAJkVpRE4v
--000000000000eb3527061fb31b32--

