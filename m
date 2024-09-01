Return-Path: <linux-kernel+bounces-310333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF1967B7E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 19:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C021C213A0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E52BD05;
	Sun,  1 Sep 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dySyYQ8y"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FA17ADE1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211956; cv=none; b=ETkZ0RsCBsndy/XEAKwB20JVDiKWGW/2gfhAhEK6iVAW4UT+I/qbhLWwlpEE8bF1VwqvQcxW2Aovi2bACwGuBv+uh2kV/Z3iU4aMNpXGmAhkcnxIjtMMufgFddZesrNfWUJhe//+kE4hEYNvX5f3+RhAT04BKel6tyCeOk4FNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211956; c=relaxed/simple;
	bh=EkWT1jF7poYKL1Z6hU8sc4dRjedKR4GLFHZcsyyeOLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mipG0qW0S5uHqVgPalrIPOVkRjuV8o0xnqC78E0mYs58mcnV7NHRyL7yFsOePPZ/Xnrexlc55BlHspul7/NSMQj8iPpph59RHlbATtNr0xta+CZFnKzKllCeGonKyjNlWzWVUCndCV6/xLd4IQkGgwlyzcLhAGLuBY5zjd5iU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dySyYQ8y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367990aaef3so2120716f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725211953; x=1725816753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4D4sJrLrrIZ7iVSCd2I4lMCj60uPYottSCrMVDrHb0=;
        b=dySyYQ8yRHA+K+OnhGUK+zN8GIKkdjjhWturWHFp1fay5dObVHqzSnvjZIpb3ujSJ4
         aj07Gw4krOtJnQYposqjnq+SberWJ6LCrfnHGjuCWGuhUHErBiJPYtQJ+rgvuKB7BK5y
         dWnTVGLdBO7diKCyM7qHbAtG3wGhVlJA914Id5ASex9a7LakRCR0P8DwRThlB/th5C1I
         rZbWdFdn84Iqco996aew21t8WMFqi+DzSS1dmzhlD+49LmqK5TbRzBzcGvIlZnnfNYSI
         J3xf7YVOpuMlcesXYL6dZUgcdV86S8lWk7391EkV4WWpitq7mua3bBx+HhjHThNJxVMU
         5eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725211953; x=1725816753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4D4sJrLrrIZ7iVSCd2I4lMCj60uPYottSCrMVDrHb0=;
        b=XOwkHkqOZOR/GQMPC2cfezLiFApQeA7pd+gI0+HJ3rdNskDNRL9r3h+g5ZNlyG4pdY
         YRF7GBhJChyu7BOhqdKd2cMo6S0cev/D9lqJ9Wy/01f3ja3t1sgLVJubWiEcqG1JK3mD
         Ze8Blf3cIpwbFeJ8HboQzh+2hVBfSEkxVcTWP8u8iPzfuX1bUP8bHw9D3+DlHQNd5wdD
         baU+x6JjzfEU+1jzBmq4WpZFD+MBdgl5psoD9HsinCW9mpV2yPnPnTS6m5hYTsjmW2Qs
         Xn9peoIvGd34aYv86fdmJaRdIphJ0okifMB9OMJvBqxtAH9MHTC6Bd8Bqui91k24AELx
         xjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKuaxOEpQRSfQZUwf7caVhcjYl9vhgZVml5D1B4gigyAJu7fpl7WcfAMbGhhMgDETC6a0YJr0QvPTlm/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaP9O8t2wEFtpjGZ7qaEMZW4Z8n3be/SsBhsbaAp9oahbTfmiW
	tApdimdXhjOZZ65yFJ9zEAisEfhx05kDdeZU1qGdCWstX84hyhf0O+L0QFKOVBo=
X-Google-Smtp-Source: AGHT+IF90MOG01YVgBOrF3b0ODo3ETDvTIlN2Kg7QhpNwD6cuuJL5fr1+FoCN4ZU3ILfdx3HxUhC5A==
X-Received: by 2002:a5d:51cd:0:b0:374:c515:4441 with SMTP id ffacd0b85a97d-374c5154570mr1799939f8f.56.1725211953126;
        Sun, 01 Sep 2024 10:32:33 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c255d3da3fsm836309a12.79.2024.09.01.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:32:32 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:32:30 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Manish Pandey <quic_mapa@quicinc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
	quic_narepall@quicinc.com, quic_rampraka@quicinc.com,
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH] blk-mq: Allow complete locally if capacities are
 different
Message-ID: <20240901173230.lgyvfkx5eq5sr7ss@airbuntu>
References: <20240828114958.29422-1-quic_mapa@quicinc.com>
 <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>

Thanks for the CC Bart.

Manish, if you're going to send a patch to address an issue from another merged
patch, the etiquet is to keep the CC list of the original patch the same and
include the author of that patch in the loop.

On 08/28/24 08:13, Bart Van Assche wrote:
> On 8/28/24 7:49 AM, Manish Pandey wrote:
> > 'Commit af550e4c9682 ("block/blk-mq: Don't complete locally if
> > capacities are different")' enforces to complete the request locally
> > only if the submission and completion CPUs have same capacity.
> > 
> > To have optimal IO load balancing or to avoid contention b/w submission
> > path and completion path, user may need to complete IO request of large
> > capacity CPU(s) on Small Capacity CPU(s) or vice versa.
> > 
> > Hence introduce a QUEUE_FLAG_ALLOW_DIFF_CAPACITY blk queue flag to let
> > user decide if it wants to complete the request locally or need an IPI

I answered you here

	https://lore.kernel.org/lkml/20240901171317.bm5z3vplqgdwp4bc@airbuntu/

This approach is not acceptable. I think you need to better explain why
rq_affinity=0 is not usable instead of confusing rq_affinity=1 needs to be
hacked in this manner.

The right extension would be to teach the system how to detect cases where it
is better not to keep them on the same LLC/capacity because of scenario XYZ
that is known (genericaly and scalably) to break and requires an exception.

rq_affinity=0 would give you what you want AFAICT and don't see a reason for
this hack.

> > even if the capacity of the requesting and completion queue is different.
> > This gives flexibility to user to choose best CPU for their completion
> > to give best performance for their system.
> 
> I think that the following is missing from the above description:
> - Mentioning that this is for an unusual interrupt routing technology
>   (SoC sends the interrupt to another CPU core than what has been
>    specified in the smp_affinity mask).
> - An explanation why the desired effect cannot be achieved by changing
>   rq_affinity into 0.

It fails to mention a lot of things from the discussion from the previous
thread sadly... Including the fact that there's a strange argument about
regression on a platform that is easily fixed by using rq_affinity=0, but the
argument of not using this is because some other platforms don't need to use
rq_affinity=0.

I'm not sure if rq_affinity=1 is supposed to work for all cases especially with
the specific and custom setup Manish has.

Anyway. The submission has a broken CC list that omits a lot of folks from the
discussion.

> 
> >   block/blk-mq-debugfs.c |  1 +
> >   block/blk-mq.c         |  3 ++-
> >   block/blk-sysfs.c      | 12 ++++++++++--
> >   include/linux/blkdev.h |  1 +
> >   4 files changed, 14 insertions(+), 3 deletions(-)
> 
> Since the semantics of a sysfs attribute are modified,
> Documentation/ABI/stable/sysfs-block should be updated.
> 
> Thanks,
> 
> Bart.

