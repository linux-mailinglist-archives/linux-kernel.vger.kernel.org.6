Return-Path: <linux-kernel+bounces-551721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E2A56FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F17A6164
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29352459EF;
	Fri,  7 Mar 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL5Zu6K+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67924501E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370282; cv=none; b=gI6aKf5yk6+7zDTJ+ATszfN06+4YBzJ5QVUSidGtLkgHGXOGGR+5eXKGsajiqY2Kk1e4hw5fZNtQby3ZexZUK1lQsDoDvUuOOuxVMZtykNrlpupZAs1aX0C0ya2i0Ly9vE2AR62ZyEN68BrHzAYqxdI8NA4f9t16Oj2mdYWoSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370282; c=relaxed/simple;
	bh=RTw4bd+nFerVVw40Ha4aRIZhqdSLvqW4M3J/KVhQ2XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5+FudbcKw9NX9BMMt3/xcAMv0wAAUD5O8OSVx7sCN7CVbngian+UGX1X0A4nOOBSfPdomrDwvY5ostlE3kX+bzbjwGmMepSak4jrjqBvFXAGG6RmNCXWiV0JUmrLpbn67wI+NaSJlZPWnfTS6Ssx7dqa3sbKwlJ4nXRyhR6uEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VL5Zu6K+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso3383068a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370279; x=1741975079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQqEJjs3j8paEAurgtMwvj4Mcq7zggHhd+MXddK/xGk=;
        b=VL5Zu6K++rU2g2JsnwxNlL6R6uPfOfHKouU5bd4ObVdok0mqs68D6ymo/McoraKqml
         AJyX5ZhjLlyM41QtOSUQ6xXPLw5t9ZzfDahMR4BQrVYdilrVtngDR31rM9pgER3HYzga
         ZBYUgsTb+5QILblaj0WHV64/upViNiOv5pwzqNvXymjJwNLKnRxppThgWwJxm0isQkfo
         +v0rfZKKzWiJITElD45yjbK66ZoCkWeyqzermJFo01ExUVmf5Dm49CuUmopRa1wmYQaY
         CUWFW8qEPzUDgL8gqEMiYVE7XLs/WisKwgQui/bUIBmykTz2CfxFx8WvJUl6gjn3QoUa
         EREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370279; x=1741975079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQqEJjs3j8paEAurgtMwvj4Mcq7zggHhd+MXddK/xGk=;
        b=CCIrI1kz9gOnJkrKhauED7gUw/9cKq95cL2jpgSgiYsiTLGVVRjf2yh5/HFro/HZsR
         vXoZus5ma9IbITgxzQGWtQSHEkkPFmPNWead+CFKnZwQiqM1nW/7uWZSN5jKC51gDCI/
         WhLawa9rivmrF+BoH3IJpRd1lJViLpjKKS94y1ZlzbUukEU0Ec9kSh9mHjMLGed83d/q
         jvAXjWB/GfMULKCjyGaSxELlSQDzWWw4cn/I8SxhExSSGmi1hFCJemndICnMJTGq4Sx5
         +SQ8nVaSRibP/udG5HyASS6mUGHKDBfZB052KaNnq9pBGeS/NIuK2B6zc3tK0VR02hsj
         gXcQ==
X-Gm-Message-State: AOJu0YxKhMfVznSHUoAGApqnKOjFHUI1Ot/TOV0/+kAlN8XpBRvDf1eo
	jX0OahQifmEfkFelxaJG8bgTt5mL8oV4XYs0SBXD+u9jqbjWZhx0f13McKHpTFs=
X-Gm-Gg: ASbGncvwUkM5M7dNDfN2I+19qMSMX2SIKTe1Om1VmcWgWJa2jORZ9LeA05CTJQE7rnv
	YytlWof4F6KLM8nexfoCUYXFH6D0a/m5kbKty8GDVgl0+90yVABWKynCqMcnULoL5TBQXkURtE1
	wTQwXLon0RVuAezbosQoDB+kX39qsUClmPQvyBvNALkxPg2xIW2efoitrAmON6JNDyCCPovAcl4
	3UjgzuKiYrP1G/057K81Gy8zfvCMVoQ3gULDD2qbwNUfxmWgUb68IR2msn4TZN+VL2peRgGtcds
	sbQJfZq2mKMzt83Yb6bK5eWl9WV8fv+5UjHGRcICVFHtjFJplGVGHJPG8vQMbMkGxAFLbg==
