Return-Path: <linux-kernel+bounces-576306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D4A70DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D10D189F810
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E075269D1D;
	Tue, 25 Mar 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1phQxUk"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBC1991D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946732; cv=none; b=nR3Fsorxh15m9rcXeosAcjodrXMQ2c7NGdSdkxALFy+xzx6ckJuR97DQYA62REuYcfLpa2FK/cyU50vdEksHqVNWezw6Go/56Gpx+GcN1Ec0/6d5LwRXbCOFV2DTIPraSLTX2wPpCZzKV4SGLEx6QApCbi4dcxRDNbZsUM+Azmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946732; c=relaxed/simple;
	bh=3CW3Zo5ueo/xVKPOIFAdiBARkwVqXp3zCmcq2YGKqO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5Typ02n29Zzru6UHlvGlue6nHh08g7PgCcbQN4SQTQlNL91W3wnMoyVJL7WKTVaC1cuWiPUQRXScr+dXKCiRPkDaTukZ/cRrax4hNQvntcVYNdf/5ppBfS8BStenkJqrK/T9grfqTkTK1xZJANRAtaNHDMsZQIeYRVLtTdHuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1phQxUk; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso197974139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742946730; x=1743551530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsJWqGNZ7UEBjtLuJy1QeDkWVjnrLuUjPxriJGNTwRc=;
        b=Z1phQxUkpNXei1ZUsXdeNReXrNaev6jxcoG7+atCIP496NX2sTFrBacxAhwtbTMuxQ
         9UKNplkjZDMi+i/pmjn/mP9H+u94qMaSm0qDiL4cZ14IfxnDWvfWpxLH+cu+CkpoQeJO
         3JGBa/7n6cPi7SD7YGU9bFjHuq2YpUo0on9QQUjrG7o+BO9JDrXVyg5qEYo6p41UjA0N
         t5tEl1gDcOjkob9hDfA1sFsbSgKEAyqPzZryVws9ZczcVqUj8Rv3CL8tD967XlFIJIyO
         Xomuy2VVxWa7FphoyjJoQOu99NsUyIJT1WUUKVcapN6Y0iyGUKejdJ1ah44/BOLK9amW
         JMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742946730; x=1743551530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsJWqGNZ7UEBjtLuJy1QeDkWVjnrLuUjPxriJGNTwRc=;
        b=UGkUvE/0d/DztCRrY1lkqDAOOZILF397sAAw+rpm+OA+oV90Z/+1LKBr/lNGkq7EIO
         VrxQnQMAwTbykUDWgJBdIOJ3R24rE1nOcIBsaVsOjairN7J3lpIvmQhuFTiIgf+I/eXN
         +ZWuPucopMLj5dlph+PzKQ/KAg0Mp3eNiuEcpK5D7tSybcK5PjUzrTvdPW/hEWYYyjVZ
         OkX789L5y0uVErS6Cv1FMLEerk506JXCO3SR1REdFKMIgdZ145Ns4svF27Wu3SB8ixUD
         ovLLxsAzn9sXLLPDVegC+uAqDFYAxKhQLf/t700W4TuvxcZ/4Aq+TOPnRNV7yhnaycl2
         0uSA==
X-Gm-Message-State: AOJu0YxLAjZDiwakm2pj+6E185TbJVkzsEsdQK7b15X4OROZr1EOTxr0
	crRgSu9lVH04WQzwEBTRnLtmHplhXg2xvFtmnq1c3ttro4mZRM7EtqAg6RLL
X-Gm-Gg: ASbGncuY9o55GHY4nJA9OkMZnVQ02UrxyLoNBbRoWEba7LZqYIwvinqWXNfnev5uRy+
	DodutR9ytmo9BDINtfDX0guvpcs8nF/SOeTeOHie1Dz95x4LwTo1qWsKKRXmqvGn7Zb+dLLERZt
	CQYtZ56qSohCNYcjRWw/359oalQwDQWzq72mm2v8aihIOLcMYdyW9sk+7yPA1DD9kbESMfay/h3
	G7pas9rh4mTLH0zlZWQtA0FN4z8X9UKF/pQrSXlB+VQ/vYnuiuk/t86iNaHVndISBc3cTNzH4Kb
	UZUodR0mVzhFc0CeSzVKoYXpK6Frnli6dkfqaHQx5YwQ+fty/OSwyE0/fv47RFbra3TwQs/j6ro
	MUQ==
X-Google-Smtp-Source: AGHT+IEPEyh34gxJ1q46rLihO63k1d+5FV9qfYI5SUKINenx9dsXvrMxSb0lqqXr0pgOayTPlN33IQ==
X-Received: by 2002:a05:6e02:370b:b0:3d3:d994:e92e with SMTP id e9e14a558f8ab-3d59616b908mr164496765ab.17.1742946729942;
        Tue, 25 Mar 2025 16:52:09 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d5960cea10sm25191175ab.45.2025.03.25.16.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:52:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/3] 2 checkpatch fixes, one pr_info_once
Date: Tue, 25 Mar 2025 17:51:53 -0600
Message-ID: <20250325235156.663269-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

2 small tweaks to checkpatch,
1 reducing several pages of powernow "not-relevant-here" log-msgs to a few lines

Jim Cromie (3):
  checkpatch: dont warn about unused macro arg on empty body
  checkpatch: qualify do-while-0 advice
  powernow: use pr_info_once

 drivers/cpufreq/powernow-k8.c |  2 +-
 scripts/checkpatch.pl         | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.49.0


