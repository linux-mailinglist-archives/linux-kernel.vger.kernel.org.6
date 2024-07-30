Return-Path: <linux-kernel+bounces-266865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9D9408DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1D71F21A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DC161939;
	Tue, 30 Jul 2024 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puida.xyz header.i=guilherme@puida.xyz header.b="ZKad0ZLw"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B7241E7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322114; cv=fail; b=QuHNSnH+2ZlChE5FmpktI1QGtFXJidjVBGec8KdAgagNfK58ZhxUr/ZCfdXF5XNiccax8HIIjwg1Mz3Hjv15EUmaea34ZV8RNA71QyxP0MNaMepDj0sYnXQusH17Uy3h2OgWJt/MnAAPG3eA+b1pQ2GxPONfgpTGGW+vODNyX4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322114; c=relaxed/simple;
	bh=vN9SIByHzXwNm9whRVmNe/Woa/Y6SvNO2dFuhYWr5ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M/zVcS8Kh1OaBA4HE+9ZUmitj22zgJhSbrsPo790A4VQ+9aTzZFlbbTbBeml371U4/aQsyRuic3OOKo8UIlIi42SuY3he8jYgv7knpnlI9q6xXDb9+XLWLkw+Wzw7HP0823WeDgJxo6Xc0/O//Evic+xtekoaSVYTcNGDjxbB3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=puida.xyz; spf=pass smtp.mailfrom=puida.xyz; dkim=pass (1024-bit key) header.d=puida.xyz header.i=guilherme@puida.xyz header.b=ZKad0ZLw; arc=fail smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=puida.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puida.xyz
ARC-Seal: i=1; a=rsa-sha256; t=1722322100; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xsk62iHOBTAUjGEcT/OfX2gf/Q0kFydrh5Q5teo/lHT/iPypwg+Xy1K8r8YG+ssiBU3OQXWfhJ1vl4C7hSfzfPCU7v6MAmgu9j+1wSuBiKGKJlBRaqy+kdNpqHJ/cMlYh9o3SiDloeX74BDpmR1+a0lPtOadkOlTHxvv0EMGJoA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722322100; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:Message-Id:Reply-To:To; 
	bh=BfTSVbDgPto1zryF9/kfDoJnWPdqY+wIibqrxaSUyE8=; 
	b=HNHgtstdZgSOaYd6v4DLW0tKWCIwi5kZv2BFrd3oIYjt45sQ37ivanFf5Q7OvD69EvO0j2xVxuqLGcAvsoTxy+ERHym0Ms5gBBJKojB6Th3DnpwcJWKAYhv7N7s5ySzkn0znXy9QZf9jKqQd4dQnGamkL4JTSv3zB4ygnjGpVVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=puida.xyz;
	spf=pass  smtp.mailfrom=guilherme@puida.xyz;
	dmarc=pass header.from=<guilherme@puida.xyz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722322100;
	s=zmail; d=puida.xyz; i=guilherme@puida.xyz;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=BfTSVbDgPto1zryF9/kfDoJnWPdqY+wIibqrxaSUyE8=;
	b=ZKad0ZLwr1aKXSyg0ET/Yy9AwnTLKKERTBTaAngBkcWgl8YWpzBE+yITH2sYJ2F5
	x8FYF8qbD5LxZRrEQ7dnNfm9qBWTzQKv2uKvrVFNrPyG19c10cNbb+q84ymGk8uunEB
	QtsFHs1ZwZRl6m/B03RCzjdpbk0xtZw0nIl1aKbY=
Received: by mx.zohomail.com with SMTPS id 172232209874270.12992549102853;
	Mon, 29 Jul 2024 23:48:18 -0700 (PDT)
From: Guilherme Puida Moreira <guilherme@puida.xyz>
To: 
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: place opening brace on previous line
Date: Tue, 30 Jul 2024 06:48:12 +0000
Message-Id: <20240730064812.1979-1-guilherme@puida.xyz>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix checkpatch diagnostic "ERROR: that open brace { should be on the
previous line" in rtw_security.h:173

Signed-off-by: Guilherme Puida Moreira <guilherme@puida.xyz>
---

Hello! This is my first patch, so go easy on me :^)

 drivers/staging/rtl8723bs/include/rtw_security.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 98afbd305..c3e47d526 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -170,8 +170,7 @@ struct security_priv {
 
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
 do {\
-	switch (psecuritypriv->dot11AuthAlgrthm)\
-	{\
+	switch (psecuritypriv->dot11AuthAlgrthm) {\
 		case dot11AuthAlgrthm_Open:\
 		case dot11AuthAlgrthm_Shared:\
 		case dot11AuthAlgrthm_Auto:\
-- 
2.20.1


