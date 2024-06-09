Return-Path: <linux-kernel+bounces-207308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06945901558
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B7D2820FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB561CFA8;
	Sun,  9 Jun 2024 09:42:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31401CD11
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717926124; cv=none; b=SrFuPOX5jT+16Kz9jl0FfDbA5lwJmpy9WJ9dh3k1Wbde/l7moAqJZUCQr2IhOSb0qQJ5wM/I3QJ+ZR03zwKeTa1YSY97OU4h5r0WTu7kPRCSQc1IRGiDd6ZMC5rnTUBNGR18hUh2Yi+iu9ujYd2YlEa7RMezLGuWHzhYgDMkJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717926124; c=relaxed/simple;
	bh=7oz8I6Fyv0Sp5TqZ2Z7ImltOrAjaNA8nLaU4Er0DP7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kua0eoNdM2on7VUAkv27U9KXrGMdPjVu+220tzn7Ajro30OqT9BU8CjFHNfpU5KLaRESNAsduhkMTkDdoLm1ZB2X6VHgEj/9wqG2OE67wU11clabfDJ0T7jQT7N8NK8lrNNjcdVeEUYWesvEWZzre6szOq2h8WdQaNqnRmLgbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3758eb520bcso18558725ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 02:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717926122; x=1718530922;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc25IaX1F5ETIaqYA3bHANc9JQJo/j8ifD5rkdEcuDo=;
        b=Ll+7IzHbfKBpECObJIAEsLPTb0UWAnwTLE5sIRpv+b7QANIqoeoL4sgMxS3xnQykn3
         1eFkKCIBnRcLHe2Z5Eyi8V7lfK3K5sGNnknChPwkLvFneE1dYapoEFPbd3lgH3uDoKea
         8+u5tK0PCt+OADvvg3hoPaZj3Q1KUhOQB1naDhYgdf+P8fEwtuZJ6daesPU8itMMj02u
         k0BZMjpYe9VmRDzhrthTqVBbupBYtNHsu0GXHgNNni+CwISieJ+RqmpMOQT5kl3KLm2N
         i9lJmleU5Lw1ENCBMltGAtQrgfJLIBA4WfNQeYpydbCtSDG1lRUF6ov7VXw9HppltdKO
         0ZmA==
X-Forwarded-Encrypted: i=1; AJvYcCVrXrk1E8ymQIYzJyNxLCi4aFrj/wxr0/GFcSvFqr37b+eGPoam4HUNCBu62dEj58R44gxWkSV9Q2g/fBMjWjbFOxk6Stvr3nIiaGol
X-Gm-Message-State: AOJu0YzS9V4Fx9GdHU9TyabRE1Ah7va7zqBaq5KL3mRpkFqu92o2tcQB
	jAvfph999RYlEP7YKFh01MA/4MjIX0gL7rcGpEAPwrQbaMThWCNUxZYdZOSHIFl7orEWxkdJefW
	AD5v8xz3SLdbs/9a94xk32tcvD6G2NrqrqXwNcY045gjW4mUu0NnYfIs=
X-Google-Smtp-Source: AGHT+IETV3Ia2SW8Bh0E8g/N4DeS8PepyCznMtb4EWIpWsNnl47eCGRFTZxgot1F/VpAnS80hIXSOjUR0Yj2TRsxO81jltEosyOA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-375803cf3abmr4214235ab.4.1717926122063; Sun, 09 Jun 2024
 02:42:02 -0700 (PDT)
