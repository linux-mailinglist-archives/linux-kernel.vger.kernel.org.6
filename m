Return-Path: <linux-kernel+bounces-331160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D2497A946
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E736B1C22B41
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210E41547F8;
	Mon, 16 Sep 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lfiQ3rHe"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C51DFE1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526262; cv=none; b=PgY0apj0Nr9BHsaIvbzlZgppaUKo5DG+K+bdMtIck8eh0gx2bS3Tim6SgywoQ7/taBknsFyOXlU13LyTdS4HbDNW2ZWpddSr8QIHdIgpuUL1nxDnaCRZhJVr2dx7/9O9lqJ6deVDR1RKZ91cSVirHcOTWLmX4g7zpf7IUU+nNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526262; c=relaxed/simple;
	bh=hB8pyhfz3JL37n0ynJ8m12ZTp2lzXOkNsBgAphBIbQw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTUm2spRMLVohp3lbksstN57f5/VToVao6SZhmJe4YQZLwihG0ha6gad7nHwHzHSNiBnCUbqV8GxQP9GYhAgAaaKTSMR4fhO4yQ7fBxxXwJm+IGklT9GCJN6Q1yry5BTxy+2PxUpmt0eOVR0jaezaH2S+4dTJzNrk403lANmqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lfiQ3rHe; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726526251; x=1726785451;
	bh=VMWrgVfaE8EOR0/npbxIgIJMkAXl6DfVUEzfNnfMYk0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lfiQ3rHejcSzDd6oiaGRLmjS2GWkzQdtV6M91XFOgBT0Jv/5kZwKFyQnFl833neT8
	 QafltmFvnqE8lSPXWUA38e3cZDNlr3VPsFzJsTJX4dNIQsqxDuqFBVq2YhVlsO+2bw
	 fJZWA2JCXmlms2Xf8JwCsFSvu5SFwOhKh29wexfi7wgbLFwChp+xkF4X9ynfHYA9nC
	 cMBUWC75elzZzWPxwvaXIsJru1eusvdmXBlqcHVi9fFQ6Qe8FVhT4+UomkCu5Ucmze
	 6lg3uOL2L1zeJvJP0o1HTyKMCME5/tYV7CrEuOjNJsiIZTdg3tW5AI873Ezk4Q7kJL
	 vw10ta58oyFpg==
Date: Mon, 16 Sep 2024 22:37:24 +0000
To: syzbot <syzbot+6f655a60d3244d0c6718@syzkaller.appspotmail.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
Message-ID: <rVaWgPULej8K7HqMPNIu8kVNyXNjjCiTB-QBtItLFBmk0alH6fV2tk4joVPk97Evnuv4ZRDd8HB5uDCkiFG6u81xKdzDj-KrtIMJSlF6Kt8=@proton.me>
In-Reply-To: <66e57e46.050a0220.115905.0002.GAE@google.com>
References: <66e57e46.050a0220.115905.0002.GAE@google.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 1210da08731888fc4fceee61f6440e08d48729a8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

On Saturday, September 14th, 2024 at 2:15 PM, syzbot <syzbot+6f655a60d3244d=
0c6718@syzkaller.appspotmail.com> wrote:

> Hello,
>=20
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> kernel panic: corrupted stack end in x64_sys_call
>=20
> bucket 0:127 gen 0 has wrong data_type: got free, should be sb, fixing
> bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, should be=
 256, fixing
> done
> bcachefs (loop0): going read-write
> bcachefs (loop0): journal_replay...
> Kernel panic - not syncing: corrupted stack end detected inside scheduler
> CPU: 0 UID: 0 PID: 5945 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g=
57719771a244-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
> <TASK>
>=20
> __dump_stack lib/dump_stack.c:93 [inline]
> dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:119
> dump_stack+0x1e/0x30 lib/dump_stack.c:128
> panic+0x4e2/0xcd0 kernel/panic.c:354
> schedule_debug kernel/sched/core.c:5745 [inline]

The place where kernel task's stack magic number gets=20
smashed was found. Backtrace was presented below. Seems
like it is KMSAN's fault. Is this considered a bug?

