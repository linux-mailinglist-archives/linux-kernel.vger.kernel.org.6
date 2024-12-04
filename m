Return-Path: <linux-kernel+bounces-431445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377E9E3E91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98F8B2E462
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558020B1F3;
	Wed,  4 Dec 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+2W/SP/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A71B4124
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324249; cv=none; b=nxPIjvwdkCjrV24tyToava0ClztDP0gJG0aanAXDdjbQinkXE1EFrD5lK7U410oUXIRp3dSo9dw5+DnCi0nwqTXmjjRWyX1+gUduNZM9ptfRrh6SyR80jwEnCY5pWfk95Q+CZy9F4lLuxv7lpvIPh6TBNNh2TjK3NTuzTiyNmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324249; c=relaxed/simple;
	bh=GEuCylRtOd7Usloo0EEytk0DH26Xelwxn0h3r0Wwvvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsrlBHYvCmW8sybKvVFyyitOS4BkG2CXDWqDzv7ZBm48D0egKbSCccnGIDS0Mne9ROiAiYj/whwgu25qsckJq1l355BG7h61+7/N87DBGDp6FGIovxhUN/JX0E1GgR1Qq87TaKfv2//yPM7ly4cUYgl7AOzL7NqYm4Jfe/4apho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+2W/SP/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so56920345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733324246; x=1733929046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JvEa9vsa9JdRBPOAnu7Fa25rHqzBln2moKCPZNdENU=;
        b=S+2W/SP/wqgTb2K+2ErPAzsWT8UOsztdRiM4+eJU/qswcyzNS7654O/Ptc/dplHQf9
         LPmEFCSsXjrdIWP4C1OAIezDBaTrbvtZzFVU4LxkrhjBIvHIlvP8I27OdTM26FA51WOJ
         KoCf/fyhbJQdENtLkHUIFynUm5c1xsV3JwwXCX6kBcKfh9fTDRx4LXAmdrui694nmL71
         Pgv7ErI/Vv6mFXhGpGS91ysl953KxUtp8m7JGR/hA+11TY3P02yalfC72Y3PjISrgRvs
         hKOsPFK3s/lRL3C8vFtNWTVldBEUbZD1AIS1ozrX3DAVyndVs6CP/Wqm48putgFeZH5y
         uZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324246; x=1733929046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JvEa9vsa9JdRBPOAnu7Fa25rHqzBln2moKCPZNdENU=;
        b=oB38G0vP7ZumZJ2zB/+oUEBVlADJjnENz/KKXN5l1c4uHOHvwZ0vLlpaGzWqPIr93i
         VwsXhyCfX+IMJak4Mnx3yiP4tSm8l9mVW9MKYT7pVwndMqxq8nn4GqgQKiawfhBk+JE4
         AR6C4WVHMDcYBD3hNEPB+xCEvtnb33rRt9FNV/zduUoAlG4mld+BzRyGXRVALugJavZu
         S0lD9TJA1tYPJgRkh7trBeMmZ1bVwEm1hnYS9MHHbrBj9LN58Xv0zRc2mttoFks1jmin
         vGn7J/X968j0DtSRQ3R1aRM/icUNN8uaXs4VA0wT9SDM1sTl8qdaAeeb+1SrY8rMpvQz
         2rWA==
X-Forwarded-Encrypted: i=1; AJvYcCWj/rT4ANn9IZwnxkPnqGV0Ih5OmykYxOCA9c535OTt+qwszAfh+Vsp01do8RcPhEjmY5txq3bhloLrXQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5f2XhD75Mccr7gu6VbSHJQvQf1n374mqbslK47hQqhDRhgDN2
	A/WygzkVJ7LRHDy3F4OQbepSNn2dp2EgYE5TKIaEUQMrdVvg+yX8
X-Gm-Gg: ASbGncsWc3pdlsoNNPRjWzjOQhatf0021Aq4ZAlE+HfhfxcTBmdifI7x1Y97xPuSGAt
	35ros+IQvi0LP3qL2/vNa143Qg4JmmFgt3b9QscWCKDKGZ31rns/iZ/LAYO7RPNfz7ZAzxKG6p1
	bOqtSAFEkoOj2X8KGbBwheG8Wgr0NmjK7wl2iqoKUrfTihyHHqJEtgfuOyaBZ3scAi+CPQkpFrE
	9WIwLalU7nqUqVA2tQ2JpCq42dtU5X4i8YEg5sOM57EBS1OslsdHNkesGrnYcFwfTVjK6dzUzu2
	V/XcGpGfOw==
X-Google-Smtp-Source: AGHT+IG6VCtwNN3Dh0zaDip5JgDiDs9TxLrgWM0X8H3c3JbWn35BWZOqF67YBwEV0ftj2+qLhx96uw==
X-Received: by 2002:a05:600c:3ca1:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-434d09ce1c7mr63470375e9.18.1733324246421;
        Wed, 04 Dec 2024 06:57:26 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm26678955e9.13.2024.12.04.06.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:57:25 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/4] staging: gpib: Cleanup and fixes for lpvo driver
Date: Wed,  4 Dec 2024 15:57:09 +0100
Message-ID: <20241204145713.11889-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the accumulated patches for the lpvo driver
Patches 1 & 2: Remove redundant includes
Patch 3: Fix protocol constants
Patch 4: Fix unreachable code

Dave Penkler (4):
  staging: gpib: Remove useless include
  staging: gpib: Remove duplicate include
  staging: gpib: Fix erroneous removal of blank before newline
  staging: gpib: Fix faulty workaround for assignment in if

 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.47.1


