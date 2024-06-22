Return-Path: <linux-kernel+bounces-225881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451159136AC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDDF1F221B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75C97A140;
	Sat, 22 Jun 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EFrAXF8h"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38972DDCD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096102; cv=none; b=cmG8axn8iwJXxmVqi/f5BNDzR+qXjHHz7m5CUS9WetJl5Zdqz3QBl8aVEkVUr9yO9kSZkf//2woWR37Omdd57caIkGdvxgAcIKqhLBhuu6tHaJyiCgSw6jb7kAkVp9sl89fKjqDUizwh6LEmrBISs5j8UkCCipJ9T06nyJPMHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096102; c=relaxed/simple;
	bh=kqyVjEgP3/7mXzKVNMbYCUNnf3n+IgnYTEx7zPeTiw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL01Ld1kHRfZkiSb3y/rL6t3Hary/ehb+QBiRbGGgbmWhtE3y3CGUynXcFsRpzIw5MLRQHaLmGtAC93tWvngJSG7kfZMIbHrO0x6OIqObKDWJNMwmm07J1QvIWz5/Raejsl0PlDIlrjatGUOn8XiDIi1r+XdSqttXPEJ19Q+WQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EFrAXF8h; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72420e84feso57617366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719096098; x=1719700898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=EFrAXF8h1pSGOwzoYiY+6MYJ5abB/1iVrSeKo7TF2epGiiTgPM19jSh+y47wH9cgmz
         gjxQsa9eCVBo0T1+E8AFf5txp62LeiEOxGsimOLj2zmmiMQuAFMRfuo13MtHT0zNEnmu
         C06HsK6ZiVSChulZyu6nIx0o4HBLbmZs9E12A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719096098; x=1719700898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=oIDCW2OFdoO2Qs/pkBpCfabVd/D8AY/mZ6nPcHjcuBRfIDzhtla3Elq0mmwIYJ+8/E
         JRMv+3qnd0JQdcwZtzf04U6dZpbQqZKS05+pW/BU2xeY2E6L7ThZGkyNkkpHEQVUxW45
         VV+W86A4okzu3ttKz0V/MOSFVEEuRlzPmXTUPb5F2r7KUtwqZgE/HnWXgSAvPDDXHCPh
         eORPrLwQwLgEms8M6Wk0rVNHp/Ip81x5VwEcEQjiP3IO49Riv93uHLvSL+y/vGkPKi5g
         zcHgOJwCOA9+lGVxWsmfmzEpZkQHOSksZ8NP83rsOQ/gTFvnB+MpvAZ8+AIpxCgsfWku
         iChw==
X-Forwarded-Encrypted: i=1; AJvYcCXPbSV9qqI/57jobM3C3ZGCzRsapvFn/bYD7JRqWLfC42WfeaGBv1b3ONTt1X8BLEfSoBXlPty+QyCU5EIcV34qkHY2JybwI13Jk6Vq
X-Gm-Message-State: AOJu0YzmUr4XOKP4vYfeBnDGsxHpAAVVjJUadV8M//LMF6z9HDK9PFsC
	G4fnelKevusZDEQeRtmaN6Gj11e9lVy072FlKRu0jKWIxp3dV+HWH2611x3/Q3B3OS5cIPL6xLZ
	EQr8=
X-Google-Smtp-Source: AGHT+IG1G+47vqXOB18LabVw/kze31R/c2PLDzLgM+JGGSvuB36fNLLsYJyGskyh12f/5LYIm9Oj0A==
X-Received: by 2002:a17:906:7055:b0:a6f:53f9:7974 with SMTP id a640c23a62f3a-a7245c80a43mr52714866b.52.1719096098340;
        Sat, 22 Jun 2024 15:41:38 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48a0b6sm240892266b.53.2024.06.22.15.41.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 15:41:37 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso3730723a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:41:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+zZlannTlk3c1CgMTQfZ4Q9LnuIktuEcBMoKeLegiVd8iyBDCcVU/uqUk9+ydLdRDtW82+s0EHcm1FhR9gLDxq+mzLgDn2d14mYzh
X-Received: by 2002:a50:d653:0:b0:57d:785:7cbc with SMTP id
 4fb4d7f45d1cf-57d4bdbfae4mr617930a12.26.1719096096671; Sat, 22 Jun 2024
 15:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622105621.7922-1-xry111@xry111.site> <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
In-Reply-To: <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Jun 2024 15:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 14:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> +cc Linus

Thanks.

> To sum up the problem: stat and statx met with "" + AT_EMPTY_PATH have
> more work to do than fstat and its hypotethical statx counterpart:
> - buf alloc/free for the path
> - userspace access (very painful on x86_64 + SMAP)
> - lockref acquire/release

Yes. That LOOKUP_EMPTY_NOCHECK is *not* the fix.

I do think that we should make AT_EMPTY_PATH with a NULL path
"JustWork(tm)", because the stupid "look if the pathname is empty" is
horrible.

But moving that check into getname() is *NOT* the right answer,
because by the time you get to getname(), you have already lost.

There's a very real reason why vfs_fstatat() catches this empty case
early, and never goes to filename lookup at all. You don't want to
generate a 'struct path' from the 'int fd', because you want to never
get anywhere close to that path, and instead only ever need a 'struct
fd' that can be looked up much more cheaply (particularly if not in a
threaded environment).

So the short-cut in vfs_fstatat() to never get a pathname is
disgusting - people should have used 'fstat()' - but it's _important_
disgusting.

This thing that tries to short-circuit things at the path level is too late.

              Linus

