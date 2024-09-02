Return-Path: <linux-kernel+bounces-311470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291ED968996
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D4E1F236E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24019F122;
	Mon,  2 Sep 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCc3lWNL"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81819F10D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286459; cv=none; b=BFemLKIxcm1hT8+lmPr8ymw8l3zrZXsj9k0cSy0eRyiypqtA6/Aan5jcrVN/dGUOlbV6MR6zVE4jiwEDu/lGEcKMdtGIj0RpdIQ7nVXOGXgIpfqkj0tgOeIXYM9K14cWmnk88JmAbCmR4BNA9y2c5e0qYEWCjygwNyeEA2QgSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286459; c=relaxed/simple;
	bh=rZtYvZT3t5YqCKjvKOvn3lPOS4XRObzHCChGIgVH2LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWUGJJGB1UYmDORIeCs5+uHcs10OEokyzelgHqOKTQBy0V7IGRq98bP9BHo33M/ZWrrcWSOEIN3n8qi9uo5MvSI5bhnjy78cOHrLe/W/I9k11z0Nv5anK8BP4K9UpwOTs8thcJ6fKRYxG8u8X6O5FbJqX4jbpJUre0zy3N4JWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rCc3lWNL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so1413116a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286456; x=1725891256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjWGlL8hpxI5HTF7bPRe18FLFY36d+1vs9Q/uivOOnc=;
        b=rCc3lWNL8d+H+n6HbPlXxacLD4EZTUBZZ33Hjmp8ok/p4Pdlj6IvL7u4fnArp/htyF
         //FCzPZ1yu8+HGymAM5kTtz3dpVghgftFj0yHoFLM8/ASb4r6ZpAqmIAGYWhqjGnyiuw
         nsfIrLrMxm5ap46fI2ZGFSy1KjRCUGZDDc8PORKRUL8J4uB9OzM3dj9yCtQkgJmx0V/c
         I2OufUvYu2oNuYu0xGbpLrSYZds7w55mpvUtXCP07sKmoBFroqa3hw4l9HXj9oREbaBY
         SG3HQZwHlUG3/j0volIafl+ANEMDWt2QCDmE6P9Cc5YPMeq4k2DzBeKHDmPCSnRBbKfH
         /nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286456; x=1725891256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjWGlL8hpxI5HTF7bPRe18FLFY36d+1vs9Q/uivOOnc=;
        b=ZwFeEdzoJ21j5tCfZvduSwGLhJ3NpKp4z/A9SrNoeK/0Y07IZH+S1gMbKnjjqQvXXF
         IY0XrilRYOgmKz33NZWVknQom0HV9JuCmGKJVGOXoeKDoutrSR0VKH57K7tRAWxblKL9
         yu5WyOQvNmqhAwFMhX1aVGJ6r991IoH4V60r40q/bCr6PL2KosstOMV3ucZTkg0wM3lk
         zEgrDcpyn5BXJ5H7WUzd79J2I+k6KXM+40nxwEam0Y1KL22/TZ5YHXLlRo3/iMYv1zJ/
         oD6YvVCm/tRlV4J1aIeMTvDZF2gPPtkYY0zKNMjiUSowian1f5AiRnENL8sqeLzojMSC
         BA/g==
X-Gm-Message-State: AOJu0YwpwaTimMAg1VSy0t9wJ9Bd725j9nWsJVye0TyivLGHcpy4/bNx
	cnBUSQt2Zy2WZay5NGfCD+bLJIwbcQ3h9mUkMcxGZUkurotxgjGjRMv3PxV/KJE=
X-Google-Smtp-Source: AGHT+IH0BcVVK1LxtoMIW2Z6XmDWh6/SSmViEJR1CFiT4bkc6RbyjqhtxYslO7fB/ykIFA4yNox6Vg==
X-Received: by 2002:a05:6402:5303:b0:5b8:d362:3f46 with SMTP id 4fb4d7f45d1cf-5c25c423f4cmr2363814a12.35.1725286455662;
        Mon, 02 Sep 2024 07:14:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24ff04551sm2370824a12.35.2024.09.02.07.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:14:14 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sukrut Bellary <sukrut.bellary@linux.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] misc: fastrpc: Fix double free of 'buf' in error path
Date: Mon,  2 Sep 2024 15:14:09 +0100
Message-Id: <20240902141409.70371-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141409.70371-1-srinivas.kandagatla@linaro.org>
References: <20240902141409.70371-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sukrut Bellary <sukrut.bellary@linux.com>

smatch warning:
drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'

In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
fastrpc_req_munmap_impl() if unmap is successful.

But in the end, there is an unconditional call to fastrpc_buf_free().
So the above case triggers the double free of fastrpc buf.

Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5204fda51da3..878a6746f994 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1910,7 +1910,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 				      &args[0]);
 	if (err) {
 		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-		goto err_invoke;
+		fastrpc_buf_free(buf);
+		return err;
 	}
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
@@ -1948,8 +1949,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 err_assign:
 	fastrpc_req_munmap_impl(fl, buf);
-err_invoke:
-	fastrpc_buf_free(buf);
 
 	return err;
 }
-- 
2.25.1


