Return-Path: <linux-kernel+bounces-349268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBAB98F373
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0571F22472
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA41A4F38;
	Thu,  3 Oct 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmLQSZM3"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51751A01BF;
	Thu,  3 Oct 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971321; cv=none; b=NVyYi0OKGR8NujSNROWdXdzodmoKZZuZBwB7bH+XvrhuGPwYSgj0kcTswj33+Rywp51KqkDi+/tc9rFwAw1N42OKbLvIMgfrR72Tcjw1S3S4nrGsJy+YYFN9I0lUg3NzgS6av4L9pkfgMxnoOnAq4k/BQOTq6SamaXi3izNBzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971321; c=relaxed/simple;
	bh=iLamM93nJJZKN6Rv4ZJvWL/hsC+5qjKK+emyYEgKCHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fl35qL6kjZCckDeO8Nc8XlYN/K+kXK/WqK2Qz7K9ehuRwHBtUO6FF8hKSY3EFPsNeGRZuhOXQorB+jvFhm0OuxiELdDEhBHSF4nPvXsGzykFyo8wZzjkIC0958PbzpP3f34/dGUJeUhzzBTWG4s6aUhMWwVJ+ZlfDaRVVGOFV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmLQSZM3; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71b0722f221so899333b3a.3;
        Thu, 03 Oct 2024 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971319; x=1728576119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3AkVb/lriXc82Js957ZFq4iEp8cLG72TPugo+XIyOuU=;
        b=nmLQSZM3ED20JrL0YZobjAQ0yb8IK44zm0Iolt1qvNlRyZClzE9S++S8fLsqN9r364
         qXjZVviL7y2wkJouyC05npeHtMHITTxXPP/Nr2EPDzYeRV8ZXzlWlyTM+ySdsPhDlR84
         RDCZeudIQ8qFplpMs0HJDDPqrStVg1ANPkyCU0mCvh5rnI5zo9f/SFN4qc1vcCKUq5+1
         XQHHtDKpbxaWaW+wQP54cWYIV5Z9HdwubWJI+gVVeRRf94RFzU+8BaDaRPiEhCh9sq2R
         f2PrUqPPZjja8tUGiw//vs/tY1aC8UocWQ5l1gy3eFNpbuR3uNTVKNVyehLTc6H+be0l
         umnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971319; x=1728576119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AkVb/lriXc82Js957ZFq4iEp8cLG72TPugo+XIyOuU=;
        b=Z0aTsICuzmOv3buu8v3+o2C7SIhmRQzkTuuEKYGZvma+hW+zfdtWYUuIbzg2tBZ9Pn
         Z18BykaFp4hmyt0btzU35n2foqslKoKdylgtDpnVsj7ToYyi7UqJ0E1x3L2hGo3R5B/1
         BsTPFUurwH55O+lESkg0Uab1a+aNgKUHMtKKSHRVVUKY6WZCIGWDrGyLpobzF/5qD20d
         CLgNCSfG66w+jYYdGRVxATsDvAPkrouIi1IDXqB1sXzBHk0xKwjPtz71+TqSfTuOste4
         TI1cWx6EXjFd9/xq66R4M7okhHX79NvGqOlbin8KoEyycYER4fktlxlwWbaM02G8+eVM
         ncNw==
X-Forwarded-Encrypted: i=1; AJvYcCULNYqkKUHnIfrj8wjWdShlePk+12S8YVugtBkRxGNip1NEyS07auk614laMvrcYQzb34H0k9VUK0NNOXM=@vger.kernel.org, AJvYcCWXdn/9mwRDbgtkyx6JB1b+ueRT+4/iggcaWbwOS638VjSLP4qwLOKlUFDDM0NbpHe3QSYbk12gwOZtYkos@vger.kernel.org, AJvYcCX42Qmt8/2Tn2iYu8fbsnMFMCfyb8e8r00wKSrTolTpUwf0cVs+YJ6bFKUPmz2/FYBsCM97a/2lKF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZWGzmuWNV89B7Om07PWlg7Qh+WIOvu6XV0zpUg+0I1tJYhzC
	hLZOhlou0z4gcFcFnwMdyandpGLpNfkj8czKhBxhPRPlmjiuqbhE
X-Google-Smtp-Source: AGHT+IERqwcSC5dhjNYsFZFAJM0bAAhDjj5Jq/25T5iLfxl7QwWy81JvSqQcyRk8hq4wcOFgWql/Uw==
X-Received: by 2002:a05:6a00:c88:b0:718:e062:bd7e with SMTP id d2e1a72fcca58-71dc5d8691emr10673168b3a.24.1727971318879;
        Thu, 03 Oct 2024 09:01:58 -0700 (PDT)
Received: from Archie.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb4d171sm873965a12.66.2024.10.03.09.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:01:58 -0700 (PDT)
From: KK Surendran <kksurendran95@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	KK Surendran <kksurendran95@gmail.com>
Subject: [PATCH v2] hwmon: fix typo in max31827 documentation
Date: Thu,  3 Oct 2024 21:31:49 +0530
Message-ID: <20241003160149.43991-1-kksurendran95@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in Documentation/hwmon/max31827.rst -
"respresents" to "represents"

Signed-off-by: KK Surendran <kksurendran95@gmail.com>
---
v1: 
  - Initial submission that corrected the typo from "respresents" to "represents".
  
v2:
  - Updated the subject line to include the affected subsystem (`hwmon`).

 Documentation/hwmon/max31827.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9c11a9518..4a7d12934 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -136,7 +136,7 @@ PEC Support
 
 When reading a register value, the PEC byte is computed and sent by the chip.
 
-PEC on word data transaction respresents a signifcant increase in bandwitdh
+PEC on word data transaction represents a signifcant increase in bandwitdh
 usage (+33% for both write and reads) in normal conditions.
 
 Since this operation implies there will be an extra delay to each
-- 
2.46.2


