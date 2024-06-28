Return-Path: <linux-kernel+bounces-234087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E691C204
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB6C1C218BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72B1C230B;
	Fri, 28 Jun 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEDp4h/8"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21651BE86B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587081; cv=none; b=UcMF4HwPgEi8MzZBIaxLhHeLN1avoYr1Bwnf/YlrFEsjhJvuNpLQO5wYuEkpvhUOQtqYLGLgtq0OfssOqUSl5oN4fwTUkVwoVP31wkWh4fo2OtJmNEwTtGKAUidDnYUOqLJ/HLLhcfVvh9uQYiOMin3c4kSVRlg0FVLlkWcKhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587081; c=relaxed/simple;
	bh=4HrWgrMVq1i/YjC4ut2igeIH8gX5s35Ldos/IW/06ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxg5Kwv/nNDrNVv7/XI1hW5dzJDZOilBp3h+5NIKqzAWsE56luFab824KpCCVrX5Xi4kBGVKSX58C1zsQK0o+sJQrNtaO06N5yXh7VVHM14zAwiaeZiOkHGZDjrP+xobKoFPOgsWCX7a3VUO5lNzu43w7Z/+/tRmHoSYHUwkGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEDp4h/8; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-700cd43564eso349433a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719587079; x=1720191879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IdPgPHdqxoeiATTbOh8/ckCue/94/+WvA2r7sPESkkk=;
        b=SEDp4h/8bpLTcONdgeGAz6GxYAeJZD2nhb9NfUTBCnnF6k2jk5oCVkYt8sJnEIbXse
         ho8ViCVYFlDg3ABrUvkm5dnVg5H8tGtKhT5drak4wWI4TuCIlTFT/fzQsBLzOn9k0458
         RWq7g7/ouztAHMSwuhjvIlwvgYoZqApvaMlKxYjKv0qZg4DeO8GCy5yyaqX3v0559+as
         ndbVT6+zXfXFhR2b1OjfbmMfCiKzDiRkvU/VBy3USpK3Q8PKUfAoNgnExmikhQID+Xkn
         CEYZxCC/3Gn1ssGs8XfPG2ep4OWtjxUAdPkuh9xJpFpkoLegFKl2IGrA8SlveK2Stc+v
         2uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587079; x=1720191879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdPgPHdqxoeiATTbOh8/ckCue/94/+WvA2r7sPESkkk=;
        b=vO7l5lewoRj+OJkYJMcfDG9ipyyDvyj3Nf0NwRbgZeQfibonAEeUTSJpkO6gpf+9Xp
         2wU0aPJ/nc1/XPM1ug67lXm+44t/LbfsnisFfjCMdWnn7bJaK4pDgNzq7UCv/jjrbn6+
         ac/A6/zfu+WIj0Qy4qvskRkeydOO03El74P1E+NgUxh/S8Mvbdt+smE1WMimKSFtuHZ3
         66COXGgTXSydX7euUah59m/cwdtPuI0Yv3nyXPw3fAenJ5MuLFwefozKLGK19DF5LyYn
         DKHDTwBxLXEYI4UBYGrhaCh+fJpYiWhIxx4T55fM3rrnfoWmvLD0rxeyHC7BUEfg4t2s
         HT6w==
X-Forwarded-Encrypted: i=1; AJvYcCXc2SapSjWmr5fVGc/W4jMENQX/J7l2kS9JvAJLFfLlYN6wCkoCyQ/YMWlmcpsNdJyvLVxju5oTZBWpetsp9thiDHwXxw6Q+6pqLqMB
X-Gm-Message-State: AOJu0YzkqElt3/zpeHSDJrtLSw/FLC7tuezHqNdWkWEwonzGEbuU5koh
	1QIwHKGFF9ejlr2LMTHd+A6YKLDC6j9ITeXpBPzP529bSlwrZaGI2EXwZ4m6jEYhLPY332d9EOF
	3aYujpxl60usP6FNSFvg4a+8YmqUTFSzdKhTP
X-Google-Smtp-Source: AGHT+IFIH5GSIlejCaeZJUlzf/wdLPoHO3nRreBGVb8Lrricv/ZEiUvWttJ1AzkoFkrRhwDOgnR87ijjJyZ0O8134lM=
X-Received: by 2002:a05:6808:1307:b0:3d6:2d2f:d03b with SMTP id
 5614622812f47-3d62d2fd33cmr4988807b6e.10.1719587078322; Fri, 28 Jun 2024
 08:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623220606.134718-2-thorsten.blum@toblux.com>
 <CANpmjNMHPt7UvcZBDf-rbxP=Jm4+Ews+oYeT4b2D_nxWoN9a+g@mail.gmail.com> <1bebf2e8a8a64b4aa4097fd045993106@AcuMS.aculab.com>
In-Reply-To: <1bebf2e8a8a64b4aa4097fd045993106@AcuMS.aculab.com>
From: Marco Elver <elver@google.com>
Date: Fri, 28 Jun 2024 17:03:59 +0200
Message-ID: <CANpmjNPoYaCVTHONGhN3ZJgd_yzUSMmjib+EBKbHG14xLnrQwg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Use min() to fix Coccinelle warning
To: David Laight <David.Laight@aculab.com>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, "dvyukov@google.com" <dvyukov@google.com>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 16:52, David Laight <David.Laight@aculab.com> wrote:
>
> From: Marco Elver
> > Sent: 24 June 2024 08:03
> > >
> > > Fixes the following Coccinelle/coccicheck warning reported by
> > > minmax.cocci:
> > >
> > >         WARNING opportunity for min()
> > >
> > > Use size_t instead of int for the result of min().
> > >
> > > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Thanks for polishing (but see below). Please compile-test with
> > CONFIG_KCSAN=y if you haven't.
> >
> > > ---
> > >  kernel/kcsan/debugfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> > > index 1d1d1b0e4248..11b891fe6f7a 100644
> > > --- a/kernel/kcsan/debugfs.c
> > > +++ b/kernel/kcsan/debugfs.c
> > > @@ -225,7 +225,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
> > >  {
> > >         char kbuf[KSYM_NAME_LEN];
> > >         char *arg;
> > > -       int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
> > > +       size_t read_len = min(count, (sizeof(kbuf) - 1));
> >
> > While we're here polishing things this could be:
> >
> > const size_t read_len = min(count, sizeof(kbuf) - 1);
> >
> > ( +const, remove redundant () )
>
> Pretty much no one makes variables 'const', it mostly just makes the code harder to read.

This is very much subjective. In my subjective opinion, it makes the
code easier to understand and it'll be harder to introduce accidental
mistakes. For trivial cases like this it really doesn't matter though.

