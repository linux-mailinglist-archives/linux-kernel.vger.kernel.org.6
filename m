Return-Path: <linux-kernel+bounces-392792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C19B982D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73386282ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B61CDA2F;
	Fri,  1 Nov 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9xBr4fp"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591C1CF7A8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488329; cv=none; b=ZtXboxZ2noKCFceZHQMHkfZ/YagMym3pGjaXBXw26oRNnEezqjU8ZSAWObRVf1qDGim3H6E1xeGCw2eMRAMMqg8MWUOiqs/KA09Lq5v5xkjGl62QEm4ZleBwevoJMrRpva/G1Xg5InMC9ne7YCcurQQXE6BkejxBIRGOmDsNBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488329; c=relaxed/simple;
	bh=sjWLwU72+TM3wrbCnZk1mLiwGKN++8XAP8RRimOMboo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=oHvhVHXNgDvuXTGpAEPstXZLHtFvicehyIM1en1t/0r/8U1AHANmPnDFAya3bxJ5tRKwcOTKl1tubRmmU2fjQn4erU1tiVb/WAily4MXYI4ZCsJt7GmMOL/8UzhQOZUpNKJy4khccuH7yb5jVeeHTJO4mSO3SFggd4eabB7Lekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9xBr4fp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so44422427b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730488326; x=1731093126; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohnZM44rwMZlspoSV7nexQOFx9fd9I0RoLZU+lRn4Jw=;
        b=t9xBr4fp8xOO4y9DFYzoVTUoOyTBVwH2aDwjhEWP8CKvn+GLWiwi3i7YUr/QJFQXOO
         KNHhlsrEs6HuJEqvAlKpQNgFe2uwPMATuDka+VGvViB0Hz6uiYYGYKIYKSJMHvcrPyyC
         7qdzuYgO0ZFYLD39/Aro6lmP2bh3j6cApQIFnOaiTC6ngYIJKQzxKhA3uGBgGiIPsHjH
         ON14E85uokgP33WI5STz1mAdag4Po6YZsZnZKOv6H1HS/6ulGH/P40y6stmj+h4OXoUJ
         AmjpsVLvYeO7SWZOH7DuJ+wxeYwbOfbdzMvMAZyYCiqERaeu+oERwFen0YmtzckNZr0/
         YMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488326; x=1731093126;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohnZM44rwMZlspoSV7nexQOFx9fd9I0RoLZU+lRn4Jw=;
        b=Exih2uaBqmPFtHPcRZ4GUdesYeJ830p0zzJT33B5Dej2Ke5t+INAA2lpDhkUgQmY7i
         6d6dAL0LkrKKbT4F4vKfmEfv2WkTSWuaJBUOXpeAgf3ikt2ynFhli0k7inN5SjDBmAlx
         RDqMKW3e9c7k7CO5HMYc7JdIFtK4Kf51dZaxS+neUNWNrarmaShQdk4rRwlTGRm5LvrE
         xp9mx1n0S28XKjblqP19VQx2eIyapJOPXCJtQpKBHDHbxCCwoWtxzPX3ZM6CiVjqRtO/
         qArVDdCd6DmR0VYKNMMujDcF2G7wwb3RIxbV7URxLQtCOw1Gjzbn3OjRbCWgWEJ3ZsHI
         np8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGg7bukT0T5BZl4tcxUJ428ujRDaztdYxpiPcFKjPPFBeUe3wja7gIJlQy60JsPvOQrxxj+Ts0gh4m/YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwE7oAKcxea+Ha+s3Zcjt/akyqIasNy2NCB3g+yMi8aq6y7Vj
	s/RCTiQi2+Fj59Pk7a5PFd6/m2+bRGjmMYxPBTyJmtwDFiV2vZMbR81vFhuG2jFBD1ALGclFTKE
	SE6iBgQ==
X-Google-Smtp-Source: AGHT+IEuIJAQ2wb2B6bc2za+FDb03I7t2GB4uUnxnQv8Bdi+HQoDpYmPSz/8C2693i9quEq0xJ1kmlxHgSAn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f2e6:5ab5:a95f:35cb])
 (user=irogers job=sendgmr) by 2002:a05:690c:6407:b0:6e3:8562:ffa with SMTP id
 00721157ae682-6e9d8b5f046mr14987157b3.5.1730488326506; Fri, 01 Nov 2024
 12:12:06 -0700 (PDT)
Date: Fri,  1 Nov 2024 12:11:56 -0700
In-Reply-To: <20241101191156.1272730-1-irogers@google.com>
Message-Id: <20241101191156.1272730-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101191156.1272730-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 4/4] proc_pid_fdinfo.5: Add DRM subsection
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>, "G . Branden Robinson" <g.branden.robinson@gmail.com>
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
index 290cae6a6..98ac12f16 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -301,5 +301,99 @@ fields contain the values that
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
2.47.0.199.ga7371fff76-goog


