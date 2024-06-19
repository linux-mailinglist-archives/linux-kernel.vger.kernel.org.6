Return-Path: <linux-kernel+bounces-221578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1690F5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940EC1C2111E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94374156669;
	Wed, 19 Jun 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Ni+sHEvN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A21AACA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820232; cv=none; b=fsMu6LN6/lrcLJcGSoZDyR2/PW+NJer3MfEbIF16/lW3h7ImTg0wWzhqJq4SYOqyNQ3lxMN+Y9bJfAkxD6ddGUeS+x4h0hg3VLVdO1OZ9EMvbVgaj9jBS5tRz8/EBfET+CQjVCTGYzbUp2jvFPjO/3cuMJ/O34R7so0kIZ9xOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820232; c=relaxed/simple;
	bh=E8fYTNuxncc6ua3apnuYuOnGPi2E2eZjt3umEpuwO/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQMudREoZKt+KtsgnaObgssc5MpF8B1EGGfyVii02MWde4GKG/LZLwxyaKA1sYSsxQev5AIenqb9W0ZyJjE+JV5zOVjKpm0vU2QarjnfP/O3EP1Kgbk50y6oN+kJp6pDD4O2Iz1EP8Z6eTKYrgyeQuPpiTsQj9o7ZTYXdysAY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Ni+sHEvN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217926991fso779645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718820230; x=1719425030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBjwH7XhHtGHbIrjPZpHwYhP3dw35hC85DIjS3QHdns=;
        b=Ni+sHEvNjg4pgeKg5Tkiv/XfLmAPpHwg2taNKcJfWNtiSnj7KzOMuCynvWgWtPj1I1
         25eFjx9bxRn7M/AHTyujHerI6pM3Z8b7QCmtodz2v0RdMMRts5a/sCq3ahiABVAj9QYL
         uSoe8L3+mlBzwOkW1IjtCAemtOcQUBssQ9IsJbv29/Y1cs5mfgBrK9d8QwDliS+9ZSFu
         oqdkcA0xd/bqFMeTt6S0BloqUh8xtTMUZiQaR6YsSeAS2mgEkS2cVV7gkZLwx986MK7n
         kCJOkoQeRZE5qLE/44eJ2tPaHXJhpD4nyx84n7H/Hj9857wTyNUfYQ6v2rtPA6hyJ1Bc
         R1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820230; x=1719425030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBjwH7XhHtGHbIrjPZpHwYhP3dw35hC85DIjS3QHdns=;
        b=K9HCQ4ejtKv95kxPz5mSlehJOWuSQHaBXkbbZeHpnCc4G0QmdkqtitpNYV3Y2+GCwA
         gYpau/i85jty5652FLu1ZrJOpvhpDIXw7VCTMJjB3muE6pzxuJ3fCyOx/kg4G2Xe8k78
         T0RAxMfIQyQ4OXpw741K/LaiTT4HDAuYQNb7ML6qBbN94KT9TkJsj7BQ57/a9LieXo4G
         TCUTU1l7nPZxWI4N0iCkPjYx3D5L2FMNUzQbPBDDut9jZNFU5Ir2PjulZdezYLeva0Ir
         BsxLB2QKd1tNfpDppwF65b/4T4QPn1lXHLMUCWs86WGFcf4PopG7qnG5p3ah548LZQmm
         NDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTt3tigpMaR1mymeDSqOX0jsPIatX/V3aBnu6EJJygI+BtgBPvqKDZ3M+V0LzcDJL7gc+Yx7C99rxk6u8Jxuu72Zf2eALUGDCCncaY
X-Gm-Message-State: AOJu0Yyoyl6eiJJ6Xpw9W1zwo9+NfHEBc29MFl+mCMUk+XJX6d6n+8FO
	od5VGuEeD+GlDqazLWGujyMfUm5zTTcM3oQ2dvXE6Rw1sje2FSFa05GNJcYP2bE=
X-Google-Smtp-Source: AGHT+IE11qHIoeWE4/ZnaHU+x+9C3StSmVvgDimbuCwc8W9DaUpLRz0TMhdZrW/vF38xMDn8OwKxIg==
X-Received: by 2002:a05:600c:4194:b0:423:6b7:55ee with SMTP id 5b1f17b1804b1-4247507a958mr23144275e9.7.1718820229608;
        Wed, 19 Jun 2024 11:03:49 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm277081595e9.37.2024.06.19.11.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:03:49 -0700 (PDT)
Date: Wed, 19 Jun 2024 19:03:48 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240619180348.rp22d4ozb4emncuq@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu>
 <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
 <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com>

On 06/19/24 10:46, Xuewen Yan wrote:
> On Tue, Jun 18, 2024 at 10:58 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/17/24 12:03, Qais Yousef wrote:
> >
> > > > Sorry, I miss the "fits_capacity() use capacity_of()", and without
> > > > uclamp_max, the rd is over-utilized,
> > > > and would not use feec().
> > > > But I notice the uclamp_max, if the rq's uclamp_max is smaller than
> > > > SCHED_CAPACITY_SCALE,
> > > > and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> > > > return true, and the rd is not over-utilized.
> > > > Is this setting intentional?
> > >
> > > Hmm. To a great extent yes. We didn't want to take all types of rq pressure
> > > into account for uclamp_max. But this corner case could be debatable.
> > >
> > > Is this the source of your problem? If you change util_fits_cpu() to return
> > > false here, would this fix the problem you're seeing?
> >
> > FWIW, if this happens due to uclamp_max, then this patch to do the capping is
> > still needed.
> >
> > I think it's good to understand first how we end up in feec() when a CPU is
> > supposed to be overutlized. uclamp_max is the only way to override this
> > decision AFAICT..
> 
> Sorry for the late reply...
> In our own tree, we removed the check for rd overutil in feec(), so
> the above case often occurs.

Yeah, the current definition of overutilized is not good enough. So I can see
the need to do that..

> And now it seems that on the mainline, uclamp_max is the only way to
> override this.

Thanks for checking. Your patch is correct and if we combine this with another
patch to use get_actual_cpu_capacity() in util_fits_cpu(), they are good
improvements.

Are you still happy to send an updated patches?


Thanks!

--
Qais Yousef

