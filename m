Return-Path: <linux-kernel+bounces-332322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424097B850
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D50FB2167B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180051531C1;
	Wed, 18 Sep 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB1BxnyE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34613AA2D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642969; cv=none; b=QVj7hL1gTIPUV1e0zM3SR5eva44gDbOprvwqZfCXmr7rHYz0GvxK7iENS/vKhERE7rUpfnUIERGWeUP4Alt+SsqZQnG3LjaP8GJVJltL2WzluaT0gwqJOgmQGr2Y+/wXFaUQcvusOpN+e43rAiPp49fd6YmHGNNZ9zj5E/iqbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642969; c=relaxed/simple;
	bh=x+ZPrZvw5zCUjODXMNdET4lREA097EsekxJMe70rJBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/1K/iF0A5+rErYjhhn3GG6AERDgSY9AeBRaqunAp8VxiOD84+c9ENVGgfW503OQTQ5UGD/GsM6Et3QRwoEw2PKXkOshBjGWXiN2djdeHevVm5BdtbbkCc2vOwJUQL7Ez+DUpX4KkPnCnAEVcfMrSo7Vy6Vd+lV7zX7QEeV/xxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CB1BxnyE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c36ff6e981so47600346d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726642966; x=1727247766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=869EbhnjfZGDtHkFGlotnYqbz0aunEkOp5rfFgx3Wa8=;
        b=CB1BxnyEGOv1k2UXqXYLUftbYPO7OKEyM68otoMJAYSxfYh3hLFN04AL8S9Ml2Vbfh
         0pzf5lR67WG7pVecTBOGi+RTII5W2zdGWq/YDhej1Pf4bOwv1/f0BQYQ3utx/98KGc5J
         my3qmWSqQUXW2DD7cOMUf5Slb3MGdntArGxPm4VpBe66Pv7IyGlc4qrYbATFATJOu50r
         nkbUaSZ28YX0qyjOR4vrCkoeYF1TfgoaSEsjDXIC5aCHSPvi9xat/wYrDn9W3rXtsXFH
         eQY4zgi2H0jcvqfouVVSwpS5uItejFUJqkAeboJc3JsbU5bxf30OZv1NR7fl+P2oe6c8
         FRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726642966; x=1727247766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=869EbhnjfZGDtHkFGlotnYqbz0aunEkOp5rfFgx3Wa8=;
        b=pij07wmdAT+UiSNmsozHYVau1n1VHztDfhHTXIXXT6abUeJiz25FJ0D3UtpSsceHc1
         pNKRmSHPpjKhFBWhkslzGTNwOE6G5hd1CZC5w93doolcxM2T3yvTfbasab4Xw7id/JeR
         IBckWX6+wDZOqM5nULWK6qdmHXebthGAMnbDl68RY709keiMhe1vW0mx8zyhjYXfMtgg
         9XClDL8FWiHGWYmc2IEe3wl++49NwpAJ2cR9jTNrnQ55H2E3FA5PdfzmIgKslHdIHKLx
         3nnDsT9s8G4z+QWQjB5Tt1uBl9i+mGfM7A1CF7V0l1+a49OMquvf/xJgzGFA3D6Zw7ni
         mE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0Z57usN6XstgQQXRuhqMKnfGiEF7MhWH4BLqEP/ybPi1kEkn7EaNdsBYobRhgwm9nUED7vFu6k7udHWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfCJ3NT7rzOCK1pW2C5MtZvF/Jw9lzhmvdIIc6CjLxO4jimBU
	pMVyIjhzLqT1AgVugtNTUOxKdq6zdNnvO3r8R9/WpD4MoUL2axVCMUH7JlWqRjWhiBGFXTQfcUP
	9ecFhCBoZDMC2Aog6nQHc3iz8hZEnfywUH+b8N3aAmvNmUQ8efu5dHqaDzg==
