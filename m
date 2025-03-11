Return-Path: <linux-kernel+bounces-556148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5407CA5C16D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44DA164251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E8925BAA0;
	Tue, 11 Mar 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EkycBGfH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B425A34F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696629; cv=none; b=S5MX1ZjG9R+Kbvg562Z5MeFJVvIekSTfNWucsP9UqLwobv0l9ojn6lzG1TkEUk7sPUW/CjGvFpZFdVPXygJLEQvPuY1OYN0znzsP7utZ/GzdOusyE9YvkNfRifrFwRd3ERPFpUmGKbneHCctaqdT9+G76YsvhPnfDRvL3P0hwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696629; c=relaxed/simple;
	bh=H9SzSxgPt+9gHiJ2NrDb4AnmWvevwAa4/H9YK0jc134=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEUqUp0jPR1rn5dbi4cXs+Jxjo2uKAYtMqCIQXfiKE+aFaOW/41m5hNusgYbKAMACuWffxZRuddJ/cEW0of1YD3JjSctBi6uD5OY12CIMcfSP1XvW0QOQwXFkUIjcYdvngYxOZttkm0VLGC9GsigJZKN4k3skB0NE+v+gBt82jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EkycBGfH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bdf0cbb6bso31565985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696626; x=1742301426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg2GfKNIBA0xBc9t5SMBYlXXu+7/ZD43VLJh0o8WZ/4=;
        b=EkycBGfH1Q7dgMH5Ky2wMxRih9ADLtEI3vRC9GxRro1BghsZVAwOS/pnrAdpoVAV6c
         0lgYXd52YOjfiWbJJuNYPvpK27h82lpyhBPzm0GSCU4OuWfrcDtByaVkmJ5SyUqB4yg8
         gWv9nuCbi6J4gAJ+P8CesyUaMcuvn9PWrMGCKvqSn1UCk6WUsxCw/BxPCaWCZ/6yUJHa
         5HzHoR4qzNfYjA3xGWAGrdcfuE0dZEv5Fi8NvsQbAAjWIyICsyvLlvYpMa2J8dn6+v7I
         ISrCeEqUb6+4/MstXQhtTEvhVKAz9dH7+pv45Msz9R7DKdmck7PdAeMc0nMyd/2omE62
         otHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696626; x=1742301426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg2GfKNIBA0xBc9t5SMBYlXXu+7/ZD43VLJh0o8WZ/4=;
        b=ZxhiOhsB3lrFSfUPzGp3Gs4xDEe91ddYNI8xM04/h1Kr+vp74siGQTmirZzeLjO5TQ
         PcGd8dhGrK8mPnqzhfEoEyceICm+bLk7jlSMNAikk1AobXC07IFOPeY71A0j/RD5sYK1
         je1uwB3hnkESWPk76VVBlsjSfEDUJ4JAsiB3dRtGNCvMHcjMGXdsYK/Z7T3quXKpNuzI
         lb/abZ3XqdEV6WpMyQ9N8jb173WG4w3/Ul/FtdLAesk7gglL8La8Xx2JUDAn6RJTelyE
         /o9XbyIQ5cxtA6gc50ycHG6O00gDZip6GxDnk8KQLQkrgbjOuwgppPSyKsXsj5+DOiEF
         ZsRg==
X-Forwarded-Encrypted: i=1; AJvYcCXlGaadQ617scGLkwn5Kcshs6ChfNhqiQRyD7blgMDjkj6fqJRosYi2HLK9NGuPFDUzoHdporiFjoYS/yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ2tivvEtNQyJ2swDjbPUIcVlBZb33Mpu0JUG3vEe8F95dSKnT
	gPng06vq1cIDDvd6qS8VTbF45IdlVgP2TEuuv/GDYP59x2xtW+wjL2ksQ9E1G7I=
X-Gm-Gg: ASbGncvkVZdhpsol0m2fui+oE8O2QCCNLqRAnnmAqUshnvD5CEocaZObavr/Q+PXxYH
	nA80A3FoB8SFvUp0XIS0X8EdJSdIsgrv0gpgxfhNfwHAqSfraFNKhWxrEJkbyPtnPDf8UkEGyHP
	TNztesa6u97t2vHYs1HdOQsktFLkyu1bZ0FFCv6u5R8UbLAbxGB4H+3CEvN00HeGwxmDxx328wO
	R1eE2VhZiTi0GZ5idw23t7EDXixDD/UzcIGEX1pdwGD59IY7DoSRrrzkz6BY+iG7i4b66v907E7
	da02wmQYDYg1F0/Fr7W+IUZGSfXAAwONDRaHVaGuzUW/QFc=
X-Google-Smtp-Source: AGHT+IFEs+y18tASfJQzBfnAofD11tP4m/kDNfpZXGz4WBh7pK/QCx+Nx6gHTTMr15yKyEisGcj1Ng==
X-Received: by 2002:a05:600c:474c:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-43d02092256mr45422675e9.30.1741696625747;
        Tue, 11 Mar 2025 05:37:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:05 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 10/11] cgroup: Update file naming comment
Date: Tue, 11 Mar 2025 13:36:27 +0100
Message-ID: <20250311123640.530377-11-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
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
index 17960a1e858db..485b651869d9b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -619,9 +619,8 @@ struct cgroup_root {
  */
 struct cftype {
 	/*
-	 * By convention, the name should begin with the name of the
-	 * subsystem, followed by a period.  Zero length string indicates
-	 * end of cftype array.
+	 * Name of the subsystem is prepended in cgroup_file_name().
+	 * Zero length string indicates end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
 	unsigned long private;
-- 
2.48.1


