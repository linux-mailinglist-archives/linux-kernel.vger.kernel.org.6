Return-Path: <linux-kernel+bounces-285337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E811950C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7BB1F22880
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74721A4F15;
	Tue, 13 Aug 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kl0qYfGx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A271A3BC8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573685; cv=none; b=tG3p2RJC4sMf5qBYtnQ2KwekfUIAAtIBr3jchmB2KKHjSRK6YQZbBfWdWfwXZqhrTjV1OrifkhtzYqYYmS7ockSUct/50CwlQwxF6jLBjew3eG+iXl2q/QdKOZDOScRaGoYSXaJduBHpcowxNf9v7EOXQNIHwt1IszcJw/AVHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573685; c=relaxed/simple;
	bh=341AIaEeBSFJu73c47ddLKfkUSw2l+H2RZ6SJ/BltPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N00RonzQ8c8bj6iM6Y8iZRes1sdjaxuF9arPEh0iXadZJCqHIdW4t61Ad2U78HvvTrCjnbs4CetU7wsVy9W2JoZxi8V/ELB1HcRgfMjfi3pJ3XQWuS6zVsqIyTDGVgmgq/S4GQLACapbqDb3gCdl6zPXf8d1nkKOIx+ZxPEMXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kl0qYfGx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e8826e03bso9512025276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573682; x=1724178482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvCJH3TZ9fBYiYpF5a88AFpsytgjevnUGq5R4un9KfQ=;
        b=Kl0qYfGx59p5J73dw8Ih+eN5iZ2LHLA4V4tl2uU0KQvdtJ0pw0mJ9uWt+zGCQSGDtN
         LRT9I+awdlnIqQHd+x18pPxtZPsP5FVxknjSzkFAPBP/vRIoSjLAU2wLHhOgy9vBkcnS
         dHTw3Lgtz7DtdNo0xvDGc8mlxTLmIGvgfI9TfKY1XAi6VhnDr0wDJpPdzWFyojrVWvuO
         QaGHVP0vd/sYow/JDgi5EcSbW1ioKn+QRSiPBJSvWfAe0EMBPJWwwhZQCcJWr/jNW0DI
         wwlQkL8Ql/7eRJkHfjzue7hAPcVQbM6Pq9AXlXVvm/mJ3VayM6Jp0q8dwYWYGHjDmtBk
         5FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573682; x=1724178482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvCJH3TZ9fBYiYpF5a88AFpsytgjevnUGq5R4un9KfQ=;
        b=kMTbl/DItYh59lxKj6FxXH8Ol3mbiBNM8Q8VykN6rm53bG3sB9yqFlKYOBeizm0g13
         crkpx4KxeapKVFr8/Nz6YUnvOrzFmKnmZ8mQKBfn2MmCDSB8bMdY2dKhrZn6VDtSk/LH
         mrUBvwX6hBkBTvz15IAfW84rG9OW4YPSNZB9ZQiU6pcS2yv/lRtVF6R/U3JXxIx7Tlnm
         kt+84Wg9WdQ0C4/7HfU/ycjgobqTE8va0z6Oc+mvIwxB2luuNKCIxHy5O8tin+jMu2YS
         TRFbg1Yj3SuODDnb0CVTrL5+uIXswWhnOaERDd6lI0xosePpL2m1Gq37Zp8WrSjeZVu4
         srHg==
X-Forwarded-Encrypted: i=1; AJvYcCWkN0f3sTqyyE/T1JmDu9gt2qwNrN0vZgaMrtcfpugAKcUSviobXA8syU8YIdxoSQeg4vwH78VHAPn9cLPa7S1GHrYYIIID9SJtCe/0
X-Gm-Message-State: AOJu0Yy3iSK5zBruvJW9f+t/BaNxudfkxr3Wum4x1Tda1unroPRNR835
	8HI8JF821x0l0/aolNn28K9gyEX2Dvx7OoaVBT2aq/2JzyJ+lS/O0Q/QfLJyDB2E/HJC1S8RmKz
	vEwS1VNAxEbFPCGjYCA==
X-Google-Smtp-Source: AGHT+IGj4/G4VHtyu7j84mLj7yhWkQtHtTJEHKj/H2cGvmAy6yo3iqZtz9v6g07d1BL8wXt51Jxah1P72bzfqR2d
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a5b:b43:0:b0:e03:5b06:6db2 with SMTP id
 3f1490d57ef6-e1155a57e9amr896276.3.1723573682504; Tue, 13 Aug 2024 11:28:02
 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:44 +0000
In-Reply-To: <20240813182747.1770032-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813182747.1770032-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-3-manojvishy@google.com>
Subject: [PATCH v1 2/5] idpf: Acquire the lock before accessing the xn->salt
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

The transaction salt was being accessed before acquiring the
idpf_vc_xn_lock when idpf has to forward the virtchnl reply.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..30eec674d594 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		return -EINVAL;
 	}
 	xn = &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
 
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
-- 
2.46.0.76.ge559c4bf1a-goog


