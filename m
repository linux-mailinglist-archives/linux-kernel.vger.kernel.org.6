Return-Path: <linux-kernel+bounces-434545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE279E6819
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8C2281DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A151DF252;
	Fri,  6 Dec 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4iHi9mY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32C1DE2B1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470719; cv=none; b=bSzTfNMgrx5qrlow6N5ux8hsYz+TsP4oYdLU7iWxlcXfNJRPiPrNa/dIO7l+TyDyAOBRIOMvJnfThuHd1NKknGw5jFv4fskW+q6zLFIk29bRlzstFEWWLSKKMYs4u1qXvAFe/jz0+UCfTsbTtrHJTYd+uElW43GWU2VQst1MkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470719; c=relaxed/simple;
	bh=QNykjUmeytuOx0G75pMP0LzTrKz7WPi3BleJRHunwwY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=oecbR7RN5820x5FPgsIreXnzUVJk3thm8WoSO3Ao4ALjTASt6lFWqzzYMyXhcdnkW78NCAlcvzVCEqaBfDimjmb5x6+sbXpnp3bPdimhWw78nmevT+qYRylv5AMyr1qOVp2EUF+hCJdv4+tLViD0BVTLo2DhAuck6n7MVkoxJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4iHi9mY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3977f08b5aso3265040276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 23:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733470717; x=1734075517; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=08qPRW9xswRt2OtHroBUTIZrJ7mnuAOFiexcUCiCKeI=;
        b=Y4iHi9mYHp97kn//AhVrEp16ayfPyDvAmDajwdMA138Mn4XEMTICutnIcahfVL7YOH
         1wTRxK5MD9WdkKakK30Y2f5mzAqjiFCxx4Q4RGy93+daCTF7sztjxUp5d9eVKdW/cFcz
         7htzgxuAVDAtf0ihAtXGvdtL/8Uo9nSdzK9vj8FiSdNWj6dyRU5tq/L5w1IXbeDyg//2
         xLq9u8TT9CzClU3QOgok5G9papwInKnZfJQQvxJi3IShlIWYE4h1awjoCW/Qpi7i9JNw
         oordasCaQ+pVFhUB7AvLKrtyZDyFiwkHXNRisu5Z7Ok0GilQ05MT/pfC+9J9w5kH6NWg
         GIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733470717; x=1734075517;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08qPRW9xswRt2OtHroBUTIZrJ7mnuAOFiexcUCiCKeI=;
        b=j+AuxPqNrH9HHuqVvrtCRPdmdjaf6rrNUnNiQt3WMDXfUa5zwJwQHGFaN6ubZ+fNXn
         SBMDTg7lri9zpfAGdLhgwCfFnxD/CElnZ4adg4rEHYGU74rhFXdlL1JSR8f6QTE1oeAf
         OIAZOS2PBc7YgTSppZW1cvXwR4agNnPqi7UELK5m1MVco+a2NuDS8/aLBfI5PXnJu0V+
         4R0SoIYrc11oI0iKQ0bWO/nCDUo317CVAJuHwOLsNumepODm99lulBi5zyIqRRopEjK6
         1MT+q06XhkYF0UgMxk5GKfUDdtV5691rgtHBSDmiscGbZHwLiS97kx9GrsTX0MJFmDZk
         5wcw==
X-Forwarded-Encrypted: i=1; AJvYcCXXCat0FbUO6MxDnE8tLd+hDXbE3M+BeT1kRUN6w3nq9srocFQL3cwJUefaEY8oU3Bv7DTftlho/oJU7yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJQl1hMkhm1sF1BBD3JuuX4/TClAvnlieEIWTDncARk2vtOu1
	9ol22cTOVO5PmgdzolFT7RQLQYbXfJhcbGln7W0deZZtHQG21UBR7zc8npbYKouFWHUMhmPyrGn
	LOh7t4A==
X-Google-Smtp-Source: AGHT+IEDRTiD4aFoP45cgyoosz12ZeHtxiOVt8IhT1Y6gGd2sajlkNmKprLDP9GTdgZBV9Sm7Qm7+AXk6YX4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:bff4:a354:8911:79b3])
 (user=irogers job=sendgmr) by 2002:a25:fc1c:0:b0:e33:111b:c6a4 with SMTP id
 3f1490d57ef6-e3a0b073bbdmr902276.1.1733470716612; Thu, 05 Dec 2024 23:38:36
 -0800 (PST)
Date: Thu,  5 Dec 2024 23:38:27 -0800
In-Reply-To: <20241206073828.1119464-1-irogers@google.com>
Message-Id: <20241206073828.1119464-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206073828.1119464-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 3/4] proc_pid_fdinfo.5: Add subsection headers for
 different fd types
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>, "G . Branden Robinson" <g.branden.robinson@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Make the sections about eventfd, epoll, signalfd, inotify, fanotify,
timerfd better separated with a clearer subsection header.
---
 man/man5/proc_pid_fdinfo.5 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 2797ae216..c4914f1f3 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -57,6 +57,7 @@ is the ID of the mount containing this file.
 See the description of
 .IR /proc/ pid /mountinfo .
 .RE
+.SS eventfd
 .P
 For eventfd file descriptors (see
 .BR eventfd (2)),
@@ -75,6 +76,7 @@ eventfd\-count:               40
 .P
 .I eventfd\-count
 is the current value of the eventfd counter, in hexadecimal.
+.SS epoll
 .P
 For epoll file descriptors (see
 .BR epoll (7)),
@@ -108,6 +110,7 @@ descriptor.
 The
 .I data
 field is the data value associated with this file descriptor.
+.SS signalfd
 .P
 For signalfd file descriptors (see
 .BR signalfd (2)),
@@ -133,6 +136,7 @@ and
 .BR SIGQUIT ;
 see
 .BR signal (7).)
+.SS inotify
 .P
 For inotify file descriptors (see
 .BR inotify (7)),
@@ -173,6 +177,7 @@ file is exposed as a file handle, via three hexadecimal fields:
 .IR fhandle\-type ,
 and
 .IR f_handle .
+.SS fanotify
 .P
 For fanotify file descriptors (see
 .BR fanotify (7)),
@@ -229,6 +234,7 @@ The mask of events that are ignored for this mark
 .P
 For details on these fields, see
 .BR fanotify_mark (2).
+.SS timerfd
 .P
 For timerfd file descriptors (see
 .BR timerfd (2)),
-- 
2.47.0.338.g60cca15819-goog


