Return-Path: <linux-kernel+bounces-434544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EF9E6814
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C678D1656E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F471DE894;
	Fri,  6 Dec 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wme0hK4D"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883B1DB37A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470718; cv=none; b=UOmilTb/v1uBNzD8pyar+WcR/HCKPz3IkEsFsRiC+SgS1U22hAe27xx2ub5bi+ZxN/Sf7OKwnYaG5GJQTXRZhTt/1G3M9uq0NoPNwAoZp4MonKMP6bOA91h0O6p6ZhZ6kMZkEhsWY06a50AcUdE+cWUavA/WmBVOwmg0dmXN9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470718; c=relaxed/simple;
	bh=i42VA45iFtvtTu9uqrx33o++p+VgCDSxI4O/OQFn6cs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=PGyZCh1CEwNJZ8IFCQ/vAyOPfwIxgcbmNpBDBLLrohBTk44avH27GniEdIZE3XjoOz6P4z3KplEbx804Klfn6NimxQqujvX2lrVjpZBWdoueNjuX3Xad4TllA+LmDlY0ZM7PsSGFYdEgnAylJOdFnS5HJK8k1LCYcR0SVPXSMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wme0hK4D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef542990dbso20970437b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733470715; x=1734075515; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbEVs7detr4gWlE1fo2icdJ/ly1cL/4ZTUPJqPQuitM=;
        b=wme0hK4DM3ruu3kCTTsI25ViRMHOcDsX8YTnwVG6UhqxrscRSWHFvwSga7NiKY8L6w
         Qx9Fvg8WFLI2nbRxkRRVGHvBl8GXBcHnRbce4QmjpG+fov2wALMTjP9oPlfq+SdbSvMz
         lYwQ5bLXcKRWmHcic4Prv42uOzfOD4xPE7RE3uMhNOru1kE9GZQZe4fqISsjUmMFUfCY
         vL2RNYBjrPPn7Ayb5EG8Uk2Oo/+FV+o6G0tUrr3vsL9W0G17xjOC3GzqWlvK/H/6dUvv
         tTW4EXGDTZ2zXRZEZX3HCNP8c7aVe3VfH6vqxtCfApShsBTypvbr2EohDH4A0O4BL5wo
         y9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733470715; x=1734075515;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbEVs7detr4gWlE1fo2icdJ/ly1cL/4ZTUPJqPQuitM=;
        b=ZYNo6x6DfnvqwIfQg1bmZpGjczzHbCOLPcytud+w4RzYWva6RNEnwETePKhHnYnpqh
         zgv79+8KGh1tIWU9h7C51UC2OUMJ5plA5/JGBrU9CJERrcfHQEsfKO4i+n/s6RSUA7lN
         /eHhSx2sFywaZr1JtVxc/7EE+Niv+MdcUlJNIJSgUrgNPjCUv9HnR/CTBQmfMYRxwgn/
         ejr+hAp1jCEgMGHRi8U50b+mfWoLFk9gVLlSuCLp2aByN8VD9SDnjurZev3c178ywnP6
         9j10mvCXpWbRZfJC2Kxqam/pHLUtGz6bDyr6f//v1gJrhgKcI2sJDgW2hkch8xyEQ4S4
         1zog==
X-Forwarded-Encrypted: i=1; AJvYcCXFPZ8RiyVgXTZ/q+kYkfdEdzzoONorblZyh0pAHAhukizWOfhkqH85xUXJv7moVK09zdm1pLRNhaNZn/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpT/5/Zo8EhWRIaI9p2My6wc8Wx0Kruu7/6ro9NLyYvN6MeIKy
	mbdJ4/xPqUGH54PSirF+REGmQFgdco0r4GWY4b71Ek+cuTXYTks5vf1s/cPKPKgLasQvHpf1iCm
	uK3ircw==
X-Google-Smtp-Source: AGHT+IEnc5lvx3tnV6q+JZ+7oy3fAvJY1NjK6AF22JKF722V6Xkpco7cg4TiIjSPK1XA9uKJwGB0NGP7c9Nv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:bff4:a354:8911:79b3])
 (user=irogers job=sendgmr) by 2002:a05:690c:3143:b0:6ea:ecc3:ec61 with SMTP
 id 00721157ae682-6efe3bceae7mr17667b3.1.1733470714665; Thu, 05 Dec 2024
 23:38:34 -0800 (PST)
Date: Thu,  5 Dec 2024 23:38:26 -0800
In-Reply-To: <20241206073828.1119464-1-irogers@google.com>
Message-Id: <20241206073828.1119464-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206073828.1119464-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 2/4] proc_pid_fdinfo.5: Make pid clearer in the name and
 1st paragraph
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>, "G . Branden Robinson" <g.branden.robinson@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously the pid was highlighted through being a tagged paragraph
but not mentioned in the description. Add italics to the path
emphasizing pid and then change the first sentence to include pid in
the definition.

Suggested-by: G. Branden Robinson <g.branden.robinson@gmail.com>
---
v5. Switch .IR pid to .I pid
---
 man/man5/proc_pid_fdinfo.5 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 1c6c38423..2797ae216 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -6,10 +6,11 @@
 .\"
 .TH proc_pid_fdinfo 5 (date) "Linux man-pages (unreleased)"
 .SH NAME
-/proc/pid/fdinfo/ \- information about file descriptors
+.IR /proc/ pid /fdinfo " \- information about file descriptors"
 .SH DESCRIPTION
-This is a subdirectory containing one entry for each file which the
-process has open, named by its file descriptor.
+This subdirectory contains one entry for each file that process
+.I pid
+has open, named by its file descriptor.
 The files in this directory are readable only by the owner of the process.
 The contents of each file can be read to obtain information
 about the corresponding file descriptor.
-- 
2.47.0.338.g60cca15819-goog


