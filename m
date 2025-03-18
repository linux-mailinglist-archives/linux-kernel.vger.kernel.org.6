Return-Path: <linux-kernel+bounces-566436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DDA677F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C8B3AED8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7520FA93;
	Tue, 18 Mar 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEqoYVNU"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4F20FA86
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311988; cv=none; b=GHSHSf5v5I//d/DFVKlh60TuWysrsV7bBaNWeTVkRPGQnZWSG2SKWdcvGXEC4gT8n5i7qrLwnBW5nlq+xJS00kamhKiQN/WVmbKAq/O1K14AVvZxvxH68ToOvnyXNIIDlYQLZzJgAPOuVMzsLlS3gwdxrG1v4DNMNJKR12dtLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311988; c=relaxed/simple;
	bh=jMBjBmnpFfJJbgSeWUOicYgOpJMe9ifxkmEYZNl5IVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1E/1SsfwO5GNzlMdu4znRkjPziUuDHGhnhjemoYiR/GBkM0aDXx3vDAwS5rEKDa+Ex55+axFDwfq/T/aD4KEg205jMfgsmVrjCPALoejddftz/wCDfkGxrBhnRnq0twNqP95M4U8B+N29g87ZPFQSLGZpQdolT1H3+VLaeI6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEqoYVNU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39727fe912cso1550185f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311984; x=1742916784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQedOYF0JbGhNTsRLu/QrPIdEyMAq9Lyufwf1HjqHkU=;
        b=nEqoYVNUpeHdWUO75wfyNZARJz4kkNy0eaY/ciDmLbZaMPzHKVFHlm7T/qfEfQvg8S
         uLzeecIue5WlYA5f7vjdac8yleVT4JZXFhg0aMpZTSuime06Dv340qS9+r1/Ko0kZc1Z
         alArQ6wCLDOEvmIS9s4noT3cKR+G7aO7fg52KyXelsF5wBkbsZjk7zlBQYkD2ua/ZJmT
         LDZKsFSLWwyAakIt6jTuNqT9WqzthnV2m8Fu7ptdijUt6RGLHVsIFsfJLLugcthGo8WE
         bvl4WvSSYXKPGRqfVNFhQOKbCsEIBTQPtSxy7QuYsRD7GsBAh1xN/ysMaH032mn8Ffzm
         ARyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311984; x=1742916784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQedOYF0JbGhNTsRLu/QrPIdEyMAq9Lyufwf1HjqHkU=;
        b=QpBzQLmX/X4Rwv6rY/mYbkoYzMm0LYib9OXGuI5+VfoQtQU2T7p91vxDly/EI0gk0k
         Ci408paiuiKHyHQU7HCh62rIZV/nLMVcg9HrqJmgcSjCBLXVB+n92htu4A15DUagBZkM
         Zf9lZsyQyj6nZf4IxC7ZmnweX2bVdeBpW7xMWSK32Caf7/9jJpuBBw4rzNEoRnEN2EAH
         Io8T0QxtO06ppheLaM9lCjfGztyKZGo4emXNymoEgHwXgv1vcJe3id/kuQf8qe+IiK6b
         45zpOR36tZo+FPqJjpjXl7pXMdEWr1Cb5pMJ3DYA/veyrzCbLHwelk1IplxkhSvh8aKR
         sIpg==
X-Forwarded-Encrypted: i=1; AJvYcCXfPdpg/SofavjYAqIBGUQ66wYh99XjVVF8XhBXlSr1DbY2EN8Ytpbqw9K5m85qI2f7XFS39Ut3dFf/Nrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpTuAwwn3cfPChniaokylpv5i78dUABOzdFhAVfiZ9DHhuGL7
	Lw2+KTaXPk4hcMwcfVdNtz3Is4ci3EphmnVlkLm2oy0PA0sWFdhdnzUe7VA/TSfGbd8bR8YqzcU
	EOPZH4ZiXlNSylksHJEMvZ2GJnXE=
X-Gm-Gg: ASbGncvmv0zYKubIujR9cKZAtAjasyNd3Jvrx1yT/tbyblX+OxLD2U6CMmjyINTRTk1
	bbnohaor/Ncjn8/oeZT83lvTn+AdJ0IZ9xKklxEcFX/7UEbjO6SwAPQrSiOu4mqTQJu+SFUt8GO
	+5wdbKT0vqYoWMgIFjwZN/I6cippYIsibg6aPiRg==
X-Google-Smtp-Source: AGHT+IHtUbfef6AuENuUNXTiGbXJ9bAjThV0ug/y6ZpFhUtc+q5kR5UByEL96jx8QrkNeGx+D5z+NN5m4va1bqJ78dA=
X-Received: by 2002:a05:6000:402c:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-3996b4a1f12mr3500096f8f.50.1742311984401; Tue, 18 Mar 2025
 08:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318015926.1629748-1-harry.yoo@oracle.com>
In-Reply-To: <20250318015926.1629748-1-harry.yoo@oracle.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 18 Mar 2025 16:32:53 +0100
X-Gm-Features: AQ5f1Jp2LdhedIBpqplA-ibdx9fucHDmyRIqhF4hweSMbvA5brq57w8VLaw2NDA
Message-ID: <CA+fCnZcnkL4g1Do0MjwzEUMgQuS+5oWkcK7yaWy8Xvfd4uJxPg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/kasan: use SLAB_NO_MERGE flag instead of
 an empty constructor
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:59=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> Use SLAB_NO_MERGE flag to prevent merging instead of providing an
> empty constructor. Using an empty constructor in this manner is an abuse
> of slab interface.
>
> The SLAB_NO_MERGE flag should be used with caution, but in this case,
> it is acceptable as the cache is intended solely for debugging purposes.
>
> No functional changes intended.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/kasan/kasan_test_c.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 59d673400085..3ea317837c2d 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1073,14 +1073,11 @@ static void kmem_cache_rcu_uaf(struct kunit *test=
)
>         kmem_cache_destroy(cache);
>  }
>
> -static void empty_cache_ctor(void *object) { }
> -
>  static void kmem_cache_double_destroy(struct kunit *test)
>  {
>         struct kmem_cache *cache;
>
> -       /* Provide a constructor to prevent cache merging. */
> -       cache =3D kmem_cache_create("test_cache", 200, 0, 0, empty_cache_=
ctor);
> +       cache =3D kmem_cache_create("test_cache", 200, 0, SLAB_NO_MERGE, =
NULL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
>         kmem_cache_destroy(cache);
>         KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_destroy(cache));
> --
> 2.43.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

