Return-Path: <linux-kernel+bounces-179827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2C8C6618
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E03B283646
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69D77442F;
	Wed, 15 May 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="u6H+7BQb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540F2CCD0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774778; cv=none; b=RNwpc5QegBZR7Y3k410+hzDTyP4mXvH1AF93765ZFGMxkFW9/7UdD5gOUrJNRSZmY4PmWafFSTSJvn4sxqHJMLQcWjfTLTARz2NHO9p2kQeo6BgDIfKw9GMOWk4HluK/JgNpGEPUd5RjGr69d8Yxid7eaUR+3b5iRewvAs33pvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774778; c=relaxed/simple;
	bh=Wf4PtMcK4TWbBm/o2EnpN3Y26qLxkxka0G6bwrOg3aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKH0e/q7YZ6Nsg9WBprWzP51xOGDdeDbFReD4hdKqUt/UjaKGSXxXZcdebg0syq6XXMRWhe0ieYSIBZWHbZuPdXvxLatlaaY6yPkq2XfSQlw6ykMgMQ12sbSdRPpDHHJZLIyGBzo0E0PgesQ7lSsMPVzZ4WC79CKvKieFqFX8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=u6H+7BQb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41fd5dc0508so45556045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715774775; x=1716379575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJYF6H91YS9YSoXm+Tl9JERoBMf7eBC9ZSy+O3IfVoo=;
        b=u6H+7BQb9llJ+GoUyqhx9nL12eq1QZTpEYwVKf4L6Kk8pxybMMa6wGPamt1Bg1ep4d
         C/lsdKjdJeZdXwMLWp5fxgO6nHcC9zVgGTXn9zymZ6xqiiOGQW4rrxGI9jgMEd1nbgYA
         3zZ5OzYV1RLUm4QAEl4pAqnDflIDLagY3fotksWvN5G5S8JQRnwavg71k78sQdNQSyGG
         eNyDwXYPYfDTTtrAth6G5gdKHPHtbfOX2QJbdr59n1S9no5Kz15fhFmCr3jnxK5+YEqu
         ve6MqQrYhJPoB6C1CRuR5F1dkin6pAE07+u2g+nP8Yhoa3ZGe855d6flwjmZT/e1NoCt
         ZGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715774775; x=1716379575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJYF6H91YS9YSoXm+Tl9JERoBMf7eBC9ZSy+O3IfVoo=;
        b=sIutzkaz718BQv40C6I8N9fQN1xfkvGpJwbW6lqltLr5ESel5MKP01pW1tIbHgR4az
         Zd9iKLxQUpi+PGiMyV5xbWuWLY+mW/nsTiCa0H8n6C7w55qPkUsyIZSXY1tBGgo6Wm/p
         uONnIiu0+TMPRKtV1szLUDmToP03JXBfHCzifVDB8tCTZoqOTfcOxUJpobkFEmPBeWRP
         U6Ly1awKSPd/VsqSTqj61klu9faA/xQfj//hSHG0RzJrtjKjUTKBSgMvS9tTF9nbmyo5
         nhTX11mtJepnEffN/C8DEYtpx//VLib6EYqxY7SFdimopMNukDgpYbI1QHnNYCPeKEhW
         dGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVM6a2KYcal0fyuEiSkwLJ9tqmEo62vHt3/16UeAvWITVAjOS2BMjP3r1hZMWcWH26Ypytt07jCO28FfriPu5L95Mo+LGuSJ6dmgy6I
X-Gm-Message-State: AOJu0YyXt5p3DC08P0kCEg4g9pZhCnxQOhRU8SR11f4AUID9+fQuuIeF
	8T2GtDtF1ugisykjAnzw7cpm0Ib8d7s3Inxk6M7QihmBL+F8k0J8bj2+RK1hyqs=
X-Google-Smtp-Source: AGHT+IFLpgfv8/Esnolm22txMsxpEfskLJZ4i6egdOEr6U9kJff2jGBqFVP62Bj1ZgVi3f/r+yf4Tg==
X-Received: by 2002:a05:600c:2187:b0:419:ec38:f34b with SMTP id 5b1f17b1804b1-41feaa439d6mr115391895e9.20.1715774774868;
        Wed, 15 May 2024 05:06:14 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm266011555e9.25.2024.05.15.05.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:06:14 -0700 (PDT)
Date: Wed, 15 May 2024 13:06:13 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] sched/rt: Clean up usage of rt_task()
Message-ID: <20240515120613.m6ajyxyyxhat7eb5@airbuntu>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
 <20240515083238.GA40213@noisy.programming.kicks-ass.net>
 <20240515112050.GA25724@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515112050.GA25724@lorien.usersys.redhat.com>

On 05/15/24 07:20, Phil Auld wrote:
> On Wed, May 15, 2024 at 10:32:38AM +0200 Peter Zijlstra wrote:
> > On Tue, May 14, 2024 at 07:58:51PM -0400, Phil Auld wrote:
> > > 
> > > Hi Qais,
> > > 
> > > On Wed, May 15, 2024 at 12:41:12AM +0100 Qais Yousef wrote:
> > > > rt_task() checks if a task has RT priority. But depends on your
> > > > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > > > task, which includes RT and DL classes.
> > > > 
> > > > Since this has caused some confusion already on discussion [1], it
> > > > seemed a clean up is due.
> > > > 
> > > > I define the usage of rt_task() to be tasks that belong to RT class.
> > > > Make sure that it returns true only for RT class and audit the users and
> > > > replace them with the new realtime_task() which returns true for RT and
> > > > DL classes - the old behavior. Introduce similar realtime_prio() to
> > > > create similar distinction to rt_prio() and update the users.
> > > 
> > > I think making the difference clear is good. However, I think rt_task() is
> > > a better name. We have dl_task() still.  And rt tasks are things managed
> > > by rt.c, basically. Not realtime.c :)  I know that doesn't work for deadline.c
> > > and dl_ but this change would be the reverse of that pattern.
> > 
> > It's going to be a mess either way around, but I think rt_task() and
> > dl_task() being distinct is more sensible than the current overlap.
> >
> 
> Yes, indeed.
> 
> My point was just to call it rt_task() still. 

It is called rt_task() still. I just added a new realtime_task() to return true
for RT and DL. rt_task() will return true only for RT now.

How do you see this should be done instead? I'm not seeing the problem.

