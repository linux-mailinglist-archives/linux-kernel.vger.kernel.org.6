Return-Path: <linux-kernel+bounces-414980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3C9D3003
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D98283887
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E021D2B1C;
	Tue, 19 Nov 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj2bh3nI"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B91A9B2A;
	Tue, 19 Nov 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051497; cv=none; b=bZ955hnSuQ3smBoa2HoQz4lp75bPQAly9KwBXB4iQFamT+HMwF4pAG0DLr74lKU6IkZCRO4uY107idWaQirv0E5wE2zxQJAVWagYhLjzImrzDvxUkv6Ng8UDUV7Cn6f8cwnUPMTHK+wzgMhYNAlPsjTTU9gFoLWce9ZG5E/uV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051497; c=relaxed/simple;
	bh=dXGgkWe+4BMLaI3Lm2v0N49ZjSE/JrvGn7fMjcWirKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUgS6otbNi4lbqvK8dVo+NDtu1Ax+Cdb13SR5hmtrIwjkFFl6OkgzMprSe2iyRevyrIp3z33tUruddMPfL4HabTR65s3CzxeAEliD0Z6TArIqObS4yfqum77HDLtSMBJIHo596Hv9Ug+yp0QNtD0X3ZDbreWhoP1dkFes/de+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj2bh3nI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eb0bdf3cacso2426757b3.0;
        Tue, 19 Nov 2024 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732051495; x=1732656295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrBnHWzui5ajJG2pMcHOyK8xqGhF66gzfKEXVnIlLcU=;
        b=mj2bh3nIzSzqDmzAUmXynGhLyBAszahNrg/NBSkrW5RF++EwtFXwDvIMKICbpUHkXz
         fxO+QZExE2wL8zU4pvcwp/CcuIMlMgZpJrt6lkYTC/9M5/EaIkqocJq5GCy+CLE37E53
         F8MncnLualWFCRfhxEZXCzG2anOJEI/A/3az8YPf3WypMgBVeHeUTwyG4BivuJU10NiX
         N3Wol/p1o3EKYIupOK7/DNF/ylTDRtPjYwUwmaV0GxFuarGMKKT3gzZXQtNw775fBwYQ
         xmNEAQgDkgie+5KZ4qGOj/HIKHFogMguJ/q8mqfAt6w7/JtRpZ9lJCOe6G3mU9Vjl4zJ
         E3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732051495; x=1732656295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrBnHWzui5ajJG2pMcHOyK8xqGhF66gzfKEXVnIlLcU=;
        b=KCkJgYs7SDoK/CqnZkUoNuuEpPdyOILH+5zEH1GV+Ps9XE/cTEEE9Hv88LfiuuUjsc
         L9t4muQotNo/0iGmjKOlzI4VeTRoodbVUoKlXxRO7YLlpSWXe4kEfiSt5K3AmFrNSLSl
         500rExSeFmfrWgV5EY6Og31Q84wogW08tov3KZXLGFBhW9dYbapvC+Lhg7yOL4W43SmD
         yUr/62fTzaIV9sotYPDWGkEEITTAluyHNaV0tUvkCl1cPTpyXuPKdJn/BBh2rSZpBpDi
         ghyloasH6Z+DlZfkEbQxR16E6FG/kPniITi3KcXsWp6k4VdjijpAWzF0gimbrMx8fF8E
         kUGw==
X-Forwarded-Encrypted: i=1; AJvYcCU8qZnB9mnxC0FtWg7UhdcvSwAOO2CPoaDtwJ7zLbyPZq+H/NN4Nv+QbqxB3M72atruJyQ9ZXAk8dut@vger.kernel.org, AJvYcCUz43QeV5BxvyTLP36nyDGjsg1InkC96ZSWOsUaGlSVVNCfQvjWDKDMmWPNWP0PG1UoUdBvdDx2kLgpoOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmssgaRHAB6I2m45lQoY2duk4NOUHRV7SfofTQ8ZMeXlIzGnR
	HJGzqq4xdz+EEIY4AbbkVFUH0G0xBDmYvKHaBhyJ6sd2EP1S1o2G9++3/CQfXeo=
X-Google-Smtp-Source: AGHT+IGeJRlXNincJupegpSkUYSTkphGlAH1mccKLE44MBrYRH4PL/iHiTJSxCDFVAyvQoNf41gBng==
X-Received: by 2002:a05:690c:23c3:b0:6e2:1c94:41f8 with SMTP id 00721157ae682-6eebc318939mr5931167b3.10.1732051494968;
        Tue, 19 Nov 2024 13:24:54 -0800 (PST)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7137ede8sm19092257b3.122.2024.11.19.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 13:24:54 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	rbm@suse.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: remove unused sg struct member
Date: Tue, 19 Nov 2024 16:24:51 -0500
Message-ID: <20241119212452.269255-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sg member of the dwc3_request struct is no longer used and should be
removed. This patch drops the unused member, cleaning up the struct.

Previously, this patch addressed a documentation warning caused by the
missing description for the sg member. However, upon review,
it was determined that the member itself is deprecated and can be removed
entirely.

This change improves code clarity and avoids maintaining unnecessary members
in the structure.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Reported-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Ricardo Marliere <rbm@suse.com>
---
v2: remove unused sg struct member as per review[1]
v3: 
  - Add reported-by tag as per review [2]
  - Carry over reviewed-by tag from v2 [3]
  - Update commit subject to reflect maintainers
  - Update commit message to reflect actual change gathered from 
    Thinh Nguyen's feedback

[1] https://lore.kernel.org/all/20241119020807.cn7ugxnhbkqwrr2b@synopsys.com/
[2] https://lore.kernel.org/all/2024111922-pantyhose-panorama-6f16@gregkh/
[3] https://lore.kernel.org/all/5l65sdskdzbehxamff5ax4ptiqhaxh7ewi4umtpp6ynen45nj6@nebuxjg4c4rx/
---
 drivers/usb/dwc3/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ee73789326bc..3be069c4520e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -956,7 +956,6 @@ struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
-	struct scatterlist	*sg;
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
-- 
2.47.0


