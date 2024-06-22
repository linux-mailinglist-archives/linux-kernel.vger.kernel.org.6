Return-Path: <linux-kernel+bounces-225752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECECC9134D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F1E1F238CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9AE16F906;
	Sat, 22 Jun 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TABpHXSo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857014B965
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069953; cv=none; b=T5ZFqHcHAEYCep87FtVqVdBkdeFSKB8p0DwZWY51So7rZNuCDcNkFybdzNkbWk2xe0SU9okpQK+ny1uDbgHrVY9460Nny1FH7uGh2SlqU7pMFN1GI4SsKE4AHqk+Z9qWe4J2h9RvPrh30flSUC8VdRedcMMhtGVOy6Q6Q3274eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069953; c=relaxed/simple;
	bh=Yu8GOdoq+eJNpH+CNxbmQ50ulv255DXgrq/+0Sxpm4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+BHFr+LUvkhtjtNo1IOGEyq7hpcvB5Ct3wmHGc4iJsTWFo6tASncX5o03S7WjARsNBQmbW4vsNnw8wUYC6GtPpvrBjIAPNjpSNRaJ0WI4sPRN/3YSe7U5JGygTSSDOo8jYz55YZ3wwm52CSy2+FSk8Wwc0htffNLnNNP3qywC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TABpHXSo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4218008c613so25347425e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719069950; x=1719674750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbSodxAaiDtcKinNeLOLfj3D7ZLToasRWjY0Ib8lWzA=;
        b=TABpHXSodCR8N/nrOFFlQ1epJrkBIom6kkndvCyXKlciv+kPose9ypDp4+jLsRjZkv
         BRkxdZw3NTWsvzMLL491RxJtEbWGCa+IcWywwZPOydKHhugC8VloThGyBA3IKVseWopD
         ELg7cV7Hco2EFjPfI0GqO7Pjtos7DWEPe5wniuO9XLYSgDG0F4ShSlanS+PdfyncHUtM
         MoGoriDDeAk9D1YhdwYBPCvVlf1bbq1uc0CLkF2ScmzEjc9U6+JIo3pL8gwNwZLbF1ka
         2RjRPeAm8SCFm7gxffyWB+AGreJgnC6bz5f3vJ8AOgn05DJ4AZ5c6AuyZWacMnLnyRVU
         rClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719069950; x=1719674750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbSodxAaiDtcKinNeLOLfj3D7ZLToasRWjY0Ib8lWzA=;
        b=l/KRMetowPrWEt2WEgWnUVqoNtKjOcRKa3BBaGM5l9abj3/wnNfcLhjz82PHYidyWK
         pxaPY2IiM1YOI5R/fNfouM6JE6hbVFfm0CbEmUp2Lv5FeXF/mbg0lHEU9Q90we8PxqKj
         6fkOsjs8fsHp4cQAgJ+gaIyLSJhrwZZixG24cBtf85F7/u3miqMQFhUnuyfg0RYMVpP+
         4SkLNwnSttvmMHLKhn+dTnQ/z+80mx7F09daZyAwCaMaUGA50KlsG8YlnOFwTFcySB18
         2rDtTdSUE6SEX3mdRBOk3SHO8DekkXGYDca8fHm38FgPODfTWU3HNWkDOfmdC/DFpQQC
         pfdg==
X-Gm-Message-State: AOJu0YyOQs6cglGEI9TxuP8D+k2NUj/lb6VIFGcRtVQbAjAGOHx+0+uj
	EhipIt0SoEcWHwxpZivS3gq/6lxLl4R+c+tYCHYwh3xBC4FcsUAi/5bHO0Sz
X-Google-Smtp-Source: AGHT+IH51O2rOHJnHQpU0hp8IG8Mkt+2PFJGTinb4XvfwotsyX2qmjfdZyYs3FFP2WhjjLvO8TaCJA==
X-Received: by 2002:a05:600c:4186:b0:421:7c6b:4003 with SMTP id 5b1f17b1804b1-4248cc66c43mr2303975e9.38.1719069949770;
        Sat, 22 Jun 2024 08:25:49 -0700 (PDT)
Received: from sacco.. ([217.201.157.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b27sm108053655e9.30.2024.06.22.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 08:25:49 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH 0/1 RFC] drivers: cacheinfo: introduce automatic cleanup
Date: Sat, 22 Jun 2024 17:25:25 +0200
Message-ID: <20240622152526.131974-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces the automatic cleanup feature using the __free attribute
in drivers/base/cacheinfo.c. With this enhancement, resources allocated
with __free are automatically released at the end of their scope, improving
code maintainability and reducing the risk of resource leaks.

This work follows a previous patch [1] that introduced the same feature in
drivers/base/arch_topology.c.

To introduce this feature, some modifications to the code structure were
necessary. The original pattern:
```
prev = np;
while(...) {
  [...]
  np = of_find_next_cache_node(np);
  of_node_put(prev);
  prev = np;
  [...]
}
```
has been updated to:
```
while(...) {
  [...]
  struct device_node __free(device_node) *prev = np;
  np =  of_find_next_cache_node(np)
  [...]
}
```
With this change, the previous node is automatically cleaned up at the end
of the scope, allowing the elimination of all of_node_put() calls and some
goto statements.

The updated code has been compiled and run on QEMU. Debugging confirmed
that of_node_put() is called appropriately. However, I was unable to hit
all code paths during testing.

Sending this patch as RFC because I wasn't able to debug and test the
code in the while loops on QEMU. I'm also getting some warning and
errors from checkpatch but I believe these are false positives (?).

Thanks,
Vincenzo

- [1] https://lore.kernel.org/lkml/20240607163350.392971-1-vincenzo.mezzela@gmail.com/

Vincenzo Mezzela (1):
  drivers: cacheinfo: use __free attribute instead of of_node_put()

 drivers/base/cacheinfo.c | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

-- 
2.43.0


