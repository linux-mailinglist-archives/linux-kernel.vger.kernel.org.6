Return-Path: <linux-kernel+bounces-571589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C8A6BF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DE7A4BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66822C322;
	Fri, 21 Mar 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciKoWlGm"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57D22B5AB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573604; cv=none; b=BjUEbTRNV3caM0HEwXUYuNKDrOQPtqthy0wA1mA6b5K5n6nlsN3Id42wYox+MZCjwo6OB/8YeVnVUT37MamdsEFqc6JwxHJQ2DnGPzBX0KWpMpWxbdBTBD0mDUo9alRb49rzRFbZ69pCxX/GhtE7QkDtUuTO2ze5RXh4Dt4/pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573604; c=relaxed/simple;
	bh=C4aK4DlSw/wJI3i7YtL8fTLyTEQqGsdWSWsribRkY1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+8j7ws5sCzBhuuG1sve8veDMLCoM+bp6bxGL/ZAsnIYEwF/3ZqGWeoYU+qyJiCKsOl/xmrsrbhO3A15ki8NmdrRTVVHCK1zoJJlxJ19Seu9taSxzMXItnlR9QWhczrSAv401oHyfm/vPOy003qOsriYkmmmxsmYM4kEAgbq0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciKoWlGm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476693c2cc2so361781cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573601; x=1743178401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DB6Et2/ns18QKw/fxCT3wrpCitAogjqJ6rF7Sc/IdI=;
        b=ciKoWlGmO0mpXBvyGxsnvw5X8odjsFGhO3wgjjxYo+qS6ulwDyXudLOi68VOG4fTyq
         9s3RPfcavXJy2t7ylGYjZ1jeH0H55Ti9CIJjdBg0WJBv1WrvH94pdcUasmr/uR/q+3Bl
         VPHAKtGDa5dbp5ZK+qtGuRr1Pio8IYlPAiHnp5K4nTysOL5Zl6GFONMp0TrJEVaaoveR
         619OFSBc3T+EZV3EDJR1Db+n0l76Ub2slZ1nNhSnHyQG6l95rzCBRkFdShfYc/9nfWkc
         0lEPW3cueY+5cQaeG+LHui7qps2vmIo2FjD+cJTzPnurJkAzfzCN9YuTyh1HdfFNjsMR
         cnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573601; x=1743178401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DB6Et2/ns18QKw/fxCT3wrpCitAogjqJ6rF7Sc/IdI=;
        b=B7m/4qf87zv7ueiNDbc7BrzZtp9dRriaMg7wLey0d9OZfFENcSgtJHp6EriuSzEdv2
         6ue1Z0RtzO2/fdAsgY4RwIjLHeNFXeE3P29CG7zfJJ5DKtHc8q1icPmd+vUgO6kg0mAg
         GBK/ruhdlECmWXky0FTdcYVdXb1Ne+Aq6cg1GK0vOdHt3HMn/m4vZmvtqb86JSMHwjpg
         Ll1y7GrQ+aM2jx+odctNICMpslTcJMihil3MvcW6JgKYlL/gUqX86QcutpxOe+nF5GNA
         1QWYQoZcoEuH6R1iSV+VcUOu9jlBR+4iZCxkSApldFg99JPuIS/CBtY1iJAEY74/wy8T
         QKXw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZiQV+ObPKPVHFxY8ZzX4d3pTalpYwEi/5yBltJGXP4iGzh3xGui/8qbc7SWaEvDNJz89x+6cKkNGi/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeSgTELBenFMpzZGDMtiUpJIY3W1e4nh0amKGVD3xSJRZN9FO
	KPICnSsAl6qbC8t5R4tn+j7lJT8IeZrxuz8mv77oNJ5u+H4Sb4crO2eLA43b4JevUITi4ufJvWb
	XhA+D/9xi1rhrf7kqdpJC58lFZe05IJgReLvV
X-Gm-Gg: ASbGncscKiLbyyGpwgME0YVtEEzewsk8FsDpwyCWFCRVq1jg3l72gQYtlo4x8XLqvW1
	Z3qUA/QZBSgeIbHZOrB8Rvfq/FMvW+NYbZ4e22Mw+8WQPH5Qoo5glwEPE7kUiVeWXXpVRQBg1tN
	l1ifg4bviXv2inghepIMucNxrq2w==
X-Google-Smtp-Source: AGHT+IFSgyka4WC1voAzOEbVYGRfiKD2rPwZmgBJm5bmCEG2w77v71gm7DM31qNjr/YtvVbNnr/XQWUzc/NWKh6R9Qk=
X-Received: by 2002:a05:622a:4acf:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-4771e0a7e7dmr5053721cf.2.1742573600117; Fri, 21 Mar 2025
 09:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-3-surenb@google.com>
 <Z9z1w2vHfJrwSgWW@infradead.org>
In-Reply-To: <Z9z1w2vHfJrwSgWW@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:13:09 -0700
X-Gm-Features: AQ5f1Jr9bSIHVG9XyNi5uOulPdcHUxw5kGAy9us8_XrILBTKaK6kzxC5mMI3vcM
Message-ID: <CAJuCfpF=fk3=s3NLkai0GN5twjgY8AyyL1vZn3T+N7E10SgHug@mail.gmail.com>
Subject: Re: [RFC 2/3] mm: introduce GCMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:14=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 10:39:30AM -0700, Suren Baghdasaryan wrote:
> > From: Minchan Kim <minchan@google.com>
> >
> > This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
> > cleacache backend which reserves some amount of memory at the boot
> > and then donates it to store clean file-backed pages in the cleancache.
> > GCMA aims to guarantee contiguous memory allocation success as well as
> > low and deterministic allocation latency.
> >
> > Notes:
> > Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
> > Later Minchan reworked it to be used in Android as a reference for
> > Android vendors to use [2].
>
> That is not a very good summay.  It needs to explain how you ensure
> that the pages do stay clean forever.

Sure, I'm happy to improve the description. Do you want more details
about how only clean pages end up in the cleancache and how they get
invalidated once the original page gets modified? Or is the concern
that donated pages might be changed by the donor without taking them
away from the cleancache?

>

