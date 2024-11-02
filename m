Return-Path: <linux-kernel+bounces-393244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E759B9E32
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D11F22C41
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8E1662E9;
	Sat,  2 Nov 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbIXG55G"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DD14A630
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539882; cv=none; b=cvrCGEMs9QxYiMDnDLQTZXu0vkJzAfpJG791eWNgQsLCgodbwZbsU9fq+AocGDoFqbpf5xwMOgdBSXooWq0qwPF0R57XwiqAmLJIQn9x3y3YnP4oj3Ejb8eBYrtdj7UCvmGRL7PBUaB3hNMrtoWfoJKi4txDHktwfxQTs9/CK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539882; c=relaxed/simple;
	bh=H8Gb3WLJbngLpNTN81q7DwfW5UpCvmMUw/IR5xIOfr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z83YEhHhpzC9WO6Qb2Hg2LwrCKlzrJzOoAXUZzIkfk9nz/AOH1fCy02O56edJI23iz6h3PogfI4/w2Wss7+VhBsx6FW3cBSPEnOp/W3Q+DyCTVo+5RYPNx9G3L/t/qJM6F7MFyq8UaMcHvXAzquJ6oOnzP9BIb/FnKwcBTUe330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YbIXG55G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so23336435e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730539878; x=1731144678; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y20IPLl0T1Inu0ZWcS2TQ9J2Ib1jjVRfeGEd17R1p8c=;
        b=YbIXG55GqcQ4NPSVURngZzFPwMzQYTqsc2WZft4XTzMn9JhbGbXjxNf1vNesUGKl28
         yZad2LQll6+By0vhwVBMsARyXLYFPrIg8L4vdfnsbcY/czATgHH6xt5Pyk2OsJmzXj3z
         MCOLcFs2Wm18LdOqP1xwst92qdyZVT5xu4Tct3e2IzTGtJZ8ERFymk/EDdf14x/3MHlY
         1dsfvrNtqz8HPjZz0MCeo+3ezwOCs0mnA1pCK9Fw9L3g5QXApbw5U1P97u0kfBDOWRRO
         p+AOz6Gd5PwsFwgitA9EYV0iFahtoU6ioutXKq5eJX1n6+WmyI8KFlbdtIhPp2d1GZKr
         mkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730539878; x=1731144678;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y20IPLl0T1Inu0ZWcS2TQ9J2Ib1jjVRfeGEd17R1p8c=;
        b=gzvC/l6mjewQ4n2rOK5TLt7PyoKTIpWE046St/pmACKJXr1JBegAA5ZdBaQ+VqO8IE
         mh0nNfZRX5Y5fjVI3Jfy5mlXPfUs/ZeB40qLnZoHMgGjiEZ/DxvGDZ/UgCY9L1ekxkCF
         jm51lFImZToxLbKhByHGHc4Zi8P3Q/CxtkQGDDYsJnnzVs0tmEdXkQtZhzYHoi6QewNr
         +cQpUX8cMP8kOd5b98Kitbtu16bWdQtjNCssD/Qo2Xvkdh3oqMY9UuHQ+PVdykizn3J9
         RjzMvWaGOJvJG3hh7zJ9Rhx//Ik8E/ZVw9MdgRqz+4kOKfa50No03kdJubHeO6liBhT9
         qJRA==
X-Forwarded-Encrypted: i=1; AJvYcCVchT/E96RGXAIKsMgbO2qEDeeV4VivMZ0QujHZJB8vk9RGnFFlbo9CzClgIabyuQ3Yb3RZhhaiHty6ovQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp86E164iEa1C1cBydyan1fShaQgPz1rwnPC7B51+wCRHSk7Gd
	474Sa5Muk5fU1F06HT6nFjsSbCJ+FXg02/bH3P9c7/X2MAmvW5btvPWe4PWKlX4=
X-Google-Smtp-Source: AGHT+IElQhl8RTx1u2Qv+Hf698kNw66wgtCjAXGbW3mdm/POfTMzJMzs4xEy2zd12QkNz0gSnIZD7Q==
X-Received: by 2002:a05:600c:a08:b0:431:4a83:2d80 with SMTP id 5b1f17b1804b1-4327b6c1c78mr88114585e9.0.1730539878363;
        Sat, 02 Nov 2024 02:31:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ac37csm88619985e9.10.2024.11.02.02.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 02:31:17 -0700 (PDT)
Date: Sat, 2 Nov 2024 12:31:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tycho Andersen <tandersen@netflix.com>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] exec: Fix a NULL vs IS_ERR() test in
 bprm_add_fixup_comm()
Message-ID: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The strndup_user() function doesn't return NULL, it returns error
pointers.  Fix the check to match.

Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7e24d585915e..c5c291502dca 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1512,10 +1512,10 @@ static int bprm_add_fixup_comm(struct linux_binprm *bprm,
 		return 0;
 
 	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
-	if (bprm->argv0)
-		return 0;
+	if (IS_ERR(bprm->argv0))
+		return PTR_ERR(bprm->argv0);
 
-	return -EFAULT;
+	return 0;
 }
 
 static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
-- 
2.45.2


