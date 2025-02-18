Return-Path: <linux-kernel+bounces-520272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53FEA3A7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A04B173A68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998561E8339;
	Tue, 18 Feb 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvlZjj6X"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC201ACEDA;
	Tue, 18 Feb 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907697; cv=none; b=Y9eOg7qxLD/l4gLMgl19x2TON3kqRrJq+6cRaKP9FQP3/ZeoRwT7RCmXaHUJxBJmuMfWjMc3TsxxAqbsZdKrlBiJ3U9bmcuA2m6DHoCe1Ve5WUAJeMs6pHOvvlOhDZvqW035DS0wfamkcX5giQO/gcn41stLhXu/tiI6n5lfz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907697; c=relaxed/simple;
	bh=5e6tqDFhbA90wBnxn4vrlWthC6bmnqnimz9RdO+r854=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETXwChXoxIN2qoY+rNiZ5dW1bsF1d/I9s7w1DuRpH//2w9d6jR0+F0TzT9XxhQTRSvXQ8rYwK6Xp0lTAg8tJzjWEXxhoffcdWs1iKJB5fIlsFNdc8x0yI8Q2Bwj9nJcU+39direyJRSD6ZV217jl+nxPM3c1mejD5Hahss/H56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvlZjj6X; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4be7f663b50so262240137.0;
        Tue, 18 Feb 2025 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907694; x=1740512494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mvh05rBFslZQy52d5zcT6K6oumSOAQUgZGAs4mHFhbw=;
        b=TvlZjj6X4KovRbSgV7aSODoUpwzryc1NEpqQU4eQuK1jzbHsCW/Kno9pk/ZpaU2KfB
         k97j/LLIlV4I64rK81vUbQZCatGwgvO5OWw3sXZg6wU5X1PbRmOVwuH6U4EL8ifw1kxl
         P2nvSOKhLzo8ieTlbmTRoJgJApMHWzAubRDEMuR8m03J0ZdNawKidCOnBPqoKoVvTB1V
         F/pm0uInQW0dC8ImJgLC/uu53qeVpi6J506FAtxjbYoIjOqi6FvUcJH8yD6DGdeP581k
         p9LBsHkHdtiwDEfrjh9xmWZNmAnl+ece1VOSyNT69dkn3vryvvHWBYboaDAR4o6Tp/vJ
         gCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907694; x=1740512494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mvh05rBFslZQy52d5zcT6K6oumSOAQUgZGAs4mHFhbw=;
        b=Eyy7mf495dWLB5ndPgWqukLJ+ja12eoIbhWjhSzsDd1jLiPDLZlEpav6uXYww6sESm
         Z2OUDxoPhhyoxgDINZ5cEecZ8K8uHvqO/N53Sf6wWE+4r/n5AoX0zmTmGrIdCn4dg/Rk
         LIwCGEeRadGJG3/VbwoF8sDLIMhtWpo46JWd14OrJeC7tcdFGpONIBOwmOrCkeGa+2Hz
         0DHFgu3oOo0qBLRsbdH4EtQvbUq6tfd+g7T0XHXhqJWvdDdSmh4iWVn7/XgcuUbsxc3x
         x/qgQP0CkKwH3SAH5DW00DuF2NlO8HmkXvZ1Pr15ZSSr7D8eFYcaSuXm0pK84S1dH+XS
         w3KA==
X-Forwarded-Encrypted: i=1; AJvYcCUFzMe011M1m6OTRSGP/JfCFgh3KkNc+WkLSjpEOJHinriWONRLw7IHiJfhGw7gPn6Sv3fGsy5SEa8QSSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxFSZbhGOaPpx/JnMSXZ9+c83rjTuB/wpM80sYWxIEBaNxBrw
	1tlHfZTogWy9AKz0s7BxZMDXqRiRxbqAskb+h/X82UJZLRA5wZcu
X-Gm-Gg: ASbGnctXm8YDsZc6il1F4GoopuWmpLkA5Ba8Jaln0+nj0YAuPWowHmrx0fFNnKECRUk
	3ixf+VQl5RJCXMNiwZBg9pWQcQXS4ULZTIBye7XOi3rm56nTnIUNZFnUEDTGt4F/COmGRuZqAcR
	PQalAS8kDGEFjIA9zpSryBTNLIoHLFalHfx3vRBIXbnoGO2VvcLCGzxfjzLsIKZOW3Mcq55Md2k
	ZW3Jt/r7NIQSyDZ3wY9Kt7MwIi0ZJoNJxpJLnvwLDerQKUIMTUHvVelf9IxrZproPvjghYTX++p
	g6+eQHBcRsZa9fW3eWEAXJY=
X-Google-Smtp-Source: AGHT+IGIvk7WpWb15SAmXu09YejHKZsSTBvNpth3sdP4liVVWVCIdAsMZuzaUfAhmHe4zzVWiyyzpQ==
X-Received: by 2002:a05:6102:809e:b0:4af:c519:4e86 with SMTP id ada2fe7eead31-4be85b3c609mr667011137.1.1739907694264;
        Tue, 18 Feb 2025 11:41:34 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc68dd766bsm2305214137.20.2025.02.18.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:41:33 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/4] platform-x86: Use *-y instead of *-objs in Makefiles
Date: Tue, 18 Feb 2025 14:41:07 -0500
Message-ID: <20250218194113.26589-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

According to documentation, the `-objs` suffix is reserved to user-space
and host programs. The `-y` suffix should be used for composite kernel
modules and drivers.

[1] https://elixir.bootlin.com/linux/v6.14-rc3/source/Documentation/kbuild/makefiles.rst#L153

Based on pdx86/fixes branch.

Kurt Borja (4):
  platform/x86: dell: dell-wmi-sysman: Use *-y instead of *-objs in
    Makefile
  platform/x86: amd: Use *-y instead of *-objs in Makefiles
  platform/x86: hp: Use *-y instead of *-objs in Makefile
  platform/x86: intel: Use *-y instead of *-objs in Makefile

 drivers/platform/x86/amd/Makefile                  | 2 +-
 drivers/platform/x86/amd/hsmp/Makefile             | 6 +++---
 drivers/platform/x86/amd/pmc/Makefile              | 6 +++---
 drivers/platform/x86/amd/pmf/Makefile              | 8 ++++----
 drivers/platform/x86/dell/dell-wmi-sysman/Makefile | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/Makefile        | 2 +-
 drivers/platform/x86/intel/ifs/Makefile            | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)


base-commit: a787ab73e2e43c0a3df10bc8d9b9b7a679129d49
-- 
 ~ Kurt


