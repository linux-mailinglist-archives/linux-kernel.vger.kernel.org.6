Return-Path: <linux-kernel+bounces-322362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BE9727C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D61A285A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150A1586D3;
	Tue, 10 Sep 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXI6q0bG"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF016DEA9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941091; cv=none; b=N3MFD0D32A/O3fWLYzmOQ9I1FqfvcbcBe0A5P3mPOXEajnrci6AvnfPg9uaTjBtPqqRQa8zvOvopAJKvEjgmT4S36k1ha3Tc9pRa6qDSBFwpH2LjOR8KTmARmhf7hEogf6y+Rv5Nr0Bb89dzewmeIqHve16Vl+bchkdgFZjo7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941091; c=relaxed/simple;
	bh=yLjbFI/E6WMKbyPscD4uiGdHMIhrp2uBsRwwZrl1ipU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snRc0Yhn55fzhUxSwETCGXkRqeTUNtPM07So0PKv8Gb2XCs1qZzaW+N2t2bSH3IpQNr5qVvKGDHnXjtRtujZ5Qiz8o01PCRiwOuVWlE/vBDe3eNq1zmgHLqQL5K7haqKVdxUhbots2DRPrqdReMcU6i29gk9cWgqSM6Y+mUGD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXI6q0bG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d21b0c8422so742581a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941089; x=1726545889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFv96eIyjX/Rm1g6rrh4ImmOzw08mdxo0Bz0ACVugwk=;
        b=aXI6q0bGgFK6GbQcasmIHdf2xi6qbEVroG/9fAyoIpOSj4vgDRTamitnN43zsGMI8S
         sx3a1aW8psVhVrA77Yc+aUf5aOUmNR/cpGFDVGw5dz3fLFDDtStbT/DxOmTGYcT5QmAA
         nMUjgmoplCIE3NTS0AF5o/pOAAA8phPeQUp4oa4CtqTlkRVcAlMePofBV+qVbk1/vPW7
         1pP6Su8Psha4nqwUOk9cIKBaHyEStQ5uJZiLhAn0w2He3RERiY2KfIbaVbVzv1j0WrAx
         n9qghJIxPIBen2cR6sBR0ZhjYkzDh7SZUu1xQnwFaYNYfVsssJaDRWfw4bAOqExiX3+1
         jpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941089; x=1726545889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFv96eIyjX/Rm1g6rrh4ImmOzw08mdxo0Bz0ACVugwk=;
        b=s6B43317axQLR6x0nQYFsEMIxDXXqHacrQUkwyECwBs0s1r6lnOg41qRPbEALosK4o
         BGZ+yH8M/vhYL0oGVNnuc5koJaZk7bNx6LAdXTABH49tVT/q7wBayhDegByBP9tuXP20
         Xh/LPCOng8yYPxXi3kNM+ZroSs5uZB+eoCFExY2QNFg4QEBStEeCLokSjvrzCqUBlTi7
         OWF+8hQdmHvO7sdh0NIukh0MmMFIjiJYFcaG5sQpFXgtLPH41D2uYcQVIBtDmOSSqPrf
         4lV1J+yPFb9aBpIKwbU5fPE0rpJs1X/ar5oSjuC7ZZnB8wo6VF+L9Y+WZ8/OjHmWLlBN
         EDrw==
X-Forwarded-Encrypted: i=1; AJvYcCXQACMiXMbmZT7HzTGSIDdLqD4vx/2nufMIOJguXpp2jwCDB3DTr2MkKuuL1ikt7hqCND4FGzkD3aZ5Lg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHhbekY2EyrWaWRJg14CNAzg3vqohhQb1k9c1C2+XQ6ISEXAT
	tz6jig1x2TL15h0J6zxuVm4baYMZAWDkNLQ5ctLGKybMyjMlakC/
X-Google-Smtp-Source: AGHT+IF1+1KlgcjMjgBVIqQ2FMr7ZD1aQaaqg4HWeFp2nehpCNdlivmvWtHrkMxP5WvGnR+yNP0cSg==
X-Received: by 2002:a17:90b:3793:b0:2db:60b:eed with SMTP id 98e67ed59e1d1-2db060b0f11mr4002816a91.8.1725941089060;
        Mon, 09 Sep 2024 21:04:49 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbffd992sm7456194a91.14.2024.09.09.21.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:04:48 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] staging: rtl8723bs: include: Fix spelling mistake in rtw_io.h
Date: Tue, 10 Sep 2024 09:49:41 +0545
Message-Id: <f77f1155d07de7780726562d628e8ed3a3ce4b4f.1725933169.git.topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725933169.git.topofeverest8848@gmail.com>
References: <cover.1725933169.git.topofeverest8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v3: Created patch series with cover letter as suggested in the feedback 
v2: 
 - Created patch series as suggested in the feedback
 - https://lore.kernel.org/all/20240909041508.2412-1-topofeverest8848@gmail.com/
v1: https://lore.kernel.org/all/20240906141104.10076-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/include/rtw_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index be9741a056e5..0ee87be6dc4f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -13,7 +13,7 @@
 	Otherwise, io_handler will free io_req
 */
 
-/* below is for the intf_option bit defition... */
+/* below is for the intf_option bit definition... */
 
 struct intf_priv;
 struct intf_hdl;
-- 
2.34.1


