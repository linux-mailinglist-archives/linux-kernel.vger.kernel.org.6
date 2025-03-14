Return-Path: <linux-kernel+bounces-561428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1707DA6119F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A331B6217D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7811FF603;
	Fri, 14 Mar 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVQXj2E0"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102031FF1BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955985; cv=none; b=lccSQssqYABvuPu5X3TdOECAwvFpYYtzgVyHueSEXs+f+pYn7/SLVuK/o408rHAmoF+QqS/0Ot7fB5bW5DMFSziC/tPsR7Ua+Q+8CB1vUVNbOOamu80sYSrndnCZ+rLofwHXWsEy8Fkot/rFuwbpTAp55wWhSL4XCeiS7UGt3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955985; c=relaxed/simple;
	bh=/pW0R9D7uHZMJK4vBJP4tRWLf2TE8r624WgltpYA3/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jAmaGUIPmVNRAJg2XonhXztkCptbo8fe+ig6OLDWrI46a9sVdZVdvFa0WZgiuiw2XCK//j8r2+a6OFBiB7ItYX+/ovAZWxjfGTxGQdaNipC2hCbXcuDKtTSja0eWHeujhEP+54oJfQa6Hl/50sAoMyyjrwdxjhk6NlkrhPJ7R1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dVQXj2E0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f7019422so18984316d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741955983; x=1742560783; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MaXgm+yzeWHhK7udzVdjry9arnq39Mnq6+YB4TtmdM4=;
        b=dVQXj2E0n0ucQOeUOYq8YkDp8sfX5nqXhh95OTkcF4PVEGR4/yemMgzJapk3ud4go5
         HGq6vdNpWo5SENMAm7sUNllFCZxvygDDnHO8qg+PH6VNQDNfNrglNd/+FzdaT3RUzDlM
         u6GcIzN5T0bb8yRvQ2xBS02uqMmGOGiNmMRJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955983; x=1742560783;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaXgm+yzeWHhK7udzVdjry9arnq39Mnq6+YB4TtmdM4=;
        b=dHYx9u5oEvx5+SDPc6L0iX6ihFE1v8py6btZnYD+Wz0dNv9qhYv8tCyilDzv0Kt1iM
         m3itQFRHZdtlUhpKmRdbeDUw5fEK0enE7AWODOnbAdAJ19S07h5nhM/yQhcyiq81KZJz
         Ux6aJxZmMXW4FUk+3uKCQfD3WF8dBgZvmi/l5NVC2iKrL4xw/v+70DSLkMfgWtxc8S7a
         hYPVgiRFUuKr1dQdZCGrW7Y225P7fqKuz+J0QebSHHUtQj84YbL3rNJh1i5gUtQgIzAZ
         2XIole0a6keMqhpksRiA5xhVulWPy1IBsoydvEA2J9KngO8pfLfxLTPbzS0tYeZ5fL7g
         Rd6g==
X-Forwarded-Encrypted: i=1; AJvYcCWPZWwnMoICXha0F2qeMF9l354YPtXC3/5FdbdvrG6Es/jL6qPiwR2YPJ5olOME8oEhUoh3P6EGU303kaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogNzyx9ZmXnAyou2HHGvqDivJ1H+ABMZnjvcmlG87DL6roFEi
	ND/CzH7ZXP1hL0XSE1KjE8T6Ws83zoBYXAm4bkfVREx6Sq5PgG2GplqRXPwm1o/3sa30bY94qmw
	yUA==
X-Gm-Gg: ASbGncvIHWuK9UXIBuqYbW5uom/CbrbU9Q6gNBa+mahhDeUHyL64lPRdnvk4G7s+Im6
	4ufSvAyOa9PQngjugevEuutXBTIB1/Dfp8DSwTAdkUVwZIy1dVeERVRRc4FY4N9PbgA2emQz5Bo
	/fAssPEgKxf7vgyH84x5nYf31qV5L3BI4uP63UBl2T8lk0HyDqjbhkgK7f6LK3LsCeqZ1CQWdzN
	eqr8aXenVnzf+nDhA0wghYk/7oRtuRwMsZY1vEqlzBnD2+vmlNIfosi9hxAnZg/NWiaebbCy8pq
	Me6sT8Edf7c4mQxo6zRMAjjf4Z6MgmuKdjy2SBqr5kOk0LHNRAVhZyky/Lzxe4dMljAQNsw2if9
	n+fKPT1SPKsVNCsVdMothmw==
X-Google-Smtp-Source: AGHT+IFM5j0VZpj6YX0U9qAjNIvQTnIzXPOHOx3wYEsvxQbTFHkI9LRKWp8ElODaAGpHTftIynH4cw==
X-Received: by 2002:a05:6214:1c4e:b0:6e8:9535:b00 with SMTP id 6a1803df08f44-6eaeaa0800emr25952736d6.12.1741955983076;
        Fri, 14 Mar 2025 05:39:43 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24b8c2sm23031586d6.50.2025.03.14.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:39:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: vivid: Add more resolutions to the webcam
 emulator
Date: Fri, 14 Mar 2025 12:39:39 +0000
Message-Id: <20250314-vivid-fix-twice-v2-0-dcfca4053704@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsj1GcC/3WNwQ6CMBBEf4Xs2TXtUhA9+R+GA5QV9gA1LVYN6
 b9buXt8M5k3GwT2wgEuxQaeowRxSwY6FGCnbhkZZcgMpKhSpTYYJcqAd3nj+hLLeOaqIa0NkWk
 grx6ec7kbb23mScLq/Gc/iPqX/ndFjQpPpi4t9arv6vJqJ+9mec5H50doU0pf/jv5c7EAAAA=
X-Change-ID: 20250314-vivid-fix-twice-9e5821142248
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Add 3 more resolutions, that are present in most of the webcams. Now
that we are at it, fix a comment.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Fix Hidenori's email
- Link to v1: https://lore.kernel.org/r/20250314-vivid-fix-twice-v1-0-7463c2b0ba63@chromium.org

---
Ricardo Ribalda (2):
      media: vivid: Fix requirement about webcam_intervals
      media: vivid: Add more webcam resolutions

 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250314-vivid-fix-twice-9e5821142248

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


