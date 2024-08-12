Return-Path: <linux-kernel+bounces-282437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4094E3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A391C2123E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199484C9F;
	Mon, 12 Aug 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mA6HQzR3"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB84A1D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723421064; cv=none; b=SxiDtM9Gci/TQAaVpBLAqDOXf+LM8u2dzGoPs3cSHgpW6p9ZAuqxC7vrgdAaenYQgkZv58NqwCspYbbBPBADAtH42rxgMjcPdpKeT/FTW69ETBQiAMCkTKU0HPZe/RR97EuZxFhgTG6jGKgugEZT4lVpjxFaPgVt2QyeKH5ItiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723421064; c=relaxed/simple;
	bh=xkh6wJHVf6uVke9ptkJtT2GAdv+0ZBuNUx7jFO6MAGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL3xU9dHb4BxMQL9u4P93unAvOVYsXXBBpIR02kOaHAr+Fjp4K5XAgmTNhzqLwe7ezY2fIyZFjNUi+4zWhdkBP2lK2Q/lTVdKRo+e8uv+VQGf1ULrxxEYtTBbj3RWLZ3R6A0WeU3BSOSeiNPU5B9sVRVSJfNtBH2a5kcffCECQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mA6HQzR3; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-264988283a3so2579588fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723421061; x=1724025861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwHHMTfR0m72/F0FKClBhUnG7fJbSLh/yvNQxx41+us=;
        b=mA6HQzR3S1Gx+jVpF/LL9s6yVD49b0wSkM2jyqIwbqQg8s5KgPDPcm1sN7HNu5EF86
         jaQdya+iaPt0AgKUeN1wVBU+XwL6Uw9IK75KU1A5XF+8ejUu2AJd1Jfs1qbIulQNBzAL
         82qVQ90H6jDALcmcVWgMZdrMBXG3eUs1y/tLaGbnJZYHopv08C0dWX24hI6IwQSavV0e
         fK3llqerNO44OpLS3XdNgJ7stAqeLjorqkqR2vx3ll/5SLLCLCpK3JasY/UIAGC4BOP8
         IA/KKv/W1O8FOTZTbdqdCoSUL38s1YuyMhQJ23nX0WDz0pHcMt8WlY7pKmxgywLwolJd
         mlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723421061; x=1724025861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwHHMTfR0m72/F0FKClBhUnG7fJbSLh/yvNQxx41+us=;
        b=MaSiOLv/9ylE5es9jY+kqWp5SlXt+im0+YExoFZtQkZEnCzyqmaFi6oQ4/BetGdy0S
         d6+wFn/NwYTUmRqgzTGMpjoAFGLe1UF35OOMMRGYH0csMO4nRhEXjWSHtbWk2SX3Ijj9
         lTpLKgCi4cMmZToo72SFRPmFWuOO3f57+gPFfkeEmz3+Ox+p9y2HXZQ4cdjJFKFdahpa
         WtBlylGplO1do6tbBmtGtdjT7DKXVg6uTLhI8HDvlhUoZ06fM5Ue9LZP4Y95lY4cFG+a
         w5FrHo8cG3WYdezbCJ+ZpDKja0GQvjD0qb4gvFi9IH1eFT6svSsDR4gRmuQkJOUH+wa/
         573w==
X-Forwarded-Encrypted: i=1; AJvYcCU4PTOekoBGyQMJHxVfms51SgZyaZC8iLeXG0kJg5CnhL1R+Sgw4xlE0ZQAlaz3HiR3vNAUkFhkY5NQ8zKwxloNCOnmMhja3LPSt2bO
X-Gm-Message-State: AOJu0Yxj3QYM6CJMS51UJI60LDFBEFs2SPlv7gWkJOhR/wmv1PV7AiOC
	5CA54ZlmVoo7O7z7MtIPRYi1nIWd/6bsEqDcDOACXV6haJyhJWQt0WJB0QEgoGM=
X-Google-Smtp-Source: AGHT+IGb7eCyKYvq+Vqr8OsUoaQJY2rmfDVWWR4wHJ7zWsOfWyPSQU6zpm+MuO6FZOFN+8ecM6Purw==
X-Received: by 2002:a05:6870:7246:b0:260:e36f:ef50 with SMTP id 586e51a60fabf-26c62c0df24mr10492409fac.2.1723421061598;
        Sun, 11 Aug 2024 17:04:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a89ab3sm2857371b3a.153.2024.08.11.17.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:04:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sdIXq-00DpB6-2p;
	Mon, 12 Aug 2024 10:04:18 +1000
