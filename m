Return-Path: <linux-kernel+bounces-248555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52AF92DEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61EB1C20D01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A0422301;
	Thu, 11 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+pLKir8"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AE1A28B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669752; cv=none; b=hYLTrhF5/iUf3daEIOY57mguGEXwKgFOrpDCDV6b2n3b0AkTmUdps0XhYs2yb38AKyhPYXW47vg1zxIdPn5TsYpvF+n00Z39pJaVl9yf1eKe4kVQUUW2akvfl0mjwcSi9uRjlvXUGaDIAF1PzppGgFik2wA0FqeN4sX1CUttNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669752; c=relaxed/simple;
	bh=OOSIaDjUKxx8ppT+WEWMcZVFF25MA0WR2g8F/xeMge8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Az386H9w/2xsMzF0fOTgrHS5BHRtXycuQofOYu4yw6TZWNKF+8HnOIt5mDOatttD9AyuwECGKDfA1kkgpUgR0iOoQrL7ECSvi4j10JX/XstzCekBAcaJ9HYh9MsalAUD9fQdQp9Nt6aXohUTFGedRD0VmyfybUmTVI11WRofd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+pLKir8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447f8aa87bfso225981cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720669750; x=1721274550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JHJURosDxIVNeWRriY7YneHWnhGXjqKpm6wOgWTjRuo=;
        b=T+pLKir8wHPOZuaaW95A+RVLpc/4axN438HvV0tsovPQi9/TqAau2yP0jbOEYV5l/t
         7MenCmtpalDIuKRGzEOGY8Tgc4B1zUiiNjCLImvY8xZljaze8CVtcf+NuXgQkrrgBTEA
         1YhMzIEyNts356UU+X7XEUEu2mIIQsmfXTQPt1c8lXKNVVCqrek4q30ZA2Y2RcaDsxR5
         Ysl/tY0jJkxmvpIyAosVSSSXXOolTWW9wNbwpHDOyJfH/O3lMBAHNSFCV5vuROali9uh
         xcSdexJ5O8c2SnFSpNlvu6sT0jLKHljutfNXaF+Ssx+G9hkop4cMzhoq5VYQ/dYUzFMy
         NfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720669750; x=1721274550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHJURosDxIVNeWRriY7YneHWnhGXjqKpm6wOgWTjRuo=;
        b=B+Mk6hext2QXO9tpBSi54CP7Nxqz5TaKuDxsFi4fO9jsKgi3xSvDTlSShVpvr8Bnzy
         jCpxofUAB6kJ3+WFwt6s/E0Kjlehduy/W3OyZAJi/b8gwq3TxZA3FmBCRTVWqVymLXwC
         kXRNoHDLqvr3wQM6sQPGpTB32+sXPt6TYSyBOGVfIvbFxOONvigKno/FrB5hHgRIBV7e
         b19lWODgOxQENXI8VaoWuhtq8c8Yafuus9UcehbIsAi0rnC2nwxDQWAQdR4gVahRN/dt
         WAmjqvTtqgF/JVtqIw8MsmVKKfhysUZnwkFKykz67Hqm1Fx5OrgNrL2lHuSbtKCzeYqN
         vLNw==
X-Forwarded-Encrypted: i=1; AJvYcCWWNyZ+sm+y21WeQZId2A5UbNleN7CBQb0BULwgF/powheND9pCyXP84ZXgHJdAdu5D/GO8AGszkLVx9XPVDwpYPaE6fCD8+kUuVABe
X-Gm-Message-State: AOJu0YzFrMRqFUvvrCAkYcEsA14AMBcJjh4mRz9wC4Ga8U6f9RDzYvJV
	d+bQizq484jYzPA8R1u9ibr2dNwLKfq5bL1Sfx+moBua4FkyJAHzHxLaGmqOg73exLHZyz3/YRz
	ge6P8Q4rVx51lgL9VTTKrPz2E9OYpp+3KYkxF
X-Google-Smtp-Source: AGHT+IEKVUKYb9pPK5Ipagk20mplMUADJdr9kdqImKsxzlW8QBUxWV83kXFBGju5eUOEzIySL5zYG4wmcoC+SKphKKI=
X-Received: by 2002:a05:622a:601d:b0:447:daca:4b25 with SMTP id
 d75a77b69052e-44d0ca65cc3mr1891601cf.28.1720669749986; Wed, 10 Jul 2024
 20:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710170448.1399967-1-ericchancf@google.com> <20240710170625.1400724-1-ericchancf@google.com>
In-Reply-To: <20240710170625.1400724-1-ericchancf@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Jul 2024 11:48:57 +0800
Message-ID: <CABVgOS=4N3GMjBsTnW=jbzkZbqo4Wwh5wpLod0_r+A2q_vxnGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
To: Eric Chan <ericchancf@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f57a2061cf0a570"

--0000000000003f57a2061cf0a570
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 01:06, Eric Chan <ericchancf@google.com> wrote:
>
> The current comment for KUNIT_ASSERT_STRNEQ incorrectly describes it as
> an expectation. Since KUNIT_ASSERT_STRNEQ is an assertion, updates the
> comment to correctly refer to it as such.
>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---

Nice catch -- copy-and-paste strikes again!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/test.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 61637ef32302..87a232421089 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1420,12 +1420,12 @@ do {                                                                           \
>                                    ##__VA_ARGS__)
>
>  /**
> - * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
> + * KUNIT_ASSERT_STRNEQ() - An assertion that strings @left and @right are not equal.
>   * @test: The test context object.
>   * @left: an arbitrary expression that evaluates to a null terminated string.
>   * @right: an arbitrary expression that evaluates to a null terminated string.
>   *
> - * Sets an expectation that the values that @left and @right evaluate to are
> + * Sets an assertion that the values that @left and @right evaluate to are
>   * not equal. This is semantically equivalent to
>   * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
>   * for more information.
> --
> 2.45.2.803.g4e1b14247a-goog
>

--0000000000003f57a2061cf0a570
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
hvcNAQkEMSIEIJRybzE66oeq/89q1LarO9U8GQqRAA5o8K+vM8orkZ1AMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMTAzNDkxMFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAGnsXq
De9EQJ5lbigGRe2jNr1noRmygzmTLHZG5slXVOdmy56HvD5j8JsXHPP9tNgRxT1qPhZJlbinrmtd
N015u3oDdAXQANo1f356s5Ct8ZKB1rb+o9MscbEe/JEhn4DTzfuQTFBZzEgSZsmJyFHLzHSWw/2y
NWmFJuP9esg6R5N6Y6HDewE5fv1Evdp2jGnvP3xtx3tGVGGsG6kS/nl7ONA01NNt3K685y4UnHKU
Lt7GNwfy/ELFoviZIo6844v8XT9jmxGv1Ldjwzq++ARebjGPe9XMP8SpvC7kjJxDVQklLOotzfbj
wqTo3FzwhLZjWjwl7kod6inuqs32OXlz
--0000000000003f57a2061cf0a570--

