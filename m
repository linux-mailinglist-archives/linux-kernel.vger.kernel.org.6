Return-Path: <linux-kernel+bounces-291198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B04955EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B101F2121E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4914F115;
	Sun, 18 Aug 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQi/dvb"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0761304BF
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724010719; cv=none; b=oFhS099wQY5+p1uznLjUqLH4s2J4DNZCxh0bc+BQTT59928nZmGswAy1RCwraaPDx7rZl+XaUJF17Zih/1/3reeGuukAE7FhgpPp8MmHBa2rZTed5/WzgJXp3F0ZxxjQkLDH9Bm3fsfM31Q0upSNE6ch2Q/buq9uXZl2p6SNN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724010719; c=relaxed/simple;
	bh=TZsbwwNkEWH1tZ3HT7gmTDUuL1/JZAkZO8Jh34cMkwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHhnQ0aKJWdxlMKPvrzPE83VGZvVz9fMBpcPJCm6wLKIkywyQEDbs38wAnxw8txLe7ZPoSo0Ac1VDMl9Iu09RR+wYYtdv/LM5nqzu9anlTLbk6OzcmZ6v5sLVS4c5BZyUvg35xaXrfKylkAl5UdcBxXBIHXfUz9TNPM5hTm7+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYQi/dvb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d4so35451151fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724010716; x=1724615516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HygLz4lr7P8WKYrQBOAfXSnwsJqt7olzVpK96u5Fr80=;
        b=CYQi/dvbgyzFvMTq79PR3ImduiEIvFwhhTl5XwfdR2I3rkm9iVGhP9KyBRnSsczBd4
         VptRjjWOBodjYsX+fcydNjLa0SyErzM2kW+ckZoDe+/mpfEQ8tVm95GSuQIBpRp4HwKc
         HOftaqCFNDEt9D+uO6w1/baIqXjtYn+HCMZs/LFe+d2KRp9/VPgE6CGmd5AwOxisfiz9
         avww2IJCH8pf34SDFMSJmNRFmzchVyn9S/ZIVBS3VpEXUhlSl+HV0CG35ULYWWl+in5T
         /N/Da0uyL+Pk5rD6puIaxrqWnQCT8iOMfdsBMIv5Ey7FnO/szXfG3xXmdxjoVlsusBpS
         5LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724010716; x=1724615516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HygLz4lr7P8WKYrQBOAfXSnwsJqt7olzVpK96u5Fr80=;
        b=coFMI33gAeqHJ82BxxL3C/Kmb/IJ+Lyp3pCOzaHDg0RePiETHU0xIi4KhwT2dDiCfn
         KCcYkqw1Rn7DRFuamIuY/9chqHF9HWh6XgMYMzfx5Ij+Tj9FeKsbikZuNdDCDsMthOVs
         TXmI8moYo7vgjcR/qU+aMpHE83qbtFHIDeYoVX6BH9W7e1dkLN1tMx+qjHlNtKDfShQZ
         5agfsshnDvyds+fyXyBrbb9fkKDOduLklTLxTHfPTa/cL4PTb9eJfXFOeeKjEEwcRhR8
         q3i9NLgLtKCa/2oIZJXLZfItf6eRQSfaidZt9dCcRZf6gZAusFsLWoJcl6uH67VwFFQ4
         gZgA==
X-Forwarded-Encrypted: i=1; AJvYcCVtyq0EcikiIhiIle+MV5cYdSzXYa818n6M4uztFkyV4+tUUcL1gPpFogiyfBIsJeNCvh5vFF8LjOx+4UxqwA6OLY55w+dW25huo03P
X-Gm-Message-State: AOJu0YwgCz+yzoeRF0i/+Rt7C6HRzmcCNG20bDZ6VesLLS0+ilPixrFe
	uFLDDtjk+GU7/UQf+S6hvVef+0hJcv2ks32Is+IesN3Nl8UmS+LXoDVPdqDUKRu9IQFDSxUBmPR
	1oby7ElvYQnV0squObeiAzVs7rWT2yw==
X-Google-Smtp-Source: AGHT+IG4/azy1BipsGz50yyFODjemRjPoWuBkdlTqirLQtcIcQY4fvCrRextMlthXhPmXdEQ3lc7awcA/sg05JsOKxY=
X-Received: by 2002:a05:651c:19a5:b0:2f3:ac23:b1db with SMTP id
 38308e7fff4ca-2f3b3b84d7fmr37554001fa.4.1724010715234; Sun, 18 Aug 2024
 12:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818152634.17443-1-ubizjak@gmail.com>
In-Reply-To: <20240818152634.17443-1-ubizjak@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 18 Aug 2024 21:51:43 +0200
Message-ID: <CAFULd4aFsoLxs57W6EfddcvZiy=oQ7SMVhSCkvNcPXDvXy6h+Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kmemleak: Use explicit cast to cast pointer from
 percpu to generic AS
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/mixed; boundary="000000000000455c0f061ffa8622"

