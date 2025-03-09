Return-Path: <linux-kernel+bounces-553131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCBA58449
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB6A3ACA54
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E71DE880;
	Sun,  9 Mar 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CyEe1eUF"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44A1DE2C9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527001; cv=none; b=bbDXHTCpSKPLwAun1G6PPbyOpuUCDx0rNSU4thxXQ1539zKNAW2dp4o6SzfCrpC0Hl5tEe7mshtOvtBN7TZEukJvwcvFElKohyub0BOCPUCAxZ4oDNMCw2b+k9y+Hn8NZqjQjvDF3ThrHcUKbICK303OQW3h+p2kRnCUy//GD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527001; c=relaxed/simple;
	bh=HBzrftBgtmyJjSlrkubZ14+wzgBNDhuJgvNUC0ysav8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYgUJxEOXSRt/GEfZ8SOo2NIKW7cwB3hVnElm+Un/ZgL0TnlBkzBhjNrFv5ua9pVQcOrMhj2TcCXRQrUpWW3+xPngipHcrUuZCJVgzxceXDARPqFoclGLWy30t8NejF7OZ0w3sWUD844Sh9s7KNOBjoI8xCrkWRTO3sbi6tyLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CyEe1eUF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0BDD63FCE7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526990;
	bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=CyEe1eUF6ito/OGMBlQsZnS5ilrqScAUB5paGBECAtEOtmDwere+8LgqnfYLolTcv
	 nTs3zew035jCiDX577RQtqsRLjCB9aT4PcIb6OSGYLtzIZx+FUb61/KCAcuL84X+/H
	 OpYk4OJphC6tTGm535fv6JEG752kU1GKr6jlUueNvjVCZVvy/p2cLH2kHIrDkJQCVj
	 4vw4TZgThsKfDkg7yqQJ6MKY+fABhMctvjE+8vS9H5JMwSGcpY5MLTeu5tDVDPe3Gr
	 SQaltd0gD2b0pNCs1w1rnGS6QuQPZUMsDH8eYimpH9w9fP0AzLGs1joHL+xE41deHW
	 Dydi3XtOvarPw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac1e442740cso317834766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 06:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526983; x=1742131783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
        b=aS5mpoo0aVr5yBk96GQxQ96vhByS2XOQ4sZWU4Die8GKnMm47sjFACKUZKN5VHZvtV
         kPYTi+w+5dGPWYr+x42RygTPXnlCrrm26JVQ6d6Q7GymzPgRTqDyvsQ5D1tTbRIDGxwB
         AQWS3LRwCAPPk4ZhACN9/UofDnN2wj+cRSuALGP8Hw9K1cf4RXA5VUqwVubEKi1h9iHm
         jnxnRjhk9V78A3fU3u1RmsffBwhTgBFcuQ9nt1nisfreaXWuJnR9nx7hcXd8kUKoEV3j
         VQEvUAxl6CK64yonWosY4uXUSNqqgn29Kq4M5A6zfl+8dKp379JEcFbueoNgf1fo40YI
         EV+g==
X-Forwarded-Encrypted: i=1; AJvYcCUgfqWvpflYn+D6+poem7IOBYW6JoKO9PMSuLiSuKZEVBkNS9coAwgqEFWxdcrvPt6wIIJsr9bGVQuxbuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyddmvba2XPj0GX+0iyTz/nRvICxhtGLLU6X8CklUwyYDuQWRB/
	Is7yYj/OHoMgiJN1Riiubryt/JtGqsBm42EwLN5colBZnVUPvO9OwBwaiqy8e6P2Tg7VmxReWHF
	MeFL6SywbCccpvm+WY2R2aWcuLZXYaZSmjgNrisytQwlCpeV/tp8w3wU8NIFobuNYeXERb9HUrZ
	kjzA==
X-Gm-Gg: ASbGnct2JKYpiBy2OtgVBhWhxOncCzZmm7uWi3US9u5DtXXYfJ+BF5CokYY2VBX1a0l
	9gUmM5nM4LBqBw+dNPvRYIdxdvYcFE59pKUyNpsgYbZ5VPN1Kufe7osSFYVPNDVoDPRvsYXhIPG
	vSkPUPojy0kWOo/A4/qj3v1f2uhYjaCdZu296a0palkZzGAKUj1uTahjPfPhjk+twrHcrZkYGq1
	AOJV2bW0M8sL6jPSrXPfa7xHSsZj1VR56G5h8oflmklGgMHMt4FrCREe3UE0VUlWV0R0+1tm7Y0
	SVHDwkGpizoYWeSl+nnfhB9ZBgA243/fLh99SdtJfdTySYnUx/MELIeo7rGHMke6opF6ORePhEG
	haBDXfTqawV9giWAaug==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252828566b.35.1741526983275;
        Sun, 09 Mar 2025 06:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Jp1lBL5UEDOmoLhr3/1+wDXXnEG000YcKS7uOUaGglmKZVGqoQ8LvIDpjopxUUJhpkTkFg==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252824566b.35.1741526982866;
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 3/4] tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
Date: Sun,  9 Mar 2025 14:28:14 +0100
Message-ID: <20250309132821.103046-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 15 +++++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e2d46636a0c..b60e0e1433f4 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -205,6 +205,21 @@ int cg_open(const char *cgroup, const char *control, int flags)
 	return open(path, flags);
 }
 
+/*
+ * Returns cgroup id on success, or -1 on failure.
+ */
+uint64_t cg_get_id(const char *cgroup)
+{
+	struct stat st;
+	int ret;
+
+	ret = stat(cgroup, &st);
+	if (ret)
+		return -1;
+
+	return st.st_ino;
+}
+
 int cg_write_numeric(const char *cgroup, const char *control, long value)
 {
 	char buf[64];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 19b131ee7707..3f2d9676ceda 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdlib.h>
 
 #include "../kselftest.h"
@@ -39,6 +40,7 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);
+extern uint64_t cg_get_id(const char *cgroup);
 int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
-- 
2.43.0


