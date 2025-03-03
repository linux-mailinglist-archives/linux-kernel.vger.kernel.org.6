Return-Path: <linux-kernel+bounces-544489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F7A4E1C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C7018853A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D7207E09;
	Tue,  4 Mar 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="Opd1Ifto"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95825D900
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099505; cv=pass; b=DMv4uY3dEBjfkPMrGJb6zDOhQoZUHmDs0PGIdsMPLLxiBR1UspsAm4npzeAb6ivXtrd/ssW9ZvHUHRvqFUEWwnhF6AGbLpPOayWKCkQEgFPOJe8/5TWppCxQCqfZITVzJC0jPrntrDEoKmRr8qlBxSjmb0+QO0s7MpyAMJHk6hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099505; c=relaxed/simple;
	bh=Y4na+PZuq9qpln+6pQDbOO1I/ozVi+pT4LINH5/Xlf8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SYvKm1hLV41H/1vsoj85/e6JE/g/h7Hf82zojdGFJJVKlyHOolGePoDhfabpiV8iJfhUYGdODFdJWB+BFeTM2r5691EZ5oL0k/yLEN029NL/UGiZdfH44bEpJwTl3xZDGN1YC74ke74gHbsEr271DnZJXEmIGCCInhmkGZH+Q0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Opd1Ifto; arc=none smtp.client-ip=91.236.205.1; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id E679440D4DF4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:45:00 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=crpt.ru header.i=@crpt.ru header.a=rsa-sha256 header.s=crpt.ru header.b=Opd1Ifto
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dj160lgzFxRv
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:43:33 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 043B542763; Tue,  4 Mar 2025 17:43:30 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Opd1Ifto
X-Envelope-From: <linux-kernel+bounces-541253-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Opd1Ifto
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 2D62942D01
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:14:43 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 057322DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:14:42 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC4A188BED5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00E1F0E2A;
	Mon,  3 Mar 2025 09:14:15 +0000 (UTC)
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5901F0E42
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993252; cv=none; b=iu812KvnEwKTExnA7JcFeSwxx+FFJT7lqqnfo5kqg9RxnGvgfiNBE2k4P0ajbim6CzneJnwZEoMwMEItJKsgoe2qh7qdPpxXBcosus7p3IFMz0bPE4ZfffkbTNxKY8Gmj5WusGwv3sVvCtbu5mylctPQNicfesUvPVEDfA4i4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993252; c=relaxed/simple;
	bh=Y4na+PZuq9qpln+6pQDbOO1I/ozVi+pT4LINH5/Xlf8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HdOAl4mQY5k6Lx50SOBwh5DH+z1pd917lpgK06Q+k8YYSG7UzEHSa8v/IrKcrbND/BRF4bRCs/23925yBA8sBoZpqDdAIclCOO2nr30z7gkqmbuhx3yTauQdqKGsG2yXIhCIj8fwQqKfVmAN9q6CsV0r14iJsNarySOmig9Q324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Opd1Ifto; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 5239Dv3R014231-5239Dv3T014231
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Mon, 3 Mar 2025 12:13:57 +0300
Received: from EX1.crpt.local (192.168.60.3) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 3 Mar
 2025 12:13:57 +0300
Received: from EX1.crpt.local ([192.168.60.3]) by EX1.crpt.local
 ([192.168.60.3]) with mapi id 15.01.2507.044; Mon, 3 Mar 2025 12:13:56 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] fs/ntfs3: Drop redundant NULL check
Thread-Topic: [PATCH] fs/ntfs3: Drop redundant NULL check
Thread-Index: AQHbjByXRCuH30BWgkWBO5T9Xi9FhA==
Date: Mon, 3 Mar 2025 09:13:56 +0000
Message-ID: <20250303091321.68634-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=pWgN86eTmOK9MIqHI455dmQDuotfD8lDByCxbx0so6g=;
 b=Opd1IftoPEawGICNHpkbQc77+FGkvgOn7uG7QKYxcgdPYrnSoeVtjTUDs0qZbmiX5U29LNb/Tr83
	XlhLZv9DzCfXuiwxvjkTJ5fywD60AU03zRbDx1/skaPjYw4gn2A9yiYMWGPun2EjsGNsITqjn0hl
	LS/W2EZMoPQhFrNyCxpkub2gcny2mhdl/UOW/TqHC0uQ9Mq8xXVVjSPYNkd0Vc0REvcXJ6dAU/0E
	pVecCbKYFMad4F16anQfL7+7/SttQ1+PTC8dY3uwIerHeloyU+KJjQH4WQoe24GqnG8DWjCxSRda
	AnZsasnah1fxbU4i9BwOo6HZtE+8cB1pFILGQw==
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dj160lgzFxRv
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704228.84701@v4RcShEroNVwkwM1I6l+PQ
X-ITU-MailScanner-SpamCheck: not spam

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Static analysis shows that pointer "mi" cannot be NULL, since it is
pre-initialized above. A potential failure when mi equals NULL is
processed.

Remove the extra NULL check. It is meaningless and harms the readability
of the code, since before that the pointer is unconditionally
dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 fs/ntfs3/fslog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index d0d530f4e2b9..03f3292fa987 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3143,7 +3143,7 @@ static int do_action(struct ntfs_log *log, struct OPE=
N_ATTR_ENRTY *oe,
=20
 			if (inode)
 				iput(inode);
-			else if (mi)
+			else
 				mi_put(mi);
=20
 			inode =3D inode_parent;
--=20
2.43.0


