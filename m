Return-Path: <linux-kernel+bounces-294829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2882495932C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528731C2143B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A8158522;
	Wed, 21 Aug 2024 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="h2TDJI8y"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5443FF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209744; cv=none; b=p3J2VKlbGho+5lQD0MA4P8mkAuqx4Bd9urRNf6FFxNTkoSPmu7rRXmiajN7tJrxFrFkehguwYcZgm6UJ0Et4GmN6uok8M+bi2ByY5ZaswcUnf0A1LT2cDVNVDskW1G9f5i7tSGpzwxKjb4RekzZxtQZnmjJNHZtYjnA/2QDRQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209744; c=relaxed/simple;
	bh=EhogGN/0K5c0wQKRDXoOsl7gKqhK/nqe6q5HBqpRa/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/LuJ6F2xs+WZka0avr7ZxkmohaaWliUnZIoW9mOyS6BsXQ99kBR9QxWCikAtnbPy1Meq2HXN0zLf2FU8wT2+SWFQjI5Ius+Ob7qO4R+5lzXQwfxL2EG4P0Azl9AEP8JDcJKc0t+87NH+ddUFG5oFn+in1peKIYEu8IxGZAISLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=h2TDJI8y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714263cb074so109088b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209740; x=1724814540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6x6dAOtaMiziM8hI7NOqaYooQRvRtzAARw8c3hYwAkI=;
        b=h2TDJI8y3Sa0eJYkhbm609oWP9qZXvzgpfSpLf3E6rlm735xZxsKHfLhwPbMolt/Jp
         BO12nhWb2F4lwSgBn5eGD4kEXiKR9VQFFBmydnhdmsaixnGxsqQlg86PCskpzzGP6Ebo
         Rcc70G9FqLJ/rTBWKdTjd8GvVl3xPs7L59TMWiKwm5LmrIxSpucjBEtQ2Fi1ZqwQTPhI
         UQF99InGeNHVZ7PEnOvGV97VVDk18ypXaK8qPaVZMnvUN4keEli3voHSA/IZ0m6VJmu6
         KnIUlWfQoNBM5cMY+HVPz8NdifH9vDdAAl5F3PUrrPmV9gD3hBsIquVmt94h9W4Og+Uo
         TDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209740; x=1724814540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x6dAOtaMiziM8hI7NOqaYooQRvRtzAARw8c3hYwAkI=;
        b=OS1ARxijFVSCPAzBxCsl9yCHjGkqPekGun1UJJNzJwb4jV8CnUYyaBC9ciU8Ka1FRf
         qMPsS/lxzkvLZm0rlT/pc9a0+cClg0biYAsHYXjSpI3cP8+IWs51gu2USevXlEEyUjWh
         1ecmG4OCR0m7a9g5cWlWi43Qa4Vst/O6SkkY5PupXGj1w014+j/NgUXZ5nQQMjIsRJjR
         mkaj1tPk7MAk7v4jps5528lRETcxqOzR51q5paFs/oaBnl6QmmvFu0OUyjq5eTrg8U6r
         OMej+NHffHwZ0aNIiPit1XqfDDCK5L0ad7tE+TgUFPoT6Zlche3jCdSPaj/1y25IJYBF
         fMuA==
X-Forwarded-Encrypted: i=1; AJvYcCUmgnLKvPKTZOGGUtTh4j/aeyQb/qIbX3wWY/DFjH31yZA8Qe2g7rcTfzPkJc9dMEha3MFGj+qdZuOwtvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyli88HLTRaUf5hLyvNxf+LA1TNYHm2aI1E7lhiSdypvYsV7cZg
	lXbQ4p6RT3uNu7WVcxMwAtQHO5/+E6YN0ox8PgrNPgTiAklbEr4YhoIznjFDvM8=
X-Google-Smtp-Source: AGHT+IFkSlznMyLs3v8wqjC5glkCuAOH8oxqlC+SiRhqisz4ba/yX5OBuf89WyteBz6zJthOmCYx5A==
X-Received: by 2002:a05:6a00:9190:b0:714:2277:3435 with SMTP id d2e1a72fcca58-714234657b2mr1361859b3a.11.1724209740461;
        Tue, 20 Aug 2024 20:09:00 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/6] Staging: rtl8192e: Style guide variable renames 
Date: Tue, 20 Aug 2024 20:08:50 -0700
Message-Id: <20240821030856.57423-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series renames variables to correct style guilde
violations.

~Tree

Tree Davies (6):
  Staging: rtl8192e: Rename variable CmdID_End
  Staging: rtl8192e: Rename variable CmdID_SetTxPowerLevel
  Staging: rtl8192e: Rename variable CmdID_BBRegWrite10
  Staging: rtl8192e: Rename variable CmdID_WritePortUlong
  Staging: rtl8192e: Rename variable CmdID_WritePortUshort
  Staging: rtl8192e: Rename variable CmdID_WritePortUchar

 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 18 +++++++++---------
 drivers/staging/rtl8192e/rtllib.h              | 12 ++++++------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.30.2


