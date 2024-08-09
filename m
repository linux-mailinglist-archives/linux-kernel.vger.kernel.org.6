Return-Path: <linux-kernel+bounces-280997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3094D1B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764651F24EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC219581F;
	Fri,  9 Aug 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRjSAZHh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086B146D6A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211883; cv=none; b=N7YAMT/JwvGhodQXq5mj+xCwr8SNDD7n22d5BT1/luMT55AUW0FiX7bFxW7uAm9qik3csrwQYBnmOC6p+w/OOAm02/9/T5LeTuOTwpitOhnqgbS8UIIHjrvEiwOoqxffKDi0FSlrU9RhnE33omuP4HPNkZ3ReOap+xucxZcG0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211883; c=relaxed/simple;
	bh=w6Vkbk7g1bhMu2SYQ5zcQ14DAY77SckcLxEdl1ex4yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QecLLrf0xrDK2SfGGpz6q6/y8E8UpjgA/iGgyNTFRsHsGLyhkZaK10cjPARZJ3q8vnaLVlCLHMvdU8DnNpZnCy9L3lufL+htGWDFe8qBzCUXMcW5P/9UrJZapqCgUVDGm/N/2qyX80IZa/Ou1wmEZudjksHjoSBmKfJnsfw0i/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRjSAZHh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so11925a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723211880; x=1723816680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6Vkbk7g1bhMu2SYQ5zcQ14DAY77SckcLxEdl1ex4yo=;
        b=tRjSAZHhLbdbfid7C8lcGNSDDvoAaag4+iQgrgCOdn6DXV5Efrm8jDl1k2xEge2TBq
         Dr0FcDkPlEf7QMQA7XfQf17lNSrW8odn7zAeZK/72NKQZkzrm1AUzq50Vp4Wldkpxxdu
         RVAa1Pck4vDzjXKNVR6W+og1gJ8kEtn+GXysKxKR4Y9i1IMVN+CvY8dLYMUn6ikccvub
         Au/4UHPL3JLfiiRqMqLt+qHplDlxGRIjI0JdnF2N1c9x2ve2SZBmOSmxH1ZJ8a9OcSyk
         Jk999JD68S9/G0An9JI922lXPVEs3/U/hhohGwmhDyt9cSjniU4+0PVD/BM4TyF5cM0s
         M5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211880; x=1723816680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6Vkbk7g1bhMu2SYQ5zcQ14DAY77SckcLxEdl1ex4yo=;
        b=O1mclZKz20FVCwy6JidLE6H706itbmpGHmc81zSbNIbsHiiWqmmZfMhDwBbalH4vqN
         yPs9uPQ6piQFK9Cmt0B0mQ0De5Wo+shPHyvVn0VG/0+2rXm7PtiHhig15caZZbC0W0W6
         968OefzDxFWN0UPKlNgfYLXCBbslMjiSXnPA+3A1Zs70z3TCJ2DbrHsRqXLdqtffZ8O6
         0Zrhf8cldTRqeq0ZTTG7BqBDROEc6Wu53l/ApvEZouC7zphdOXeBuePsvgYv8QBI030u
         mT8Fx52dr7raLzoWaT6FbzRBug6AuVGS1tQ9sWa8OYvGNWAP7bKLkjQ4T2RO7gTv9L1L
         HaqA==
X-Forwarded-Encrypted: i=1; AJvYcCXV/vQ8t8AZbsKWxLOxrOSKq5MP2ncP6gPepHiCrtL3BRZE7vi8Nw683hyEJE+UAZ87AozZn/wVL/QcrdXEskgVrInH9WIkigic/mJW
X-Gm-Message-State: AOJu0YwksTslGPG/td6bApB4U97F16OsRuu5ez1nUUmWPg7tqciUrfZV
	iqjTwXApRbS1rvbiddIsv1MP4Yhz+KVjoyjbm5Nos5JX9olfxPEG6/8ADRFl/E80aGzEKdLWTyr
	EXCwXD9lxqLOus8JCCC7J+p5y4WM2LbXcZM/o
X-Google-Smtp-Source: AGHT+IEAwCE819eFp9HXrJhbiR7g72RxfA+RZ0jzRNR/HFmgCAtCKkR3PyB+6FOmP0Sp56cWkOjaTh98FKimp19wPws=
X-Received: by 2002:a05:6402:5216:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5bc4b3fd7b2mr131081a12.3.1723211879768; Fri, 09 Aug 2024
 06:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.fee1eiPohphu@digikod.net>
In-Reply-To: <20240809.fee1eiPohphu@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 15:57:21 +0200
Message-ID: <CAG48ez3nx4fR7skDf_Vhgm3OLJqGtsLUgHQMykq7oy9HZq5fgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:37=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> > On Fri, Aug 9, 2024 at 12:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Thu, Aug 08, 2024 at 04:42:23PM +0200, Jann Horn wrote:
[...]
> > > > So if you want to use RCU lifetime for this, I think you'll have to
> > > > turn landlock_put_ruleset() and landlock_put_ruleset_deferred() int=
o
> > > > one common function that always, when reaching refcount 0, schedule=
s
> > > > an RCU callback which then schedules a work_struct which then does
> > > > free_ruleset().
> > > >
> > > > I think that would be a little ugly, and it would look nicer to jus=
t
> > > > use normal locking in the file_send_sigiotask hook?
> > >
> > > I don't see how we can do that without delaying the free_ruleset() ca=
ll
> > > to after the RCU read-side critical section in f_setown().
> >
> > It should work if you used landlock_put_ruleset_deferred() instead of
> > landlock_put_ruleset().
>
> Calling landlock_put_ruleset_deferred() in hook_file_set_fowner() or
> replacing all landlock_put_ruleset() calls?

Calling landlock_put_ruleset_deferred() in hook_file_set_fowner().

> The deferred work queue is not guarantee to run after all concurrent RCU
> read-side critical sections right?

Yes, I was talking about my "it would look nicer to just use normal
locking in the file_send_sigiotask hook" suggestion - don't use any
RCU stuff, just use the same lock in file_set_fowner and
file_send_sigiotask.

