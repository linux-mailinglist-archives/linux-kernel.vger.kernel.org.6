Return-Path: <linux-kernel+bounces-243071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D192911D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC74B227A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0241799D;
	Sat,  6 Jul 2024 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="SHVd2YsX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F917740
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720242889; cv=none; b=d5+tsLBv5y3IuwUgxUrHzd2hNdYDTLAqrpVBqnOK8ZAJKB6JNFyL2n0ECDzgVpnJR1ZOr2VFgYcE8rRpQqFgT40kWBpNLywHN0lInsQfqj7e3dAvL1E3aEnSea9pQ17LxwLcD9PJIEFedopPaCEW9EJs7oG0c/kuJP+O6DpxqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720242889; c=relaxed/simple;
	bh=mgf18Fc9En0jFpIVsTgvmKPyThGPCz/ikS0vOiSXnio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fssuaQCpa1Pod1GaqkMpcdis0F09m/IlxE3IgBb//o9CRfo3agfBXugHRpCoX0JOG4mAbQyTlJ0CPEpq5yK8h+HP6ce+crDfEd3qjl9m5yMnNLK6M4uey7wgpkYbeIhtr5BUNQq2fbriFYcETJsn4BanxA+J3WXCjeR59kqjuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=SHVd2YsX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a5344ec7so16186655ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 22:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720242887; x=1720847687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Giw87SQe8yuf6FkxysGSg/f7HoKphY0bMqQbHsvLA3c=;
        b=SHVd2YsXu29HYrL/WxV6hSu7V8Cpe4759sOtZOXD9ergNdhjtWxykVop8QGOY5Id50
         NDl034feKXh8we1mv5Cfka1WktjrJ+KqbqtBlOYlXxrxSwrunN2lUNc4Q2x14S3/028d
         ZzGhzm/jNlhOX4ZHodzODcE+256lAGPktuBe0RJvOfQ4fXSk0iECzH8LXtQXWuBAAiw4
         qWMraRENifRlWK50M9F8fAEZ2wT6lvJIfif2QIZoKZgkC44Fzm3cv38J9DnE1v0zNHYw
         RnelGw8A5yZBfRmBnUmEs8Ji6U2lvteKq5FDUncRxIp6opy5OA3hUKRtq+Z0VJdA8Jtt
         gSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720242887; x=1720847687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Giw87SQe8yuf6FkxysGSg/f7HoKphY0bMqQbHsvLA3c=;
        b=ofxs53TLd4u9cErK5r5OuKLitRKqucKgMSu8WChx5BQfqjzsU9SV5mgmNqp3FyfHPP
         u4534Bclz1bmzDE6XtegyB/CH+2PwU+PjGmGvJk3NpdsuDqMSRS7I8bYPPBEl86VAxfZ
         oIbM1QPutriiz/V4ePpht82dkZfRRrboUve0e6Rf95ob1SusYondfAFomFgdaUr23T6x
         XPOxRseaZy1n/CI7owBCw+e1iZEN4VP1CMuNdwovg1nqgxNFGmBev1jfGaIRY96NirOC
         Y8bGcteHRgeiFZ6PXgWZaa7SSgg+D+Or201ctvgyhvFAGP5acMkpvLT1XbfpRXE6vpZs
         81Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXlOe/+zfSQaR2g2ptdu43hqP7Mp0KFYnmnGsZKkyw0aRz0JaWlJsaFcSG+Of84IppEB5nBEkoj37DxymyUw7bA8uxxOE1xv5n2qyBe
X-Gm-Message-State: AOJu0YyZsQmhiECJiadOwn43usHqFfncSuX7ALa5ZsMZvu8GFqvBln7E
	AZ73tHar7JP621LdjUomro4MecPCnTmmJ1bmMuV2FrTQz29l/rJWFrOoJUS5060=
X-Google-Smtp-Source: AGHT+IFnQuT9OJyrEvKbkFbzI3EZR1voDmFuCU345bHL7OeAXzihbf1UNVrtwjUCvtnM/QKF/0czFw==
X-Received: by 2002:a17:902:d58a:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1fb37055ef2mr103534355ad.18.1720242886676;
        Fri, 05 Jul 2024 22:14:46 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3dbd7dcdsm34174015ad.157.2024.07.05.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 22:14:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH bpf-next] bpf: Use max() instead of max_t()
Date: Sat,  6 Jul 2024 07:12:46 +0200
Message-ID: <20240706051244.216737-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use max() instead of max_t(). The types are already compatible and don't
need to be cast to u32 using max_t().

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/bpf_local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 976cb258a0ed..f0a4f5c06b10 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -779,7 +779,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	nbuckets = roundup_pow_of_two(num_possible_cpus());
 	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
-	nbuckets = max_t(u32, 2, nbuckets);
+	nbuckets = max(2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
 	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-- 
2.45.2


