Return-Path: <linux-kernel+bounces-238518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D3924B78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59AA1F2179B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9817A58F;
	Tue,  2 Jul 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gJstGB+R"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FC1474CC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958517; cv=none; b=lBLGU5KeqtxDutiKe0Fgog6dSMhl2wTWWStL/bnTTWNgS75SpWN+f12tXv2C05kIUfq+ppocvvhr+N/Jd3ajv9WsZq/0bPYEG+qM1cnzwGaACdVl0pxYdXffXB/2j1B0NaY6RkW3Wn8/mF58YgMoce69J/BoDWuyR9b2FzzJS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958517; c=relaxed/simple;
	bh=ZjF9gVm+hnPGJTQrV1NhQloS/3+JlMk1M9zOF/E95/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SM1Qx+HN3e7G2dqanD9Nz8T8KZVuQMmoGcLYcGCFcFVM8RH5S9XE4F7AKuwdY7GLMJ/ZTYckhwzpq2p0gaINgSFhD+c3hbdgnfwEyWluSt7c3VaZLRZsoaw0v+qS/0xvANla/HEQYDdjKsq2lyhgENBrD9S1eydqiRFK/a0d3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gJstGB+R; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso46125081fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719958513; x=1720563313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yV7nDkLq2boIMByXflMHOo0LFkkVyBsyXcyeGHYPWNQ=;
        b=gJstGB+Rk+Utb6sualpKoPUQYwB7G0Do3Zf9ywJ1aAzvV5iUvXyxVjYw9JKf9YjTKW
         dKemA1znRZcbH6YTzKJIUN3PgPjPS0nwmrNtu1KPEz4+mHnq+5oSaTOsFH2BgkM4QEiz
         H+/9u+RWPcbrYcXfuI79G3d8PWtFZTmGo+O+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719958513; x=1720563313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yV7nDkLq2boIMByXflMHOo0LFkkVyBsyXcyeGHYPWNQ=;
        b=UCqcVZL1uJg5RFt1hddPnSumHau7z9z4zCRe9WvEiAO+Wgynd45CkDVh7+SzbpZ1LC
         faFIl0pXwhjX3/dsbNe6T6iHfaOpdJjPPuSDDYDYKhvmLrLcY2qYqVP/Ja6SOnaMacsy
         eQfdL9qO+8vypjbtSOI6MJ2IbcOKiCf/ZV+1qSaeU59Gf/0eYs8Z348ZenkzeWwv99yi
         s1gq7OMBZv944EamwgJpp2FhSPC4aNuu0E5tfldW5YnwYaILvlAos2aUPA0g476eSDT1
         Rva4t1vwA+7R83h8m0tRGCzfj5FbxGAqQ82qiyabPV+YOOc1j9Mfho/YacXt2YEjDaqH
         nISQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq/+b6I4r2aSZodiR4vmxX8u3YyeR6/Ld4ShotOhODhlKLPZZG6MsTayg3N0UM+H8KJfw2+CTq1jDOkoFNZLwXs4rK6JnHiX+pZZ1y
X-Gm-Message-State: AOJu0YyRlBI4IW1Qt0pl66/Y9fiX8PNHZlTqOsxxc1l1aIUBhDleWI+n
	6oXS+P9W0pGtdxTxgAA+iBgbn5P59+xnvkNO+ULav1iSF7CqU57bVhIMF/7HjY8aLig3tbS3Fc3
	87xlpOw==
X-Google-Smtp-Source: AGHT+IHWwTTKv0xF8p6zPfWglviyyqqhM//QMkzP5DZ9wP+eM7jCLS6FMfd5OUVXwOW3hwBjJ7JRdw==
X-Received: by 2002:a2e:b535:0:b0:2ec:4eca:748b with SMTP id 38308e7fff4ca-2ee5e39260amr57412991fa.14.1719958513084;
        Tue, 02 Jul 2024 15:15:13 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835dfsm6177987a12.20.2024.07.02.15.15.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:15:12 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so479214766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 15:15:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVipxYqdt8noEjNtv1USZDjkEI8dxQFAWi31VAquqgQbD4bjrfRWj/mZ7tpYLSDTwYuPI0ikTAsXSeiVYSpnLqRmEBia+QgIlsmQyrs
X-Received: by 2002:a17:906:6d8:b0:a6f:309d:ec23 with SMTP id
 a640c23a62f3a-a75144b9d16mr658615466b.72.1719958511691; Tue, 02 Jul 2024
 15:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
 <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
 <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
 <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
 <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com> <6knlkefvujkry65gx6636u6e7rivqrn5kqjovs4ctjg7xtzrmo@2zd4wjx6zcym>
In-Reply-To: <6knlkefvujkry65gx6636u6e7rivqrn5kqjovs4ctjg7xtzrmo@2zd4wjx6zcym>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jul 2024 15:14:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whagTfq=EgwpuywUUu0ti7PPQuE_ftVjZOVrjnLwtS0Ng@mail.gmail.com>
Message-ID: <CAHk-=whagTfq=EgwpuywUUu0ti7PPQuE_ftVjZOVrjnLwtS0Ng@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 14:15, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I asked you something in the previous e-mail though (with some nastiness
> of the problem pointed out) concerning handling of slow vs fastpath,
> here it is again:
>
> [..]for example did you know xfs does not honor rcu grace periods when
> recycling inodes?

