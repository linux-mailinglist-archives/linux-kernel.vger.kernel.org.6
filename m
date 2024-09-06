Return-Path: <linux-kernel+bounces-318415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1E96ED82
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE811282B56
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D020158216;
	Fri,  6 Sep 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzs76j9R"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE11553BC;
	Fri,  6 Sep 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610586; cv=none; b=LrDexGgp9QXxhJWzz42CWY6fmQ+ZIYp+GRXiUupEVI1MYvi2A23tkNXNpUxy+N7C0SXSOjQYDTyGRd//fHG7kK6X5lKhM5jQaQCMX4YixsvCCa2tUmom4qjUCWI1nclh4X+fIDOE+9U4EAY5ER8Pwsug5SYeqAFT4il6J6opLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610586; c=relaxed/simple;
	bh=TuREpq7BTAb3IENow9dze2WvGtSTj7JqbOGPFQvBi/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CICK+ph9fUaJihUEVqsA6XsEubBN9uv7Iw32/fEGFzH8qCfA3HhTyjCbfBY9S/wlZlKr7cOGDTeIJrsEWfrkcjBVqjJBlAqFgKVji66OOkRyjA9eU1t5AoW2x0SHmLyiCOJaN4uz/pvdubvCA2LDH/8kyN2yJFzr2vhU5EJrKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzs76j9R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3787f30d892so966459f8f.0;
        Fri, 06 Sep 2024 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725610583; x=1726215383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyJxyBiz3f5QLJaKCcHAt8OoCSqkmVPwET3QnPgH6/U=;
        b=Rzs76j9RoooDlSMqKpW8LZ+Z1qKBO1jy4ib5Vf+UmlTvOzuaEYppbTc9pHSE2m2qrt
         pYmmX4hERQ9OuzH20/o5pgzePx4TRrtzxX4/pR4fHbilUqQCdmetXHSnEl9BZECI0J2O
         0f31pL33sRLJW0hN4PH7GaQha8nHB7M9tVaMRuYZILYK4JREoOJf4Z0dH1NSw4ChsrB6
         u109KJL+peofo+llEQoEeqqcCAx7VQTa7uZYxmP15hHmmSlgPGTEfQdoVP/gmEWgaN5t
         IcxNwmonYTkfS5DtGQ7sw9P+bxwsiBbS+IaEH4V1pUA99ySW5WTt5NDDj9iycYcCQ2A4
         j/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725610583; x=1726215383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyJxyBiz3f5QLJaKCcHAt8OoCSqkmVPwET3QnPgH6/U=;
        b=w5q3iDzKjocOkN8B4nVWFfNkLJA9wgZFuNkq4IFhQzvcSmyOOmPSJfgbFtA2rCbjEL
         tzeDJU8R3ODLjVqLU3RKgZC2FgnB7e34BpZSkTuiw8EXUsVvuA179rZyUBR9CYfXZJxY
         8igcpTtzDBDMscorEunDki17Lxmxo9SRQk5ubAhWzLcQwfpXo9TsZzrpif/sZbDbmL8M
         SMfiP39PYC9KgXfKFZbRWecdZqOA1UiLlyv6aMMbCziUQYAA/HZii8JOdSNvLbWhmjVb
         2ZPp2JMB40L2vruW+6TUr2FOZSTOj3AWopx4A2xaTYzOS3cdhLNrTEbqV8qPCk6cLGbs
         duEg==
X-Forwarded-Encrypted: i=1; AJvYcCUI4+Xx0tsjwVQDKuleEDR4lFroS35Est9T4V3q05xaniutup0dYJr10mKH4CBBS8KXQWaxX0nvjpJfOVdD@vger.kernel.org, AJvYcCVccfPVYSyJ6zbcYnQqJaYNPwQnIhk7GWR5Aq05r6H0YabHxfUGDXKlQTp6yLjVw3/RPuv2lYW+fKA2F1sN4+I=@vger.kernel.org, AJvYcCWVlNl6TbUgdBhaTOJBpBmVr7XtWfZFNBwAln42dpMqPIx8zwgmWg4Zbkwi8cHPZz2Cf9/GLkdC5NEe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8oLXGwXf9LGw+KmkAg+tZRl9dGcB5c0vgE+1DAhEOIFqN5hK
	nNOOFNuMJ4TZILWDWTGuXA5TpklIC8qS+cJeerzURXOfy1B6dEUlrbVFJ34n
X-Google-Smtp-Source: AGHT+IF6OgIRORTRWzlKDz5iZX4iJn8NPzFliVBue5P0ozE9PN+alTjgVr8zP8Ad7RbUuZF7hJ18Hw==
X-Received: by 2002:a5d:4109:0:b0:371:9395:9c2d with SMTP id ffacd0b85a97d-378896c797cmr996898f8f.55.1725610582336;
        Fri, 06 Sep 2024 01:16:22 -0700 (PDT)
Received: from void.void ([141.226.13.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d8617sm12193625e9.34.2024.09.06.01.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:16:22 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] docs/process: fix typos
Date: Fri,  6 Sep 2024 11:16:05 +0300
Message-ID: <20240906081615.5409-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/process/backporting.rst    | 6 +++---
 Documentation/process/coding-style.rst   | 2 +-
 Documentation/process/maintainer-tip.rst | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
index e1a6ea0a1e8a..a71480fcf3b4 100644
--- a/Documentation/process/backporting.rst
+++ b/Documentation/process/backporting.rst
@@ -73,7 +73,7 @@ Once you have the patch in git, you can go ahead and cherry-pick it into
 your source tree. Don't forget to cherry-pick with ``-x`` if you want a
 written record of where the patch came from!
 
-Note that if you are submiting a patch for stable, the format is
+Note that if you are submitting a patch for stable, the format is
 slightly different; the first line after the subject line needs tobe
 either::
 
@@ -147,7 +147,7 @@ divergence.
 It's important to always identify the commit or commits that caused the
 conflict, as otherwise you cannot be confident in the correctness of
 your resolution. As an added bonus, especially if the patch is in an
-area you're not that famliar with, the changelogs of these commits will
+area you're not that familiar with, the changelogs of these commits will
 often give you the context to understand the code and potential problems
 or pitfalls with your conflict resolution.
 
@@ -197,7 +197,7 @@ git blame
 Another way to find prerequisite commits (albeit only the most recent
 one for a given conflict) is to run ``git blame``. In this case, you
 need to run it against the parent commit of the patch you are
-cherry-picking and the file where the conflict appared, i.e.::
+cherry-picking and the file where the conflict appeared, i.e.::
 
     git blame <commit>^ -- <path>
 
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 8e30c8f7697d..19d2ed47ff79 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -986,7 +986,7 @@ that can go into these 5 milliseconds.
 
 A reasonable rule of thumb is to not put inline at functions that have more
 than 3 lines of code in them. An exception to this rule are the cases where
-a parameter is known to be a compiletime constant, and as a result of this
+a parameter is known to be a compile time constant, and as a result of this
 constantness you *know* the compiler will be able to optimize most of your
 function away at compile time. For a good example of this later case, see
 the kmalloc() inline function.
diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index ba312345d030..349a27a53343 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -154,7 +154,7 @@ Examples for illustration:
 
     We modify the hot cpu handling to cancel the delayed work on the dying
     cpu and run the worker immediately on a different cpu in same domain. We
-    donot flush the worker because the MBM overflow worker reschedules the
+    do not flush the worker because the MBM overflow worker reschedules the
     worker on same CPU and scans the domain->cpu_mask to get the domain
     pointer.
 
-- 
2.46.0


