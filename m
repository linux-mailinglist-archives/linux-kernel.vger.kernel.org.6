Return-Path: <linux-kernel+bounces-332757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84297BE79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502B81F21C63
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18C1AD3F3;
	Wed, 18 Sep 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwSdLjvS"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC507A15B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672534; cv=none; b=O/Wjvjw0IsZEHhoh618JtvTG4NGT4h+Xbi3TmC48D9yMVMwfkTnC5CH4X3IAfI+XGZh0zSzekjdlT4RNKcuLdRPFEAPupbeFZUm8ntybA4YZ0u5jx/kLV3ppE8Vs+pGFdWxYfaBIHdHaiO0AArIYK5jd3Bm0hUu7auFYnmdW1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672534; c=relaxed/simple;
	bh=MC4wkYdxuLGFiN453rt8wRT0ZiMnpIEqFW6hfAlDOwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwgVxAujBsYK1xiWACpAwcKMcjuOhtqDFEYFNRQ81Xwb6vxTdNRc0JlzL3ETVQzcWencN4Yk6YqJFrM3FkX8t0RYuD8mGWrkB2D4z+LODAm8T/i9qTkO7xcqN2hKzV/oLFB6fwFO8YO006Tb1jSIFn3CLPQaB+aT9ML6+8JOfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwSdLjvS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374ba78f192so5184505f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726672531; x=1727277331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e7U1XrXIdEL6SVlFY7nb/dZRU8i4CDxNhm+to+Gq/Q=;
        b=cwSdLjvSvs7X1ainaIg2YNqPNUOJuxbNtzOx6ibEWfISbKmLGSmN3gHnl+r9JOKRpb
         c28FNvBi4W4USwOysRX3/rHk61IoUZuiE1ALNGhAup6CyYGYTYs1R9fV4WYsDeGnRmfu
         wPUV6L4hBIVAHwz2AHYs2EHoU8f+9zpTuMn3vCxOfSAYgtoeAp1Ioflu0QUelE/v5F1m
         x4ar447HCU8cceVtBQciXFlyouRHEUQ2CAHTFDefu/DigFjlN2zjaQxtU9Db/6CqW3CF
         OK+GygnfQuMsJS2goldhOMJ06xI1/Ub9z21Dw2msCuj0/gBlbv5wEjB1FsnV/ZBccVim
         ZH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672531; x=1727277331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e7U1XrXIdEL6SVlFY7nb/dZRU8i4CDxNhm+to+Gq/Q=;
        b=nHHqdNfifrs79oS0o45iue97qya6iBmYiapaZT1G8loLc5kGiKqfkQY8WKEf+tZAyX
         j2zAEaQE8PMujmgGWL+/cqaW8YscpVVZrVUq8B3oqwNJfDeJPEa1t4h33N3AS6b/1mCb
         WRTAHv5W3fU68Tti0GuF/sD99Niw0FR4fIpCRzMy1WT7M8+HV2Ch2FRvHHdYyyJMfiTe
         u9mJSMM2JcOs5oV4PAK1QEBlwSs5FvObHzoKLAhCYYHo6kRXMiags1k8W9HYlgCIzO25
         NpMx5fbBkawIe01OhgpuUpGCAMartP+KkthTWxSSbBhfxkQh7nLUizVtWhjPS0pswEIb
         YCKg==
X-Forwarded-Encrypted: i=1; AJvYcCWIkydglJWL9Tv+Q+dWPKdMXbD/kqU/piONrXcI7T+00Mu11wwuddDTxSYhDrmy7p+ur7xsFBv+Fwcz3lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCgfCD/uhOLDHFfuRSLAXVF/PaRSSqLMRd7O9DkXgAK8dt58+
	eGI/hNOQUtjVY6ianU25Ffwa4/Xua63vB8+7ZXAA2FXTg2YSI0Dyl+sdp0/2ozNnL7XfpemPIWB
	qIwJrLUMW7P7Tl4Zs192lcevoTUM=
X-Google-Smtp-Source: AGHT+IH7g5X7QV1vQGwl9PQkZ1vX7wZdmUENE/RPdlf7EB0u/MS3daySjnjNdQQwL3J5uNlzaoHz7oobGCSt23K/nW4=
X-Received: by 2002:a5d:440f:0:b0:371:8ea0:e63b with SMTP id
 ffacd0b85a97d-378c2d7275dmr13798552f8f.52.1726672530778; Wed, 18 Sep 2024
 08:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZeorA7ptz6YY6=KEmJ+Bvo=9MQmUeBvzYNobtNmBM4L-A@mail.gmail.com>
 <20240918105641.704070-1-snovitoll@gmail.com>
In-Reply-To: <20240918105641.704070-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 18 Sep 2024 17:15:18 +0200
Message-ID: <CA+fCnZfg2E7Hk2Sc-=Z4XnENm9KUtmAZ6378YgeJg6xriMQXpA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: x86: instrument __get/__put_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 12:57=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7b32be2a3cf0..9a3c4ad91d59 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1899,6 +1899,26 @@ static void match_all_mem_tag(struct kunit *test)
>         kfree(ptr);
>  }
>
> +static void copy_from_to_kernel_nofault(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[KASAN_GRANULE_SIZE];
> +       size_t size =3D sizeof(buf);
> +
> +       ptr =3D kmalloc(size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       kfree(ptr);
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_from_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_from_kernel_nofault(ptr, &buf[0], size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));
> +}

You still have the same problem here.

What I meant is:

char *ptr;
char buf[128 - KASAN_GRANULE_SIZE];
size_t size =3D sizeof(buf);

ptr =3D kmalloc(size, GFP_KERNEL);
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);

KUNIT_EXPECT_KASAN_FAIL(...);
...

kfree(ptr);

Thanks!

