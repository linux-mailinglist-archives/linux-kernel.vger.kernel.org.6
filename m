Return-Path: <linux-kernel+bounces-172845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA88BF766
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB821F230AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7876405;
	Wed,  8 May 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0XZMc2G"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA07442E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154192; cv=none; b=UPv/hcgCgYTiHiV7+vzuPF6Bu+vFZ8kvI9l9Oe+1DKh4ZOvxA8J1EY8aiRCtttw6jcB4jJYboV/71o8gbqDv9Ix4s95H7WlxcE5UoacnHeh2Gh+tRWJaAhzFbvSKNhU/bS2wYPnpgU+Lr6SZLE6wl+xIxryZTmFlh170gBASnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154192; c=relaxed/simple;
	bh=/K1XcnvsP30yWA0TcnD+ptMLyVHuWtcwczM/qqCTSuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nhTouRaQZcJcrPeWKnCQxaUDBTATyc5h71EBHmMaEVEj7r2fl9EepTuENDl6KXxM7OxVSjfUSZPkJMbxlqVK8z7q+QR9Ln/18GlHY/TBT9+pH64jHwNLrwg++VVqgY4YNBfNZPt4A8RI4nhzEphDLj6ciA4cFwgJKws51UmjUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0XZMc2G; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59c0a6415fso915396866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715154189; x=1715758989; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Xvw3cr1RyoF79KTdx9ez6z4+coEhpvNMvaOv4mOPeY=;
        b=s0XZMc2GVH22ks4YW/y9FPtu3ksMTX0NzWUqArMM+TJbCin0u+ZbA5v2jepTYcoDZb
         xJwoHnQv2xQpfmolZJYv7KG5bpqnk/flQhtkeK0uxWVOdSl+rMKE1X2LHxom6ZeOXeEs
         P+ta8V69/xFisEeyC5Zf8uyRF+fLJUph9H6e0Mwogo4ReNt1jue96wLPlSbPG9Wk2CAg
         pSiZt3aVjw6ZWmTihBw+Owr9Jhn/4bXtwIbOellRcBLA56SEf7R7U/9cgW8UH9gB3hA8
         gOQzxdoBCAuBcVIEwNgreJAB+grycZLaDZ13i/zqQujZNNmHd53wUl+EsG+0wRoteZcs
         Witw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154189; x=1715758989;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xvw3cr1RyoF79KTdx9ez6z4+coEhpvNMvaOv4mOPeY=;
        b=d3C4/UIgsmo0FRndYTkJCGVD3MkzzGnCi5iW2uwM4ii21U+xhY1VjxKx5dEhu400+i
         GKzQtwkL/qyljXYrbS/FS9dFN4NEzA25DUpwo414Q72MIZzhcxdW4ETcx0l9lqtrMfFe
         8CBeF1U/jsKTbxv/g7mDvHJRi0NK8bGyGGerpZAQCAIjbqYvZnmJSe3XuaXi/ljBsKQh
         HcDNshmzkiOJvHReRojqB/sV+K6RcnQRxqYX1cbPfNKfMgxsnKxIb9p1HNtKFAsnwJ+D
         C5h/y+7H3Cvu3lpepckcx2R+JzPyaZEDvMdTIWWjfl4HnWqBVP3OH1h6cf4V4/bFLh1s
         2gWw==
X-Forwarded-Encrypted: i=1; AJvYcCXr6nQW3Myna9/aBCCBRDiakMsnMVC9lTBB0wNqE9FziBpbVJNrfsCu28//Qzfl8lxmBrmYrmIZuLiji4QWzGqFNQBASOM7XLOCCNXL
X-Gm-Message-State: AOJu0YyrU2hNYoz6YKae7JKX6ozJAOYs6melcR8hr9Usk1xCzVYM/ex7
	9HfdkuwuE7jn39Z+bIpIPq67vIyAzrHlJ3slu5PrgUzq+c9fhTFYVuaW38cbQPw=
X-Google-Smtp-Source: AGHT+IGNGbq3AaoeyQZEUAek7mACIMKHY6D74+bWoezKoLVMrHCzDFCvjv/4+axxxyGGJUbfgQms/w==
X-Received: by 2002:a50:8e4f:0:b0:572:78df:c606 with SMTP id 4fb4d7f45d1cf-5731da6b1e5mr1274488a12.26.1715154188725;
        Wed, 08 May 2024 00:43:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7cc09000000b005725d859e4esm7328022edt.73.2024.05.08.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:08 -0700 (PDT)
Date: Wed, 8 May 2024 10:43:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvmet: prevent sprintf() overflow in
 nvmet_subsys_nsid_exists()
Message-ID: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The nsid value is a u32 that comes from nvmet_req_find_ns().  It's
endian data and we're on an error path and both of those raise red
flags.  So let's make this safer.

1) Make the buffer large enough for any u32.
2) Remove the unnecessary initialization.
3) Use snprintf() instead of sprintf() for even more safety.
4) The sprintf() function returns the number of bytes printed, not
   counting the NUL terminator. It is impossible for the return value to
   be <= 0 so delete that.

Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/target/configfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 89a001101a7f..37cd75ff150e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -757,10 +757,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct config_item *ns_item;
-	char name[4] = {};
+	char name[12];
 
-	if (sprintf(name, "%u", nsid) <= 0)
-		return false;
+	snprintf(name, sizeof(name), "%u", nsid);
 	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
 	ns_item = config_group_find_item(&subsys->namespaces_group, name);
 	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
-- 
2.43.0


