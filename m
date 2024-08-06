Return-Path: <linux-kernel+bounces-276654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343BB949698
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178451C22A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9B54656;
	Tue,  6 Aug 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRMQvc2Y"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F81482E2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964844; cv=none; b=a5PJ6eJ3Jqh5GNI8Z4uF7GEVuyjp1yzyAFCwzdDInK1G4TFuvyb2nDpdPGDq5n9kBaDUktH6Gg6ZaQCWgsxQ9vHjUJcATeyog0Z4V2joQQ18DiSNoJtGychNbgxmO5ekyF2qgFq/7mQyKMFIXeqT/cXddKRrPWY9pI8Gbni9yqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964844; c=relaxed/simple;
	bh=FOMRHYZUaXpnXwhSzs+UdxsZKLdmJb/HKJt8UcD9VdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnNaWJPAAzmaixVpTxB/yW12A47WKL19ONxn1/Q9icpGeKsdjJSQokdjZaptSIhCAn5mUfaC7D9klVMvNygiDPNJyIOoWJl+ynw2ZOLjrIVysXt+oGFpXI0CtTrmwSnd1dmtIfBexPzwvsxWrXCgYGmywmU9wM7XVRaYlrZR55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRMQvc2Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso687891b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722964841; x=1723569641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfkvQzkVnvdLU4Xnhiiu+GcPymivnWdb4ilIrpYhYdA=;
        b=nRMQvc2YCBMT5FQXLmQ12XrZjf0i/vhX/UpF+xshdfVF4Z3wl4ieTLP34VXLQBLAAV
         pmdoe/dpbxwrPUp4mdj0DXuSlLh3hJnEe7pr4LpPvfz8YS9es8qiaCZ9oy1cfLlBHQD2
         zsh89wHIErh0qjqOD273XnDBYREda89Sa7gZ3xkFTb6MELMReVR9Dw2Iv8ottZcuYl49
         D+KIDXESR1oV7r7reMAOVpyjtx9judCfC1SOKrMRGLePkvsR3uoF6FCSha7jVHZw4s05
         ztwGeTh0l6QVRUnHorguEZVoV1yHEUlhvS8jvS86oxjPriWCW5vz3/4xyFw1X4S1KnVF
         QLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964841; x=1723569641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfkvQzkVnvdLU4Xnhiiu+GcPymivnWdb4ilIrpYhYdA=;
        b=USjB1xi0px2U2NTfcU0GRTg4WzUNaP8c2df9Qc1EXAz0d+1/bxeYlVUyFbf7qK80UG
         h2N4lCd4ua2YOevsd9/FI59YnZpeiriLLy/AgaMGn4tOnV01+M7S2UVaVhUVC455FNfd
         eOd7xqqCd913rT41CL7XMXrDbzQmuDIYOKwS3WynjpSdvJL+LK6MCkmkODopD6XynuWA
         U9nUoZDQrl1NP0zfUzWlQyCvpdG822N3cZXCAmWdIzO/Pa+fkLBmPhWSOfjN/ADW8fDf
         MDTaj0C6KyLoWowlfp2nzUCiIJ4MMNIehURZvKZcPYjnwmxfqO+QG/rzM4so0cSEy1x8
         FR8g==
X-Forwarded-Encrypted: i=1; AJvYcCUz8QYb6AD97SwvSSlAVDgJZoJoE0YwYzIwYd3pEpPRuHsLnAKB5pPM1vpqzaob/vzmZM73FDhVo9WPEoGH/ha0J+ObKVtl4tuMOpMj
X-Gm-Message-State: AOJu0YwK4fJrGSg9ssV3OITMSzn0wQtaywZcAOvIT8NTfQme9W1KShAv
	TDNQYvQINTqc+Tgv1PvqScK4uJ7gCzpMii1PMtN9svTqZU5ZXK8j
X-Google-Smtp-Source: AGHT+IHOsMfKk8iRF6bnNQBmcDNFzMlFClLq20Gdus0xwRETLMdx7eDsoYLpHWvVLusZnyqw6/UcOw==
X-Received: by 2002:a05:6a21:78a1:b0:1c1:89f8:8609 with SMTP id adf61e73a8af0-1c699437165mr20730745637.0.1722964841403;
        Tue, 06 Aug 2024 10:20:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654beb1csm7071101a12.93.2024.08.06.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:20:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Aug 2024 10:20:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Message-ID: <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>

