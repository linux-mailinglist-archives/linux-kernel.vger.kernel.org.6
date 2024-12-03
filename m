Return-Path: <linux-kernel+bounces-429933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE69E292E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4E7284A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC3C1FBCA6;
	Tue,  3 Dec 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvuqWreo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199D1F8AE1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246810; cv=none; b=I1M7mh2JSV+ihZxdhR6mLur7j4Ds40gFk1l3nfbmTxQ6II6xazNsR5HRYKUfG3JL9PZktRGANWJxqZGYAhAA3ISpgLhRqA+GTKwQBYtMNc8iyA8nWhkzvL5aFq5ty8koOYYU86SX3xqos+2Bsphxpw9tRU4jRgmQMkqijqYDwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246810; c=relaxed/simple;
	bh=MCDy6HkUfDKHYjRUBvEabLuhWMTUUHI+2O5UXR9PdkA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bOPRnUZ4aKdTcwlcPxF2fO2GmjT7SZ5V0nbnIPwaJRVXiKhtVIZAeXODP86uOawgRDH35f2uG4Fw8qn+lRma9m7R+Wln6khXOwnRTSaGCBCZBNwBsQXSiiZijco3QRbYnI2BAPwUGF4ne2VirIvhSaCzOerGytevbFsesMhuCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvuqWreo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so55995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733246807; x=1733851607; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esMBl0uOLbGzsFzbKrL9tw7lBRfURdjOWkpYSobO80c=;
        b=kvuqWreoEPTh05IQgWB1Xv6RDHveXyeGC6mbLxyug6E3zrExlcgZLcS7CX0oXYQZxa
         FRMqWUSH79q/5HilViq8aYbF4L7698F8x7oj5QUYyChRYt21NgYNCAaieu/PXhsTE0V2
         IN8XQd7bCDgCYgp7kQ5Lb4RpH5H+uM2/pH+hy5oHcvjHPVvaxXSRR1ziPJlj6y33Ei+e
         0V/S/U3+LxnCxmDtw4OVdUaJ6g+g17KsQd5sbGwmVHsdmcrJvKTF5nkRWns5pxo7iG6f
         +80TuNeq1CeJe1koiliq58tCB7GS7MFoam0U+sqBdfzC9VABIH8o3o+xloP4cJcHruUF
         SMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246807; x=1733851607;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esMBl0uOLbGzsFzbKrL9tw7lBRfURdjOWkpYSobO80c=;
        b=oBiHbFI3/kZi5dsx44DSVq76LNzU0CzHawG7Ccy+wxp6NCNsPGFNoRPwqXaKcUHyaB
         OzjXBZFF3JBL0XcZ0ooJ5WI7EhVEzvqd6GHbCbI0LElbvE5Ho0cx7E0dxtKmRLewqgwe
         pQz946a88EpIjs6NdB1jL1/P7YhDxKXRvmvDaks+5nxDS1w4W2/voGQ8xIhB70ehDoMW
         W8/nXxvgHd44a69VwdBRFv1gOeYzPpE2e7UDUvUQN/AZxvroiqCyy1JGniExOqDPAgc8
         k/ilsLXcZ0ean7lmFGJzKqDvp5p/HOlot6yHPE939GN+W/xjNKrLsyz79IaOQs2T+6cv
         9FDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZUbjz4Wz3nLm/MopKPg6YF1IdrQCLfxwtWBEWh0/nGvKliIs3WawQSXmEm8tRouxrXuXeJaF8ylAPsgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyHBhHhr3dV1Hh4iyx5ZHEyW35QTFsA2ay2mlKSSN1rek1NJV
	s+C9U/lta3HaijL3SC+DO/RJmjsqa3y4JRK6xlCWHDEIyuRS1IiQ6mq287YtWA==
X-Gm-Gg: ASbGnctHiTRHQ8Tcei9uaMKV9QbBzHEEopElIH+ybmxxQmfySHpOeVAB7kbs/Jxn49G
	OF/mAYoMBVDm/wyxfUJU3uXKcHYXJVrvo6FicPbGPt4ClDQSpfuzgY3PCkMGklCkADzO0N0zfGn
	oiXQ1D5MRLxfON5/Y53GREcswWrHW4tzGBsgWR0TdVWiyfqAEzFrgRlFLemJkuD1sdVkYgqlNEc
	WmxDt2+rKcsD2jnm+JbpM7jVUdOFnHNrrfVirw=
