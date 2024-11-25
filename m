Return-Path: <linux-kernel+bounces-421259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EC9D88BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27F116B09D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57F1B21B8;
	Mon, 25 Nov 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JZpFYDpv"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD571B0F06
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547166; cv=none; b=frHLW1JMweHm73T/Wvs48Atp02MQsUNdYsGf/BJJcDVLEstNv+P/+EoOPQB3HImwLM3l3C5Y8o1HsgN+BGUrErMMK+dehStxFgcPpNRMlM/fDncdTPVFKCg2vIK44lt6XICufsFUesV5AcG0QT/OGirWdcoXAT09uGq3GPGDj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547166; c=relaxed/simple;
	bh=LxMztgNW0LfIP5/lVtd+yyO75BoseyhoayRS76gWIVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FMcm9/8TL1ShvRva6DKQIuyO4a8+RL/7IdDrFiaPUNC0XT1j0WToolGrz8aYgUnus2OoEa5pIhwkZAGrmCDZ4lgvs8oTzRatupNkzdDGK61QpSGMi1AQXC2PLOlIjUNMU5cBPY5i67u/4bsMRUgQp6a8u5BJHR65l5+zGb1LzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JZpFYDpv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4669eecd88dso2715151cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732547160; x=1733151960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Odb6HwBqhVtcHxBeQOFJ5xJTqDGEvgjNBkYIdkylyWg=;
        b=JZpFYDpvlAAVhar2x21fKe3lZ3TQf8GCZNVsmj01Yt4E4N/PWUa1l+trdnodSxDHaG
         S3FanrbH3olK6AbR/uP/sH4JLKa9RdV9z/P5cJbnbODJG4WKAYFxnbKWx2JzXT3Mlxr0
         0NGNYjEDTzon4QGdg/2Q62Y/X7ISFqFNNVNyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547160; x=1733151960;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Odb6HwBqhVtcHxBeQOFJ5xJTqDGEvgjNBkYIdkylyWg=;
        b=Jptvs/wD5VyapZvOJa3rW2ZIruO7VE7+W5OErqHURsVwicvNKnaIk3lOU9MELfG+SC
         IqDfERL/Lg3qv6iRVqPonfwJWWQB64wpMMXKDZWfPaG7AqjFPSZPbzHDKdauA4VSSo6h
         47T0jiJM1bu7M1YT3qGVYWcU1Sot6TPdhSTNPN5cJSXqvg8jveXLGRxsOzu07NZiA9eo
         2P7PXDVfT46m2qA+YsIkgAkWXw5u6ys6SJT1dpPsCA/1ekIS9oeO1JWl1tTS5sIWhzvq
         CZozUL7UEhXa5VcAygSUwQfHfOPwCv9j86Tq3JMYvTM125A6babpUUef0hANx0mTXd3M
         L3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmaUxBWSLMzqFI9DMpqvyzrRqSMecpOuXVw8Yysgn/UI+w7XM1xWIqngraw+yzAjlrNtkKpf4ETxHdXoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFX4pbF09IcinKPaHDJhc1mYEg7PIModFUenbeVLkX8ctvsiXd
	ZnjytyI5aBqjra0qi9Mn+GDtymknWMLFUqyzzTpvq8Tj/aQAWAZj7SSQF08umfdRWd56GjR89zJ
	CHeMN+l3VJTXvbJEVRVo5rIXdOuZNFbIZQn82fw==
X-Gm-Gg: ASbGncuMheYx4TUZ2wr8OUalL/EeZP68TcH4YUBp7HjDynxeK126Yw9CE0Xk14GkxRg
	a5bij2PCW9HFgvLrax1bXiDn7BS4kSK2UJA==
X-Google-Smtp-Source: AGHT+IGqI/9AP9tR1c34m3O1hWJP5tde7AZlFq0uo8d5BqgaPIdV+Ewn2Nb2TMQwz+/g+1aEM9UFoa/p7NSxI+zaQIA=
X-Received: by 2002:ac8:5d07:0:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-4653d627dfcmr176791061cf.44.1732547160336; Mon, 25 Nov 2024
 07:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Nov 2024 16:05:49 +0100
Message-ID: <CAJfpegvCr7hBSqU8iqKUCZ3i5wUyiiyfbCtP_NO37OGMA2RVPw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.13

- Add page -> folio conversions (Joanne Koong, Josef Bacik)

- Allow max size of fuse requests to be configurable with a sysctl
(Joanne Koong)

- Allow FOPEN_DIRECT_IO to take advantage of async code path (yangyun)

- Fix large kernel reads (like a module load) in virtio_fs (Hou Tao)

- Fix attribute inconsistency in case readdirplus (and plain lookup in
corner cases) is racing with inode eviction (Zhang Tianci)

- Fix a WARN_ON triggered by virtio_fs (Asahi Lina)

Thanks,
Miklos
---

Asahi Lina (1):
      virtiofs: dax: remove ->writepages() callback

Hou Tao (2):
      virtiofs: use pages instead of pointer for kernel direct IO
      virtiofs: use GFP_NOFS when enqueuing request through kworker

Joanne Koong (14):
      fuse: enable dynamic configuration of fuse max pages limit
(FUSE_MAX_MAX_PAGES)
      fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
      fuse: add support in virtio for requests using folios
      fuse: convert cuse to use folios
      fuse: convert readlink to use folios
      fuse: convert readdir to use folios
      fuse: convert reads to use folios
      fuse: convert writes (non-writeback) to use folios
      fuse: convert ioctls to use folios
      fuse: convert retrieves to use folios
      fuse: convert writebacks to use folios
      mm/writeback: add folio_mark_dirty_lock()
      fuse: convert direct io to use folios
      fuse: remove pages for requests and exclusively use folios

Josef Bacik (11):
      fuse: use fuse_range_is_writeback() instead of iterating pages
      fuse: convert readahead to use folios
      fuse: convert fuse_send_write_pages to use folios
      fuse: convert fuse_fill_write_pages to use folios
      fuse: convert fuse_page_mkwrite to use folios
      fuse: use kiocb_modified in buffered write path
      fuse: convert fuse_do_readpage to use folios
      fuse: convert fuse_writepage_need_send to take a folio
      fuse: use the folio based vmstat helpers
      fuse: convert fuse_retrieve to use folios
      fuse: convert fuse_notify_store to use folios

Zhang Tianci (1):
      fuse: check attributes staleness on fuse_iget()

yangyun (1):
      fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter

---
 Documentation/admin-guide/sysctl/fs.rst |  10 +
 fs/fuse/Makefile                        |   1 +
 fs/fuse/cuse.c                          |  29 ++-
 fs/fuse/dax.c                           |  11 -
 fs/fuse/dev.c                           |  66 +++--
 fs/fuse/dir.c                           |  37 +--
 fs/fuse/file.c                          | 449 ++++++++++++++++++--------------
 fs/fuse/fuse_i.h                        |  68 +++--
 fs/fuse/inode.c                         |  67 ++++-
 fs/fuse/ioctl.c                         |  35 +--
 fs/fuse/readdir.c                       |  33 +--
 fs/fuse/sysctl.c                        |  40 +++
 fs/fuse/virtio_fs.c                     |  77 +++---
 include/linux/mm.h                      |   1 +
 mm/folio-compat.c                       |   6 +
 mm/page-writeback.c                     |  22 +-
 16 files changed, 578 insertions(+), 374 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

