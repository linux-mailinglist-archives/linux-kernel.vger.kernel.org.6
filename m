Return-Path: <linux-kernel+bounces-441715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02D9ED2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0868A281300
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BFC1D90AC;
	Wed, 11 Dec 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QJGbhKeR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7017BEC6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936459; cv=none; b=btpVl5Tthevda8xhCDYedkHTaVuV4wB/+jaspmi+eW7CeOyO2d8pMBAjGN3mQgx74bpDbxpwBZYph9Eze5VRMGxBgZHiCb4Z4lk8FXPrnvhsNJPLu7csxoIzjmtNnnDDhM/WJQeW9kCR2p5erhhR9RG9kPNRzWzCUvn+NlS1cfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936459; c=relaxed/simple;
	bh=B2sRIu+XnZuTeAjXW4x8wJh4gUlYpUujlvC+LJUIei0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwb5YfVbn7rBnZO5nraaIrmHEOE/JSQmPvpq4nrfZzRWIHDZUezBfBdnM74KTcy4tSWxMXG9++WoN3S7kJ0b/gr59nfUB1uXkoZlrNw1HjUGMYQMiq8ws54Xvw/syyX/pnxVFKPirRVjpcMr+ZzLCYMJg7nsV1DhaiPdYcV9TuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QJGbhKeR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e2880606so5705345f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733936456; x=1734541256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HyPQF1lbC/2X66nKlz9IG/RYEBhoNWgSBjs8SKK7a8=;
        b=QJGbhKeR81fk4bd0gnjTvlEbPTnAXhAzIYSES4HfcKyXHN1sjUU8Od2sDXRMdiN3sO
         w8/MAsFpR+wUTDQuD/SGbKmm8QRdERdDCrxjE2RKsIhMnoaEXP0kyyjjdVI5X8Nw2U/9
         uV63PUaqJ+oaSubbG9eiB4gD6CxEqIx5vP/HMbsOrwA+UlYBW4VSBFOF+XB5pZ/fp/Ok
         qJNx6NPDHD90Xn8DU+LjJf2nxzOT2aOB0gH/5y7F/eJUu/JeJQysd57IAywOYtj6mLD/
         cQBTcc3aly5uMDLsMxG34+xsU9bAN6PYFfGd5CvGzb7UzJBg2diV3je9Q9BrB20Y65vG
         5Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936456; x=1734541256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HyPQF1lbC/2X66nKlz9IG/RYEBhoNWgSBjs8SKK7a8=;
        b=cJB8iTsGihgj8y5zl3rXn3iaByD61hQRDhf2HeTAPxw0BxPiU+zuESDr6hFFG+Ciyw
         Dlhj14GScu6EowHkFthwlZkBWO+WKi/iMYdJaJ/vwW1nAKCSFT9sE3SFhKF1QSMLSZGn
         VOm6hTSNzTGu/slYzgGjhdGMsBK92Oguslv7OusCx/KDPz5qPXVsoZRsBNx9r+YC+Grg
         X+UEyeAvSiK2ZvfFDmal+LmKPdCvJ4XYXh/4+H6KM6ZoPNnnBy8iO9xD/soF5A8mmYSZ
         PmQvYGzwER8AgNGpeskFa0XwjcR59OxHkTnDdgurhef9UEXseUypo4bQqjZNJpIPB/ZO
         NQXg==
X-Forwarded-Encrypted: i=1; AJvYcCWyUmWhpWJxU2PN98B2PBDbgQy1d/4hFZWpeNmX13fbyiyKoKMBr6SrjZyo7Rga+wyJWBeESq8PprZuVWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHL5MK9sjeHxErhyzpAW/IW0PTo4720XY5A7KZXn0lY8/yQ/Y
	2FWYQPXqO4ByJCfks3odsUtFzCVW7TMpeP893AzaVu2CJ1HP24jUWol5HBGFurY=
X-Gm-Gg: ASbGncttm7KumdjBrVcGnqsS1Q4uOwPWWMen4rPlxFklaaYRs0m0/FCQmS4INYOB3Qt
	NF7Tj9IHclJ1Rw2ZMN0mL6bJk2JPFhIBTKYD/APoZu29Pb4LqLFGK8ztx48v2LfMjJmlbyOKxdD
	5gjlpGkr7fdCIV4fqjPRMUV/cuA+zFC+jlCTxifsHcxT++O9Dv8XRaLvcLIJPCb46lCELdWVKtq
	J/pbM1wqwMOg+gAyxKzjOSNjNmkdAjgOQY/L8Fa0CfwN1ssA+U5Zb0Z
X-Google-Smtp-Source: AGHT+IE+PH8kQNKr4K63S3Fg+sNQObK7n1xFImaHq5etBibCIiT8JmgSKVK+KNbJor5JCoeWXzVFGQ==
X-Received: by 2002:a5d:5983:0:b0:386:3903:86eb with SMTP id ffacd0b85a97d-3864ce97148mr3155156f8f.23.1733936455548;
        Wed, 11 Dec 2024 09:00:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824cab97sm1667458f8f.62.2024.12.11.09.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:00:55 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [PATCH] Documentation: sched/RT: Update paragraphs about RT bandwidth control
Date: Wed, 11 Dec 2024 18:00:52 +0100
Message-ID: <20241211170052.2449581-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This has slightly changed with the introduction of fair_server.
Update the most relevant parts.

Link: https://lore.kernel.org/r/Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/scheduler/sched-deadline.rst | 13 +++++++------
 Documentation/scheduler/sched-rt-group.rst |  8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 22838ed8e13aa..a727827b8dd52 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -591,12 +591,13 @@ Deadline Task Scheduling
 
  The system wide settings are configured under the /proc virtual file system.
 
- For now the -rt knobs are used for -deadline admission control and the
- -deadline runtime is accounted against the -rt runtime. We realize that this
- isn't entirely desirable; however, it is better to have a small interface for
- now, and be able to change it easily later. The ideal situation (see 5.) is to
- run -rt tasks from a -deadline server; in which case the -rt bandwidth is a
- direct subset of dl_bw.
+ For now the -rt knobs are used for -deadline admission control and with
+ CONFIG_RT_GROUP_SCHED the -deadline runtime is accounted against the (root)
+ -rt runtime. With !CONFIG_RT_GROUP_SCHED the knob only serves for the -dl
+ admission control. We realize that this isn't entirely desirable; however, it
+ is better to have a small interface for now, and be able to change it easily
+ later. The ideal situation (see 5.) is to run -rt tasks from a -deadline
+ server; in which case the -rt bandwidth is a direct subset of dl_bw.
 
  This means that, for a root_domain comprising M CPUs, -deadline tasks
  can be created while the sum of their bandwidths stays below:
diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index d685609ed3d7a..80b05a3009ea2 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -92,10 +92,10 @@ The system wide settings are configured under the /proc virtual file system:
 /proc/sys/kernel/sched_rt_runtime_us:
   A global limit on how much time real-time scheduling may use. This is always
   less or equal to the period_us, as it denotes the time allocated from the
-  period_us for the real-time tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
-  this will limit time reserved to real-time processes. With
-  CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
-  real-time groups.
+  period_us for the real-time tasks. Without CONFIG_RT_GROUP_SCHED enabled,
+  this only serves for admission control of deadline tasks. With
+  CONFIG_RT_GROUP_SCHED=y it also signifies the total bandwidth available to
+  all real-time groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
-- 
2.47.0


