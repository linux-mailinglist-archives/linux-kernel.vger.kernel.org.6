Return-Path: <linux-kernel+bounces-186366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8AF8CC33D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA01F228D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5D15AF6;
	Wed, 22 May 2024 14:30:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B5C8E9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388207; cv=none; b=LDpBuTEnZOVFIy8SUzKfypb2ptqqVi4cUsjYMt2efSEUbgPKIyUbKRBZT5A56wSEs5wo9qZtIBJbSIjP0GcwmSfW8jtDqa0KJnnc6IqC+/kZFtm8UqozouTEKdwUxIyP5E2XFafX/kWgmvqDI0gL56BgEnFmNPhhm+qXJ0ch3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388207; c=relaxed/simple;
	bh=+7eqm+iTB4TxXKBYmTENAnkTV7RnK793DVyxzKTFUlM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pwwndDPDGizSGXqTT1JB2rBhB2wRoXxtQTDkhr5teeCqgj6cuvHt41vmbdko0B6c5QnIJ7foMpY/3U7taf/KKW7gw00/1K8W/gWYJwpLOgx0RUrMqQ8dDrH3hiLfwUrr+9OFnhRHO/XE67ttU2yFbqKtHmvIfPA+xhrRMUbYu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e613a3a0e6so37359239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716388205; x=1716993005;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwe5XMUbchBZ1hpH0C/u6LtTNEFmsPXG1Go4bUNqcQQ=;
        b=YnPD4TcTxc1zjMgP/ZjzCBzyUhiLe6UB60Sg5ZHq6S8pIGNo1WkkUyXIwc6VcwJMaT
         L5S6FLqEmwGfbk0IE1OQ7Hz4cjX1eY1ZVf9Ow93Meus2P8NuYt++DkqEMi+smBytrW9S
         Mift6o9cNSqnnRHBRHCf+9uvVcV5JeTl8NAM4/Qy9cPeyrjXUamTZ1sHnWngtIYIMXYz
         3bEUm2sTWwTIP1v6ozIJFVCfi0By8f3VAR9fr7rLXGfICcypz3fvhqSrs86ibMDapv7s
         PFagkFgAxrxtGtLXRDlqXx2TVSwZg0lyHOCo3mA7D3Sfq3K/hwqLbqypWjwP8bwdmDg4
         jBIA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5xvsa/K9cd6F7MZKWUG5C9GcWy8BBAl6j0CYoSGHawVhGe/lCdnvU/qs8wSBPqvzL//xO0TV02snoCmPUubFD4z0c+w7ie879//G
X-Gm-Message-State: AOJu0Yx5780RkjrTBwr3xmC7K1nRIU7domaFObCbsO6EuOsx/g0DUqbQ
	OuhefzLtHkXX6z9+2JxBlam5+d1cC/D4JKY/Rs8QIuV6StHNBEagWHrs0a28b9T63Lzq8t3VsXg
	h/EcOxcoxF4FqfFDxtfGwSiTuX0ItRTaPvisyEjPKwyuLttrZXsv4VCc=
X-Google-Smtp-Source: AGHT+IHnSWCNuqa6xE2RXEGVdwcFBoDtEUFb5p88dd2m0RJTkzeNzmVvpwSOIAuWY5lVPXYZSPl1oJVgoMkSLMCR7ZMxwXOsDNNf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c21:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-371fc6e2dd8mr1759305ab.3.1716388205183; Wed, 22 May 2024
 07:30:05 -0700 (PDT)
