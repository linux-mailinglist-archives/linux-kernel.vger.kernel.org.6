Return-Path: <linux-kernel+bounces-229471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F5916FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6977C1F21F21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B617B438;
	Tue, 25 Jun 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g9FOoVxl"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3B178371
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339157; cv=none; b=eMrTsjE4Kvs9pkSigSIt7n/5v1IwmHmcAepSePf0r+CgIv+X9zfBsCz8CPC8b1KDcKlr7JNZQvRtEgYTshgLjf38Uf6pJT68I2jnM/hVCfNuOQnaSZ/sIWhhhk16YUY13pzF9BQYrZapYdrcjJnIlKtmTGRmwyjy3A2iX4Vubi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339157; c=relaxed/simple;
	bh=nGXNe+PE/VAVWq1alIdYYv4xLsJd7LfebmRVN6KSWFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/jIGwC6xfcBF3q0wOLL+C2ZTep9eA9dHGKDEO4HJqDyLs3iL/7GufgeMZhFsnmzEyL84SPPDfxzpKEplnQuf87gX4FS5erZnB1CYQ/eY15d1BiwAfnAz6GX8khfz/cMLdEI9GHwZYf8IwO2qjELn+YdV6IzMQZlqEs7yOezPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g9FOoVxl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so19833241fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719339154; x=1719943954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6VwDOaqwr4wbQW4OWCZIaWgizSIAoa+poBbII7mCEk=;
        b=g9FOoVxlQbVOwJuCFHrNjo5ibmQE8VpZwDXIk2GAsmi9AmsBHW1lTMzK0rTB+T/UtO
         FsadCM6oCOyEzWCXv9p6e+B+8yvX5l9zqBEbuoEtCarUdX5XD2HANz+GwS0fNXxDOS/i
         05UyNKOwUc5R8piqCjn8zLC8zsHnfQzTsEl9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339154; x=1719943954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6VwDOaqwr4wbQW4OWCZIaWgizSIAoa+poBbII7mCEk=;
        b=nRW4ia94MH/w/h+ztXA0T9Dk2Azzdqr3OVIUBS63RUxbRQ201pM3YzorJiY8ILyLzF
         UM0hMl3eA7g2qkmYhCwPILDEM+oqE0CGBwQBDGl1NVLT8ekZBWDe1Hhrk1zVPGmuKIOg
         BUzq/Y/wXZMqYfP/RYN4nsMukSpQMvEIARdBW/VdqUHzYHjHmIBgof4nV7pw9+MrTZfq
         16CiIMEeU7I6j4M4K8YsPgcutD5+sA+qCW7G5qOETbmcy6FAB8ptPNvh0oPInWT7juDE
         pNr3HD+MPda+GBQcYnEx/SgrHhktyac/YTYTXs92lbg22JxJhAWUY1nxg7M0IglDD7lf
         rxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPTLretKNuj01Kz/s5HXvYFTnJTA/JIZJMbl7BM/aB63+I4G7tOBKl3+9REsU1wkplHO9eLoaAB1d0CI6FXZWgKfK/QkKPwIH1JMg
X-Gm-Message-State: AOJu0YyjLnP5EiVOQZVSUPV1IDsmIvEtzjilLiryfywfJXToEL2/5gT6
	64eGUJVKmdxRxyIgc2UwoMB13CBdxKYEa7DvMkctQ7N+GtcwG2f5zlckC43jVDhuoaeuheKFBVO
	SOY5uoA==
X-Google-Smtp-Source: AGHT+IFFKSp2cbx20G1PutA0FGwUU/2C+Tp4obCDUBsvv+vyzbsAUo0E14tANMmZ5Evrs8mxqyZyjg==
X-Received: by 2002:a2e:9b94:0:b0:2ec:c8:2755 with SMTP id 38308e7fff4ca-2ec57983763mr53721961fa.24.1719339153966;
        Tue, 25 Jun 2024 11:12:33 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4db2ad8bsm12380991fa.85.2024.06.25.11.12.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:12:32 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so3333052e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:12:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/YNzQj378Sqi6lTMsFt2/8bHGzLYAKndxAl8kLyiv1XOp4S9kcZXDvBdsx2wSen/8GW1G8JCNt2m+yd5W9fjZ8J7rMx//d74apgSh
X-Received: by 2002:a05:6512:1594:b0:52c:cca8:a9fb with SMTP id
 2adb3069b0e04-52cdf820956mr7108544e87.42.1719339152174; Tue, 25 Jun 2024
 11:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625040500.1788-1-jszhang@kernel.org> <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
In-Reply-To: <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Jun 2024 11:12:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
Message-ID: <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 00:22, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I think the only bets we really need from an architecture
> here are:
>
> - __enable_user_access()/__disable_user_access() in
>    the label version

KCSAN wants user_access_save/restore() too, but yes.

> - __raw_get_mem_{1,2,4,8}() and __raw_put_mem_{1,2,4,8}()

You still need to split it into user/kernel.

Yes, *often* there is just one address space and they can be one "mem"
accessor thing, but we do have architectures with actually separate
user and kernel address spaces.

But yes, it would be lovely if we did things as "implement the
low-level accessor functions and we'll wrap them for the generic case"
rather than have every architecture have to do the wrapping..

The wrapping isn't just the label-based "unsafe" accesses and the
traditional error number return case, it's also the size-based case
statements ("poor man's generics").

The problem, of course, is that the majority of architectures are
based on the legacy interfaces, so it's a lot of annoying low-level
small details. I think there's a reason why nobody did the arm64
"unsafe" ones - the patch didn't end up being that bad, but it's just
fairly grotty code.

But apparently the arm64 patch was simple enough that at least RISC-V
people went "that doesn't look so bad".

Maybe other architectures will also be fairly straightforward when
there's a fairly clear example of how it should be done.

             Linus

