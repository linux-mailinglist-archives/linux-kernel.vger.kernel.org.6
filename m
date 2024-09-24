Return-Path: <linux-kernel+bounces-337174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183A98464C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064721F241A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDE19F12F;
	Tue, 24 Sep 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/S4wPm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770811A76B4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182819; cv=none; b=q9NjxsB2hHHb7vskJzTZNrxgvxa8RbexPdt5eDQSULonHWdfGi9fiuJlzfO3Gg2FaLEwjyFKAndB9DB2O6Lrj8YmoMpVAolkxJ51u5mWbKMwU9YZedFeIq8QmzjUswrS7LNfs9Rsjng5WU5jbwZPwHEw+QaK+ZWnQUamPEXE1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182819; c=relaxed/simple;
	bh=XhT2pXIZ+/NQQhlgXLA+4UivQekPRug6Jme2Zf+Uk6U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q0BxjCGkR0pRtaoGzyTHbuQH4OSz+RyTP9VZ5ubAzkS0YhwjnjQwt4dWtWy7w1+p0GE0ZI7dKf7VTM9T1iOPJZIg9YFpxUOpM3YfCv9c6YCf9yLD+nIsVsT4NFH1YuIN2DxgKfzjBkYRil3Y0vhoNRYn6srosLZXxnonKRxYz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/S4wPm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49526C4CEC4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727182819;
	bh=XhT2pXIZ+/NQQhlgXLA+4UivQekPRug6Jme2Zf+Uk6U=;
	h=From:Date:Subject:To:Cc:From;
	b=m/S4wPm6rTYGbsxJ1cQdhyt7r4YxLrNOxtMw7Pdrq+JuNPuEA5zRGIbSrIn+mAlbh
	 25/wQ0YiqMD0mKChNLtKt0ojvsVR93+Vmar7681cAFv+JvkvIg/wq6PaFNwUQ7BsSc
	 lAlUz4LYlc7UWSivdm5JnWjE3oyAQTEmwu47HMVGQtXnQjRk0/oOnmhqRmJ7w2WuLh
	 3o0b/6uvrI73qbYu313EiLStCojrRXPHyoZs7FQkXhfYZgxmAqvMIrwiyz/EHhMxDJ
	 q3bEX8zj21Y5LW6T2FBEHJvq5k7l4bTo8Ziq7CooHTa3Zy8hkYV5dChAkoFsa/htFk
	 IOPXaBl2MQPeQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-710e910dd7dso2996495a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:00:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlhFQJ0FITpGxRCY3BDpBj5jbGfJwEQ6QQtPdCPHn7LA7brce4
	uNZTLZj4qzIww67LOwPffvKlZXNh19TZ87US5Pn4OkzI7S/P2GyDRz7U2v8UmTiBA35Feci9veS
	yR0Ri9qEmaTdhvhcwkSD2dY+csl8=
X-Google-Smtp-Source: AGHT+IFqBcr7FjbbsuCBDLP0K5jsHQrGvgBYFV1ej8pXe/cVvaGldv+vSwz1uxWclKpuI7zMwEoK1t4GLaR5sTf1UVk=
X-Received: by 2002:a05:6870:a901:b0:27b:5a02:f940 with SMTP id
 586e51a60fabf-2803cfa6789mr8541055fac.23.1727182818621; Tue, 24 Sep 2024
 06:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 24 Sep 2024 22:00:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9NGv1D0A-B7T67nK1Md1XYeLH2hjC-H1q=9jF4rFPcUQ@mail.gmail.com>
Message-ID: <CAKYAXd9NGv1D0A-B7T67nK1Md1XYeLH2hjC-H1q=9jF4rFPcUQ@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.12-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit a430d95c5efa2b545d26a094eb5f624e36732af0:

  Merge tag 'lsm-pr-20240911' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm (2024-09-16
18:19:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.12-rc1

for you to fetch changes up to cb7d85014fb1ca3387f7ff5f6067337b3d7f3c5a:

  MAINTAINERS: exfat: add myself as reviewer (2024-09-23 21:38:15 +0900)

----------------------------------------------------------------
Description for this pull request:
- Clean-up unnecessary codes as ->valid_size is supported.
- buffered-IO fallback is no longer needed when using direct-IO.
- Move ->valid_size extension from mmap to ->page_mkwrite.
  This improves the overhead caused by unnecessary zero-out during mmap.
- Fix memleaks from exfat_load_bitmap() and exfat_create_upcase_table().
- Add sops->shutdown and ioctl.
- Add Yuezhang Mo as a reviwer.

----------------------------------------------------------------
Daniel Yang (1):
      exfat: resolve memory leak from exfat_create_upcase_table()

Dongliang Cui (1):
      exfat: Implement sops->shutdown and ioctl

Yuezhang Mo (5):
      exfat: drop ->i_size_ondisk
      exfat: do not fallback to buffered write
      exfat: fix memory leak in exfat_load_bitmap()
      exfat: move extend valid_size into ->page_mkwrite()
      MAINTAINERS: exfat: add myself as reviewer

 MAINTAINERS                |   1 +
 fs/exfat/balloc.c          |  10 ++---
 fs/exfat/exfat_fs.h        |  24 +++++++---
 fs/exfat/file.c            | 110 ++++++++++++++++++++++++++++-----------------
 fs/exfat/inode.c           |  94 +++++++++++---------------------------
 fs/exfat/namei.c           |  17 ++++++-
 fs/exfat/nls.c             |   5 ++-
 fs/exfat/super.c           |  41 ++++++++++++++++-
 include/uapi/linux/exfat.h |  25 +++++++++++
 9 files changed, 200 insertions(+), 127 deletions(-)
 create mode 100644 include/uapi/linux/exfat.h

