Return-Path: <linux-kernel+bounces-308615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66662965FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3752BB2D90B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95218E37C;
	Fri, 30 Aug 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="iRAUpXCf";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="iSZPtY5N"
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BF16F0DD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=149.20.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014671; cv=pass; b=KoMdf9A+Y0oLGI9Pm5xl9VsQt40lPYNlMPs/y6B30Z5da2v7PKDcvmhQe3AbMPNCD5oB4qbNBrk9BcuDRJFkIfJ4h+KenqTZiDcwStxdPI9z5JGDqUuqwD+wddjYC8aiCwQuHoXciebtMBIydYJrwosoJxqeCm4f0qKhO8Qu2a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014671; c=relaxed/simple;
	bh=cgBmCHdRwUxF+qGn4iXkZ0PGffsChnB8Atnoh1RJ1qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RI83nnbINt2ZeL0OOX94eFcgXnvDvLJ137Ee1umKmzsR7ZiNOP6OofVbupPWwknygJOyHM4kaGkitWMM+V0pZn8gwLIFJT28wLXTSBVerO7LcYZBikO8gXkgKCjvOCCAIzOqEg2vTh7himYTPP3KaxaRSW6mtyoFhp4wcVRdRq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org; spf=pass smtp.mailfrom=isc.org; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=iRAUpXCf; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=iSZPtY5N; arc=pass smtp.client-ip=149.20.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isc.org
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id 26C663AB294;
	Fri, 30 Aug 2024 09:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org 26C663AB294
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725011819; cv=none; b=ccTJi2pfy/pZUC8zvZbDttdt+gd0ol4uLA4sRH9Si9dB9GikQ5/UzfTXNfK21kVEPWnYSjc6CgVT8cQeAmxoHEz5Y8kTObSanJIra+LP20H3ATW8L0RboU838nEvnkInGC4Nytysfi7o1ftlNHtjDuehn43i/Q8SO8YT+yUlKDo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725011819;
	c=relaxed/relaxed; bh=yQqeysRA7BvACQoikxWHOQ42EW7pELM6Da6x7deyM9I=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=NY0LbN0YhsFsDIiGNn+rhl4TS14bTNICMHaHLtOFP/0zi2eDKMuH1Xd5NcDPHZQZHJdy/TDZ5LAcm4+JhvbAKFvITbRrFQU0Q+N+Qa5/WdYxHBa+6dFjhCgLiWIMu7y7QwPd4dwTGR/+qZ8/91F5lkKVcwaI2b6TTzrcf/VJCig=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org 26C663AB294
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1725011819; bh=cgBmCHdRwUxF+qGn4iXkZ0PGffsChnB8Atnoh1RJ1qA=;
	h=From:To:Cc:Subject:Date;
	b=iRAUpXCfD0JG4nW9fZKuGzTR50zKk7hwIM7OLp8e72ljUlj0Jnq/GtyQwny1ckvz9
	 YqQgkeuhPb147lKylC/ib+N454DpEPgk490xwI5SVBE3qUb5DMcVQc6ED9dzZuzORg
	 Ym+htdQnMjlCrUus471W/7sbzI0pBQn+9dI/h5j8=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id 20EAA110BEEA;
	Fri, 30 Aug 2024 09:56:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id F3E8A110BEF4;
	Fri, 30 Aug 2024 09:56:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org F3E8A110BEF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1725011819;
	bh=yQqeysRA7BvACQoikxWHOQ42EW7pELM6Da6x7deyM9I=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=iSZPtY5NdSqXe8NyHXBMWQ5inf3T6xjGTbt68yBuwcZukf4fFDIl+XPjJQiIixpx1
	 lV3V3/6kUjaK/xUYEwoB5RBH2KSXGt4o8XNo5iyrUfY9KpGVkM3CFG3AE3M1M7KWHo
	 56tGgeqaXoA6f/YBkeRc4K7kWlLEYLFiOyqRlJpU=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id dkC6QH7jNJyl; Fri, 30 Aug 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [149.20.5.121])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 277E8110BEEA;
	Fri, 30 Aug 2024 09:56:58 +0000 (UTC)
