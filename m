Return-Path: <linux-kernel+bounces-576246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2AA70CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF33F1898E61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90C26A08F;
	Tue, 25 Mar 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TCE65fsy"
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E5269B11
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941209; cv=none; b=vD8L36NvAul1Xl5Zgfsjh6HS3aHCkDEN7a6cvLaaLrAVhe2dw4CKk+7Q+9H5ssDm7iffAJUqdNt1Qrab55WSKKcjcyDOoN5uWm7tC6Xszd+NkwvkoZMlOagcpn5gu3T7KePt+5du2y+f+fJOUBhAxIfLQ6qzVnTtmxLfTu2FAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941209; c=relaxed/simple;
	bh=IukoZe1GMKFKCT6AG9qWXRdmFYXwpjtymU1Xp2ZmbHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9DNK+HskY0RoRSjAB1W5qoaUoKrg1GIqOH7obzQXqDyzgpuWXXBvhS4wCZ46qRjX9+wBKQMSCGJUbiG+xCK0N2THxoe3aAOR9MQzjhr4IyEwY0uCfUH98c0JY2s85gV/Z9y1tt2RiRgFaWiGpSIXOJ9G8wAg+M880yi/Wh0CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TCE65fsy; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso8530053a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941207; x=1743546007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaD1f0dkmAmr6EkfX2zgrSqJ41O3Qgw2EtPX5+qTxTA=;
        b=TCE65fsy8ydcRESp4tvrbk/aj/S4bs/oaxUdNYYNI5KaqFDGxGw2dreY20sfOYpME/
         /ukTG1Pqzu0UKz9Bv4BIpe1SkI14zLaJvYMAZ/vxT7B0z7v+cuO4T3m7aY7WzB7mBZJ5
         BBZ5oRUb/kuFYPjxM8IBBxCpiFxKJwsZ3nIKYy7oHI+X+CeVlhiqJTee+X/ygAXYTnx8
         6poILVYgWhaJfiU/c4ykr+0MWmNiHYFG+CYFt8yDMM60nEtR8z7A6Hueoj8cH0pB9rE1
         FqW6LEfNjGRXgR2ECfahd8/yrxxMTECawlQFtaoK7Z3uzLip226eBKN/fijnu0Xow603
         8oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941207; x=1743546007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaD1f0dkmAmr6EkfX2zgrSqJ41O3Qgw2EtPX5+qTxTA=;
        b=eh7afnCo1QjAcg8A2foWA9+HpqYd7WPaN+mDVRfOkiZHwgZgiVdEahIt54QNIqKRef
         pdVbaqCy1xIewdViKHDGg5li1vkKnsfiG3B85iQlHWl+CtGPInQpGY0bm+5woOCIlOmY
         gjuZNA3KV1oACGJUdsZ1WB23B/LXuOsh/oECWo92e7+Dr7jn8A7Djia5kYomkBG9wvlD
         9ZQ+7ZSAo4QhWA+JGAE8Jtn0gFwUbOKIFLGNs0Jx1fj7H16iUEAh55pE5iJ452Ni0/7l
         M5YY/HX6a8MGhCduT60NlrRs+RQWSFjFumdXWhGYgkuZ7gKodKG3PEAI/OfIAAaoJb+c
         cPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWidcvfK92hNC1jlqfFn9OXzGuuymOPi+bp9NozWHmovksxm/mmOiphdz121dciVXzP2l268LLKEGfLUEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgvUEigiE5LVigKn6RX3tBJ1Qvg8iPazvf/TqNYcFh3s0snA7
	1Q4fo79u5K+4Lzq6Y0/5M5a3vzja2NQ/MEl9iHun1HKOFvweOJjul+ylcnP/fME3vtMQaaIJvLr
	h/c/hO3PFtQJ36c+H207jQuao8Rbs6c5w
X-Gm-Gg: ASbGncvRLuuC1pc3SJbcZAjp/TzeRT9XvmwGRw1FFeWXLrVR50df2TzLDwMPSIyqkox
	ePkwlSSjiB/W2FA1rEtAwDE199gYxTaXVEuM45WeI+cJkZOBl+dgxQFFJbKqfqfJ/FUeoveSy8i
	AUiYEOvyghVRoWONql4gNV85BQz5i9EQca5K/1RWdgYYNtXirOhXzQIh354DtmkvfHGwK0+b3ut
	Hd2zb9CgqBKHtxyjJaexkUxNA9CDaSY2zycGZW6yQCv/TsrNY1REcXwttaBTDVuLnRgICy/w1rK
	olDx02o+wmYoCQpyfVv0ZjaPItWMZaA6lIKR6AIz3+OCBzmqWQ==
X-Google-Smtp-Source: AGHT+IGS6Daus7qm2CJ7Yu+HWXaf3SPjvYYwo50CAFD4+MN72OYepK7+CxhHCMpyyk0kzla/ZeuQ4Em/0fZE
X-Received: by 2002:a17:90b:4c07:b0:2ff:4bac:6fbf with SMTP id 98e67ed59e1d1-3030fe56aa9mr28017596a91.7.1742941206960;
        Tue, 25 Mar 2025 15:20:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-301bf61e28fsm914628a91.14.2025.03.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 58E573404B9;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4740EE415CA; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:32 -0600
Subject: [PATCH 2/4] selftests: ublk: kublk: fix an error log line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When doing io_uring operations using liburing, errno is not used to
indicate errors, so the %m format specifier does not provide any
relevant information for failed io_uring commands. Fix a log line
emitted on get_params failure to translate the error code returned in
the cqe->res field instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index b17eee643b2dbfd59903b61718afcbc21da91d97..ded1b93e7913011499ae5dae7b40f0e425982ee4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 
 	ret = ublk_ctrl_get_params(dev, &p);
 	if (ret < 0) {
-		ublk_err("failed to get params %m\n");
+		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
 		return;
 	}
 

-- 
2.34.1


