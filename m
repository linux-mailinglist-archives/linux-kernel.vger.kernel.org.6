Return-Path: <linux-kernel+bounces-383723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF89B1F83
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708AA1C20939
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59017E016;
	Sun, 27 Oct 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LWOACRw+"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44917C213;
	Sun, 27 Oct 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730051939; cv=none; b=ae5OOZSenWAGYeofoR/e0vMRprw1I1lqb0MQzQI7ZzlbloLxAm5LwgW9FmHv/boVYc62DQb4zKpB/J6yaeROQz/YHOntkwpqk4kiPmPvxuD3R0ML8uIwTQtz+HhPLy18hstbHF4ffjgLrfCbDBvVyIB8NNme2CYmDfa09+EEqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730051939; c=relaxed/simple;
	bh=ZG1FfEjGllD/phuvR3uOMeVGzSPc7fDfEJoiaGQStYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYUAJVx1cums525qoACqha2zQWj6FkB9nEOO9yniJWt76K3vjugTxqctC4ykau0mSn+5TuxhZ3WS6S+exjsHHF3Nuziwy3e5EXs0dS04/6H1ikx01BdaH3+sOXUpTtYbgKIIHEWQ+9ZwVAy7Uyh2mdWurqhEXQFbEffvYrzBagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LWOACRw+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EjvE5ECkO4a4IWIH2md5SXeAC7aZ8rGsxgHC6JRzPsc=; b=LWOACRw+dPktdCnjBVPNnav3wG
	J412nBd0B+W3uFXYRYz5YMfapM74Y+LsSfRSbsb1J0iKD+9MlPz/bJT71PTbbaN0oIS+57F4drsed
	IHASrgssG6FW3L2dR1Zle2wbESYJneUhGRsWbjgWvXVa0dIDIH6ueDJ1D0di1VYcDMQ6ssKtk9Xx6
	QLZOHz+6NdPIDz57IsedMvnSginavJhCTEa/jJVF6rjGAqMBqIvJuScPDp88UCVwO0CFiQ92mVsE+
	D4bs1vZDGXa/91LPiT3Y87ft+OUv6JU1u9Km17P5zrXoGboGG5GIuP8lWss4AZ+ZdeLPGkkWTwjOt
	+t2o+55g==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t57X9-00Fn6f-UU; Sun, 27 Oct 2024 18:58:36 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 3/3] mm: shmem: override mTHP shmem default with a kernel parameter
Date: Sun, 27 Oct 2024 14:36:39 -0300
Message-ID: <20241027175743.1056710-4-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241027175743.1056710-1-mcanal@igalia.com>
References: <20241027175743.1056710-1-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the ``thp_shmem=`` kernel command line to allow specifying the
default policy of each supported shmem hugepage size. The kernel parameter
accepts the following format:

thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>

For example,

thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size

By configuring the default policy of several shmem huge pages, the user
can take advantage of mTHP before it's been configured through sysfs.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 .../admin-guide/kernel-parameters.txt         |  10 ++
 Documentation/admin-guide/mm/transhuge.rst    |  17 +++
 mm/shmem.c                                    | 109 +++++++++++++++++-
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index acabb04d0dd4..595fa096e28b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6700,6 +6700,16 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
+	shmem_anon=	[KNL]
+			Format: <size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>
+			Control the default policy of each hugepage size for the
+			internal shmem mount. <policy> is one of policies available
+			for the shmem mount ("always", "inherit", "never", "within_size",
+			and "advise").
+			It can be used multiple times for multiple shmem THP sizes.
+			See Documentation/admin-guide/mm/transhuge.rst for more
+			details.
+
 	topology=	[S390,EARLY]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 9b5b02c4d1ab..47e7fc30e22d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by using the kernel parameter
 seven valid policies for shmem (``always``, ``within_size``, ``advise``,
 ``never``, ``deny``, and ``force``).
 
