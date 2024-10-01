Return-Path: <linux-kernel+bounces-345053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2D98B171
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFEF1F224B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162933C8;
	Tue,  1 Oct 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtwptL07"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922717FD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742394; cv=none; b=t38je4Q2Ph6KVJhGD3PyVT0jO2k6DnKiy3UljE31cI3lFBBQr5Oyo3v4D27QbHGxluPzDi8xMajHgOSyCQgRp7F96/ESDML/UIoXU1DWjoaN4hfY2JrAzH7ymnwWZepFsRqcvBqUepC00enEce8YQVs7NYCl+xSgmQMrDb5g6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742394; c=relaxed/simple;
	bh=kbMFnzagpQdusXtPFCQNh4LtOtnG1FrlUx+fANLHKoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMv3NYFJdhLQdIuaJIAAJDvQE5lti+mQu9QiAPhf3H+m0etxkO5ZP58MzZINnsdqNNoTsHZd5igPUduJ2Or8c+uhDP31cvnBPRPmgvbO6r4iYr86oh1b7Rv2npN7+7E3bPv9e+hH50x3C1EKaIIeSjOyChuTbzDjvNOwkC96n2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FtwptL07; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e084dc44bcso825253a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727742392; x=1728347192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Ah0ZMWQ8huX6PXrR+FitgdByGuh4bQ4S4OQRetSRI=;
        b=FtwptL075N3oWlxT29mowa4HN9e5VBHTMbN4Qe58L9+aGcOhtyX38miG7/Jp/4fu2D
         pp+wz8sej3/94fHiIB1swTDKO+5qfTMWZCMWXOYSCkuV/BKXsJ/Kagvykz+h0JelDHVW
         gQoYOhnK1ygvtspr0TZlCO+/4ytzj5bvx31RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727742392; x=1728347192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+Ah0ZMWQ8huX6PXrR+FitgdByGuh4bQ4S4OQRetSRI=;
        b=jJz3Sy3/Msz3rQKXgTAZY6BQwLQFmaTn+IFmg0zKRAKyiG7rwgAfNhA7ORbUQ5+Khf
         C/UFjfqhWOqyuhAN/1PpyocHfreRyPNeIjDDlupzKeebgIfbU738uU1A8nU2YTN+g2sL
         pbMWXPohY6nUkExwLvQ7q9OJ5DaFfjcZ/XK+PWDZG54qMDgjuH6ht4Y0Xu0YO3jrwjH7
         8DB5xMRuZaBuCybU32JQnAD/BSM94+dSwhM3MfMz3rR1BxMrw7QffCt+5e7YJToN7jUX
         X1VK6aQEr7aBsOWyXFr1Z1BQVxK/eqzgah+1d1lqLmKDNrse4iKPmaDpmpD8MZLDoo36
         tqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJP25Nj4Op/FX4q6vMc2mWvM0Mc8lyb19sHhW5SQy3Tecj3XXviC9oNDxuPHROpOiR6ycG6w4gF4tEwf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oT9Rzlh5eHY6dPXAVOGnvV7Newobj/a8scLGf1cSQ4xQSxr9
	hI7KVMXY2aktMnyPxePelbzl9RUsbz8cUv/xWBHkxgenCuAMSjykISfiJ0OYww==
X-Google-Smtp-Source: AGHT+IHaC8TRH+0CqFL8ePmOQQcQjHt2DWzOtlbUiQVAZBBhzUk+OWDYuAMRBsTobNPtDc/8lsuUIQ==
X-Received: by 2002:a17:90b:4b41:b0:2e0:72ab:98e5 with SMTP id 98e67ed59e1d1-2e0e63a5a38mr5503246a91.0.1727742391881;
        Mon, 30 Sep 2024 17:26:31 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e0b6ca4a4esm8734399a91.31.2024.09.30.17.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 17:26:31 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] update mseal.rst
Date: Tue,  1 Oct 2024 00:26:26 +0000
Message-ID: <20241001002628.2239032-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Pedro Falcato's optimization [1] for checking sealed VMAs, which replaces
the can_modify_mm() function with an in-loop check, necessitates an update
to the mseal.rst documentation to reflect this change.

Furthermore, the document has received offline comments regarding the code
sample and suggestions for sentence clarification to enhance reader
comprehension.

[1] https://lore.kernel.org/linux-mm/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

History:
V2: update according to Randy Dunlap's comments.

V1: initial version
https://lore.kernel.org/all/20240927185211.729207-1-jeffxu@chromium.org/

Jeff Xu (1):
  mseal: update mseal.rst

 Documentation/userspace-api/mseal.rst | 304 ++++++++++++--------------
 1 file changed, 144 insertions(+), 160 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