I don't think it should matter.

Yes, the vfs layer will access the inode, but then the sequence number
checks should always verify that whatever access we did is then
validated after-the-fact.

And yes, any "stat under RCU" will obviously have to do the sequence
number check after having copied the data, the same way we now do it
after the "lockref_get_not_dead()".

So the RCU part just means that at least the allocation still exists.
But it might not have been the *right* inode, and that's the sequence
number check.

Or do you see something I'm missing? I'm not loving how we deal with
dentry->d_inode, but considering that the whole point of the RCU
lookup is that we don't hold any locks, I think it's almost
unavoidable.

> Sounds like you are deadset on the callback approach.

Hey, I happen to think that it's the easiest model, but you can easily
prove me wrong.

Almost all of my worries can probably be handled by just having a
separate "do this after the operation" helper function.

Also, maybe the "callback" model is the wrong one, and instead the
right one is to just say "the only thing that wants this is the 'stat'
family", and simply have a "path_statx()" function that is all inside
fs/namei.c, and that doesn't take any callbacks, but instead just
fills in the 'struct kstat'.

But if you have better ideas, go wild.

The only thing I really *don't* want is some kind of expansion on the
new "filename_lookup()" function that takes a new flag, and that then
random people can start using, and that is so fragile that everybody
will get it wrong.

Your 'vfs_rcu_magic_lookup()' looks like it would work, and we'd just
have to make the rule that it's never exported to modules or anything
like that, simply because I don't trust random drivers or vendor
modules to get it right.

> Can you pseudo-code how would the consumer look like in your case? Do
> you want the callback to execute for both slow and fastpath and switch
> on the flag? It is rather unclear what you are proposing here.

So what my half-aresed thinking was on how I'd do it is roughly:

 - add a new "rcu_callback" function pointer to ' struct nameidata'
(or, if deciding to just fill in 'struct kstat', just the pointer to
that).

 - in complete_walk(), where we currently do that

        if (!try_to_unlazy(nd))
                return -ECHILD;

   instead do something like this:

        if (nd->rcu_callback) {
                int ret = nd->rcu_callback(nd);
                if (ret) {
                        if (!validate_sequence_counts(nd))
                                ret = -ECHILD;
                        nd->path.mnt = NULL;
                        nd->path.dentry = NULL;
                        leave_rcu(nd);
                        return ret;
                }
        }
        if (!try_to_unlazy(nd))
                return -ECHILD;

 - add a new version of filename_lookup() that takes that enw
callback, and just sets in in nameidata before it does that

        retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);

    thing.

IOW, the point is that the callback can decide that it has gathered
enough information, and to basically "abort" the RCU path walk by
returning an error.

And if it does *not* return an error to abort (or if we never even get
there, because something else caused us to exit RCU mode), we act
exactly like we used to, and nothing has changed.

But if it *does* return an error, we stop walking, never take the refs
on the path, and we validate the sequence count.

Again, if the sequence count validation failed, we turn the error into
ECHILD, so that the path walking just gets re-done without RCU. So a
sequence point failure means that we did end up calling the callback
function, but we basically discard the result.

End result: the path walking will return that new error only if the
callback (a) existed, (b) returned that error and (c) the sequence
counts still validated properly afterwards.

And if for some reason it *cannot* fill in stat data (say, because the
filesystem is one that doesn't support "stat under RCU" or whatever),
the callback returns zero, and we do all the things we used to do.

And the *user* of this would basically just put in a "stat_rcu()"
callback that fills in the stat data and returns some error code that
path walking can't return, which then informs the caller that the stat
data has already been filled in and can be used as-is.

So now the caller can look something like this:

        ret = filename_lookup_with_callback(... callback);
        if (ret == -ECALLBACK) {
                // this means that the stat info has already been
filled in, copy it to user mode
                copy_stat_to_user(..);
                return 0;
        }
        // "Real" error
        if (ret)
                 return ret;
        // Ok, we have a path, we do what we used to do before
        error = vfs_getattr(&path, stat, request_mask, flags);
        ...
        path_put(&path);

Anyway, that was my thinking. It *feels* fairly minimal. But no, I
never did the patch, and I might not have thought of some
complication, and it is all pretty messy, and no, I do not want to
force you into this kind of model if you hate it.

I don't think your vfs_rcu_magic_lookup() function is all that
fundamentally different, but the advantage of the callback model is
that I *think* the above would be a fairly surgical and minimal
addition to the path walk.

I _think_ your vfs_rcu_magic_lookup() model would require a fair
amount of moving code around to break into that

  path_lookupat -> complete_walk -> try_to_unlazy

place and be able to restart etc. But maybe you have a clever plan.

               Linus

