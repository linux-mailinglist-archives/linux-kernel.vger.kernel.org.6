Return-Path: <linux-kernel+bounces-366438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D8599F555
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C130D284D44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBD3DAC08;
	Tue, 15 Oct 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kc+pie4g"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696023DAC12
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016874; cv=none; b=cWp84DFPF2Sz+PbKSeDG6SBY7iZIhegEdpQuV0K9dSgRdqr4rrsnviVwzHwMTVgw7MB7WQKfLtjQAhAyNe3//zyRfCsydPsu7KwWlTjmYNa8onYj9HWXxR0Dc9b7BON8TIkUAcPTA0g3yGUmXhUSR4xaQHgxcTuyF8qJeD67TNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016874; c=relaxed/simple;
	bh=H4MAbne90wrlHRCK9Y4D+uP2WHYXI/9s5xplsy2qMAs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=pjthTIA1eXCCVZ4RoLDLMjvodf1HpBDA99PRcVMSpcy/saoIJNyOVOLysdXiKCkV829lGhgELeVRjs6R6p1Ju8MiWnP0H7lrbEQ1r8p9ePSbp/y59FjF7GdYtTg5OvV9fr912L7TId0N8jm5deyTIeygFFL01z46WoUo5UM9s+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kc+pie4g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32f43c797so1360447b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016871; x=1729621671; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gM3YrE4Q9C+Si8Co65mOi5KDwsbx7zuVuDXpGhuB+1o=;
        b=kc+pie4g7SLZobJHsiEilTpCaH+/2/FYQwCacCRagZgozoFJS2yVvpihlJ3zUBuZiK
         JaxbpQe86Mb/s6GjlKAKo0VBBl2QPi3EMefNKxXSUoBcfo3GFYmo4ju5Q3+YGyjzEkdJ
         w/wzQV/xyCoVrFMGXSuPiebohfAzLbqUhcxo+lAkDGNfDiqnBc7EcHCvXpWiPiXxsFJw
         w37PQg3YEz3iYACZPGo9jgwv8IF7voGrDvD2CZzc3omOoqrCm7zk3MxHqJgMEB7TW36h
         DIoTakrmKQvzmoUU6v8pUFVVXSWsqLgqrI+S/JykQlgHNRGYak5kvzM2xQ/yHX9kM5lE
         slZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016871; x=1729621671;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gM3YrE4Q9C+Si8Co65mOi5KDwsbx7zuVuDXpGhuB+1o=;
        b=K0n9bgoYVlld1e7Kjkpu9oxcCaF16qFaB1QWhvl3NKRjW8ZUIG9U00hwOAudGsy1AI
         DOXxBCBZinAemvU5f2/bJWMZV1lTwfir/O+2cQxALfeej9/HN/inuqUDS3aeRVomgp7+
         SSmo8bFAHIxZrQfbUZjuOhjtQUHC0JRjMI9eMRr1aw2T9P5FSQ0vGIIaCYfo645WgZl6
         Z+qYeRHio6oyy8OtYfDhLOleLfpBLj37SSoiwVTDATZdEjCOb4IhM3j9SbG8dIIM6WF4
         iRoC0EKpNPcbKDa573s64DhGsnkAWRLHAX7b+X5/r3dku3YCULPZiVmIdKRyRcfWBbEJ
         J8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXm0Yc4CmVl0+YEjckpHnlcXof3EQM1s3U3fFsWPrzi8yEWtpoMyY6SkAHbF3iDkQb9NhVmSC2TlHrDEmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wvwTAhBqs7omvgy7NuigrnvGBkt3W2Ook2Ts0d8fiig61XP5
	Iv5QVk4pL2gPrE/vCkK46dFp0VE4CaRXRLja7NR8tqELBPw7jhRjN21yVoluiGvAWjTGKlf9RHd
	wJ++qcA==
X-Google-Smtp-Source: AGHT+IEAFY2fyFLu1qZ7jkAzDxh/B5nDgk+pHq87dsAFMXXqft5EY45jsumwuefjFJboTq8uj+pIP6i8tkZf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:690c:3587:b0:68e:8de6:617c with SMTP
 id 00721157ae682-6e3d3aacfc0mr155807b3.5.1729016871353; Tue, 15 Oct 2024
 11:27:51 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:27:45 -0700
Message-Id: <20241015182745.1012684-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1] drm: Fix separator for drm-pdev
From: Ian Rogers <irogers@google.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The PCI slot address for drm-pdev should be a colon not a period. On a
i915 GPU I see:
```
drm-pdev:       0000:00:02.0
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 Documentation/gpu/drm-usage-stats.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index a80f95ca1b2f..f56ca58312fc 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -56,7 +56,7 @@ Optional fully standardised keys
 Identification
 ^^^^^^^^^^^^^^
 
-- drm-pdev: <aaaa:bb.cc.d>
+- drm-pdev: <aaaa:bb:cc.d>
 
 For PCI devices this should contain the PCI slot address of the device in
 question.
-- 
2.47.0.rc1.288.g06298d1525-goog


