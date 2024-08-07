Return-Path: <linux-kernel+bounces-277544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EBD94A2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0003F1C2177D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514FB1C9DF8;
	Wed,  7 Aug 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjYdWq7/"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE131C9DC6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019130; cv=none; b=lcGs9LLGExjKbQvoQEfDwlftPLBH6Y8LQm0D3aIuMKj3mWDuhWNVFM9ZSfU/xYiNaP2s6PYMh26bgVcp/emwzl7bpje1QQ7nwHPkquYMMt6eRiTRihXaQX4XO8dg1cUHKQ3i2SG0QMgQzi2cRZ+bCae88EFmJjEkPSQ0MXcY1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019130; c=relaxed/simple;
	bh=05rUOREPT47y98cAfRIgwPdy4oZntK7C49vCDSpn17Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HIF9fcYuZQxQFbu+fIXKRS7wy2fMuJ/dh60Pq5PybFLSl9gpUHGQQSgoZ7oPiZZrgqUGto0QZIMGd7Hc2PcGcQzIx3CsKtU8HB0+/2jczsHRAIZgR6i0ryE1Q1QSIrao5M+D/AtqTGe5rSicDuQXF2ZZHse9qUprbbjNy8pdoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjYdWq7/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so1197113b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723019129; x=1723623929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3iK8ZSwBrGI3RfSrcme7sg3QHtVebDulO9FtrVvWj8=;
        b=gjYdWq7/4bd7VfCIl7crzVMAMrgckVKNO/zw4YBSuDZoja75b9hxJ4FPJVxrRgalbb
         FU1EnOxkhnMIcjOEtD08T3VQBQzxE3oJDYeOERfPIQiNtALJdemtLZqBPIVlOq0J8mqq
         NXq7508ZUO+/m/GbAHkCjWCnyCMkQTBbXsD8lUSkppMyRS+0x4gEyIY9ITWQvv5impJn
         +n2lcpuxBGn/Amq2xfKIHHxlR2MAk+rkQE4C9vCCJsiEMAs7l4WQgvVXwewn+zLoowfP
         T7dEqGl4C36NdF1GxeUReB5KHN6VNYzWp5ldL/eX3+9gzr8OQSOJebjF0oQUZXSmafdj
         TqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019129; x=1723623929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3iK8ZSwBrGI3RfSrcme7sg3QHtVebDulO9FtrVvWj8=;
        b=jWuhvjYHGL5Cwd/53eCkzhfBO49yvbQFXkUZkEUl6i7bpE5HPNtw9UrUqJiFLpCeWX
         x9EQy18aEK69V6iNgoRiNEZvaBLWEFLYKmHuLILVtqXbA6XC9yrfVk2J1206IZ5qtdmS
         IEv9bMpxoUWeXgSRUKkpSTPk58HHWSOPIl2wMeUHt1aHfXCLsVSzvKCfUci6K7D7iSW+
         q48BpkB3GbfBW4D9CQ8z1xqPGonBqAifwiiVE9tREKTAzJ1vHmMv5BTE6wzogNlBkOfJ
         vmS0kMkJzFSBv59wd5+q1hnJ+QQhyxyG8VXoWMmGNleYAfiXFQubYIYQBAvyoGefswT1
         lAGA==
X-Forwarded-Encrypted: i=1; AJvYcCXZdGXNRYXxgu8ACwkAvPyERcCdiuVYDhfBiheUff/ySjrav23wCXFYY5UjzI4W8qtFmg6CBmbARYe3oarHMUZjFsu5QWAcY3OUrZ7y
X-Gm-Message-State: AOJu0YyIYyFaVBt+vkf44MHCEhU3BNVyXqCr9DsMK6BwBwYi72XrB8kV
	PNXEg4gZWlsxaBqpeIBh/Ave0+WmYJBGMKLX006A09ZP1rde1ROO
X-Google-Smtp-Source: AGHT+IEPWCoSdIhYPn+ZYc/O4dnNZ3F7X1EL07HeW2rmg/mPGQisz+refjeCJtWvk2J1FNC4oqbbJw==
X-Received: by 2002:a05:6a20:4393:b0:1c4:9ef6:499b with SMTP id adf61e73a8af0-1c6995a01b7mr16907669637.29.1723019128594;
        Wed, 07 Aug 2024 01:25:28 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed0d457sm7911763b3a.156.2024.08.07.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:25:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: justinjiang@vivo.com,
	chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v2 0/2] mm: batch free swaps for zap_pte_range()
Date: Wed,  7 Aug 2024 20:25:06 +1200
Message-Id: <20240807082508.358322-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Batch free swap slots for zap_pte_range(), making munmap three times
faster when the page table entries are filled with swap entries to
be freed. This is likely another advantage of using mTHP.

-v2:
  * cleanup the name of the instances of swap_info_struct, per
    Andrew, David;
  * refine the code to add fallback in the batch free function,
    Thanks for David's suggestion.
-v1:
  https://lore.kernel.org/all/20240806012409.61962-1-21cnbao@gmail.com/

Barry Song (2):
  mm: rename instances of swap_info_struct to meaningful 'si'
  mm: attempt to batch free swap entries for zap_pte_range()

 mm/swapfile.c | 412 ++++++++++++++++++++++++++++----------------------
 1 file changed, 234 insertions(+), 178 deletions(-)

-- 
2.34.1


