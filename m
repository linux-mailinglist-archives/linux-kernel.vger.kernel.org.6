Return-Path: <linux-kernel+bounces-566247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107FA6756A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347443AD5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6C20D4E8;
	Tue, 18 Mar 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="jAGSr8Kf"
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558520D508
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305361; cv=none; b=pJHRQ/DnDNipU2OSmoEDgtM6UaFGyWAXkhCbQo/VHjMfDFOx8wT99hUNBv0jWW6ctHeZQDVoXrkkc1ed/hC4pAd7bJ2Q9AdHXBHGpumTus5Gsa6hZo/DK7w49Jhp58+NZy20nHfvIJL+psA9vhrA6Fb6BfeZMEYj6miw7f8NCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305361; c=relaxed/simple;
	bh=zHBz2NzGYeN8kH4fiaKRZfcg7nVFrjGejjkp7DglSnM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IVTSl9y9jNuAXbFLBsezb3F+pp1A9kdwxkKoLkZGO3rabPcKQehq0nD9wemvaWlqc58w4TCNuTMlaIlhnga3ao7Ce8z4nROsEOyrxK+Sy+och7SKiUqUuzE5hxVaESdS9AAiNr/6LUjgViy9aslwDjyQi/LE/X6UGBGP2S8bwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=jAGSr8Kf; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 52IDgI81019229-52IDgI83019229
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Tue, 18 Mar 2025 16:42:18 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 18 Mar
 2025 16:42:18 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Tue, 18 Mar 2025 16:42:18 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH v2] fs/ntfs3: handle hdr_first_de() return value
Thread-Topic: [PATCH v2] fs/ntfs3: handle hdr_first_de() return value
Thread-Index: AQHbmAuQAyfNJudJa0SRheQB6mnCWA==
Date: Tue, 18 Mar 2025 13:42:18 +0000
Message-ID: <20250318134211.149170-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/18/2025 10:14:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
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
 bh=VrN5ggXU+9ieg/XF+YNQbzdFaG3OPBPHUDO8pb+HC5g=;
 b=jAGSr8KfziJ4q7X3/WbDcNYYlVIG95qByWIysHPzrIB1lIDZomy2SvhnT1QX6aj0QDoFy6v/PKhD
	xtGc8/cJIgwmetqlMmDHIArgd3oLX3BVrl4EqeY5NHvY+GkPLa2BaPlT3QXtiLbcdbmy49/pK851
	iYfPikJKaOg2Vux6OpruOMwsXnuFJjm+4DLppLbPHUsqmpMaGn7nynLAyskdjiFOIoA5Z6eGBWRF
	QrR5Bt7R3dlwGIXrftzaKMs49igm8QTcl/79eJepV6We3MK6DXKjjEH8lR7ihfqLYU//wjgFMGge
	oZE4PVWc6KmyuDS3jyncoOTxDqdswSjlNfGyNQ==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

The hdr_first_de() function returns a pointer to a struct NTFS_DE. This
pointer may be NULL. To handle the NULL error effectively, it is important
to implement an error handler. This will help manage potential errors
consistently.

Additionally, error handling for the return value already exists at other=20
points where this function is called.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
v1->v2: Fixed memory leak.
 fs/ntfs3/index.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7eb9fae22f8d..12bea99da3dc 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2182,6 +2182,10 @@ static int indx_get_entry_to_replace(struct ntfs_ind=
ex *indx,
=20
 		e =3D hdr_first_de(&n->index->ihdr);
 		fnd_push(fnd, n, e);
+		if (!e) {
+			err =3D -EINVAL;
+			goto out;
+		}
=20
 		if (!de_is_last(e)) {
 			/*
@@ -2203,6 +2207,10 @@ static int indx_get_entry_to_replace(struct ntfs_ind=
ex *indx,
=20
 	n =3D fnd->nodes[level];
 	te =3D hdr_first_de(&n->index->ihdr);
+	if (!te) {
+		err =3D -EINVAL;
+		goto out;
+	}
 	/* Copy the candidate entry into the replacement entry buffer. */
 	re =3D kmalloc(le16_to_cpu(te->size) + sizeof(u64), GFP_NOFS);
 	if (!re) {
--=20
2.43.0

