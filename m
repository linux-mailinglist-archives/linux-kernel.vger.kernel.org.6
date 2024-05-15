Return-Path: <linux-kernel+bounces-179762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1738C64F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02F71C23198
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBF65EE97;
	Wed, 15 May 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="PrYT6QxD"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09394207A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769084; cv=none; b=eUkt9p3lf3n/nG/pJga+pfle5/86ialpuaEQzPQVkp16Mjl/dnKZ4V4jLEWc4Wt8+W3CK7Va7T88mDeL5zDamP7/nMJQmI6ayxv3qacVHIfKJ9MivWKHPayx5ggVT31lzqfCn63G60s2M95y8d1AY3/sVBMzP242o9mFHQoaaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769084; c=relaxed/simple;
	bh=ZFdFfOpGktquqXyWz6tLLfSfinPgS2/HBD5fwMfexpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVhfmkG4+NmUcaAC1zJsfNaFsxvNepgpxf1+PSyBKHuvT9JcpPBszqnszDaI1zNiy9KgWn2fFAwTPkHXljI3GjvW44EZQPuoNphzISOCz3PwegyrTMBPXlzbNpl5lz1tjVXxJOSAFl7rEh2WHIfR3ACXTwq4+g/TogzLwsze8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=PrYT6QxD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420160f8f52so20988735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715769081; x=1716373881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG5zBn5o6j3jWJFkBRDbSpLzfISGJr4t+twnkK5Jmvo=;
        b=PrYT6QxDeJFMOwrOXbfz850MqMTQFlMFpDCYyMtNBDP1Q3Nn+wKWJUPclfNSLApAqr
         BfR9w6Dh8A4F+vK2BlYk3CU3ohcJeReYnmzegTRCufeWRDKgaM3XSPJ2syZhSAkezfb3
         P5CoS1H3yq3zOD6Rp/wkWUHnaaVt/lskOq8xa+ongFFK0Ki6WQGpDJv5/vHL48ogId/f
         SmGrT/alXYOEwEeDoPwKjNvoVtBGHSbfdZgSfZvPbmj7cRA4q4abwoiVMWDxabQWg14+
         GtoVqsEv0dBA8x0OH6Gj0joZrtqvr/xG+CDwpcBAaRPtEmRVxnlwvJS9cxvEOKkvncc0
         XwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715769081; x=1716373881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG5zBn5o6j3jWJFkBRDbSpLzfISGJr4t+twnkK5Jmvo=;
        b=C8E/12fLJRdPWfUjhE3tSHa3r4vbdRy40UeQP5LcdwvzjOWNuglScUS/7reowJVHpe
         iaBLM/cX5rgq7QBbZmtoseKwAUF41TuTYLYffEj7m/xh2y8wYT2AWaiyLGpI5kIDPX3x
         YtvSdjIE0WluPuNUQpk8FgCVZU4xxf1/2YYRUpvn+ei3kkGhJrsKrptp824l0N7UZ0b0
         XTnRS6GcBsk2pKX6hc2GqdiRPGErnWd2yKMN4MY6xUWLhfvMpY61LQW+hqB8MthXvuFJ
         deh80dYqwghC1se08MZyt5zYOxfx5JT82PoWSniq2uCrGvIx7lUvG6nraAICvMUwtL3G
         B6cw==
X-Forwarded-Encrypted: i=1; AJvYcCWJOqM3rtAG273IfviMnwx4DeGyJOrbrWPG047nTbseiH1SA5RNr32IhXS05ZPNPBdJb44uGpt1JpDvmdRTCNwPV45ydFDpFX5EXXy2
X-Gm-Message-State: AOJu0Yx5JYdTCQ8a4ImjeAxpgNhZf0JYl1baRigVN0k8fEadOFxyTgRp
	87lMwJlJjjYUtCnF9lkZ6TmAEoCOhzGmYLeFmHszF0ODXXwBL9Si88lw/jvNMhU=
X-Google-Smtp-Source: AGHT+IHbRa4f6a0OPIXc+X3mZ/XaiasEuZZegiJVELTp+PTvnfGjOfFYQYTXxfiYT/De51423cv9fw==
X-Received: by 2002:a05:600c:310d:b0:416:605b:5868 with SMTP id 5b1f17b1804b1-41fead696bbmr107457525e9.35.1715769081002;
        Wed, 15 May 2024 03:31:21 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f74sm229578795e9.8.2024.05.15.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:31:20 -0700 (PDT)
Date: Wed, 15 May 2024 11:31:18 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20240515103118.qc76v55x4ylqhd52@airbuntu>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
 <20240515083238.GA40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515083238.GA40213@noisy.programming.kicks-ass.net>

On 05/15/24 10:32, Peter Zijlstra wrote:
> On Tue, May 14, 2024 at 07:58:51PM -0400, Phil Auld wrote:
> > 
> > Hi Qais,
> > 
> > On Wed, May 15, 2024 at 12:41:12AM +0100 Qais Yousef wrote:
> > > rt_task() checks if a task has RT priority. But depends on your
> > > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > > task, which includes RT and DL classes.
> > > 
> > > Since this has caused some confusion already on discussion [1], it
> > > seemed a clean up is due.
> > > 
> > > I define the usage of rt_task() to be tasks that belong to RT class.
> > > Make sure that it returns true only for RT class and audit the users and
> > > replace them with the new realtime_task() which returns true for RT and
> > > DL classes - the old behavior. Introduce similar realtime_prio() to
> > > create similar distinction to rt_prio() and update the users.
> > 
> > I think making the difference clear is good. However, I think rt_task() is
> > a better name. We have dl_task() still.  And rt tasks are things managed
> > by rt.c, basically. Not realtime.c :)  I know that doesn't work for deadline.c
> > and dl_ but this change would be the reverse of that pattern.
> 
> It's going to be a mess either way around, but I think rt_task() and
> dl_task() being distinct is more sensible than the current overlap.

Judging by some of the users I've seen, I think there were some users not
expecting they're not distinct as they were checking for !dl_task() &&
!rt_task() which I replaced with !realtime_task(). Similar users checking for
dl_prio() and rt_prio() in places, and others using rt_prio() to encompass
dl_prio(). There were BUG_ON(!rt_task())/WARN_ON(!rt_prio()) in rt.c which
I don't think it in intended to encompass dl there.

> 
> > > Move MAX_DL_PRIO to prio.h so it can be used in the new definitions.
> > > 
> > > Document the functions to make it more obvious what is the difference
> > > between them. PI-boosted tasks is a factor that must be taken into
> > > account when choosing which function to use.
> > > 
> > > Rename task_is_realtime() to task_has_realtime_policy() as the old name
> > > is confusing against the new realtime_task().
> 
> realtime_task_policy() perhaps?

Better yes. Updated.

Thanks!

