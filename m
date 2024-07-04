Return-Path: <linux-kernel+bounces-241332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB569279DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8951C1F25C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4888E1B11EE;
	Thu,  4 Jul 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mW/GZCwd"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D01AED55
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106366; cv=none; b=PNcJrg0SXeAtatLdUCbM6BP4XHdHfvzvQjv6XNSLJU78baXPKpNc61EUdWJRkAc82JAqqyNZN2GzRS4DiiigK8aAX2Km6GOFVbHujKkA2a3RnPijXesCo2XrSTdTgt3WbBhTfQcHY5n4rO7avDKzJkVeM+OfzXLq5EiRw0FOrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106366; c=relaxed/simple;
	bh=GW7lGQVvoINycqpkDuvFso5boq2/G2LMAD35CBY3e+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ofZ7A2M1u0Njj5P6HCven1WNWePGbiykPBJaI+pyzkqY0ypY+y1GPeBiiTA+uRWxP0K59+JKQ6lsnWMxHVgSdVQxjRREH4CT615HSIIxoF9uGacJLrvX9AQIJZIoLeLRrW8/0fmPgEW9zV3AxflUwACHI7+MjX/HQyJCv1WOiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mW/GZCwd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-701fb69e406so415132a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106364; x=1720711164; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNuQK2cmBkSQYJ6c7VDkHOb8OIuBPIO52OK/qSuYR/Q=;
        b=mW/GZCwdMLuDCYGHfBumEj2WD7SxreB62nSDklaqbApugm9/RaOiK4bbQVQRNByIs2
         ssG3T4Dq/fO+Z65sLxzPcWweLic064yhcs0p71aaQ7KIMv5p/nbCL98VE+xzLtGJFHJo
         CQ4SynEF6t9GpRfphbr5qrJA4tYs3Pwwm0D42ywT300Pfrnc+xuHn8D02+MS9Nt5VhIk
         zT6ET+ofEwqRRv9LWGzr5p4oWEZsJmOIcxKd9yi3vm/zO4QjH7ADG5ZqgzRSaeK266zm
         aIlAPpG5gB1YtSLywpR+MbqDfimZ3YUxf4Ce0VhhJ0ibwB5Bf/mdMmWIx2Xhsz8ljKwZ
         RWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106364; x=1720711164;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNuQK2cmBkSQYJ6c7VDkHOb8OIuBPIO52OK/qSuYR/Q=;
        b=k4KFQ6upFP7Bt3U7493Nx04Y4lSMu9g0hC9iun9tuoFcHaZyXiBxFddNmmTVELtljV
         DfRvKHb7kZDeMUIwQQxRt1KkLRsNLa7C0MnbiWuHVjDU+XDKZ+DWzdX/9xJFNMT+IPxP
         vG1T0VF/OAJxKwgaiVGhuw2u4tJw12TLudF+doeYVIB/lVu3r8d2jNmunA64yGD9G1A+
         wn8/mfU8LdAtwgD4D6Mc25/iVnLPUF01aM/Idq/66YM7eD0zAIUJy4QbOWr/R26CunRc
         bpjIorC0b560g2dCDe1KKI/q2g1W0qJMbnWsgvlFaDuldUhVxcaSy2ybZkl+s9FP5eF2
         jxHg==
X-Forwarded-Encrypted: i=1; AJvYcCWCpR6/hK7yK/G43vaoMbKqp4W3sa/wgr/zdSCn93DSc59lxEwaeryaeIoTj66QLLXM0JlILzyxR6tSrlZh8Ge7mQeIVOaNqLMYb/Zy
X-Gm-Message-State: AOJu0Yxn/Ih5BMjHrReajB53xbBsurKxTGDbaO9iGIaNfR3DEmhTX2bn
	GOlQtVPTKHfUdDvN6oK0cRf51sLp7X+6oPAlgKisrhdlKQa5tL9WiLc0JFY6HUI=
X-Google-Smtp-Source: AGHT+IFOSX1RgZBOPwSdETXKnceKwdzsvK0Bgb6C66NIKvTohb08sSlA2qq83eKVPmd1LfCeS+jAvQ==
X-Received: by 2002:a05:6870:171e:b0:254:8ca4:a189 with SMTP id 586e51a60fabf-25e2bb48b9emr1726668fac.17.1720106361830;
        Thu, 04 Jul 2024 08:19:21 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e339b40sm3259752fac.43.2024.07.04.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:19:21 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:19:19 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yonghong Song <yonghong.song@linux.dev>,
	Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH bpf-next] bpf: remove unnecessary loop in
 task_file_seq_get_next()
Message-ID: <ZoWJF51D4zWb6f5t@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

After commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") this
loop always iterates exactly one time.  Delete the for statement and pull
the code in a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/bpf/task_iter.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index ec4e97c61eef..02aa9db8d796 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -261,6 +261,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 	u32 saved_tid = info->tid;
 	struct task_struct *curr_task;
 	unsigned int curr_fd = info->fd;
+	struct file *f;
 
 	/* If this function returns a non-NULL file object,
 	 * it held a reference to the task/file.
@@ -286,12 +287,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 	}
 
 	rcu_read_lock();
-	for (;; curr_fd++) {
-		struct file *f;
-		f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
-		if (!f)
-			break;
-
+	f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
+	if (f) {
 		/* set info->fd */
 		info->fd = curr_fd;
 		rcu_read_unlock();
-- 
2.43.0