```
Thread 1 hit Hardware watchpoint 15: *(unsigned long*)0xffff888112370000

Old value =3D 1470918301
New value =3D 18446744071600444244
kmsan_get_shadow_origin_ptr (address=3D<optimized out>, size=3D<optimized o=
ut>, store=3D<optimized out>) at mm/kmsan/shadow.c:83
83      {

(gdb) where

#0  kmsan_get_shadow_origin_ptr (address=3D<optimized out>, size=3D<optimiz=
ed out>, store=3D<optimized out>) at mm/kmsan/shadow.c:83
#1  0xffffffff82499354 in get_shadow_origin_ptr (addr=3D0xffff888112370110,=
 size=3D8, store=3Dfalse) at mm/kmsan/instrumentation.c:38
#2  __msan_metadata_ptr_for_load_8 (addr=3D0xffff888112370110) at mm/kmsan/=
instrumentation.c:94
#3  0xffffffff8194dfc9 in filter_irq_stacks (entries=3D<optimized out>, nr_=
entries=3D4) at kernel/stacktrace.c:397
#4  0xffffffff866d79cb in stack_depot_save_flags (entries=3D0xffff888112370=
110, nr_entries=3D8, alloc_flags=3D0, depot_flags=3D1) at lib/stackdepot.c:=
609
#5  0xffffffff866d8062 in stack_depot_save (entries=3D0xffff888112370110, n=
r_entries=3D8, alloc_flags=3D0) at lib/stackdepot.c:678
#6  0xffffffff82499c92 in __msan_poison_alloca (address=3D0xffff88811237020=
0, size=3D24, descr=3D<optimized out>) at mm/kmsan/instrumentation.c:286
#7  0xffffffff8fef8326 in sprintf (buf=3D0xffff8881123703b7 "", fmt=3D0xfff=
fffff910e22a3 "+%#lx/%#lx") at lib/vsprintf.c:3024
#8  0xffffffff81a1e08e in __sprint_symbol (buffer=3Dbuffer@entry=3D0xffff88=
81123703a0 "bch2_bucket_alloc_trans", address=3D<optimized out>, address@en=
try=3D18446744071649627845, symbol_offset=3Dsymbol_offset@entry=3D0, add_of=
fset=3Dadd_offset@entry=3D1, add_buildid=3D<optimized out>) at kernel/kalls=
yms.c:452
#9  0xffffffff81a1de7d in sprint_symbol (buffer=3D0xffff8881123703a0 "bch2_=
bucket_alloc_trans", address=3D18446744071649627845) at kernel/kallsyms.c:4=
84
#10 0xffffffff8ff0130d in symbol_string (buf=3Dbuf@entry=3D0xffff888121efe4=
36 "_MIN bch2", end=3Dend@entry=3D0xffff888121efe440 "\006", ptr=3Dptr@entr=
y=3D0xffffffff85380ec5 <bch2_bucket_alloc_trans+2085>, spec=3Dspec@entry=3D=
..., fmt=3Dfmt@entry=3D0xffffffff91194721 "S") at lib/vsprintf.c:1002
#11 0xffffffff8fef50b8 in pointer (fmt=3Dfmt@entry=3D0xffffffff91194721 "S"=
, buf=3Dbuf@entry=3D0xffff888121efe436 "_MIN bch2", end=3Dend@entry=3D0xfff=
f888121efe440 "\006", ptr=3Dptr@entry=3D0xffffffff85380ec5 <bch2_bucket_all=
oc_trans+2085>, spec=3Dspec@entry=3D...) at lib/vsprintf.c:2422
#12 0xffffffff8fef1b70 in vsnprintf (buf=3D0xffff888121efe435 " _MIN bch2",=
 size=3D11, fmt=3D0xffffffff91194721 "S", args=3D0xffff8881123708f0) at lib=
/vsprintf.c:2828
#13 0xffffffff8580676b in bch2_prt_printf (out=3D0xffff888112370b28, fmt=3D=
0xffffffff9119471e " %pS") at fs/bcachefs/printbuf.c:183
#14 0xffffffff8546d2c4 in bch2_btree_path_to_text_short (out=3Dout@entry=3D=
0xffff888112370b28, trans=3Dtrans@entry=3D0xffff888121ef0000, path_idx=3D5)=
 at fs/bcachefs/btree_iter.c:1485
#15 0xffffffff8ff58bf3 in __bch2_trans_paths_to_text (out=3Dout@entry=3D0xf=
fff888112370b28, trans=3Dtrans@entry=3D0xffff888121ef0000, nosort=3D<optimi=
zed out>) at fs/bcachefs/btree_iter.c:1540
#16 0xffffffff8ff58ae8 in bch2_trans_paths_to_text (out=3D0xffff888112370b2=
8, trans=3D0xffff888121ef0000) at fs/bcachefs/btree_iter.c:1548
#17 0xffffffff8ff59245 in bch2_trans_update_max_paths (trans=3Dtrans@entry=
=3D0xffff888121ef0000) at fs/bcachefs/btree_iter.c:1576
#18 0xffffffff8546fea7 in btree_path_alloc (trans=3Dtrans@entry=3D0xffff888=
121ef0000, pos=3D0) at fs/bcachefs/btree_iter.c:1673
#19 0xffffffff8546f02e in bch2_path_get (trans=3D0xffff888121ef0000, btree_=
id=3DBTREE_ID_alloc, pos=3D..., locks_want=3D0, level=3D0, flags=3D24640, i=
p=3D18446744071650896280) at fs/bcachefs/btree_iter.c:1723
#20 0xffffffff85496915 in bch2_trans_iter_init_common (trans=3D0xffff888121=
ef0000, iter=3D0xffff888112370f08, btree_id=3D4, pos=3D..., locks_want=3D0,=
 depth=3D0, flags=3D24640, ip=3D18446744071650896280) at fs/bcachefs/btree_=
iter.h:484
#21 bch2_trans_iter_init_outlined (trans=3D0xffff888121ef0000, iter=3D0xfff=
f888112370f08, btree_id=3DBTREE_ID_alloc, pos=3D..., flags=3D24576) at fs/b=
cachefs/btree_iter.c:2876
#22 0xffffffff854b6998 in bch2_trans_iter_init (trans=3D0xffff888121ef0000,=
 iter=3D0xffff888112370f08, btree_id=3D4, pos=3D..., flags=3D24576) at fs/b=
cachefs/btree_iter.h:502
#23 btree_key_cache_fill (trans=3Dtrans@entry=3D0xffff888121ef0000, ck_path=
=3Dck_path@entry=3D0xffff888121ef0420, flags=3Dflags@entry=3D32) at fs/bcac=
hefs/btree_key_cache.c:438
#24 0xffffffff854b634d in bch2_btree_path_traverse_cached (trans=3D0xffff88=
8121ef0000, path=3D0xffff888121ef0420, flags=3D32) at fs/bcachefs/btree_key=
_cache.c:504
#25 0xffffffff8545ff9f in bch2_btree_path_traverse_one (trans=3D0xffff88812=
1ef0000, path_idx=3D5, flags=3D32, trace_ip=3D18446744071649632148) at fs/b=
cachefs/btree_iter.c:1144
#26 0xffffffff8548e8bc in bch2_btree_path_traverse (trans=3D0xffff888121ef0=
000, path=3D5, flags=3D32) at fs/bcachefs/btree_iter.h:229
#27 bch2_btree_iter_peek_slot (iter=3D0xffff8881123718a8) at fs/bcachefs/bt=
ree_iter.c:2602
#28 0xffffffff85381f94 in __bch2_bkey_get_iter (trans=3D0xffff888121ef0000,=
 iter=3D0xffff8881123718a8, btree_id=3D4, pos=3D..., flags=3D32, type=3D0) =
at fs/bcachefs/btree_iter.h:551
#29 bch2_bkey_get_iter (trans=3D0xffff888121ef0000, iter=3D0xffff8881123718=
a8, btree_id=3D4, pos=3D..., flags=3D32) at fs/bcachefs/btree_iter.h:565
#30 try_alloc_bucket (trans=3D0xffff888121ef0000, ca=3D0xffff888116aac000, =
watermark=3DBCH_WATERMARK_btree, free_entry=3D25, s=3D0xffff8881123717f0, f=
reespace_k=3D..., cl=3D0x0 <fixed_percpu_data>) at fs/bcachefs/alloc_foregr=
ound.c:301
#31 bch2_bucket_alloc_freelist (trans=3D0xffff888121ef0000, ca=3D0xffff8881=
16aac000, watermark=3DBCH_WATERMARK_btree, s=3D0xffff8881123717f0, cl=3D0x0=
 <fixed_percpu_data>) at fs/bcachefs/alloc_foreground.c:521
#32 bch2_bucket_alloc_trans (trans=3Dtrans@entry=3D0xffff888121ef0000, ca=
=3Dca@entry=3D0xffff888116aac000, watermark=3DBCH_WATERMARK_btree, data_typ=
e=3DBCH_DATA_btree, cl=3D0x0 <fixed_percpu_data>, usage=3Dusage@entry=3D0xf=
fff888112371b50) at fs/bcachefs/alloc_foreground.c:643
#33 0xffffffff85386492 in bch2_bucket_alloc_set_trans (trans=3D0xffff888121=
ef0000, ptrs=3D0xffff8881123722e8, stripe=3D0xffff88811698ec68, devs_may_al=
loc=3D0xffff8881123720d0, nr_replicas=3D1, nr_effective=3D0xffff88811237239=
4, have_cache=3D0xffff88811237242f, flags=3D<optimized out>, data_type=3DBC=
H_DATA_btree, watermark=3DBCH_WATERMARK_btree, cl=3D0x0 <fixed_percpu_data>=
) at fs/bcachefs/alloc_foreground.c:804
#34 0xffffffff85399b83 in __open_bucket_add_buckets (trans=3Dtrans@entry=3D=
0xffff888121ef0000, ptrs=3D0xffff8881123722e8, wp=3D0xffff88811698ec00, dev=
s_have=3Ddevs_have@entry=3D0xffff888112372497, target=3Dtarget@entry=3D0, e=
rasure_code=3Dfalse, nr_replicas=3D1, nr_effective=3D0xffff888112372394, ha=
ve_cache=3D0xffff88811237242f, watermark=3DBCH_WATERMARK_btree, flags=3D0, =
_cl=3D0x0 <fixed_percpu_data>) at fs/bcachefs/alloc_foreground.c:1052
#35 0xffffffff8538c939 in open_bucket_add_buckets (trans=3Dtrans@entry=3D0x=
ffff888121ef0000, ptrs=3Dptrs@entry=3D0xffff8881123722e8, wp=3Dwp@entry=3D0=
xffff88811698ec00, devs_have=3Ddevs_have@entry=3D0xffff888112372497, target=
=3Dtarget@entry=3D0, erasure_code=3Derasure_code@entry=3D0, nr_replicas=3D1=
, nr_effective=3D0xffff888112372394, have_cache=3D0xffff88811237242f, water=
mark=3DBCH_WATERMARK_btree, flags=3D0, cl=3D0x0 <fixed_percpu_data>) at fs/=
bcachefs/alloc_foreground.c:1096
#36 0xffffffff8538b4c2 in bch2_alloc_sectors_start_trans (trans=3D0xffff888=
121ef0000, target=3D0, erasure_code=3D0, write_point=3D..., devs_have=3D0xf=
fff888112372497, nr_replicas=3D1, nr_replicas_required=3D1, watermark=3DBCH=
_WATERMARK_btree, flags=3D0, cl=3D0x0 <fixed_percpu_data>, wp_ret=3D0xffff8=
881123725d0) at fs/bcachefs/alloc_foreground.c:1404
#37 0xffffffff8554cdd2 in __bch2_btree_node_alloc (trans=3D0xffff888121ef00=
00, cl=3D0x0 <fixed_percpu_data>, interior_node=3Dfalse, res=3D<optimized o=
ut>, flags=3D<optimized out>) at fs/bcachefs/btree_update_interior.c:338
#38 bch2_btree_reserve_get (trans=3Dtrans@entry=3D0xffff888121ef0000, as=3D=
as@entry=3D0xffff88810e56e000, nr_nodes=3Dnr_nodes@entry=3D0xffff8881123727=
80, flags=3Dflags@entry=3D435, cl=3Dcl@entry=3D0x0 <fixed_percpu_data>) at =
fs/bcachefs/btree_update_interior.c:549
#39 0xffffffff8551d02a in bch2_btree_update_start (trans=3Dtrans@entry=3D0x=
ffff888121ef0000, path=3Dpath@entry=3D0xffff888121ef0200, level_start=3Dlev=
el_start@entry=3D0, split=3D<optimized out>, flags=3D<optimized out>, flags=
@entry=3D432) at fs/bcachefs/btree_update_interior.c:1247
#40 0xffffffff8551ac12 in bch2_btree_split_leaf (trans=3D0xffff888121ef0000=
, path=3D1, flags=3D432) at fs/bcachefs/btree_update_interior.c:1845
#41 0xffffffff854f660f in bch2_trans_commit_error (trans=3D0xffff888121ef00=
00, flags=3Dflags@entry=3D432, i=3Di@entry=3D0xffff888121ef2400, ret=3Dret@=
entry=3D-2203, trace_ip=3D18446744071651609665) at fs/bcachefs/btree_trans_=
commit.c:903
#42 0xffffffff854f1713 in __bch2_trans_commit (trans=3D0xffff888121ef0000, =
flags=3D432) at fs/bcachefs/btree_trans_commit.c:1135
#43 0xffffffff85564c41 in bch2_trans_commit (trans=3D0xffff888121ef0000, di=
sk_res=3D0x0 <fixed_percpu_data>, journal_seq=3D0x0 <fixed_percpu_data>, fl=
ags=3D432) at fs/bcachefs/btree_update.h:184
#44 wb_flush_one_slowpath (trans=3D0xffff888121ef0000, iter=3Diter@entry=3D=
0xffff888112372c88, wb=3Dwb@entry=3D0xffffc900088004b0) at fs/bcachefs/btre=
e_write_buffer.c:129
#45 0xffffffff8555a1fb in wb_flush_one (trans=3D0xffff888121ef0000, iter=3D=
0xffff888112372c88, wb=3D0xffffc900088004b0, write_locked=3D<optimized out>=
, accounting_accumulated=3D<optimized out>, fast=3D<optimized out>) at fs/b=
cachefs/btree_write_buffer.c:183
#46 bch2_btree_write_buffer_flush_locked (trans=3Dtrans@entry=3D0xffff88812=
1ef0000) at fs/bcachefs/btree_write_buffer.c:375
#47 0xffffffff85555c86 in btree_write_buffer_flush_seq (trans=3Dtrans@entry=
=3D0xffff888121ef0000, seq=3Dseq@entry=3D11) at fs/bcachefs/btree_write_buf=
fer.c:510
#48 0xffffffff855600d1 in bch2_btree_write_buffer_journal_flush (j=3D<optim=
ized out>, _pin=3D<optimized out>, seq=3D11) at fs/bcachefs/btree_write_buf=
fer.c:525
#49 0xffffffff857c285c in journal_flush_pins (j=3Dj@entry=3D0xffff8881169a6=
fc0, seq_to_flush=3Dseq_to_flush@entry=3D18446744073709551615, allowed_belo=
w_seq=3Dallowed_below_seq@entry=3D6, allowed_above_seq=3D0, min_any=3D0, mi=
n_key_cache=3Dmin_key_cache@entry=3D0) at fs/bcachefs/journal_reclaim.c:565
#50 0xffffffff857c0e1d in journal_flush_done (j=3Dj@entry=3D0xffff8881169a6=
fc0, seq_to_flush=3Dseq_to_flush@entry=3D18446744073709551615, did_work=3Dd=
id_work@entry=3D0xffff888112373327) at fs/bcachefs/journal_reclaim.c:818
#51 0xffffffff857c0c2d in bch2_journal_flush_pins (j=3D0xffff8881169a6fc0, =
seq_to_flush=3D18446744073709551615) at fs/bcachefs/journal_reclaim.c:851
#52 0xffffffff85826851 in bch2_journal_flush_all_pins (j=3D0xffff8881169a6f=
c0) at fs/bcachefs/journal_reclaim.h:76
#53 bch2_journal_replay (c=3D0xffff888116980000) at fs/bcachefs/recovery.c:=
383
#54 0xffffffff85836243 in bch2_run_recovery_pass (c=3D0xffff888116980000, p=
ass=3DBCH_RECOVERY_PASS_journal_replay) at fs/bcachefs/recovery_passes.c:18=
3
#55 bch2_run_recovery_passes (c=3D0xffff888116980000) at fs/bcachefs/recove=
ry_passes.c:230
#56 0xffffffff8582c99a in bch2_fs_recovery (c=3D0xffff888116980000) at fs/b=
cachefs/recovery.c:859
#57 0xffffffff858b5f56 in bch2_fs_start (c=3D0xffff888116980000) at fs/bcac=
hefs/super.c:1036
#58 0xffffffff8567507e in bch2_fs_get_tree (fc=3D0xffff88815d061600) at fs/=
bcachefs/fs.c:1946
#59 0xffffffff82632873 in vfs_get_tree (fc=3D0xffff88815d061600) at fs/supe=
r.c:1800
#60 0xffffffff8271cd6e in do_new_mount (path=3Dpath@entry=3D0xffff888112373=
d90, fstype=3Dfstype@entry=3D0xffff888116ac8b00 "bcachefs", sb_flags=3Dsb_f=
lags@entry=3D0, mnt_flags=3Dmnt_flags@entry=3D32, name=3Dname@entry=3D0xfff=
f888116ac8b10 "/dev/loop0", data=3Ddata@entry=3D0xffff88815d37b000) at fs/n=
amespace.c:3472
#61 0xffffffff82719e93 in path_mount (dev_name=3D0xffff888116ac8b10 "/dev/l=
oop0", path=3D0xffff888112373d90, type_page=3D0xffff888116ac8b00 "bcachefs"=
, flags=3D<optimized out>, data_page=3D0xffff88815d37b000) at fs/namespace.=
c:3799
#62 0xffffffff827215d3 in do_mount (dev_name=3D0xffff888116ac8b10 "/dev/loo=
p0", dir_name=3D0x20005900 "./file0", type_page=3D0xffff888116ac8b00 "bcach=
efs", flags=3D0, data_page=3D0xffff88815d37b000) at fs/namespace.c:3812
#63 __do_sys_mount (type=3D<optimized out>, dev_name=3D<optimized out>, dir=
_name=3D<optimized out>, flags=3D<optimized out>, data=3D<optimized out>) a=
t fs/namespace.c:4020
#64 __se_sys_mount (dev_name=3Ddev_name@entry=3D140734779799792, dir_name=
=3Ddir_name@entry=3D536893696, type=3Dtype@entry=3D536893632, flags=3Dflags=
@entry=3D0, data=3Ddata@entry=3D140734779799856) at fs/namespace.c:3997
#65 0xffffffff82720e24 in __x64_sys_mount (regs=3D0xffff888112373f58) at fs=
/namespace.c:3997
#66 0xffffffff81009251 in x64_sys_call (regs=3D0xffff888112373f58, nr=3D165=
) at ./arch/x86/include/generated/asm/syscalls_64.h:166
#67 0xffffffff8ff838d9 in do_syscall_x64 (regs=3D0xffff888112373f58, nr=3D1=
65) at arch/x86/entry/common.c:52
#68 do_syscall_64 (regs=3D0xffff888112373f58, nr=3D165) at arch/x86/entry/c=
ommon.c:83
#69 0xffffffff90000130 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:=
121
#70 0x00007f7e7e0dca80 in ?? ()
#71 0x00005596cb52a242 in ?? ()
#72 0x00007fff5e8ebbc8 in ?? ()
#73 0x00007fff5e8ebbb8 in ?? ()
#74 0x00007fff5e8eba40 in ?? ()
#75 0x00005596cb531dd8 in ?? ()
#76 0x0000000000000202 in ?? ()
#77 0x0000000000000000 in ?? ()
```

Best Regards, Piotr Zalewski