Date: Sun, 09 Jun 2024 02:42:02 -0700
In-Reply-To: <10654d2b-4fb4-4484-bda7-bec60ddf214e@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004193d2061a71d813@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    T1] Demotion targets for Node 1: null
[   49.119163][    T1] Key type .fscrypt registered
[   49.124054][    T1] Key type fscrypt-provisioning registered
[   49.131133][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   49.161844][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   49.188222][    T1] Key type encrypted registered
[   49.193331][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   49.200083][    T1] ima: No TPM chip found, activating TPM-bypass!
[   49.207200][    T1] Loading compiled-in module X.509 certificates
[   49.249983][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 4044fdb61657f0d7afb57899761a918f325ad9da'
[   49.261109][    T1] ima: Allocated hash algorithm: sha256
[   49.267173][    T1] ima: No architecture policies found
[   49.273691][    T1] evm: Initialising EVM extended attributes:
[   49.279714][    T1] evm: security.selinux (disabled)
[   49.284916][    T1] evm: security.SMACK64 (disabled)
[   49.290078][    T1] evm: security.SMACK64EXEC (disabled)
[   49.295621][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   49.301561][    T1] evm: security.SMACK64MMAP (disabled)
[   49.307143][    T1] evm: security.apparmor
[   49.311428][    T1] evm: security.ima
[   49.315316][    T1] evm: security.capability
[   49.319780][    T1] evm: HMAC attrs: 0x1
[   49.328692][    T1] PM:   Magic number: 12:657:575
[   49.334778][    T1] usbmon usbmon15: hash matches
[   49.340450][    T1] tty ptyb7: hash matches
[   49.346466][    T1]  workqueue: hash matches
[   49.351454][    T1] printk: legacy console [netcon0] enabled
[   49.357452][    T1] netconsole: network logging started
[   49.364585][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   49.373483][    T1] rdma_rxe: loaded
[   49.379175][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   49.398675][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   49.416007][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   49.424502][    T1] clk: Disabling unused clocks
[   49.429431][    T1] ALSA device list:
[   49.433391][    T1]   #0: Dummy 1
[   49.436942][    T1]   #1: Loopback 1
[   49.440749][    T1]   #2: Virtual MIDI Card 1
[   49.450862][  T781] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   49.460739][  T781] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   49.470135][    T1] md: Waiting for all devices to be available before a=
utodetect
[   49.478147][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   49.484855][    T1] md: Autodetecting RAID arrays.
[   49.489958][    T1] md: autorun ...
[   49.493726][    T1] md: ... autorun DONE.
[   49.614018][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   49.627278][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   49.652172][    T1] devtmpfs: mounted
[   49.914371][    T1] Freeing unused kernel image (initmem) memory: 36920K
[   49.925939][    T1] Write protecting the kernel read-only data: 260096k
[   49.973690][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1876K
[   51.629847][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   51.640154][    T1] x86/mm: Checking user space page tables
[   53.150732][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.159748][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.180434][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.192322][    T1] Run /sbin/init as init process
[   54.758005][ T4441] mount (4441) used greatest stack depth: 8144 bytes l=
eft
[   54.829184][ T4442] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.180355][ T4445] mount (4445) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   58.985674][ T4475] udevd[4475]: starting ve=
rsion 3.2.11
[   62.542055][ T4476] udevd[4476]: starting eudev-3.2.11
[   62.555019][ T4475] udevd (4475) used greatest stack depth: 5376 bytes l=
eft
[   96.245738][ T1222] net_ratelimit: 2 callbacks suppressed
[   96.245811][ T1222] aoe: packet could not be sent on lo.  consider incre=
asing tx_queue_len
[   96.260621][ T1222] aoe: packet could not be sent on bond0.  consider in=
creasing tx_queue_len
[   96.270147][ T1222] aoe: packet could not be sent on dummy0.  consider i=
ncreasing tx_queue_len
[   96.279315][ T1222] aoe: packet could not be sent on eql.  consider incr=
easing tx_queue_len
[   96.288322][ T1222] aoe: packet could not be sent on ifb0.  consider inc=
reasing tx_queue_len
[   96.297303][ T1222] aoe: packet could not be sent on ifb1.  consider inc=
reasing tx_queue_len
[   96.306386][ T1222] aoe: packet could not be sent on eth0.  consider inc=
reasing tx_queue_len
[   96.315372][ T1222] aoe: packet could not be sent on wlan0.  consider in=
creasing tx_queue_len
[   96.324577][ T1222] aoe: packet could not be sent on wlan1.  consider in=
creasing tx_queue_len
[   96.333636][ T1222] aoe: packet could not be sent on hwsim0.  consider i=
ncreasing tx_queue_len
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:ee:6e:2e:e3:62:a1:1e:1b:9d:a6:87:1c:6e:7e:27:0f
forked to background, child pid 4688
[  109.985374][ T4689] 8021q: adding VLAN 0 to HW filter on device bond0
[  110.004681][ T4689] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
Starting sshd: [  111.585878][  T781] cfg80211: failed to load regulatory.d=
b
OK


syzkaller

