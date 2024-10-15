Return-Path: <linux-kernel+bounces-366473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A15599F5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2475A1F24AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F82036F8;
	Tue, 15 Oct 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhPiLmzt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F118991A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017533; cv=none; b=L6KUVzoqiy6O4p0qnnT9woDT8Iagjp7tBZQDYVIN3DDxjv0LQm+6nWsm1g4Ncgd6YOsmGfeXIN2fVplAlPgdbfU9Vr3hyyuh1IkSv8DTPmLgxG4y7eercjYyNzZxQCMDTM7MdUg3Pkrx5T6S/biNf6fV2SjEkQvWZ4jz681RpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017533; c=relaxed/simple;
	bh=DxO1yn608tkTo/xlx2OpIg93kc4bshLzdHOMRwt2p2Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=N3agikARkKWBxyVe8fucqfykUH49ciyXuL+TgXh5LtljD/6rGYW75jUS8uQI4FwUSP2JAkYd/gOPUyrYwMaadH01kY3DuVChLcg5UmAwxc1KL11LXySwBorKCb0BDkuIW3NixG9ZW5vCehxr8HgR4jeja9lu9u+OgOEctWtC9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhPiLmzt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so9200597276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729017530; x=1729622330; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMeke42q77vKZdk9CqMaOeiApW1FFSuUHd/dD3slT+g=;
        b=PhPiLmztKFgGs1iaC/wNDbOmH23jLhQHMdNBQdN/ZtEZRHN6pOn5MpKTgfIiuxtTwG
         2aQ+sof/Tcz4bzwqD4mtPeE7Nlh16ACaYjE/K8xbtm7wPKkriuegXUuy/rXDBFfk+yqc
         ywx6ZU+aIzBg9kHli56aRmTReXuezZGfUeN024TQ8LCXKP0NKwV7E/0bqGGyeqfMG1iL
         bRAOYW3iCO3meaLJNtXRysKaGF31N9CfTeebu32XMQWqmgSAPMqV3UBWuJqF8isbx9lq
         w5mu3mYWr/cGfEZN/Re8px9YqTBlRSg8elUSV67Lft+4gHLg45Jb0QWqTCXOwMnfQTbf
         s6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017530; x=1729622330;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMeke42q77vKZdk9CqMaOeiApW1FFSuUHd/dD3slT+g=;
        b=NTM7hxDp/wPs5GEdUleQOVaGOIrLV0mqIBD79+suMYhb3/Q93wX3tP27aMCsjRWfJx
         EE+nS/sxkFRmBhhgyBLbWt2hWOwRSurvOhELjItcgIfU6rJUUOnulA3Ahn1LTKH1b8Cr
         ppgNoj5xUjAVYCnZ5gIQpF8/yaWquv/s45PRUFtfcXhnr7boZDjkGEtX/3r7GbJO5Qba
         k9V0YMr3BZ4Fb9FFFP8L6TuYZLnyHrWyX6jmvo+ZAdUsA2OmBPfw1iMQe4XqIwamy8vP
         pKZ8n6o181uLdlMHwr6AeApSFZrkFc2pQ3e7YrdFxvYE09nNOCr316jOhj6V/gRFCeAf
         X6dw==
X-Forwarded-Encrypted: i=1; AJvYcCW3CgPQyOe/Ar8y1H0gV17oDms8GVuBAygX9jvzRwGJ6HC3OFMrWh8DLuBOcnIchaLOWB38PeskeDNBQ0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FyIQyHwaizXpjdRKTfBxmuZ/TbH7xDjaWUbScQ3U7HvdF7xe
	4MsEZFfdQg1E5kB9bM4+pqt4coLG8ly7pLlTAqqLm8h+f8shzU4KVvyL8Nl+vLl4+LGYi/SVMr+
	Jzk6TyA==
X-Google-Smtp-Source: AGHT+IGETkEI/5EAubwwlNl50B+eFDsqD15jqw1peUq+N2xQNvJcU/MhNMYfdP+IJSFOGW9SBOZ45gGLwb1l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a25:aa09:0:b0:e29:74e3:616c with SMTP id
 3f1490d57ef6-e29782e9e9cmr600276.3.1729017529497; Tue, 15 Oct 2024 11:38:49
 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:38:24 -0700
