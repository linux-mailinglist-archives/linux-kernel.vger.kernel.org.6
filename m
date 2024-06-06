Return-Path: <linux-kernel+bounces-203682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AB8FDF01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B3D1C21D27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653813AD1D;
	Thu,  6 Jun 2024 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JbJg1HQC"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43B13AA46
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656210; cv=none; b=G/0QOGRgLGFOk0X2z/bVZ5b6qnUu7orxB+AVLK8rrY+rnYoSGUuWNSUSm6LCUw5hnwllUV4QgzsvM4MZsddBGXs7lv4FfOc0LqYC3YIiAShY2WJSMJiB0j6NrrjBp4NCSWH2zqlVFdn8zF/MdnfV1wo3sy2APiiagtTysqiB3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656210; c=relaxed/simple;
	bh=lUTwQmTkXSAak3oROEANOq70038+HQrsZbNaSYQ2QYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4+gt9yhtlAOb1MJCW9u5RIKu4KbrIv2E/1lYK1s46P1Vo5NjoWVwnwAAvIKKCZ72Q2sxh6cc9eexRWs50etavpe/2FmwU63gMU/GD5KtC5Ph1b7X67GgZYoVpCBAScUkvVYHBOBzgzjiX5F1M+YhZde08XtMA8yEbyFnt9QKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JbJg1HQC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaccc097e2so6054781fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717656207; x=1718261007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omfvRqkaBys+keRVcCwWZsFLAUvdCTBnb4DeOzbHfX4=;
        b=JbJg1HQCh2aIquqEsg6HggZcyaY22fGmRrHencI4b9o9Ft6B6I/LpPumOX7WJWaShV
         90raB0HlZnb3aQIZWTtHLxrP16Yt3w4UgrHlEFdvvO4xbLRBI1q487B67h1xsnp0QeGX
         WX6Pd8szP/g3kaUjl9PcxbTNkVEI3HaFz6u/hcUDJ099VLAD75aSuhaxIemkmYxN+FyS
         PIiDKhjP6Mw0exWrhoBvOtv9bQWgONMJgqKxUnFEbDgh6uhAip4GqRmRB3nEG46JvfLM
         9eyvOeC9d6lZCp381zSQquyUkgzKJ4tnaowfzf8euWMTCAW6OhTgCHkNuF4iCCt5XX5c
         ZxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656207; x=1718261007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omfvRqkaBys+keRVcCwWZsFLAUvdCTBnb4DeOzbHfX4=;
        b=mx/Z9jcNMzPuKd96eyzbJDFNbPMNZaBC9i6uzm5mv14FoiO2nWN4EDwWHGIjC3WtWX
         970rDQr5+upao+kLJbGF+kD5BiirAMaXFA7us8Njo7BUwgF43vt3sDslqChRbSZfjd6j
         ZtjzRMcTvd7lJabV73nPlxo8q7I70jLm8MGn6qeG9i65wIU5V5PjfxUdt5eQXYJrFy7l
         ev3MZocL1tATE9udh3RX4tnN8/XwFmvXazzGmkG63pDWcAmKpqhjW/a0GSLNPchLon0K
         g1bNLGfmCPvaQ0TwBOdSvG+LgRVEccerUwYQO92fToqK1dwPI5926W3nnswFAoYqUXOY
         mugg==
X-Forwarded-Encrypted: i=1; AJvYcCVnuAW8DU/4a5cAPFx91cB9O6Xp1+FKuBEaj3CWtIDqsCcqcWkELYG19o7hUj1AoEw7lBTgCl42eTrw4xJ8l/HN0jDfa0+ZyAa6noB9
X-Gm-Message-State: AOJu0YxdPglgx/j/xRct1xB+5XALHNmu6rAWdT3XDXLSWpFzi7Y64FhF
	O0W8RVZYQNanLp6F/mVBR+E0FG58sQKfkwdqkyAdGFATlbVFQuXVu3v2GDfcL5A=
X-Google-Smtp-Source: AGHT+IEGA59Ld7fxgXUJDzsTcNIscMWvDgsppmsiO4nhCip7lnZ+ctEKacwPIC1ddr/EL9VC/D6TNw==
X-Received: by 2002:a2e:9888:0:b0:2ea:cd94:60f9 with SMTP id 38308e7fff4ca-2eacd9461edmr14568641fa.51.1717656207292;
        Wed, 05 Jun 2024 23:43:27 -0700 (PDT)
Received: from localhost ([2401:e180:8882:8af3:26fa:edbd:5679:640c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28957153sm499471a12.91.2024.06.05.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:43:26 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 2/2] docs: stable-kernel-rules: remind reader about DCO
Date: Thu,  6 Jun 2024 14:43:09 +0800
Message-ID: <20240606064311.18678-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606064311.18678-1-shung-hsi.yu@suse.com>
References: <20240606064311.18678-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending patch authored by someone else to stable, it is quite easy for
the sender to forget adding the Developer's Certification of Origin (DCO,
i.e. Signed-off-by). Mention DCO explicilty so senders are less likely to
forget to do so and cause another round-trip.

Add a label in submitting-patches.rst so we can directly link to the DCO
section.

Link: https://lore.kernel.org/stable/2024051500-underage-unfixed-5d28@gregkh/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 Documentation/process/stable-kernel-rules.rst | 4 ++++
 Documentation/process/submitting-patches.rst  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index daa542988095..a8fecc5f681c 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -168,6 +168,10 @@ If the submitted patch deviates from the original upstream patch (for example
 because it had to be adjusted for the older API), this must be very clearly
 documented and justified in the patch description.
 
+Be sure to also include a :ref:`Developer's Certificate of Origin
+<sign_your_work>` (i.e. ``Signed-off-by``) when sending patches that you did
+not author yourself.
+
 
 Following the submission
 ------------------------
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..98f1c8d8b429 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -394,6 +394,7 @@ e-mail discussions.
 
 ``git send-email`` will do this for you automatically.
 
+.. _sign_your_work:
 
 Sign your work - the Developer's Certificate of Origin
 ------------------------------------------------------
-- 
2.45.1


