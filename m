Return-Path: <linux-kernel+bounces-252248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C493108C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6302B1F224E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17163AC0F;
	Mon, 15 Jul 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RcF7yDKe"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68090184102
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033113; cv=none; b=Rgx43kJdgTQSKDeO3mTguve61CH0skKdhIf0pn7Z2JHIRwEON2aK/ba9EV5HcZskg3zPOMva9Us8wGyZ2rJbQmiMTUCOL9EF6l731K+giOAQHN/g+6g52afO3rwHqF6Q5b+B3GpeAPIqw/ucSY2D9feF60aoA8mjmoSBW9/SXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033113; c=relaxed/simple;
	bh=KbdlWQKJn0hza2m6K2BTUfffnTnvoHZmFO0gSi7vJwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiX+4z0/5i0bY46wOP/WbwKDzLES1dzoyCTKI4TGsIKIy1WN3NJY1mx/dY47rOp3atRvmS4+U239t1TthlSZ8WNP54iH0lSFnTNiUgXDAHmZB5QKbiPI/iIVo2NJeNMAuXRFGMsANLEzd4dBvUNmUe9p4uDk7Uf3kdF72rgXLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=RcF7yDKe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42666a5d33dso3207875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721033110; x=1721637910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPt43vWv7W7uWoCMBzaMsxBX+ZmRLoqnMa3kAMiQQGg=;
        b=RcF7yDKer3QecybgNFRAoXitisxR93dnEqr03XAm9ERhXF+nkF+Dehg4hTmVXPqwLc
         ZhLMjFyWfSlG1r+CSIhM+gZO6gcoyU31fsAg9lBWCUObW/E6IRxV7+JiMZjK7WGurxUg
         xVeT5JMD6d/bylHVnPeS1X/jcHkVlgk0f1HU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033110; x=1721637910;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPt43vWv7W7uWoCMBzaMsxBX+ZmRLoqnMa3kAMiQQGg=;
        b=A94zC0yd5dL3L5wDS4TTMvqAcw6V8sSKeeOnupHQnN8eF4vN4r762lPRvJUlnoyZqa
         iQiiiYHJHXM203F6RSjJfaKg08NpkNMdMbbv/BbM3Lr6RPNEQeN2cFWBUsDFtujcKH4d
         MTZ/4QRAUlYw5M1oZ/yZAYneT7x6prXnnvP2XTTweTfjLxJDGzYwI9L47eAZr7+2Qu/r
         zZhhgJQOWlixhwm/1O/U9TK8LiPc1MjLxzdNddVt6oQ7Xz6GXmPmg+hdTj5qV0z5g4hC
         +OFRFnLdQYwFLenXCI/rNH/8bZHOXj0aePmx57dHgMBquVxLbFuTP6TpD7MiievL00M2
         ar/g==
X-Forwarded-Encrypted: i=1; AJvYcCVT0+FNBt0mWwET52HzjQWHn/fEQhIEyR5uZNOnI/pyqL/RaafXOfZ4t/ViWhmJC9a62h6poX65dw8OQHb7q+O2tlOFR4O1xEbxJIoP
X-Gm-Message-State: AOJu0Yxp6raVKTx8eVoe0HNELBJH16F2MfzZ/Zz5/hEQvfbjIslq8J9e
	ZwykxLEglBg0nWF9IA917kjdL+0OUUzcheu+aNRshcuWS/XegE/xdkeBdQNKdXg=
X-Google-Smtp-Source: AGHT+IHkDheiQWPRAvAOHQTkNQHOAUKicTVB0J2JBhxVC1tcwLKXg6dTru289RnVzPDELy4A5wdRbw==
X-Received: by 2002:a05:6000:2a4:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-367f05439c1mr7021710f8f.0.1721033110619;
        Mon, 15 Jul 2024 01:45:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbd2sm5664721f8f.49.2024.07.15.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:45:10 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:45:08 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com,
	Daniel Vetter <daniel.vetter@intel.com>, stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] bcachefs: no console_lock in bch2_print_string_as_lines
Message-ID: <ZpThlAGUsPXZArvk@phenom.ffwll.local>
Mail-Followup-To: John Ogness <john.ogness@linutronix.de>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com,
	Daniel Vetter <daniel.vetter@intel.com>, stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240710093120.732208-2-daniel.vetter@ffwll.ch>
 <20240710130335.765885-1-daniel.vetter@ffwll.ch>
 <87jzhtcp26.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzhtcp26.fsf@jogness.linutronix.de>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 10, 2024 at 04:19:53PM +0206, John Ogness wrote:
> On 2024-07-10, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > console_lock is the outermost subsystem lock for a lot of subsystems,
> > which means get/put_user must nest within. Which means it cannot be
> > acquired somewhere deeply nested in other locks, and most definitely
> > not while holding fs locks potentially needed to resolve faults.
> >
> > console_trylock is the best we can do here. But John pointed out on a
> > previous version that this is futile:
> >
> > "Using the console lock here at all is wrong. The console lock does not
> > prevent other CPUs from calling printk() and inserting lines in between.
> >
> > "There is no way to guarantee a contiguous ringbuffer block using
> > multiple printk() calls.
> >
> > "The console_lock usage should be removed."
> >
> > https://lore.kernel.org/lkml/87frsh33xp.fsf@jogness.linutronix.de/
> >
> > Do that.
> 
> Note that there is more of this incorrect usage of console lock in:
> 
> fs/bcachefs/debug.c:bch2_btree_verify_replica()
> 
> fs/bcachefs/bset.c:bch2_dump_btree_node()
> 
> from commit 1c6fdbd8f246("bcachefs: Initial commit")
> 
> ... and its parent bcache:
> 
> drivers/md/bcache/debug.c:bch_btree_verify()
> 
> drivers/md/bcache/bset.c:bch_dump_bucket()
> 
> from commit cafe56359144("bcache: A block layer cache")
> 
> These should also be removed. Although Kent should verify that the
> console lock is not providing some sort of necessary side-effect
> synchronization.

I'll take a look, at least some of them seem doable to audit without deep
bcachefs understanding. Thanks for pointing them out, I should have looked
a bit more at git grep ...
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

