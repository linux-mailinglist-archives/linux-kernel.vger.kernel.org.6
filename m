Return-Path: <linux-kernel+bounces-283486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2353C94F58B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A841C2126A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A153187550;
	Mon, 12 Aug 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V25tjlB7"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB64153810
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482157; cv=none; b=X6uC7VnPDQubOOvwS3CLk9omoGEFggjg6kBZOF1GgC7pIDj7khNo/AQ7cdpB+5QSwUd0IuJTuK90A0gtAgjqWFlhsQw4/ihxTkZO1DopcDz3OOx30DYn2S4H+vXyjRaH8glVdsHx44B2muJuW5/fRzns+7gJvqXItbazXp/0W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482157; c=relaxed/simple;
	bh=ExezfkMNjyJwnWQP4jzUzm5nlE4GG+8hNfjIZ0yccuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oh9vxEWMyOu+/doYm4kqpwdUQsP/bSoRdnvF+y5x/j3LNGhcUeU0pxODKDpwZ0heNC5X+Bb0nZ1ONiR8fTsVmzlxzFa2cvYsYikxPnklnzB75AGe/TL+ZKNjjqF4Jl+uf1jmxjqvSFldMrpdj4Uc90ZJNzeYF16IfkuLQHPsBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V25tjlB7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4e1dca7aso914711a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482155; x=1724086955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUuJ7R4KZSbJs2nsJpX44i3SY8Pc9QeqzYnFkJ5u9lQ=;
        b=V25tjlB7B/ar7dcXGPfYqaaSCoGH6GSDjwyNNPkK1oqc/rhykGVxIzvJdX7K20uyrQ
         bCmiMrmhFxwbYyF+QspgD+TodToCxIAkisYSDYijI8tTq7yOivt0UvrlckMh5txOAqCP
         8WA+c50TFUQ3OHpj96GdGYq3MP4WWJLUwYWobb8TmOAE6OBUuXJ/ViXarZopnA7Ut3it
         UnDMEmPyTBALjXQd3ga7P0N2M62/8EhFvyLXbmZDzIYT08qQgSg61SHESAMK8E99b7IM
         TUIzXN7DNzOjRbn/s7LPaWmXsiBOWkYFEhld3dVeDmTJ1QaC4Rl8lksVkbTN5/cstuHB
         4Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482155; x=1724086955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUuJ7R4KZSbJs2nsJpX44i3SY8Pc9QeqzYnFkJ5u9lQ=;
        b=v06fkW3bXG90tfJn7VhRfeuODR0ZkJAkLFGtd4Bl5nJVDFCafk/srxR4iEYjRYq8ni
         VLFDk9UtVI9nve8F8C3ntTen5ZDYiWSfZTaqIUn/R08ax++Dl9LaEOqy/2gpuz1eq24t
         R2jTVsQqnilti3PTTpGBB3KocYB5FxdQq6HrSC7xacQtcxJdFnLOxrIrtcuqK0pSkMSe
         MBDk0yGPlKx8fpZ7M+srpKojWnZbjP4jf91bRj2uXt4JvNdvZ/eFwS23G+NdV/h3ioRD
         u5p0DCxGzL8J6oWp7KoiB9YKeSWk3G4M8soPU738ux3df8HVDorFOhbNvj/o+IpTj94r
         DqVg==
X-Forwarded-Encrypted: i=1; AJvYcCXfQCK+OiCXINdwuWHSOQJmuzKgugDjbaXE27L1XZ0stGmaogdUta1F1j7pBHiWW9CMtneK/FGG8ufCDDEgqCdLDsI0RYSUGnmlbIY/
X-Gm-Message-State: AOJu0YzDNH4YV/FryvU7nnqltuf+ejsVxQSkmzCtHrsxNhXRQnR5ejP6
	vsXSIApR5WRyCSZovXp7rrmhxWIHwyHA+COEoMVE6e9ze3amQK/VyQgWpw==
X-Google-Smtp-Source: AGHT+IEDElqLIojFGm8i5TBtrkfdQq9DIEW7SoV/zbfLfLa//AIYUHRjQouxp1ivmNzzACQGIFIHaw==
X-Received: by 2002:a17:90a:6043:b0:2cf:e075:1222 with SMTP id 98e67ed59e1d1-2d39273c614mr523259a91.6.1723482155277;
        Mon, 12 Aug 2024 10:02:35 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9dceed4sm8618816a91.57.2024.08.12.10.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:02:34 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] lib/bcd: Optimize _bin2bcd() for improved performance
Date: Tue, 13 Aug 2024 01:02:29 +0800
Message-Id: <20240812170229.229380-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original _bin2bcd() function used / 10 and % 10 operations for
conversion. Although GCC optimizes these operations and does not
generate division or modulus instructions, the new implementation
reduces the number of mov instructions in the generated code for both
x86-64 and ARM architectures.

This optimization calculates the tens digit using (val * 103) >> 10,
which is accurate for values of 'val' in the range [0, 178]. Given that
the valid input range is [0, 99], this method ensures correctness while
simplifying the generated code.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Use a unit test to confirm that the new implementation produces the
same results as the old one for values in the range [0, 99].

 lib/bcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bcd.c b/lib/bcd.c
index 7e4750b6e801..c5e79ba9cd7b 100644
--- a/lib/bcd.c
+++ b/lib/bcd.c
@@ -10,6 +10,8 @@ EXPORT_SYMBOL(_bcd2bin);
 
 unsigned char _bin2bcd(unsigned val)
 {
-	return ((val / 10) << 4) + val % 10;
+	const unsigned int t = (val * 103) >> 10;
+
+	return (t << 4) | (val - t * 10);
 }
 EXPORT_SYMBOL(_bin2bcd);
-- 
2.34.1


