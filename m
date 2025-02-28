Return-Path: <linux-kernel+bounces-538037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34CA493D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162493ABC46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB12528EB;
	Fri, 28 Feb 2025 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJLjYhAP"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8925290D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732289; cv=none; b=oepr6n6V0bub3/BmwPJsjQgi8ZBkdlhZuEMjjqgnsgl1R5204RKZZQgFnBN40nIN1mXbDNwlgmoM+Sx0OjPSDflN+HbDBEJc87qpt5LrUfubzHxEbPK4v67zjdmhePDiaZ5MeQhpVG7IhBgEnuXBSh6RzqbbnpQc6Fc8Immh4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732289; c=relaxed/simple;
	bh=Zkf8l0uryByZdz9QVPXFiiID4xittvMYr6H6I5rroZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH48BwLT52WQtr/RhnsL63MSH23rLdSyVMVn5VdH9uso3zGXjqUlZ5AWP0tphKZRRg1Z3jKFIOEvYFsnJ33nKh2dPUjHQvwgXeNqm+5ZOgYRuYy3ofsZRY/tF5aq45Sp9zp8/mjkSGMjvnbge6HQCw0QB/Oar6Zo/w52V2x+W5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJLjYhAP; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30b83290b7bso21016641fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740732285; x=1741337085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY06bAcZIeFxZq+rVVGy8xdQWazfVF+gu1V9CdHTqzs=;
        b=cJLjYhAPZ7R4jkUQq4r+JwFM5ITl4gMzBc5M9hgQJTlTDr7haM3fvcSLMEhDfMgy6F
         KefWKRgCKtYJt7gVIztCr0zhOEZp07UaR+wIqZmB/0iQWwjnH7JY/Hq1kn4+atAn8CKo
         HLdx351OaNXjyj0OFA1+K7F28xuI/brP871AaYi1hlhJCQYYkrKZgNQ7tBRvbOx5p4xo
         mWrqPXN/Wc9MtPNAK8enzSMhGrXwieg21vXCUc6dTCjDwMaxgf6Yd+bUi87tEBXWI8LH
         pXraJ+2I7rYIasrxEigj/mUPZkDCo5Y6tnR+D3GRD7zfuqqe4l5/eluLNtbD8q0Jzwwu
         54Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732285; x=1741337085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY06bAcZIeFxZq+rVVGy8xdQWazfVF+gu1V9CdHTqzs=;
        b=LbWX8qgRXJXuXa9uYUhoMN2szM2gyEazNaH2jEt6llQZy2wk9cBcrqd6CRbFWjw/7U
         9IpMs5jI5m7RJN/MkJ1Qu8nhGIXODqqkPeGoHgGk91jTvKH4fRoG2jaNV9UuUJPMzH8L
         PdLVYNgEhFAPvNU8a+sFe6ES2uqahEXbNVwue89WI6JOP7OXG7iK9mtx5HxZQm8bnWzj
         IqM3nQOzcZjBvYVqyMtMg1OHpdhj7fk8yXQRTAT+786vK0MFlIrTP/sKgxphCg+GBAKh
         wU1GVIoy6F2o9kpsuszVNooySVRRu0JnIvAtA1an1YbqlgSq6E6COZJwEXuJ8SZAW1GG
         VJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXYRWR5FgOSKt1lG8nsYmihy/k/gh63pB4SFVaPyxy8Th3xjF+Z7mFE8q/ic7Z6UCBFU8OcAdEbIdxmdf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7su7sWDuo02JKIeTffJu2YU1VLXtZ3rFYcril++6Vp4UPpHW
	8weSz83GDNZM5ecnm2qW8R+edsgNfSoxWCKSaHReBfEuwpZIV9tFyMISsxQt4rmh4k8Fc/BOLtJ
	en6PdXRKEqt1yKm6DGMVmGDgEj3pYtmeSTb7s9w==
X-Gm-Gg: ASbGncultPS0U1KmxOc2vKWRbn9CezUQKTVxbiPUJ6QQtgrgvjsOyXHrhBMQJbdjwxq
	eC8u46Wo/sL7EgkQJS3CqXQxKVuuFpJ8FjPC8QyDjIDul35cRpYdepCgDE4OhZGNszMbt6mzn2p
	9X9pBPfdk=
X-Google-Smtp-Source: AGHT+IE62towVdCnTrudnvaIoU1TJ6pTFTYV/chtSrCWTC1Ko1AEApipZL64MrBly6WJNXyhwZwLLXLgsny92LECsFE=
X-Received: by 2002:a2e:9fc9:0:b0:308:ec50:e841 with SMTP id
 38308e7fff4ca-30b9330f13fmr8612541fa.25.1740732285416; Fri, 28 Feb 2025
 00:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-04-gpio-irq-threecell-v1-0-4ae4d91baadc@gentoo.org>
 <20250227-04-gpio-irq-threecell-v1-1-4ae4d91baadc@gentoo.org>
 <8fce8a9c-7946-4e3c-bbf3-25f8b4f4466f@riscstar.com> <20250227204155-GYA51171@gentoo>
In-Reply-To: <20250227204155-GYA51171@gentoo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:44:33 +0100
X-Gm-Features: AQ5f1Jo79JYnCkWBYG5UqJJb1LGSJ1JmSW8NVl43VT942aaOGBkJP3E28SChE-c
Message-ID: <CACRpkdas4TsMQx2Cvu_JR3kTStqWaOt1N+Cmq7nFesMzpGnZ+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqdomain: support three-cell scheme interrupts
To: Yixun Lan <dlan@gentoo.org>
Cc: Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Thomas Gleixner <tglx@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:42=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> > This function is meant for "twocell".  There is also another function
> > irq_domain_translate_onecell().  Why don't you just create
> > irq_domain_translate_threecell" instead?
> >
> good question!
>
> it's too many changes for adding "threecell" which I thought not worth
> the effort, or maybe we can rename the function to *twothreecell()?
>
> I'm not sure which way to go is the best, ideas from maintainer are
> welcome

Yeah just rename it twothreecell, that's fine, we will understand it :)

Thanks for driving this change, much appreciated!

Yours,
Linus Walleij

