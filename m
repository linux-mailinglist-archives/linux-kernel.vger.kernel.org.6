Return-Path: <linux-kernel+bounces-513123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C707A341BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB0A7A5CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DAC281363;
	Thu, 13 Feb 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nk1bX0/t"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFC28134A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456448; cv=none; b=Nrk1SKnVACu3fJmI8Nt9P++/oL8ftrG5zfsPZqmKoT3Mr9AUHxZHPZx4FAcMydOz+GZnozmxISpDx7hg/fD/emYgwEnOlyOKvsrT5sdQtmeUb2uGSGgSkuMKGbOh2yovtm1YP0oRSJsudZ1b6NjJQyV/2l8husayb0JjfErSYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456448; c=relaxed/simple;
	bh=W4UC5h0oxNGNf3Gcc3aP7t6L4iCexNLWYlMLrbpEbw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLxjwg23JwjQ/Ov1m+Bgecrg2QVkK+5v9BPUf3FWC2Whe8A629VPAcx4PJukcAyCtNv5+4s/I1v8cYkSAJrGUsbYrvwlmqzeaygGbyIZDVxCccwVusx03spRfb9uJ2MtprkiCktJhBlqgrj8b66lCb8XFoEo+PFboKlnFphXbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nk1bX0/t; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f3d8e72235so23280b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739456445; x=1740061245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4UC5h0oxNGNf3Gcc3aP7t6L4iCexNLWYlMLrbpEbw4=;
        b=Nk1bX0/t+Wg49Sud9aF9L+2146eGOZuquDOs5M0/wQOW2ELLDgm8X5PcIkXjDU3GZ4
         cq+WlyvY0NGPdO+wztGfkzOcquMjsSB3Ipid9Y2dcQsQ/fDXgDsiHUk9G9sQYt897+Gp
         v8QGP8A1CMTYxrZHrO0oNSiyerKOi/i7DXlO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456445; x=1740061245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4UC5h0oxNGNf3Gcc3aP7t6L4iCexNLWYlMLrbpEbw4=;
        b=wmX+Sm0OOlDhHdgO3JAzBDDQjKOAVHBXKOxElJ1SEtAHKfJT2XiZtruoZQLALo+yxi
         gl/eGc3wulnJFew97ikMItYxrjaIahoCfoulbejMVbeQphCk2sOJlcm45BEKxw41N9NA
         L0PpJVn7zjqofVHbPBOo9b8zhhPVg0AzGHJ58/yrDvU+RyJ6By0ARTCRyG5mc6syAETi
         Ba2enM9EoDGT9xCJlkbtopBmnBJqaPQvQ0ymVFyIQu6FjAhglQNLgCNjKFc7ylAPW31r
         iSN7Tg8bFPW/hE3ruolzzoJre+LM1/QKhrZZ6IJuYsfTDeAUQ20H7awDHFTxnCEwgC5v
         eoCw==
X-Forwarded-Encrypted: i=1; AJvYcCWcvz1TYvnEjj4eDJRR0UcB4Z8Zou4VEMeZ0aPcsPdwD4RxMVPhJtW+4nBdCjGWK663e+utXggZCzariMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2lIqRnEmAUcYbrq3M9DGAoKZ8M1oYjNOZju2dbCopkQ/Indx
	bfswwhPQHfyg4mQ6tzdmClmXsX1fdhrT/3s3094yq7q5wItKB8pd/i1qC09YFprNXaq4+pkLOJI
	cBv1tlDo/Kk8tUH8wgX0MHYzcb+NtSALSkJyK
X-Gm-Gg: ASbGncsUs04RmNgMRYMX+trt1Kkgyg5m1TpbjjZDCQCWD3md6MjPBCnzXK5gLTbVbX7
	Lwbn8+CDEWIrEng0hrsVvDiaww+NTxL9BIyLSKHnq1N4zLEqSUiHtxw1YbhG1BQQOSTcCVKYaus
	YP9VszqHEFjJzIoy+LpDl5XgwHbcd3LA==
X-Google-Smtp-Source: AGHT+IGAXPpwFZ7DOEudMrOlVqjPC+LaHLP+X27Z9YtQOz9iiB2ORSQ7DxYPkmOMw4okkqdaC7PyOXVEXg9CiOpB7yg=
X-Received: by 2002:a05:6870:14cc:b0:29e:73f6:ee8b with SMTP id
 586e51a60fabf-2b8d68c8a25mr1609549fac.12.1739456445551; Thu, 13 Feb 2025
 06:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <202502121401.B6EF2D4517@keescook>
In-Reply-To: <202502121401.B6EF2D4517@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 06:20:33 -0800
X-Gm-Features: AWEUYZl-9kl58flpzB7gHde-CGvyUjvurrYBhAejrmr0ps8oWaWIhTMUJXeqP18
Message-ID: <CABi2SkVMzeerqeFcmGxVwB+uNeZDmRPF5Nd1oicUXJuAFnHB=g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:05=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> > It'd be nice to update the documentation to have a list of 'known
> > problematic userland software with sealed VDSO' so we make people aware=
.
>
> I like this idea! Probably in mseal.rst, as the Kconfig help already
> points there.
>
Will update mseal.rst to include the above suggestion in the next version.

Thanks
-Jeff

> -Kees


>
> --
> Kees Cook

