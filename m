Return-Path: <linux-kernel+bounces-260156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B993A3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4901C2282A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC028156F40;
	Tue, 23 Jul 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TldAeWz0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E71534FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749587; cv=none; b=q1gEnjZztkn1dh9hahIx8zUloBg2Ip+GBz2dgehNyaD8d7046TojQRCLnb0WPoCIpCZbpIQJyMgtvfI01072Mlb2xYro1q+18Z5qLKcmGHM9Kos3vMNZ3UDEtHGNKmmzKVmgT71u+9jAAQa4F2T1lxXDcVjcYS7rkeicrlShMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749587; c=relaxed/simple;
	bh=n9k+2NfUwYAQsfwt62/90sKrf3xEsOAQoIIc3U+Olqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GHgfWOpuNmDMh0MGhFMW0uPwh6FbScsaSsZvbWZsDquLVn4YGInmeqZWyxqPhV6dxb78b8Bi4Z79iYJfDgGbVZIUujpUWF/fMVA/Q6008sOV5SqrrpfpgTN6XIrEpVfP7Jaamb61vzKHuOGztVaBVf4d4PqQWn/vDFGy4G+I5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TldAeWz0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efdf02d13so4617786e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721749582; x=1722354382; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mh6odsW6uxACEx0EwwAKle+a6OcUyNx23L6vxbPv18A=;
        b=TldAeWz0oyvLmnJac4EmR01tIbyUYiVcfugYsvWhqSDlY8cn/UuwnPdIxepapejbdn
         sED4uKKWAhcCNSl4lZL0kez3mb/TuBf9v7Vk0nmrmoacsaAOHSO8CTZkXmAEkaOA9AW5
         +sggVDX+7iAPKzr1h+xv2ZTuLHgOFrj/JCqZ2Ch1UO7yBsdwHgANmRNmU10Wt/sSUBhJ
         +3iQ0dZOguTVTjMq8Q8hq0nrlpdzJLAVHKDJX37fKuR2lSn1yh2zbGJM++LxA3eCMO//
         VenW32RLxUt1s/lpJkquV7t81mhtoeNoUXRS44v/hh9AiJtfZcxXksI7I1/bcfUCzoYO
         kzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721749582; x=1722354382;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh6odsW6uxACEx0EwwAKle+a6OcUyNx23L6vxbPv18A=;
        b=oEIIEoL8y3xPrQ4QJMHQKgvR7sC06FT4RRza0WOBZM0WfLXtT4MR20hWJanLFM32Pa
         jO3AIg/txCJfrYXvqYMuCQulvpV4l0HzuY4ZkWHZRrrMnjW3ZbrQBm8QKAOEP8aYqafV
         WLL2ZouksHn/ocjysBs+Qk/+/RrkNtENSYeUocytgUbZyCGBotx7HzrrvA3W0Jb2ZbTM
         DJ2bUTOl+SOnYhdH48VhLaJFmpO+dpxC8mgEB0RDoH/OIBbpmlfHl/v3ChOqNlQ+8Fdp
         HPd2ZqTFfa9hS3Grw6k0M33Mz3xisPkrfR11119RlDaszaV3rwvdxJAP3ptRJE08VC1K
         CujQ==
X-Gm-Message-State: AOJu0YyQ0fRmiKtbP8NDJIxbhsSH+uBA3Kh8JVYl5psWmk3EzzZMhY3B
	VlYkKElK3vydmzdLnQV6ykud8vZdyNDwoE+aj7tbmD1pcfnV/kPIx7sfBCybclY=
X-Google-Smtp-Source: AGHT+IGXlfRBTg0MuxQefaLDsxLB8y698/eelH/tnQHnPLIzxwxu4pka+iKxp6ILM/yOCmkcwnxexA==
X-Received: by 2002:a05:6512:32c2:b0:52e:9808:3f48 with SMTP id 2adb3069b0e04-52efb6324b9mr8563007e87.21.1721749582067;
        Tue, 23 Jul 2024 08:46:22 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7bde59sm555847566b.74.2024.07.23.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 08:46:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 17:46:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 6.11
Message-ID: <Zp_QTDDsvyPtCgrl@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest changes for the kernel livepatching from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-6.11

============================================

- Show also patch->replace flag in sysfs.
- Add or improve few selftests.

----------------------------------------------------------------
Marcos Paulo de Souza (1):
      selftests: livepatch: Test atomic replace against multiple modules

Petr Mladek (1):
      Merge branch 'for-6.11/sysfs-patch-replace' into for-linus

Ryan Sullivan (1):
      selftests/livepatch: define max test-syscall processes

Yafang Shao (3):
      livepatch: Add "replace" sysfs attribute
      selftests/livepatch: Add selftests for "replace" sysfs attribute
      livepatch: Replace snprintf() with sysfs_emit()

 Documentation/ABI/testing/sysfs-kernel-livepatch   |   8 ++
 kernel/livepatch/core.c                            |  17 ++-
 .../testing/selftests/livepatch/test-livepatch.sh  | 138 +++++++++++++--------
 tools/testing/selftests/livepatch/test-syscall.sh  |   5 +-
 tools/testing/selftests/livepatch/test-sysfs.sh    |  48 +++++++
 5 files changed, 163 insertions(+), 53 deletions(-)

