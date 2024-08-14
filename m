Return-Path: <linux-kernel+bounces-285714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF29511A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7135E2866B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878B1CD00;
	Wed, 14 Aug 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bvh3SQ7J"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3918046
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600161; cv=none; b=TjozkXC2ES/+GT0kVJKx3Z+xI0o032KRP2X72esCGgeEpAU4wqX3bZnuOm3+u0BA7qA6zDe/feLSnHUnxAh+z/4vWRaoBgS3M0ui2Z8jh5L86c3zXVx971YBhiMJDZtpXO0rVXnUy0ex8GlO0po4wJdvjjmB+MiwX5mwnnn1zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600161; c=relaxed/simple;
	bh=pbuNWprQEBoJyI8KBTUf/yY/joRLqqEHcwtKN3Yy+ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtLw6pACSi5lPMOcYjniMZ2EErl2a74PNwAaBC8rNUP9yceBesdYHwendo14NHwzxIo5tVUUJoJ3f+W7A/G2L7BuQ+1vikvP0zR4wpUdcDhUNaPreZF5CKGCqtnMk9MCQ7qrKVex2ZY9xCP3xEp+6nQMeAzpeLtIN3xUV8xGzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bvh3SQ7J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201daff5461so613325ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723600159; x=1724204959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQuPtUQiqDIJaa11XX2bCBMMxTq1jV8ulgi33bMi18Q=;
        b=bvh3SQ7JSSHYF4bKwQt1z6ZTN3VHi7YEwUff1RlWFM6T6hWaOZEWVKd9qWcGOtjDLY
         vMaZAtLWAhh8PsMaaPi0QjzbkwaIr/DaKvnFOOcTYuE/xB2NsIHBpzVM3UiAh1r6z1n8
         JYH4BWO7MweYE0RfIraMwcan7dVFBmslCxVFQS+LHhSgoXrJb6tCA+m1fd+GHZYvoUcp
         1KCPH5B5eebBFSg3PME0n3VpAdusHs2yeJwd+qUD/NT6p00wiMGR3ZacIFO9JhkeR1wo
         Bc1BIZDVe3/hHrNV8DRV/5okjC1RqRvA7AIrm2LEO3E6W+3N4I8CKmrD8B1Yr/jk3DXm
         MLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600159; x=1724204959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQuPtUQiqDIJaa11XX2bCBMMxTq1jV8ulgi33bMi18Q=;
        b=f5Vcsy8in3OhFB1H+0/kmr56JPCv9hJPMg1mnsAYai4r79p4StBSGpy8suedma6yfw
         xUoC+w6+E1eiGOdRgJCAQ0fFmmZzd4bEN7nguc9XmpsxqFruAleZv3AG3eiJEBgy+Bgr
         aVJIv995cQpuW07Ur+JVIsdtkakykolytCM+UQ/7mbOylHeYvJJfHP+muafmOWQQ4KBD
         d1zdP+S4GcqDfMY/fExTprz0P/Yu/Ym4Im2kAc3H3a+qwS3KFhRhRwMyeC0JT6z0rf+Z
         +hfE6KCo9dO4PFa1iWO52VYGI4FxKxkD5kkzCrhmRyk03jIkRgE7SYl+caPsO0FZYkg/
         LiHg==
X-Forwarded-Encrypted: i=1; AJvYcCU4nIHkc08vn8bG9PeyGUv2q+HHoI4IW+fuYxtxO8z++G9yPnXQPI/5pcAt/2+02knpiRHBWc9qDI6OLbUShLKiL8Vy8r7OMDer1+9n
X-Gm-Message-State: AOJu0YxMCkqqqzVk420Tza1Jxc2TycZhGyqwbA1uO0BK1HQAaPZR2eYD
	6R56S0onlJejc0wRQWaY+8B41eUwuqRHPcEZnLK1ehcLTeP7HTxBhRwdYDNlc6g=
X-Google-Smtp-Source: AGHT+IEfAFPrWlCTO6wXtIMc3ItUikWnNtj+Pc/IdeokdwRfNhZ15x5Xomn4t0XPqIDvMxyohfjP+g==
X-Received: by 2002:a17:902:f552:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-201d639c93emr18247355ad.5.1723600159010;
        Tue, 13 Aug 2024 18:49:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201d9a78499sm1710655ad.153.2024.08.13.18.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 18:49:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se38V-00GGfh-2C;
	Wed, 14 Aug 2024 11:49:15 +1000
Date: Wed, 14 Aug 2024 11:49:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
Message-ID: <ZrwNG9ftNaV4AJDd@dread.disaster.area>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:53PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Patch 5 fix a stale data exposure problem pointed out by Willy, drop
>    the setting of uptodate bits after zeroing out unaligned range.
>  - As Dave suggested, in order to prevent increasing the complexity of
>    maintain the state_lock, don't just drop all the state_lock in the
>    buffered write path, patch 6 introduce a new helper to set uptodate
>    bit and dirty bits together under the state_lock, reduce one time of
>    locking per write, the benefits of performance optimization do not
>    change too much.

It's helpful to provide a lore link to the previous version so that
reviewers don't have to go looking for it themselves to remind them
of what was discussed last time.

https://lore.kernel.org/linux-xfs/20240731091305.2896873-1-yi.zhang@huaweicloud.com/T/

> This series contains some minor non-critical fixes and performance
> improvements on the filesystem with block size < folio size.
> 
> The first 4 patches fix the handling of setting and clearing folio ifs
> dirty bits when mark the folio dirty and when invalidat the folio.
> Although none of these code mistakes caused a real problem now, it's
> still deserve a fix to correct the behavior.
> 
> The second 2 patches drop the unnecessary state_lock in ifs when setting
> and clearing dirty/uptodate bits in the buffered write path, it could
> improve some (~8% on my machine) buffer write performance. I tested it
> through UnixBench on my x86_64 (Xeon Gold 6151) and arm64 (Kunpeng-920)
> virtual machine with 50GB ramdisk and xfs filesystem, the results shows
> below.
> 
> UnixBench test cmd:
>  ./Run -i 1 -c 1 fstime-w
> 
> Before:
> x86    File Write 1024 bufsize 2000 maxblocks       524708.0 KBps
> arm64  File Write 1024 bufsize 2000 maxblocks       801965.0 KBps
> 
> After:
> x86    File Write 1024 bufsize 2000 maxblocks       569218.0 KBps
> arm64  File Write 1024 bufsize 2000 maxblocks       871605.0 KBps

Those are the same performance numbers as you posted for the
previous version of the patch. How does this new version perform
given that it's a complete rework of the optimisation? It's
important to know if the changes made actually provided the benefit
we expected them to make....

i.e. this is the sort of table of results I'd like to see provided:

platform	base		v1		v2
x86		524708.0	569218.0	????
arm64		801965.0	871605.0	????

-Dave.
-- 
Dave Chinner
david@fromorbit.com