X-Google-Smtp-Source: AGHT+IED65IahY+uYs8UBOfeYynJPE5YAWY5vNgKIGFQ7bIoogdYP8XGZHbrXFHL9kXkblm6I1mHXw==
X-Received: by 2002:a05:6402:35c7:b0:5e0:9390:f0d2 with SMTP id 4fb4d7f45d1cf-5e5e248f10amr4987485a12.20.1741370278723;
        Fri, 07 Mar 2025 09:57:58 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:57 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/14] nvmem: core: fix bit offsets of more than one byte
Date: Fri,  7 Mar 2025 17:57:18 +0000
Message-Id: <20250307175724.15068-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=fqrKmcbiS1AKaDRrZvXTHaNkz/q/+2qHSl68uGqUaBM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN97hGNgbYjaTbvZPgdzB72XNiBcbLcq4a2R zoh1+IK6NSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV N7FbCAC2fYQ75qNn7uIOrrM/GfgdtFREP81SNBme3i+nK7aa8oBrjYz0PRLpt93jSTkUvtfPONc eNnYo6gqfXmYZ/stqP0rtMWxzVc/mwo2vcvPpvIZNdBgc4IJsCukzkMwhZfww9M6KjyxFSWHxZp vWEC1Ojwyy9YJAiHz/Z1dnOdPJRv+Pp/invb+iQOCNQq5roENMYpLibCRig2m88TjD1oz2tRRZT GuRhMcIUzql+bCr4Bb5eruK+W2jwE7OdM600T7i8ihU0GKO+qR7QP5vlbj7GIgj+9zkk2K4P6gH o/0iJXcKeMggRX7dwhaISwh2lJJTcgSPLMuqzsJCkKeXA34o
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

If the NVMEM specifies a stride to access data, reading particular cell
might require bit offset that is bigger than one byte. Rework NVMEM core
code to support bit offsets of more than 8 bits.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fff85bbf0ecd..7872903c08a1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -837,7 +837,9 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		if (addr && len == (2 * sizeof(u32))) {
 			info.bit_offset = be32_to_cpup(addr++);
 			info.nbits = be32_to_cpup(addr);
-			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
+			if (info.bit_offset >= BITS_PER_BYTE * info.bytes ||
+			    info.nbits < 1 ||
+			    info.bit_offset + info.nbits > BITS_PER_BYTE * info.bytes) {
 				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
 				of_node_put(child);
 				return -EINVAL;
@@ -1630,21 +1632,29 @@ EXPORT_SYMBOL_GPL(nvmem_cell_put);
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
-	int i, extra, bit_offset = cell->bit_offset;
+	int i, extra, bytes_offset;
+	int bit_offset = cell->bit_offset;
 
 	p = b = buf;
-	if (bit_offset) {
+
+	bytes_offset = bit_offset / BITS_PER_BYTE;
+	b += bytes_offset;
+	bit_offset %= BITS_PER_BYTE;
+
+	if (bit_offset % BITS_PER_BYTE) {
 		/* First shift */
-		*b++ >>= bit_offset;
+		*p = *b++ >> bit_offset;
 
 		/* setup rest of the bytes if any */
 		for (i = 1; i < cell->bytes; i++) {
 			/* Get bits from next byte and shift them towards msb */
-			*p |= *b << (BITS_PER_BYTE - bit_offset);
+			*p++ |= *b << (BITS_PER_BYTE - bit_offset);
 
-			p = b;
-			*b++ >>= bit_offset;
+			*p = *b++ >> bit_offset;
 		}
+	} else if (p != b) {
+		memmove(p, b, cell->bytes - bytes_offset);
+		p += cell->bytes - 1;
 	} else {
 		/* point to the msb */
 		p += cell->bytes - 1;
-- 
2.25.1


