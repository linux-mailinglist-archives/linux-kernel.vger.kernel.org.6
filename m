Return-Path: <linux-kernel+bounces-249406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CFE92EB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03047284C47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22216A95C;
	Thu, 11 Jul 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nBzRuKlY"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69815E5BA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710415; cv=none; b=hdCwV6vsLtSXBdeZc38dvHe5ClG0EDN/u4hEheSX0EDgzD9pmXGJ6F75/mWU8MQprV0pwFAiIeRsubfPdpq//U+KuJ//Hg7d0CpqsPKP42UAhhTpDxt9K/9pOzIydn2iLF5Lgc5gdbVoXduPLUGdV85sTA5cdxkYYuXE3HahZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710415; c=relaxed/simple;
	bh=wQlaVzi2oVlD/i9GpzFiamurty66UjO0u42LWzRZ8i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p1+ViL2Kv/x5ICXIBnz0XfsSd7k5wNhWZ/fHcxRLTb0DKDFCdHt4aKcYspms/gmqVabaSpepK30tAt6xgcAWvh5AcXZhJ6EtF/VYwZpMYN8KWYEFNFzjCgFqoaQlmqREBPVOzT2XQrcqEBvX6xeRFzXegwGz9IbSMD1olxvwGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nBzRuKlY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=uh35BdHSpG4IxRJoUWFD+ajB19wKXBRVGH2luxUgEVM=;
	b=nBzRuKlYzSOWqoehi6fi/Qm8Eb5eZdTCdNZXPmb3RMcgiLrV3kLKRdULmbZLnd
	maQlV/IU34+k08y+RN/ZqKBjmiwk62xUeBu+X/9A4bNBH5BpKFL3sQ310ghc7ihM
	SK0fxFd3BkRKlNHGL9n8zCxgwll/mmiAlckm7YDvD7ImA=
Received: from localhost.localdomain (unknown [114.93.107.99])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD33yjW9I9mwEzpBQ--.33715S2;
	Thu, 11 Jul 2024 23:06:15 +0800 (CST)
From: =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH] driver:core: no need to set a default value for want_async
Date: Thu, 11 Jul 2024 08:05:45 -0700
Message-Id: <20240711150545.3143-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33yjW9I9mwEzpBQ--.33715S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWrAry5KFW8tF45tFW3trb_yoWxAFb_u3
	98CF97Wr1F9Fs5CF1293s8ZrWqyr4rZa10vayftrZ3Z34UX3W8Kas8WrWUtw4UWFyjvFsx
	A3s8tw13Arn7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKcTm7UUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiEAcZq2XAl4FfZQABst

The default value of this member variable is false,
which is only set to true when asynchronous loading is required,
and does not need to be set to false during synchronization

Signed-off-by: 李哲 <sensor1010@163.com>
---
 drivers/base/dd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d047919d1f5e..47351d98f6e1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1014,7 +1014,6 @@ static int __device_attach(struct device *dev, bool allow_async)
 		struct device_attach_data data = {
 			.dev = dev,
 			.check_async = allow_async,
-			.want_async = false,
 		};
 
 		if (dev->parent)
-- 
2.17.1


