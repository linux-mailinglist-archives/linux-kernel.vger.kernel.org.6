Return-Path: <linux-kernel+bounces-558078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A80A5E162
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B2A3ADE46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71F1B0406;
	Wed, 12 Mar 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="eNvYRTuD"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F718D643
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795433; cv=none; b=tzHM/YCMzkKr1fGOr/iuWb0vU9G2maiH2gq412MSwA/JNAPNX4th5a6B7mAs1u5zFKnQIwlEHEbPUPvvLYXNJ9Ol+GKcSa445rsjraSNnAFanSG6hzly3jsoUq+6iIOiialQ5o9KLZKYYSA74ReCHXmgfxIVdWKicwMRoyKGZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795433; c=relaxed/simple;
	bh=zepZhP3iRgu7VCHTnXMvKSWtEDnWV47OgGyOqd5go6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH1xooEd8pb/1SrP6dRrsEdBGdS8IG5QNkbfZ/5yRm32moeCcskDs0G6V56gKjl9cMCSWuls77vm7MN4N9ghk56GZCmYv58T+ke28BHY9HE7rrxZuyAAeetWEk9wwowbZUtb5+vr0EhyhivwILPV5ljduCK2unkTt2yIUFhXxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=eNvYRTuD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so125920a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1741795431; x=1742400231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zepZhP3iRgu7VCHTnXMvKSWtEDnWV47OgGyOqd5go6Q=;
        b=eNvYRTuDI1wX+cMtz5tKteK7YFhzVgYNzCZONx0o3hrxajMeu9A8RmuPNCRVJ4jmDL
         piDSX4IWEtMJG9meQLbUrCh7vnYcwIg7ncptqmQubLizUzhIpP8dRDzGQlYlVkSTyGhm
         sPA8EXrkDq5nQgMQq2vi/NCrperSSHIaHvAZkCFC0SfK+l/WbGMWmHF3FFgZU/Qv6q4j
         p6BhWlHLvW1rECKJR37mVucBWVdGrJ6DT9LeLjTHZNVRYYl8oO/yTwHV0Wmjp51HHz/w
         HsYlr/7gaS/2oLUHz/rhYoUadWVl0G32+XUDa2qJtrbcFt8dm6kSrXkvVc6PkHaGQVm6
         VWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795431; x=1742400231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zepZhP3iRgu7VCHTnXMvKSWtEDnWV47OgGyOqd5go6Q=;
        b=FrUrhESHjDnJWLl8cSt8aN2Em/SUGhgVMzvojg8iAe9rTZY1TDvmmaAOi0BQwngnzk
         FB0+ZyZ19deCmxiUIxgtUIiHwml4XB4kiv56nS0QyqCBJx809BxUdDBhx4WRLFFvoDHY
         3Q3ygEF3ChwDQb1R3BO13dGXvFnMUDdbyHPvWuhhGn0MIbqrCPAam2GwJGy1hmgsQ2iJ
         TcE+LT7uwq7jZ7bm8ZZETpwJKQUNkejxUOJo+qtqBaKk3BKQa5NlKbGGZ3frYRh9Qh3+
         dJ7O4mlaxSOLhJLIuT8OJda+2KIqPgvIfP+k2sYBUAYWtY9MaXHzwtdNs8KLl07tuDro
         1esQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA9ub0q57O3cnYkJCDSJ8/6kE2Bzah1dq1yTzUYabXpRlEwk1h+qLEfCuN2YrkRs1CHmoRnLy0B1TH1/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJnIiLxTpHFwvAzKotvr8FalUJNmgu7H5z75GV22v0bBHkcWx
	Q9nzWiWwulfq+6Xdmq5Hg0zv9VjJ6ogAZ6cs6w7kJUJVSy1iGYr1TN5bWWyXgydUqyhMjdv1hyG
	lihtloGmgrjWjbrA8a5RGE5V0PVt5H9EUwMNLXg==
X-Gm-Gg: ASbGnctP6CUcXhtz+NUstx8QdUa+ch/1BIQMlKPuQRwmkmbttquaw9ZE6lzIp47Qqe7
	Qk/rGT1tvo93hPqWq2Hc5o6yHAtEP0Xe+gFtdr5K0PGeg6XKjn8Y9bsmz1Xd8MJES02EtUfQHLh
	EQTmoVmmO9t6a7Egs3VeoowBRqzA==
X-Google-Smtp-Source: AGHT+IEf8vqxGqPhkQcc+WtrBu7Tpvs00r93QHKClgJq3i01gR0qdZRbJLqJ0wVixMhZyzimw5pfDjPnzxwpUS88S38=
X-Received: by 2002:a17:90b:510c:b0:2f4:49d8:e6f6 with SMTP id
 98e67ed59e1d1-300ff0a4293mr10164785a91.3.1741795431274; Wed, 12 Mar 2025
 09:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312111915.2970032-1-naresh.solanki@9elements.com> <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
In-Reply-To: <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 12 Mar 2025 21:33:40 +0530
X-Gm-Features: AQ5f1JqhE-2C8PQWLBe_GyQfLe2vWf7oUoGv_nnpjpn1XMv_BWlTtG7j-X0Bh4o
Message-ID: <CABqG17im5hO7xv-r16mFhJwcXyXt-6OKA_vTaRdc7kuQrdZyzA@mail.gmail.com>
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to v1.4.0
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org, 
	"Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"

Hi Gyorgy,

On Wed, 12 Mar 2025 at 19:47, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
>
> On 12.03.25 12:19, Naresh Solanki via lists.openembedded.org wrote:
> > -Upstream-Status: Submitted [https://review.coreboot.org/c/flashrom/+/51960]
> > -Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > -Change-Id: I55c4e8529d36f0850dd56441c3fb8602c5d889fd
> > +Upstream-Status: Inactive-Upstream
> Is that really the case? I mean it is just being updated to a new
> version, it doesn't look that inactive. That PR seems to be abandoned by
> the submitter at the first superficial sight, is this not the case?
Yes. its being inactive for long time.
> > +
> > +EXTRA_OEMESON="-Dbash_completion=disabled -Dtests=disabled"
> Nitpick: Could you please fix the whitespaces around the equal sign?
Sure.

Regards,
Naresh
>

