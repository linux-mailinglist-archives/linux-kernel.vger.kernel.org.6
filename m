Return-Path: <linux-kernel+bounces-354206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1D993987
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B428388B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D418BBBD;
	Mon,  7 Oct 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quu0Tzhf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308874C08
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337675; cv=none; b=ot+Od1N1fvlcUE308Yh9cseYlS0I4kCYoHmu1COPsANiH8f7mZJ3brau4Lx2yShkV50rJ7XEc1IR3FdZQBS39z9RbMAjl9gMoGn9/DKY0erZOX4RsVZFhX30Z5OHfBvGdFHLIgq3t53DFwIPBwCCjY5HO0n/rfoMfVEFcEpDpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337675; c=relaxed/simple;
	bh=sHaP8gyR0rr7Ip/nUMYIRG8J8W7aXzQPM1mm57KAkYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QsjTgEt8JoDBpYt3yV9UW+uTGgJ1NJuvE13rYWKqhzvCLmc/fPTydyPJpAOuaFMf2eFJbRa7i/1EDnRYI/fHaWmMSG2cjIyBAYqyGX2OzYvK4Xnor7FZfEaVB/Ek1/bfsekC9/6o3VaRR4frmadzQos4rNSlDArDqgBfuGZ9vCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quu0Tzhf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6995dab8so89615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728337672; x=1728942472; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECgP5fvdUFoRi7cXjxsv8+LRLTtUHELj5XDo2/F4PEw=;
        b=quu0TzhfWz2WmIJz43GGKlFe9YROLCGbEaXNWg6wuQSuIIqIQ2o8JAdIQYIflf6THB
         Qz7xuAqUkEBLMrFDw+q1fZKtr1vs1IPEbA/poiU0K1b/uyyC+Alh4aeFthQ0aw7LT+xm
         B1A07d2axPOYBsJWQK5g1Wa+IQrAZW+eaJk11lBrBi4HDU7WEPF8QmRqC0iUH7WdOgMZ
         Ujdk/rd0iFIGT8aRxWnQ7jxywJ8TiBAPFcYze2ll5UmhhzPyqgzNrHwqXZ7ew5Sy0f6M
         kPXgbbof3Sh5g2QQEy/x1xyokRXlNCjALfyxfOhQtvXam2QiZQULi+g+MzGT1GNfZkXh
         fDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728337672; x=1728942472;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECgP5fvdUFoRi7cXjxsv8+LRLTtUHELj5XDo2/F4PEw=;
        b=Xs/UZe/06ia7QQLu6i+wKyNNvROSqaX9fHG47mxJwoZBI70AnGPat30Q1h9O70SHFF
         nrn+uXLsXs8sLhwe+AQ/MaUR2vq7YhsMEuwu4dNQJ/vMF+S+y0b7cHFqYYMyj8a6A6ch
         /K57Q0miZScIB98QvudyOcrCy3LnhbWk0DYooM0KTEaIuCcMCunFEHpABAszHjpY/bTV
         6FEGA7GwsceS0D1zABFBQQVMdS+1NRVUW1UOvrj/76rWuT3PtWJvPyOiHXPLtaLkVifg
         /BPnMJiuY8wiMbDEUTYECoGM2j54GlfG87df32IFO6392Z6gg5+TQyoRt23rAsPUSrnH
         2ANw==
X-Forwarded-Encrypted: i=1; AJvYcCWo1S7VojtJ1C+a8pThHZzDuNITkPGOlWorRYhs98aeTghlRGd5p/yTaaJ8wFHAY5prpsrodyrd+O+1Tlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFJoFWT9bDUDnMAMI9RsZInDY4ihNhK426pMFWKqZOl2BEuDQ
	WqmzxdkmNzAheXIVRZGFmWzOlD/LpgA8jLhQ0Zy5kAY9GT4/nUXA90RAaGV6FA==
X-Google-Smtp-Source: AGHT+IGDQO4nHRNWdEKeqZdj/pMWxMLlAciMeijzka1tn8Wn5Hu3zNWJfZA/A0qfuY+py/QO0cYu7Q==
X-Received: by 2002:a05:600c:5010:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-42fcdcddf49mr1500625e9.4.1728337671287;
        Mon, 07 Oct 2024 14:47:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:39d2:ccab:c4ec:585b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20393sm104521425e9.12.2024.10.07.14.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:47:50 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Oct 2024 23:47:45 +0200
Subject: [PATCH] maple_tree: fix outdated flag name in comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-maple-tree-doc-fix-v1-1-6bbf89c1153d@google.com>
X-B4-Tracking: v=1; b=H4sIAABXBGcC/x2MUQqAIBAFrxL73YJaFHSV6KP0VQtloRGBdPekz
 xmYSRQRBJG6IlHALVEOn0GXBdl19AtYXGYyytRaqZb38dzAVwDYHZZnedhNSjczKqMtKIdnQNb
 /tB/e9wMsaowaZAAAAA==
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728337670; l=1106;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=sHaP8gyR0rr7Ip/nUMYIRG8J8W7aXzQPM1mm57KAkYI=;
 b=MpX4G9zNkSR1p/lJKwqYFyj/FIS3i0E7M/RCPID4+WNzadZyecSH37beYlx4DgU+tBpq+4KEb
 pW7h5lsjPC0BJcgx+4EgQ6beVcgTehUtGFrLdelA5lakauDNg6iWxwp
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

MAPLE_USE_RCU was renamed to MT_FLAGS_USE_RCU at some point, fix up the
comment.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/maple_tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index c2c11004085e..61c236850ca8 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -224,7 +224,7 @@ typedef struct { /* nothing */ } lockdep_map_p;
  * (set at tree creation time) and dynamic information set under the spinlock.
  *
  * Another use of flags are to indicate global states of the tree.  This is the
- * case with the MAPLE_USE_RCU flag, which indicates the tree is currently in
+ * case with the MT_FLAGS_USE_RCU flag, which indicates the tree is currently in
  * RCU mode.  This mode was added to allow the tree to reuse nodes instead of
  * re-allocating and RCU freeing nodes when there is a single user.
  */

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241007-maple-tree-doc-fix-db016fe321ce
-- 
Jann Horn <jannh@google.com>


