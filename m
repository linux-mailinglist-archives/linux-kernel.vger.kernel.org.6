Return-Path: <linux-kernel+bounces-340929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6185987924
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DBB1C21A09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541C166F14;
	Thu, 26 Sep 2024 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3zV5e+K"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297813777E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375801; cv=none; b=T00L0UnX1IZqNv2WyZr/5TjtcpcaUuRNwLlCVK8qU1a9krf8NXgJvx3FCL6fBwUKJJLPX23GWlrrkdQm3f5hLYC9ev9ZMRuS+b4xEYQzoUYszI1BwosfJio/oS62aoTVyLNkNOh87b0JePYWG5AY6HAgI5/g7NSKrgYS0RQWcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375801; c=relaxed/simple;
	bh=3ruPZk4F5vqn7x1Xjix/frplXD9KxRqUfI9qf1duV+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3WxGzYYlY/+ixWatKVe2saEx8DIWSnepC8nkdMFSOUSTKI33fKymKRHQxjq8PSED9iApUsOtOR+Fap2cXqQTRY5kkeVdrIHARDSPQ4xA3LDoJNNK+y6pFYC4KIMZiMtsZG8RX4IdQOdgAasPBgT31ZUPWTLRtQuYRODwzx5wDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3zV5e+K; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-656d8b346d2so851290a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727375800; x=1727980600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmRPot6Ie6OccFefzvDBa+te4ErsUV1zq2U3Xjqd8lE=;
        b=f3zV5e+KfBcRYa1pcDW+1fDzGWjWrBBtKOpEVEwm4BNp7ZHNOnGQZZpgNC+01srEwj
         +MCjnJlUnwYThIeMs6Hk7ZVEod4hEmaayZa2rzu5d27dTo2DLruzVLgfTMPYVEV7qGzb
         i+u6o/zu/NeDH9TtKFqYiCEHGxZQycT87NIIilTH1fKfNmqGwd9NCh3Ihl9QBOGAAXey
         jjdo5tLdJrKbOTRUzyES79ntt6XLIq9Ux8ESesgSVRMdf97JQ+eKEJgQjJLQTbNaV1/j
         0two1GVmYGUsNn5hWv28posM7xiINY62+WMtzdS/YGHLd/SSjMu5omfErGvLjPbYp/U5
         50Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727375800; x=1727980600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmRPot6Ie6OccFefzvDBa+te4ErsUV1zq2U3Xjqd8lE=;
        b=OtGl/z8UG0K7NFpZououc993lNcDOQnPK8j2Jl1jv3rDnbNDTTQ/WkMXT44M989erd
         Essi8eghem04KzuoT5rfFeCo+AOX9DgUqhzUhCe31djYiYLyGT6LRcR1irC13V3zTCfv
         87Flsw4ntqQf/L/fY8xQhJkgRSiYnO/ZSTKEsRxpXd+2WLtdKekKqn5YBm6rTEreE/Yn
         U30QK2WAGNK4ImCzqrpxS4tSH5qHc+xntFO2mmYw2yJy/nPreIhoMOk0h6HbeUbNSjKE
         e7/JhTkjUlzvgc+kIMmDq8zD8hcpOkAHJyTYNQoq/0FRZvFgIq2FbUSaxwXd3rj3Piuu
         zlKQ==
X-Gm-Message-State: AOJu0YxwjcbPOYYeR/qhgsX7kFNdMxWY3BM2NFBAipBYPlFWPEPmvqCj
	dSs8nmC14AejPdcJhV8hfCadWXoGLMMljO34silEuWu8wpnVQ7u5E6Hq9z/PelA=
X-Google-Smtp-Source: AGHT+IH4jCyb4OpdVkzjDM5pGaZATo32qNBH/jhrVhtJNhog3cy2rtTY7UArPc/mVQ38+Pzjgczlgw==
X-Received: by 2002:a05:6a21:9cca:b0:1d2:bb7a:722b with SMTP id adf61e73a8af0-1d4fa7ae2bbmr726036637.33.1727375799704;
        Thu, 26 Sep 2024 11:36:39 -0700 (PDT)
Received: from localhost.localdomain ([115.97.189.145])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b264b7decsm215249b3a.47.2024.09.26.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:36:39 -0700 (PDT)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	tanyaagarwal25699@gmail.com
Subject: [PATCH v2 0/1] mm/mempolicy: fix comments for better documentation
Date: Fri, 27 Sep 2024 00:05:15 +0530
Message-Id: <20240926183516.4034-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

As part of my ongoing work on Linux kernel bug fixing, I was planning to
focus on two key topics, one of which is memory management. While reviewing
the memory management subsystem, I used aspell (extracted comments from the
file) to check for spelling errors in comments. During this process, I
found a minor spelling mistake. Upon correcting it, I also noticed an error
in the number of policies.

Tanya Agarwal (1):
  mm/mempolicy: fix comments for better documentation

 include/linux/mempolicy.h | 2 +-
 mm/mempolicy.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)



-- 
2.39.2


