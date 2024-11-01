Return-Path: <linux-kernel+bounces-392790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545D9B9826
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2900D282BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463441CF2B0;
	Fri,  1 Nov 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7aiSz+V"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA71CEEB3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488324; cv=none; b=P400rHRWEHTa4p7IiBJt3DOCwMegcZTpWMKM+rFzCP/NzxKMDIoCIwgutuUUsXXw0v5f5KyV9LxoE92sL5OazIDAyCl/RDaOrtjOFPyqDIL6udzo+8RDQ5SR/R3WuHwW9pqflfQfBbxdlVgRyUadzpNbUnl3XMGBIqd0huRHhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488324; c=relaxed/simple;
	bh=crc9a2qeTrfoT4y/ld9Di4bnHUtZshTfKcSQNphD/Xo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BTtXbScH6fFpaDp/7UF6b84+uF+/Idzvvb2JJmyIP38XEA59zcXc0uueobqMi/O2sS6HLnCSJUxekGwZ9BY5T7E4bO5IFcEFP7QWUa4LFsnD9hf8xG39jXvxYWFRb/VE38GwsHzm3rjM3nNe0R4ZrTh0ZX16V4EfxaCiRdonSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7aiSz+V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so36308947b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730488322; x=1731093122; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTmM4lMLfU7fGWgK3OZ9YV6wKdDzMuf6g9cMhIBqTuY=;
        b=x7aiSz+VgZLKsFGHoJXUsSaadZ5Z+CEpJxJOyhIcFL1axodg2jmt5NyydFdhtlIesj
         ZbulGX0KQiru9QolWKyBDEBfytD7aqRqscH6/RYOqdaRtCpWU8Q4Mw7lSGBGJ5jRBUem
         vSbTT6QXil24Tk5JbOZtD+fPQu2JnpCCNPlBoLthHtzOe1MVdaigbSO9Yd6AOQmrto3B
         UgzSolqYEQi4woPCESFFAxAUzeOI+eAz8UFt2Ajnw8tn7H5PhyYt7DScdNsx/0D0bkV2
         r2knf0p0qQPDeXbBhJ2TfVf/E460sso+9SZINo7Houn38OpbddnHAr5fHKJc4nFrGexv
         1PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488322; x=1731093122;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTmM4lMLfU7fGWgK3OZ9YV6wKdDzMuf6g9cMhIBqTuY=;
        b=nONYbriW+olGFP4aXOf6pNuJyJNDbpH0xrxNbNRdaI7hciyoJIK1vq7OOCo2XAwBw0
         zox2T/3dRzdVkGHpWKxIbkNsLHnAE+2JFo7Mk9B7+tOVpUUK/A1jNlqhes/zGSflNPbZ
         b3Ju4ld3w4vpOPxmb4azv21CvchSqoPvHSPcEsYAMHGX9k3sNsqsuBwu+/cXRUwf7oOG
         4oOvdeqyI829Bo/weRaurk75Ze9XVweTVzKebtz/K0cSDIfIk0nCTFkXPdZOvGaHSgZl
         qvbMPSHDpJzeyzzqPJO/8wmkFyO+ALaQ+TDp5LZ2CAuYxGYwc7jE3mMHuVpPSI2U0okH
         5Ksg==
X-Forwarded-Encrypted: i=1; AJvYcCXX8BywEWRc4kG6kLT5s6vIyKlbGCN2VJMj91sbX8GGCuyqrghQXaHRLWkQbwihS846Dn+hT84a+ZTpanE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYro4wURo+Q8VXUIQZCtC3yf4MFCuLyxakP+jTl2cqCZF9j8hP
	J9I0QgHXVVaKRBpU34A2sFtBTFVciAXDIs96x7JJtceLc2LI5EIIza4rIJQKqQFgZyaSj8n9eDf
	v2YXhrw==
X-Google-Smtp-Source: AGHT+IEFgEJ9V+dh83TejHj9KUuGhQ2RdYn3JAxq+LxsKxbpt4nL0i5Wq1qyj0+MuSpB5JhnuJSnp05GuRfa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f2e6:5ab5:a95f:35cb])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c8c:b0:6e3:1702:b3e6 with SMTP
 id 00721157ae682-6ea64b8c450mr305747b3.4.1730488322219; Fri, 01 Nov 2024
 12:12:02 -0700 (PDT)
Date: Fri,  1 Nov 2024 12:11:54 -0700
In-Reply-To: <20241101191156.1272730-1-irogers@google.com>
Message-Id: <20241101191156.1272730-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101191156.1272730-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 2/4] proc_pid_fdinfo.5: Make pid clearer in the name and
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
 man/man5/proc_pid_fdinfo.5 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 87e6dbe56..935b54b4c 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -6,11 +6,12 @@
 .\"
 .TH proc_pid_fdinfo 5 (date) "Linux man-pages (unreleased)"
 .SH NAME
-/proc/pid/fdinfo/ \- information about file descriptors
+.IR /proc/ pid /fdinfo " \- information about file descriptors"
 .SH DESCRIPTION
 Since Linux 2.6.22,
-this is a subdirectory containing one entry for each file which the
-process has open, named by its file descriptor.
+this subdirectory contains one entry for each file that process
+.IR pid
+has open, named by its file descriptor.
 The files in this directory are readable only by the owner of the process.
 The contents of each file can be read to obtain information
 about the corresponding file descriptor.
-- 
2.47.0.199.ga7371fff76-goog


