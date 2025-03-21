Return-Path: <linux-kernel+bounces-571435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E96A6BD15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FEC189F427
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01F1D54E3;
	Fri, 21 Mar 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAAaP09q"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC31D6195
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567743; cv=none; b=ueOC87w8bdNxYLfQeTnW4257jkWSXTLYORZb9U+8oRFC3Rr0XYsgGGIPdgl9Duo2DwbTmBOnZ6ylLZJvUEnG/a595bdCtK7hzGO+acRRUt0uljPvz9cu+7XLk7us0maxdo+vay7fbP9FofOe7udC1m/FrVfzn4YUfu6iOPRTU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567743; c=relaxed/simple;
	bh=2fWMldJmgwMUu39tdUGRd4PbG+rFiQ2bc0jCTZUfh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l7CtdbOgC3TDU8qGXC4HqkokwUiksA9TP3UQ+WXtmbi3H9/Qxr4qsj4n+CNJilzmyCJSymWqs1M1D41xmNRA86XK3I5YMkKLW/VP/0KfnZpKUzQQErnKZim2bxrv7vtXk1etIHbFsV4eiDNVMZhfTciO9M+cfY+1ap+mBR+LAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aAAaP09q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2063788f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567739; x=1743172539; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PPRppdrVJ7KjI6wixZGEvPAU+S5utOovE0gqiXmI0c=;
        b=aAAaP09qNuJblyS4TtpIdwnKa8aYrpNyeRhPqWeeQSFO1f1eE5c3k14Jfel0LkSBt6
         nnHwpvKWEjjnlv/FrgIIssRMLWtVqaesxqr3QGq2scm76uwOzd5Mimg3A3tXp7KUFheg
         /IxbIZrjbJ3fFFND1LK9ItekDVG9YLnDNxCDFpmj/Wf7nfj5+X3Dl+66kdXpblOoMVuE
         2cDroYA/mKt+8c8nvYo/+7Z5cYjSoJPDEoqCw4/G7VCK0vfMXHOUncYJ2yfNmagirg9M
         JhpNhJVr64SWvBeCMiIOiLbxwunGI0E4Mc0eDThYfIT+TLk+P1xB23RnJrxPT7hO0JcQ
         nuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567739; x=1743172539;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PPRppdrVJ7KjI6wixZGEvPAU+S5utOovE0gqiXmI0c=;
        b=PgzQFPkkSDbM+VB4lzBRG5fagEMeXC72ghN5WOfi+DoSZ63fjP6BcASzRxWhntfqob
         u0wL6zmElcOmZaaM2pQwg4/tT2vRCpA51UUoq7LvhEQZtdHEHw7IrymsjJvT103AnfKQ
         MiqV1lBQc2BjMo+LhvKsZ2CD18Cknr1UxO9oCMmvdnbeSyaQ/5H0u1FN5/XbcaOw4+Qz
         6ZRK/z6aOPEhyQaUlpZ7N5z/hYwdWdH3imxoAjRmUjkWMM5gweq/sOJCk1I4WBqzQTWg
         CBY0hWYi1rpHcWCCH/1aDdL/Fimtxd35/RbJ2aQ+8oA4cfjeZ2cVB7NzbmzSMIkzpRj4
         awqA==
X-Forwarded-Encrypted: i=1; AJvYcCXjyTh3GLVgSi6oSLENP/49G5tUFTIWu4Tv9Bt4ZEo8Mm8HdN5OIqODe75RZTxv9Jon8hvCVzlDTUkaZ5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8XrDLwDrQv97DTzBSXwo5p5JPXJVk+5N8a+7Y17R1IWGTs+w
	iAt0D+pxvcnPDX1OlCGNacJRxbhpMCdscH03TKhysnUGBK+r7rDH7aj1ZiLSLlg=
X-Gm-Gg: ASbGnctavoRNa92nJM+iPg/QG8a/vF8gGx8hm0IO1VFyExgdQmEJBjolaRQsr1nAU6m
	fpClijg87jJ9jPddyf0bO2Ka+ohYwHBXf4c6U3DDUkIgIS9+FUSZPkxtgmUyJhgK12q1npCSDkf
	Jl5u9t7K61D3HLkCrU5GlvSUlISP1duNbRq8qhVVEDD30ehe6cmyvqBmp07VE5vBiUsuVV+ctHo
	8lRnFTbWYsnTnE8GzDI4zdpQdaC3fhBNSzjBNc+Y8KmnBspQBOHEeRY/sQdmBggQ/1vwJv4kuS2
	OnASakdNYTJqSRIirsNwR+5Tjp+hzjlFPPb3nF8ePz2mEebTlg==
X-Google-Smtp-Source: AGHT+IF2afE+amq9nc4FEedeUCaZRhGRjLvVfJvTuEgevNOAdUUfdZR/acRzOI2V9GG7bPnUNFsa8Q==
X-Received: by 2002:a05:6000:1fa9:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-3997f93e053mr3439159f8f.28.1742567738601;
        Fri, 21 Mar 2025 07:35:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9b26a6sm2493540f8f.44.2025.03.21.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: remove duplicate check in
 mt7996_mcu_sta_mld_setup_tlv()
Message-ID: <fde7246b-08a2-4c2f-b2dc-c3fd0e6b300b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "msta_link" pointer has two NULL checks.  Delete the second check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ddd555942c73..03539e20f5c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2242,9 +2242,6 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 		if (!link)
 			continue;
 
-		if (!msta_link)
-			continue;
-
 		mld_setup_link->wcid = cpu_to_le16(msta_link->wcid.idx);
 		mld_setup_link->bss_idx = link->mt76.idx;
 		mld_setup_link++;
-- 
2.47.2