X-Google-Smtp-Source: AGHT+IHu3tfTAoXvieXaIRaJiRZryx8cWpn3+5PzdcsLUtGUjPoPKMn6gY/KMYeGtkKYB5HV7URZ6Q==
X-Received: by 2002:a05:600c:2144:b0:434:9d0b:bd7c with SMTP id 5b1f17b1804b1-434d12b8df7mr1213685e9.3.1733246806576;
        Tue, 03 Dec 2024 09:26:46 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:92ba:3294:39ee:2d61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f8448d32sm4515574f8f.96.2024.12.03.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:26:45 -0800 (PST)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/3] fixes for udmabuf (memfd sealing checks and a leak)
Date: Tue, 03 Dec 2024 18:25:34 +0100
Message-Id: <20241203-udmabuf-fixes-v1-0-f99281c345aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4/T2cC/x3LTQqAIBBA4avIrBP8y0VXiRaaY80iC8UIpLsnL
 T8er0HBTFhgYg0y3lToTB1yYLDuLm3IKXSDEspIJTSv4XC+Rh7pwcKDMHpE77y1GvpzZfxDX+b
 lfT+rWACQXwAAAA==
X-Change-ID: 20241203-udmabuf-fixes-d0435ebab663
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 John Stultz <john.stultz@linaro.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733246801; l=2909;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=MCDy6HkUfDKHYjRUBvEabLuhWMTUUHI+2O5UXR9PdkA=;
 b=7R1+MVXGDrX8ZjzD+lYpU8vJrqqQZsU/jjVE8x5Xvlp659inhHh4Hs6EU5+zsTLaWSIvHEjrU
 U58t58Lkh24B4O1A8seSqKkOWQKwCT4vgQTfc8JN9wGpHh4WP31+uUE
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

I have tested that patches 2 and 3 work using the following reproducers.
I did not write a reproducer for the issue described in patch 1.

Reproducer for F_SEAL_FUTURE_WRITE not being respected:
```
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/udmabuf.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  int memfd = SYSCHK(memfd_create("test", MFD_ALLOW_SEALING));
  SYSCHK(ftruncate(memfd, 0x1000));
  SYSCHK(fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK|F_SEAL_FUTURE_WRITE));
  int udmabuf_fd = SYSCHK(open("/dev/udmabuf", O_RDWR));
  struct udmabuf_create create_arg = {
    .memfd = memfd,
    .flags = 0,
    .offset = 0,
    .size = 0x1000
  };
  int buf_fd = SYSCHK(ioctl(udmabuf_fd, UDMABUF_CREATE, &create_arg));
  printf("created udmabuf buffer fd %d\n", buf_fd);
  char *map = SYSCHK(mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, buf_fd, 0));
  *map = 'a';
}
```

Reproducer for the memory leak (if you run this for a while, your memory
usage will steadily go up, and /sys/kernel/debug/dma_buf/bufinfo will
contain a ton of entries):
```
#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <linux/udmabuf.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  int memfd = SYSCHK(memfd_create("test", MFD_ALLOW_SEALING));
  SYSCHK(ftruncate(memfd, 0x1000));
  SYSCHK(fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK));
  int udmabuf_fd = SYSCHK(open("/dev/udmabuf", O_RDWR));

  // prevent creating new FDs
  struct rlimit rlim = { .rlim_cur = 1, .rlim_max = 1 };
  SYSCHK(setrlimit(RLIMIT_NOFILE, &rlim));

  while (1) {
    struct udmabuf_create create_arg = {
      .memfd = memfd,
      .flags = 0,
      .offset = 0,
      .size = 0x1000
    };
    int buf_fd = ioctl(udmabuf_fd, UDMABUF_CREATE, &create_arg);
    assert(buf_fd == -1);
    assert(errno == EMFILE);
  }
}
```

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (3):
      udmabuf: fix racy memfd sealing check
      udmabuf: also check for F_SEAL_FUTURE_WRITE
      udmabuf: fix memory leak on last export_udmabuf() error path

 drivers/dma-buf/udmabuf.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)
---
base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
change-id: 20241203-udmabuf-fixes-d0435ebab663

-- 
Jann Horn <jannh@google.com>


