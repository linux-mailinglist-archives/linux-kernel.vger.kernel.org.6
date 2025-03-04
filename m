Return-Path: <linux-kernel+bounces-544754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31898A4E570
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82E48A09E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6928FFF2;
	Tue,  4 Mar 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QgTw9Ucc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B1290BC1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102746; cv=none; b=GgEPnwb7W4tBBHagh7WnbEhHtZVp65wtC3rMIbCmUVZEEAAUIlZg5efX4ALJF7SIAjNKh0zEkHmxknNgibOzHagWfm2kM2si8TERFYSPlO41IDlcmyGGc/Tik7BVGgSh6pMegsoQ/BpqfaPmz4SgM95XdKYrmT7sl4dd1CdNv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102746; c=relaxed/simple;
	bh=uEBo2XwkWIu1kEQdFfc+UP0MGpzG764Wn7p6Ra7wCqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz3m3Ch1U7WuWyiyDU8msf/V89UuzzNRP3iL+4objCBpWLTcfvW9o+qrR614XU2FzIq9xOBgEAKyLal36miNVttF1DzefzO4Jq+pE8bVQLYnapIxKO3y8WOelbO1PDr5yGtBb5b15JUs9f5g1FEg7oY1yfJychnDu+q2XaRjceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QgTw9Ucc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so6784875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102742; x=1741707542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhMHstYP/DAcPBOLk4EEWApjXQhALePsm/Er/3v899M=;
        b=QgTw9UccyVFux+Vzt527ZlRdEEyF6sGd6zoXTXS0p45mPX9AzYejJpkn2vqR7TsLpx
         R52dwdvY571HVzEMMaFSL6H9goHxavWIFiL7FS8K4VxUFvHSP25zU1TmLdfEfitFzC/f
         GOhvhPpio+foB3nG1G2wj7z+mLTUKtvGH6AWSQqU/qr3INofgfHz4uzZFWBLs9iyqDjz
         74STZli9eGyHQlKwYEG5OBAf59pLUHkhdvJPlNhI2KW2uoj/q02A0L2PmPwC/F/FjAhw
         81qFOHe8SDmPP1exWfvOrNvZeNPqe+yRULlrBJn20zOSzMnvO9GUr5RRcGrpnLLR4cF1
         V4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102742; x=1741707542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhMHstYP/DAcPBOLk4EEWApjXQhALePsm/Er/3v899M=;
        b=aFvXETZsrLN0+zwd/O47X0sJZXJZTGSCh/qOX9LybgdYtdNvwQwdxbA0OJaY3MR6Xl
         xMS4T+OjbUAyiYX1cagJZanumcLPGm6nN7bgMhNv20Gu5Za89ZAW6r3RTM5Zqjr/Qfh4
         Ib6mcynIRU3ZhAyHOcXn4TcAGSm/ZXaS9I/NceOGBNYQYvhqWZwuJDBxF2QgvS9fIRq1
         ++w2npzai/v7MwdbfBA+v0wiyFaoingU7weRUsE9Yi+H9KLXvDFTK81iZxKnwLo/qQY2
         sEIL3yaOunirj5WZ6qZpBeEcej15c7ErhPBEtT4frq02N8SdNWt526bRH6DqC5+a6OxE
         1cvw==
X-Forwarded-Encrypted: i=1; AJvYcCWzS+9hV1Wraz4oq5yHbOL3jk1wwErkg/Q9rjw6+/H5O3VqgF+mKGh3Jss2rtc+lWsV+ioGbbGw/wdTHN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzliYMGXyKRkno3xHrQUxETTlTGnuz7GhOJmoHgGQZynJEqfzs9
	UIle0KjXXEH066EbsZWJcOv+n5ORGYUS/2uVqQ6GU7WEUQXJWNouQx58W0j2Szc=
X-Gm-Gg: ASbGncsyixW/OvNojyNWQNg3LYgHOKGvl8GIMRLxju1JkA0zpO4WIGOiqtqtHoWux84
	NbBiPRSCcIbUMPthfAOioSNfp7NMr7Wot7y4hHm6Wn0V0dKinvE+lTsG0fIN6xeWQ/thh0f5Vx2
	475bG0RuWWzWiLwMi2b2H1hRgOsH48yMAPYni7lbCxfRkSXO/VcPCyijFIuEBZ4qjOfnSD0lsa9
	96J2Q7cMhWA6I4nV9iywA4Zn+eH5eJa6lvZvGvbGQ9pYXbB9G8xy1H/eOX/EOABTp10836qdEDc
	zAXu7N7DFqZQ7aTHWnNZ6NwWgY/FiloERTK1pF88tWCwQ0Q=
X-Google-Smtp-Source: AGHT+IGgG3j37XPpBlw8fV8aejT9Y282Zg84Ylxu78/13gmSg1k/Grk33Ygxi04T6savqD/zyfoG5w==
X-Received: by 2002:a05:600c:478a:b0:43b:c7bb:84ee with SMTP id 5b1f17b1804b1-43bc7bb85bfmr53809865e9.2.1741102742506;
        Tue, 04 Mar 2025 07:39:02 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:02 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 8/9] cgroup: Update file naming comment
Date: Tue,  4 Mar 2025 16:38:00 +0100
Message-ID: <20250304153801.597907-9-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This changed long time ago in commit 8d7e6fb0a1db9 ("cgroup: update
cgroup name handling").

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17960a1e858db..561a9022ec100 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -619,9 +619,8 @@ struct cgroup_root {
  */
 struct cftype {
 	/*
-	 * By convention, the name should begin with the name of the
-	 * subsystem, followed by a period.  Zero length string indicates
-	 * end of cftype array.
+	 * name of the subsystem is prepended in cgroup_file_name().
+	 * Zero length string indicates end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
 	unsigned long private;
-- 
2.48.1


