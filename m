Return-Path: <linux-kernel+bounces-421537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A29D8C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4C5286935
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957B1B4156;
	Mon, 25 Nov 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkFEdYoq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3040C03
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561832; cv=none; b=ENUbpkoNsE+LrvHgPGseDOIZ02tGAWE3m/OsoPoeeqacTMvKNypojwHsDVGlRKWTAeUnhsp9W+pIxk8mmHu5/MhfIHYPCs7WalfWPuKnl/9EAPB5jXj5ChS9bHoNUVhQPTcSbjpE7JJy/2svL0RqwEFZGqbCYjWPKVMb6/5V6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561832; c=relaxed/simple;
	bh=KCvNy3wW9cjEYr+pDsTjgPAw4AfBJWk7EQedEn3RIpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBJtfGfrBlYpcAM7PD41OP8Ccyg7dG+ZT2bj/wpzq7oF5yduJ6w1BXHQ4SXibmgi6QyTBJPtUXd4GeF3iPt63wYpGrbaKi5LqbSVJWyF/1+3OZ/QJ7BXbjYKKwoKfijCW4HBU6gerqgLZOOY2aNaNyUf1M2vLn4OBumpB8rGvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkFEdYoq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2124a86f4cbso43266535ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732561830; x=1733166630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q78q1OoQNcZ98znvtV4ozluwpFdzLILnURvHrjKkDmM=;
        b=CkFEdYoqUjGM35DzvMAQWfeayLNA6R4nzH22p4eiuPVXxeq5bnbjcuwOG2jn1q0AgI
         2kq+MeGZjRkBfsmct7z2DzGCspoVYm5pYxKo/BPTfO7xVhYzWRMZBkeDjZxV9x8HxUhu
         i2YpUivtKPzYISqiAqoSMG+wpaOQbp6G2em+SqD8TTRH5gdIFmiKWYR+DojbR02kzOIk
         ljlTOQqoyoCnUEr3fK1DqSxI7LUCn579/sx3A96IDGer2cYK4oQkQWceRK6x6cv4KRNT
         6vVpSadMnMKWizkL9x23M6pD3lFcUasbgPlKqpsdtjRfoDog9vZpTEb4bjs5i1QYK7uD
         A7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732561830; x=1733166630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q78q1OoQNcZ98znvtV4ozluwpFdzLILnURvHrjKkDmM=;
        b=DmFGxL/4JosKeXVEHWcYYGqC80/knEBowzzAoSHTozE1V6Z6I1kNvI+6ROq8MLjQRh
         mEJwXSAVrQe7csRKRvTVR7cHY0xeAIrcE8ZOU2Zoktrm8ndEpj27h89LdxnArhjfggL3
         XadGi3jwBrzQat5M0bu5qqHQs6rOdChOZRWxZyUGDDsAh+Coyo6ogos/BLl90gbOJE87
         VLXBorh8Z1t1etWOdMRE3i/MgjJCA2HtSIR1x7ZeBdN8NzpaGYflf2rl+pJpt11H6TjQ
         lcVzVmXaQyJIhcuI6uUjVXuYpISn3znoJDiX8JhZyk2ciDq/ixYE+Cnu2GTPxT/bh+PP
         /6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQLrxeHPPHklruEMrHQcpodTDpyokU6pfDgvRUWSXUh6D6w+XIrfRxYzYP+1jUmuYDJIMef4e3QquQoh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCqt4RYbkX2cbh1juL0q6ZVwUHOkhBIYcesFMEI45cNFgJXhs
	ey6LpiPPKvr/itpCGkFCwTG+fXlpaSoUZEv7eFDZuwpCAxFAorja
X-Gm-Gg: ASbGncuqe7d4+JLQ+IpfEc6m6qD9HcABgHPM4IQ3I0fvaTU+kZ/A032Ig8bszAnt6NF
	4u1f0IXFzuV4hWFXFkEL7PMQkTUrPNvXCF3dxB/VeqgGj4mdTqajWDwcEIi7UZe08j688ZMAaid
	DdeuGl2X3P2fshoI1hPYSnIVvb7YhXw0QUqM4wp8kdSpfIRhGw983BVDaflH4zQoFVjnbavBd2/
	+cAz2ZVj0kMIDCRnT65h/evpHXJumNW4rElCta3cCn6Xb+zAGMO0L/rPrev/hIWKQ==
X-Google-Smtp-Source: AGHT+IHCxmfZgBVj+1qygDHPsmou0yVLe20pxtiugxO94Cqk8ljgQAN2f+cO5yXaAJdG8vF2YDDb9A==
X-Received: by 2002:a17:902:ccc5:b0:211:6b21:73d9 with SMTP id d9443c01a7336-2129f81e8a5mr211338415ad.37.1732561830341;
        Mon, 25 Nov 2024 11:10:30 -0800 (PST)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:8701:62b0:6f84:ac3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc20ae9sm68428745ad.240.2024.11.25.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:10:29 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next] mailbox: th1520: Fix out of bounds write
Date: Tue, 26 Nov 2024 00:40:09 +0530
Message-Id: <20241125191009.28535-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop in the function iterates up to `TH_1520_MBOX_CHANS`,
but the `ctx->intr_mask` array only has 3 elements. When 
`TH_1520_MBOX_CHANS` is set to a value larger than 3, this
causes an out-of-bounds write at `ctx->intr_mask[3]`.
This could cause an immediate crash or incorrect computations.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/mailbox/mailbox-th1520.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
index 4e84640ac3b8..759634a4fb72 100644
--- a/drivers/mailbox/mailbox-th1520.c
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -532,6 +532,9 @@ static int __maybe_unused th1520_mbox_suspend_noirq(struct device *dev)
 	 * INFO data all assumed to be lost.
 	 */
 	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
+		if (i >= ARRAY_SIZE(ctx->intr_mask))
+			break;
+
 		ctx->intr_mask[i] =
 			ioread32(priv->local_icu[i] + TH_1520_MBOX_MASK);
 	}
-- 
2.34.1


