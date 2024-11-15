Return-Path: <linux-kernel+bounces-410411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7F9CDB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0754282E74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7880188CD8;
	Fri, 15 Nov 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeRfDmx0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960C18DF8D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662045; cv=none; b=SPXvnasRpAoPV8hLBcU9oY8HW28pZoAb7iCOQ1M4opToClk6bg/ZWIwodtY9MZ2RDw44LX/Ej9j+LXlkHBTrm+ZUCi2nnVHph1RjJydSAabFjL6qbFRLK8yyQ5lBtHvEiv5bULif+/O29sPm8LWWf+qWB5EmZF0mGxDdNxkySWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662045; c=relaxed/simple;
	bh=oL0UzlFZqjOr/6ocBd/mXCjQcqAFgGA2jsO52+VBifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LsOOklxV36aERFrGECQ7zlAb9LkcGnjyVpgU97JLdg2Km9Yjs7nKs8BVad6cRVAfFsAz2WDyxBAuk1nhmKrcDL0dxysJNl1PFpUNqtnvhneN9i+MBRifd47B+ay+47Hda/3mx/RqxtClkiSMerZqYfiFJNnX5jdY9tkecf9u++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeRfDmx0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314f38d274so16984995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662042; x=1732266842; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YuB/szIEkMxlq3tPJ1z9SjBnVW4504PF0OtGMyd9Ts=;
        b=TeRfDmx0sSznIaXIO832QZ3lrjOKmsmr3ZuKVWR6RfILfEReImRvSg153NjPKvpLwg
         IdV/y/y8iPPUjb50MApxbLOeit1/zbKduAGAIappbfVINE7FvemoiPteUN/mfF/BfMJx
         pEDv71PQO9/RNOegrxJdhrTmjcgSurepFk0rr1uscrB1JPhTOujk1ESuAUpS8T+Mwt1I
         +ApDcfd/zwyaOxw//N/SkdEq+Ayl61MtwiBxJAZ1vx1K4br3M3Mup7cAjpGqQlfegirE
         oROduPYLOv3vPOf5wnlSaZGABEQy6HpUDu9cpPqAfiYvBOLSTaL8Av6BC5lRjEsAoafo
         XwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662042; x=1732266842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YuB/szIEkMxlq3tPJ1z9SjBnVW4504PF0OtGMyd9Ts=;
        b=d5HWIKL3bVX8JQs+4a69jYoEiS7OS2DwUu7MTIp/lu4b8+TU3MPHqn44lkDTlav+E4
         JriqGIfgN0fyF1G/wVs2hxaJeRjbmIy0mLTehEYqNggrASXaa8yyB2nsp5iQyV6nbfGt
         reJ3DwSVYkJLITqSiJlTRf1P7B7hxJ8pqx63+efu5aFmd4B14VSJ+0AlyiqrYZHXek+E
         dXCst5HYgmsQ0vL9adPXRNKzOcSF6Ea1X5h85JxbiBzg5KA4DQ4jd+aDWb1xtLI6hABs
         n5TPW4rIC7l5DIB+aK8v9eVdY6dhqmUOlNlWW79WBO7GChq8DHoQO6x6XZQUZb8D5ysC
         uIkw==
X-Forwarded-Encrypted: i=1; AJvYcCVTBQagYZ7nNyV6LTQH+p81WSS7k+D9kNEAfeAWgAMUY+Km8q4mcMlmpXhVrVJr9urjf0BakDoA/qQ7Koc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1ipLAAGR4nmTOm5RlmtxSXZ5Vw3tk0LqtRKlFw7V8+uJbJhx
	uoDi0OB1EjZF9CKF1V/HqArBmrjrMbNMIdWB2pcrg5coQS25m3fFPwAKQxOtYSw=
X-Google-Smtp-Source: AGHT+IG/yzx2BrirfQLi4fTkAmm6tdWmADdgYhJai5mJ+OObY3rJiGs8gvXT6Hvgka4TOkojxVFw+g==
X-Received: by 2002:a05:600c:198b:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-432df723048mr17674985e9.5.1731662041725;
        Fri, 15 Nov 2024 01:14:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae04sm46823735e9.33.2024.11.15.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:14:01 -0800 (PST)
Date: Fri, 15 Nov 2024 12:13:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shyam Prasad N <sprasad@microsoft.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] cifs: unlock on error in smb3_reconfigure()
Message-ID: <e4ea558b-5124-4f3b-83a1-267097d067f4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Unlock before returning if smb3_sync_session_ctx_passwords() fails.

Fixes: 7e654ab7da03 ("cifs: during remount, make sure passwords are in sync")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/fs_context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index c614c5d8b15e..49123f458d0c 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1008,8 +1008,10 @@ static int smb3_reconfigure(struct fs_context *fc)
 	 * later stage
 	 */
 	rc = smb3_sync_session_ctx_passwords(cifs_sb, ses);
-	if (rc)
+	if (rc) {
+		mutex_unlock(&ses->session_mutex);
 		return rc;
+	}
 
 	/*
 	 * now that allocations for passwords are done, commit them
-- 
2.45.2


