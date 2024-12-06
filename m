Return-Path: <linux-kernel+bounces-434195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478339E62FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AA4165B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1415126C1C;
	Fri,  6 Dec 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVfGpoiQ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6242AB3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447375; cv=none; b=gUfQ71PbpvafEBk4NIRUeElASfurVfRrj/3HksjiC2t70aqnV9mfs+rclSgyCJJglWGDoLch1t7FAlP0aI7D4OEJ+wx6+CTKGIrAuw/47QI9zcxhIJQDkL8I+B6I+kZ/s2ocVrwb9BJ03zUjmsXiqGUalmxDlhNuoq1Ej9BR3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447375; c=relaxed/simple;
	bh=wsM9vLDw0CHdbLDDaEcHtOdF5+mAPzk7SGmw4gV4nvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qRtBYNJoNiPOvSL79aI/FKuAWHzC39KLxYU68TKnD8maGUhoux75wD4N4pU7ZMzr8MqRXErdS5jHEizpbdkmkTycnrhgs3uq1Jfow+3I54dj9hbvf91xuHdfVHSlgsT6GL/JkQIKDoV7K27GOuU/HY0LseusqQdOELBoVf4Qztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVfGpoiQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fc62de66b5so1796825a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733447373; x=1734052173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mGLqKj5S2m2Rj61UvNDmOdNoAA7bI8ePX/RHfZ0+49A=;
        b=EVfGpoiQSMD4eWdHyHda8xsUYg1gYuZ176bMxvKSRMrVzarbklQkxewive+sHSTHMb
         wPeYzF4kk6PtAAjUBLnMAp7EddnxUSeoIdxdzWl6zZysVza6hv52QwsKjm62kJcylVCR
         /N2tCeQMgum9DCrB3MwaxjiTlYa2Ia6mYSHQUs4yXr2k8Re1HE2R/4VlGOB5dtZsxyxV
         kUBXfu7qwH63fl0F+yLsspH9B5bei8u1qW9mYcAwh2JN1OvNkCI6ACZc+1MTkqZT/0PG
         em6TNVn01oHo/kqiLtoOyaAItS2MK284MM/ekF/x55eugV7YDOfWscL6Fak9BQR3sDUb
         qAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447373; x=1734052173;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGLqKj5S2m2Rj61UvNDmOdNoAA7bI8ePX/RHfZ0+49A=;
        b=Mm25TF2TirXAKGStW8TYTAZYOLJ4gnQ3RMmLiL0SmWB2KEDXtuL4hW/0K4QBrEW8yg
         W+0rg8WUTvUx2adhrxNXC1f9RRX2aOCVue1SdAwxlL+i27z5qgXf7/iqmJbH+GxpKjUm
         RjPISMakxvNu6Ec4lbC1I8g6df53nrypGq8GUNGpKZxO7LYqfp0PMEBrrVFIQ6A9R3+C
         elMuQed1KA/r5wVQKl2EXfok/n3ttAHarF+aahdo9SsRIQ1mDOk5x6LbJ/DXP4eHi9mM
         K1pNc6ChXWuLAotI4eQ674LMk8eIWvneUFsTi71Rbz8IwLcNi96Z7g5htQYIW5s+C0jj
         yTvg==
X-Forwarded-Encrypted: i=1; AJvYcCVId1KkEmrsza6WKh9LNUCOAtKxyGIkxoNXk/+spMZuqWC+EhgqYr97zA823VrNQRESkN2LI3KRKLnwZKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjazGEnvV2FFlEZU20/wB1klgyfqDanDJjpf/DQIKGmCFWbM36
	qoHnVTgm9VpB+0mJjRGYYdq53kBAbxaQtRqnVfbfkEGSG5HjA0oPmpcS6p8JBxVkvM6nZ+dY3YF
	rhHoAbSDk9+/tm7pLyuTCCLdgk+Ebuvs2/A==
X-Google-Smtp-Source: AGHT+IFPnDgD07jtAFpU33ooDGy+t+dpNNTC6OaKUlNxnqoWnzm0WCjKmNAOIG5jiM0RQhNLAN/4r5MmaJJzsy+7bV7Z4g==
X-Received: from pgbdt13.prod.google.com ([2002:a05:6a02:438d:b0:7fd:28c7:fdc3])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9986:b0:1e0:ca1c:857e with SMTP id adf61e73a8af0-1e1870c964fmr1724998637.20.1733447373037;
 Thu, 05 Dec 2024 17:09:33 -0800 (PST)
Date: Thu,  5 Dec 2024 17:09:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206010930.3871336-1-isaacmanjarres@google.com>
Subject: [RFC PATCH v1 0/2] Add file seal to prevent future exec mappings
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Android uses the ashmem driver [1] for creating shared memory regions
between processes. The ashmem driver exposes an ioctl command for
processes to restrict the permissions an ashmem buffer can be mapped
with.

Buffers are created with the ability to be mapped as readable, writable,
and executable. Processes remove the ability to map some ashmem buffers
as executable to ensure that those buffers cannot be exploited to run
unintended code. Other buffers retain their ability to be mapped as
executable, as these buffers can be used for just-in-time (JIT)
compilation. So there is a need to be able to remove the ability to
map a buffer as executable on a per-buffer basis.

Android is currently trying to migrate towards replacing its ashmem
driver usage with memfd. Part of the transition involved introducing a
library that serves to abstract away how shared memory regions are
allocated (i.e. ashmem vs memfd). This allows clients to use a single
interface for restricting how a buffer can be mapped without having to
worry about how it is handled for ashmem (through the ioctl
command mentioned earlier) or memfd (through file seals).

While memfd has support for preventing buffers from being mapped as
writable beyond a certain point in time (thanks to
F_SEAL_FUTURE_WRITE), it does not have a similar interface to prevent
buffers from being mapped as executable beyond a certain point.
However, that could be implemented as a file seal (F_SEAL_FUTURE_EXEC)
which works similarly to F_SEAL_FUTURE_WRITE.

F_SEAL_FUTURE_WRITE was chosen as a template for how this new seal
should behave, instead of F_SEAL_WRITE, for the following reasons:

1. Having the new seal behave like F_SEAL_FUTURE_WRITE matches the
   behavior that was present with ashmem. This aids in seamlessly
   transitioning clients away from ashmem to memfd.

2. Making the new seal behave like F_SEAL_WRITE would mean that no
   mappings that could become executable in the future (i.e. via
   mprotect()) can exist when the seal is applied. However, there are
   known cases (e.g. CursorWindow [2]) where restrictions are applied
   on how a buffer can be mapped after a mapping has already been made.
   That mapping may have VM_MAYEXEC set, which would not allow the seal
   to be applied successfully.

Therefore, the F_SEAL_FUTURE_EXEC seal was designed to have the same
semantics as F_SEAL_FUTURE_WRITE.

Note: this series depends on Lorenzo's work [3] which allows for a
memfd's file seals to be read in do_mmap().

[1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
[2] https://developer.android.com/reference/android/database/CursorWindow
[3] https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/

Isaac J. Manjarres (2):
  mm/memfd: Add support for F_SEAL_FUTURE_EXEC to memfd
  selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC

 include/linux/mm.h                         |  5 ++
 include/uapi/linux/fcntl.h                 |  1 +
 mm/memfd.c                                 |  1 +
 mm/mmap.c                                  | 11 +++
 tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
 5 files changed, 97 insertions(+)

-- 
2.47.0.338.g60cca15819-goog