+In the same manner as ``thp_anon`` controls each supported anonymous THP
+size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem``
+has the same format as ``thp_anon``, but also supports the policy
+``within_size``.
+
+``thp_shmem=`` may be specified multiple times to configure all THP sizes
+as required. If ``thp_shmem=`` is specified at least once, any shmem THP
+sizes not explicitly configured on the command line are implicitly set to
+``never``.
+
+``transparent_hugepage_shmem`` setting only affects the global toggle. If
+``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
+``inherit``. However, if a valid ``thp_shmem`` setting is provided by the
+user, the PMD_ORDER hugepage policy will be overridden. If the policy for
+PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
+default to ``never``.
+
 Hugepages in tmpfs/shmem
 ========================
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 24cdeafd8260..0a7a7d04f725 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always __read_mostly;
 static unsigned long huge_shmem_orders_madvise __read_mostly;
 static unsigned long huge_shmem_orders_inherit __read_mostly;
 static unsigned long huge_shmem_orders_within_size __read_mostly;
+static bool shmem_orders_configured __initdata;
 #endif
 
 #ifdef CONFIG_TMPFS
@@ -5013,7 +5014,8 @@ void __init shmem_init(void)
 	 * Default to setting PMD-sized THP to inherit the global setting and
 	 * disable all other multi-size THPs.
 	 */
-	huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
+	if (!shmem_orders_configured)
+		huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
 #endif
 	return;
 
@@ -5174,6 +5176,26 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 
+static inline int get_order_from_str(const char *size_str)
+{
+	unsigned long size;
+	char *endptr;
+	int order;
+
+	size = memparse(size_str, &endptr);
+
+	if (!is_power_of_2(size))
+		goto err;
+	order = get_order(size);
+	if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
+		goto err;
+
+	return order;
+err:
+	pr_err("invalid size %s in thp_shmem boot parameter\n", size_str);
+	return -EINVAL;
+}
+
 static int __init setup_transparent_hugepage_shmem(char *str)
 {
 	int huge, ret = 0;
@@ -5206,6 +5228,91 @@ static int __init setup_transparent_hugepage_shmem(char *str)
 }
 __setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
 
+static char str_dup[PAGE_SIZE] __initdata;
+static int __init setup_thp_shmem(char *str)
+{
+	char *token, *range, *policy, *subtoken;
+	unsigned long always, inherit, madvise, within_size;
+	char *start_size, *end_size;
+	int start, end, nr;
+	char *p;
+
+	if (!str || strlen(str) + 1 > PAGE_SIZE)
+		goto err;
+	strcpy(str_dup, str);
+
+	always = huge_shmem_orders_always;
+	inherit = huge_shmem_orders_inherit;
+	madvise = huge_shmem_orders_madvise;
+	within_size = huge_shmem_orders_within_size;
+	p = str_dup;
+	while ((token = strsep(&p, ";")) != NULL) {
+		range = strsep(&token, ":");
+		policy = token;
+
+		if (!policy)
+			goto err;
+
+		while ((subtoken = strsep(&range, ",")) != NULL) {
+			if (strchr(subtoken, '-')) {
+				start_size = strsep(&subtoken, "-");
+				end_size = subtoken;
+
+				start = get_order_from_str(start_size);
+				end = get_order_from_str(end_size);
+			} else {
+				start = end = get_order_from_str(subtoken);
+			}
+
+			if (start < 0 || end < 0 || start > end)
+				goto err;
+
+			nr = end - start + 1;
+			if (!strcmp(policy, "always")) {
+				bitmap_set(&always, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else if (!strcmp(policy, "advise")) {
+				bitmap_set(&madvise, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else if (!strcmp(policy, "inherit")) {
+				bitmap_set(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else if (!strcmp(policy, "within_size")) {
+				bitmap_set(&within_size, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+			} else if (!strcmp(policy, "never")) {
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else {
+				pr_err("invalid policy %s in thp_shmem boot parameter\n", policy);
+				goto err;
+			}
+		}
+	}
+
+	huge_shmem_orders_always = always;
+	huge_shmem_orders_madvise = madvise;
+	huge_shmem_orders_inherit = inherit;
+	huge_shmem_orders_within_size = within_size;
+	shmem_orders_configured = true;
+	return 1;
+
+err:
+	pr_warn("thp_shmem=%s: error parsing string, ignoring setting\n", str);
+	return 0;
+}
+__setup("thp_shmem=", setup_thp_shmem);
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #else /* !CONFIG_SHMEM */
-- 
2.46.2


