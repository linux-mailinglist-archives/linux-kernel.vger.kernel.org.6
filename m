Return-Path: <linux-kernel+bounces-517632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6933A38389
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6DE172D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40B21B8FE;
	Mon, 17 Feb 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9S7racn"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE521ADCE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796994; cv=none; b=LysjJv0Ieq01PioNelvRJoxgxJ7cnhwOZkffdEtmpMqARMctuiMdsdxXuJxMC4q5zNMUf6pdiNWxYqfE3RvTW5DtEMSni1u71t5itopMjlEm8EX9wUDqqwlL08ryFsUMWLVBOw3RK+R9MyEhK9ractZuJVTsO4xLo9N/BLAawPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796994; c=relaxed/simple;
	bh=0Lsx/C4UCcCrKw05NcJnCPZjnOR7o1gKd5NLSlEnz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIVRRZ3xGdLARRpQcS/l47R4O/40Lq7oOVWrnYXPuGk6SwpDgf+7RYuKjZe6esCO3bvwaU4Ks6TSWqe45l63+dyhHcKQfsiIqjVi/2izE8m3HFunDXVdMT5A0ipg6VavKlSluGpIql6D1gv6EwJuJv6CFYG3Lrh88AJLFw4CrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9S7racn; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-219f8263ae0so75935865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739796992; x=1740401792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhXYHMceaATkeZwBak3g2eCtVGrZxSSMr61b+pgDgh4=;
        b=e9S7racnX8lgM8035l6Vq0WmwtEU+vmVkymZp/MGjHx6fr7b7R/g3wV+HYd1Xlqpz+
         9PDXL3VZYELW26op1FHEwTVHMOiliGgD6vyQjuFazrLUYLt8AF5UrWACDIS/ppgLuU8j
         3jp3VxDHJbZkkykjsybPV04LPKBk6/4e70IZpUaEvQjkcCZXIMkbcsrsHGRJfSq0HGQ/
         5tSZB4cUjkrBbNmEiQmv/i6FXqVsv7UDIWpY2qHdKWBenL3s41JMdkefaMXqh1dh3Axx
         ixHsxcfafq/Gxdf5Wz/PWKnhSBq2pROXYETi1znhDELLQFyYUXwaA0s2sEmxQ9BKs2XG
         cwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796992; x=1740401792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhXYHMceaATkeZwBak3g2eCtVGrZxSSMr61b+pgDgh4=;
        b=OjAWB5HwF9idAj2ffegOokHIFvttYHrZlWRhR6aAdsMngVrj7ADCWtS7YZJ9DKRMFl
         cS1sVSzi0Jrx46MuobxcUSjlp/e/IhQMWTDWQTu/PJXu5ZmgL0as5DcX/+ZrRCjw/8Tb
         np/Gnj0Y2F9xiVt8qhbtI8WhzskSPENmzKSFw0tmv+BgTi5d1VkjtgDhw3hca04eqTvA
         96xOhMIF/UiBvepC8mZ6F2DwOomDScWcC0KKMC38PW6wOTjJusT+7/FKmcTBmpRCdFeK
         cOuXwJmToFDxTrLDbrXZOSuGIQdSCQ8JvJ72KAWkA8Jw/c75PnQx3gDfbdzfiYEGo7id
         wAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOSeK7XX4YGeaDPF43ASMJKIv3mm+gHC+zy/xh5iHyBrwqCiJiuqIGtGRDI4zu9mVAka93N9Sjv5VbFDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/92FbwOjsq7GfvCRQq4RshumWx/Pw6cLhpO+0WAGvMwIeT8Pe
	+ndIxYh/682K++3zYPUL5ysQBjJG/zSqfOtKBZj8u6doDCYqV1ZC+DvnbGRQv/I=
X-Gm-Gg: ASbGncvjXmibN4NQwdnc1tphtbQHbtRbgDjRFXCnIIFJVCHcM8u53nDLvV4oF9ogecF
	SVaY6++bUVg03hny+ly7m2fHti0VtzXdlpQP1suR0qcRNQMqLiO7we4qgbpsBRS4sJK6R+6GvkL
	JXWZzLUHgtJJGBOaRnK2JdndvEKobE/SUHjsdLWf8gv10w8exQlef8zpMVnhJ50WmnSIp30cQIY
	yN3avEUSSu2v9uUN+yjRsV19Kz3hoIJAHy8SZSxQUH4ja1I58Y+XqgDy4YF1QTe2h6l9PW9D6wQ
	1OzHbQGTlQqxTow2D0t1
X-Google-Smtp-Source: AGHT+IH4mg/5JQuKZpcZB/tPTXHHc/VOc8GskFvFYoZ+313+CE9jE/meeMS0IG9GKD66TlKAQgifng==
X-Received: by 2002:a05:6a20:734c:b0:1ee:7ea6:8e0c with SMTP id adf61e73a8af0-1ee8cac55c9mr20369896637.8.1739796990719;
        Mon, 17 Feb 2025 04:56:30 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adcd481d902sm4706160a12.21.2025.02.17.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:56:30 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	kuba@kernel.org,
	rmk+kernel@armlinux.org.uk,
	broonie@kernel.org
Cc: arnd@arndb.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 0/2] staging:gpib: Fix error message formatting and adjust memory allocation style
Date: Mon, 17 Feb 2025 18:26:15 +0530
Message-ID: <cover.1739794938.git.kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

This patch series includes two minor improvements:
1. Updates the error message format for invalid base I/O addresses to use hexadecimal notation.
2. Changes the memory allocation style for `private_data` to use pointer dereference rather than hardcoding the struct type.
   which is perfered by checkpatch.

Ravi Kumar Kairi (2):
  staging:gpib:hp_82335: Fix error message format for invalid base IO
    address
  staging:glib:hp_82335: Refactor kzalloc size calculation to use
    pointer dereference

 drivers/staging/gpib/hp_82335/hp82335.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.1


