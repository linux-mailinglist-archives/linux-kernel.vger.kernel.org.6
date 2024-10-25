Return-Path: <linux-kernel+bounces-381151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E39AFB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A8C283E94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015451925B0;
	Fri, 25 Oct 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhgJEot9"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D900156C40
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841745; cv=none; b=Z3622ZePsenRliQoZVMLlxsENmvH56zmc4TxBhwErMIVlzpXHd5eou6XyacHsKXjC2PzgQQK5VWJmrsp1bWPTBiInnpEVI+MW6iR5eO4yFPMxVwkWEnB0bX4A0QB8fhZSKjo5lCNHQodNTCWd71tWQ4a+Uc3qHI7vKvwdts3VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841745; c=relaxed/simple;
	bh=rGvGIc1qiNqwfkIsPmKUXxwK0y+VXC0z56uOdEuCMsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAg0ior/4Tl1r/E3p4Tk4Rol/xZhu4rfMJ9on2cleWM/IXiUAd/Scug1rgueArmqFbWHN+3qkFeSrpNZIS1HDsCFzKHE1q9cP8HB6hTTr1rJkTvGdldHygj2pJGGnux1JdT4b92DnD1956ZExZfP+roQdiIY+T/37Ji8nFzqgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhgJEot9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so16692001fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729841741; x=1730446541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGvGIc1qiNqwfkIsPmKUXxwK0y+VXC0z56uOdEuCMsg=;
        b=KhgJEot9IsgR5PA7XAQobnsDbL7ZX8YvvDTbfXwdJP/gjXPKzByTeou4JOH0GSiZVq
         ZS/OSt4dYM7yVPFXdKe9Tvm4knrbP8rOS6dcXrWiwjIA8uMXAZzLLfpJo2V9rUufOOGD
         K88WQqDZGTGdJLcuIGKypUNp51MTepsjmWiCA8jSFWdfwSOCMCSn2rtE6mRIiLCPZB+Y
         WGEMsvEXfCGLxy1fTqBT4FgYxcUEFOCFQtmg+28XdUvDFFTac4aCcofVNMzNQwdlUKAL
         pXS5+UQdQ8Ho2cPoVd+9u7lOcEJiimgBRFhy0XPgHqHw0krj9fvYRBccUVMbztx64ziv
         gp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729841741; x=1730446541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGvGIc1qiNqwfkIsPmKUXxwK0y+VXC0z56uOdEuCMsg=;
        b=LWeruzoWO7JVBC5feKBKt3zWnRBxMRXyYarUGi0HsO3KgVMKLyX4FsUmoWhMNanqGW
         L07H0HeaXcZ+qjJFuCrBWdmOMtEkiDcdry6mDH/oqfCT+T6l+dLSe6+BPSSyE0NYQCPT
         TlAjFMxXpXeeYXgFC6PK3kc5U8xgE1AO0ITBDzQej0mkEbJr3MvfmnXBzMKcWFJnvuC9
         L4be0f1bRR/2luF2X9hx5LGb71sMlvr8/fjYHDhdnVDJOzUCp/GkeI5/HEOVNMPaJMyx
         18DJKTSVm5yW4jkwfGy4xeEIjPknzUuibpt0ffENwp0unNoA/l4XgBImwLo4F4lfMZHj
         vqNg==
X-Gm-Message-State: AOJu0YwwsIziTA4Tbr2AT+DDhLGZiyJGgLbCXx90Dbo7/gX4NGYBliYH
	xS9iG/wd0rUoj008s4TQRzVqWkThyPpSLHtnoBR7Zzr9IhZ5QH99witNloWVuzccdpmxrsj9/en
	yMgCjKC8zi5DcnieHfuyKUTD9XNqIyaHV
X-Google-Smtp-Source: AGHT+IFgnXdO8af6o7ebr8MmSjk906AemSzYS90BmCeyt0qLhq+MrKH7H+SieMuw46FNWoEo31zCvdeyjvfjDC9VMlE=
X-Received: by 2002:a2e:b8ca:0:b0:2f3:f4e2:869c with SMTP id
 38308e7fff4ca-2fca827f77cmr26671301fa.44.1729841741115; Fri, 25 Oct 2024
 00:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819074124.143565-1-ubizjak@gmail.com> <20241018112259.GD36494@noisy.programming.kicks-ass.net>
In-Reply-To: <20241018112259.GD36494@noisy.programming.kicks-ass.net>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 25 Oct 2024 09:35:29 +0200
Message-ID: <CAFULd4bBaFWVZv=hERmHExn7ToJbJ6a+VCtZPQ3FvbPO=5EJCg@mail.gmail.com>
Subject: Re: [PATCH -tip] cleanup: Remove address space of returned pointer
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:23=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Aug 19, 2024 at 09:41:15AM +0200, Uros Bizjak wrote:
> > Guard functions in local_lock.h are defined using DEFINE_GUARD() and
> > DEFINE_LOCK_GUARD_1() macros having lock type defined as pointer in
> > the percpu address space. The functions, defined by these macros
> > return value in generic address space, causing:
> >
> > cleanup.h:157:18: error: return from pointer to non-enclosed address sp=
ace
> >
> > and
> >
> > cleanup.h:214:18: error: return from pointer to non-enclosed address sp=
ace
> >
> > when strict percpu checks are enabled.
> >
> > Add explicit casts to remove address space of the returned pointer.
> >
> > Found by GCC's named address space checks.
> >
> > Fixes: e4ab322fbaaa ("cleanup: Add conditional guard support")
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>
> Thanks!
>
> Now lives in queue locking/core, and barring robot screams will make its
> way into tip.

I noticed that the patch was removed from the queue. Was there
something wrong with it?

Uros.

