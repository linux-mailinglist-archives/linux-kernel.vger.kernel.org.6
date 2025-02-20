Return-Path: <linux-kernel+bounces-522941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BFA3D05E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A5188661F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED71DFD98;
	Thu, 20 Feb 2025 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgYKJAJT"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF21DEFFC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025197; cv=none; b=IxeFVsZbgRcCCxUv2+MRlV7Eqrb4dPNPOmSR5PfFuvKPkqucAoS99ncY9TgAsOGZ/2JdErO2MtrIF3jTh1wAPKkIvTCukaUFt65gzDoTDpOWVAooz3KxPpThHh2p4W9RIqjmvMvOWECwCjTiRSuOjuxPAq3gcZSmmiVta9T1SE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025197; c=relaxed/simple;
	bh=lPF33hTjr8gCKvWnHfEwO/a5Inh/srwa5zAEePCfwaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgExPfhmg4aKLYEyPi22sXeQK1DwI5GbRdEL4Gw+grr+7vbD43Xf2XHT85Q0itFF0DD1uQibA+b/IntcIQ/WQcnHb4LEPlkfXFC8074PpgHGHE9L/6NscljRxBn3BNL7j8rvQa3J5N6llRhLRA5LugrxKQJMFwOEIiuRFueeb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GgYKJAJT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc4418c0b9so774495a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740025195; x=1740629995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1guhW82eeWquTt2CEyxnqbnegZGM8zsatvuN9vRWU6U=;
        b=GgYKJAJTOX6ClvId8r36WccY+bB0Ke9m7PHDj2nMb8ieD2Ewl+zOqGd3bShqrTgHaA
         86SmW6ImEITGcMIT1CjzT+HSPz4trOxYgN3d8yVy6UCvE+FW9kLl2N/B9lwpqvr9C8NU
         eAbt1VmdJL6IOM8h3ky1h2HW5bRsqxlcYPczE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740025195; x=1740629995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1guhW82eeWquTt2CEyxnqbnegZGM8zsatvuN9vRWU6U=;
        b=ud+XgDHP61vvvz8ScW7lCf1RRWGbzRJj7VeApQ76NCoqWt/eNs4o5TvN4nLTXRUE4j
         tAHdU5lSEnqRuzBBFKaJXuEyiEqSXTZeQgds/R5u7Kz3AErUxPHzBlBwLfbgHsTK5JGb
         vbZvbhMBq60vH8UsaCjIfKKwAgUaHE9dR+FOdqqBg9rPEWk+DEx+EPxSk7UN0XGmbish
         djqrcxnLRZ4e5MI/It07z4A20rg4aTeNob9/q1HdyuvIlbgEIQNLWjM8NEa5+HnDN0Bk
         RqByv5KKHLWoVmbkPc2RUzNaeA/56Rk6S1anpFf9uGpmg22Lh3vQwDsQyHMbn62Y5YJu
         iEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvNk5AH6qjb5D0Yq0f0r3whZTQMlqWHEZUWSjJtbR5NqII1awAJxx0O5cc0ygLlxu8mKQsPt25dGHHF4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIa51wbnV09bufOWMw2n5hHb0bNntM0YnccDONL6igRdlmU/Kx
	yKIkMMlxopYUjcxldTuZHpjE8ajDYZGxJRsbtJkSYqIkT/X38m06FvGkr/vHmQ==
X-Gm-Gg: ASbGncvuGUAO6vIYjsNGaTx3PVCSIAsaWzSkG71a8tn4V/1diRUcmB33c8TJUMJHpkd
	n1TBDWs7MjfyoyVSXYvKfq/xVnpKaxzZwyJJ4xdElwfXsSkm6gRiffR9RX6pviofxwJ2/lpH/5H
	e9vxwOBczvVwbfs1YZBatKFznVwmvN3MJALX0UUdlclYabhIuiYHYykAJyup06jRCZ9jKPDYmiZ
	v7IhlUYB819BVOp9pG74t7p5Tw9rWNk3WgozpROrf+Ugc+zJW2DISTg7NbKEI/sxqh0OEEx5xWs
	l6jAq8y6aP9CdN/N/no=
X-Google-Smtp-Source: AGHT+IEltPMfgtQhVZ0dQG0v1P099D7vde3veq/4xhclX8N/PJrWK6HsbG46xV8T8CL676zNThnv6A==
X-Received: by 2002:a17:90b:3ec3:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-2fcb5a39326mr9355970a91.19.1740025194915;
        Wed, 19 Feb 2025 20:19:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9c92:f424:750b:8e42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ab0fe7sm12801138a91.10.2025.02.19.20.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 20:19:54 -0800 (PST)
Date: Thu, 20 Feb 2025 13:19:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Waiman Long <llong@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Lance Yang <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
Message-ID: <20250220-112040-neomutt-senozhatsky@chromium.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
 <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home>
 <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
 <20250220-112040-neomutt-senozhatsky@chromium.org>
 <524bd2b9-5322-4012-b1d0-b76edb84ec4f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524bd2b9-5322-4012-b1d0-b76edb84ec4f@redhat.com>

On (25/02/19 22:49), Waiman Long wrote:
> On 2/19/25 9:45 PM, Sergey Senozhatsky wrote:
> > On (25/02/20 08:09), Masami Hiramatsu wrote:
> > > So something like this?
> > > 
> > > unsigned int	block_flags;
> > > union {
> > > 	struct mutex	*mutex;
> > > 	struct rwsem	+rwsem;
> > > 	struct rtmutex	*rtmutex;
> > > } blocked_on;
> > > 
> > > enum {
> > > 	BLOCKED_ON_MUTEX;
> > > 	BLOCKED_ON_RWSEM;
> > > 	BLOCKED_ON_RTMUTEX;
> > > 	BLOCKED_ON_IO;
> > > } block_reason;
> > I totally like this and always wanted to have something simlar,
> > something for all "sleepable" synchronization primitives, lightweight
> > enough (memory and CPU usage wise) to run on consumer devices.  I was
> > thinking of a rhashtable where each entry represents "sleepable"
> > primitive with a "owner" pointer and a list of "blocked on" tasks.
> > But I'm sure you'll have a better idea.
> > 
> > If I may add a couple of "wishes", can we also add:
> > - completions (so that things like wait_for_completion and
> >    synchronize srcu get covered)
> > - wait on bit (so that things like lock_buffer and so on get covered)
> 
> Bit lock doesn't have a owner field to track the owning task.

Right, so that's why I was thinking about keeping it outside in
a hashtable.  A list of owners plus a list of blocked_on per "lock",
be it a rwsem, or a mutex, or a bit.

