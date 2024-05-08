Return-Path: <linux-kernel+bounces-173141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CE8BFC17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8023D281136
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6282D93;
	Wed,  8 May 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw0qPfqt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E182D82
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167859; cv=none; b=KH9ZklnI5CBG4a5qzdPlPsk0VnDxnIvHY+TiTjDtAmKlJgaQ2LE/jwXAxg0zSL8yshAPGfRENe1O2Mhu/R7o+/DFjKB3Ez0tWapJsYfJSeqmYt0pJ1nWLJk2Ny3XG9mHccZ8NvFxU5vZsQLDSdapbWgvhKlkRuHRXZhLZnFJ2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167859; c=relaxed/simple;
	bh=Quvf2rhIwBNlcXv84WWuCXyyRzAbThKNogCt9oJBlZw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FX19Z3Ty5mZNKUOoN1kZmOGPVhHVDl9YtKA27ETQZC7h45I9fUUjWeg3ikUmP4RTimi/R+tTpqEnEDQZnmA27eGLE8ALfK4nQdNrvQHDrl5FsVxWESMq7p2ZXkOAGvLS8tRuCOA9HSkaA/j8dYieTiRyJ9WSudn1MiHGdhd3uew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw0qPfqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A82C113CC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167858;
	bh=Quvf2rhIwBNlcXv84WWuCXyyRzAbThKNogCt9oJBlZw=;
	h=From:Date:Subject:To:Cc:From;
	b=tw0qPfqto92QcebQLZ3XpTvTBoT746ji3BLslUnTGB2A3Fpzp41Cn5oAhLtrIM1ms
	 v4JAIULWCTqym+NVsDurZm12E1wSKV9XiubYiE8ucLBNDTjBYrvgWfWv6UNSJ+49SQ
	 mXZ7ZXaM7I1VegxLmj3QbO0IVeEMVXIYHKtVyuAeffYyxeRvQhFh3pvB7J9NCBQNxG
	 UZPCO1k4MDwwmyRRzTua164aBixkf5aDgOI1cUW2p47ejpYzPI8QE+xzQ9FI9wQCsD
	 d3uyAsfftZ5dt1UGEPdfQ3RsRbzLhuDGc7U4g6EzfM6G52j3N+fF5VoWGl4AZgXBkk
	 j3g2ijhLQA+WQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b1ff50e8d1so2321105eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:30:58 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyp2ncH6lyDAKpKbgh760XeUN3G/k3jNVfF/NgkHqzCZIMb0v4j
	sFsILk5RSZF9pWarE1Jt4r/W1tGtmU6tz49g3/GuDk6Wq9PzeCErAzX3wojAaQv0awZcRMZQ9c8
	w/dmS91fyAr+NSpbFUWx3Va8j4Nk=
X-Google-Smtp-Source: AGHT+IG7hDzIgJ3coiYNWDTz4GfDvFXdMt4eDwqxH7gOU+qXkxCXcqRRKBWXzARYpSn9OOqqWpAiom1KEtEuROcRmho=
X-Received: by 2002:a4a:5441:0:b0:5ac:9f22:2686 with SMTP id
 006d021491bc7-5b24d77d994mr1908653eaf.5.1715167857756; Wed, 08 May 2024
 04:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 8 May 2024 20:30:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ot33DfFt4394TSAVhK4zSY2J5RPxM2sMm8xBujaXrxQ@mail.gmail.com>
Message-ID: <CAKYAXd8ot33DfFt4394TSAVhK4zSY2J5RPxM2sMm8xBujaXrxQ@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.9-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat fixes pull request for v6.9-rc8. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.9-rc8

for you to fetch changes up to f19257997d9c31864b4cf3fcef6e2d2b9ede148d:

  exfat: zero the reserved fields of file and stream extension
dentries (2024-04-25 21:59:59 +0900)

----------------------------------------------------------------
Description for this pull request:
- Fix xfstests generic/013 test failure with dirsync mount option.
- Initialize the reserved fields of deleted file and stream extension
  dentries to zero.

----------------------------------------------------------------
Yuezhang Mo (2):
      exfat: fix timing of synchronizing bitmap and inode
      exfat: zero the reserved fields of file and stream extension dentries

 fs/exfat/dir.c  | 2 ++
 fs/exfat/file.c | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

