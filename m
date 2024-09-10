Return-Path: <linux-kernel+bounces-323644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D397410E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730571C257AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225581A3026;
	Tue, 10 Sep 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="nw3NQwii"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74161FE1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990583; cv=none; b=rj4ZCuLbPknr/TGtv74CdL255tKYCCqbzc781qAbdSFJn1fc/3TxTLCTWbIpzpNptcP2WyOM55FxBf8v6JbI+3fI9QljIucRMPj7s8SlM+iLMWaWaDqyIsPFUOJoGT7lXMjQE66AoOx7RKWNVCWt09QQA0byaEtmZQ4YiKhCzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990583; c=relaxed/simple;
	bh=AXwpFuaMqL8AmfzXJ7qg4wzkx1fpxc97BQ6WENMs9eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UADOmRFf8Q8IJw1ocBDnjm7D1yt0ynrmvs1pJn4g+bl9fu5Mc/4nrEh/psGP/7UNFVgRNE4Z+y9Nx+o0A3nU3gfdrKRO1+oYtZFaUKcb5Gx1yyhQtg+2lij4iNHUFXsfp9o30qizy3zlT1EwbTNQZmc35LxEoNGqRNwUuLdEOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=nw3NQwii; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ca5447142so6673775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725990579; x=1726595379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEMKhoKz265xTr0h6063lsKQJW8lu4nWZPLj+dKg/ak=;
        b=nw3NQwiik5dKfY1UJuTkEIsiTQcVAPS8LbiFrZjIwVMAHQtVLH2YQceQSrpl5M7inD
         jgdmyURelX+igy/+vGWlVfBp1hX/MVja/XI5+H5c8VEBeruCJm+/qwLVEAIMioeniZzj
         y76MdEtJEwIXUxZZM+gkHp81YopEa6+o9Rgjz8dz10JEIr5CvU7CipgMFuDqcgRB5XNS
         xbg+aq64mM7lX+Tfjnv/HIcxQ/cVNMaKFWMuwIfN+LnHnqCzdrBejLfsvvnk3LC2tSGZ
         GwdS2Lwi2dY3P4+S46aUX3VS2ewIGiFObfwO/68iEXu4eaemvuOYDZ1HjHFY2bs7C+Q0
         4QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990579; x=1726595379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEMKhoKz265xTr0h6063lsKQJW8lu4nWZPLj+dKg/ak=;
        b=GbZG2NWJ7Ss8K2e/ShOdS6Zp8cye6CqZa966D2wEXD+SjiOYRJ0kKYNACh8gO2Rv9s
         e6aoO1hltmGJhDox63I+9sfwPi293X4Q8ff5BZijvYyURJ/SUHegxE86xPS3N2bleO5Y
         3IFgmqNpYONv//Jj7DXxTpVDlFK6dAb/WDjko44dyvJ291NUJlUNY6UKh+wjOLoZeFPj
         un/G4kxTn/G3NPxdLannFw4vJeu8juFV/X2dpfN7n2rU34PJ+SrJbZwz067chRFOZHF4
         mTxotEuXg1UWK3rYUWchuVIb6ctkW5mCMPp1+CojuhCir0dX4nG7BjdS01SM+2/nEAPO
         RM7A==
X-Forwarded-Encrypted: i=1; AJvYcCUUN8XUGVJxnyL3aWZ+xAZ9pamNyz131HxJ+ztwJ1rrd3Z5kD4QiSVMxFzolwhbaayyzT1goZiS9L0F1mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKWUHljxjYAT+7OUMGFWVzQdyySbLdPse2Kq8L9rA1ZvsCM3IX
	piqnfNnKvhN7ajP+BeEZq/Wycaxr7wGSDDdYcJ24wzMDWiBG1BFqNp8IDk/CN/k=
X-Google-Smtp-Source: AGHT+IHelw/uYw52OYmIixy02tvwb5mK2pkTzmGN8qQjLqO8V8gMqDEZAl0lSTYgOrrjILVgYICXyg==
X-Received: by 2002:a05:600c:4506:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-42c9fa0c6fbmr55373495e9.4.1725990578992;
        Tue, 10 Sep 2024 10:49:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-91.dynamic.mnet-online.de. [62.216.208.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dddacsm9399741f8f.107.2024.09.10.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:49:38 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] apparmor: Remove unnecessary NULL check before kvfree()
Date: Tue, 10 Sep 2024 19:48:37 +0200
Message-ID: <20240910174836.8966-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kvfree() already checks if its argument is NULL, an additional
check before calling kvfree() is unnecessary and can be removed.

Remove it and the following Coccinelle/coccicheck warning reported by
ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 security/apparmor/policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 14df15e35695..ce1c96cb2aed 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -103,8 +103,7 @@ static void aa_free_pdb(struct aa_policydb *pdb)
 {
 	if (pdb) {
 		aa_put_dfa(pdb->dfa);
-		if (pdb->perms)
-			kvfree(pdb->perms);
+		kvfree(pdb->perms);
 		aa_free_str_table(&pdb->trans);
 		kfree(pdb);
 	}
-- 
2.46.0


