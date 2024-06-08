Return-Path: <linux-kernel+bounces-206991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31999901117
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7401F2290C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3C176ABC;
	Sat,  8 Jun 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL0CvBtS"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA039AD5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838431; cv=none; b=ArXil5yrNTp2wFVNn0jOY2aPJUOT9/TP9kRNs2LMcVLTS3/4xoCjPBEJiJJFk/UyKaKNq5YqGbwMoGWeYqy3y4nPQiw9h61pgs4OEc+IIygS6hnxROpr0mD2xfzv1R5O42+wvz7qUoUaS01V06yFoe0xmCm9bHspOg2Tezl673Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838431; c=relaxed/simple;
	bh=Bfi0o/ISEYeipDbHOFMHy7bTQU4FlUMiDsl147tF0a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMqiNrN/tP8L8Nm18ZVEEDM/yoS+a1nTT9kNB726AecL9M74OIFplVKcBUGM8tm4ELG/KDY0Grqc51R69ghl5xjnPdn/V26F3sHVl7JBsETOwg9AD351Dtap5mDbtCW+W9ejpeZLM8izx2WBtBfsE6ao73N4/DL3hbbwGtpINLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TL0CvBtS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405dffca81so24651cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717838427; x=1718443227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZoBMRmtCtfO2IUGB2YTtXszXTX3apQbnsN7Ab5ttko=;
        b=TL0CvBtSIl43BQRwU8VmtBAmBndoXu4JXEquyz6NumPmbfR+weF5kEXoAPA65+BVo5
         bJEMPcGqG7b+Van/5y3AXGi6N8b1LTWVEzdXiJyA8N8QdgkawMTjx8vGN+phTrzq7qtk
         tIGNemTOw/uDBJl3yP43T7UFBmY3/eXSFE8KOTZ9S/cggZw6CHydzFbHQ6uzWl8to2WJ
         xOQ3sK61aotjgSDwuR5ZpDcyeSmNinFBHwkJ9Zrl94uakBSPs6lUKnTGmJrWR60flTsK
         oqVBBXv/8gLM7Xkb+mmlkpjLzBAZcJNxSz0cjS/lX4agQxXxY8P6zgs55dpXIFhlFSfm
         tpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838427; x=1718443227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZoBMRmtCtfO2IUGB2YTtXszXTX3apQbnsN7Ab5ttko=;
        b=F94w8fI4CaQGwWR6FdzrwJcauWT6mcLZV2Rq/zW6I2vde4xWaxvSNd0cy6gkKTfkSu
         8+EKiVZuryLwWYmtkxinHxMnVfZBIFR+FyQ5SvCrPw8n5rtEpLrZmcHrDmSDdobFGN82
         ZnSFHZ7KhH0LAQWx6VKKPQTGcbBD631703Sm91pmDDmzyYS4+CvZj4TpfmIkXHrfKoQC
         SXUgeqQbA0apRMQ5Vdjv1vz15bauUaCdcA/k2t5qX9fvB+pzcwoEP4Gdojgs45lc7lQr
         a/5NH8LI8rQRbyw4p/2PK7T32jSkDmygy/bwG45wnVssy9gcParkZSfpkbMP/U6VDxFA
         BhDA==
X-Forwarded-Encrypted: i=1; AJvYcCV6cP82GJIc1hdfFz21/Cgo12KSPJ9rVHDUuOYdmPtXC/mHweimk21733iKyVmsg9WiIjxY3C0UsQVHcNrL5vtlmH03ETAHQOTDIPLv
X-Gm-Message-State: AOJu0YwXCJicZvHMne5v/L9q9ozO6EqWnrO0gQ0ZsAEI3aplzHgaCv3B
	ed9A/XRiozSiuamP6c9Liflhp7ZvPWAsRnmFi4etFU4axZOda1LyB+3WA8+vD/+mKHFOQXd1V+k
	N85/67/UsMEwZrYoH1NQZPuseiiyMH/TX2Oyh
