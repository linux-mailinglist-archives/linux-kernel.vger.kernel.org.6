Return-Path: <linux-kernel+bounces-206450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D39009E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDBC1F25F56
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152B19AA46;
	Fri,  7 Jun 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKJG1Mml"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD8199E9A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776320; cv=none; b=OIGbcKtwfLIHsZ6H1Cw951Zjp1eha7mW+8Ausq8/YJKHrIePZ8OhEu4Ns20/PkQx9Ju+Ncl//e4TEPlTZ7dJBhGTi85aewxZIbxtspaKcVEEAL+4JgN9T0Zz9fZjZF94MDhfVyLF4xz+m9fEIXC8cf1mv76MCWv9jOYBEvVDTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776320; c=relaxed/simple;
	bh=PkhT36oQfIFSxnsTi/xZYEC1/Wh+3xFYb2O/Bmxgk7U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YuyF8280oypuzPUtWE8DhPFA0scqyyq+iMtl/PtgPjBc2GKkxdSf0E9VgNa/VUYHJAph+J0MLRFccpFmlGC3TgVM76rfwDJUJOuovLNPdi/WqFdiLBiddGCMIDrkiR2iMolxnW/WVCOK4poKj8JwIq/QwskD2s186leG1ZU+HSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKJG1Mml; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a084a0573so38187647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717776317; x=1718381117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJQYxePR0iHdVpyH6KgKy957kewW8MXS1xiZJc94kzM=;
        b=HKJG1MmlycUEQDyL7jY33NzWkNKxhRRLuKxGZXmBpzj6QVrFwDJig+UgEbiI7RWz8L
         petq5ML37LaxiKkdhHlAX/RQxvhy59E2mzHysH6NpQpwycLZzqhZIl/C7jB4sV+cZr/P
         2VznYLlgfoMrcsDdziCW/ZFZWAboSJR/gca3F1SiFG2/NusZ12195zphjErARRWdFFZX
         /1s7f1elB/agXfYYBzCRLLomEBwjo2VOnJiFJojk6VQY4gXoE3cRVOjNDNCID4pIyJW/
         5d8vUPu5fCTxAUEdVzjqPPBnNR+fN2I20MucDYw0BJD8JUrr1yU2/3Ui8r13ltYn8oOV
         m7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776317; x=1718381117;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJQYxePR0iHdVpyH6KgKy957kewW8MXS1xiZJc94kzM=;
        b=UWxplar/esMWcW9TwC4fqmAfE2YbK35GCJhVelYp1Sp1pW8pBpV7cWE2XR/SOlfMpA
         bAoZIYVOdqlH2ezDx8nsj5TYicqMic/mrGC46XpFdKEfqbOUFWSl1MxcYgc55MOPdTM6
         G5gPOrKk/J9yqeW66h/oZGcDjD3IA3hvCOtJEQicu12iNwNDqypMngcJVZCfOksWQPEG
         dCDnADuA/4c6oj96mKJJu8KMnKCkxYs9oB6xNbvrutLZsmtruuHYBDbhkpO2vLLBJV5e
         SPbIW2/GhjkJEv1rF6a5tjdA9VSm2LuNuZKVK9zBh8DLLqGI7nepah5w4BlBW0/esFij
         VKJg==
X-Gm-Message-State: AOJu0Ywp4QeNezAWP/l2J7nreGL20PAXMtMOK+rU6hU4wNqFAWvNC4T1
	Nt2sUm9rG2cMlburzDWSF5Y36/9eNSg1N6yAk7Txob7wNzP/vC3F2vy5H+rGHq1adCx+smsXFy5
	jxAUYvXiR9g==
X-Google-Smtp-Source: AGHT+IG64lqY0yQa0AokSTX2EMstB+TXXJ/qbAvxRcK+iiBrZnFLE+9N9olvbSBYlkiqAXRbb2EBxdF56b8qVw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:6410:b0:62c:c56c:94c3 with SMTP
 id 00721157ae682-62cd546f5e8mr7536837b3.0.1717776317494; Fri, 07 Jun 2024
 09:05:17 -0700 (PDT)
Date: Fri,  7 Jun 2024 16:05:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607160510.3968596-1-joychakr@google.com>
Subject: [PATCH v3] nvmem: rmem: Fix return value of rmem_read()
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

reg_read() callback registered with nvmem core expects 0 on success and
a negative value on error but rmem_read() returns the number of bytes
read which is treated as an error at the nvmem core.

This does not break when rmem is accessed using sysfs via
bin_attr_nvmem_read()/write() but causes an error when accessed from
places like nvmem_access_with_keepouts(), etc.

Change to return 0 on success and error in case
memory_read_from_buffer() returns an error or -EIO if bytes read do not
match what was requested.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/nvmem/rmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 752d0bf4445e..7f907c5a445e 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -46,7 +46,10 @@ static int rmem_read(void *context, unsigned int offset,
 
 	memunmap(addr);
 
-	return count;
+	if (count < 0)
+		return count;
+
+	return count == bytes ? 0 : -EIO;
 }
 
 static int rmem_probe(struct platform_device *pdev)
-- 
2.45.2.505.gda0bf45e8d-goog


