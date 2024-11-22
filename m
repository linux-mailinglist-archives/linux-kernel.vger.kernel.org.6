Return-Path: <linux-kernel+bounces-418433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB499D6184
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC0E160436
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8C14D452;
	Fri, 22 Nov 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDMCPy3v"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881D134A8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290600; cv=none; b=ZWz/PMzgIcLDmyXEqZkkI2WdmvNc/0iaZxcIQhOdnGKW2wiuKg1mmOWkATPJSVQWMhiqimP1tl5gYDKy2vgypcrBhtth+MEfeVsAERwn1/5+SgXyDNmL96tnGXe7dwAGJfOPj/I2KRoJL6/kZZWKzb/eB1mpL1qzUivqZsTICvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290600; c=relaxed/simple;
	bh=9R+8ZOFgrk2QeFtVS2U2/gysj+B1H8MqJZNTjEXqaVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSAx9D03qXe1rBdlnkIYbtOvffpvHmrqxwlFebMj66Z5wyZvwdZ7hL2EG7RWLLA8oQuMNzcVT+lHvqI+4utoZf1P+HIi4jnd3W4fggeywHyO/7aQS1ErFeVVa376AMWzIbnxz0COEarLVcv10HEQmVwH5/pc9qj86du03sA7DBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDMCPy3v; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4608dddaa35so345011cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290598; x=1732895398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtkHZaiA0q6bw9BqHvH90RAXE3nDrWJJ9ufpDzBYokA=;
        b=VDMCPy3vRh0E2YIWLAUr8J0NTPHsm+jn+lk5RRqsYxudlqXgmPdg9b6rJJi6lNKQXE
         GJwiftgNevpHpe4WOQsi8XpiHZWcAdJSNTDJ/VFtKK3pNuv3jx8dJ08oQWzJAX/zmlq3
         jGIW/rWVSNkTUXO0ON2ut2J6IU3dxvghtHF6n32rXsKcRn6iTKtJcE9zXFWA3vpWLkeE
         K78fKswOoU8FdsI1KBUB2Ma4e1qkY07vHDoQ0ctG2SAKTZRS4avYtB1US6fhSd2Swf6q
         S0Ha+wowj4SSo/mPb8pMPw3QdjrrkZEbqbJQo9F2nX7F0KxGRYmV6EFfC2ZxwWYy9Oho
         HKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290598; x=1732895398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtkHZaiA0q6bw9BqHvH90RAXE3nDrWJJ9ufpDzBYokA=;
        b=sYunPTING/0s20WnqvkO5N/dLy/f0s5l/VHIqSwxztSHSnuF/B+bgbxDfrNIu8dGWK
         QUeGmJkB+jG9vbdr7GIoToEIJAF/Gt9xBVQmObibK/zGveVvhoOGM4CISHZovWv8zZfc
         DO1+YTuF3ArT0zZqW/FUJfZiZd7tz272oOUfw12Urlq8y+iRKmZURa5JO1ewFosORWWa
         d9q/Ws2zkdrE10CbXMLA4rzMsHSL9wPWShEfWEiQmn57dW3ffy+KITdIq6G1Fr36sSxv
         nK6jZZS90JPVxuZMpLzbIeGot0Vfelto4lWr9K+g3HqEr/4lzFLUO9QEPO53/NOaqhYh
         1BRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfIQe+QDnldi+UcfCOuedm2tNSY/26VGtEvKzWG67zPwnHtx2vusF+lPFBhv97C30ulAchBUh1xyEhLBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd9t7HZzmBmyMYTqvFvZqedNmUAYHMY70Gf1Iu+/q3Yxdwa6D
	5/9aTjpWX4B7cSai8QMDBFTjQXU3MO8swiP328iAEhPKY6FDEwBBhZMpzz7PKtlufzkqdmclVp9
	TdBoZIcvEzs0R+2Xl/j4NiD+VZYC0v3vmUDSk
X-Gm-Gg: ASbGncuCBDqjyihdIqeNfFlv1fcRatF3T3bfEoFLIsSxSYHUMQRModlrXx2tH7bwAnv
	/L0kqvRCL+PKQtcimhjdDmme01gXHjR8=
X-Google-Smtp-Source: AGHT+IG2Z2e0FeRW9KBZVkCKobWrPKQEssf0c2MmpiTdDbjLkpSF+QneeKKnJOs5ZYocVnc4jxMZ+EvtXaBJi8vXB4g=
X-Received: by 2002:ac8:40c9:0:b0:465:bc11:c481 with SMTP id
 d75a77b69052e-465bc11c56fmr2400451cf.1.1732290597788; Fri, 22 Nov 2024
 07:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com> <20241119183250.3497547-9-cmllamas@google.com>
In-Reply-To: <20241119183250.3497547-9-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 07:49:46 -0800
Message-ID: <CAJuCfpGb_kT98GTmahG9ZOYadBMY0xPe-DSfEFWx9Rskq2vRrQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] binder: propagate vm_insert_page() errors
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:33=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> Instead of always overriding errors with -ENOMEM, propagate the specific
> error code returned by vm_insert_page(). This allows for more accurate
> error logs and handling.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  drivers/android/binder_alloc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index f5dbaf1d7d65..aea35d475ee8 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -339,7 +339,6 @@ static int binder_install_single_page(struct binder_a=
lloc *alloc,
>                 __free_page(page);
>                 pr_err("%d: %s failed to insert page at offset %lx with %=
d\n",
>                        alloc->pid, __func__, addr - alloc->vm_start, ret)=
;
> -               ret =3D -ENOMEM;
>                 break;
>         }
>  out:
> --
> 2.47.0.338.g60cca15819-goog
>

