Return-Path: <linux-kernel+bounces-278622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0E94B284
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A3D281202
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F551534EC;
	Wed,  7 Aug 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOo8tj1A"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABF146596
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067956; cv=none; b=esZ+cYYisfwx4xZyP2w8yEFaD5C4ThQvAwRPPm7JVbE4HQ9NtvChptiuFf7Dj3tTdACwWBcr1EMcfgyfGpIS/SW2vmgSeJVyLfbDjA1SbORI+uNyhBLK9SexHzTvXzA0VIA4xEHlUpOUuen22q/qHSlf/2qVLqwedARES/gd1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067956; c=relaxed/simple;
	bh=LXFTv0BK9Iffajc2/i1PtjtI69HQGOGoDpwrOPWu0vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UcYaIfXpgbGHkAzciESOW6apJVgiKSV05hQd0ALPL4+Tb/5576HI5rO00E06OvYGbxmwYtr6zOxwuRfyIjuIAGfHwqtexuOEQenY89lMjkYCbODSHaAGihfB9fiyRUb1Wd1gKa3jaInwko5XKciyKUx2pa2W6uXEKU9r6K3ss8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOo8tj1A; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso336340b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723067954; x=1723672754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxDzmKdqcUtJZTcycGOXStgdnD7iuQY3wxJVwQ+aWpw=;
        b=GOo8tj1A17kuHxnVV1Zg0g1uJ7B1+UFdGB9rqjSRT0gPra+MFKTnfB5STPN7pFdxWU
         +PzhAtdv6iLuoJ1I75o4e7ZqHHcTRuz0meayCbyfpKhm9dI2XPNOL4s4/SRhF9pr9jhF
         XHC14lBIDLbwLu7w250B0ZKXCfnsTRW8s2O2s9TVAJJEuuf3eWKju225ONJ1sp4iwIh7
         2R09EYD8G8p899RcYjyS0SnKkLW75ZklP+Wa5XGniy6BpiB6fRuGBbEYWyCvu7w/ppjh
         mg4hVin0I2CwH8mmx8K94mXSe2TOUJAHY0EqgSw7h42DWu17/uIqzeTtXiFCpqkJ8oQ5
         Ngmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067954; x=1723672754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxDzmKdqcUtJZTcycGOXStgdnD7iuQY3wxJVwQ+aWpw=;
        b=NMq5nCBG52ddx0Ei2wILwVT2R1TBlPTf8LPXEKe6Bl6yxWR9edpwd1YpsHKoFdMZIG
         5NP6+8w9LFODHrK27suu05O0zYvHTB/rdqDCERtce/mjL7IXGZXZ6+V4MC3RJnyXyn9G
         F/DO6xG/5tHZ9Zlb217xwXaa73pL//VrwqApcxWTl0b1HkfFqY92bhKIDEVVdu1/Voai
         ROTN8KO0pkBIsn9oAkxfMTXTqAby/jSvHLnGaEhut/j8Kb47NE2Yq85R4kAjZIJp4SeJ
         muhfaA7V6u3k9XG20/xKja9iv74tQmMgb4OaU1+vrnyrp56JWBnxcWeVeyngY5Btja2l
         ODkg==
X-Forwarded-Encrypted: i=1; AJvYcCUkc/TLgjC7JIof7EbXzLCuCCecYcRBu4LYE6Umfv2U2J+t5MPenAQEWVQuFmBXvUtYgQgaNlCL/srBE8DVYxpODh8u6JMrsJo2S1Yn
X-Gm-Message-State: AOJu0YwDgL/7N0vxGlshBpZ1lBU5gvDH8ji6MZ7TJbu8eGuW+ojRoa2K
	KG234G7saqnuoI/eQq7/hDoW55LtmOn27BkBUITx0AI79NoLNR9u
X-Google-Smtp-Source: AGHT+IFYGqVS/K51ggCR3u26GIQcG9UZvTeioqf0950X98wqlmAMKhuS+DQUIzv6+k8/rjlQITQSlQ==
X-Received: by 2002:a05:6a00:2e1b:b0:70e:9213:f321 with SMTP id d2e1a72fcca58-710cada71f7mr44542b3a.14.1723067954434;
        Wed, 07 Aug 2024 14:59:14 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2d544sm8842695b3a.187.2024.08.07.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:59:14 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	justinjiang@vivo.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v3 0/2] mm: batch free swaps for zap_pte_range()
Date: Thu,  8 Aug 2024 09:58:57 +1200
Message-Id: <20240807215859.57491-1-21cnbao@gmail.com>
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

-v3:
  * collect David's acked-by for patch1/2
  * further refine the code per David;
  * fix a corner case which might leak swap slots, thanks for Kairui's
    comment.
-v2:
  https://lore.kernel.org/all/20240807082508.358322-1-21cnbao@gmail.com/
  * cleanup the name of the instances of swap_info_struct, per
    Andrew, David;
  * refine the code to add fallback in the batch free function,
    Thanks for David's suggestion.
-v1:
  https://lore.kernel.org/all/20240806012409.61962-1-21cnbao@gmail.com/

Barry Song (2):
  mm: rename instances of swap_info_struct to meaningful 'si'
  mm: attempt to batch free swap entries for zap_pte_range()

 mm/swapfile.c | 410 ++++++++++++++++++++++++++++----------------------
 1 file changed, 232 insertions(+), 178 deletions(-)

-- 
2.34.1