--000000000000455c0f061ffa8622
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 5:26=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Use explicit cast to cast pointer from percpu to generic address space.
>
> The patch will avoid future build errors due to pointer address
> space mismatch with enabled strict percpu address space checks.
>
> The patch also fixes following sparse warnings:
>
> kmemleak.c:1063:39: warning: cast removes address space '__percpu' of exp=
ression
> kmemleak.c:1138:37: warning: cast removes address space '__percpu' of exp=
ression
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Actually, we can do something around the lines of the attached patch
and still keep the __must_check directive active.

Please disregard this patch, a new (better) approach is in the works.

Uros.

> ---
> v2: Use explicit casts instead of IS_ERR_PCPU().
> ---
>  mm/kmemleak.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 764b08100570..fc2e09ec48f8 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1059,8 +1059,9 @@ void __ref kmemleak_alloc_percpu(const void __percp=
u *ptr, size_t size,
>          * Percpu allocations are only scanned and not reported as leaks
>          * (min_count is set to 0).
>          */
> -       if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -               create_object_percpu((unsigned long)ptr, size, 0, gfp);
> +       if (kmemleak_enabled && ptr &&
> +           !IS_ERR((const void *)(__force const unsigned long)ptr))
> +               create_object_percpu((__force unsigned long)ptr, size, 0,=
 gfp);
>  }
>  EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
>
> @@ -1134,8 +1135,9 @@ void __ref kmemleak_free_percpu(const void __percpu=
 *ptr)
>  {
>         pr_debug("%s(0x%px)\n", __func__, ptr);
>
> -       if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
> -               delete_object_full((unsigned long)ptr, OBJECT_PERCPU);
> +       if (kmemleak_free_enabled && ptr &&
> +           !IS_ERR((const void *)(__force const unsigned long)ptr))
> +               delete_object_full((__force unsigned long)ptr, OBJECT_PER=
CPU);
>  }
>  EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
>
> --
> 2.42.0
>

--000000000000455c0f061ffa8622
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lzzzgih60>
X-Attachment-Id: f_lzzzgih60

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZXJyLmggYi9pbmNsdWRlL2xpbnV4L2Vyci5oCmlu
ZGV4IGI1ZDliYjJhMjM0OS4uNmRkN2YwMGQ0MjJkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L2Vyci5oCisrKyBiL2luY2x1ZGUvbGludXgvZXJyLmgKQEAgLTQxLDYgKzQxLDggQEAgc3RhdGlj
IGlubGluZSB2b2lkICogX19tdXN0X2NoZWNrIEVSUl9QVFIobG9uZyBlcnJvcikKIAlyZXR1cm4g
KHZvaWQgKikgZXJyb3I7CiB9CiAKKyNkZWZpbmUgRVJSX1BUUl9QQ1BVKHB0cikgKHsgKHZvaWQg
X19wZXJjcHUgKikodW5zaWduZWQgbG9uZylFUlJfUFRSKHB0cik7IH0pCisKIC8qKgogICogUFRS
X0VSUiAtIEV4dHJhY3QgdGhlIGVycm9yIGNvZGUgZnJvbSBhbiBlcnJvciBwb2ludGVyLgogICog
QHB0cjogQW4gZXJyb3IgcG9pbnRlci4KQEAgLTUxLDYgKzUzLDggQEAgc3RhdGljIGlubGluZSBs
b25nIF9fbXVzdF9jaGVjayBQVFJfRVJSKF9fZm9yY2UgY29uc3Qgdm9pZCAqcHRyKQogCXJldHVy
biAobG9uZykgcHRyOwogfQogCisjZGVmaW5lIFBUUl9FUlJfUENQVShwdHIpICh7IFBUUl9FUlIo
KHZvaWQgKikoX19mb3JjZSB1bnNpZ25lZCBsb25nKXB0cik7IH0pCisKIC8qKgogICogSVNfRVJS
IC0gRGV0ZWN0IGFuIGVycm9yIHBvaW50ZXIuCiAgKiBAcHRyOiBUaGUgcG9pbnRlciB0byBjaGVj
ay4KQEAgLTYxLDYgKzY1LDggQEAgc3RhdGljIGlubGluZSBib29sIF9fbXVzdF9jaGVjayBJU19F
UlIoX19mb3JjZSBjb25zdCB2b2lkICpwdHIpCiAJcmV0dXJuIElTX0VSUl9WQUxVRSgodW5zaWdu
ZWQgbG9uZylwdHIpOwogfQogCisjZGVmaW5lIElTX0VSUl9QQ1BVKHB0cikgKHsgSVNfRVJSKCh2
b2lkICopKF9fZm9yY2UgdW5zaWduZWQgbG9uZylwdHIpOyB9KQorCiAvKioKICAqIElTX0VSUl9P
Ul9OVUxMIC0gRGV0ZWN0IGFuIGVycm9yIHBvaW50ZXIgb3IgYSBudWxsIHBvaW50ZXIuCiAgKiBA
cHRyOiBUaGUgcG9pbnRlciB0byBjaGVjay4K
--000000000000455c0f061ffa8622--

