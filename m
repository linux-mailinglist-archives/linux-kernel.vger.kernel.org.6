Return-Path: <linux-kernel+bounces-447379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A1B9F3167
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1047A2C15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AF12054E6;
	Mon, 16 Dec 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RzD3rfIN"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277B204C25
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355269; cv=none; b=rY6HZRp7IZPbtWcamoX8v0zkEfH6fDfKuvVcFsPStSb+XbZ5DNn+hCJ02mzYc++15yyH/DFGbz5OMU4gw1qPij5MmuZnLIU6xCgWw/6cUf06SFuyug6y6udd/XKUSPHY11SDnqqNJIqbqIWUMRnqANxOPQMIznxm1nSW2maXjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355269; c=relaxed/simple;
	bh=nB897+6vWEd6pYH8mLCQE0U1Y7oTCdOV3drp2D63urc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po+AzVFTXQrKqXwTUYLYotCeHW+62IvU3Bwa5s0iuRswqvVUx9MqQe7TBOlezJjxtsJ9O9Lm8InEk/rPTz6gz8QnQGJ/2EvvqMpwF5IwoZkEUkoMJPXkT7Ct9dI28XrFDxYWmGR4kCMkjRvbQmfiUQRqS1GlJzgJIIF2ljrCM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=RzD3rfIN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401c52000fso4133452e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1734355261; x=1734960061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DFco6zz3ViZHeRNfOV74UUN+XYneMKfp/doHU14hnA8=;
        b=RzD3rfINuBfhkiGPIGIb8kz+LcKqd76pBguGmkZeOomzAbgWXj9zjz/i1RKxVHXvxJ
         idfu+z5WsBXzOgUm47u5yeEM/Xb3v8mxiYfPg2OohBk3troxQVh6cB32ek1vEzutDPSj
         9TzOneBv9Uge85zk2VnTMdOkdXEmw5VSSo+WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734355261; x=1734960061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFco6zz3ViZHeRNfOV74UUN+XYneMKfp/doHU14hnA8=;
        b=wg14bOIu1J+BW6eTCHHfcLcUFquc57hYCooclnP8/cFYihq1Mv+mkGCOAkNvEa0FAp
         gGyqqN1fzJzU+RZ8wKJ9MnLNa0hnI2PJi/1bd64C4mKqtbTIqNtxUiv6wnRvaluehApB
         bjWeOE0MmWSpxa59NHmixwbdG2TFo+URZKqJ0JXDqScrUaBiZcoyPLAL9jzbEETx0/LD
         zsNlOFVWNud6x+hNb6q/+eVqVCWvyuiUvhyo/1rADISDn9g+uoGDIRixkfLtVzytj+AA
         Sl6gwep1CSvnYO6Q3DrR9ZLGwnzExdiOA8DZWcEwnYZeWB/9kmD4xjXIKxOETWULsou5
         Ggbw==
X-Gm-Message-State: AOJu0YxzIt9J+cbjXjEnkIgB7tsLHfPqrPrKykYELrhZL0P/omo1esHB
	9xvMM0ogFCD4WloGW5vPB6WpTO/IWYfWt9rgArN3djR1Crvi1LXh3B63rENWgrxFFu0V8z/xPZg
	eTfk=
X-Gm-Gg: ASbGncsOTD4po32OhOr8fsCat6KaHnQwedgxjmETWp/wRm2amtkL/NAp3Ptuo4nvVom
	/ac3Y1B0JN/Vll7B4WPQzhbrjjJEYxnedvGEff39L5v4Nf5xgY05kr4E5tKaSErCRNT8Ie3xvL2
	/RjeNhD5p4lSy4St9rwAUNzuFn1DirsblZ9+q3e2hJS+byTpCl8DLelOp1Z2u5CovARjk3UJVrE
	lIL/GSr+PnLQcRDh7jxWXfvBe/LXGZ3tsiHVsVgUYK14eSAjKE65/ka1DtXf/do4A1g3uQrh/ut
	wqjGvNbcDOjruxY=
X-Google-Smtp-Source: AGHT+IFWEvBupHqBDbttAhQG15UMVl0A9wDHJA3TjsJ9voUC0qHS3hTvHi6raf7jb3BMqQcFrp/i9g==
X-Received: by 2002:a05:6512:3e17:b0:53e:362e:ed6 with SMTP id 2adb3069b0e04-54099b69b54mr3769006e87.50.1734355261056;
        Mon, 16 Dec 2024 05:21:01 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f4b8sm876526e87.13.2024.12.16.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:21:00 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] LICENSES: Linux-syscall-note: replace stale "below" reference
Date: Mon, 16 Dec 2024 14:20:35 +0100
Message-ID: <20241216132035.3409853-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since this was copied out of the original COPYING file [1], and the
COPYING file itself subsequently replaced by references to files under
LICENSES/ [2], the word "below" lost its meaning. Refresh the wording
so it is independent of whether the GPL text is reproduced next
to (above, below, alongside) the syscall note or not.

[1] e00a844acab3 ("LICENSES: Add Linux syscall note exception")
[2] bf02d491237e ("COPYING: use the new text with points to the license files")

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Linus, I can certainly understand if you don't want to change this
text that has been there forever, so feel free to just ignore. Also,
I'm not sure I can even "sign off" on changes to this text, so also
feel free to remove that tag and replace by a reported-by or
suggested-by if you do decide to take it.

 LICENSES/exceptions/Linux-syscall-note | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/LICENSES/exceptions/Linux-syscall-note b/LICENSES/exceptions/Linux-syscall-note
index 9abdad71fafd..df3ced6ec8ee 100644
--- a/LICENSES/exceptions/Linux-syscall-note
+++ b/LICENSES/exceptions/Linux-syscall-note
@@ -13,7 +13,7 @@ License-Text:
    NOTE! This copyright does *not* cover user programs that use kernel
  services by normal system calls - this is merely considered normal use
  of the kernel, and does *not* fall under the heading of "derived work".
- Also note that the GPL below is copyrighted by the Free Software
+ Also note that the GPL text itself is copyrighted by the Free Software
  Foundation, but the instance of code that it refers to (the Linux
  kernel) is copyrighted by me and others who actually wrote it.
 
-- 
2.47.1


