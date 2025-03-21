Return-Path: <linux-kernel+bounces-572061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5EA6C60D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006BB189C4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3471F3B8F;
	Fri, 21 Mar 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St9JuDJ6"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CE2A1C9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597176; cv=none; b=eps/knkIppyEjOwNhSYlQmDRPytPl+CdhgvADS7Sxx4zpvpqB0755a2CP/uxZdq1maERhPSnzRlknynyypr1M/nSDEeLavdxmh6ZG/JwVUF8YLjKwB+YxiPFNacYw7u22GOQDCEsPsdt672L/zb2Kfq5Z9gZgFKjtoVNHjtALGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597176; c=relaxed/simple;
	bh=xFKdyKRqHHLSfvUodQ/kjlY+bI+NvBRAz/rMCiZhh/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vj331Aj5jcwOwPkTLix6tp+K+htFrwQZn5APC2AImRetnJmr7z+sSK0IjBogs9t4qnAABkJ8OCTQ/sHgiPlYhaHR8O1mz/u+n0QshFLgnLKuws5k7u1gS8V2FeLXfwrWT9NZCIC+e+XMQMxG0PrkyinAPsSeKqWaucPzTIJPsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St9JuDJ6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2f391864so1365027f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742597172; x=1743201972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lsLa42J+Zulo6QK8WPYyJQJ8/lMx6z1kULXdh8/lXCU=;
        b=St9JuDJ6Bdgz17oesSYxl7/urkKdisyaxUGb5kHn5bAaXpPLtIpPe6CKJ1pZXM80TU
         RHKbBxGS/jic7Q5N+EDoR6y8b6wyJc32MoXh7M3qbIJXDE4MUynBMPXFCkA+x9wsQpLQ
         rDmJKrFSrWtAGIlg9DtNBCv7g993X/yK1vLBHNOp/ii3AcSHVhvWcHPlsfYC6kbKzyGe
         ofbPrZOd2qsFSJ9aLREC3goSdX219JV+ZnHvsm5wT4eoyrx+SY/0bDt8OEqjzPx9CSw7
         ccDcb5e0py2wt3/FQHke/PWkFIWvLknq7r2yNr2X6SPYSwqrk7CNLFH04ko09Ck+LKLN
         /2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742597172; x=1743201972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsLa42J+Zulo6QK8WPYyJQJ8/lMx6z1kULXdh8/lXCU=;
        b=c8H7qvNirCOBbsCS3Ofrzm/pXjudn46+wULTVoizYykTDGPVEkAw4+Gv1jn7jDlxAa
         XbXof6ntR+25b56QRRuQB9Uxw1C/OQp4ehK34UL5IJHXuAOutgWwmxdq3AVdr6rs/1Ra
         SghUVZ6keXDL1mUiPTCZELT3sPP8gGeolADqfAWIV5d2qEET0oYPPSnaf498D05WPhie
         ijrk/yccf8E94LcN1Nv4KUcVhsox/l9rNxAVdEBN95gVSoXNl11gosKFL7wtIIN7f9js
         L4dxBvmAVcwAZVnt1ibVDDrQ5SLLJ0yhd2C4cjp0by8suibyDEeyo+em/2szGlu6dNXv
         fScA==
X-Gm-Message-State: AOJu0YzGdkc9pMz9lNuUfZKjuEBIlURf0RG54VKRZ69/BYav/girlQTV
	yhFWhqfKlM/w/mws4l3Rg0kBp8pTbAo46ZR3dCO2g7/PVViRpxcXq7BDig==
X-Gm-Gg: ASbGncv+H3DOzVWgqT1p54Mnhu3URnfY3p3X08ZHiR51hp0Tfb08aRbn6Dd3dZS1G6L
	wTH08NVXabBCZm8G8vSaSvLLMGSBYDwVjLas2FeQg8qs0LEfDLsr80M+1c2fG6V4YZjQZSaiWXn
	V4maFYYZzeS+KxlLNAzELEMcga79dFPSodp4UYfAokxqRGfvxtql+PGd3EejvhDCetIiXEuNKsR
	xckuGOBeSqLMT2ZdTlWDInaTlya3x7ipvMbVEzFysiZMafelwGhPgST2gqhEuF1YGKSBpIhx8ID
	VHse7hg2hTN9CpkMPpV6C6VUbTQWXII5BzmZTUz00RFi1JBA0DBBmPHGMKer8dpTpJKwLD71wFB
	WlW1GHo/B7Pa76LanuZF9LlkeeQ==
X-Google-Smtp-Source: AGHT+IEHXocWjMN1zyFdcjrGmr8zI+9ph5jrwvJUvvN/0m5mcRwmXrrZzxTcq293kZoEdxh4FnlA1A==
X-Received: by 2002:a5d:5885:0:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-3997f93c495mr4506373f8f.49.1742597172390;
        Fri, 21 Mar 2025 15:46:12 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm3609957f8f.38.2025.03.21.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:46:11 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH next 0/3] iov: Optimise user copies
Date: Fri, 21 Mar 2025 22:45:54 +0000
Message-Id: <20250321224557.3847-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The speculation barrier in access_ok() is expensive.

The first patch removes the initial checks when reading the iovec[].
The checks are repeated before the actual copy.

The second patch uses 'user address masking' if supported.

The third removes a lot of code for single entry iovec[].

David Laight (3):
  Remove access_ok() from import_iovec()
  Use masked user accesses
  Optimise __import_iovec_ubuf()

 lib/iov_iter.c | 97 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 34 deletions(-)

-- 
2.39.5


