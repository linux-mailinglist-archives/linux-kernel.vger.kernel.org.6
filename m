Return-Path: <linux-kernel+bounces-418614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE39D637B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A5D16042E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F01DE8B8;
	Fri, 22 Nov 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZd97TWO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FB18452E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297461; cv=none; b=Ly0f5YCU1zQQV913+EiecS9L4GW4NpqK/BjST23KKly0EmvNFMsVE3JoqflH//i49nBdXDorcBMSqQS4tZSLu9w2G5LP5WTBnJzkJ1E+nmMAHgvFamIe3pL20k/591zDtKz9NIAF4tSBUsNH9bb3rwc2rYKcdoIUVD0RoByxuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297461; c=relaxed/simple;
	bh=U8RdlSFjaBtcAuHDk42rXE30sHYRay/0r5iABcDGa2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YzhF+P4Y7K6kG1HCMlcqA1NlcFgZ+r9FCcZS4EuAH8NJMeCHN8EPaJdhImuofDb6XoN5CMxxXiicClQmTR3NZbJ55o6qzVnymDoOFgSdn1cyvc5+XksJVPp+L234GayQ4zSOFibmvaA4/7o7MThCFkIu1vgDMUmv60AFaFiL95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZd97TWO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eea70c89cbso28107137b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732297459; x=1732902259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yj1n0zU6JR6TtWJJSwgCR8Y16uC2MOhbrp4MIHnT7BQ=;
        b=KZd97TWOx6fp7UhQ5bbggFjOvaoPCatJ6sN7SrlTZEwyfKN+hDJYdX8HtCvcPSKi1f
         p0osb3bYfbLf03xsDqlPtiFeegPJThNoEN0ntTaRV/BY2tG/h4X2Q7Ww5EeaGb3J/3JZ
         MAvAN79Gulz+kd1GSW6s5iHIRgo8J6gsUhg0TbFCBe7qY1F7Dj+fGjLe79VI3hQPDHM/
         HflNLqHwYu6MfQpvypyZQPVICnmKxf2HaiEtuPvl70h/HUHKOOhOFtJxjVD9kNcaXY/K
         a/kdf+eswZvPsDKQ3D6OXGLiUWTR/8/eoVGLkDKTlIS+wgCmvBAJ1Evie+c3VU+jHbch
         EuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297459; x=1732902259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yj1n0zU6JR6TtWJJSwgCR8Y16uC2MOhbrp4MIHnT7BQ=;
        b=AuEjTkJhDD4B6weDiVo84bVcPgelOgV+Y3vN4LQ4s7zC7tcdxECmhU5xsVIvRczDx/
         9hvQbhRiuApqwnSer4LaLT8RQx0w3hh1WEKvNsalOQoroa85oH4RNzut5zADBaqtqUDr
         5Azxrg2oQ1iLnl7kbk73JVXUlg3lfk/18zujO39AcRVkEMKcUHY3w5j0Vw3DKZWJ1eTj
         mhrIiAtCudHCfKsBm3+ViETVM/sqlg5MUsSxhhQUdRbA022ufyATfXiZEjP21DkAMnmd
         jGoG8SZp8Xf9wqCqHsQ8MOFm/G/wuG3GFdNFsxqJz4dzyVYYuyzVfOoddAc1G4lSOi8u
         QYVA==
X-Forwarded-Encrypted: i=1; AJvYcCWV56kyDPb6vhOy0nI3Bwk73U6JEyLndKocBlbvnjR/Kk6U1Igo4EYrd0X9noJ7KLvQk6r2mWksG9YuWO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx852pWg95cKD6BHWyQa5KN0sA2E3pKM/y99Et7Erc8Z4+zd5BL
	ovl+rAIIU8x8OMlKKJSpqhlnuNURBHRtcBCDwomDlV5MhIjFV2Np24VP5/wWopuWOlqI3cC1S4g
	bXA==
X-Google-Smtp-Source: AGHT+IGq3cGWzdvvhpU8u0wQHDoiOGsV0+vlaDIGvQqvSQKVuhJtv4ZEC6vOgRsc5zcknFaXDhykLQhGUlY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:8f07:6a96:7af9:8fe6])
 (user=surenb job=sendgmr) by 2002:a05:690c:dc3:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-6eee07b3563mr576407b3.0.1732297459074; Fri, 22 Nov 2024
 09:44:19 -0800 (PST)
Date: Fri, 22 Nov 2024 09:44:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122174416.1367052-1-surenb@google.com>
Subject: [PATCH v3 1/3] seqlock: add raw_seqcount_try_begin
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii@kernel.org, jannh@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add raw_seqcount_try_begin() to opens a read critical section of the given
seqcount_t if the counter is even. This enables eliding the critical
section entirely if the counter is odd, instead of doing the speculation
knowing it will fail.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
Applies over Linus' ToT

Changes since v2 [1]
- Added SOB, per David Hildenbrand
- Added SOB, per Liam Howlett

[1] https://lore.kernel.org/all/20241121162826.987947-1-surenb@google.com/

 include/linux/seqlock.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5298765d6ca4..22c2c48b4265 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	__seq;								\
 })
 
+/**
+ * raw_seqcount_try_begin() - begin a seqcount_t read critical section
+ *                            w/o lockdep and w/o counter stabilization
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Similar to raw_seqcount_begin(), except it enables eliding the critical
+ * section entirely if odd, instead of doing the speculation knowing it will
+ * fail.
+ *
+ * Useful when counter stabilization is more or less equivalent to taking
+ * the lock and there is a slowpath that does that.
+ *
+ * If true, start will be set to the (even) sequence count read.
+ *
+ * Return: true when a read critical section is started.
+ */
+#define raw_seqcount_try_begin(s, start)				\
+({									\
+	start = raw_read_seqcount(s);					\
+	!(start & 1);							\
+})
+
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization

base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
-- 
2.47.0.371.ga323438b13-goog