In-Reply-To: <20241015183824.1014964-1-irogers@google.com>
Message-Id: <20241015183824.1014964-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015183824.1014964-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 3/3] proc_pid_fdinfo.5: Add DRM subsection
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add description of DRM fdinfo information based on the Linux kernel's
`Documentation/gpu/drm-usage-stats.rst`:
https://docs.kernel.org/gpu/drm-usage-stats.html

Signed-off-by: Ian Rogers <irogers@google.com>
---
 man/man5/proc_pid_fdinfo.5 | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 3f90f6bb5..76a2562e8 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -302,5 +302,99 @@ fields contain the values that
 .BR timerfd_gettime (2)
 on this file descriptor would return.)
 .RE
+.SS Direct Rendering Manager
+.P
+DRM drivers can optionally choose to expose usage stats through
+/proc/pid/fdinfo/. For example:
+.P
+.in +4n
+.EX
+pos:    0
+flags:  02100002
+mnt_id: 26
+ino:    284
+drm-driver:     i915
+drm-client-id:  39
+drm-pdev:       0000:00:02.0
+drm-total-system0:      6044 KiB
+drm-shared-system0:     0
+drm-active-system0:     0
+drm-resident-system0:   6044 KiB
+drm-purgeable-system0:  1688 KiB
+drm-total-stolen-system0:       0
+drm-shared-stolen-system0:      0
+drm-active-stolen-system0:      0
+drm-resident-stolen-system0:    0
+drm-purgeable-stolen-system0:   0
+drm-engine-render:      346249 ns
+drm-engine-copy:        0 ns
+drm-engine-video:       0 ns
+drm-engine-capacity-video:      2
+drm-engine-video-enhance:       0 ns
+.EE
+.TP
+.IR drm-driver: " .+  (mandatory)"
+The name this driver registered.
+.TP
+.IR drm-pdev: " <aaaa:bb:cc.d>"
+For PCI devices this should contain the PCI slot address of the device
+in question.
+.TP
+.IR drm-client-id: " [0-9]+"
+Unique value relating to the open DRM file descriptor used to
+distinguish duplicated and shared file descriptors.
+.P
+GPUs usually contain multiple execution engines. Each shall be given a
+stable and unique name (<engine_name>), with possible values
+documented in the driver specific documentation.
+.TP
+.IR drm-engine-<engine_name>: " [0-9]+ ns"
+GPU engine utilization, time spent busy executing workloads for this client.
+.TP
+.IR drm-engine-capacity-<engine_name>: " [0-9]+"
+Capacity of the engine if not 1, cannot be 0.
+.TP
+.IR drm-cycles-<engine_name>: " [0-9]+"
+Contains the number of busy cycles for the given engine.  Values are
+not required to be constantly monotonic, but are required to catch up
+with the previously reported larger value within a reasonable
+period. Upon observing a value lower than what was previously read,
+userspace is expected to stay with that larger previous value until a
+monotonic update is seen.
+.TP
+.IR drm-total-cycles-<engine_name>: " [0-9]+"
+Contains the total number cycles for the given engine.  This is a
+timestamp in GPU unspecified unit that matches the update rate of
+drm-cycles-<engine_name>. For drivers that implement this interface,
+the engine utilization can be calculated entirely on the GPU clock
+domain, without considering the CPU sleep time between 2 samples.
+.P
+Each possible memory type which can be used to store buffer objects by
+the GPU in question shall be given a stable and unique name <region>.
+The name "memory" is reserved to refer to normal system memory.
+.TP
+.IR drm-memory-<region>: " [0-9]+ [KiB|MiB]"
+The amount of storage currently consumed by the buffer objects belong
+to this client, in the respective memory region.
+.IP
+Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
+indicating kibi- or mebi-bytes.
+.TP
+.IR drm-shared-<region>: " [0-9]+ [KiB|MiB]"
+The total size of buffers that are shared with another file (e.g., have more
+than a single handle).
+.TP
+.IR drm-total-<region>: " [0-9]+ [KiB|MiB]"
+The total size of buffers that including shared and private memory.
+.TP
+.IR drm-resident-<region>: " [0-9]+ [KiB|MiB]"
+The total size of buffers that are resident in the specified region.
+.TP
+.IR drm-purgeable-<region>: " [0-9]+ [KiB|MiB]"
+The total size of buffers that are purgeable.
+.TP
+.IR drm-active-<region>: " [0-9]+ [KiB|MiB]"
+The total size of buffers that are active on one or more engines.
+
 .SH SEE ALSO
 .BR proc (5)
-- 
2.47.0.rc1.288.g06298d1525-goog