X-Google-Smtp-Source: AGHT+IEnWY8IceNJN1psB5I2m7UQ69GqSAZRA2aftJwhV76Z/bTiiy9NRp+n40q6Ff/pqyGyZQCViMjQga/bUlsJm8I=
X-Received: by 2002:a05:6214:419f:b0:6c3:55ea:aada with SMTP id
 6a1803df08f44-6c57355e845mr403563756d6.14.1726642966361; Wed, 18 Sep 2024
 00:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910043531.71343-1-richard120310@gmail.com>
In-Reply-To: <20240910043531.71343-1-richard120310@gmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 18 Sep 2024 15:02:31 +0800
Message-ID: <CABVgOSmn=SEwq3je3+vJ-S1Rwb=cLT2a3_WKOQsHu9xZYEZhrg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] list: test: Mending tests for list_cut_position()
To: I Hsin Cheng <richard120310@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Linux Memory Management List <linux-mm@kvack.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b2dfad06225f6475"

--000000000000b2dfad06225f6475
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 12:35, I Hsin Cheng <richard120310@gmail.com> wrote:
>
> Mending test for list_cut_position*() for the missing check of integer
> "i" after the second loop. The variable should be checked for second
> time to make sure both lists after the cut operation are formed as
> expected.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---

Alas, this breaks the list test, as we're comparing the entries we get
from list_for_each() with entries[i], so changing the value of 'i'
will compare against the wrong elements.

You could either update the KUNIT_EXPECT_EQ at the bottom to verify
the _total_ number of elements (which should be fine, as we already
verify the value of i after the first loop), or compare each entry
against, e.g., &entries[2 + i].

This is causing a test failure on -next:
https://lore.kernel.org/all/202409161554.6c3e8d5d-oliver.sang@intel.com/

Could we remove this from mm-nonmm pending a fix?

Cheers,
-- David

>  lib/list-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 37cbc33e9fdb..8d1d47a9fe9e 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -404,10 +404,13 @@ static void list_test_list_cut_position(struct kunit *test)
>
>         KUNIT_EXPECT_EQ(test, i, 2);
>
> +       i = 0;
>         list_for_each(cur, &list1) {
>                 KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);

Either change this to &entries[2 + i], or...

>                 i++;
>         }
> +
> +       KUNIT_EXPECT_EQ(test, i, 1);

This to expect i == 3

>  }
>
>  static void list_test_list_cut_before(struct kunit *test)
> @@ -432,10 +435,13 @@ static void list_test_list_cut_before(struct kunit *test)
>
>         KUNIT_EXPECT_EQ(test, i, 1);
>
> +       i = 0;
>         list_for_each(cur, &list1) {
>                 KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);

Either change this to &entries[1 + i], or...

>                 i++;
>         }
> +
> +       KUNIT_EXPECT_EQ(test, i, 2);

This to expect i == 3.

>  }
>
>  static void list_test_list_splice(struct kunit *test)
> --
> 2.43.0
>

--000000000000b2dfad06225f6475
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgmuP+qwoe4ZNmQ2ruUUYx87u1HZwV
o1xZC9BB50Ma/iEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
OTE4MDcwMjQ2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAMZmneXc/QaflmpB8YcfieSxWgd1tScchyqntPtyU1nTluIK
UqAuWsGsp8I1sWJWJZEIS/Tjm+61I+Cgmafy3TS10V4g77m1BP16Mv/Y4MOcc3nHFnD5/B241ihg
iTU84IkA9T2+QEPqC1+UD9jX2+Ls2u3PegbVG9mqcknJQQD7rvPym6UaSmKlKUYV8/cD4PqxohdS
KGxd2d50NzDknVE0AUJRuhVKN2ToHc2ft+IAshmhibk4ZI/aJIfZw5JW+aEJ/KS0XMViieL1kB7t
UTX7S2ye4W5o5nWeqz3neOzGKCFD9jl5e4wt6uh6P6WMURWP9hj687z1aHcBDkqzlKI=
--000000000000b2dfad06225f6475--