Date: Mon, 12 Aug 2024 10:04:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: linux-xfs@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: XFS mount timeout in linux-6.9.11
Message-ID: <ZrlRggozUT6dJRh+@dread.disaster.area>
References: <71864473-f0f7-41c3-95f2-c78f6edcfab9@gmail.com>
 <ZraeRdPmGXpbRM7V@dread.disaster.area>
 <252d91e2-282e-4af4-b99b-3b8147d98bc3@gmail.com>
 <ZrfzsIcTX1Qi+IUi@dread.disaster.area>
 <4697de37-a630-402f-a547-cc4b70de9dc3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4697de37-a630-402f-a547-cc4b70de9dc3@gmail.com>

On Sun, Aug 11, 2024 at 10:17:50AM +0200, Anders Blomdell wrote:
> On 2024-08-11 01:11, Dave Chinner wrote:
> > On Sat, Aug 10, 2024 at 10:29:38AM +0200, Anders Blomdell wrote:
> > > On 2024-08-10 00:55, Dave Chinner wrote:
> > > > On Fri, Aug 09, 2024 at 07:08:41PM +0200, Anders Blomdell wrote:
> > > echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> > > mount /dev/vg1/test /test
> > > echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> > > umount /test
> > > echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> > > mount /dev/vg1/test /test
> > > echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> > > 
> > > [55581.470484] 6.8.0-rc4-00129-g14dd46cf31f4 09:17:20
> > > [55581.492733] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> > > [56048.292804] XFS (dm-7): Ending clean mount
> > > [56516.433008] 6.8.0-rc4-00129-g14dd46cf31f4 09:32:55
> > 
> > So it took ~450s to determine that the mount was clean, then another
> > 450s to return to userspace?
> Yeah, that aligns with my userspace view that the mount takes 15 minutes.
> > 
> > > [56516.434695] XFS (dm-7): Unmounting Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> > > [56516.925145] 6.8.0-rc4-00129-g14dd46cf31f4 09:32:56
> > > [56517.039873] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> > > [56986.017144] XFS (dm-7): Ending clean mount
> > > [57454.876371] 6.8.0-rc4-00129-g14dd46cf31f4 09:48:34
> > 
> > Same again.
> > 
> > Can you post the 'xfs_info /mnt/pt' for that filesystem?
> # uname -r ; xfs_info /test
> 6.8.0-rc4-00128-g8541a7d9da2d
> meta-data=/dev/mapper/vg1-test isize=512    agcount=8, agsize=268435455 blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=0, rmapbt=0
>          =                       reflink=1    bigtime=0 inobtcount=0 nrext64=0
> data     =                       bsize=4096   blocks=2147483640, imaxpct=20
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=521728, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0

Ok, nothing I'd consider strange there.

> > > And rebooting to the kernel before the offending commit:
> > > 
> > > [   60.177951] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:00
> > > [   61.009283] SGI XFS with ACLs, security attributes, realtime, scrub, quota, no debug enabled
> > > [   61.017422] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> > > [   61.351100] XFS (dm-7): Ending clean mount
> > > [   61.366359] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:01
> > > [   61.367673] XFS (dm-7): Unmounting Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> > > [   61.444552] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:01
> > > [   61.459358] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> > > [   61.513938] XFS (dm-7): Ending clean mount
> > > [   61.524056] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:01
> > 
> > Yeah, that's what I'd expect to see.

Ok, can you run the same series of commands but this time in another
shell run this command and leave it running for the entire
mount/unmount/mount/unmount sequence:

# trace-cmd record -e xfs\* -e printk

Then ctrl-c out of it, and run:

# trace-cmd report > xfs-mount-report.<kernel>.txt

on both kernels and send me the output (or a link that I can
download because it will probably be quite large even when
compressed) that is generated?

That will tell me what XFS is doing different at mount time on the
different kernels.

[snip stuff about git bisect]

I'll come back to the bisect if it's relevant once I know what XFS
is doing differently across the unmount/mount cycles on the two
different kernels.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

