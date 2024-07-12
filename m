Return-Path: <linux-kernel+bounces-250214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656F92F543
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8553C1C21C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886413B2B2;
	Fri, 12 Jul 2024 05:54:59 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511A13B580
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763698; cv=none; b=ROsKdGDSrvvDzWqa9bFhkrfT/hiAYeXrBJdv/+DYNKKyl4NdFnYNOp3HcXHzEnwnKDO/7JmTWOJzY5xxKS+MZ/rETmfbrJLP9PXmDNajwbErCNIsxo6f0bEtSMjxO9w3/5Hj0VTip/S77LEjhESGTkGSQpp+1WRsrsUfkiSWdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763698; c=relaxed/simple;
	bh=fg8765+pk5IfWfTN3LNZ4gvaQT1UA0MYjWp05Yd3gQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI3RubGyb/G+g+4MLOSrTzHBBPi+V4WRhEduzEiv2vacc74RtzCnw9eejoOqLYgnqHmFHSQP8dMU3tgOVI1IC+AxOso1elqjxoshO5joxpEI5IKbByMswcZzyfbbbuv6lOa78IEMsL0iyDw0rPfSnk5EoNI8lSjQEB3st+ReMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8076cee8088so54559739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763696; x=1721368496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40hC4a3JyqAGowvvkpNf/Hf3u0OS8HjmD+s5WJJ0YZ4=;
        b=NO77yEgtB/6pORD6wJupGuFCH/luUgNwTQX0/5TSUfEsw26vMCLPQ2J0DzDLl4RBoG
         yTa0uIk6AtzLBRGwe7N0GyXkmV0yKZJHbdWFygtVSmi2ILCPtreb5jS4jNHESiIRzdjB
         tyr+FuK32h+1hkD6WKddufy6dPCv6vdJAur3QQOZF9MR+ox1RKajfLeNDo2FM32m4fqH
         6Jnn9kKx5qvgV5ms11IVUi4TNTlpmyTG1nRKuUF147qwPuwyIgiX9GeV/fp9E819OAw2
         tfdSV79sGlOQnRf20+mDwzx7dxpp3Yt0UKBbuLl2O8DvVKWNuhNRigtWDg3826xESGBP
         cdbg==
X-Forwarded-Encrypted: i=1; AJvYcCXHvVACedptqaXNk0pNmJIvSxph/pu+FZDh84Vt0myxPWuaQK+u+KXoAIA43HhBzTQae1Vi0OUHEZj7Q7NH94N2Vss8dca43tKvZx4z
X-Gm-Message-State: AOJu0Yzrl1bNxlLdyKmv6KjPPtbmKg/Soc9xrSeUYj4gk20wOw7KUJxd
	DCcnGetuKTBtQW5F7U00Enfc218n24Hw4Bb/MIDGsMIMTu66bsZLizhGDOd5
X-Google-Smtp-Source: AGHT+IH7ojZDc4xwnrJQJEaFjn9FaaNirIYhDEzvo5jFvHZPWPC8vFjWjU0PYzB38KBk8ouq2vc9xw==
X-Received: by 2002:a6b:5a19:0:b0:805:b510:92a2 with SMTP id ca18e2360f4ac-805b51093e0mr639585639f.19.1720763696012;
        Thu, 11 Jul 2024 22:54:56 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c2c744sm2233325173.171.2024.07.11.22.54.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 22:54:55 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-376069031c7so6728685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:54:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1c4GjZ2/dOjvQlDYQJ9pSQOqiebmD1PZERudlmP56TSrfbQAZ+pe1nrf2qPSoqMOV6j7HvZyIxG27OCS5HTzdMQQh+hGouNFyN7ti
X-Received: by 2002:a05:6e02:1585:b0:374:9a3f:d197 with SMTP id
 e9e14a558f8ab-38a57fb18a1mr112887215ab.15.1720763695416; Thu, 11 Jul 2024
 22:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712032140.4012667-1-lsahn@wewakecorp.com> <2024071214-onshore-moonbeam-4eeb@gregkh>
In-Reply-To: <2024071214-onshore-moonbeam-4eeb@gregkh>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Fri, 12 Jul 2024 14:54:55 +0900
X-Gmail-Original-Message-ID: <CANTT7qj+FNiVsvK=d3cgKHJXo8kjriVh3PcGnk4t+Fgb12==sg@mail.gmail.com>
Message-ID: <CANTT7qj+FNiVsvK=d3cgKHJXo8kjriVh3PcGnk4t+Fgb12==sg@mail.gmail.com>
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 7=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 2:40, G=
reg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> > It better prints out an error message to give more information if
> > calling debugfs_create_file() is failure and the return value has an
> > error code.
> >
> > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > ---
> >  drivers/android/binder.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index b21a7b246a0d..eb0fd1443d69 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -5673,6 +5673,7 @@ static int binder_open(struct inode *nodp, struct=
 file *filp)
> >
> >       if (binder_debugfs_dir_entry_proc && !existing_pid) {
> >               char strbuf[11];
> > +             struct dentry *debugfs_entry;
> >
> >               snprintf(strbuf, sizeof(strbuf), "%u", proc->pid);
> >               /*
> > @@ -5681,10 +5682,19 @@ static int binder_open(struct inode *nodp, stru=
ct file *filp)
> >                * The printing code will anyway print all contexts for a=
 given
> >                * PID so this is not a problem.
> >                */
> > -             proc->debugfs_entry =3D debugfs_create_file(strbuf, 0444,
> > +             debugfs_entry =3D debugfs_create_file(strbuf, 0444,
> >                       binder_debugfs_dir_entry_proc,
> >                       (void *)(unsigned long)proc->pid,
> >                       &proc_fops);
> > +             if (!IS_ERR(debugfs_entry)) {
> > +                     proc->debugfs_entry =3D debugfs_entry;
> > +             } else {
> > +                     int error;
> > +
> > +                     error =3D PTR_ERR(debugfs_entry);
> > +                     pr_warn("Unable to create file %s in debugfs (err=
or %d)\n",
> > +                             strbuf, error);
>
> Even if we wanted to warn about this (hint, you don't, see previous
> response), this way to check is incorrect and will fail if debugfs is
> not enabled, which you don't want to have happen.
>
> So I'm guessing you did not test this with that config option disabled?

Oh, I haven't thought about this and just figured out it would work weird.
Thank you for mentioning it.

>
> thanks,
>
> greg k-h

