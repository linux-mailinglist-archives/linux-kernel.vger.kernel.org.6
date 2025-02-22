Return-Path: <linux-kernel+bounces-527150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD9A407EC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C18702421
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5A20AF7A;
	Sat, 22 Feb 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq96x3qt"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0320AF62
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224235; cv=none; b=L0qzuyP3dn0qkADsi91Ocr6AMJ2EUcOPOsQFIim5l3mIi309rtIyOMFcqkiwuj5a+LlUKfcKff/c3GPDcPb25pHP8wjiwCYgg9dYyZuj7GehAcg8eKYXvOe/3yLU3EvuHMSio144plnaml9Zg5M9LeiG5tcRVoEAIdPmRkxVEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224235; c=relaxed/simple;
	bh=6Y2aFBZyhM55V2Qq3a19NXHXXbUzDjvPB28oiQBEHOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NbStmhso4lh537vmu5cVr+qCTp77rxPoyqVqn/1ezCvvHISCvGqJqQVVJgJRSjONK/Wbl6xE5b+2QWo3PASkC2K9MDbB25Msx8LxCoeYPrsbZINmGN/zJKB9UexR014aTK9ieQlsMy62ZClvcYTxuXO0t1xGa31sHMW9PAn1KgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wq96x3qt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso625881a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224231; x=1740829031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0H2diZ7E/nwkLTAw+jOP/xKPBpOWiWdncq7SZuIVqs=;
        b=Wq96x3qtcqHUtGUa/6e9YSomlxOfXYgXU3VvZaq+LEbVk2JBo37bXAAg2Uv4TBJrfe
         oMfungyvOY1BSiH8IRALJJIdt7dIiBl5vhIkCpIMqzYgnK3xE/bys2dNRjgle+XugCU4
         8KoVwrusNsEvjfBl9KmVpmpVQshHMeY6s0QNlt8ImpZ7mQDigEzlBdh5ziV6QCofbX8m
         O4c0XFHOrFNrUFdzuWL/iJJ5b1Kx2pwzpehltYcw8EEDYh1h6tok2ewAiMfhFMQrAKUb
         UEtnIbfTkxJLiihisE3dNZo7y3IL2k/NuvCEVgrKRCX8+VrI2Yiumh76SByI88aRGscL
         x6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224231; x=1740829031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0H2diZ7E/nwkLTAw+jOP/xKPBpOWiWdncq7SZuIVqs=;
        b=MyUnfo6aJi8cOBkJKkFUrIg+iB0ESRX4krz4KKJjGjDBWjFiazipGCit1EoYHdvnlm
         XF0fhXfay3e8lKY97THtCVF9W+WDcGF1v9DjwHYQQr7wiAnlMsB/y1tJJcfG39MXFsub
         KaOQSAohCF7Hzw7FMCBKPN8IVgHVJNyoFx9MDW37FQyOduJhc0lmDBBCddyXfyIFFNmk
         A7ZlvI5DCl78ZSlUYFiG+0qyrILAeXaDzv3SnsMCeNhaTpzf65aryLm/FG5SRXeJAdRD
         H5prGxinTEk1q8O02bTBIs1vla+WZBKONat6bdValP3yG0Fej36kT+72EAfpB8IIILi7
         qy5w==
X-Gm-Message-State: AOJu0YyZEiIkSyOeOUhInZlBly88U9ZtK220I53g0m+96nlvJw4U/wh7
	DJ7eCufVaTL9qq3ccnRmhaj6o54XV9xh3n20WWail/0J3mSzox6yfmrm2eV3fYeCJbr27N0yyZn
	OJfI=
X-Gm-Gg: ASbGncuGH5hIpy67DY5j6WuUhVixjdGNqjAvk9io5fttNKN0IpFX/EgcdkBp6CofaQ9
	NzXXdLlU4CDyoRF7fIrr7/d7E9HumFSkHm9E9y0osX+YFJinW5fOA9snx4+hnUJn/VNYd7EYDRT
	Bv353ZZZ+uqIEqZmv0o7kE57ynynnN42sTpBv8iio1KB+dEOCjo/Z16KX8xpey6fFyyGwrv1Y+e
	xafFlxIwmHHVeseQatOqa3ixiuisZPzrqz83Z0vruZZIfIddI/HCZ2q4j5UnhuxLrC3G+TknElj
	3ZXYPYefhQtYZ3TYWZijtja2SKUbwLhvv5CfCJARhGaKkD00qmQyRIrFB+OnEwKoAaq8GunGWao
	K
X-Google-Smtp-Source: AGHT+IEykIKgn6Gm3l/QIX0IUkOL8ddjfNCJCK5etjBMh1khNAHkPXoyIg08wOwN4XCdV/B8jHzXCw==
X-Received: by 2002:a05:6402:2108:b0:5de:3b3c:d02d with SMTP id 4fb4d7f45d1cf-5e0b724a9ccmr2297910a12.9.1740224230622;
        Sat, 22 Feb 2025 03:37:10 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm15011493a12.37.2025.02.22.03.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:37:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:36:18 +0100
Subject: [PATCH 2/5] mailbox: pl320-ipc: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-mailbox-const-arm-id-v1-2-d60589215a24@linaro.org>
References: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
In-Reply-To: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6Y2aFBZyhM55V2Qq3a19NXHXXbUzDjvPB28oiQBEHOs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubba+WwvmRRzHwfgY/uWiC7WyO4doo8s2BhGu
 n2jUkx+R3+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m22gAKCRDBN2bmhouD
 13v9D/9Qup7BsP0Fdxdl1ErcVNMdsWUIScwlDLWsi5cY7NLOS/QM5M09FvKuFYgGT0COS7H1IZ4
 baY26G20gK6j2shIsiNZ7ycxsYXYe81aKxPEUywLeI4C85c4dtFQdGYdGpBh8iCFacp2YT43zpZ
 in9GMDgX7de7pCv4cgJTzAInLT7fRUJrJInNVvikdfp8L63nm35EmKq1rUaNjJCMzvv8VfIHd95
 BxzRggFMwb90I018VHk6Br4HF3EieOe/L4bns0lWnwjuzJesvo+rzmUpYVjVOW/t2eeH7Hsm28F
 OhDP1SnqQ2+ObXXUFA2C0ah9MtO925Q1YJdfpqPvoD3ZEDSMT9Q7rs00aFEo48k7m6Y98ucF8mB
 accT2MLSvtmJ+js61cfXHI1VhxwufUxTFiQu/JuBIEa0nu/YUMp/cHRgcuUr60ozV5km7/13tWt
 18eR6rjwY7+mkB003qAdA1RBCDlwkBUbcTinhFIg5/ql6Jb+oXGJXMeZ6eDoHR8YrnRE+LM5qZ/
 +yu882WSA22PWRL7MCQpPvyF0T46ymNdKnUO/V9EoKYn9aIJXNU1EGLDhfOxtkQfatdaxsyMwaG
 Z5DkUu5GG+TkPUaHtvvkQD6g5l0A2UO8pFSGDFCxtPJ/H2oX0iQaAkr2AcUMpKrtqXkUp+BPols
 hqh98W8WnfEjJ8A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/pl320-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index 0b807bbcbde07255116db40cc9d9028711135fe8..606f26a2a6fde4adce0c1a165a9746a1f2b639d0 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -152,7 +152,7 @@ static int pl320_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static struct amba_id pl320_ids[] = {
+static const struct amba_id pl320_ids[] = {
 	{
 		.id	= 0x00041320,
 		.mask	= 0x000fffff,

-- 
2.43.0


