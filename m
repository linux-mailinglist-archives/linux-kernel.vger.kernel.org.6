Return-Path: <linux-kernel+bounces-558385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EEA5E526
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9663B92DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6831E98E0;
	Wed, 12 Mar 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VUpyb42c"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1078C13B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810611; cv=none; b=gyEdkcCQbhHj/MYW3rBX/yAuioIAiRWJIBy0aLM08hZzwqv3TjjPYEulsiQHfpzhfbdxXzE1KkUhKexc/T5ZQIAjZATTLWtXNfIeKY6uGTZHOmHkUjiDHwBsjChxWaVoaLma0qnZ+wuzHSKIdzjDXoG+Vt6jjyseglKVO8XLvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810611; c=relaxed/simple;
	bh=+xKFX1pp3mEipSSCK8l7b4EKmFag5w8aJf2eklRJ4QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beBZ9FxrpOYqTYhP3aIQ/lqJhzrXnqqYvOoNvVR3ma7r6hNMJCCqMiaF3TBd8RiL8opzCLEH3Uy9rlHqOHUeSFl62SALgfvrO84zK8kAEygFUoYeeb6t4dhVdApixgDiPLrO+9nhpAUqbSt+7JgCpuv5mA96/QZPhzYYsfp2aDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VUpyb42c; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fee50bfea5so2531407b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741810609; x=1742415409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlAiZHSczHL4dPmU0Svxpoh1IeIWVxip/9BPH0/DEs0=;
        b=VUpyb42cv3jxSVh+FkHK+b+yOFpB/jqpxfFd14SrBoYhm5f+xVRBH4/Xpe8d1280Eq
         oZxXvveLVME24iB4B5Nj4CPM/HZtACPaLh513/PXENvN2f7jSyzNUO7PdLtOMjArHaPT
         k/h3xUOuIQyhYUgavBJRZfCBskeBxdTCWDFwBvqqxcC4gQ2zDu/qlaYICzS8e+Jk8doc
         1x8b6gtJUym1+3RNra3noEgZ+D1gF2YUkLRo5CCyEf+RU8UVigfnukJzwaR2j4ris5kE
         9ulqZThheCnHuatp9ll/+LLUcUfoao8uZTK43itHSONNE/ULhikD6kkaJARA8kX+jPKl
         4mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810609; x=1742415409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlAiZHSczHL4dPmU0Svxpoh1IeIWVxip/9BPH0/DEs0=;
        b=WGu1EfdLbFWH0DDuNSbw0/WcKs+2nHDV++w0xmrcW9XjsQLpeOA1nhB8fZikHQqKvE
         whyyEfvH+gAujTWH4mK0D0sTsk1Rx4CN5Lvh1jo3Lu15hChNiXstGY6/4z6WJ+4WCGdD
         SF9ENMYzv4mDXAhmrerIhxvYoTFW/ug5nWRF3ye/56LrinopUrPc3mhwSdfk6PnVivZL
         7zdFRHjKsTPwaX0k/VKPluXJK2RAfIVeY1riS3vySupsTelOz3NJc44I2tcI/0XvWwqF
         rPffJLdi/eB64rvwgbjqdIc+Q3k7Q6IqTTZTHytBbvPdZn2FthjFFbn9CoV43dQ43d1e
         ++eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw46B6wJLnAXBgDJ+nHZhFt9IuaJh4WONhzR1o8VLR0YFvMz6cCw5+5/94wdF2Jppfd0SsXcpZpCcBC9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxq5a3g1l0DxkxNAy20AzGz52edeeydG5Zi6hX+HnMAqf41XoR
	MHHaxSEX8c6+/BhjRx9kYG9BuPnFz+W4F5ZP5GNOnAF9jR8ye1LGLzCEDIRDZeuXU1ialLk/HJT
	WY+JZwKJkPJixV9ginOHwssS1eh/EQs3V8q8b
X-Gm-Gg: ASbGncvghJx+ZNcWKnJY/DYkQjil3Sh5QzxpsxihYcovbQFQGA/9es+w/kz0iLnAxbA
	4bOHWFj3N2WlXeJHUxS4BLTLlZSsV/IzqA2tjk6uOkaIPvvBKR0Iy4EWoSabYGdV9epyyDLhyev
	WQ26ZSDWxbbM243o686cdPkxI1fA==
X-Google-Smtp-Source: AGHT+IGsMfpU4NDQUU7HmINQA7wNmAYjX+dxqWkgxOHEnX0Fo1BZ419T/c+57j2erW8jJdPXACroUyNNCW7XYAAoqbM=
X-Received: by 2002:a05:690c:6088:b0:6f5:2793:2897 with SMTP id
 00721157ae682-6febf37b72bmr342709407b3.30.1741810608700; Wed, 12 Mar 2025
 13:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312200216.104986-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250312200216.104986-1-andriy.shevchenko@linux.intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Mar 2025 16:16:36 -0400
X-Gm-Features: AQ5f1JqM7dTfNxqvjM7Bbx6USu9RTu4JsG1NDCgTEFRgJ8zuzc8E0i2b76FB-ys
Message-ID: <CAHC9VhRHZL+QTsfK2Sg5+rw7RSxUoaF=YTwGW9Oia5xnvqAL1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] audit: Mark audit_log_vformat() with __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> audit_log_vformat() is using printf() type of format, and compiler
> is not happy about this:
>
> kernel/audit.c:1978:9: error: function =E2=80=98audit_log_vformat=E2=80=
=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute =
[-Werror=3Dsuggest-attribute=3Dformat]
> kernel/audit.c:1987:17: error: function =E2=80=98audit_log_vformat=E2=80=
=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute =
[-Werror=3Dsuggest-attribute=3Dformat]
>
> Fix the compilation errors by adding __printf() attribute.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/audit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It would be good to list the compiler version/flags that triggers this
error in the patch description as I've compiled the audit code quite a
bit and haven't seen these errors :)

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 5f5bf85bcc90..f365e1bbeac6 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1956,8 +1956,8 @@ static inline int audit_expand(struct audit_buffer =
*ab, int extra)
>   * will be called a second time.  Currently, we assume that a printk
>   * can't format message larger than 1024 bytes, so we don't either.
>   */
> -static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
> -                             va_list args)
> +static __printf(2, 0)
> +void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list=
 args)
>  {
>         int len, avail;
>         struct sk_buff *skb;
> --
> 2.47.2

--=20
paul-moore.com

