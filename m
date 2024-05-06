Return-Path: <linux-kernel+bounces-169798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B98BCDC4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65F21C235D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85B143C62;
	Mon,  6 May 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="J4Sdfzf+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38199143C42
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998234; cv=none; b=UY/K0fKgn90HKkSiTp71YqLvAo4VhcZdAcotZjE5x/GaLkEjuK/fTnyd1/c31PAPkNxiD1Zo2UpaPgSD3NlSj3LeryGEu5vHpBlG+BGXcD0JEo+t1ebyPgksLym/np9+go2H0s2cj92rOd87t+IqMAwr9W5rtVARqIURxHyYDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998234; c=relaxed/simple;
	bh=lCeN5/qj6q6vJSmEiKVBWOtCMx5sNu2IArRIsx3u2Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX8nyCuvVOfJvzExV0jdJ7g6L77fUAez5YG2GhTiD/IuWtpEVKe++8cHnITxEDrBNZc+OsudgI5inTuyGs1nH9K1VSmsrwS/aanz4luU8D894PgJdTQ9jFyQpNlfosB4pgH5nwkelKQ3rRxnbS6s52VM6YpP3G6JJFarAiSr3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=J4Sdfzf+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34ca50999cdso99004f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714998231; x=1715603031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJvxbNUxeULloPkLJE9SsjERpdsUIXxRxn2yKsRsSwc=;
        b=J4Sdfzf+sNHeQZbjLlHQkxe+vBV/CqtEKZIE21zHs5BZaP4fVUooE839QXHepk/ae4
         POXW3MdM2YM0mL7+kPF0sFDjddZ6ZqJgjPLk5O1FAQ9LQ6NuGoI/6ghK9qafc9p5r5/q
         eIF9aflCGGZxuDwFxBa6ppO8Igf343ne8trek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998231; x=1715603031;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJvxbNUxeULloPkLJE9SsjERpdsUIXxRxn2yKsRsSwc=;
        b=LIAYnhtVXZvqGc3UlkXvPXd4C8uGNqDYTmpfn+wfML6ovkRxrR5GtQHk+jkABwv9bo
         rbHsSpF4mg8LcqmrctNoUDvZTSSNm/rdMGcrQeDy8/QnC6NdKKtFMjsn42PrE3j3GyDE
         EJm+fzy/y2EJ8id9vTVcKVh1uNhwMHfJ97Jnk97QWp6QEWZTiR3wUHwZyyy1sW8JdOBL
         7qSHOkCUdsfveHPkZgOhqrDR19ER/2/k7cFNA5Ej8eARTlBS7/WDgu5qSDwEfgafNcuB
         zmgH/ZBURXPM6h+dKLh9XzwqVnDqL8oULrIGE70ciVwT8145ReZoGxouLZU8Tnb16ACu
         aEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNJkzyBuiKAwVZ7sdX4cTJsI9wJn2LtVAh7Ig5F3Ydz03CTjG28TDmAS5YhWiuPRsXltwByxeZIhqnNcV77hnfqu7sTdhvMhmSDqf4
X-Gm-Message-State: AOJu0Ywx4/djNvy/3Z4LuEkuPDH0KrSdR4z4GUuSF/a0Wl1PfBrv9632
	AzyDSQSDtPFIBjQatJsC2bKQIe9XXTyBHPcCfjYqTBDo922UFE1q7OYrE0uh9eA=
X-Google-Smtp-Source: AGHT+IGuUvBtI5rIVLpD2XOZICwCS9IQtrXwLWSsF2oFAMcsXQKy2Upppe1zQ4rIa9wWPmT5P5GIew==
X-Received: by 2002:a05:600c:3b02:b0:41a:c4fe:b0a5 with SMTP id m2-20020a05600c3b0200b0041ac4feb0a5mr6970105wms.4.1714998231468;
        Mon, 06 May 2024 05:23:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b0041668162b45sm19554882wmq.26.2024.05.06.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 05:23:50 -0700 (PDT)
Date: Mon, 6 May 2024 14:23:48 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>,
	io-uring@vger.kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?]
 [io-uring?] general protection fault in __ep_remove)
Message-ID: <ZjjL1GjSMMMcxdsc@phenom.ffwll.local>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>,
	io-uring@vger.kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
References: <202405031110.6F47982593@keescook>
 <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook>
 <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
 <202405031237.B6B8379@keescook>
 <202405031325.B8979870B@keescook>
 <20240503211109.GX2118490@ZenIV>
 <20240503213625.GA2118490@ZenIV>
 <CAHk-=wgRphONC5NBagypZpgriCUtztU7LCC9BzGZDEjWQbSVWQ@mail.gmail.com>
 <20240503215303.GC2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503215303.GC2118490@ZenIV>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Fri, May 03, 2024 at 10:53:03PM +0100, Al Viro wrote:
> On Fri, May 03, 2024 at 02:42:22PM -0700, Linus Torvalds wrote:
> > On Fri, 3 May 2024 at 14:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > ... the last part is no-go - poll_wait() must be able to grab a reference
> > > (well, the callback in it must)
> > 
> > Yeah. I really think that *poll* itself is doing everything right. It
> > knows that it's called with a file pointer with a reference, and it
> > adds its own references as needed.
> 
> Not really.  Note that select's __pollwait() does *NOT* leave a reference
> at the mercy of driver - it's stuck into poll_table_entry->filp and
> the poll_freewait() knows how to take those out.
> 
> 
> dmabuf does something very different - it grabs the damn thing into
> its private data structures and for all we know it could keep it for
> a few hours, until some even materializes.

dma_fence must complete in reasonable amount of time, where "reasonable"
is roughly in line with other i/o (including the option that there's
timeouts if the hw's gone busted).

So definitely not hours (aside from driver bugs when things go really
wrong ofc), but more like a few seconds in a worst case scenario.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

