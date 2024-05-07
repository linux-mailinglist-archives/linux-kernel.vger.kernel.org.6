Return-Path: <linux-kernel+bounces-171166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16778BE09D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4AD1F25FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D21514F1;
	Tue,  7 May 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CDnDjLE5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906B14EC77
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079781; cv=none; b=CRDhFXNxm1bGJQNpUEBrdSRHkvUXOuzsBtIEb9B7q4c5zAJ2B1qPcWgSNOEBr4ytlxQowPde/vvClh4m75bObzO92e3X1UkoiZCP0fALemG0nHmRyX2ZODZGh1FPmGpcE5tlloJvDH2yFh48+BjOGmzp7YuJXBP2Wp3LHVCkehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079781; c=relaxed/simple;
	bh=NYe5+/G+0dLsnUyympMhbfDF1UgMbpQ6AmHg9R3TjSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo5FIlD+/vgIAegkZtMwssKZXE1v6o+zeVMph4VktNcYoEtfyn7fb21Gj1YMO7Qt5Sh3TSVDuEZmWf47YXaGgTgDznxNqxc9U+PDSnRax0973RkPwEGdojLo4yMCqdsGyCD8A/urtzQsE9rmSHxp0EWR15rS6JrfPjZa5izbmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CDnDjLE5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d24c8fc5cso164238f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715079778; x=1715684578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGTjyA9KJ+ZN6kFiIcuqLZ6W/XXJNW0jRsNPu94ZivE=;
        b=CDnDjLE5wmxvCz6JRmrpo/FwsU5ZQAEaBFhky1gBjjH0C2XEgePwbGYYKjLNka91pD
         hrmCD4gtzwpWbSm5h+XoSSWnFLe62YR2KEWqg8eJM7IXx2gBY+T5YQ0rETGtI/kXDBML
         3CrMmEzPhqjwNHUfCmXyHqulbk+pCpeVelxnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715079778; x=1715684578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGTjyA9KJ+ZN6kFiIcuqLZ6W/XXJNW0jRsNPu94ZivE=;
        b=ArQJ5RtdVBwtL1hleik6Q+iGzY149mX6ElH+Wv7//JkUVqO4L2j8qO87x9qzopVcpX
         5CkT7dhRpDo9scdLKhK3otakxw8hhZEedXTPf2C06U8JwKxhGB7g5OP8p4leQjLj6/XR
         DFBh6tsxaZvHUmZV7q2oDrVpH+X+NqNpFL4o04q+KvFur6wSktNCtGRxj+gYvrvOMoYF
         gIMBhC+P2hXE5v3M6d0J3xRo8whMrZ0MwKVNS2VNrTA2XjBLw/hD62NrgAd0YLOYEj4C
         HRFuHscZRXC94O9PJftjP+scWRXRszq0s64NoxogRUr2Wr7m0k7lIV5Hd7XmdoYcmuX4
         lpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnQR82rS5sEPGaQ+UA/tqH1XUlSRY8ax9u4Z8EfQ/qGCTllrNxH7B0PPe040YHAvOWzhc2lWFtau+CapvIzYYxfDaTaLU4dTCwGlhJ
X-Gm-Message-State: AOJu0YxSi/G28KrprI1hmJtVl2gsW0zkefFAHQEjm8uOdFhzh2NYD+g6
	YXj68LeGgbq5skJgXUyU48tSqnYjEsqk70QV22KQQ6fZ0xs4RYbyv0tAteL0jiE=
X-Google-Smtp-Source: AGHT+IEX2EtqX8oJOpcirgNGAupSfQht9uZGGyEeDzOIFWWprFx1SmPXUeMAhFXKNaku4P+OQUC4Bg==
X-Received: by 2002:a5d:6409:0:b0:34d:b76c:cff7 with SMTP id z9-20020a5d6409000000b0034db76ccff7mr8695492wru.3.1715079778329;
        Tue, 07 May 2024 04:02:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b0034df7313bf1sm12829804wrx.0.2024.05.07.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 04:02:57 -0700 (PDT)
Date: Tue, 7 May 2024 13:02:55 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
	axboe@kernel.dk, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org,
	jack@suse.cz, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, minhquangbui99@gmail.com,
	sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better
 about file lifetimes
Message-ID: <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
	axboe@kernel.dk, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org,
	jack@suse.cz, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, minhquangbui99@gmail.com,
	sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
References: <202405031110.6F47982593@keescook>
 <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV>
 <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
 <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Mon, May 06, 2024 at 04:29:44PM +0200, Christian König wrote:
> Am 04.05.24 um 20:20 schrieb Linus Torvalds:
> > On Sat, 4 May 2024 at 08:32, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > Lookie here, the fundamental issue is that epoll can call '->poll()'
> > > on a file descriptor that is being closed concurrently.
> > Thinking some more about this, and replying to myself...
> > 
> > Actually, I wonder if we could *really* fix this by simply moving the
> > eventpoll_release() to where it really belongs.
> > 
> > If we did it in file_close_fd_locked(),  it would actually make a
> > *lot* more sense. Particularly since eventpoll actually uses this:
> > 
> >      struct epoll_filefd {
> >          struct file *file;
> >          int fd;
> >      } __packed;
> > 
> > ie it doesn't just use the 'struct file *', it uses the 'fd' itself
> > (for ep_find()).
> > 
> > (Strictly speaking, it should also have a pointer to the 'struct
> > files_struct' to make the 'int fd' be meaningful).
> 
> While I completely agree on this I unfortunately have to ruin the idea.
> 
> Before we had KCMP some people relied on the strange behavior of eventpoll
> to compare struct files when the fd is the same.
> 
> I just recently suggested that solution to somebody at AMD as a workaround
> when KCMP is disabled because of security hardening and I'm pretty sure I've
> seen it somewhere else as well.
> 
> So when we change that it would break (undocumented?) UAPI behavior.

Uh extremely aside, but doesn't this mean we should just enable kcmp on
files unconditionally, since there's an alternative? Or a least everywhere
CONFIG_EPOLL is enabled?

It's really annoying that on some distros/builds we don't have that, and
for gpu driver stack reasons we _really_ need to know whether a fd is the
same as another, due to some messy uniqueness requirements on buffer
objects various drivers have.
-Sima

> 
> Regards,
> Christian.
> 
> > 
> > IOW, eventpoll already considers the file _descriptor_ relevant, not
> > just the file pointer, and that's destroyed at *close* time, not at
> > 'fput()' time.
> > 
> > Yeah, yeah, the locking situation in file_close_fd_locked() is a bit
> > inconvenient, but if we can solve that, it would solve the problem in
> > a fundamentally different way: remove the ep iterm before the
> > file->f_count has actually been decremented, so the whole "race with
> > fput()" would just go away entirely.
> > 
> > I dunno. I think that would be the right thing to do, but I wouldn't
> > be surprised if some disgusting eventpoll user then might depend on
> > the current situation where the eventpoll thing stays around even
> > after the close() if you have another copy of the file open.
> > 
> >               Linus
> > _______________________________________________
> > Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> > To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

