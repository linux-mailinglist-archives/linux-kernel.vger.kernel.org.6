Return-Path: <linux-kernel+bounces-541355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F57A4BBE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E616E5F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69D1EFFB7;
	Mon,  3 Mar 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyV7mTRL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317581EDA04
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997200; cv=none; b=MYVsCQzJ7VOXWrn/BEN8fsQbvDR2X+xCKkVMbVDgRpOM45XwXcMZBG3wIp38rHoyLz1/Kz7bkgYqAJ1Z5mQH/iUEgxkAWIckqEjCkxw1S/6NWhjheCp8qSI6Nf/jp5LlWF/uFbIHqHaAL6cWJRlO7kUXbARda+SIAukjh9zBfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997200; c=relaxed/simple;
	bh=HxVdEkr7I2moERDn0q1ARJ0Rw6vcwwih2/quCJhbrVA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TW2Z6seUPh37TcG/BmNZImkpGA4nOnKhB2pwuEH5fiWDekgFBDEjvE5zqs3NmYPq2ANJoL29galpKEQSAywIiItCHPVrpAfqtGhgWe6OGGJPKxcDjkagy41EZi1doiOaI3rGZv+rgRCHoyuSDiX/ve4J8abk3fBvQ+1oiuNg+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyV7mTRL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223cc017ef5so3249795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740997198; x=1741601998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALzECRug3pCnEgmKD7GaeWIQgfl3zaHcGtQwIkelrJo=;
        b=PyV7mTRLjKYu80SFD/iU5QHIjBEWx9YKiPmRk9GZvFg2gXelpArWR0w3JXsNQCLJvj
         3Puzdmugk5qGqiksp1qTu3+RC9xfepbkCO4ETA7Tl4yR4hdaO0aW7CEZs0OzSX8LZoGn
         1JGGOQ8dysjn8igH8MMZjpzp3hKtcRCrA7lTU4jY872hoszlRxd3iyDP1Vq/gzRvIFlj
         3WpNXfnX6s1OcWrquf2arPyx2BbUPnEOzmLQTeLBptVFG1prWIOoAhH0Tv7FdlmoGVcg
         Uzz1RY9Itvf2invuwGtr9+ME+5yswqiM022QCJqE15ttv6PEkdhBQAsjBBRPPZ7NyUtu
         3QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997198; x=1741601998;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALzECRug3pCnEgmKD7GaeWIQgfl3zaHcGtQwIkelrJo=;
        b=EbCu3OLTpvk5HUK2toFvNADbf+Iq/ArHP4Gbn1GYK6VHDygguJY9naVjUsoc4EC9zt
         K1izTS0H6B7CF+FX+Yg2VXwwuPHxP+oCgrc96PtEECy7ftPNE7L3tGqeu0XKWBCiYJ+/
         MdkKl/esC0ATXYpzyTW2w5DVqb5WC86rkcTEmXK5Etp9OzTFkUgXzlE+2pkM/y37BSus
         NbBaflWlLaBUOUnKdiomGwM6JJdoD3ypY0QOn7UYdKDsupiBAb6BMAWcTYTmamDclvrt
         aURVM6JlpnPSR3nu5HltyPKS05QjXIVNNRIhTbepqTnt71dFP2bSti6Kx0EeQAR+SpeV
         v7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW+AzAwXZqu1xNlx1/M1mqIiHMJ24iptAtq8/lLg0y8Bqx4lIvrUwQfagctCCbftGCtWrLOevd3jg0ou4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUCeFJA5B6BRbQG+69Sk7SptvIvezMMX/hRzQ/YOeEUSf5xhbr
	aG9RMkX+b/IDQJzkNmUeEY2fsLrAYl62oHXfYupZ28lphlYC+Fmv
X-Gm-Gg: ASbGncv4g3yAez55/UnoVfTRhvBbcNfNPEbS/c6kW6ki/gJyu92vkD4tp+fgCp5qoBB
	gYxT93zXY9DUjx59/qPtAlUJTghQ77Lga5q8ezgLBxEyW2OaC9QiQ4AVr52/zaE4P2ORAYuRB4c
	Hkb/gOHkaDlaqGK8mBRkRE1SFwrtODx6l4xi7W0AT+MDqP9gtHAVHuEJt14yL1GTbv2fnuOaTcw
	E4I2FcS8zpq1its4s3CiiO9dzPl+/Hjpp097FcE4eixtZTB71fPFlCIZGfIegw9AHSYBjGJkNTo
	BqZD75uIureI6gNLMOBMaLrHRzB+1aQnt8K1Pz4hKFd26iHJODIlqoU=
