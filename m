Return-Path: <linux-kernel+bounces-553176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95C1A58528
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BE53AD977
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA41EF398;
	Sun,  9 Mar 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbNE15dw"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23D1EF364
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532264; cv=none; b=bzQLkkpdvYVy/wP+VTp/8reRwrErdU9/pfpm5Sjdz9I6K1KBqDx0wy2pTqArQvk7OcmO+K3PvYJKlhE/ya08s5R8esdLKoI+qQKwrKc7wIZESto+NveJFcTAt/Bvq8aoZZq4uhlmHL6HXFYEex7N8xBQc/dr2wSS6twCVGtOeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532264; c=relaxed/simple;
	bh=RTw4bd+nFerVVw40Ha4aRIZhqdSLvqW4M3J/KVhQ2XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snFCY8JyDvDIGFWgKHBHcMKlusawx3F8C5b+YBgiCARU5xza7jU31ZpDX2f1yS2WHyZE0oZ4medou+6FkwwpVMZF8GqOHAewoo/0MEYDQKAoSsWV60Xowy4tQ68X8x6qoG0GCmik9l7uveNUwdtWFqkpRmUHn+0ExejON9kBVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbNE15dw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso4633645e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532261; x=1742137061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQqEJjs3j8paEAurgtMwvj4Mcq7zggHhd+MXddK/xGk=;
        b=sbNE15dwRomVQeXEjCymFh1HzwERvTzXuXTxsplLKGJEJrc5tFTcIMPYmTE6LTMHtQ
         5C/dlv0wFrvBRQ49pMFSkUHsHZmJyDM4GRMVvd6bsASyk/yOSvhYLhl9FlZplHB+S6d/
         nte+qpxR+aB6cjlN8HXUSazm+NcAHmcUr3MWJOq3UhOR/2ZhjacKDrCUBgHwoXcL4h/Z
         JH6eKuKE+xxCBJKdCpDk+q7c6bTQazBe6AVXSfrMJl5FYVC55F2vW3BlHDQUa3/NX/s5
         IrtIdrJwslDBeCSnO9y6pV7KdysYaWOmjHiaJ+efPfUNmlJmPQAbb/Ve17VaR+TlVDK4
         86gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532261; x=1742137061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQqEJjs3j8paEAurgtMwvj4Mcq7zggHhd+MXddK/xGk=;
        b=FjTfNkQ27d66mJ7fAj0LjThoEEQC0Eqz946zNks863HCTbswpPMOhJSkhAc43m0cGA
         hlISErYJ3n8+MomdYIisWPaprEzzPmqCMPyx9eOlaDA1nN1h1NdEeQCImB/dBoP+cSsM
         KEPUIqdSrOns6LFyeGQfNnW5pzu4L7oOeQ31FaHSOEJAqoTRVbpdKZ3Ic9Rxx6R05BAX
         7eken+HTDvD3d+p6Gy2/p7LKK0Ric1310eN0zW4SpWYWTYj2AOlD7Ah6t7fvqgK8NSs2
         o571dzkICYydbJ/MRUGa8DGTcCzJlgIEgoWMAjOHmZSybo4htg2nbwgms8lI/q5MrmOP
         bSrA==
X-Gm-Message-State: AOJu0YyisNjqcNXhs2HEGVed1kfC3cF1MPbrFx5tBYlIfBQqgMrHNS7G
	H3PGdGEzezjt5viy0KxSKkVqtqC2owEtfqRdJE71TcB+hoBN6S5ieJCNJKll+JI=
X-Gm-Gg: ASbGnct6T/4xpU0fxP5jetAJ8J6+uhFgOGK04CXzk7Nv2mO7Tox6LXmne0qYMuyKZC0
	w6X6UflxOGtmoBm2audUJo8aZyY3QxupYF0KSgD1qJSMSawqW6SN91Q2tLO+P/819kYxackIu76
	S/nXvfQqAnXCB70dUBm7ITO9RyV7BbzUNOBlHSDaXIhS6QpUHG8ePl2/pVQrJlitPrF9OTYcADW
	FN5C1gbR/CK2zOl/5cj99YbKzIuXrZlfKw0aqUqBeiwsQEJjL7nU0IzgowrOpK/ZYRpfvqQM5mJ
	OdFykhbwycc/H5Dj/GILggN4Gli1iCvIMGiE8li0AAxSCLtPTBNcuoubQjjJCUfIa4qjCg==
X-Google-Smtp-Source: AGHT+IFcvbp8gtLJC59AMKS3IILqsrbXi5WRaOonWlaQrxhFlc2ECurqOsmHdAEFwcZMiNXZhG33gg==
X-Received: by 2002:a05:600c:1c07:b0:43a:b0ac:b10c with SMTP id 5b1f17b1804b1-43c5a636803mr51573815e9.26.1741532260778;
        Sun, 09 Mar 2025 07:57:40 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:39 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/13] nvmem: core: fix bit offsets of more than one byte
Date: Sun,  9 Mar 2025 14:56:58 +0000
Message-Id: <20250309145703.12974-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=fqrKmcbiS1AKaDRrZvXTHaNkz/q/+2qHSl68uGqUaBM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw57hGNgbYjaTbvZPgdzB72XNiBcbLcq4a2R zoh1+IK6NSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N2yaB/9iaoilAtRBG7iGvmqKH02OXEauUvASGpVldy+1IgQF9fs9m0mizKcrop/T/m9Nmg0D4CU yfpiU9aJ1ZDQCvtBXHKmD6E7NHxf9A+lj0rWtQQDJIpimotlbLEGMRfp8yivUiKJSZj/U5N5zVb MG8dBSxoIPbw4Ffk8vObDdATFxV+wPFZU74y09Xac/KgMd4lkLI3xONIfh0lXyw+xqeyODBNZth wOX4sy3zQrP2XKNdIHu+TvacnuYnvntmMVP6UYTwFtXVYmZoIKy+2ouyIyO7T/09OXOzxbOcfo8 tLyE5u+wUX0pSOlZlAVj1t9yahCIhOr4RNOjnyjgJpSkLdsI
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


