Return-Path: <linux-kernel+bounces-319460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2E96FCC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C8228C9E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3B208A4;
	Fri,  6 Sep 2024 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBNHYO9G"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26016FF25
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654633; cv=none; b=afs6qQu3FCTYW8vMDffMK2rkEOjKucYBYUcLju5vakMFmsc8k7KZ3a90tuBT3IzYm0fM4vAW1DvAQlqxo/5bFAnAW07KtIi7btSIMPHGE4pJ/0IWr38jnnpkLb/GfALZGHVPYmThEoFI280UG/c5HODojegdjyFA7CEtsvrZbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654633; c=relaxed/simple;
	bh=0U3IVLkwpjMDkZfeMiBk78Gdag2qeYoz98SOV9ZjhNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LddxkLkeWkQHOmpjoXCeZ3qSA1PJAiBkNK8lgpMTK1Iq1UoA/TTy3RJni+BetJQr1DaYklr2lUqd1ZI9xdYFr4TUe4JHPf+5kERR3LuoGrjPkbxH1BqUhWwIUU/3kNI5s5vPXsmmWE4IyDM71hBvUe8rGgdtjW07kaah7JLee74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBNHYO9G; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so1910701a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725654631; x=1726259431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Rbk3DSuNWUnUADQJm7wN6W4544RAIhoOC0f2S5sGk=;
        b=jBNHYO9GvlC2CpF/nQPUiTAWiZMx+RRRvDbbSMb4RcSLlNxlwvHfCxNvyRtqj2BFk3
         9ppfww6rDmoNIAuxK4BhtgYo4EEqsCxGHHiKBRK7voRMrBV/fzJf2Xqt+sc3J8VE+SDE
         EMpGFBYtczfjo9CSGahuh3QdasItgXrOS5XlXqhG8WYdXUqqnle2/nSGfZ8wlAolhcP0
         iYQ5TDkZwwVUOG5FUP+Gg657guA0Xl5MIwKim66ifQK4uTbB70mtMPSyntv5bXnm/GAF
         AimaNnjJtN/tuEJwpLvGdH0/NAby7Chn5uDh2QHH3ybjkIxoHScqdwgvj+NoIRlaxLxt
         igRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654631; x=1726259431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4Rbk3DSuNWUnUADQJm7wN6W4544RAIhoOC0f2S5sGk=;
        b=kAbtQzO6olv8DTVSDFHPLc9G93DGoQ+DcDWXPVH9qJ0slTlkrtMXEs0VvoCO24+jPq
         jOmc9hO38j/lb/6wQvjFWu6SZJVI5ei6YEWKFLPkDoNawBoV4oUeCSTCHLy0rQXLgioi
         zZRnrigRwD5DyJzZ/kRZJfq4duEuLn9U+fk27RSiMJJ4WfQcDJTCdZ3qRRrixNgCzIoT
         LT4ttV9meActS6s+G+oKym3uXziMxNSUe+nEujADo2+oQPFh1c8DGhMK7N6U292S3LSZ
         xJ+qFlmuSfTbJQiljuhg1cyA+lOnN3NwSwblF36bHszWCoBZBz5lG42Tn9jr+ql86kMT
         fXSA==
X-Forwarded-Encrypted: i=1; AJvYcCWmpqMSQHDA4gb4giSUuALLbqKQ863dmqWolvimjSnQh6ScbTXZqjvIQq+G2xlc97Tv9t/xM6j90fUND4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79Rp49tNy9sSvbhnQEWCQvd7NKpTREHxaLjpEu7Jxl7UsnhgM
	jEsvHV8mefhhVt7qo9sf4v/snuixbXeqHh3ODIpvIEu2qnjyXU5NUwmwUg==
X-Google-Smtp-Source: AGHT+IGuIPEMdd6VovONJwvSbjzLMykxwVa+nAo5z+4FoAWmawKEHi+mVzXQxr9JR6yR3pyp4tTHTw==
X-Received: by 2002:a17:90a:a414:b0:2d8:efd1:22e4 with SMTP id 98e67ed59e1d1-2dad50c99f5mr4690851a91.26.1725654631387;
        Fri, 06 Sep 2024 13:30:31 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc11051csm2039919a91.42.2024.09.06.13.30.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Sep 2024 13:30:31 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ni_routing: Check when the file could not be opened
Date: Sat,  7 Sep 2024 05:30:25 +0900
Message-ID: <20240906203025.89588-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- After fopen check NULL before using the file pointer use

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---

I'm sorry. I think it's dirty because I'm not used to the patch. I'm going to write it all over again and send it to you.

This is just a defense code just in case.

 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb..892a66b2cea6 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