On Tue, Aug 06, 2024 at 01:02:45PM +0200, Vlastimil Babka wrote:
> On 8/6/24 04:40, Linus Torvalds wrote:
> > [ Let's drop random people and bring in Vlastimil ]
> 
> tglx was reproducing it so I add him back
> 
> > Vlastimil,
> >  it turns out that the "this patch" is entirely a red herring, and the
> > problem comes and goes randomly with just some code layout issues. See
> > 
> >    http://server.roeck-us.net/qemu/parisc64-6.10.3/
> > 
> > for more detail, particularly you'll see the "log.bad.gz" with the full log.
> 
> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
> [    0.000000] Slab 0x0000000041ed0000 objects=21 used=5 fp=0x00000000434003d0 flags=0x200(workingset|section=0|zone=0)
> 
> flags tell us this came from the partial list (workingset), there's no head flag so order-0
> 
> since the error was detected it basically throws the slab page away and tries another one
> 
> [    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
> [    0.000000] Slab 0x0000000041ed0080 objects=25 used=6 fp=0x0000000043402790 flags=0x240(workingset|head|section=0|zone=0)
> 
> this was also from the partial list but head flag so at least order-1, two things are weird:
> - max=16 is same as above even though it should be at least double as
> slab page's order is larger
> - objects=25 also isn't at least twice than objects=21
> 
> All the following are:
> [    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
> [    0.000000] Slab 0x0000000041ed0300 objects=25 used=1 fp=0x000000004340c150 flags=0x40(head|section=0|zone=0)
> 
> we depleted the partial list so it's allocating new slab pages, that are
> also at least order-1
> 
> It looks like maxobj calculation is bogus, would be useful to see what values it
> calculates from. I'm attaching a diff, but maybe it will also hide the issue...
> 

Of course it does :-(.

> If someone has a /proc/slabinfo from a working boot with otherwise same config
> it might be also enough to guess what values should be expected there,
> at least the s-size.
> 

See below. This is from the failing image after adding your suggested diff
(which is sufficient to make it pass). If there is anything else I can
provide, please let me know.

Thanks,
Guenter

---
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
btrfs_prelim_ref       0      0    176   23    1 : tunables    0    0    0 : slabdata      0      0      0
btrfs_delayed_extent_op      0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
btrfs_delayed_ref_node      0      0    208   39    2 : tunables    0    0    0 : slabdata      0      0      0
btrfs_delayed_ref_head      0      0    312   26    2 : tunables    0    0    0 : slabdata      0      0      0
btrfs_inode_defrag      0      0    152   26    1 : tunables    0    0    0 : slabdata      0      0      0
btrfs_delayed_node      0      0    448   36    4 : tunables    0    0    0 : slabdata      0      0      0
btrfs_ordered_extent      0      0    560   29    4 : tunables    0    0    0 : slabdata      0      0      0
btrfs_extent_map       0      0    208   39    2 : tunables    0    0    0 : slabdata      0      0      0
bio-280                2     21    384   21    2 : tunables    0    0    0 : slabdata      1      1      0
bio-344                4     36    448   36    4 : tunables    0    0    0 : slabdata      1      1      0
btrfs_extent_buffer      0      0    392   20    2 : tunables    0    0    0 : slabdata      0      0      0
btrfs_extent_state      0      0    192   21    1 : tunables    0    0    0 : slabdata      0      0      0
btrfs_free_space_bitmap      0      0  12288    2    8 : tunables    0    0    0 : slabdata      0      0      0
btrfs_free_space       0      0    200   20    1 : tunables    0    0    0 : slabdata      0      0      0
btrfs_path             0      0    208   39    2 : tunables    0    0    0 : slabdata      0      0      0
btrfs_trans_handle      0      0    296   27    2 : tunables    0    0    0 : slabdata      0      0      0
bio-360                2     35    464   35    4 : tunables    0    0    0 : slabdata      1      1      0
btrfs_inode            0      0   1520   21    8 : tunables    0    0    0 : slabdata      0      0      0
bio-416                2     31    528   31    4 : tunables    0    0    0 : slabdata      1      1      0
ip6-frags              0      0    312   26    2 : tunables    0    0    0 : slabdata      0      0      0
fib6_node              8     23    176   23    1 : tunables    0    0    0 : slabdata      1      1      0
ip6_dst_cache          1     24    336   24    2 : tunables    0    0    0 : slabdata      1      1      0
PINGv6                 0      0   1456   22    8 : tunables    0    0    0 : slabdata      0      0      0
RAWv6                 12     22   1456   22    8 : tunables    0    0    0 : slabdata      1      1      0
UDPLITEv6              0      0   1584   20    8 : tunables    0    0    0 : slabdata      0      0      0
UDPv6                  0      0   1584   20    8 : tunables    0    0    0 : slabdata      0      0      0
tw_sock_TCPv6          0      0    336   24    2 : tunables    0    0    0 : slabdata      0      0      0
request_sock_TCPv6      0      0    400   20    2 : tunables    0    0    0 : slabdata      0      0      0
TCPv6                  0      0   2736   11    8 : tunables    0    0    0 : slabdata      0      0      0
virtio_scsi_cmd       64     78    304   26    2 : tunables    0    0    0 : slabdata      3      3      0
scsi_sense_cache     703    741    208   39    2 : tunables    0    0    0 : slabdata     19     19      0
bio-104               18     39    208   39    2 : tunables    0    0    0 : slabdata      1      1      0
io_buffer              0      0    144   28    1 : tunables    0    0    0 : slabdata      0      0      0
io_kiocb               0      0    352   23    2 : tunables    0    0    0 : slabdata      0      0      0
bio-200                4     26    304   26    2 : tunables    0    0    0 : slabdata      1      1      0
mqueue_inode_cache      1     26   1232   26    8 : tunables    0    0    0 : slabdata      1      1      0
udf_inode_cache        0      0   1080   30    8 : tunables    0    0    0 : slabdata      0      0      0
fuse_request           0      0    264   31    2 : tunables    0    0    0 : slabdata      0      0      0
fuse_inode             0      0   1200   27    8 : tunables    0    0    0 : slabdata      0      0      0
sysv_inode_cache       0      0    912   35    8 : tunables    0    0    0 : slabdata      0      0      0
isofs_inode_cache      0      0    904   36    8 : tunables    0    0    0 : slabdata      0      0      0
squashfs_inode_cache      0      0    928   35    8 : tunables    0    0    0 : slabdata      0      0      0
jbd2_transaction_s      0      0    320   25    2 : tunables    0    0    0 : slabdata      0      0      0
jbd2_inode             0      0    160   25    1 : tunables    0    0    0 : slabdata      0      0      0
jbd2_journal_handle      0      0    152   26    1 : tunables    0    0    0 : slabdata      0      0      0
jbd2_journal_head      0      0    240   34    2 : tunables    0    0    0 : slabdata      0      0      0
jbd2_revoke_table_s      0      0    112   36    1 : tunables    0    0    0 : slabdata      0      0      0
jbd2_revoke_record_s      0      0    144   28    1 : tunables    0    0    0 : slabdata      0      0      0
ext2_inode_cache       0      0   1168   28    8 : tunables    0    0    0 : slabdata      0      0      0
ext4_fc_dentry_update      0      0    200   20    1 : tunables    0    0    0 : slabdata      0      0      0
ext4_inode_cache       0      0   1648   19    8 : tunables    0    0    0 : slabdata      0      0      0
ext4_free_data         0      0    152   26    1 : tunables    0    0    0 : slabdata      0      0      0
ext4_allocation_context      0      0    248   33    2 : tunables    0    0    0 : slabdata      0      0      0
ext4_prealloc_space      0      0    232   35    2 : tunables    0    0    0 : slabdata      0      0      0
ext4_system_zone       0      0    136   30    1 : tunables    0    0    0 : slabdata      0      0      0
ext4_io_end_vec        0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
ext4_io_end            0      0    160   25    1 : tunables    0    0    0 : slabdata      0      0      0
bio_post_read_ctx    128    140    144   28    1 : tunables    0    0    0 : slabdata      5      5      0
pending_reservation      0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
extent_status          0      0    136   30    1 : tunables    0    0    0 : slabdata      0      0      0
mb_cache_entry         0      0    152   26    1 : tunables    0    0    0 : slabdata      0      0      0
kioctx                 0      0    592   27    4 : tunables    0    0    0 : slabdata      0      0      0
aio_kiocb              0      0    288   28    2 : tunables    0    0    0 : slabdata      0      0      0
dnotify_mark           0      0    200   20    1 : tunables    0    0    0 : slabdata      0      0      0
dnotify_struct         0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
dio                    0      0    768   21    4 : tunables    0    0    0 : slabdata      0      0      0
fasync_cache           0      0    176   23    1 : tunables    0    0    0 : slabdata      0      0      0
audit_tree_mark        0      0    200   20    1 : tunables    0    0    0 : slabdata      0      0      0
pid_namespace          0      0    272   30    2 : tunables    0    0    0 : slabdata      0      0      0
posix_timers_cache      0      0    376   21    2 : tunables    0    0    0 : slabdata      0      0      0
UNIX-STREAM            0     23   1408   23    8 : tunables    0    0    0 : slabdata      1      1      0
UNIX                   2     23   1408   23    8 : tunables    0    0    0 : slabdata      1      1      0
ip4-frags              0      0    328   24    2 : tunables    0    0    0 : slabdata      0      0      0
UDP-Lite               0      0   1424   23    8 : tunables    0    0    0 : slabdata      0      0      0
tcp_bind2_bucket       0     23    176   23    1 : tunables    0    0    0 : slabdata      1      1      0
tcp_bind_bucket        0     23    176   23    1 : tunables    0    0    0 : slabdata      1      1      0
inet_peer              0      0    256   32    2 : tunables    0    0    0 : slabdata      0      0      0
xfrm_dst               0      0    400   20    2 : tunables    0    0    0 : slabdata      0      0      0
xfrm_state             0      0    896   36    8 : tunables    0    0    0 : slabdata      0      0      0
ip_fib_trie            7     28    144   28    1 : tunables    0    0    0 : slabdata      1      1      0
ip_fib_alias           7     26    152   26    1 : tunables    0    0    0 : slabdata      1      1      0
rtable                 2     28    288   28    2 : tunables    0    0    0 : slabdata      1      1      0
PING                   0      0   1264   25    8 : tunables    0    0    0 : slabdata      0      0      0
RAW                   16     25   1264   25    8 : tunables    0    0    0 : slabdata      1      1      0
UDP                    1     23   1424   23    8 : tunables    0    0    0 : slabdata      1      1      0
tw_sock_TCP            0      0    336   24    2 : tunables    0    0    0 : slabdata      0      0      0
request_sock_TCP       0      0    400   20    2 : tunables    0    0    0 : slabdata      0      0      0
TCP                    0     12   2576   12    8 : tunables    0    0    0 : slabdata      1      1      0
dquot                  0      0    416   39    4 : tunables    0    0    0 : slabdata      0      0      0
bio-224               32     48    336   24    2 : tunables    0    0    0 : slabdata      2      2      0
backing_aio            0      0    224   36    2 : tunables    0    0    0 : slabdata      0      0      0
ep_head                0      0    112   36    1 : tunables    0    0    0 : slabdata      0      0      0
eventpoll_pwq          0      0    160   25    1 : tunables    0    0    0 : slabdata      0      0      0
eventpoll_epi          0      0    224   36    2 : tunables    0    0    0 : slabdata      0      0      0
inotify_inode_mark      0      0    200   20    1 : tunables    0    0    0 : slabdata      0      0      0
sgpool-128             2      7   4208    7    8 : tunables    0    0    0 : slabdata      1      1      0
sgpool-64              2     15   2160   15    8 : tunables    0    0    0 : slabdata      1      1      0
sgpool-32              2     28   1136   28    8 : tunables    0    0    0 : slabdata      1      1      0
sgpool-16              2     26    624   26    4 : tunables    0    0    0 : slabdata      1      1      0
sgpool-8               2     22    368   22    2 : tunables    0    0    0 : slabdata      1      1      0
request_queue          9     25   1296   25    8 : tunables    0    0    0 : slabdata      1      1      0
blkdev_ioc             0      0    112   36    1 : tunables    0    0    0 : slabdata      0      0      0
bio-168                2     30    272   30    2 : tunables    0    0    0 : slabdata      1      1      0
biovec-max            48     49   4208    7    8 : tunables    0    0    0 : slabdata      7      7      0
biovec-128             0      0   2160   15    8 : tunables    0    0    0 : slabdata      0      0      0
biovec-64              0      0   1136   28    8 : tunables    0    0    0 : slabdata      0      0      0
biovec-16              0      0    368   22    2 : tunables    0    0    0 : slabdata      0      0      0
bio_integrity_payload      2     30    272   30    2 : tunables    0    0    0 : slabdata      1      1      0
user_namespace         0      0    736   22    4 : tunables    0    0    0 : slabdata      0      0      0
uid_cache              0      0    288   28    2 : tunables    0    0    0 : slabdata      0      0      0
audit_buffer           0     34    120   34    1 : tunables    0    0    0 : slabdata      1      1      0
sock_inode_cache      40     64   1008   32    8 : tunables    0    0    0 : slabdata      2      2      0
skbuff_ext_cache       0      0    208   39    2 : tunables    0    0    0 : slabdata      0      0      0
skbuff_small_head      0     25    640   25    4 : tunables    0    0    0 : slabdata      1      1      0
skbuff_fclone_cache      0     29    560   29    4 : tunables    0    0    0 : slabdata      1      1      0
skbuff_head_cache     52     72    336   24    2 : tunables    0    0    0 : slabdata      3      3      0
configfs_dir_cache      0      0    184   22    1 : tunables    0    0    0 : slabdata      0      0      0
file_lock_cache        0      0    280   29    2 : tunables    0    0    0 : slabdata      0      0      0
file_lock_cache        0     26    312   26    2 : tunables    0    0    0 : slabdata      1      1      0
file_lock_ctx          2     23    176   23    1 : tunables    0    0    0 : slabdata      1      1      0
fsnotify_mark_connector      0      0    152   26    1 : tunables    0    0    0 : slabdata      0      0      0
buffer_head            0      0    232   35    2 : tunables    0    0    0 : slabdata      0      0      0
task_delay_info        0      0    264   31    2 : tunables    0    0    0 : slabdata      0      0      0
taskstats              0      0    528   31    4 : tunables    0    0    0 : slabdata      0      0      0
proc_dir_entry       517    529    352   23    2 : tunables    0    0    0 : slabdata     23     23      0
pde_opener             0     30    136   30    1 : tunables    0    0    0 : slabdata      1      1      0
proc_inode_cache      12     35    928   35    8 : tunables    0    0    0 : slabdata      1      1      0
seq_file               1     33    248   33    2 : tunables    0    0    0 : slabdata      1      1      0
sigqueue               0     23    176   23    1 : tunables    0    0    0 : slabdata      1      1      0
bdev_cache            10     19   1696   19    8 : tunables    0    0    0 : slabdata      1      1      0
shmem_inode_cache    525    527   1056   31    8 : tunables    0    0    0 : slabdata     17     17      0
kernfs_iattrs_cache      0      0    208   39    2 : tunables    0    0    0 : slabdata      0      0      0
kernfs_node_cache   9323  10045    232   35    2 : tunables    0    0    0 : slabdata    287    287      0
mnt_cache             23     36    448   36    4 : tunables    0    0    0 : slabdata      1      1      0
filp                  37     74    432   37    4 : tunables    0    0    0 : slabdata      2      2      0
inode_cache         1134   1140    856   38    8 : tunables    0    0    0 : slabdata     30     30      0
dentry              1674   1700    320   25    2 : tunables    0    0    0 : slabdata     68     68      0
names_cache            0      7   4208    7    8 : tunables    0    0    0 : slabdata      1      1      0
net_namespace          0      0   3776    8    8 : tunables    0    0    0 : slabdata      0      0      0
key_jar                3     23    352   23    2 : tunables    0    0    0 : slabdata      1      1      0
uts_namespace          0      0    528   31    4 : tunables    0    0    0 : slabdata      0      0      0
nsproxy                1     24    168   24    1 : tunables    0    0    0 : slabdata      1      1      0
vm_area_struct       111    175    232   35    2 : tunables    0    0    0 : slabdata      5      5      0
fs_cache              13     21    192   21    1 : tunables    0    0    0 : slabdata      1      1      0
files_cache           13     20    816   20    4 : tunables    0    0    0 : slabdata      1      1      0
signal_cache          56     72   1344   24    8 : tunables    0    0    0 : slabdata      3      3      0
sighand_cache         56     72   1728   18    8 : tunables    0    0    0 : slabdata      4      4      0
task_struct           53     60   3088   10    8 : tunables    0    0    0 : slabdata      6      6      0
cred                  66     84    288   28    2 : tunables    0    0    0 : slabdata      3      3      0
anon_vma_chain        85    125    160   25    1 : tunables    0    0    0 : slabdata      5      5      0
anon_vma              67    148    216   37    2 : tunables    0    0    0 : slabdata      4      4      0
pid                   51     84    288   28    2 : tunables    0    0    0 : slabdata      3      3      0
pool_workqueue       277    294   1536   21    8 : tunables    0    0    0 : slabdata     14     14      0
maple_node            83    105    768   21    4 : tunables    0    0    0 : slabdata      5      5      0
radix_tree_node      240    312    672   24    4 : tunables    0    0    0 : slabdata     13     13      0
mm_struct              6     24   1312   24    8 : tunables    0    0    0 : slabdata      1      1      0
vmap_area             32     48    168   24    1 : tunables    0    0    0 : slabdata      2      2      0
debug_objects_cache   2156   2968     72   56    1 : tunables    0    0    0 : slabdata     53     53      0
page->ptl             39     96    128   32    1 : tunables    0    0    0 : slabdata      3      3      0
kmalloc-cg-8k          0      0  24576    1    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-cg-4k         15     16  12288    2    8 : tunables    0    0    0 : slabdata      8      8      0
kmalloc-cg-2k         28     30   6144    5    8 : tunables    0    0    0 : slabdata      6      6      0
kmalloc-cg-1k         16     20   3072   10    8 : tunables    0    0    0 : slabdata      2      2      0
kmalloc-cg-512        22     42   1536   21    8 : tunables    0    0    0 : slabdata      2      2      0
kmalloc-cg-256        11     21    768   21    4 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-cg-128        28     42    384   21    2 : tunables    0    0    0 : slabdata      2      2      0
kmalloc-cg-64          0      0    256   32    2 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-cg-32          0     25    160   25    1 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-cg-16         21     32    128   32    1 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-cg-192        20     26    304   26    2 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-cg-96          5     39    208   39    2 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-rcl-8k         0      0  24576    1    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-4k         0      0  12288    2    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-2k         0      0   6144    5    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-1k         0      0   3072   10    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-512        0      0   1536   21    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-256        0      0    768   21    4 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-128        0      0    384   21    2 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-64         0     32    256   32    2 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-rcl-32         0      0    160   25    1 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-16         0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-192        0      0    304   26    2 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-rcl-96         0      0    208   39    2 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-8k             9      9  24576    1    8 : tunables    0    0    0 : slabdata      9      9      0
kmalloc-4k            15     20  12288    2    8 : tunables    0    0    0 : slabdata     10     10      0
kmalloc-2k            60     65   6144    5    8 : tunables    0    0    0 : slabdata     13     13      0
kmalloc-1k           326    350   3072   10    8 : tunables    0    0    0 : slabdata     35     35      0
kmalloc-512          151    189   1536   21    8 : tunables    0    0    0 : slabdata      9      9      0
kmalloc-256          314    378    768   21    4 : tunables    0    0    0 : slabdata     18     18      0
kmalloc-128          341    357    384   21    2 : tunables    0    0    0 : slabdata     17     17      0
kmalloc-64          1881   1888    256   32    2 : tunables    0    0    0 : slabdata     59     59      0
kmalloc-32          1836   1850    160   25    1 : tunables    0    0    0 : slabdata     74     74      0
kmalloc-16          1226   1312    128   32    1 : tunables    0    0    0 : slabdata     41     41      0
kmalloc-192          296    312    304   26    2 : tunables    0    0    0 : slabdata     12     12      0
kmalloc-96           538    546    208   39    2 : tunables    0    0    0 : slabdata     14     14      0
kmem_cache_node      197    210    192   21    1 : tunables    0    0    0 : slabdata     10     10      0
kmem_cache           197    200    320   25    2 : tunables    0    0    0 : slabdata      8      8      0
/ # 

