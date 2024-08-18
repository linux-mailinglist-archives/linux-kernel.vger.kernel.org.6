Return-Path: <linux-kernel+bounces-290998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D0955C16
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 11:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390592816CA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2317C98;
	Sun, 18 Aug 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StVbHOgn"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D8846F;
	Sun, 18 Aug 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723974166; cv=none; b=WCtnaeE/c1JDEqkZ3aVz8BWOmZfptwtAYP50NYIsz3A1PXqKR/i+2QVtOGQJoUE2dbSLmiQLMn3zHM66QAikHDxZZQlL9W2nIt8AOVHS/4udsE1SrPLD0NWvExovyJKBFGg8FhxIOvl1e3HphiAWTKu2yYI+t9rH6VhnJD3hoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723974166; c=relaxed/simple;
	bh=uRdH9sn3ugTF7EbpksQZHiiQvsrX/1G/Lc6Id52GXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsTdlT1IGfriCpcmtqBFrgKJeWUPufBun2t5y0QGkjOv4I/uxvxLeku29TzuXoPbKo4D+Z2Q/OL4BtfBhb4XM0PQKtALG5PEyzGq01VUxEpmaAXOeAKDf9IdYb95ZIwiDZz67ckIj2dSvrX7H19ApMgl+xr+pXwVlefZl6lEXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StVbHOgn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371aa511609so652757f8f.1;
        Sun, 18 Aug 2024 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723974163; x=1724578963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QO0daqL87O3Zy/fH2u+i6LL14oDAmC7svy1Hs8gOC8=;
        b=StVbHOgnPA/XK2iqL4kKgIP9JnRVkG4G4+liI+7PdoIN5wFcGsbjcMaBoVt1HxchSK
         BylFGn89sxYFNyzcLwr+FpQrJwufk9eALDY01dMpQvZRhPpcjXmwThUGLZX/B+XdYfG4
         i3s3ZJZ4IUZ6HVNsEAefCnIhdfGIXcnVVVR4mPtQetczYnSS7eEOAcZSfEgcZSlcsTvT
         U9lcCSu/ssPE5kK6iXbXcNQ9Tz0o0ZcFiMo39QiSZklvpjHwWkPddWbKZDXWSmfrUmwp
         5DF7n0XPsttqNdrWxU8Cp9fcfora/0/EgxuLhSBoMlZbgiNFR7kBlsKPYovvl8QNi2rQ
         ocAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723974163; x=1724578963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QO0daqL87O3Zy/fH2u+i6LL14oDAmC7svy1Hs8gOC8=;
        b=vs4QBB9MdYf2IsDDpSMVFX3sUBqOXbej0bs0TZEMiKnEZjhffYaZ3KEdXG3mGTFf2H
         FN4kAgxT3hpWXi0Iaq1si+xvAO7p5pm2Js6CZWb5R4se617orH5o3w+VCQAiCwKadqmq
         MSzDNgQL2h43Qq9b2tw+Wr9W2SPdvXetjkYLW6spHWlzmFHlBX3naGqqVSbSS0n6Kek7
         hk9ijDBitq+fO6zC4YOQHKFhZ8CG/LTtHhy/QrGev3yTmAz0/sHajssMnxC3e81/6fB5
         /pUpY7Io5zm4lrZWrrSIPeHg98TyANhfOlIJSshYIqLSscDrM88tOJYxvII9jBakBBwN
         XSGg==
X-Forwarded-Encrypted: i=1; AJvYcCUwGgrhdbOvPbY9eaziFny/prR9TUkcqsY7WICwzAXfZjxvZgmwjgMAfXonN4nrYMqlb5Faq4dMW38p5v3D39dwGisylbuaesYCf8pc
X-Gm-Message-State: AOJu0YzVaDbcDFH8VAn7yfJu0PRlNJb2bXu02beread1vsh6ipTjctxZ
	d4kngBYBRpDJN+rL3vj5AKbc1BxxyzjX9NC0urfGny5aEkZapXb1
X-Google-Smtp-Source: AGHT+IGUyVgLo9a+FYh7ZHPkpv+ouV8YsA4Xp9WCBAKlpl/FZiNkwaDM9UOCqrCd6fRsm78XvKSP8Q==
X-Received: by 2002:a5d:498b:0:b0:371:7d3c:51bb with SMTP id ffacd0b85a97d-3719464b22bmr4761874f8f.19.1723974162746;
        Sun, 18 Aug 2024 02:42:42 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.fritz.box ([2a03:6880:104f:5c00:da8:f501:bb2a:e60f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897008sm7603408f8f.84.2024.08.18.02.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 02:42:42 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: akinobu.mita@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH] Fixed typo "allocateed" to allocated
Date: Sun, 18 Aug 2024 11:42:26 +0200
Message-ID: <20240818094226.9079-1-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
 Documentation/fault-injection/fault-injection.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 70380a2a01b4..9170e22db215 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -283,7 +283,7 @@ kernel may crash because it may not be able to handle the error.
 There are 4 types of errors defined in include/asm-generic/error-injection.h
 
 EI_ETYPE_NULL
-  This function will return `NULL` if it fails. e.g. return an allocateed
+  This function will return `NULL` if it fails. e.g. return an allocated
   object address.
 
 EI_ETYPE_ERRNO
-- 
2.43.0