X-Google-Smtp-Source: AGHT+IHXSS4uNUJfw9D01QLr/NzyWFzC4puJIKbCnwGkPMdB6trPxn0NgwdUJIdjj3IKbGAQqy+bp7dJKovfzlocNrg=
X-Received: by 2002:a05:622a:4c08:b0:440:2dc2:f816 with SMTP id
 d75a77b69052e-4405645860emr2106031cf.26.1717838427217; Sat, 08 Jun 2024
 02:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com> <20240604123204.10412-2-ivan.orlov0322@gmail.com>
In-Reply-To: <20240604123204.10412-2-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 17:20:13 +0800
Message-ID: <CABVgOSnNLmmMDHin=mvrAmN3m6mJmWsntcc_JvV03pCzXUEX+w@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: string-stream: export non-static functions
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000046ea0d061a5d6d38"

--00000000000046ea0d061a5d6d38
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> Export non-static functions from the string-stream.c file into the KUnit
> namespace in order to be able to access them from the KUnit core tests
> (when they are loaded as modules).
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Looks good to me, thanks.

It's very slightly hilarious to use EXPORT_SYMBOL_IF_KUNIT() here,
because _of course_ KUnit is enabled, but I think it's the right idea
nevertheless.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 54f4fdcbfac8..a5e3339854da 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -10,7 +10,7 @@
>  #include <kunit/test.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> -
> +#include <kunit/visibility.h>
>  #include "string-stream.h"
>
>
> @@ -86,6 +86,7 @@ int string_stream_vadd(struct string_stream *stream,
>
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_vadd);
>
>  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
>  {
> @@ -98,6 +99,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
>
>         return result;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_add);
>
>  void string_stream_clear(struct string_stream *stream)
>  {
> @@ -113,6 +115,7 @@ void string_stream_clear(struct string_stream *stream)
>         stream->length = 0;
>         spin_unlock(&stream->lock);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_clear);
>
>  char *string_stream_get_string(struct string_stream *stream)
>  {
> @@ -131,6 +134,7 @@ char *string_stream_get_string(struct string_stream *stream)
>
>         return buf;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_get_string);
>
>  int string_stream_append(struct string_stream *stream,
>                          struct string_stream *other)
> @@ -148,11 +152,13 @@ int string_stream_append(struct string_stream *stream,
>
>         return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_append);
>
>  bool string_stream_is_empty(struct string_stream *stream)
>  {
>         return list_empty(&stream->fragments);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_is_empty);
>
>  struct string_stream *alloc_string_stream(gfp_t gfp)
>  {
> @@ -168,6 +174,7 @@ struct string_stream *alloc_string_stream(gfp_t gfp)
>
>         return stream;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(alloc_string_stream);
>
>  void string_stream_destroy(struct string_stream *stream)
>  {
> @@ -179,6 +186,7 @@ void string_stream_destroy(struct string_stream *stream)
>         string_stream_clear(stream);
>         kfree(stream);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_destroy);
>
>  static void resource_free_string_stream(void *p)
>  {
> @@ -200,8 +208,10 @@ struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp)
>
>         return stream;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_alloc_string_stream);
>
>  void kunit_free_string_stream(struct kunit *test, struct string_stream *stream)
>  {
>         kunit_release_action(test, resource_free_string_stream, (void *)stream);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_free_string_stream);
> --
> 2.34.1
>

--00000000000046ea0d061a5d6d38
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
hvcNAQkEMSIEIGTIGu+fTFqj7KEIZ6Z3IEzjWigoR9Ov6I9FtB8klNUIMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA5MjAyN1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcPNYH
JmYLNdAuQvFooJiERLruZkvF/M5tKiMtiz7tnrHwgK7SOT8En8TncGNuV4WmRPq2SslT0GRSPg0x
hbyRkJEOIO63iqrr/xBHT+TtOw6h+AlwAIC60a4DRos6KJ7pQ2h3KzaEuL5va8YN7qf2tNYlWTuH
K//s9c2CuOhN9NBWU0CPNrMA6PPnGho9YLC27IZqzzWmMi8dMhX0xQGWBSuXtAIcShDDj/4nsSgg
bFzMvCs0mUcwOyrIs7lZ5Mwp0Jf+4YJwXPiWWHp9En/KvN0rAb9ci31RhFawin6127Sxzwg0xHkr
yLIe8SoOgR0ZQU88seVorsxF5WLox4Wz
--00000000000046ea0d061a5d6d38--

