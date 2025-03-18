Return-Path: <linux-kernel+bounces-565490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D2BA6697B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE917C1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEC1D6DBC;
	Tue, 18 Mar 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqTdv+WV"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B703198823
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276187; cv=none; b=c5Acc0ckKGsZjP6JpQ3gbA71d2JpiT1SnhYS8FnIWRqhX/J4dz67flo4oriRT3dDSxam0IxuBGrPOj36GpPdD9IDBWr2J5dWUDonEi0V3+sYFbEkV1IhqCtWM8idLj0H38G9PjUguQDKAWOVeyWZzJc9DaBRxb0hXYBjHIVjDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276187; c=relaxed/simple;
	bh=8oQghyez17aH26kMvp2RD24R4kX2f6/H/4UC7Q+V39Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+nE31O5xQiCfkkF5qTUvnqVQ6ZtOxxA1W4yPDTiY+lwXaBm5avN0NkSzCXdi2Tta4bkD7e1fp9ova75LxYSq4Tn42mOWogVblh4lbenn5yrCu0gSpWcFsJ5rOtcaRIXlmJ6iiSLMRy9pcT7j4vejH02ng9SgyeZCzAUfSr0FTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqTdv+WV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224191d92e4so98789505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742276185; x=1742880985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQWQga54dvDSkq0vaFiXjWbUXDkOKyh1NJzeCcOJyv8=;
        b=KqTdv+WVakWNlCZ8+UxacLBstzDd2WzU+Awxdc4PYdJ5oJchxFAazlM101gSunrFby
         dAjybdR52rEPFcsN1gBzlwN8myxjB0xnN0l/dUNj5qL0WDw4C0gGKw0kUHpZ7dsecHkK
         YynOcOyul73uFGILp9G+Cr1nJ455nvallpRXRaMxZxrzYDlGtGwzNikIY4XUV1CFCIRJ
         xSYxCmkva7JI6TWUbbipdvLEe6/8Ld3yGAahehySvLZ+azSYpXU291K9KyGanD28fg7H
         lv5SPbrvulxrGc8oOBXTjUpmYrQJG0rn2+WN3lTIC1cQ3/d953fWI6CNLiP/b5p1Hria
         GaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276185; x=1742880985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQWQga54dvDSkq0vaFiXjWbUXDkOKyh1NJzeCcOJyv8=;
        b=hcwrOGtat7/vYej/d33DEhyhH5aIS5Z+tOz+fnwT/LX8aok0HWKAzwCz0SFuSoyE/r
         7ZArBtmXuVHqEGQAnR7QfBexVTfMqgpVfm7ip5QNtn665FAJ1ocMYlzAKxP8Df/PTEgv
         HrP8leI78KlvtpHKVxTNyYI0CPICzfDTKJLz70/ziWrQF6auzKv3WxGg2sWpYRvdhD/z
         iXeRkHTZXVca06/1JHKUyu1W8AeJz8hYY+XgJ4bQSD0lWv7dcL9oD5sK7l5l4HpAvcn2
         /FMGXRRDFzQJq/ZNns5VZM282XwqcQYPDOXMNlq5U6chvQ2xcOlHfAaa8ybE2TrOXT+X
         PdfA==
X-Gm-Message-State: AOJu0Ywr1bh9P/i7qZUgfhIxXIuVnm/+/17YkMV7yUTsg1HCHnrBPMXM
	dpnnfmarSRk08QvShEBGZgyrS21fPl+F2uCT1bMH8DEnDH7QhRCCKz9LGvyn
X-Gm-Gg: ASbGncsk9OhRJuJxMVX/IH0A/LR4gcWipHRBDT9E4CS9Gpb4Gf7iEOUnJSGo4EXoAxb
	JW7jH2OT84GlMwUdznwT4yDLl0++eS+hBSQ3M7uW5jfM9W0b3S6s9LWdLrGBX7lVUNFL9qt59UX
	Xo+Q2A9x10VdEw89w48wMbDtqAgb3w6kCPLkIhkWfjs5d+HJRByuRdwTwE6i8zVb3bV1u6Ek/az
	vP19LexPPU5I4N/yLM53hPRayjvUBOoJQA0XPXLQOzOviqL9pM9z/O52/PGaVin8nzmLvqZsQO5
	eyedEhUjbuVJw3SN72+npkUzC8vsBpwkKc9s+ASFQ+06uSj0C6m5cYc=
X-Google-Smtp-Source: AGHT+IH70tKMZCZE7xD2wUNKGBOLiU4CUDBB+dxt98kG5w6rN3vU+6NgJt5Bhflzw8skWPeWmXpbTg==
X-Received: by 2002:a17:903:94f:b0:223:4d5e:789d with SMTP id d9443c01a7336-225e0a664dcmr187989475ad.19.1742276185146;
        Mon, 17 Mar 2025 22:36:25 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:dc02:2d2e:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f09sm85299905ad.133.2025.03.17.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:36:24 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 0/3] Some fixes for Silvaco I3C controller driver
Date: Tue, 18 Mar 2025 13:36:03 +0800
Message-Id: <20250318053606.3087121-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds some fixes for the Silvaco I3C controller driver.

Stanley Chu (3):
  i3c: master: svc: Fix missing the IBI rules
  i3c: master: svc: Use readsb helper for reading MDB
  i3c: master: svc: Fix missing STOP for master request

 drivers/i3c/master/svc-i3c-master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1


