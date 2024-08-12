Return-Path: <linux-kernel+bounces-283371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BC94F1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D198C283217
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4D18453F;
	Mon, 12 Aug 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+j0HDcj"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E8130AC8;
	Mon, 12 Aug 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476442; cv=none; b=mmzKAkqPdoTCFNTQyOP53k1LruheQ1Njk8nwxYwDEBFV8LeWga7OV7wOuVtrOpKSSSL51nx3V0e9THuPe6ftKa8Nz4TPuBolS98afgO0hzsWsJd+roNsaArrEh5BrHmDJ1Ny+3zkb/cTz6i4N5wCbZRnEMixfSh1/AGVxTix/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476442; c=relaxed/simple;
	bh=SJOT4u2AOnoFTV6NcHUtZJgEsVCS7Ps8uAl3BZ5rzRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMRirwtv9bLeJG8iEqw2LsJ1aJ+Qwu1N8FXiM3jeTbarZrzVccf0IL0LMQ4muWJ3PlGnpe8eNFnsUUDUGOzs8bNx0VkgoGILQ/YPb1aR3jiISoaciM+FLepKIZBztn3JEkz0cHKndpevh2id0GF97VObZgxqEFMTeCRVZdeuT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+j0HDcj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso5323163a12.1;
        Mon, 12 Aug 2024 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476440; x=1724081240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbQh4JaQElNnZSJflbJl8EURMl30t+auDTJhns6YUQ0=;
        b=i+j0HDcje/0Ugf/0u1gCeRhcisLELoJcTCiGt7ElPgWNjBE8Tz4ZYCXMYH2p03r53C
         hZGqUs9nAzGU4H8JGDJ0aRuHysI8Qt3xqqRgeRF4gBu5jKqX3qAjaT9jkFz1QcIygOBO
         O/cw47QXipNADqB81pvTDunbrISyEK5GhGv3u7uxXQAF9vrSke1JBWV6xWRUyZeBHG+A
         aVzv7THI5Fws2UZwcjByH/kizJKOkKtVmDB00Jmhyq4vuKgL9Rn/Oc0+BK9qEn9j7E7z
         jjGLjK2zWMZ9S4UrYsvSVJVIHoA4ju0fY4FYxDcQh020pKdhWkKaG9CO17653fn1H7DE
         WjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476440; x=1724081240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbQh4JaQElNnZSJflbJl8EURMl30t+auDTJhns6YUQ0=;
        b=wA2WGnf4Ptmtw7m4thsQvkVIWoqOETBsRonQRvrL4lTePaOb9Wo04crXFSLdRXU2i1
         1hFY0Jp0kCbIyrsBc/ZjizaV31QZOx89LkrfAs92fvlGoxueV1z1yrg+mk/cqcAntrsj
         0vlB725YSqryrujIS+QH+8F8EGE/rq3g6VTmZuc4KchPfQM7JiXq0cgYU/RxuHLdvv7u
         JIhCELCc1zbjQYnElslw49SSrq9VCw/xpZ8ZgHRLw+XcInQCanZ+MBZRy3Ie6KcnugGa
         zaxm84ZUg0Zkj0nR2V0/HT6G6gzQ/DeESCx6vqPKrPejwNM6TvFCymbNAECm8TKRqpah
         uELg==
X-Forwarded-Encrypted: i=1; AJvYcCVWhbVh92+23hNogZyp3M8RyEIZIBxzjeotOA5KlOYXm2A2Ti0WX/zrqGklqTIM+5s9phGUnq2VYFZiVMpt0zOSer4lPcurnR5CWelXQGuwA+8U9bi+RI0w1uScSEhBk2p77JCAoQ//6wE=
X-Gm-Message-State: AOJu0YySiNk9H3OoZ2UOJH7PVvPkae21i/f8E+Y/4dsZgQvvrO3FMYWM
	RG9xvb+a6vxUxpDBKVgM6r8E3xoHOn8gtguOJA4qVdpSSoLOA2QD
X-Google-Smtp-Source: AGHT+IGTq/JhAuFfdEry9aYhhGTitZfc0b1DLfoiMUaC/HKUYquk1iU502prvA9tvKyVKql/7LeUEg==
X-Received: by 2002:a17:907:f7a8:b0:a6f:d990:338c with SMTP id a640c23a62f3a-a80ed1efea2mr52466366b.20.1723476439263;
        Mon, 12 Aug 2024 08:27:19 -0700 (PDT)
Received: from localhost.localdomain ([46.211.27.200])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a80bb213171sm240568866b.145.2024.08.12.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:27:18 -0700 (PDT)
From: Denis Pauk <pauk.denis@gmail.com>
To: pauk.denis@gmail.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	attila@fulop.one
Subject: [PATCH] hwmon: (nct6775) add G15CF to ASUS WMI monitoring list
Date: Mon, 12 Aug 2024 18:26:38 +0300
Message-ID: <20240812152652.1303-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boards G15CF has got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such board to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Attila <attila@fulop.one>
---
 drivers/hwmon/nct6775-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 9aa4dcf4a6f3..096f1daa8f2b 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1269,6 +1269,7 @@ static const char * const asus_msi_boards[] = {
 	"EX-B760M-V5 D4",
 	"EX-H510M-V3",
 	"EX-H610M-V3 D4",
+	"G15CF",
 	"PRIME A620M-A",
 	"PRIME B560-PLUS",
 	"PRIME B560-PLUS AC-HES",
-- 
2.43.0