From: Petr Spacek <pspacek@isc.org>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Petr Spacek <pspacek@isc.org>
Subject: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
Date: Fri, 30 Aug 2024 11:56:36 +0200
Message-ID: <20240830095636.572947-1-pspacek@isc.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Petr Spacek <pspacek@isc.org>

Raise default sysctl vm.max_map_count to INT_MAX, which effectively
disables the limit for all sane purposes. The sysctl is kept around in
case there is some use-case for this limit.

The old default value of vm.max_map_count=3D65530 provided compatibility
with ELF format predating year 2000 and with binutils predating 2010. At
the same time the old default caused issues with applications deployed
in 2024.

State since 2012: Linux 3.2.0 correctly generates coredump from a
process with 100 000 mmapped files. GDB 7.4.1, binutils 2.22 work with
this coredump fine and can actually read data from the mmaped addresses.

Signed-off-by: Petr Spacek <pspacek@isc.org>
---

Downstream distributions started to override the default a while ago.
Individual distributions are summarized at the end of this message:
https://lists.archlinux.org/archives/list/arch-dev-public@lists.archlinux=
.org/thread/5GU7ZUFI25T2IRXIQ62YYERQKIPE3U6E/

Please note it's not only games in emulator which hit this default
limit. Larger instances of server applications are also suffering from
this. Couple examples here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2057792/comments/24

SAP documentation behind paywall also mentions this limit:
https://service.sap.com/sap/support/notes/2002167

And finally, it is also an issue for BIND DNS server compiled against
jemalloc, which is what brought me here.

System V gABI draft dated 2000-07-17 already extended the ELF numbering:
https://www.sco.com/developers/gabi/2000-07-17/ch4.sheader.html

binutils support is in commit ecd12bc14d85421fcf992cda5af1d534cc8736e0
dated 2010-01-19. IIUC this goes a bit beyond what is described in the
gABI document and extends ELF's e_phnum.

Linux coredumper support is in commit
8d9032bbe4671dc481261ccd4e161cd96e54b118 dated 2010-03-06.

As mentioned above, this all works for the last 12 years and the
conservative limit seems to do more harm than good.

 include/linux/mm.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6549d0979..3e1ed3b80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -178,22 +178,19 @@ static inline void __mm_zero_struct_page(struct pag=
e *page)
=20
 /*
  * Default maximum number of active map areas, this limits the number of=
 vmas
- * per mm struct. Users can overwrite this number by sysctl but there is=
 a
- * problem.
+ * per mm struct. Users can overwrite this number by sysctl. Historicall=
y
+ * this limit was a compatibility measure for ELF format predating year =
2000.
  *
  * When a program's coredump is generated as ELF format, a section is cr=
eated
- * per a vma. In ELF, the number of sections is represented in unsigned =
short.
- * This means the number of sections should be smaller than 65535 at cor=
edump.
- * Because the kernel adds some informative sections to a image of progr=
am at
- * generating coredump, we need some margin. The number of extra section=
s is
- * 1-3 now and depends on arch. We use "5" as safe margin, here.
+ * per a vma. In ELF before year 2000, the number of sections was repres=
ented
+ * as unsigned short e_shnum. This means the number of sections should b=
e
+ * smaller than 65535 at coredump.
  *
- * ELF extended numbering allows more than 65535 sections, so 16-bit bou=
nd is
- * not a hard limit any more. Although some userspace tools can be surpr=
ised by
- * that.
+ * ELF extended numbering was added into System V gABI spec around 2000.
+ * It allows more than 65535 sections, so 16-bit bound is not a hard lim=
it any
+ * more.
  */
-#define MAPCOUNT_ELF_CORE_MARGIN	(5)
-#define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
+#define DEFAULT_MAX_MAP_COUNT	INT_MAX
=20
 extern int sysctl_max_map_count;
=20

base-commit: d5d547aa7b51467b15d9caa86b116f8c2507c72a
--=20
2.46.0


