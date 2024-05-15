Return-Path: <linux-kernel+bounces-180192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0698C6B52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F395B22BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0D433BC;
	Wed, 15 May 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="os8QrypA"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735438DE9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793150; cv=none; b=JCH73hl1sZ2kXemwD4fv3XoNI2D2dQWAXND4YaoiT8wDd3WMxlnlUDtKmE6bFN/fVcq5HLR9gtdZpzIGS9cj0x7oXqYvEpAzDt3dQrdHACh6M2E3XGJzBzw0Y/MDoUHpdrYjnXMcQyqwTfaWBYpP8j+QG7CrQqUwiyOc2N+L71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793150; c=relaxed/simple;
	bh=PFgxIB1YPLSdg2W7I438r4ndLIqIln1z0HvRj4J4qqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl8a4+julYYUsddqelCHU8Et5ztTIQX3tW8r6leR4WowHUZHX//eDitbqEm60PMoDD7hoh7srq3h69qZ/NQY8IwuTskZrBkh8Xsm5Oce3jcXtd7OBCJ3ZRBdZQhbtQLfv/8G+YnAw4Ifw7oywgFg+IMNFC64p1huE7ExsML1J3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=os8QrypA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so4642410f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715793147; x=1716397947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNosG3ckDHB8NLVJ2gGvIoo4Er1X+7+xgehDnbjd6jc=;
        b=os8QrypAOGFUEvSmqTbU6IVOP6d5jIztE10CDXdEhhdN4o3ePI0BGrfiP11iJd8CIJ
         30rpzHtxM8JoRm1AUY1gAey/bAp5dl5Cxle+qQx/KcCFx+SIaqh7meqBoLYgJk0r6M9+
         +AgcOqPp7bQCQeZsSX9ng8QJSL/QAI0PZFEmN6ShU/R2OX/lT0cHvLv3vW1Azaym41UE
         H+tsXezBuQLFNeCnUimjV9r2vM0cK+wiDwxo8Iu1YFnClBixIyMLbLMCiQV9qcnMHimT
         HocFr+9vZ2fXetYL1gYpgCgTxwAyS+pNmKPWjiSj0x1ehpjWVvk6E17rd2SGOcRXb4Bp
         +FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793147; x=1716397947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNosG3ckDHB8NLVJ2gGvIoo4Er1X+7+xgehDnbjd6jc=;
        b=ajRaj8qe3s2mDKANvVzOAsKWOIBJ3tht1zUEydlJF4afHawR0tTyVbDE37zpdVAmMs
         gvtkzeS4I7F79HOKK9gsGwkhMV6OA24+W/1fSzo/qxnOCI8MMRTzzc3GinseFmsxwMSE
         ZR/BmbJy0fXnGCth5KXpOe/1jVXTedA8CJlP+Zgyui/o4XSrENMBnZ8QIbthWInZ+OLG
         0ODo4hSQ0cnIAajC4g8E3bmW6MaMN3ccCzsoHYwqfu+LCbSs4ORJs0TfdPkteuHj7s9C
         2ivYlD/huAbWSxkvDmeAYfH7PhWETjVgCfB6IA4ppo4Fnhs/Oim9AmkQS8SmFVAjc91d
         yRRw==
X-Forwarded-Encrypted: i=1; AJvYcCUTXD66aRA4St7Gfk/B1IAUTiE44oMBvRM3A4UHRvNdTkyGaPBm0BQzjnJRnzX+7yZTEcxiww9f7R+M/s56CeJQsGqZzFdJtb0dAeFl
X-Gm-Message-State: AOJu0YzDpArB7IP3PQLJc+v4Bl2vKJgZiNUCcDajONghPxx8cJyinb4c
	b+TrOnZVGNgc/hXUKm/PiaO//H88IM4W+5g7+QoD01rKLl/teihSL0lbBj7vvmY=
X-Google-Smtp-Source: AGHT+IFLKOGooEzh5kgxSU0G+WqjP7c8Us/ACZAVQOeBbdHE4Nu/p8dE0Q5EYbLnc34bRxIqp6xGpA==
X-Received: by 2002:a05:6000:930:b0:351:d383:6325 with SMTP id ffacd0b85a97d-351d38363cfmr598051f8f.12.1715793147224;
        Wed, 15 May 2024 10:12:27 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a780fsm16840240f8f.59.2024.05.15.10.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:12:26 -0700 (PDT)
Date: Wed, 15 May 2024 18:12:24 +0100
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
Message-ID: <20240515171224.wbjlke6uavhig2dl@airbuntu>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
 <20240515083238.GA40213@noisy.programming.kicks-ass.net>
 <20240515112050.GA25724@lorien.usersys.redhat.com>
 <20240515120613.m6ajyxyyxhat7eb5@airbuntu>
 <20240515125049.GA29065@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515125049.GA29065@lorien.usersys.redhat.com>

On 05/15/24 08:50, Phil Auld wrote:

> > > My point was just to call it rt_task() still. 
> > 
> > It is called rt_task() still. I just added a new realtime_task() to return true
> > for RT and DL. rt_task() will return true only for RT now.
> > 
> > How do you see this should be done instead? I'm not seeing the problem.
> >
> 
> Right, sorry. I misread your commit message completely and then all the
> places where you changed rt_task() to realtime_task() fit my misreading.
> 
> rt_task() means rt class and realtime_task does what rt_task() used to do.
> That's how I would do it, too :)

Ah, I see. I updated the commit message to hopefully read better :)

"""
    I define the usage of rt_task() to be tasks that belong to RT class.
    Make sure that it returns true only for RT class and audit the users and
    replace the ones required the old behavior with the new realtime_task()
    which returns true for RT and DL classes. Introduce similar
    realtime_prio() to create similar distinction to rt_prio() and update
    the users that required the old behavior to use the new function.
"""

> Reviewed-by: Phil Auld <pauld@redhat.com>

Thanks for having a look!

Cheers

--
Qais Yousef

