Return-Path: <linux-kernel+bounces-320121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B197065F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90D21C20CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD614C596;
	Sun,  8 Sep 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbJCrlbT"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD31366
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790282; cv=none; b=U1d0BFsejqhQLr8ku6/rSPUB8DmIYbqP6MjbfYMB66yPAW71mdofSEJbu60oaQjMv2HgLcrUMdovRy/pDLCxJqVaoIJ+vZ6gpNwwkvwn2bWr0BDP0rZOltXoU1c6Coxh6B3KenhyNps47dBeQTuqdxsfu2q4LkE+0Ao9vcoXHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790282; c=relaxed/simple;
	bh=avGcyUF4moSstecPBUHUlVU4X6Gn9wgfwbWgPoyt0Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofNDsxL7NV8xoR5TtmWb+S1u14MyjnI6yL/q4bCH8KqrkOpjfttWwDuvPtY2umLaijdnZUIobKHuy+vrd0NFOjyTW97fKDobqoc8TzseYjKO9X47VcCcT1ZoodhFwjdUEteLSk4BV96Ui6xUxAmQ5mwR5SvNzKUEiXQvDbsCIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbJCrlbT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so2281639a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790280; x=1726395080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biYfC5HUlpa0qqeVAFPV4kB9CvhBlwCgTvPQrrf8Rs0=;
        b=gbJCrlbTJV0YU1JGWBBP/CNkrVPp1B3swou27HkakE+0K/f5Om1apMFNAyfncAFatP
         Sph9B5r8utVAWOENX5f/grFVB7Y15QBa4Ystm8RgteguhFk+bO0PW1QHEQurPRMqAv7V
         FvSrmjbXEhcLr9Xw5pvlHH2Jt2RREWnH+W6iM1AxApC9Gk0VxKfC5PQDIk0EqltKd9h9
         ZOXPf6syB/KgflQ4uOUTtXmMqUTIsI4efIA7cmHj026AgB/blMfPVfZ3qKsY8dA/QD3I
         x/lZO40oQjWWSYQ6C1PsnAB90A3LUmaeAF7f3b7K7Nq0AwkdQHbg4jtzkG+C71f7i7BT
         ZHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790280; x=1726395080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biYfC5HUlpa0qqeVAFPV4kB9CvhBlwCgTvPQrrf8Rs0=;
        b=iBCbmfbZkTPsmzQUVNH9JW+Ed09HtrqBVO0FKWqIdmz0Ol5rol/nrvQZHfMvotZlm1
         7bgz65nFafVroKvx0+kqXDUW5IqYXY1+uPFt6qldwywVbJmm+DgKx0MrpQF5VSTsb53X
         8rsVP2rus/hS8HTlK6y4obeBnRFdVhHt24Vkq4EJTSMtr4CZsh1xxWwbQ3hUjUkhSkXu
         B5QeZV7o8gDJMaOnFO5R8v6KAC/Lv7BjZgnmGYpGBIvICXJyCOjyIx3q9ipffZu+OMQa
         TVNJ36bzdDlPZ9FhZWDSfTDfgKiGDGDDynTO2UsIr3vuhTL4SMC9rHsH18ROf9hU24lL
         HWmg==
X-Forwarded-Encrypted: i=1; AJvYcCX5bPdoINSu0ZeOkaS/tuWGTnuvW0t07AkofrNTY6H/bRaKjZ/zpSWAKt07MeijrL3FSF6Z5xUCs1W4ki4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWuxAETmLLANttTm/ucgcVE1ITkuTZy6P3O58VXvOtdCmdg88
	HFpd+Zx03C0e90rB1L6se3OtQ/B2kYeXUeU2dwEgexdyeFRCkQ+g
X-Google-Smtp-Source: AGHT+IFC0W//oMWfh8aTsrMzXObPPAsI2g8sKwq1wCoYvHc5wJmv6zLbt2HKdL6Gb4kbk2GC/oQy+w==
X-Received: by 2002:a17:90b:4c88:b0:2c8:f3b4:421 with SMTP id 98e67ed59e1d1-2dad4de18f6mr10139212a91.4.1725790279885;
        Sun, 08 Sep 2024 03:11:19 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:19 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 0/6] staging: rtl8723bs: Fix various coding style issues
Date: Sun,  8 Sep 2024 15:41:04 +0530
Message-Id: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes various coding style issues in the
rtl8723bs/include/rtw_security.h

Patches :
  Patch 1/6: fix use of tab wherever possible
  Patch 2/6: fix position of opening braces
  Patch 3/6: fix space before tabs
  Patch 4/6: fix comment with a trailing */ on a separate line
  Patch 5/6: fix switch and case to be at same indent
  Patch 6/6: fix no space before tab and statement start on tabstop

All these patches address minor coding style issues in the file.

 .../staging/rtl8723bs/include/rtw_security.h  | 95 +++++++++----------
 1 file changed, 47 insertions(+), 48 deletions(-)

-- 
2.39.2


