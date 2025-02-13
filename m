Return-Path: <linux-kernel+bounces-513766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395AA34E74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A9F7A4B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437F2661A3;
	Thu, 13 Feb 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nfGM5Xt6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74A266184
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474641; cv=none; b=nyk/RPfFRjCqYMK9ved0IXhuVZmoNWnibOA5b52/DyTwx8epAZw1Ap8AKJo/hv4Ka5LGLlWzFTuL6DzdodPPc0UGamJMR4lK8jaXGmeeVAb1TdjCyA602UPTfNADvP6ONKdBFUKl03eVW5eMYhPnu/eaMkcy3yHjpkQjy+upuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474641; c=relaxed/simple;
	bh=CJWBPXmsxgPHyVpk2lWHbQwaPlDzlBXsV4FmAq+lo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWCBSqqXYShNTxjJVPd5Sp/wXil1oaKgx3RsxIUXpVOFHPKtbiPbiiqGjCS36j89UFRhDl6dXKszlVX0T1IFlZ4f2t25LsLXG7XeZewJYP5ikuxTNW3hKcCcap78WepDJ60KtlSf1MfEWX+D2zDonndlYiPi7xmM0IIAZzcyxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nfGM5Xt6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f92258aa6so32958925ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739474638; x=1740079438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwadMtANA8OqSE9WI8RE1a22pM7OUgQJRvEwfN3e/Eo=;
        b=nfGM5Xt64V0IJ7PdjXLw60O4kBG7IfrFO4dNnZw0FTTGYk1Z4bul4zUp0NvDBLVm/A
         h5gn77/6flk+QNUUJ+7LU0DplXmtw1QtYj3ZuiFgiwQYzfGtABZ2t1+HC3pQcDoP5ne2
         NhhAUv3Qzeqbs1fw/WMfInIAopZBgLHiu41So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474638; x=1740079438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwadMtANA8OqSE9WI8RE1a22pM7OUgQJRvEwfN3e/Eo=;
        b=NCscufP83LSbVkOSvjDixJBxF4VONMaHdRxsSYuG2or/gkRVOtx/uozYxDlO2h+mWY
         nFA+JHPOrZtqjb6vsZgPTqk/4c9I9pmze2cO1sNrWNuSUr5tGwNtShWeDbzxno0kpLRj
         dz974A92Okxn+fEj2lFqL43Zkiui9aUKO2ojLI3RBu9jqHZx2r4C015CdUSR4jC0LAII
         t2/hsq3yR5WbvE9D99aq5COIoNzDVP6oQqCK8bNfQL2SdjVD5v9xPn5z3CBNhZGBB9KP
         nTwn36olAQJnfkkm9TXfpEzd4mpRdmWw764d1NKxbZ0PstjlUmA0TQISrral8TYNT4Mm
         EAbw==
X-Forwarded-Encrypted: i=1; AJvYcCXb2lkT/wf/anMmirLO4LyUG4Gw4xwcWj9PEF3u5HiTdQVjY1MF19p8zqfpzcoaKadlkWix5kLarTfx/vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzV0DHwfUspOTQ6/ZyxuQXrPSmtQlPd1WAHDkf/XAlk43BYs1j
	4+89l20NXVKEaGUxvky/2oTIZPm2biLrJmcn3B7mvQEDqX8rMPeTddKm6kXNQHo=
X-Gm-Gg: ASbGncuk9vkPYj7g8NN9Bau/m4xjAIGqoMV44DNurg405ZTued1gVMWGp9CFTQ6Hl40
	s8sUH7Tg08iypOLHYS+SgLIcMUHLiQ7OnbA1UhlW9wldbWxKK3HDEjVGgwGjpOr2nFQ3C2PwL9j
	7v+/7wPq3jgehCQr8uBRCGx/Vt4fI9mVbx2M28INZ6XGungR69svK86WpYMGJBr77/yoUsIks5/
	bCncIgW+7vxxHCAbhUxtHD4p/H1122JaJOfa6UzYMJGacdBkk2RDca6lEXW6MeTl78HLsCkeooK
	7vJWeMrfID0gicWebs1RxRY=
X-Google-Smtp-Source: AGHT+IFB59MypCe1M67/gpnz3aEE1mKoo0YL/Ohl2o58HL0YFhqCLmbe4dCReCYupJtHWcKppaZayw==
X-Received: by 2002:a05:6a00:2e84:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7322c373ebamr15784837b3a.3.1739474638497;
        Thu, 13 Feb 2025 11:23:58 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a9esm1633458b3a.45.2025.02.13.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:23:58 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next RESEND v7 3/3] selftests: drv-net: Test queue xsk attribute
