Return-Path: <linux-kernel+bounces-402125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF19C243F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496221C25B46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E3219E47;
	Fri,  8 Nov 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rlFSkYKH"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A431C460A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087918; cv=none; b=fZ5Ac7EAmbVB1kSVlIS7swHtgG1Q0kRgN84djsh5mpWOi0TQWoBBoG7Q9w2XPIF4UIcDsp1bdskjQ6vfOlYQFlZUsD73qncZ5THYZhXuPvy71tOAjJD9TDqQde8YniNDpq5dd7PZovAYceex8Kji4FslD3go20YwNAFBtE5kQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087918; c=relaxed/simple;
	bh=40O4D/oIL4tEpy/8lWM27F2AJgtJtBL1vchNdhuMRRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZdl7gzchdeun+FzQ5K9kir4cU/+pLcubj7giQugBSg+5DBjPgYz7+tenu9MU3hjHZdItUeQW1hGnouIVcP8W10NpNVOqslCjoh/o7E/qCgsm8/V7HGOxDxUNnHEJoR/6iqbsHvokjlMDgzflSvDyFOA3WMednzd9NeV6OBGtis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rlFSkYKH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5ffbc6acbso1512409b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087913; x=1731692713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIbPsCAwFh4QrXCyUX2OKNpcITEfUEDm/2X9pcKM5mY=;
        b=rlFSkYKHGjQC5K8O2HPMjqGcPk6P55ttC6q3cxrnqq5eMQrF6nZVbcwcmqcwpn+6Md
         F76kZcOzZ/P+ZKwhg1NdM9nvVpahDomkI5mxncuYfaBeC9N4rRTbAEMV4Jxj3uXeOJ4P
         vWJ0VUkSndU38iib5iBg7pfUO+75dxhDybgBGLvpqZzSmRHs4O1qnSN9I3+3RNPbtn05
         1kV7R6gz4kezO9n7rmQc1Z5q1LASrJ/QZBD/YsJzbdxJ3T+lf237Q/7cRFeSIi8vVxq3
         eyVc6igfOCEQONDXhB2qZ+ZaFQkJG+zYobHDrYo/1eMFUBeSNI7SR5LJTJxdltqjitcJ
         Ij4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087913; x=1731692713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIbPsCAwFh4QrXCyUX2OKNpcITEfUEDm/2X9pcKM5mY=;
        b=qG7MSauM2QsnZZ/06oU7Riee2EyZ3eqdTnRFenh2WMUH1esn0EK+8UIiY7a2vSDEDm
         Aks4QmPdaNXXHc4rP1jZs1FObAX0rtduzrha7um5jCsDFztGnwBOzh7vi2/bGeYSfwoZ
         D+DrSdqn0rzQ7joGiZU54gj4OLmsVghRw52X6HEPLDng6TgyIfwZaDiXx4ErdAeERA72
         HutGuYFZBnNBWFKXxy56pT0wRGlw1ijk+llyoLeLxB4fSVNk0dSk6Ygb7GiwdrraaZ+b
         nILKzSuG4z8zuLddSox5loyASPj1DMxxYxjXgv7YrHUA3NMFdPVV8mE/QILIcv2BxO1h
         KJqA==
X-Forwarded-Encrypted: i=1; AJvYcCVW1PcBx9TquH6Rlu+b7O9CCYMbSqt/9yZnTeN7Oxa0URi+9brQ+ELssq9JbCiTYuPmLyT8XmbclihiPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2W/nbOVv9kFVOejd2s0gwD0CQbe6ZWl8NNGS0fX393v+JeBg+
	ypwjXp3prE9unXs/EqE73y0dBNvWU4VjAVCrjvQBM6U8HckQppcsWw3tEYndmGc=
X-Google-Smtp-Source: AGHT+IELfXTZchf5ws2966+qT0G3hRimxoOiA9u248rT/yieDoC8CAYaekbdxhxB2O+jrHp/dXR7Jg==
X-Received: by 2002:a05:6808:11c7:b0:3e5:d591:c9a9 with SMTP id 5614622812f47-3e7947031famr4902007b6e.26.1731087913567;
        Fri, 08 Nov 2024 09:45:13 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v4] Uncached buffered IO