syzkaller login: [  115.417995][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  115.425211][    C1] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  115.432271][    C1]  receive_buf+0x25e3/0x5fd0
[  115.437052][    C1]  virtnet_poll+0xd1c/0x23c0
[  115.441841][    C1]  __napi_poll+0xe7/0x980
[  115.446368][    C1]  net_rx_action+0x82a/0x1850
[  115.451222][    C1]  handle_softirqs+0x1ce/0x800
[  115.456164][    C1]  __irq_exit_rcu+0x68/0x120
[  115.460908][    C1]  irq_exit_rcu+0x12/0x20
[  115.465413][    C1]  common_interrupt+0x94/0xa0
[  115.470274][    C1]  asm_common_interrupt+0x2b/0x40
[  115.475495][    C1]  acpi_safe_halt+0x25/0x30
[  115.480160][    C1]  acpi_idle_do_entry+0x22/0x40
[  115.485189][    C1]  acpi_idle_enter+0xa1/0xc0
[  115.489935][    C1]  cpuidle_enter_state+0xcb/0x250
[  115.495149][    C1]  cpuidle_enter+0x7f/0xf0
[  115.499731][    C1]  do_idle+0x551/0x750
[  115.503955][    C1]  cpu_startup_entry+0x65/0x80
[  115.508864][    C1]  start_secondary+0xcb/0xd0
[  115.513732][    C1]  common_startup_64+0x12c/0x137
[  115.518832][    C1]=20
[  115.521190][    C1] Uninit was created at:
[  115.525702][    C1]  __alloc_pages_noprof+0x9d6/0xe70
[  115.531074][    C1]  alloc_pages_mpol_noprof+0x299/0x990
[  115.536739][    C1]  alloc_pages_noprof+0x1bf/0x1e0
[  115.541955][    C1]  skb_page_frag_refill+0x2bf/0x7c0
[  115.547353][    C1]  virtnet_rq_alloc+0x43/0xbb0
[  115.552376][    C1]  try_fill_recv+0x3f0/0x2f50
[  115.557337][    C1]  virtnet_open+0x1cc/0xb00
[  115.561938][    C1]  __dev_open+0x546/0x6f0
[  115.566459][    C1]  __dev_change_flags+0x309/0x9a0
[  115.571639][    C1]  dev_change_flags+0x8e/0x1d0
[  115.576573][    C1]  devinet_ioctl+0x13ec/0x22c0
[  115.581510][    C1]  inet_ioctl+0x4bd/0x6d0
[  115.585995][    C1]  sock_do_ioctl+0xb7/0x540
[  115.590666][    C1]  sock_ioctl+0x727/0xd70
[  115.595147][    C1]  __se_sys_ioctl+0x261/0x450
[  115.599966][    C1]  __x64_sys_ioctl+0x96/0xe0
[  115.604710][    C1]  x64_sys_call+0x18c0/0x3b90
[  115.609556][    C1]  do_syscall_64+0xcd/0x1e0
[  115.614236][    C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  115.620293][    C1]=20
[  115.622756][    C1] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.10.0-rc2=
-syzkaller-00366-g771ed66105de-dirty #0
[  115.633186][    C1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  115.643409][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  115.650429][    C1] Disabling lock debugging due to kernel taint
[  115.656718][    C1] Kernel panic - not syncing: kmsan.panic set ...
[  115.663231][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G    B       =
       6.10.0-rc2-syzkaller-00366-g771ed66105de-dirty #0
[  115.675047][    C1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  115.685180][    C1] Call Trace:
[  115.688511][    C1]  <IRQ>
[  115.691424][    C1]  dump_stack_lvl+0x216/0x2d0
[  115.696208][    C1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  115.702134][    C1]  dump_stack+0x1e/0x30
[  115.706380][    C1]  panic+0x4e2/0xcd0
[  115.710363][    C1]  ? kmsan_get_metadata+0xb1/0x1d0
[  115.715588][    C1]  kmsan_report+0x2d5/0x2e0
[  115.720193][    C1]  ? kmsan_get_metadata+0x146/0x1d0
[  115.725494][    C1]  ? __msan_warning+0x95/0x120
[  115.730524][    C1]  ? receive_buf+0x25e3/0x5fd0
[  115.735423][    C1]  ? virtnet_poll+0xd1c/0x23c0
[  115.740319][    C1]  ? __napi_poll+0xe7/0x980
[  115.744975][    C1]  ? net_rx_action+0x82a/0x1850
[  115.749951][    C1]  ? handle_softirqs+0x1ce/0x800
[  115.755021][    C1]  ? __irq_exit_rcu+0x68/0x120
[  115.759883][    C1]  ? irq_exit_rcu+0x12/0x20
[  115.764500][    C1]  ? common_interrupt+0x94/0xa0
[  115.769456][    C1]  ? asm_common_interrupt+0x2b/0x40
[  115.774754][    C1]  ? acpi_safe_halt+0x25/0x30
[  115.779534][    C1]  ? acpi_idle_do_entry+0x22/0x40
[  115.784738][    C1]  ? acpi_idle_enter+0xa1/0xc0
[  115.789603][    C1]  ? cpuidle_enter_state+0xcb/0x250
[  115.794891][    C1]  ? cpuidle_enter+0x7f/0xf0
[  115.799595][    C1]  ? do_idle+0x551/0x750
[  115.803909][    C1]  ? cpu_startup_entry+0x65/0x80
[  115.808953][    C1]  ? start_secondary+0xcb/0xd0
[  115.813810][    C1]  ? common_startup_64+0x12c/0x137
[  115.819068][    C1]  ? kmsan_get_metadata+0x146/0x1d0
[  115.824384][    C1]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  115.830861][    C1]  ? __msan_memcpy+0x108/0x1c0
[  115.835763][    C1]  ? page_to_skb+0x1271/0x1620
[  115.840612][    C1]  ? kmsan_get_metadata+0x146/0x1d0
[  115.845931][    C1]  __msan_warning+0x95/0x120
[  115.850618][    C1]  receive_buf+0x25e3/0x5fd0
[  115.855336][    C1]  ? kmsan_get_metadata+0x146/0x1d0
[  115.860641][    C1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  115.866572][    C1]  virtnet_poll+0xd1c/0x23c0
[  115.871299][    C1]  ? __pfx_virtnet_poll+0x10/0x10
[  115.876444][    C1]  __napi_poll+0xe7/0x980
[  115.880885][    C1]  ? kmsan_get_metadata+0x146/0x1d0
[  115.886199][    C1]  net_rx_action+0x82a/0x1850
[  115.891087][    C1]  ? sched_clock_cpu+0x55/0x870
[  115.896185][    C1]  ? __pfx_net_rx_action+0x10/0x10
[  115.901416][    C1]  handle_softirqs+0x1ce/0x800
[  115.906294][    C1]  __irq_exit_rcu+0x68/0x120
[  115.911007][    C1]  irq_exit_rcu+0x12/0x20
[  115.915429][    C1]  common_interrupt+0x94/0xa0
[  115.920232][    C1]  </IRQ>
[  115.923211][    C1]  <TASK>
[  115.926197][    C1]  asm_common_interrupt+0x2b/0x40
[  115.931326][    C1] RIP: 0010:acpi_safe_halt+0x25/0x30
[  115.936807][    C1] Code: 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 80 5=
e 0a 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d eb a8 44 00 f3 0f 1e fa f=
b f4 <fa> 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  115.956643][    C1] RSP: 0018:ffff8881026ebdb0 EFLAGS: 00000246
[  115.962829][    C1] RAX: ffff8881026d4180 RBX: ffffffff91286b50 RCX: 000=
0000000000001
[  115.970895][    C1] RDX: ffff888103172864 RSI: ffffffff91286b50 RDI: fff=
f888103172864
[  115.978952][    C1] RBP: ffff8881026ebdb0 R08: ffffea000000000f R09: 000=
00000000000ff
[  115.987007][    C1] R10: ffff888101ed4182 R11: ffffffff8f78b590 R12: fff=
f888103dcf400
[  115.995060][    C1] R13: ffffffff91286bd0 R14: 0000000000000001 R15: 000=
0000000000001
[  116.003139][    C1]  ? __pfx_acpi_idle_enter+0x10/0x10
[  116.008538][    C1]  acpi_idle_do_entry+0x22/0x40
[  116.013513][    C1]  acpi_idle_enter+0xa1/0xc0
[  116.018199][    C1]  cpuidle_enter_state+0xcb/0x250
[  116.023340][    C1]  cpuidle_enter+0x7f/0xf0
[  116.027868][    C1]  do_idle+0x551/0x750
[  116.032019][    C1]  cpu_startup_entry+0x65/0x80
[  116.036863][    C1]  ? __pfx_setup_secondary_APIC_clock+0x10/0x10
[  116.043215][    C1]  start_secondary+0xcb/0xd0
[  116.047891][    C1]  common_startup_64+0x12c/0x137
[  116.052944][    C1]  </TASK>
[  116.056275][    C1] Kernel Offset: disabled
[  116.060660][    C1] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1647276148=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 25905f5d0a
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
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"25905f5d0a2a7883bd3349199755619358=
2c6059\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14f8680a980000


Tested on:

commit:         771ed661 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7d07bfd0c305fe=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3ae6be33a50b5aae4=
dab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D169396969800=
00