X-Google-Smtp-Source: AGHT+IHrGUCiyixgFG8XWQdXSW3V+lsIqez0Ar8UD/Zaws7YPzoId5LD3q4VQeuaq9BKNRu60//xrA==
X-Received: by 2002:a05:6a21:3a93:b0:1e1:aef4:9ce8 with SMTP id adf61e73a8af0-1f2f4dfc2bamr20722457637.28.1740997198226;
        Mon, 03 Mar 2025 02:19:58 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363f2e8a34sm3287638b3a.168.2025.03.03.02.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:19:56 -0800 (PST)
Message-ID: <ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com>
Date: Mon, 3 Mar 2025 19:19:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
Subject: MMIO write access to an invalid page in i40e_clear_hw()
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

It seems that there are invalid page MMIO write access in i40e_clear_hw()
due to an integer underflow from num_pf_int(also num_vf_int seems possible).

The following is a sample code in i40e_clear_hw():

val = rd32(hw, I40E_GLPCI_CNF2); // (1)
num_pf_int = FIELD_GET(I40E_GLPCI_CNF2_MSI_X_PF_N_MASK, val); // (2)
num_vf_int = FIELD_GET(I40E_GLPCI_CNF2_MSI_X_VF_N_MASK, val);
...
for (i = 0; i < num_pf_int - 2; i++)      // (3)
	wr32(hw, I40E_PFINT_DYN_CTLN(i), val);  // (4)
...
for (i = 0; i < num_pf_int - 2; i++)			// (5)
	wr32(hw, I40E_PFINT_LNKLSTN(i), val);
...
for (i = 0; i < num_vf_int - 2; i++)			// (6)
	wr32(hw, I40E_VPINT_LNKLSTN(i), val);

An example scenario for num_pf_int:
(1) val = 0 (if MMIO read value was 0)
(2) num_pf_int = 0 (also zero after bit field extraction from val)
(3) An integer underflow occurs (num_pf_int - 2 == 0xfffffffe)
(4) Out-of-bounds MMIO write access if access address exceeds the expected
range.

From above example scenario, the maximum access offset value can be around
0x4000347f8(=172G) which seems like this underflow is not intended(also there
are masking operations like (2) for num_pf_int), so I report this issue.

I think similar issue also could happen at (5) and (6).

The following is the patch method I propose:

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 370b4bddee44..97ef79be39b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -848,19 +848,25 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	/* stop all the interrupts */
 	wr32(hw, I40E_PFINT_ICR0_ENA, 0);
 	val = 0x3 << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
-	for (i = 0; i < num_pf_int - 2; i++)
-		wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
+	if (num_pf_int > 1) {
+		for (i = 0; i < num_pf_int - 2; i++)
+			wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
+	}
 
 	/* Set the FIRSTQ_INDX field to 0x7FF in PFINT_LNKLSTx */
 	val = eol << I40E_PFINT_LNKLST0_FIRSTQ_INDX_SHIFT;
 	wr32(hw, I40E_PFINT_LNKLST0, val);
-	for (i = 0; i < num_pf_int - 2; i++)
-		wr32(hw, I40E_PFINT_LNKLSTN(i), val);
+	if (num_pf_int > 1) {
+		for (i = 0; i < num_pf_int - 2; i++)
+			wr32(hw, I40E_PFINT_LNKLSTN(i), val);
+	}
 	val = eol << I40E_VPINT_LNKLST0_FIRSTQ_INDX_SHIFT;
 	for (i = 0; i < num_vfs; i++)
 		wr32(hw, I40E_VPINT_LNKLST0(i), val);
-	for (i = 0; i < num_vf_int - 2; i++)
-		wr32(hw, I40E_VPINT_LNKLSTN(i), val);
+	if (num_vf_int > 1) {
+		for (i = 0; i < num_vf_int - 2; i++)
+			wr32(hw, I40E_VPINT_LNKLSTN(i), val);
+	}
 
 	/* warn the HW of the coming Tx disables */
 	for (i = 0; i < num_queues; i++) {


Could you check this?

Best regards,
Kyungwook Boo

