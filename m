Return-Path: <linux-kernel+bounces-518057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFEA38940
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FE13AF2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA1225A47;
	Mon, 17 Feb 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QslRI5Ho"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1818225A20
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810012; cv=none; b=aezIdk4JANYF7rN0K2bNZalWfhPyXcASMFGbh2A1B60S/MlCvFmLNTAr6E5iaCV4eYIv4wXZNLCj1y9NUHCLrJsLBe5nWgSqXzLqWow2qthasthGVk22UczZegwu3IhvCHZAvcVN5YClYF6FqPWSk9Lm96yDs6Ew5DEj94hX07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810012; c=relaxed/simple;
	bh=1bE1H788nkndn5WpT67KXk3syh82LSTU83DzpaERA9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe+nMvYKRuLAQ0WZhrUiveVfyjWsMR5Dg0JQEu4ja+nwbuoUA5e6Q15VbpHpWO5ZtNKmufnM+t2+m2q3gRWv7seWh5W0u8TD5y3XC6awhrJDvkQXDtD0ObN9/CCgO5HtBTSzTjwStOjkB7yTrus2gC4uJTnY8wxf0gzVuEojwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QslRI5Ho; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54529eeb38aso3300411e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810008; x=1740414808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqfY5O4DAa35IC0/x8APktybht+SrgKAkJthvFS6Lv4=;
        b=QslRI5HoHPHFkzA1x7ba0bvQEc7Rob9wxBkwiuryfT4ZxutAQ1kcz3gUGtlxnS9otw
         pFBojZeywbj3H8NZm/s7tNKWSF+Xt42r8RXDzP9Bu0yjOCb16Bn1DZl6zx6Nw0m5c3RH
         bADbzegG/bALVYIuo0Z7/7ZapJWyDL7Op/Uve4/VXaM0MTdGwimqEEa6R0pHPHlgKti9
         gFR1EY+nMRoJH7oYDwT1LpsOGgC+7DaiVQjM5NOqCMHoXUeBdY1mgxVNtgypf2EE7V+a
         OmotBfyAa9xXqQXryM9K6Aato8V83TK/toWFPHSTroTLsYnukMEYCmFMQ/1pP38B6N4U
         zGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810008; x=1740414808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqfY5O4DAa35IC0/x8APktybht+SrgKAkJthvFS6Lv4=;
        b=wtx/e8Angkm8EhgkOY2bf90czUd9VT8A1+0CipiaV64IuCo6f3A7L7bKiqlzIRRUMf
         UoLi/R9oWiuSIATnomKGnAahU7ZymulwXq3bLhfoVXEXkBI3DOX99qzOA/IeRIC5/kTX
         C+oCOWMyTROjef+aBSXhn2vs3U9ql9WHyg+PyfWOnnwpWSS+l0saewDEq+jCc/9n5tqM
         rY0+MsIOZgpUpE9bB7ghVxgkzwxfIkSC+DDyxBpbPg0FoThtcIlFdHkBEeaoipw9VV0Y
         owlwLpotzeoWk9EMwdkeAHUJgwdfXpj+C+HPSWKQ9EnU8bPB3SR3VcFRnkkk9INmzaco
         L46g==
X-Forwarded-Encrypted: i=1; AJvYcCUlgjyCCDW5K4SmPkRJSi9RpHY5aZ1YnVDo6GPxLJPzOVzNCoy/n2yaz+2Vljv08Sn3fHvt2BF+7uncXsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4Uz2WodVhXzPB0AZ1MiQkZMyzvQE3Bbag4DRvHzU6dUkYmaR
	MHJKxrkAuZiF9jwhMUrcXRiXZfNh6NnXXwrnVJNVXKBOvwN4d5XzJafDBtY9Ztw=
X-Gm-Gg: ASbGncsl55c1xos/1jhoUiRtkAcgv9KwVhhCJ2P831v/qJBpRGWyP7cNZ8PG3Y5U90v
	YxRWl9UshknL+eoyNAaq8zO3s6/r7BJtBu8LiuaZmHXRAy6lUxSWeFTkhhQsASofxmf5h4V9idT
	kM86mCRKrdHD+5UjbNP7P/gRfud8jbt8xOeWxe1uCbMPiAT/NIb8u8SLL58eOm14megTTBO3bSk
	/gZnyhNXtyIeYzJIXscodOu1W/J5OmvD8Exi28xO67kCu9+yuwErSLsmxX5pSKW30ILKdlDKAzq
	2Xd6UMnzqLSqpre16Go2zKLo9/Xxo7Tdi4FWsUclIqbtpKGAlxHKOii2Qeg=
X-Google-Smtp-Source: AGHT+IGvyKTEtQYqLlzIkwF+KPWXzOWc1uhtIoRf0rAuPnLTDLg8j9JwQOoNLX/NFdBWeLf6hYNn4Q==
X-Received: by 2002:a05:6512:6ce:b0:540:3561:969d with SMTP id 2adb3069b0e04-5452fe8f8b0mr3703568e87.49.1739810007704;
        Mon, 17 Feb 2025 08:33:27 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2cef18d1sm5695991fa.76.2025.02.17.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:33:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 18:33:19 +0200
Subject: [PATCH v5 2/5] nvmem: core: fix bit offsets of more than one byte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-nvmem-v5-2-2f01049d1eea@linaro.org>
References: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
In-Reply-To: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1bE1H788nkndn5WpT67KXk3syh82LSTU83DzpaERA9g=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns2TQDQ74eoBJ0Ob47kSFE87N3HMHSFSlm31GV
 LXj2Ym1GsmJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7Nk0AAKCRAU23LtvoBl
 uA5oEAC+rBH1y65jn+MdJB9Wr8vIjiEhX90bpsuoUJainU8PP0FH78HJv+4/EhA4JXs+iTeNqqe
 dwUwHtGFEIOirfOlJp+Gw7yV3gGkHvuFCtT8VqhKU2zZOQ6kb2gWe0gUp7wA+nPGkOup64e2uxt
 N7O9tS1xvr1HyRmeCKGcacm1ddcSlkSEgSlWBgbF7G81cedftPpWazLUla4fULGybklJyQa0sAA
 0MJi8U9TrajgTelQy39D2MwSFLwmeXQlgDa2k6HUFBl5qwsc9RdfPMiZKW0dbn3pvT5QTlpPKlJ
 nOEYZcu2aNUpsAIh3UH7K7WhOmpsj0RtpjOjGGR/5B8/bLf9NMX+u9oIB5tuN02SKuOyV0eHia0
 msnfqo5lfsG0JRBA/aY31W9suAUdkP0EOGYwvFJ0qvqQumZ+HksvCPECMwIhm2knnY0tLEQIGLj
 VYBfTA8O9gX5C3Q0atLaqwJpBj/01mYpaMeSmtan05yoYW60NZUCcRno43AjMaFNopaWyuHPmEY
 GDZed4u2teOSl03EayOXaUVtkopmVD0fo6JwBITW1PXOsNnaAiJGbJxzOYlVIE9XH3QFLO1+Pjb
 deAlE1Wk7jkniuN8s9GmGBdhP5LGznyo4u/Zk3f453HyxTDNUHYdYcOlT/zrT7P2qU74Xrf4mDb
 9lZEJpVvzDPdxtw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If the NVMEM specifies a stride to access data, reading particular cell
might require bit offset that is bigger than one byte. Rework NVMEM core
code to support bit offsets of more than 8 bits.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/nvmem/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fff85bbf0ecd0f638e21f127370105d9f79c00d2..7872903c08a112f11618a5aa6a42ba505106ef6d 100644
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
2.39.5


