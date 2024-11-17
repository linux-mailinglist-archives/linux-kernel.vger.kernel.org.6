Return-Path: <linux-kernel+bounces-412164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB19D04BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78D2B22275
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F61DA612;
	Sun, 17 Nov 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/1VTeXR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF771401B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731863012; cv=none; b=PfwIiMKwLssydVsKOIH9NZJs0s2LGubs55/bmyxizSIUEIY6NCznXQdHAeSkYFNGT0/18y/HP7eMI8JxtYMSQkKUqEyp+CDxFtuAUPGVjDs8mlcAPyGS4AFcTdO8ayZ6exJH1FPB0fQRtU0L3f7mJMIYwrqOph7a2cpLuUQHIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731863012; c=relaxed/simple;
	bh=8a7lEA7GnyIncokbZDwiBGQiZiijALJ2Plbv1gNjECI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ReqDuD2pB/7qCYDsRTxh95DJu15f+Z8xBlfLT7qXHIq/a3unhBnz+wlSdL4of8nQn8Kl0QlDsAhC9OGzZFhhroDp7TmPJHmltH96GVTTptu/jkHZID5S/4JieTtLO35OELNklAK5e1e/1y6lpOwTrOXZbn64ToE299FGQeCFoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/1VTeXR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee484ec18aso57048387b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731863010; x=1732467810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip5/1nZqGxhHDaB5wRv08h0uSCzJ6//9B4YB74TxInY=;
        b=g/1VTeXRpivJgCDMlfLPu3jZcqK7xq6pg4cXJopubmX80XiuLtyXjkHQPmIyr/A2Da
         dMHJtksRR70heub85Y018PO/f68E+Shl5BZTRItqnTPrea59aNWg7L2gDk/IyfzGH1JW
         sHYI7bwyHuOVWLn8uY1hxBhl9CIPasdo8PUtMhB0N67crxnr4pnDJvhxeMKyXtqgyfRb
         tCLGxsMmbAdy28TV2HwlMIXpF7QgTFzXzcLadhaKkJttBqeynxUPI7KMDoTKP/f6KQ5m
         4NnTY72IMj5aLVSmNgt9c4FzcSTqx4KG3wZLpZEPPxkhOtQnmaMLE6eDcJAEFUtIfbtc
         ZWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731863010; x=1732467810;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip5/1nZqGxhHDaB5wRv08h0uSCzJ6//9B4YB74TxInY=;
        b=veqn/rGkTumXeI4DS71JmXZLBwjThu/+/JB57WT2hE89AK3sN/5FdkUH/q+zZcCRx5
         /5R4afgDpZkFslcac52PXd7oXOS10MHnjd609SKC7c1MtwTgxhveT6ffvbkZPMJvOzKv
         ADerxF+bsRn/xPUNTLle6L7o4FcfaGDLQfScnf25xtFh3X+Pg4i2TugPWcfDOBaB/IOj
         6O9W1FMw8XZdryKgy1nEbgqMnwQVGmtR5VB4N2XtpvpTWVZIdFx7BJ8xx/GcUirt4qte
         Dqycr1nQxfV61bV3XGDyJyNpoOQNAC2wRJmVkj9CZtZq3rhNY4Go7oJDXp8s+zJutBYc
         GmZw==
X-Forwarded-Encrypted: i=1; AJvYcCUvpbD2W2S/sJphJpP00Ka6x6umigd3ZQUUHLd/8At1GIvsEcGNvyOdN3x9cCJICc1PaPwXNYxpla2K66E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3KleVsb03KfPcDNZ4jrWXu5aIHm39+333sBfbTZQb/tkJsCN
	VMtvk3eEvZhXu+PMxbbF0Jin25c9egxzy+8LgriueA3UrzMoz8Y8GAhLWrle89WIbgRjUQsTQlC
	Lc3/vmkHOdioa1g==
X-Google-Smtp-Source: AGHT+IG0Mg9dEvwB5HqwR/qPZEBllHTbHdRpgDouyxkiR2h6fNWlGlmde25AJXfVR0dvbM7cSC6zwR6YjRdqgDw=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:527])
 (user=tjmercier job=sendgmr) by 2002:a81:ad0a:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6ee55c2f44fmr1527227b3.3.1731863010097; Sun, 17 Nov 2024
 09:03:30 -0800 (PST)
Date: Sun, 17 Nov 2024 17:03:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117170326.1971113-1-tjmercier@google.com>
Subject: [PATCH] dma-buf: Fix __dma_buf_debugfs_list_del argument for !CONFIG_DEBUG_FS
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The arguments for __dma_buf_debugfs_list_del do not match for both the
CONFIG_DEBUG_FS case and the !CONFIG_DEBUG_FS case. The !CONFIG_DEBUG_FS
case should take a struct dma_buf *, but it's currently struct file *.
This can lead to the build error:

error: passing argument 1 of =E2=80=98__dma_buf_debugfs_list_del=E2=80=99 f=
rom
incompatible pointer type [-Werror=3Dincompatible-pointer-types]

dma-buf.c:63:53: note: expected =E2=80=98struct file *=E2=80=99 but argumen=
t is of
type =E2=80=98struct dma_buf *=E2=80=99
   63 | static void __dma_buf_debugfs_list_del(struct file *file)

Fixes: bfc7bc539392 ("dma-buf: Do not build debugfs related code when !CONF=
IG_DEBUG_FS")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8892bc701a66..afb8c1c50107 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -60,7 +60,7 @@ static void __dma_buf_debugfs_list_add(struct dma_buf *dm=
abuf)
 {
 }
=20
-static void __dma_buf_debugfs_list_del(struct file *file)
+static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
 {
 }
 #endif
--=20
2.47.0.338.g60cca15819-goog