Date: Wed, 22 May 2024 07:30:05 -0700
In-Reply-To: <tencent_DD0A3C9B37F697D637C04A3A7509762F6609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004453bd06190bc5d0@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

] Freeing unused kernel image (initmem) memory: 26000K
[   21.902015][    T1] Write protecting the kernel read-only data: 204800k
[   21.915990][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1740K
[   22.001150][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   22.010555][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   22.014380][    T1] Run /sbin/init as init process
[   22.270925][    T1] SELinux:  Class mctp_socket not defined in policy.
[   22.273265][    T1] SELinux:  Class anon_inode not defined in policy.
[   22.275479][    T1] SELinux:  Class io_uring not defined in policy.
[   22.277605][    T1] SELinux:  Class user_namespace not defined in policy=
.
[   22.279958][    T1] SELinux: the above unknown classes and permissions w=
ill be denied
[   22.376641][    T1] SELinux:  policy capability network_peer_controls=3D=
1
[   22.379248][    T1] SELinux:  policy capability open_perms=3D1
[   22.381279][    T1] SELinux:  policy capability extended_socket_class=3D=
1
[   22.383632][    T1] SELinux:  policy capability always_check_network=3D0
[   22.386099][    T1] SELinux:  policy capability cgroup_seclabel=3D1
[   22.388512][    T1] SELinux:  policy capability nnp_nosuid_transition=3D=
1
[   22.391006][    T1] SELinux:  policy capability genfs_seclabel_symlinks=
=3D0
[   22.393353][    T1] SELinux:  policy capability ioctl_skip_cloexec=3D0
[   22.395753][    T1] SELinux:  policy capability userspace_initial_contex=
t=3D0
[   22.493592][   T39] audit: type=3D1403 audit(1716387584.398:2): auid=3D4=
294967295 ses=3D4294967295 lsm=3Dselinux res=3D1
[   22.539716][ T4655] mount (4655) used greatest stack depth: 23344 bytes =
left
[   22.566408][ T4656] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
[   22.681935][ T4659] mount (4659) used greatest stack depth: 23128 bytes =
left
Starting syslogd: [   22.942320][   T39] audit: type=3D1400 audit(171638758=
4.848:3): avc:  denied  { read write } for  pid=3D4672 comm=3D"syslogd" pat=
h=3D"/dev/null" dev=3D"devtmpfs" ino=3D5 scontext=3Dsystem_u:system_r:syslo=
gd_t tcontext=3Dsystem_u:object_r:device_t tclass=3Dchr_file permissive=3D1
OK
[   22.970689][   T39] audit: type=3D1400 audit(1716387584.878:4): avc:  de=
nied  { read } for  pid=3D4672 comm=3D"syslogd" name=3D"log" dev=3D"sda1" i=
no=3D1915 scontext=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:object=
_r:var_t tclass=3Dlnk_file permissive=3D1
[   22.979560][   T39] audit: type=3D1400 audit(1716387584.878:5): avc:  de=
nied  { search } for  pid=3D4672 comm=3D"syslogd" name=3D"/" dev=3D"tmpfs" =
ino=3D1 scontext=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:object_r=
:tmpfs_t tclass=3Ddir permissive=3D1
[   22.987816][   T39] audit: type=3D1400 audit(1716387584.878:6): avc:  de=
nied  { write } for  pid=3D4672 comm=3D"syslogd" name=3D"/" dev=3D"tmpfs" i=
no=3D1 scontext=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:object_r:=
tmpfs_t tclass=3Ddir permissive=3D1
Starting acpid: [   22.996353][   T39] audit: type=3D1400 audit(1716387584.=
878:7): avc:  denied  { add_name } for  pid=3D4672 comm=3D"syslogd" name=3D=
"messages" scontext=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:objec=
t_r:tmpfs_t tclass=3Ddir permissive=3D1
[   23.005839][   T39] audit: type=3D1400 audit(1716387584.878:8): avc:  de=
nied  { create } for  pid=3D4672 comm=3D"syslogd" name=3D"messages" scontex=
t=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=
=3Dfile permissive=3D1
[   23.013760][   T39] audit: type=3D1400 audit(1716387584.878:9): avc:  de=
nied  { append open } for  pid=3D4672 comm=3D"syslogd" path=3D"/tmp/message=
s" dev=3D"tmpfs" ino=3D2 scontext=3Dsystem_u:system_r:syslogd_t tcontext=3D=
system_u:object_r:tmpfs_t tclass=3Dfile permissive=3D1
[   23.022478][   T39] audit: type=3D1400 audit(1716387584.878:10): avc:  d=
enied  { getattr } for  pid=3D4672 comm=3D"syslogd" path=3D"/tmp/messages" =
dev=3D"tmpfs" ino=3D2 scontext=3Dsystem_u:system_r:syslogd_t tcontext=3Dsys=
tem_u:object_r:tmpfs_t tclass=3Dfile permissive=3D1
[   23.032435][   T39] audit: type=3D1400 audit(1716387584.938:11): avc:  d=
enied  { use } for  pid=3D4674 comm=3D"acpid" path=3D"/dev/console" dev=3D"=
rootfs" ino=3D1039 scontext=3Dsystem_u:system_r:acpid_t tcontext=3Dsystem_u=
:system_r:kernel_t tclass=3Dfd permissive=3D1
OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   23.362610][ T4689] udevd[4689]: starting ve=
rsion 3.2.11
[   23.521131][ T4690] udevd[4690]: starting eudev-3.2.11
[   23.522449][ T4689] udevd (4689) used greatest stack depth: 21488 bytes =
left
done
Starting system message bus: [   30.837568][   T39] kauditd_printk_skb: 13 =
callbacks suppressed
[   30.837584][   T39] audit: type=3D1400 audit(1716387592.738:25): avc:  d=
enied  { use } for  pid=3D4894 comm=3D"dbus-daemon" path=3D"/dev/console" d=
ev=3D"rootfs" ino=3D1039 scontext=3Dsystem_u:system_r:system_dbusd_t tconte=
xt=3Dsystem_u:system_r:kernel_t tclass=3Dfd permissive=3D1
[   30.851952][   T39] audit: type=3D1400 audit(1716387592.738:26): avc:  d=
enied  { read write } for  pid=3D4894 comm=3D"dbus-daemon" path=3D"/dev/con=
sole" dev=3D"rootfs" ino=3D1039 scontext=3Dsystem_u:system_r:system_dbusd_t=
 tcontext=3Dsystem_u:object_r:root_t tclass=3Dchr_file permissive=3D1
