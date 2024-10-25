Return-Path: <linux-kernel+bounces-382047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F19B084B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D11C21898
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B615ADAB;
	Fri, 25 Oct 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BV/VLkhq"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218B13632B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870224; cv=none; b=S1tagyjwqPMNYtqS6hZMTUVsDwNJi5FpeoNTymf4MZ+xuYNBlNEQLAnEBMDZPmWn86aDbEevy/5smmpEftIUwE4BtdoMaZPsup633dpCtmzUYiiMl7VLRSPYozp/tUwjaeK0bxtESucP4jBhbkfoqvWCRBGMh6DMBVyaXdN0Vzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870224; c=relaxed/simple;
	bh=NdKEYU7SSmomiQox6PG8vZzeDfCa97hRQnFFhOzpm54=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SmwV2oaovfLTBumvYyma6RYp6R+kdAr5qDj9FPKYoQ1MVFqJcAAhu/QP/tFoAdM9T5doS2eZoxmBMQ8P6F6i6NiRnvO9XaXcMYV7uVF6sfB7ddifzAyYERnIUdc4yxCtX7AggLqCjzMhw1vXUZ4PJV5MFVDqC7f6XUD2ft5+ZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BV/VLkhq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460ab1bc2aeso13056491cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729870219; x=1730475019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/0gSt9Zn5voS0xYF+67Tc7RHamS0uLc55qNVJevcTg=;
        b=BV/VLkhqaFKjdf6lWrfAjTUpewRJYfdpbz9SBGiBE08cCyXoYYrDnSRK7FW5l8Pd2I
         sdD1wbOxtuo4Wt/uK4RV3+tlDzeG/dRI/RmxKY478pZ0w47vBvO5+Ql+w6Bl5A1kIuTa
         x4Q9stcoMWsvq8ZFABu+tWxNAgqeFVpftrjP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870219; x=1730475019;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/0gSt9Zn5voS0xYF+67Tc7RHamS0uLc55qNVJevcTg=;
        b=ZiN8Ewo1PuPs6DgD9+Uxz0l6yX/Ql6jUvyU6cHYS7uxT+g060uqp90QGGDrT6lNkLx
         jknKAzh3rn0nXz33f13TOe5IRRpinPjn4ODrqWnfjC8vnv/BUFB8jAs2hDiZoJvYl8S4
         3PnMBjJjQxgRdW+INjdotGWSo+YwC65tfUKq3VRBU/QQP2q8nogPQA4+vyYj/KV/jt4l
         c9+8QOYj0hcc/tT1CscpoCPfDZSk/KU3bezyNMYStSPNGW35PtvXoEZ8ZYlmHDnw6Axg
         RLsK52fbQdeNIttqu6ogB/cUrnbeH/Ag48qdyGwlUUunroTLzWXtNQPoyHtsRvE6tr4T
         8Yaw==
X-Gm-Message-State: AOJu0Yxpo6IXDfpiRlbhycZiPSwMfMvN+bvzXdGjrXXlSxaHzNg3moB9
	lp82kVbjTeGaUAI5m1Coj8ECikkMqoY4tbgkbzbZok2k9+VoiVhNaF84IF0rulTwXn5iaCKmnGp
	8PYFVaQnw+I58ftDOIY5poKBbaJuhQ/nfIvDZmOwd3YQd0GSamRk=
X-Google-Smtp-Source: AGHT+IENPXL5kBY76KVgzzN5iP+92toLqFuO5GmVpaPEr/KAjSQrgUt7sY9WE1S/LY2aq+ByXCkrXVad7005xbl9STI=
X-Received: by 2002:ac8:598f:0:b0:460:e633:556e with SMTP id
 d75a77b69052e-461146c5a31mr130256971cf.30.1729870219255; Fri, 25 Oct 2024
 08:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 25 Oct 2024 17:30:08 +0200
Message-ID: <CAJfpegsjHymOXg++KGrwMUWAP4e18aqWCMC2e83hLBy2AvYZyQ@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.12-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.12-rc5

- Fix cached size after passthrough writes

- Revert a commit meant as a cleanup but which triggered a WARNING

- Remove a stray debug line left in a commit

The passthrough fix needed a trivial change in the backing-file API,
which resulted in some non-fuse files being touched.

Thanks,
Miklos
---

Amir Goldstein (2):
      fs: pass offset and result to backing_file end_write() callback
      fuse: update inode size after extending passthrough write

Miklos Szeredi (2):
      Revert "fuse: move initialization of fuse_file to
fuse_writepages() instead of in callback"
      fuse: remove stray debug line

---
 fs/backing-file.c            |  8 ++++----
 fs/fuse/file.c               | 18 ++++++++++++------
 fs/fuse/passthrough.c        |  9 ++++-----
 fs/overlayfs/file.c          |  9 +++++++--
 include/linux/backing-file.h |  2 +-
 5 files changed, 28 insertions(+), 18 deletions(-)