Date: Thu, 13 Feb 2025 19:23:13 +0000
Message-ID: <20250213192336.42156-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213192336.42156-1-jdamato@fastly.com>
References: <20250213192336.42156-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that queues which are used for AF_XDP have the xsk nest attribute.
The attribute is currently empty, but its existence means the AF_XDP is
being used for the queue. Enable CONFIG_XDP_SOCKETS for
selftests/drivers/net tests, as well.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 5 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
new file mode 100644
index 000000000000..ec746f374e85
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 28b6d47f812d..68127c449c24 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,10 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 $(wildcard lib/sh/*.sh) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
+TEST_GEN_PROGS := xdp_helper
+
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index a2d8af60876d..f27172ddee0a 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -4,3 +4,4 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..5fdfebc6415f 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -2,13 +2,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from lib.py import ksft_disruptive, ksft_exit, ksft_run
-from lib.py import ksft_eq, ksft_raises, KsftSkipEx
+from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import cmd, defer, ip
 import errno
 import glob
-
+import os
+import socket
+import struct
+import subprocess
 
 def sys_get_queues(ifname, qtype='rx') -> int:
     folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
@@ -21,6 +24,39 @@ def nl_get_queues(cfg, nl, qtype='rx'):
         return len([q for q in queues if q['type'] == qtype])
     return None
 
+def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
+                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
+                           text=True)
+    defer(xdp.kill)
+
+    stdout, stderr = xdp.communicate(timeout=10)
+    rx = tx = False
+
+    if xdp.returncode == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.returncode > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
+    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if not queues:
+        raise KsftSkipEx("Netlink reports no queues")
+
+    for q in queues:
+        if q['id'] == 0:
+            if q['type'] == 'rx':
+                rx = True
+            if q['type'] == 'tx':
+                tx = True
+
+            ksft_eq(q['xsk'], {})
+        else:
+            if 'xsk' in q:
+                _fail("Check failed: xsk attribute set.")
+
+    ksft_eq(rx, True)
+    ksft_eq(tx, True)
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
@@ -81,7 +117,7 @@ def check_down(cfg, nl) -> None:
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
new file mode 100644
index 000000000000..2a40cc35d800
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <linux/if_xdp.h>
+#include <linux/if_link.h>
+#include <net/if.h>
+#include <inttypes.h>
+
+#define UMEM_SZ (1U << 16)
+#define NUM_DESC (UMEM_SZ / 2048)
+
+/* this is a simple helper program that creates an XDP socket and does the
+ * minimum necessary to get bind() to succeed.
+ *
+ * this test program is not intended to actually process packets, but could be
+ * extended in the future if that is actually needed.
+ *
+ * it is used by queues.py to ensure the xsk netlinux attribute is set
+ * correctly.
+ */
+int main(int argc, char **argv)
+{
+	struct xdp_umem_reg umem_reg = { 0 };
+	struct sockaddr_xdp sxdp = { 0 };
+	int num_desc = NUM_DESC;
+	void *umem_area;
+	int ifindex;
+	int sock_fd;
+	int queue;
+	char byte;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
+		return 1;
+	}
+
+	sock_fd = socket(AF_XDP, SOCK_RAW, 0);
+	if (sock_fd < 0) {
+		perror("socket creation failed");
+		/* if the kernel doesnt support AF_XDP, let the test program
+		 * know with -1. All other error paths return 1.
+		 */
+		if (errno == EAFNOSUPPORT)
+			return -1;
+		return 1;
+	}
+
+	ifindex = atoi(argv[1]);
+	queue = atoi(argv[2]);
+
+	umem_area = mmap(NULL, UMEM_SZ, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			MAP_ANONYMOUS, -1, 0);
+	if (umem_area == MAP_FAILED) {
+		perror("mmap failed");
+		return 1;
+	}
+
+	umem_reg.addr = (uintptr_t)umem_area;
+	umem_reg.len = UMEM_SZ;
+	umem_reg.chunk_size = 2048;
+	umem_reg.headroom = 0;
+
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_REG, &umem_reg,
+		   sizeof(umem_reg));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_FILL_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_RX_RING, &num_desc, sizeof(num_desc));
+
+	sxdp.sxdp_family = AF_XDP;
+	sxdp.sxdp_ifindex = ifindex;
+	sxdp.sxdp_queue_id = queue;
+	sxdp.sxdp_flags = 0;
+
+	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
+		munmap(umem_area, UMEM_SZ);
+		perror("bind failed");
+		close(sock_fd);
+		return 1;
+	}
+
+	/* give the parent program some data when the socket is ready*/
+	fprintf(stdout, "%d\n", sock_fd);
+
+	/* parent program will write a byte to stdin when its ready for this
+	 * helper to exit
+	 */
+	read(STDIN_FILENO, &byte, 1);
+
+	close(sock_fd);
+	return 0;
+}
-- 
2.43.0


