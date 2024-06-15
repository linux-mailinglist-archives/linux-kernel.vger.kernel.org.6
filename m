Return-Path: <linux-kernel+bounces-215653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AB909585
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E51C213DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA0DF6B;
	Sat, 15 Jun 2024 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NNQ4OetP"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E5DDD2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417049; cv=none; b=pu8AixMv0m5ZeeqA0QUaVklljGX7myJL2UOOK4qxgwO5GeGbfDLJk+L3zhAQ/HpMrOMuOmHzowhTVbiEPjuCk19mppWvRZWFDHoEG5xJ1p1qPCJK80Zd/T0VwVaPjSsvLBz26x6dw3NAX2rCZ4h0ke7tvru2tgOGHg6rzqWvwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417049; c=relaxed/simple;
	bh=ZJXPz5gCNl9GBaTas9ASxCkMJYYMS3RsF4GomEl8KIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKKW/nfsPA4xOhdEdCHqTfewyjsdrbk34RJXL3qfT+lQK3zUuHIaPszJMBYFd/Jt3hP7oFL2OjJ6/TiauZXc62PqYsQQSgsTHYAmTkyaSF0EMBSyw4r1XS2/VGuXtUnEKbnd/RBNA4xQWxBcoqtexs0Ygpo0/nbKpATAhu1VwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NNQ4OetP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe785b234so26396111fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718417046; x=1719021846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfSbDHLdI7lOPenyweve9pVzyLtMzcxM7OcWqFRyfTI=;
        b=NNQ4OetP+nwwHux/QR0AFDlW0dkAy9LJi4woDXkvhJEFoWFyzKrtzMsCjopMKpvVjP
         Ep++NnFC9XBdan3K3fZEnfJn0h5cOCT1kXZBrCFMQfSuI+LiVjFfioPchqUzVCq/2eEr
         shyHaswvwYRyo0He38XBnSB9ErH3wxMgwefyquEPMZ0JvDkxvV84fch/Bo48UnbbAp0B
         J/FpxYTg7gsgavPRRO7X2XidE52sbgGnJG+Czc7ngmSoLd9M6CvOepJOT9kO+y3cm0qC
         jrY0E8iMaWk3bdI/V3X8azdhE3T9M3lThM1Lot0HTGe8/Muu0X5nr8PkwenvYtVN7X2g
         eK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417046; x=1719021846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfSbDHLdI7lOPenyweve9pVzyLtMzcxM7OcWqFRyfTI=;
        b=kycZWylih1j7yRvCiRjnWmxXy7YatNTE4u+kbrtQ5nz9wEKC6paJe3/234JKv5XsZ/
         OE4I4o2xAT7DgaCRr9J7+8KPkH8gOXiJakl46dEm6PzshgQam9p7kCqZdFXxBLtkNafF
         Z0y3n7sngdlKVFD2rFknNtHh1Y1jVByFxnreF4NUruh3YoXdTZ5cXsyMwQ1fEC9xkgwF
         xHdMx+H9kRQj0MheUjaYbYmhf2dv6ZBeje7PbDdkXOJ8zLMizPf9YnJZimhdugmEb0Co
         fFMWOmO+VicYDVEfDgc4RaTRkrf0BtKW4q91B1uexdZ0PHzyHwIigjhcGzkuXx41zYfU
         KMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN9DixP7Q6p6ZCBNLmtUG9Wlu6GXkJnSJLSMt5TdQzzVhyZQ+PeZo0nmjuwYvfjbPgsiSLCv43YrLx4gr8YiFmdGcL/wTqqIU4tc4v
X-Gm-Message-State: AOJu0YwyDPjy5RHlztYbd2CFU4N6/HsBgtrajkHcU1FqXqhA3QvKr+Cy
	sooIY/kb9fGgpc/koqCUvyOwGq/JsSpaySSq2As2cTTJh0NnUvtrE8xWwFSY+8g=
X-Google-Smtp-Source: AGHT+IFVZyTcIvbtfJNPKvIZp7JacqXXipNTuJKgpKnVmt5m4hY8RAbm4Kv1RRfvuizzzR8z8W4hkg==
X-Received: by 2002:a2e:818e:0:b0:2eb:dc60:6ca9 with SMTP id 38308e7fff4ca-2ec0e46deddmr28169721fa.21.1718417045953;
        Fri, 14 Jun 2024 19:04:05 -0700 (PDT)
Received: from localhost (2001-b011-fa04-32f9-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:32f9:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b9c9sm3722443b3a.160.2024.06.14.19.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 19:04:05 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v2 2/2] docs: stable-kernel-rules: remind reader about DCO
Date: Sat, 15 Jun 2024 10:03:51 +0800
Message-ID: <20240615020356.5595-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615020356.5595-1-shung-hsi.yu@suse.com>
References: <20240615020356.5595-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending patch authored by someone else to stable, it is quite easy for the
sender to forget adding the Developer's Certification of Origin (DCO, i.e.
Signed-off-by). An example of such can be seen in the link below. Mention DCO
explicitly so senders are less likely to forget to do so and cause another
round-trip.

Add a label in submitting-patches.rst so we can directly link to the DCO
section.

Link: https://lore.kernel.org/stable/2024051500-underage-unfixed-5d28@gregkh/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Change from v1:
- explicitly refer to the link as an example in the 1st paragraph (Paul)
- commit message typo fix s/explicilty/explicitly/ (Paul)
---
 Documentation/process/stable-kernel-rules.rst | 4 ++++
 Documentation/process/submitting-patches.rst  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index d22aa2280f6e..85a91fd40da9 100644
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
2.45.2