[   30.880042][   T39] audit: type=3D1400 audit(1716387592.788:27): avc:  d=
enied  { search } for  pid=3D4894 comm=3D"dbus-daemon" name=3D"/" dev=3D"tm=
pfs" ino=3D1 scontext=3Dsystem_u:system_r:system_dbusd_t tcontext=3Dsystem_=
u:object_r:tmpfs_t tclass=3Ddir permissive=3D1
[   30.893529][   T39] audit: type=3D1400 audit(1716387592.798:28): avc:  d=
enied  { write } for  pid=3D4894 comm=3D"dbus-daemon" name=3D"dbus" dev=3D"=
tmpfs" ino=3D1471 scontext=3Dsystem_u:system_r:system_dbusd_t tcontext=3Dsy=
stem_u:object_r:tmpfs_t tclass=3Ddir permissive=3D1
[   30.902587][   T39] audit: type=3D1400 audit(1716387592.798:29): avc:  d=
enied  { add_name } for  pid=3D4894 comm=3D"dbus-daemon" name=3D"system_bus=
_socket" scontext=3Dsystem_u:system_r:system_dbusd_t tcontext=3Dsystem_u:ob=
ject_r:tmpfs_t tclass=3Ddir permissive=3D1
[   30.911419][   T39] audit: type=3D1400 audit(1716387592.798:30): avc:  d=
enied  { create } for  pid=3D4894 comm=3D"dbus-daemon" name=3D"system_bus_s=
ocket" scontext=3Dsystem_u:system_r:system_dbusd_t tcontext=3Dsystem_u:obje=
ct_r:tmpfs_t tclass=3Dsock_file permissive=3D1
done[   30.920385][   T39] audit: type=3D1400 audit(1716387592.798:31): avc=
:  denied  { setattr } for  pid=3D4894 comm=3D"dbus-daemon" name=3D"system_=
bus_socket" dev=3D"tmpfs" ino=3D1472 scontext=3Dsystem_u:system_r:system_db=
usd_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Dsock_file permissive=3D=
1
[   30.930297][   T39] audit: type=3D1400 audit(1716387592.808:32): avc:  d=
enied  { create } for  pid=3D4894 comm=3D"dbus-daemon" name=3D"messagebus.p=
id" scontext=3Dsystem_u:system_r:system_dbusd_t tcontext=3Dsystem_u:object_=
r:tmpfs_t tclass=3Dfile permissive=3D1

