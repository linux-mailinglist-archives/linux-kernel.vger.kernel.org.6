Return-Path: <linux-kernel+bounces-320247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8D9707F7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A628226D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB6170A08;
	Sun,  8 Sep 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ow08Tp/V"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C116FF37
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804440; cv=none; b=B7O89z4Fy/p+4nOxuDzVhuIXvWwQLPIwiCV1MVof3eBEXV5HHo1yYNao/cUTpwDmwlEjwdWadPZlvIU2bCd+DfTeh0vcDl7gdsVagRCg5yXpIZ2f/BgCVdJhRyGkgSPr8KSsGf76pEcbqA5wR0veCXlOFo6BpcYiqmT7tc3Gumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804440; c=relaxed/simple;
	bh=mo8CzNGunHuO64tHr+6qMjdt496cUslWuBLgvsDihKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRds3TR3KyW1maqRIgKq6pB4xL4Cmles3K9Y5vPx4qQypI4yGcUwF3EJqLQJLPbTjIgv2IJFuZTt10+Sj385tvs4PjDupOcUZORkKmzc5lvX/VDnZ7tV7JiHWqQCUeDGd2BlcRFY/yo+sy8GaEvJ2hVFejSI95X+dZAqF3jO0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ow08Tp/V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cacda27d1so2194895e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725804435; x=1726409235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29SIEneF1cqyaBC9DVH0mHI4s+16R15C9iDveRntcgA=;
        b=Ow08Tp/VLJ5MfRq7uqBRiahBA+6leC8LkzN4ZEScBdm3TlbV7+r0XUNA3y9wP+IKNf
         nPUK7Bc+BN48YRY4p06I4jdby5hj8J5J3RCRlJJAjr77UVKuup5mn9oN9COxMqUNJTG+
         DFlSeDstMpDZ40sMI10M0lcSLuyz0s9CVLuSR/84e8j7I4L83bspxSm6/hxhaXFz4nzI
         zjwikny1tQ6YtJiWoS+/2vENLxQ+OD9YXH7I/iNJN4qfzsICA+EtjOGBd5AlAinH3W7J
         uQ5Ou+oK34t3qpuwwWZpzdh4Ek9rRayI7IoWJhepRvqVPZ3+vBwtmw13UxqzUEi4uo+v
         WhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725804435; x=1726409235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29SIEneF1cqyaBC9DVH0mHI4s+16R15C9iDveRntcgA=;
        b=szy0CXT9q9z9lcWojzW6R85Vj2TlCpKC7xXzEUD2B3uW2dpc6+gKJQGw1OyyQQ6aBc
         H39nqPWWDVZbuks/2HxUNs7qCjpTLKzVjTtcRZapMXrLYjFE4f8qg6zFRRvSXutqkfI/
         JC8z0ULYMazvwkuniBtecnHbYtcrdNK06W5fhEv5TdgvGA0BdkY5CECc448x1F8VA8gB
         oB20EOIS9acmYEaZA5ajEkWk4qRH0ixnp2vyeQin8zcbSXx72MqOZTQVe8AE/vDC06oq
         r6G+DYsrDNMWSGHLMXC/PlLwA+Yd/uepJKCfZmzNmU7VupjUsYxs3tN/gNSzMUEnNRja
         taAg==
X-Forwarded-Encrypted: i=1; AJvYcCUe3ddcKofFFp+DnlexEY8suplr6DiChrYQb93qvnRC1PicyEj6cHN0RM3kZMBppZj+1PQx3q8giBSLGIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vJmTJPv6zBicMQW1xJhHcTFCLNTRPblAfAiZBVKXnl/YM00r
	Rkm2b9nP28ZxRot3/wxLoAI7bpdL3HesMaFMYygdbvDtgN5pxHAitU4+iTpjb04=
X-Google-Smtp-Source: AGHT+IHaYq1WS8AUlU43piYyPmURN1dkvYLnQvW/P8MeitdwlUgCLBypYHXMSCrTEm7d4ah1GXS7Lw==
X-Received: by 2002:a05:6000:184c:b0:374:bde8:3b46 with SMTP id ffacd0b85a97d-378895c54a5mr2808090f8f.2.1725804433832;
        Sun, 08 Sep 2024 07:07:13 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc074599sm4863371a91.31.2024.09.08.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:07:13 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	glass.su@suse.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] ocfs2: give ocfs2 the ability to reclaim suballoc free bg
Date: Sun,  8 Sep 2024 22:07:02 +0800
Message-Id: <20240908140705.19169-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:

For patch [1/3]:
- Factor out the reclaim code into a new function '_reclaim_to_main_bm'.
- The function ocfs2_read_hint_group_descriptor doesn't return -EIDRM
  when the group descriptor is invalid. The new code logic returns 0,
  and the input parameter '*released' is set to 1.

For patch [2/3]:
- Modify the code to follow the new logic of ocfs2_read_hint_group_descriptor
  as introduced in patch [1/3].

For patch [3/3]:
- No new changes.

v3 patch has passed the xfstests:
./check -g quick -T -b -s ocfs2 -e generic/032 -e generic/076 \
-e generic/081 -e generic/266 -e generic/272 -e generic/281 \
-e generic/331 -e generic/338 -e generic/347 -e generic/361 \
-e generic/479 -e generic/480 -e generic/628 -e generic/629 \
-e generic/648 -e generic/650

v2:

Create 2 new patches:
- ocfs2: detect released suballocator bg for fh_to_[dentry|parent]
- ocfs2: adjust spinlock_t ip_lock protection scope

In ocfs2_read_hint_group_descriptor()
- bypass the validation of GD when the BH is already managed by jbd2.

In _ocfs2_free_suballoc_bits()
- Move up the position of the vars 'idx' & 'rec'.
- Move up the position of the ocfs2_journal_dirty.
- Use le[16|32]_to_cpu() to access cl/fe/rec vars.
- Add error handling for calling ocfs2_extend_trans().
- adjust spin_lock ->ip_lock protection scope.
- Follow Glass's review comments, add 'comment' & 'else-break' for the
  'for-loop'.

v1:

Only create patch:
- ocfs2: give ocfs2 the ability to reclaim suballoc free bg


Heming Zhao (3):
  ocfs2: give ocfs2 the ability to reclaim suballoc free bg
  ocfs2: detect released suballocator bg for fh_to_[dentry|parent]
  ocfs2: adjust spinlock_t ip_lock protection scope

 fs/ocfs2/dlmglue.c  |   3 +-
 fs/ocfs2/inode.c    |   5 +-
 fs/ocfs2/resize.c   |   4 +-
 fs/ocfs2/suballoc.c | 332 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 318 insertions(+), 26 deletions(-)

-- 
2.35.3


