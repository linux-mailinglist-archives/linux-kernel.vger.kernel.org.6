Return-Path: <linux-kernel+bounces-312025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E79690FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD62840CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F91CCEDA;
	Tue,  3 Sep 2024 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2cXHic3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B71A4E9F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327522; cv=none; b=Y8gCVcwUfj7I0UMRqIdU+9WGb6Fhls5jCxx4ndxjclxSbhERHf6wvkaTto4bqyiZc5Q8I0tf2LHnMkemhfXI/FqUYgByL9dX+T8O7KIxsaR6AjT2Hn8rVXow46F5fRgs2WaQZ0sPeznyD2E54lrzp1LLAaOLQXkxnwq17PgOhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327522; c=relaxed/simple;
	bh=bWz/XRWy3CqCyrjGXlJYhj83q/x+5kQ097On+Jhsz6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8VvXtB/Swg1Cckt/TVYleV8rMKBlYKSqhK5ZeH4ndjHPYBebbHubSnbhmSdikHrEO9+IgzmonxpUPyhaVrN87GnTzvuwjMsp5kosUaTw5xRpbnoZ55M2vB7+NT/NtB17yYRjOx9nwTFQRXgphufToPFGOKVsoopR3SRg+MMrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2cXHic3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2057917c493so10839575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327520; x=1725932320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NF46/poLcWGIiOf1nD6266+IxpxJ4be5IRsEMASbegM=;
        b=W2cXHic36GNSYb2bEhxxMizcHvNXuAuDw7TxMAVJHD6SmFy6d6/rZP9WLqcZHEPyUS
         tMx+uvlhTBNvIbxlfQLCWQ8pci5V/y5Q6CsWWdaBn+iGJNHz5HMeBYnnsRRjye/byEXI
         dn8pmkBlMSTLpLT2C1msFCoiL2KDXafOpIBCJqN9q7pTKYqcjHclMDOzKfUVrm0Yje5w
         1GgTUAlGGludHnDW3851fpy4I6hOHdUK3e57cSzGDWG6QinvsoRtyrKGHJIrxszeBPo7
         VRnKcXd9WFb1sbzGAY6KeTctdEv3bs+n9ZzlWuiPQ31vNtpd9eYr2WaeEYtcUXIaEWHd
         oVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327520; x=1725932320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF46/poLcWGIiOf1nD6266+IxpxJ4be5IRsEMASbegM=;
        b=Gf+Bd0xkfwTUP8mCjcW7huqU4EQ8gJLiXXpvae3jv+w/cBWIaXJsjKlXTYP9YzQdnH
         NyEoOkgHGFwMCWPZ1VrvS/gNRjZAdb++dHPTEaNAdl53y2NWBnKav4dxBbC4tyoELMxA
         uYycugZOWUr3QLd0BaTBK4QYATr246fmPWa5KAwslMwyTfLm4lcyHp4fW+k28/6ElEmf
         uxC9EzWb/6I9M5tLgCJQVGvJhT2iIZfURO0xM0pRPuG4Daj84JI2Q66r2NaVan2NREp5
         onDe9S7NHRpWs7Tt/xxXTDxmhRNTCgf+PU3AATY5pT0P+48kce/dBz4l84akUCV5l4fg
         ea3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXu8MhL8y8qTjDeHTESGhQF3ZSi0CWEIJiYGZZoCHCJY8HThz3rivyR3bzxxXgVO2fduXmZ/r8/eYb2TkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14ONMGg5+ZpBQRAgZjXc/8EYY+01NTLLpfETeCIyxZNcJ7lQO
	VIplmoyVjGfWlddcY38/y+2GLx44gsdaLiwr57XPO6206aC84SYA
X-Google-Smtp-Source: AGHT+IE5rLJ1qrEMrjT7MUmMzjNr92PWh/mPXSbCd+5TwADwoA6j7jiZrnma60CQzUgHIYjTyUzLng==
X-Received: by 2002:a17:902:f547:b0:205:63af:3487 with SMTP id d9443c01a7336-20563af38a4mr69557785ad.0.1725327520117;
        Mon, 02 Sep 2024 18:38:40 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054e56ef5esm39662315ad.246.2024.09.02.18.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:38:39 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 6914680484;
	Tue,  3 Sep 2024 09:47:08 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v6 0/2] Add support for two-plane serial NAND flash
Date: Tue,  3 Sep 2024 09:36:23 +0800
Message-Id: <20240903013625.1658825-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add support for Macronix serial NAND flash with a two-plane structure.

Insert the Plane Select bit during the read_from_cache and the
write_to_cache operation.

v6:
  Fix the name of the flag in changelog

v5:
  Update the commit titles

v4:
  Separate the core changes and Macronix changes

v3:
  Add flags for the Plane Select bit
  Remove fixups and corresponding function

v2:
  Squash patches 1 and 3 and come before patch 2

Cheng Ming Lin (2):
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: macronix: Flag parts needing explicit plane select

 drivers/mtd/nand/spi/core.c     |  6 ++++++
 drivers/mtd/nand/spi/macronix.c | 24 +++++++++++++++++-------
 include/linux/mtd/spinand.h     |  2 ++
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.25.1


