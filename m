Return-Path: <linux-kernel+bounces-428186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18F9E0B39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8ACE1642FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB81DE2AD;
	Mon,  2 Dec 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSLod5jb"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949217E0E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164930; cv=none; b=XnCay8KZniijyc2aRwiRanOKS4R1GkSUGX1u4w0jN2LXMxsHO+GzSnCcD4WdUJACaQtVDSi+fpthB60eDEPFsDK59TVA051qAwywaaDwiZaWa/EAwUAFZ4byD20ndsIlFJHkvmdTMLl87mauD3eNuTXB7BhMhgg2Bfr/j20YMco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164930; c=relaxed/simple;
	bh=7x3yzKhVQbS0YA9w5EYFBAn/8UDuAGUZhYYCH5Pxus0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6mlitVK61dHLKeiB2E2Bq9ZuY0JKJPx8Ww+4L+1RikMwHQ7H+0SUlOLk51Y7al/Ge84ERrOHjJrjfJC/mDxayaAkhkWe9palbngokCf06jLewmQKOOKpq31cGcKEyBlFg6U7kvlIh2CyblWjUJ4SodoWGLpdXEa9LrP6x9QB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSLod5jb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea8de14848so3019194a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164928; x=1733769728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs1ZKOzA8tmw1x2UXntYJTRjKjlbwcqsiLWIOG3kp64=;
        b=dSLod5jboiGbJ96r9e8gQQpGtG8Dc7Ygd7tp/YhCQ0+d4PzvRZbnJIla7AiIMeB0Ik
         WZ0arNOdmg2slRfoYDdUADam3nR9lMNcrQBrWFXoCz1tJ6BKp+BGFCZzppJ0LAhlpTUj
         ePgwLxeX4HegAy/k8tX6ilPRNb3795Xr3kg7rwXP5vHKvaJt564pya5lLdP7RHw5mqXE
         EzhgU9jaRAtLPUqoLxY/6NPrE/FsmTZn+ZHveENQJZEzQpCAxnDToP5wfroa7oyNSrH2
         wW+3+DP2UkEbwayeaIm7BMjYt69g/ZdY1G9ZEvrjsB1N/H0eMg7C2B2Cy4HVWGDWCorC
         aFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164928; x=1733769728;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs1ZKOzA8tmw1x2UXntYJTRjKjlbwcqsiLWIOG3kp64=;
        b=vaQMYmu1MWh+PkHWQttkW0l006QV23rjEc9+KoTe74WaN86DTlFlgPdu+0q7O1R7wl
         GHEmXYwOlaGS5Piix17ZQsj3hgxOeJkOcb7gPhWqZM4T6b0gTgoCLDxIL9IwSjFaBHor
         5AfgZGzaznyCHeMNbeu4okDIvYtkPZPx9dmFmvR1RCuhLkxYFnROlPJaoWh1ID+7UxgQ
         ek0zeAO6D3pQbANhsYLBXqDZ/pAgQpfDmIlR+R6+UHixw1jwErDmKBOkVm2Mze6hXk8n
         TB26pu7epLhcb3mt0fsfs93bwumIylPXzGGZy/bEluqp3sXQYw7p09/fh3UiAdtFZK51
         w7cg==
X-Forwarded-Encrypted: i=1; AJvYcCV/eT4wgRm6Orsl+oT7TsuqIuIGooGGggsr6iyrxHOisNLlEYNSphgUt02dCsxs1zcK/SuCwUPlI0nKdqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmogouYByHDlJC+X576wbaB53xsAfw9f2oTGATpFDWln3yx6sF
	p+pho7SAZ0bSG1Qsfv7LclB4dcq9Z4Dm+qnPOXRX8ZbBAIjlCXai
X-Gm-Gg: ASbGncvo7f6AIU/WEUa+xCPskr/crluqoHegfcQQ7Z8+87ok1bsOaGEljGh8lssiuyn
	JD0lBKBgUn4i2wsIL9eFRF0kP9pJxM9Ja0W5PL8G89+K9FInavClxTlIxeELq4kQj7ID1lQo9j5
	A3haotrvQ2NLfM6qvAGFyrie3xCcEmDjJ0PJk62RvzFpkw/2W4Kh1rzqI3AlktrDJcU7WhZT68a
	/FJ1eKzvquFKMUloq714UPP+8m/O0iONAU6YWqblE4TY0buKqHHPikjix7ecAVpHWhS2gs=
X-Google-Smtp-Source: AGHT+IHkmfGLXZBCKnLmsARIDeEIAne9TONGGqSftyDIQbDiYw0C3eN18Aa5G9nvW+L9pfDtYnWufg==
X-Received: by 2002:a05:6a20:cd8f:b0:1dc:3023:bd97 with SMTP id adf61e73a8af0-1e0e0b9b301mr36331829637.41.1733164927851;
        Mon, 02 Dec 2024 10:42:07 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7d5sm8849781b3a.94.2024.12.02.10.42.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 10:42:07 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/4] mm/swap_cgroup: remove global swap cgroup lock
Date: Tue,  3 Dec 2024 02:41:50 +0800
Message-ID: <20241202184154.19321-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series removes the global swap cgroup lock. The critical section of
this lock is minimal but it's still a bottle neck for mass parallel
swap workloads.

Improvement of this series is more significant after the si lock rework:
https://lore.kernel.org/linux-mm/20241022192451.38138-1-ryncsn@gmail.com/
But this series works very well on its own.

Testing using 64G brd and build with build kernel with make -j96 in 1.5G
memory cgroup using 4k folios showed below improvement (10 test run):

Before this series:
Sys time: 10730.08 (stdev 49.030728)
Real time: 171.03 (stdev 0.850355)

After this series:
Sys time: 9612.24 (stdev 66.310789), -10.42%
Real time: 159.78 (stdev 0.577193), -6.57%

With 64k folios and 2G memcg:
Before this series:
Sys time: 7626.77 (stdev 43.545517)
Real time: 136.22 (stdev 1.265544)

After this series:
Sys time: 6936.03 (stdev 39.996280), -9.06%
Real time: 129.65 (stdev 0.880039), -4.82%

Sequential swapout of 8G 4k zero folios (24 test run):
Before this series:
5461409.12 us (stdev 183957.827084)

After this commit:
5420447.26 us (stdev 196419.240317)

Kairui Song (4):
  mm, memcontrol: avoid duplicated memcg enable check
  mm/swap_cgroup: remove swap_cgroup_cmpxchg
  mm/swap_cgroup: simplify swap cgroup definitions
  mm, swap_cgroup: remove global swap cgroup lock

 include/linux/swap_cgroup.h |   2 -
 mm/memcontrol.c             |   2 +-
 mm/swap_cgroup.c            | 110 ++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 63 deletions(-)

-- 
2.47.0


