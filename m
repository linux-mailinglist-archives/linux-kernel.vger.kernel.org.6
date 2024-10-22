Return-Path: <linux-kernel+bounces-375885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2E9A9C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78A61F2355A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C61161310;
	Tue, 22 Oct 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HKXJiNOa"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF781591E8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585395; cv=none; b=hL/UWcay7LYAWE14bVa/2ptFF+AynHy/JMiN9N+hJdV4QY/Ovjzd3bjCeb5ifz3+m1/CjU75C5nYuS5IoOWE50/66yjr/nM38PJy308rebfqStrgnu1vqAlsIVM1Z8uQyIty616shCAnUxTi1BStltnM9TcF1IK62eMublw0B8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585395; c=relaxed/simple;
	bh=YfbdErdVQz0w8vjus6Ha1KuUSHWrwEpIKNnwOncC17k=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=OiaYSLmIhOi/1Kh+nnggaJw81gkSFD7mJSTCWXngd9DJdW6aiB1AyJC+7gEpU5Pn4LMIbQLElbwnZ+UQm6OhDT7CuDqyitCUv6SjXo3J3tG156VvL6jgYQ40sgbnp7FinjFAv4cRvE/oWxa8hpjtr6vMJGl3L1IkZCDjdnXGSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HKXJiNOa; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241022082303epoutp0130a29bd20f2eeba3151ce9c32e8d9944~AuL4fZSMw1351713517epoutp01_
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241022082303epoutp0130a29bd20f2eeba3151ce9c32e8d9944~AuL4fZSMw1351713517epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729585383;
	bh=YfbdErdVQz0w8vjus6Ha1KuUSHWrwEpIKNnwOncC17k=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=HKXJiNOa6K5aeMcrUaqFJa5qMT66UmEUTCBA8UK8DBE+wswul3QdmB6eP8lcuszgL
	 CCH9RxoPY5T3sg4B65bhz+zQQwWss36TPoTsdZikcBWBPrcX26+llS9OELDzX78leq
	 wR0nd+NtTqnud0xM0mbIncvB89onWL4+F+XLnklc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241022082303epcas2p261f2be3261f88b996418ff39793513d0~AuL4AfqwA1512915129epcas2p2T;
	Tue, 22 Oct 2024 08:23:03 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XXlYL3Zz5z4x9Ps; Tue, 22 Oct
	2024 08:23:02 +0000 (GMT)
X-AuditID: b6c32a48-84fb870000002653-04-671760e63b0e
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.87.09811.6E067176; Tue, 22 Oct 2024 17:23:02 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadlock in
 f2fs_record_stop_reason()
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: "chao@kernel.org" <chao@kernel.org>, "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>
CC: "syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com"
	<syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, Daejun Park
	<daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241022082201epcms2p4709ba723c9ba274b3a8cd128a99e0463@epcms2p4>
Date: Tue, 22 Oct 2024 17:22:01 +0900
X-CMS-MailID: 20241022082201epcms2p4709ba723c9ba274b3a8cd128a99e0463
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe6zBPF0g8YdYhanp55lsnh5SNNi
	1YNwiyfrZzFbXFrkbnF51xw2i7+7brA5sHtsWtXJ5rF7wWcmj74tqxg9Zr5V8/i8SS6ANSrb
	JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoBCWFssSc
	UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaF
	u1NZC9ZXVjz68Zi9gXF6WRcjB4eEgInEvr2pXYxcHEICOxglju3/xAYS5xUQlPi7Q7iLkZND
	WCBFYm73JUYQW0hASWL9xVnsEHE9iVsP14DF2QR0JKafuA8WFxEIkWi628QGMpNZYDuTxM3m
	v8wgCQkBXokZ7U9ZIGxpie3LtzJC2BoSP5b1QtWIStxc/ZYdxn5/bD5UjYhE672zUDWCEg9+
	7oaKS0rcnrsJqj5f4v+V5VB2jcS2A/OgbH2Jax0bWSD+8pW4cqwIxGQRUJXY/UwFosJF4knH
	ZlYQm1lAW2LZwtfMICXMApoS63fpQwJKWeLILRaICj6JjsN/2WF+atj4Gyt7x7wnTBC2msS6
	n+uZIMbISNyaxziBUWkWIpRnIVk7C2HtAkbmVYxiqQXFuempxUYFJvB4Tc7P3cQITohaHjsY
	Z7/9oHeIkYmD8RCjBAezkgivUolouhBvSmJlVWpRfnxRaU5q8SFGU6B/JzJLiSbnA1NyXkm8
	oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTPsKlM9vPtUf5KTOpTzX
	SSa5dKZN0zV38QXWx8WnGLv53orO3L3dMXarxX2mzcfndf1qy3ScIPhRT+7Y1tVu702jjx/0
	4X8nvpXzxSc1i+3KvqcaxVzTMxgL9s+WrNsifvFH1oJ7el1T8s8oCuxoct+9SUva+qHK20Pq
	s9k1J+5Ldc3/+43Lr0mv8N5xi9UHnZfzn9hrUfUncL1/8t/cKf8N7M/vy12itFR/ZoWh+NRH
	f9PrGxzazjpJu7JkZT/buvFvQuS/jRN585Nuz/txIZ9tbebJj/dabyh9PSPQePRgmr61Yf+X
	Lb1zfwS2BTl8mySwyOxu+fR7/muOc+YdPMUpsln8SMpx2aXe379eDFRiKc5INNRiLipOBACp
	GnlSEQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241022062159epcas2p30650063ebb022cd51a581d2df44a630f
