Return-Path: <linux-kernel+bounces-410518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DE9CDCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904D3280ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26921AF0BF;
	Fri, 15 Nov 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="fEGi9A2t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC614A088
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666884; cv=none; b=GXOvvCnNFQS3/ZenBh6I4Ney96wdC4DKyfIElRdNOHMiJj0gd7LFb1DLVjIyTBXUupRl78mMKm3mDUwaHvuk89qCUXIRUdgBhvjJFmnvXp5HXUa/3329HZmuuRjrpowmwSyOI9t1rFB5WudwO5WZ7pTFl8JcbJ80KybILv7DU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666884; c=relaxed/simple;
	bh=0k5j4H4ThGyosbeAZR4mh0eRqVc7n4UR16sQfdLyedA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iW/4yx8tWmT1FK+J/P+Xk185nwkdksZEXCWbisw5LlgKkGsVRPde/YWS00Yy4TUUMmL5JKhTGvTHXU42fgpXR9mpQxpnUuO1j0xpFmbLouObamW6nu2uOgdU3w5w+MoJ+2HjDG2CrTMcYNrdW4T8dCUpVjXfyqY8D/1/cru+73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=fEGi9A2t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cd76c513cso15063725ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1731666881; x=1732271681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCgxJEtdxcQBWvgHN5JlceMQQr3Zip321u703iLLdL0=;
        b=fEGi9A2t3o455S77tsQS3cBkhSd9nJEm7y32uh5DFH1DBAdJpu1ZIl6A7dT4Dy1BS8
         F2/F6sOxp/LXFqb0mDzejZQAJ9xd7Y67qTUQULjvIKicz7I2lwBU4Yj2jrQxNfqaN773
         YAyklu8DAQfrNJ50ccYTCapqC/R+IL4q3nbtYGkQG6M5hDCvpG9K6QeEFRYkjZCHeVJr
         VjAxJJr9BmC3hLXH53aDVE4Nwpc7RP3O+3nezKujUf5IHkl3YIBC9OONX6yQaDOh75A/
         mznqq2epMZ8oIyf3AthAUPk0zAXsjiZYDnUR0w6i5k1TGiKdRTzzgGk37TcEj/7ZLq90
         MXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731666881; x=1732271681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCgxJEtdxcQBWvgHN5JlceMQQr3Zip321u703iLLdL0=;
        b=fQv1OW+6+VtjC+yQ6tCB5XgEh6TbXK6tbHobX1ZITfreBOIO3onSGZ16FFcmdEVwBO
         RjscsYM49h+6Phz4/360sCImWXJwyjfApBVXnJ0VRKD7Qs532Khe0UR2TeNs1ZHm6Y5I
         1ufn5IKyNpPnACKYcogVUQMwJssTPAQpq6U51CutXLs3dgAtNovVF4kKhsqtOxn1A0at
         zpG+w1o/ijOUGmeBX77GEDhkg2Wia41tVpENMD8LVmzsqPYrdDXs7bmpg8Qbvj9syOt2
         gIe5Ck4oXcEaPoHKuvBCpHnlKzwjbIwNGxyXpV8pfBv9Ev3Kr5ooFTpMvIzmxXdoN1bD
         isJA==
X-Forwarded-Encrypted: i=1; AJvYcCUknAmkdXUCik9+Na3+6mtYW1dBZpfsVV/MJKIdFz4//JDXKlibE2xyHWEkx6x8sHpD1Q3i5soxJvnVO70=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXclfmthh0Q79qIJkJsEDXYNRx3pEpzjzc5zLybwZr90TM8YS
	qybpCAQO0cUIl58MgJEPjs4Y1KRDW4GT4Wgs1MJEGnRdoC+yW/NRmykKCABeSvI=
X-Google-Smtp-Source: AGHT+IGdmb5QMtEi6lF6HVCbZpuUNSUsm3Dwd5WKiUob1G+Fjl1XkprbRQ1GycAsAJid0oXqoEgdtw==
X-Received: by 2002:a17:902:e885:b0:20f:aee9:d8d7 with SMTP id d9443c01a7336-211d0d81e71mr34790435ad.32.1731666881434;
        Fri, 15 Nov 2024 02:34:41 -0800 (PST)
Received: from localhost.localdomain ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f36dbasm9519345ad.156.2024.11.15.02.34.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Nov 2024 02:34:40 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH] libbpf: Change hash_combine parameters from long to __u32
Date: Fri, 15 Nov 2024 19:34:19 +0900
Message-ID: <20241115103422.55040-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hash_combine() could be trapped when compiled with sanitizer like "zig cc".
This patch changes parameters to __u32 to fix it.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8befb8103e32..11ccb5aa4958 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3548,7 +3548,7 @@ struct btf_dedup {
 	struct strset *strs_set;
 };
 
-static long hash_combine(long h, long value)
+static __u32 hash_combine(__u32 h, __u32 value)
 {
 	return h * 31 + value;
 }
-- 
2.42.0


