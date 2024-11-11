Return-Path: <linux-kernel+bounces-404377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5179C4305
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40507284241
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67B1A3035;
	Mon, 11 Nov 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4SDUtYw"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EB1A2C3A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344010; cv=none; b=njdGYyucnzo165o6tL5UA0vuC/huKiIknrJUgjybtO0ZJa+WujARlnXmXsELykIpR2tLzO7xIHsDIFxRsxbQpJTDk0N2M7NSZFKnQ2aBmvkCdC4ovtAcK51w+hnUSsVPGLxTayVxEvL/AqPgxL3j5vprdxJz9QjkKk4XfWYytLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344010; c=relaxed/simple;
	bh=7jB/VlRFjzf4Ba1mF3gK2PSxXXZWjrnSx7YLjrpKSQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xt3uvPO5FV03ogqi3s1WUrNbj8uj4to0tuMBMyqzlHq7cVDkowX/LSumFx1ybDqPaGY65dkGSGtWHUCmGfVLrAiJVuZ6ag+m16xCz6ffoAIiRk5N+qoPjHEB5wK4dXWTxzd6oQjcpHQSJxueSPXgP4dOiqbeFg4yPOL3PwaaRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4SDUtYw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2110a622d76so41643755ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731344007; x=1731948807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp+nbh/dZKfux7FpHpW59JPT00IgC82bEOR9JMylv+k=;
        b=l4SDUtYwBW1rAy4ev/WRce8Tog+c3WzMGC4SWW4dO8G3XNxv28uXcgqrFm14jWUvvX
         3CegGh4svka5I2HyQT8l0SALGlloOqKIlHLJIRKM8qnHrEY41TMV/Z0hwn9gymDLl+v3
         LsTtaDNAnn8Tmu1GjxQCQRonzzREdXdwRQtJ6sYSKCq7v0q5cHKJpOM3EJ2EPLrPVLCi
         6ZR/sxuZmBmgQauUzajFVE+sDNQJ8mJncl2kTdqS94FTdY0cN8CcQKkrkH7PllQc+VAK
         jfjD+AnF0jgROaiFqQtn4iyfKGA4wGnAleTpwbPmXqM8IVYELFv+SSNReHMMUPIxbNU+
         ffjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344007; x=1731948807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zp+nbh/dZKfux7FpHpW59JPT00IgC82bEOR9JMylv+k=;
        b=ddYU18yqcPUxcMJ/qyftm+eyEpGqXS3ngoIcUAC1Xcnw61zi6bEhLwAi0k/5qzomBo
         tUn4na107cwm2ISDdW3dmK25h9Q4bqGjmXvRd4tCqcIGSErtZriamuwQA1RUALCp2Ozu
         JVRzCYo+thBEji86Yua9kLiqJfjYuFZDlcbtT26QyK097rqMsizSVnraCDn4Ooi0jcip
         AhHx41uAdZvalzKrd657dCHHim2izG5SyeRFRCexJRwicFlCS2B/uXKtBRSy00lTg+BM
         KmbTs9zLmeaClecUEdEoKOrTJ6Vqk2JS97mWdPpskwjSMi5ypyLFdasNb2u+Tjy3F3uN
         Vwaw==
X-Forwarded-Encrypted: i=1; AJvYcCUCFTaIDb0t4hP6eQlGJDoJ7e40ytddlqEGkbwoZYPluq20nELUlXcBX/FV7Zx3JMHAp8e74THWLgZjW/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGR3WBn5LjwBRSTbyFb507F8x2AgjeRVlpulJihDvepKfL2IG9
	ThuAn3WuydWpKswjLl9HIKfdJOMdetpY/gI/mKs8zHzW0agZ937P
X-Google-Smtp-Source: AGHT+IHXISfj9AJxeg33E7YdEoBMj42RHz9afc6u3daioNxNqg+xQD+UBy59Q/iDkkJ+0C2kRQrlew==
X-Received: by 2002:a17:902:eccf:b0:20c:8abc:733a with SMTP id d9443c01a7336-21183daceb8mr208915355ad.53.1731344006976;
        Mon, 11 Nov 2024 08:53:26 -0800 (PST)
Received: from localhost.localdomain ([2409:40c1:5f:8acf:5c94:d8c3:91ab:c98b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd154asm8809116a91.40.2024.11.11.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:53:26 -0800 (PST)
From: Amit Vadhavana <av2082000@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	sfr@canb.auug.org.au,
	saravanak@google.com,
	ricardo@marliere.net
Cc: skhan@linuxfoundation.org,
	av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: core: fw_devlink: Fix excess parameter description in docstring
Date: Mon, 11 Nov 2024 22:22:53 +0530
Message-Id: <20241111165253.16672-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the parameter name 'con' with 'con_handle' in the docstring of
__fw_devlink_relax_cycles() to resolve the kernel-doc warning about an
excess parameter description.

Address the following warning:
./drivers/base/core.c:1994: warning: Excess function parameter 'con' description in '__fw_devlink_relax_cycles'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20241107223528.3781323e@canb.auug.org.au/
Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 78b2c0eacb26..94865c9d8adc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1971,7 +1971,7 @@ static struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwn
 
 /**
  * __fw_devlink_relax_cycles - Relax and mark dependency cycles.
- * @con: Potential consumer device.
+ * @con_handle: Potential consumer device fwnode.
  * @sup_handle: Potential supplier's fwnode.
  *
  * Needs to be called with fwnode_lock and device link lock held.
-- 
2.25.1