Date: Fri,  8 Nov 2024 10:43:23 -0700
Message-ID: <20241108174505.1214230-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

5 years ago I posted patches adding support for RWF_UNCACHED, as a way
to do buffered IO that isn't page cache persistent. The approach back
then was to have private pages for IO, and then get rid of them once IO
was done. But that then runs into all the issues that O_DIRECT has, in
terms of synchronizing with the page cache.

So here's a new approach to the same concent, but using the page cache
as synchronization. That makes RWF_UNCACHED less special, in that it's
just page cache IO, except it prunes the ranges once IO is completed.

Why do this, you may ask? The tldr is that device speeds are only
getting faster, while reclaim is not. Doing normal buffered IO can be
very unpredictable, and suck up a lot of resources on the reclaim side.
This leads people to use O_DIRECT as a work-around, which has its own
set of restrictions in terms of size, offset, and length of IO. It's
also inherently synchronous, and now you need async IO as well. While
the latter isn't necessarily a big problem as we have good options
available there, it also should not be a requirement when all you want
to do is read or write some data without caching.

Even on desktop type systems, a normal NVMe device can fill the entire
page cache in seconds. On the big system I used for testing, there's a
lot more RAM, but also a lot more devices. As can be seen in some of the
results in the following patches, you can still fill RAM in seconds even
when there's 1TB of it. Hence this problem isn't solely a "big
hyperscaler system" issue, it's common across the board. Normal users
do big backups too, edit videos, etc.

Common for both reads and writes with RWF_UNCACHED is that they use the
page cache for IO. Reads work just like a normal buffered read would,
with the only exception being that the touched ranges will get pruned
after data has been copied. For writes, the ranges will get writeback
kicked off before the syscall returns, and then writeback completion
will prune the range. Hence writes aren't synchronous, and it's easy to
pipeline writes using RWF_UNCACHED.

File systems need to support this. The patches add support for the
generic filemap helpers, and for iomap. Then ext4 and XFS are marked as
supporting it. The amount of code here is really trivial, and the only
reason the fs opt-in is necessary is to have an RWF_UNCACHED IO return
-EOPNOTSUPP just in case the fs doesn't use either the generic paths or
iomap. Adding "support" to other file systems should be trivial, most of
the time just a one-liner adding FOP_UNCACHED to the fop_flags in the
file_operations struct.

Performance results are in patch 8 for reads and patch 10 for writes,
with the tldr being that I see about a 65% improvement in performance
for both, with fully predictable IO times. CPU reduction is substantial
as well, with no kswapd activity at all for reclaim when using uncached
IO.

Using it from applications is trivial - just set RWF_UNCACHED for the
read or write, using pwritev2(2) or preadv2(2). For io_uring, same
thing, just set RWF_UNCACHED in sqe->rw_flags for a buffered read/write
operation. And that's it.

The goal with this patchset was to make it less special than before. I
think if you look at the diffstat you'll agree that this is the case.

Patches 1..7 are just prep patches, and should have no functional
changes at all. Patch 8 adds support for the filemap path for
RWF_UNCACHED reads, patch 10 adds support for filemap RWF_UNCACHED
writes, and patch 11 adds iomap support uncached writes. Finally patches
12 and 13 do the simple 1-liner writing up for ext4 and XFS.

Git tree can be found here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.4

 fs/ext4/file.c                 |  2 +-
 fs/iomap/buffered-io.c         | 12 ++++++++-
 fs/xfs/xfs_file.c              |  3 ++-
 include/linux/fs.h             | 10 +++++++-
 include/linux/iomap.h          |  3 ++-
 include/linux/page-flags.h     |  5 ++++
 include/linux/pagemap.h        |  3 +++
 include/trace/events/mmflags.h |  3 ++-
 include/uapi/linux/fs.h        |  6 ++++-
 mm/filemap.c                   | 58 ++++++++++++++++++++++++++++++++++--------
 mm/readahead.c                 | 22 ++++++++++++----
 mm/swap.c                      |  2 ++
 mm/truncate.c                  |  9 ++++---
 13 files changed, 111 insertions(+), 27 deletions(-)

-- 
Jens Axboe