[   30.939028][   T39] audit: type=3D1400 audit(1716387592.808:33): avc:  d=
enied  { write open } for  pid=3D4894 comm=3D"dbus-daemon" path=3D"/run/mes=
sagebus.pid" dev=3D"tmpfs" ino=3D1473 scontext=3Dsystem_u:system_r:system_d=
busd_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfile permissive=3D1
[   30.948572][   T39] audit: type=3D1400 audit(1716387592.808:34): avc:  d=
enied  { getattr } for  pid=3D4894 comm=3D"dbus-daemon" path=3D"/run/messag=
ebus.pid" dev=3D"tmpfs" ino=3D1473 scontext=3Dsystem_u:system_r:system_dbus=
d_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfile permissive=3D1
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
[   31.870098][ T4918] ret: 114, nbufs: 16,  buf len: 114, n: 0, iter_file_=
splice_write
[   31.872828][ T4918] ret: 0, nbufs: 16,  buf len: 114, n: 1, iter_file_sp=
lice_write
[   31.875479][ T4918] ------------[ cut here ]------------
[   31.877625][ T4918] kernel BUG at fs/splice.c:772!
[   31.879642][ T4918] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NO=
PTI
[   31.882144][ T4918] CPU: 2 PID: 4918 Comm: cat Not tainted 6.9.0-syzkall=
er-07370-g33e02dc69afb-dirty #0
[   31.886067][ T4918] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   31.890166][ T4918] RIP: 0010:iter_file_splice_write+0x1039/0x1180
[   31.892847][ T4918] Code: c1 ea 03 83 c3 01 0f b6 14 02 48 89 c8 83 e0 0=
7 83 c0 03 38 d0 7c 08 84 d2 0f 85 8b 00 00 00 48 8b 04 24 89 98 34 01 00 0=
0 90 <0f> 0b 48 89 cf e8 8d 0e e0 ff e9 38 f3 ff ff e8 83 0e e0 ff e9 ea
[   31.900759][ T4918] RSP: 0018:ffffc900039af930 EFLAGS: 00010246
[   31.903148][ T4918] RAX: ffff8880254fec00 RBX: 0000000000000001 RCX: fff=
f8880254fed34
[   31.906429][ T4918] RDX: 0000000000000000 RSI: ffffffff82098b90 RDI: fff=
f88802ea30818
[   31.909550][ T4918] RBP: 0000000000000072 R08: 0000000000000001 R09: 000=
0000000000000
[   31.912529][ T4918] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88802ea30800
[   31.915665][ T4918] R13: 0000000000000072 R14: 0000000000000072 R15: fff=
f88802ea3080c
[   31.918807][ T4918] FS:  00007f39afea8500(0000) GS:ffff88806b200000(0000=
) knlGS:0000000000000000
[   31.921822][ T4918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.924602][ T4918] CR2: 00007f39b016e5c4 CR3: 000000002b4a6000 CR4: 000=
0000000350ef0
[   31.927480][ T4918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   31.930220][ T4918] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   31.933091][ T4918] Call Trace:
[   31.934542][ T4918]  <TASK>
[   31.935639][ T4918]  ? show_regs+0x8c/0xa0
[   31.937245][ T4918]  ? die+0x36/0xa0
[   31.938912][ T4918]  ? do_trap+0x232/0x430
[   31.940376][ T4918]  ? iter_file_splice_write+0x1039/0x1180
[   31.942133][ T4918]  ? iter_file_splice_write+0x1039/0x1180
[   31.944212][ T4918]  ? do_error_trap+0xf4/0x230
[   31.946283][ T4918]  ? iter_file_splice_write+0x1039/0x1180
[   31.948819][ T4918]  ? handle_invalid_op+0x34/0x40
[   31.950675][ T4918]  ? iter_file_splice_write+0x1039/0x1180
[   31.952589][ T4918]  ? exc_invalid_op+0x2e/0x50
[   31.954493][ T4918]  ? asm_exc_invalid_op+0x1a/0x20
[   31.956421][ T4918]  ? page_cache_pipe_buf_release+0x110/0x2f0
[   31.958569][ T4918]  ? iter_file_splice_write+0x1039/0x1180
[   31.960765][ T4918]  ? __pfx_iter_file_splice_write+0x10/0x10
[   31.963016][ T4918]  ? __pfx_lock_acquire+0x10/0x10
[   31.964920][ T4918]  ? __pfx_iter_file_splice_write+0x10/0x10
[   31.967141][ T4918]  direct_splice_actor+0x19b/0x6d0
[   31.969069][ T4918]  splice_direct_to_actor+0x346/0xa40
[   31.971093][ T4918]  ? __pfx_direct_splice_actor+0x10/0x10
[   31.973209][ T4918]  ? __pfx_splice_direct_to_actor+0x10/0x10
[   31.975456][ T4918]  ? __fsnotify_parent+0x27d/0x9d0
[   31.977400][ T4918]  ? __pfx___might_resched+0x10/0x10
[   31.979416][ T4918]  do_splice_direct+0x17e/0x250
[   31.981880][ T4918]  ? __pfx_do_splice_direct+0x10/0x10
[   31.983926][ T4918]  ? avc_policy_seqno+0x9/0x20
[   31.985751][ T4918]  ? __pfx_direct_file_splice_eof+0x10/0x10
[   31.987982][ T4918]  do_sendfile+0xaa8/0xdb0
[   31.989672][ T4918]  ? __pfx_do_sendfile+0x10/0x10
[   31.991574][ T4918]  ? do_user_addr_fault+0x6d7/0x1010
[   31.993526][ T4918]  __x64_sys_sendfile64+0x1da/0x220
[   31.995516][ T4918]  ? __pfx___x64_sys_sendfile64+0x10/0x10
[   31.997677][ T4918]  do_syscall_64+0xcf/0x260
[   31.999401][ T4918]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   32.001652][ T4918] RIP: 0033:0x7f39affffefa
[   32.003356][ T4918] Code: ff 76 13 83 f8 a1 74 03 f7 d8 c3 4c 89 d2 4c 8=
9 c6 e9 49 fe ff ff 31 c0 c3 0f 1f 80 00 00 00 00 49 89 ca b8 28 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fe 6e 0d 00 f7 d8 64 89 01 48
[   32.010454][ T4918] RSP: 002b:00007fffa16e8068 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000028
[   32.013594][ T4918] RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 000=
07f39affffefa
[   32.016570][ T4918] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000=
0000000000001
[   32.019528][ T4918] RBP: 0000000000000003 R08: 0000000000000000 R09: 000=
0000000000000
[   32.022555][ T4918] R10: 0000000001000000 R11: 0000000000000246 R12: 000=
0000000000003
[   32.025553][ T4918] R13: 0000000000000001 R14: 0000000000000000 R15: 000=
0000000000001
[   32.028586][ T4918]  </TASK>
[   32.029791][ T4918] Modules linked in:
[   32.031452][ T4918] ---[ end trace 0000000000000000 ]---
[   32.033862][ T4918] RIP: 0010:iter_file_splice_write+0x1039/0x1180
[   32.036610][ T4918] Code: c1 ea 03 83 c3 01 0f b6 14 02 48 89 c8 83 e0 0=
7 83 c0 03 38 d0 7c 08 84 d2 0f 85 8b 00 00 00 48 8b 04 24 89 98 34 01 00 0=
0 90 <0f> 0b 48 89 cf e8 8d 0e e0 ff e9 38 f3 ff ff e8 83 0e e0 ff e9 ea
[   32.045466][ T4918] RSP: 0018:ffffc900039af930 EFLAGS: 00010246
[   32.048320][ T4918] RAX: ffff8880254fec00 RBX: 0000000000000001 RCX: fff=
f8880254fed34
[   32.050899][ T4918] RDX: 0000000000000000 RSI: ffffffff82098b90 RDI: fff=
f88802ea30818
[   32.054095][ T4918] RBP: 0000000000000072 R08: 0000000000000001 R09: 000=
0000000000000
[   32.057263][ T4918] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88802ea30800
[   32.060607][ T4918] R13: 0000000000000072 R14: 0000000000000072 R15: fff=
f88802ea3080c
[   32.063406][ T4918] FS:  00007f39afea8500(0000) GS:ffff88806b200000(0000=
) knlGS:0000000000000000
[   32.066421][ T4918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.068828][ T4918] CR2: 00007f39b016e5c4 CR3: 000000002b4a6000 CR4: 000=
0000000350ef0
[   32.071717][ T4918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   32.074503][ T4918] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   32.077572][ T4918] Kernel panic - not syncing: Fatal exception
[   32.080225][ T4918] Kernel Offset: disabled
[   32.081708][ T4918] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build4079149403=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at ef5d53ed7
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Def5d53ed7e3c7d30481a88301f680e37a5cc4775 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240515-155216'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Def5d53ed7e3c7d30481a88301f680e37a5cc4775 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240515-155216'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Iexecutor/_include -O2 -pthread -Wall -Werror -Wpar=
entheses -Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-=
overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variabl=
e -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"ef5d53ed7e3c7d30481a88301f680e37a5=
cc4775\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D164efe44980000


Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D25544a2faf4bae6=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd2125fcb6aa8c4276=
fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D179a8cec9800=
00