References: <CGME20241022062159epcas2p30650063ebb022cd51a581d2df44a630f@epcms2p4>

Hi Chao Yu,


>=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A>Sender=20:=
=20Chao=20Yu=20via=20Linux-f2fs-devel=20<linux-f2fs-devel=40lists.sourcefor=
ge.net>=0D=0A>Date=20:=202024-10-22=2015:21=20(GMT+9)=0D=0A>Title=20:=20=5B=
f2fs-dev=5D=20=5BPATCH=5D=20f2fs:=20fix=20to=20avoid=20potential=20deadlock=
=20in=20f2fs_record_stop_reason()=0D=0A>=C2=A0=0D=0A>syzbot=20reports=20dea=
dlock=20issue=20of=20f2fs=20as=20below:=0D=0A>=0D=0A>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>WA=
RNING:=20possible=20circular=20locking=20dependency=20detected=0D=0A>6.12.0=
-rc3-syzkaller-00087-gc964ced77262=20=230=20Not=20tainted=0D=0A>-----------=
-------------------------------------------=0D=0A>kswapd0/79=20is=20trying=
=20to=20acquire=20lock:=0D=0A>ffff888011824088=20(&sbi->sb_lock)=7B++++=7D-=
=7B3:3=7D,=20at:=20f2fs_down_write=20fs/f2fs/f2fs.h:2199=20=5Binline=5D=0D=
=0A>ffff888011824088=20(&sbi->sb_lock)=7B++++=7D-=7B3:3=7D,=20at:=20f2fs_re=
cord_stop_reason+0x52/0x1d0=20fs/f2fs/super.c:4068=0D=0A>=0D=0A>but=20task=
=20is=20already=20holding=20lock:=0D=0A>ffff88804bd92610=20(sb_internal=232=
)=7B.+.+=7D-=7B0:0=7D,=20at:=20f2fs_evict_inode+0x662/0x15c0=20fs/f2fs/inod=
e.c:842=0D=0A>=0D=0A>which=20lock=20already=20depends=20on=20the=20new=20lo=
ck.=0D=0A>=0D=0A>the=20existing=20dependency=20chain=20(in=20reverse=20orde=
r)=20is:=0D=0A>=0D=0A>->=20=232=20(sb_internal=232)=7B.+.+=7D-=7B0:0=7D:=0D=
=0A>=C2=A0=20=C2=A0=20=C2=A0=20lock_acquire+0x1ed/0x550=20kernel/locking/lo=
ckdep.c:5825=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20percpu_down_read=20include/li=
nux/percpu-rwsem.h:51=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20__sb_=
start_write=20include/linux/fs.h:1716=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=
=20=C2=A0=20sb_start_intwrite+0x4d/0x1c0=20include/linux/fs.h:1899=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20f2fs_evict_inode+0x662/0x15c0=20fs/f2fs/inode.c:=
842=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20evict+0x4e8/0x9b0=20fs/inode.c:725=0D=
=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_evict_inode+0x1a4/0x15c0=20fs/f2fs/inod=
e.c:807=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20evict+0x4e8/0x9b0=20fs/inode.c:725=
=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20dispose_list=20fs/inode.c:774=20=5Binline=
=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20prune_icache_sb+0x239/0x2f0=20fs/inode=
.c:963=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20super_cache_scan+0x38c/0x4b0=20fs/s=
uper.c:223=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20do_shrink_slab+0x701/0x1160=20m=
m/shrinker.c:435=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20shrink_slab+0x1093/0x14d0=
=20mm/shrinker.c:662=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20shrink_one+0x43b/0x85=
0=20mm/vmscan.c:4818=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20shrink_many=20mm/vmsc=
an.c:4879=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20lru_gen_shrink_no=
de=20mm/vmscan.c:4957=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20shrin=
k_node+0x3799/0x3de0=20mm/vmscan.c:5937=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20ks=
wapd_shrink_node=20mm/vmscan.c:6765=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=
=C2=A0=20balance_pgdat=20mm/vmscan.c:6957=20=5Binline=5D=0D=0A>=C2=A0=20=C2=
=A0=20=C2=A0=20kswapd+0x1ca3/0x3700=20mm/vmscan.c:7226=0D=0A>=C2=A0=20=C2=
=A0=20=C2=A0=20kthread+0x2f0/0x390=20kernel/kthread.c:389=0D=0A>=C2=A0=20=
=C2=A0=20=C2=A0=20ret_from_fork+0x4b/0x80=20arch/x86/kernel/process.c:147=
=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20ret_from_fork_asm+0x1a/0x30=20arch/x86/en=
try/entry_64.S:244=0D=0A>=0D=0A>->=20=231=20(fs_reclaim)=7B+.+.=7D-=7B0:0=
=7D:=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20lock_acquire+0x1ed/0x550=20kernel/loc=
king/lockdep.c:5825=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20__fs_reclaim_acquire=
=20mm/page_alloc.c:3834=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20fs_=
reclaim_acquire+0x88/0x130=20mm/page_alloc.c:3848=0D=0A>=C2=A0=20=C2=A0=20=
=C2=A0=20might_alloc=20include/linux/sched/mm.h:318=20=5Binline=5D=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20prepare_alloc_pages+0x147/0x5b0=20mm/page_alloc.=
c:4493=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20__alloc_pages_noprof+0x16f/0x710=20=
mm/page_alloc.c:4722=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20alloc_pages_mpol_nopr=
of+0x3e8/0x680=20mm/mempolicy.c:2265=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20alloc=
_pages_noprof=20mm/mempolicy.c:2345=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=
=C2=A0=20folio_alloc_noprof+0x128/0x180=20mm/mempolicy.c:2352=0D=0A>=C2=A0=
=20=C2=A0=20=C2=A0=20filemap_alloc_folio_noprof+0xdf/0x500=20mm/filemap.c:1=
010=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20do_read_cache_folio+0x2eb/0x850=20mm/f=
ilemap.c:3787=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20read_mapping_folio=20include=
/linux/pagemap.h:1011=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_=
commit_super+0x3c0/0x7d0=20fs/f2fs/super.c:4032=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20f2fs_record_stop_reason+0x13b/0x1d0=20fs/f2fs/super.c:4079=0D=0A>=C2=
=A0=20=C2=A0=20=C2=A0=20f2fs_handle_critical_error+0x2ac/0x5c0=20fs/f2fs/su=
per.c:4174=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_write_inode+0x35f/0x4d0=20=
fs/f2fs/inode.c:785=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20write_inode=20fs/fs-wr=
iteback.c:1503=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20__writeback_=
single_inode+0x711/0x10d0=20fs/fs-writeback.c:1723=0D=0A>=C2=A0=20=C2=A0=20=
=C2=A0=20writeback_single_inode+0x1f3/0x660=20fs/fs-writeback.c:1779=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20sync_inode_metadata+0xc4/0x120=20fs/fs-writeback=
.c:2849=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_release_file+0xa8/0x100=20fs/=
f2fs/file.c:1941=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20__fput+0x23f/0x880=20fs/f=
ile_table.c:431=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20task_work_run+0x24f/0x310=
=20kernel/task_work.c:228=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20resume_user_mode=
_work=20include/linux/resume_user_mode.h:50=20=5Binline=5D=0D=0A>=C2=A0=20=
=C2=A0=20=C2=A0=20exit_to_user_mode_loop=20kernel/entry/common.c:114=20=5Bi=
nline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20exit_to_user_mode_prepare=20inclu=
de/linux/entry-common.h:328=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=
=20__syscall_exit_to_user_mode_work=20kernel/entry/common.c:207=20=5Binline=
=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20syscall_exit_to_user_mode+0x168/0x370=
=20kernel/entry/common.c:218=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20do_syscall_64=
+0x100/0x230=20arch/x86/entry/common.c:89=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=
entry_SYSCALL_64_after_hwframe+0x77/0x7f=0D=0A>=0D=0A>->=20=230=20(&sbi->sb=
_lock)=7B++++=7D-=7B3:3=7D:=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20check_prev_add=
=20kernel/locking/lockdep.c:3161=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20check_prevs_add=20kernel/locking/lockdep.c:3280=20=5Binline=5D=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20validate_chain+0x18ef/0x5920=20kernel/locking/lo=
ckdep.c:3904=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20__lock_acquire+0x1384/0x2050=
=20kernel/locking/lockdep.c:5202=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20lock_acqu=
ire+0x1ed/0x550=20kernel/locking/lockdep.c:5825=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20down_write+0x99/0x220=20kernel/locking/rwsem.c:1577=0D=0A>=C2=A0=20=
=C2=A0=20=C2=A0=20f2fs_down_write=20fs/f2fs/f2fs.h:2199=20=5Binline=5D=0D=
=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_record_stop_reason+0x52/0x1d0=20fs/f2fs=
/super.c:4068=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_handle_critical_error+0=
x2ac/0x5c0=20fs/f2fs/super.c:4174=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs_evi=
ct_inode+0xa61/0x15c0=20fs/f2fs/inode.c:883=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=
=20evict+0x4e8/0x9b0=20fs/inode.c:725=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20f2fs=
_evict_inode+0x1a4/0x15c0=20fs/f2fs/inode.c:807=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20evict+0x4e8/0x9b0=20fs/inode.c:725=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20d=
ispose_list=20fs/inode.c:774=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=
=20prune_icache_sb+0x239/0x2f0=20fs/inode.c:963=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20super_cache_scan+0x38c/0x4b0=20fs/super.c:223=0D=0A>=C2=A0=20=C2=A0=
=20=C2=A0=20do_shrink_slab+0x701/0x1160=20mm/shrinker.c:435=0D=0A>=C2=A0=20=
=C2=A0=20=C2=A0=20shrink_slab+0x1093/0x14d0=20mm/shrinker.c:662=0D=0A>=C2=
=A0=20=C2=A0=20=C2=A0=20shrink_one+0x43b/0x850=20mm/vmscan.c:4818=0D=0A>=C2=
=A0=20=C2=A0=20=C2=A0=20shrink_many=20mm/vmscan.c:4879=20=5Binline=5D=0D=0A=
>=C2=A0=20=C2=A0=20=C2=A0=20lru_gen_shrink_node=20mm/vmscan.c:4957=20=5Binl=
ine=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20shrink_node+0x3799/0x3de0=20mm/vmsc=
an.c:5937=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20kswapd_shrink_node=20mm/vmscan.c=
:6765=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20balance_pgdat=20mm/vm=
scan.c:6957=20=5Binline=5D=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20kswapd+0x1ca3/0=
x3700=20mm/vmscan.c:7226=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20kthread+0x2f0/0x3=
90=20kernel/kthread.c:389=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20ret_from_fork+0x=
4b/0x80=20arch/x86/kernel/process.c:147=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20re=
t_from_fork_asm+0x1a/0x30=20arch/x86/entry/entry_64.S:244=0D=0A>=0D=0A>othe=
r=20info=20that=20might=20help=20us=20debug=20this:=0D=0A>=0D=0A>Chain=20ex=
ists=20of:=0D=0A>=C2=A0=20&sbi->sb_lock=20-->=20fs_reclaim=20-->=20sb_inter=
nal=232=0D=0A>=0D=0A>Possible=20unsafe=20locking=20scenario:=0D=0A>=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20CPU0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20CPU1=0D=0A>=C2=A0=20=C2=A0=
=20=C2=A0=20----=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20----=0D=0A>=C2=A0=20rlock(sb_internal=232)=
;=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20lock(f=
s_reclaim);=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20lock(sb_internal=232);=0D=0A>=C2=A0=20lock(&sbi->sb_lock);=0D=0A>=0D=0A>=
Root=20cause=20is=20there=20will=20be=20potential=20deadlock=20in=20between=
=0D=0A>below=20tasks:=0D=0A>=0D=0A>Thread=20A=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Kswapd=0D=0A>-=20f2fs_ioc_commit_ato=
mic_write=0D=0A>-=20mnt_want_write_file=20--=20down_read=20lock=20A=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0-=20balance_pgdat=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20-=20__fs_reclaim_acquire=C2=A0=20--=20lock=20B=0D=0A>=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=C2=A0=20-=20shrink_node=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=
=A0=20-=20prune_icache_sb=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=
=20-=20dispose_list=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20-=
=20f2fs_evict_inode=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=
=A0=20-=20sb_start_intwrite=C2=A0=20--=20down_read=20lock=20A=0D=0A>-=20f2f=
s_do_sync_file=0D=0A>=C2=A0=20-=20f2fs_write_inode=0D=0A>=C2=A0=20-=20f2fs_=
handle_critical_error=0D=0A>=C2=A0=20=C2=A0=20-=20f2fs_record_stop_reason=
=0D=0A>=C2=A0=20=C2=A0=20-=20f2fs_commit_super=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20-=20read_mapping_folio=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20-=20filemap_a=
lloc_folio_noprof=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20-=20fs_reclaim_=
acquire=C2=A0=20--=20lock=20B=0D=0A>=0D=0A>Both=20threads=20try=20to=20acqu=
ire=20read=20lock=20of=20lock=20A,=20then=20its=20upcoming=20write=0D=0A>lo=
ck=20grabber=20will=20trigger=20deadlock.=0D=0A>=0D=0A>Let's=20always=20cre=
ate=20an=20asynchronous=20task=20in=20f2fs_handle_critical_error()=0D=0A>ra=
ther=20than=20calling=20f2fs_record_stop_reason()=20synchronously=20to=20av=
oid=0D=0A>this=20potential=20deadlock=20issue.=0D=0A>=0D=0A>Fixes:=20b62e71=
be2110=20(=22f2fs:=20support=20errors=3Dremount-rocontinuepanic=20mountopti=
on=22)=0D=0A>Reported-by:=20syzbot+be4a9983e95a5e25c8d3=40syzkaller.appspot=
mail.com=0D=0A>Closes:=20https://lore.kernel.org/all/6704d667.050a0220.1e4d=
62.0081.GAE=40google.com=0D=0A>Signed-off-by:=20Chao=20Yu=20<chao=40kernel.=
org>=0D=0A>---=0D=0A>fs/f2fs/super.c=2010=20++++++----=0D=0A>1=20file=20cha=
nged,=206=20insertions(+),=204=20deletions(-)=0D=0A>=0D=0A>diff=20--git=20a=
/fs/f2fs/super.c=20b/fs/f2fs/super.c=0D=0A>index=209325d8dc7f7d..21d6fb6017=
1a=20100644=0D=0A>---=20a/fs/f2fs/super.c=0D=0A>+++=20b/fs/f2fs/super.c=0D=
=0A>=40=40=20-4174,10=20+4174,12=20=40=40=20void=20f2fs_handle_critical_err=
or(struct=20f2fs_sb_info=20*sbi,=20unsigned=20char=20reason,=0D=0A>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21f2fs_hw_is_readonly(sbi))=20=
=7B=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0save_stop_reason(sbi,=20reason);=0D=0A>=0D=0A>-=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(irq_conte=
xt=20&&=20=21shutdown)=0D=0A=0D=0AI=20think=20the=20irq_context=20parameter=
=20can=20be=20removed=20from=20f2fs_handle_critical_error().=0D=0A=0D=0ATha=
nks,=0D=0ADaejun=0D=0A=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0schedule_wor=
k(&sbi->s_error_work);=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0else=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0f2f=
s_record_stop_reason(sbi);=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20always=20create=20an=20asy=
nchronous=20task=20to=20record=20stop_reason=0D=0A>+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20in=20order=20to=
=20avoid=20potential=20deadlock=20when=20running=20into=0D=0A>+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20f2fs_rec=
ord_stop_reason()=20synchronously.=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*/=0D=0A>+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0schedule_work(&sbi->s_er=
ror_work);=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=0D=0A=
>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=0D=0A>--=0D=0A>2.40.1=0D=0A>=
=0D=0A>=0D=0A>=0D=0A>_______________________________________________=0D=0A>=
Linux-f2fs-devel=20mailing=20list=0D=0A>Linux-f2fs-devel=40lists.sourceforg=
e.net=0D=0A>https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

