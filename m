Return-Path: <linux-kernel+bounces-289257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2035E9543CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6480281C15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A212FF9C;
	Fri, 16 Aug 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ni852PVs"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A182866
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796338; cv=none; b=jbd2CW+cQ6KdFm1Pg4Re3N6yAqVmkWtIAheQ/iz/pAtM5Y+3vcZNtXsmtlOksmt5b4loLIYGgx0Ry1iMjOQ2wFG+MSzYbj3+clUrtXdpmS7tcJQC6KPuB7JfXQyOs6/xKtXenpyQ0DKQLL7Mj7pq0H332bT1wCpKc5XNUYkz4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796338; c=relaxed/simple;
	bh=/FSCZwMWDBvL2pdVUDCcXybfvMINgHHjI88FNgz9Ybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qip3Q4w/xztlLr0nj8wrNiTZnDdcUGQhuuY8Y9EDoJOBUMLp2+xFAyqDBgs/65HElTeJJpXFIfRc0JtuOxC0dkwKvWsqa/Q3lFk5gqW5YOs13sv+WWCbCh89jBBopdBFnur5cnMhQ/kNYk3aO0PcoNbjLVnn2UXrFi7ZRnFG8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ni852PVs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3719896b7c8so80329f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723796334; x=1724401134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHLNBtu3gOxyQPcoDoB7/UuHac6loGYyqpNQ9W8K+0Q=;
        b=Ni852PVsDn4amVV2eHoEnsKLAWMmBATbjIrthiqIxTXB3L3sAong9loqMu8FR0WDQf
         EiHRsWrG7fk8lNn87YVF1ySB0QGWPov4RoebLzQZgTEnGEbhLwW1CTdaMik3L+r8pxv5
         lPDLPMjX1MBYX0VvGr8+dmyBBQVxfcieqWnA4MVFWLj4CBAFOMkcAOyQUQf1saaizXMf
         zhG2LZ3o3y+ah1SMwg4x9hpXAMZZ2RgobNLL8sISOZjjxuPOK4NtuC3V11HDwLfke7+K
         fOfZq4XRwWLVtMzAsOKPwXiUoRBdoyQN7xW8r+qNC3wMN1kmXH7sTCuASbwYwSdAStnQ
         0ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796334; x=1724401134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHLNBtu3gOxyQPcoDoB7/UuHac6loGYyqpNQ9W8K+0Q=;
        b=O/AIbDAvlH7rv60lofr4Np2NEHMVhT+3nY535Bd40VEi/GcqTxUOafM0JVihj6iN/m
         9/sNAKBx6LTg9S+8rkJlUpSZrtj+mkNFsGRv9u+6thIEa2w82JZ4oZZY2TblWO8sctlF
         ZUZY2PBm8SDgfiA4z9QEbagTNRhFwj7DduSLnA7+mAOH6oXC4qaTtMeNdf+/snB0NFdg
         hTsRNE6+vT3kDdhpXWLeMv/asyKzPUw6x8fUrTT8LobusX9yBo3Zl5sRwmL9CAAlRIUy
         f2llJzkJuIduT0mxUvsKDxQoc6f2Mmu/AyaRP1R93IrE3XmnY1jr2/ytoBKd92CBc3NF
         x53g==
X-Forwarded-Encrypted: i=1; AJvYcCU1arQC/2CsptP6Tew8OrljWTTpAaWFXxqthDQGoDCIILDt+y16JMcdBdNtdeFCgtLm8KWFaHkI0pN4/wp1llBBLjSVa6wo355NybYb
X-Gm-Message-State: AOJu0YzHA4cHhMC55Ya4YUMIzuXXA0FUg10xCYTftkqw1KIFRBUh7rW1
	EYH+VbGS9tLvneN+y/zTW6jzbFzSsT0X3dNyXiUsfGjcqVOjg1y8G9TvAS8LDkM=
X-Google-Smtp-Source: AGHT+IFdBske6NMqguLo6M58gZVPz/3hhle42cAyCb4RiH4ciuwNcbDyYr/kztrq34Zlbgm0uutPxA==
X-Received: by 2002:adf:ed04:0:b0:371:8c09:dd9a with SMTP id ffacd0b85a97d-371946cba59mr1501747f8f.62.1723796334388;
        Fri, 16 Aug 2024 01:18:54 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896d74sm3086190f8f.68.2024.08.16.01.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:18:54 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:18:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: replace memcg ID idr with xarray
Message-ID: <Zr8LbVe8IGd1JSQo@tiehlicka>
References: <20240815155402.3630804-1-shakeel.butt@linux.dev>
 <Zr5Xn45wEJytFTl8@google.com>
 <Zr5wK7oUcUoB44OF@casper.infradead.org>
 <Zr79nrBAkfSdI4e5@tiehlicka>
 <20240816004334.41ce3acf52ba082399a76d88@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816004334.41ce3acf52ba082399a76d88@linux-foundation.org>

On Fri 16-08-24 00:43:34, Andrew Morton wrote:
> On Fri, 16 Aug 2024 09:19:58 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 15-08-24 22:16:27, Matthew Wilcox wrote:
> > > On Thu, Aug 15, 2024 at 07:31:43PM +0000, Roman Gushchin wrote:
> > > > There is another subtle change here: xa_alloc() returns -EBUSY in the case
> > > > of the address space exhaustion, while the old code returned -ENOSPC.
> > > > It's unlikely a big practical problem.
> > > 
> > > I decided that EBUSY was the right errno for this situation;
> > > 
> > > #define EBUSY           16      /* Device or resource busy */
> > > #define ENOSPC          28      /* No space left on device */
> > > 
> > > ENOSPC seemed wrong; the device isn't out of space.
> > 
> > The thing is that this is observable by userspace - mkdir would return a
> > different and potentially unexpected errno. We can try and see whether
> > anybody complains or just translate the error.
> 
> The mkdir(2) manpage doesn't list EBUSY.  Maybe ENOMEM is close enough.

it used to report ENOSPC with xarray.

-- 
Michal Hocko
SUSE Labs

