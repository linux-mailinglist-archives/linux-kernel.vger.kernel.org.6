Return-Path: <linux-kernel+bounces-186030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF68CBEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0852846B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C081AC7;
	Wed, 22 May 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NiXbxpWa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7281751
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372442; cv=none; b=KFRZal10LSbDQp4ppz9RkSnZk2XJqipL+VD7gmN39/4HZbyw0Yj1HOlY8poD+BNpyN3FucJLJnEsyDb5TBFDvfV38A/HvsZhm+bty5J0zMoedrSRa9kOljS3KuRI26arg8OOEOPDBjWhKNE+ehKkXYk5CczodvsGzIC0ZyCKShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372442; c=relaxed/simple;
	bh=RqePpTznJ6Hg/lj+jQxcOKg1VXZcl9fRFJo9qAUvH/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EywnzsQwcD5ACv5rh1jIGA4nRQ0bRbPAlkPfe3gt0/5WWBXk88R8xY6MeS/Yi8n8sLyIYjLaNOWn6jmFS3p+aCyawuwbkcDdcS1YbI+k4FpxO02M4MIwmKENYqg2RezADra5zLbBS1PawJ9OAkcl1Rt6L54LXuN4jHcjx0CFwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NiXbxpWa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-573061776e8so9945931a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716372438; x=1716977238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I+PGeb1jwb4dMj4ZXBFkbCVxNbnh5wpO/o6oygTVLc4=;
        b=NiXbxpWaHS84polxmTTph/o3pAqschY1zxuTeIN4LjkXzGQfGrRZ4E9igJT6m+pWHb
         I31jntXPVvAzcFRgYmAFCCEDJkuBbkyUa/J7WW3kim2/D8MYvf1KQVmoDG0Z94m1FMv5
         I2PFGZl8pZmGxKdxZ7Um5PXNFA30eJ0hcySLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372438; x=1716977238;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+PGeb1jwb4dMj4ZXBFkbCVxNbnh5wpO/o6oygTVLc4=;
        b=K2m8rM9EIH+oPVUcavM58Y3KwZzEfqkVGon1i0EZ09iPLF83y5Vre5+B79TVn1V3Lj
         eO5mKnm9IBe6tawd0Mc1CdnSHXBphxXC5nkz0KkeIoQbWdOuBhaEinl33HJCWDElZk/A
         2UDkcBkGV6LCpbB+1mfDprCfTcc/F5rnHaguCY/lNHq5re2lVE6Gci1EqOdSSUdLAroe
         JPtO1JH7NGIgFRXw86uBqP3j3Q7Scb7QEMucoOxND0mJ8jWaHhT/h7zwIaoT97ISffvi
         l9oVryg3mBARvUr/PhDFyRbjZEm2+GfJ5oks0ihRarY7hkc7stwVmF4ae0mG8mWnjoHR
         HLdw==
X-Forwarded-Encrypted: i=1; AJvYcCV3zYvGBiMpBzPbySr8lT33U6O7EMe83wVkyqG/9nBuMSIepYLnmYHikrK/K88PGQ5BIV8ohJhDDBuHEJ2ExzhtLBt6ialtG27732Hx
X-Gm-Message-State: AOJu0Yxb3ZN+VprkA/wKjhur/XA54/1DEa3zL0OLQ6KLQ/IuHZR+5soH
	79AUyeCPkRoohbaDyhzL/eoUdOXWjpuUtUpZlLR9cMcWyS6p2ma2hbBIKgwOJj/ZEZB3++6/XN4
	kax5Dtw26GtTuWc+hr5WZdBKoib7yzN8fMjKEzg==
X-Google-Smtp-Source: AGHT+IHqv6bB6B3rMDBM8tHyL/Ss0Wbypm81kMKQwLrRqQgLiEOBdPj2vhCsgl87SQZa5eRQlt2eyNe1Gg/8uqBdEpo=
X-Received: by 2002:a17:907:7847:b0:a5c:e2ea:ba59 with SMTP id
 a640c23a62f3a-a622807cb10mr76782966b.29.1716372438209; Wed, 22 May 2024
 03:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 May 2024 12:07:06 +0200
Message-ID: <CAJfpegs9w+yNAvFCj9Ne54H6WMCJ9T16CrNDO-NRJwb9V5ieTw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.10

- Add fs-verity support (Richard Fung)

- Add multi-queue support to virtio-fs (Peter-Jan Gootzen)

- Fix a bug in NOTIFY_RESEND handling (Hou Tao)

- page -> folio cleanup (Matthew Wilcox)

Thanks,
Miklos

---
Hou Tao (2):
      fuse: set FR_PENDING atomically in fuse_resend()
      fuse: clear FR_SENT when re-adding requests into pending list

Matthew Wilcox (Oracle) (1):
      fuse: Convert fuse_readpages_end() to use folio_end_read()

Peter-Jan Gootzen (2):
      virtio-fs: limit number of request queues
      virtio-fs: add multi-queue support

Richard Fung (1):
      fuse: Add initial support for fs-verity

---
 fs/fuse/dev.c       |  3 ++-
 fs/fuse/file.c      | 10 +++-----
 fs/fuse/ioctl.c     | 60 +++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/virtio_fs.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 130 insertions(+), 16 deletions(-)

