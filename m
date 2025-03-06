Return-Path: <linux-kernel+bounces-548929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D12A54AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB249189249B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87120C478;
	Thu,  6 Mar 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X84OlRlM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D298190051
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264800; cv=none; b=KyoOVzZ1Ha1T+DxZCA21rYG+WvYK5zY9iNJBZWj7SzpC4NgQFUfeHwxWwAlxOgu8z8Mz17M4p+++Yb1XG8SsUWDT0HpbPjSdKeFmDuXpbIGhcrBe0DbHMN08Vy17FayVBr8g8/lGZKREIfbX5cKDjJ5eviWKfCGwtZwy1MA6RwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264800; c=relaxed/simple;
	bh=aybyRln/A32pCJSGhznejjlFXAgoU0P45+gRLLlRmoc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k1qwCsV8g8C1/ntQO1bpfrGTAXarZMwAmJnmP6d7rIatnerj4oQtewkz4kc0Tfccu0OlhFRtFx+lzTZR7x2GPRJSd1CTMg2SaRP55+UZnAzG8+TXoMwD0rt5UwN5GyvwQBsjcPZ58uVneP7EiWT56vjyDxkFVKmppX1efkUhU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X84OlRlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD4C4CEE4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264800;
	bh=aybyRln/A32pCJSGhznejjlFXAgoU0P45+gRLLlRmoc=;
	h=From:Date:Subject:To:Cc:From;
	b=X84OlRlM45uFKm6jUjdouTFx0Ix2HUSca7pxReEovsra2UNWY1LGMiQ3bNkwB0fU5
	 XGs3xClWM63agMQz5tOhT9LeqFy2XcCej/NtgHPK3CWjVngjGamaYnaCq+L+tXycSn
	 SizlOAPc4yphSPMvPgkoXAH/az79YSlFnfYoF9R6+a04uNCVbJzjCsknkbSHH5KoZw
	 eoyo09db7nP77a3DasnffaOgQo+CJv7uPowfG1HcRt0ev5PGb4VLtt2Gf1z7+oDdcR
	 0Rioc/lEsRnx5pvGh4EruRhnb/dbMlw4sWd1qAeEl40vu4/Ra09386Ljvk1zZ8fema
	 CC7zofXiIAC0g==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60009c5dc26so330872eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:40:00 -0800 (PST)
X-Gm-Message-State: AOJu0YwvXyJNM5hfIpl5DJMSpF6gFJkc6NOLTIJlZQ1y7E6ws+0NITNw
	BIeAmPtB/HKXzS99e1lR1FnPGgXUBt+n6Br1Rc5cDc9hQUjBdy5oxE8EdXptCHfNBm1BQD/Kva/
	+02Q3A+9G1fxlW5mRA7nH2vMsVDA=
X-Google-Smtp-Source: AGHT+IHWT1bvpBV0s3brBBAZUN5ZQI1Jfn8v1e6P1PlEv/S8zGNBzpPjiUJrB9UD6iXq8DiwpxUC0m+rw/fX4Ik6Mr0=
X-Received: by 2002:a05:6820:1795:b0:5fc:e323:785e with SMTP id
 006d021491bc7-6003355c8c4mr3266020eaf.5.1741264799765; Thu, 06 Mar 2025
 04:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 6 Mar 2025 21:39:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8_VoQiC98Fck8=uBPAS4A5GRurhbZHPBX4EVspZHe+Gg@mail.gmail.com>
X-Gm-Features: AQ5f1Jo50VGN8xFIn1poa8XGCq5HY9dSz8K4dWaB2l_L5aYAJTsSwq8WgPc2VuM
Message-ID: <CAKYAXd8_VoQiC98Fck8=uBPAS4A5GRurhbZHPBX4EVspZHe+Gg@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.14-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat fixes pull request for v6.14-rc6. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 48a5eed9ad584315c30ed35204510536235ce402:

  Merge tag 'devicetree-fixes-for-6.14-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2025-03-04
09:04:29 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.14-rc6

for you to fetch changes up to 13940cef95491472760ca261b6713692ece9b946:

  exfat: add a check for invalid data size (2025-03-05 21:53:20 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Optimize new cluster allocation by correctly find empty entry slot.
 - Add the check to prevent excessive bitmap clearing due to invalid
   data size of file/dir entry.
 - Fix incorrect error return for zero-byte writes.

----------------------------------------------------------------
Eric Sandeen (1):
      exfat: short-circuit zero-byte writes in exfat_file_write_iter

Namjae Jeon (1):
      exfat: fix soft lockup in exfat_clear_bitmap

Yuezhang Mo (2):
      exfat: fix just enough dentries but allocate a new cluster to dir
      exfat: add a check for invalid data size

 fs/exfat/balloc.c   | 10 ++++++++--
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/fatent.c   | 11 +++++++----
 fs/exfat/file.c     |  2 +-
 fs/exfat/namei.c    |  7 ++++++-
 5 files changed, 23 insertions(+), 9 deletions(-)

