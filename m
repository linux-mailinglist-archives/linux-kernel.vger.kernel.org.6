Return-Path: <linux-kernel+bounces-291650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF4956531
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EB11C21718
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB313E03E;
	Mon, 19 Aug 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WZMFY9Fs"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1FA41
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054794; cv=none; b=rsugYoRpLVHsD8Z/Muj5lKfaL7mXoQg2mcYC/f/vQk9jHhQWkZNKh/QlogAB9lxIi1cD6qDpWuV4rnfqVGI5b470MoWvPSx0dJylEKhsIsnnC0XbvrsDPaAaJQTNtqKXtn6r1xQ+ZvyWKKl+7mIhbZu55wSebg4rmynpF0ci7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054794; c=relaxed/simple;
	bh=QrhkplzZ3C1wQsKojQLSkMO9AP8r2EkZYjP5r4HsDwg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ecvQlNgu3Vg1uD/KHkwsM4cNz7k6QoJZ9cyDfsTESTzcFisRi9hGX+/yAI0Y08cSgcSO2ALwwaAbIsWN5TCBvqDzwMzNsYHp/d4ZJFsbH52D8gWa9Bed9ytY4E9nA3QIyYPLP/TFsFjxhpR96q5OXg5KvD2XUEUzRjy5TQkfcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WZMFY9Fs; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724054788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGKlfmVH3LtzPnGo4UI3D1e5HnpdM5cATPN6KN5WYuo=;
	b=WZMFY9FsjKIVqUC/CRbiorNOiNC+loMz1N+EbLC2aIU5q84BYb/2rfyLzwwBCa6Ycls+gv
	6un6CeNucq7NwI9ArNkVjbj6vgEvRSaZ6PULDGvIEfYa0hI8jFhnKOs4l502Gin4DIgX+b
	sCiK/CoqoVT9PaeML70C7QnZ0MUfhz4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in folio_memcg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0000000000006f7e4d0620042b96@google.com>
Date: Mon, 19 Aug 2024 16:05:41 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <songmuchun@bytedance.com>,
 syzkaller-bugs@googlegroups.com,
 Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2518F6C-7652-4AE5-AE57-39380E79932D@linux.dev>
References: <0000000000006f7e4d0620042b96@google.com>
To: syzbot <syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 19, 2024, at 15:22, syzbot =
<syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    367b5c3d53e5 Add linux-next specific files for =
20240816
> git tree:       linux-next
> console+strace: =
https://syzkaller.appspot.com/x/log.txt?x=3D11be396b980000
> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee5467
> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3Def4ecf7b6bdc4157bfa4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40
> syz repro:      =
https://syzkaller.appspot.com/x/repro.syz?x=3D147469f5980000
> C reproducer:   =
https://syzkaller.appspot.com/x/repro.c?x=3D153c5ad5980000
>=20
> Downloadable assets:
> disk image: =
https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.ra=
w.xz
> vmlinux: =
https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d=
.xz
> kernel image: =
https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d=
.xz
>=20
> The issue was bisected to:
>=20
> commit ebadc95608dc3ee87ad4e5dc4f2c665c709bb899
> Author: Muchun Song <songmuchun@bytedance.com>
> Date:   Wed Aug 14 09:34:15 2024 +0000
>=20
>    mm: kmem: add lockdep assertion to obj_cgroup_memcg
>=20
> bisection log:  =
https://syzkaller.appspot.com/x/bisect.txt?x=3D170875f5980000
> final oops:     =
https://syzkaller.appspot.com/x/report.txt?x=3D148875f5980000
> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D108875f5980000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> Reported-by: syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com

Thanks for your report. I've fixed this in patch [1].

[1] =
https://lore.kernel.org/linux-mm/20240819080415.44964-1-songmuchun@bytedan=
ce.com/T/#u


