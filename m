Return-Path: <linux-kernel+bounces-365172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129F99DE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D6C284FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8D18A6C5;
	Tue, 15 Oct 2024 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvupb5GW"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00D189BBF;
	Tue, 15 Oct 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974282; cv=none; b=UQp1vNh82pSQZu58S9WY6RO/j5IHmtDNG7NgWPa9J/o253hpmSYc3YcrnRxuGeEvys06+vOPkq+wnBpVKJbhXGqzLImggFDPVcetYHiVrLmBEG8gKlNkNGOvHNlOM2xuWeQW3wkf+7Fhf/ZHeLXl/AuACqgZLG+MBxvbYm2ALUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974282; c=relaxed/simple;
	bh=OTvTXRxK6AOYSkWl1o9zLc54PYUQ89VylwIqXYBZRYs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DX8olgSmxob08X2rd5Ub6s8Wp8M72TcRxyAyGxaVHx9I/V31WIhmmOw/w2KsZwjavSWIqoJ6+JBJ5/qLro5TLXTilAM7s8+EY4mlGBrWm1qaHls0SjXqj624Nc1ZSnXSEOw64//+brMz7UVt8GhGaVstOg2G0EqyPcPDUcgCwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvupb5GW; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d399891d6so638534e0c.1;
        Mon, 14 Oct 2024 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728974279; x=1729579079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTvTXRxK6AOYSkWl1o9zLc54PYUQ89VylwIqXYBZRYs=;
        b=cvupb5GWVLXrzW1mmDMIDV9HDocDaekBEBqcOpiabuHrQctP2p7hKzt6hH7joW8sKJ
         k3j9nzYSzNIIMP6Sf1pVxgXC5TNR0B26H1pS4UAXCl6QctaOPM7ARClYMJm3dIuesYbB
         DkPRFhO9wW6cHZvjVfLS4fOnIoTvygBQEpcVSAsVjXQ+cDyW7KJvKqSZgq4SrZD/FDpS
         ks1+5zEshmWc9H+W5sZgoTVvN3WzBHbCQo4agJYde21v41Crb82igMFxW7X4aWqkOYNL
         KYT2aAmTS4ova/Jx8fc+PTRf95UXNbNdcHXZBkZSj5aov6xpLqtYgG2S2yTl/iPyOooK
         cgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728974279; x=1729579079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTvTXRxK6AOYSkWl1o9zLc54PYUQ89VylwIqXYBZRYs=;
        b=Gde+Fohw71dVOohnQ2FI5ZjxccvuIMZTwwx4rVJ+3rBjjjx+BtAs4dev7xnlYX5qql
         YkNdKW469EsUJjIVQMfvjzLY1eBOEJclj2trVWlhIbp8yDxyqbwbJsmaO7uSuoADFyu+
         4fNtq6BLCkCEY+FSl7/gVscXKS5Gzj3l7GpuVM1fOp2Gtq3D1aBvNk55LaRKmC9iV8AT
         PTBt0LqxGzDiwzpTbHZqz1GVKxh7ulp0peOjKaVbXdguwbAQoEU3uC3QRaMoBB4K3Am8
         75H05/Jxh6Ho+Hu04P5OkD3BOBRND3R/aIoOTW71QgkBLzOvDszQ10dUnj6AjHtvFrkp
         Kn4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/GqLniOZwvUKwzaebZOGrXGZUO9/WCgWBxz0uOwXqTlMFWChVcv9gBRg/Ic9uj2BBvj6phQALFY+2d0=@vger.kernel.org, AJvYcCWziauBWI0Gbcn6WBULqfNNgDHokuO+sPLlyB5rNzVAmc8kW+l91snLaeptGQcUxUeFvPVFdAQwmXqj@vger.kernel.org
X-Gm-Message-State: AOJu0YymiXNbhjCxCGh26OMq41fw8CGURTsBBxCaGSZWKDrxLZQOkLOl
	/flu3tMQO/xtfTpCC/wmA9zYMomv5bE4IHJ8TwtAGdNEIzPx3xIa1fDrQPFo3rRUwr+h11hqa02
	vldkgXK4qNIjamoPLYyMG8eZjdDM=
X-Google-Smtp-Source: AGHT+IHuCJhKRAttYYGWPbJukrB5ME2lQ3GdG+qyetP2c1BPzeYFVbccAYepYgOuHJepMeH2mpbxN07grogHCpTjMW0=
X-Received: by 2002:a05:6122:32c9:b0:50c:9834:57b3 with SMTP id
 71dfb90a1353d-50d374b8fcdmr5244664e0c.4.1728974279302; Mon, 14 Oct 2024
 23:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Tue, 15 Oct 2024 14:37:47 +0800
Message-ID: <CAHOo4gL5BYS53rd2bJiKmL1XSg94hn0u4yCPut7NqZ0XZMNf3A@mail.gmail.com>
Subject: WARNING: refcount bug in put_device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Alex Elder <elder@kernel.org>, Aditya Garg <gargaditya08@live.com>, 
	Grant Grundler <grundler@chromium.org>, Kerem Karabay <kekrby@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, Oliver Neukum <oneukum@suse.com>, 
	Yajun Deng <yajun.deng@linux.dev>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "WARNING: refcount bug in put_device" in upstream, we
also have successfully reproduced it manually:

HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/main/6.12.config

console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dcc361978f9b9/lo=
g0
repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dc=
c361978f9b9/repro.report
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dcc361978f9b9/re=
pro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dc=
c361978f9b9/repro.cprog


Please let me know if there is anything I can help with.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh to better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2024/10/15 06:23:01 executed programs: 0
[ 52.946160][ T8459] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
[ 52.948146][ T8459] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
[ 52.949830][ T8459] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
[ 52.951676][ T8459] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
[ 52.953434][ T8459] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > 3
[ 52.955077][ T8459] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
[ 52.978855][ T9837] chnl_net:caif_netlink_parms(): no params data found
[ 53.007227][ T9837] bridge0: port 1(bridge_slave_0) entered blocking state
[ 53.008839][ T9837] bridge0: port 1(bridge_slave_0) entered disabled state
[ 53.010425][ T9837] bridge_slave_0: entered allmulticast mode
[ 53.011911][ T9837] bridge_slave_0: entered promiscuous mode
[ 53.013568][ T9837] bridge0: port 2(bridge_slave_1) entered blocking state
[ 53.015128][ T9837] bridge0: port 2(bridge_slave_1) entered disabled state
[ 53.016866][ T9837] bridge_slave_1: entered allmulticast mode
[ 53.018565][ T9837] bridge_slave_1: entered promiscuous mode
[ 53.027144][ T9837] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 53.029674][ T9837] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 53.038127][ T9837] team0: Port device team_slave_0 added
[ 53.039716][ T9837] team0: Port device team_slave_1 added
[ 53.047451][ T9837] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 53.049010][ T9837] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this interface will be fr.
[ 53.054641][ T9837] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 53.057422][ T9837] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 53.058894][ T9837] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this interface will be fr.
[ 53.063627][ T9837] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 53.070533][ T9837] hsr_slave_0: entered promiscuous mode
[ 53.071302][ T9837] hsr_slave_1: entered promiscuous mode
[ 53.071985][ T9837] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[ 53.072789][ T9837] Cannot create hsr debugfs directory
[ 53.083987][ T9837] netdevsim netdevsim0 netdevsim0: renamed from eth0
[ 53.085055][ T9837] netdevsim netdevsim0 netdevsim1: renamed from eth1
[ 53.086039][ T9837] netdevsim netdevsim0 netdevsim2: renamed from eth2
[ 53.087330][ T9837] netdevsim netdevsim0 netdevsim3: renamed from eth3
[ 53.094030][ T9837] bridge0: port 2(bridge_slave_1) entered blocking state
[ 53.094780][ T9837] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 53.095554][ T9837] bridge0: port 1(bridge_slave_0) entered blocking state
[ 53.096307][ T9837] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 53.101333][ T9837] 8021q: adding VLAN 0 to HW filter on device bond0
[ 53.103084][ T2963] bridge0: port 1(bridge_slave_0) entered disabled state
[ 53.104186][ T2963] bridge0: port 2(bridge_slave_1) entered disabled state
[ 53.106320][ T9837] 8021q: adding VLAN 0 to HW filter on device team0
[ 53.108343][ T92] bridge0: port 1(bridge_slave_0) entered blocking state
[ 53.109940][ T92] bridge0: port 1(bridge_slave_0) entered forwarding state
[ 53.112379][ T2963] bridge0: port 2(bridge_slave_1) entered blocking state
[ 53.113257][ T2963] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 53.137079][ T9837] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 53.141567][ T9837] veth0_vlan: entered promiscuous mode
[ 53.142678][ T9837] veth1_vlan: entered promiscuous mode
[ 53.145297][ T9837] veth0_macvtap: entered promiscuous mode
[ 53.146206][ T9837] veth1_macvtap: entered promiscuous mode
[ 53.147799][ T9837] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
[ 53.148906][ T9837] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 53.150098][ T9837] batman_adv: batadv0: Interface activated: batadv_slave=
_0
[ 53.151677][ T9837] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
[ 53.152781][ T9837] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 53.153971][ T9837] batman_adv: batadv0: Interface activated: batadv_slave=
_1
[ 53.155171][ T9837] netdevsim netdevsim0 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 53.156136][ T9837] netdevsim netdevsim0 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 53.157153][ T9837] netdevsim netdevsim0 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 53.158103][ T9837] netdevsim netdevsim0 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
[ 53.232002][ T3671] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 53.233031][ T3671] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50=
:50
[ 53.238434][ T119] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 53.239437][ T119] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:=
50
[ 53.476459][ T80] usb 1-1: new high-speed USB device number 2 using dummy_=
hcd
[ 53.626458][ T80] usb 1-1: Using ep0 maxpacket: 8
[ 53.628120][ T80] usb 1-1: config 8 has an invalid interface number:
207 but max is 3
[ 53.629284][ T80] usb 1-1: config 8 has an invalid interface number:
146 but max is 3
[ 53.630397][ T80] usb 1-1: config 8 has an invalid descriptor of
length 0, skipping remainder of the config
[ 53.631751][ T80] usb 1-1: config 8 has 2 interfaces, different from
the descriptor's value: 4
[ 53.632959][ T80] usb 1-1: config 8 has no interface number 0
[ 53.633781][ T80] usb 1-1: config 8 has no interface number 1
[ 53.634613][ T80] usb 1-1: config 8 interface 207 altsetting 6 has an
invalid descriptor for endpoint zero, skipping
[ 53.636082][ T80] usb 1-1: config 8 interface 207 altsetting 6 has a
duplicate endpoint with address 0x8, skipping
[ 53.637583][ T80] usb 1-1: config 8 interface 207 altsetting 6
endpoint 0x5 has invalid maxpacket 959, setting to 64
[ 53.639029][ T80] usb 1-1: config 8 interface 207 altsetting 6 has a
duplicate endpoint with address 0xB, skipping
[ 53.640479][ T80] usb 1-1: config 8 interface 207 altsetting 6
endpoint 0x2 has invalid maxpacket 512, setting to 64
[ 53.641947][ T80] usb 1-1: config 8 interface 146 altsetting 9 has 0
endpoint descriptors, different from the interface descriptor's value:
8
[ 53.643707][ T80] usb 1-1: config 8 interface 207 has no altsetting 0
[ 53.644636][ T80] usb 1-1: config 8 interface 146 has no altsetting 0
[ 53.646775][ T80] usb 1-1: New USB device found, idVendor=3D0424,
idProduct=3Dcf30, bcdDevice=3D86.3f
[ 53.648010][ T80] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[ 53.649089][ T80] usb 1-1: Product: syz
[ 53.649662][ T80] usb 1-1: Manufacturer: syz
[ 53.650295][ T80] usb 1-1: SerialNumber: syz
[ 53.651764][T10865] raw-gadget.0 gadget.0: fail, usb_ep_enable returned -2=
2
[ 53.856332][ T80] usb 1-1: USB disconnect, device number 2
[ 53.857522][ T80] ------------[ cut here ]------------
[ 53.858121][ T80] refcount_t: underflow; use-after-free.
[ 53.858848][ T80] WARNING: CPU: 6 PID: 80 at lib/refcount.c:28
refcount_warn_saturate
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/refcount.c:28
(discriminator 3))
[ 53.859860][ T80] Modules linked in:
[ 53.860298][ T80] CPU: 6 UID: 0 PID: 80 Comm: kworker/6:1 Not tainted
6.12.0-rc1 #5
[ 53.861170][ T80] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[ 53.862181][ T80] Workqueue: usb_hub_wq hub_event
[ 53.862756][ T80] RIP: 0010:refcount_warn_saturate
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/refcount.c:28
(discriminator 3))
[ 53.863448][ T80] Code: ff 89 de e8 83 16 c8 fe 84 db 0f 85 1c ff ff
ff e8 66 14 c8 fe c6 05 81 f8 85 04 01 90 48 c7 c7 98 fc 50 86 e8 e2
ae af fe 90 <0f> 0b 90 90 e9 f9 fe ff ff e8 43 11
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: ff 89 de e8 83 16 decl 0x1683e8de(%rcx)
6: c8 fe 84 db enter $0x84fe,$0xdb
a: 0f 85 1c ff ff ff jne 0xffffffffffffff2c
10: e8 66 14 c8 fe call 0xfffffffffec8147b
15: c6 05 81 f8 85 04 01 movb $0x1,0x485f881(%rip) # 0x485f89d
1c: 90 nop
1d: 48 c7 c7 98 fc 50 86 mov $0xffffffff8650fc98,%rdi
24: e8 e2 ae af fe call 0xfffffffffeafaf0b
29: 90 nop
2a:* 0f 0b ud2 <-- trapping instruction
2c: 90 nop
2d: 90 nop
2e: e9 f9 fe ff ff jmp 0xffffffffffffff2c
33: e8 .byte 0xe8
34: 43 rex.XB
35: 11 .byte 0x11

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f 0b ud2
2: 90 nop
3: 90 nop
4: e9 f9 fe ff ff jmp 0xffffffffffffff02
9: e8 .byte 0xe8
a: 43 rex.XB
b: 11 .byte 0x11
[ 53.865584][ T80] RSP: 0018:ffff88810036fa60 EFLAGS: 00010282
[ 53.866248][ T80] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
ffffffff811c855c
[ 53.867170][ T80] RDX: ffff888101400000 RSI: ffffffff811c8565 RDI:
0000000000000001
[ 53.868051][ T80] RBP: ffff88810036fa70 R08: 0000000000000000 R09:
205b5d3132313835
[ 53.868929][ T80] R10: 0000000000000000 R11: 205d303854202020 R12:
ffff88812b896838
[ 53.869831][ T80] R13: ffff88812b896838 R14: ffff88812b895c50 R15:
0000000000000000
[ 53.870713][ T80] FS: 0000000000000000(0000)
GS:ffff88813bb80000(0000) knlGS:0000000000000000
[ 53.871697][ T80] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 53.872422][ T80] CR2: 00007fd472328988 CR3: 000000010a042000 CR4:
00000000000006f0
[ 53.873304][ T80] Call Trace:
[ 53.873669][ T80] <TASK>
[ 53.873995][ T80] ? show_regs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:479)
[ 53.874481][ T80] ? __warn
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/panic.c:74=
8)
[ 53.874941][ T80] ? refcount_warn_saturate
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/refcount.c:28
(discriminator 3))
[ 53.875567][ T80] ? report_bug
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/bug.c:201
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/bug.c:219)
[ 53.876074][ T80] ? refcount_warn_saturate
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/refcount.c:28
(discriminator 3))
[ 53.876738][ T80] ? refcount_warn_saturate
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/refcount.c:28
(discriminator 3))
[ 53.877369][ T80] ? handle_bug
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/t=
raps.c:285)
[ 53.877864][ T80] ? exc_invalid_op
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/t=
raps.c:309
(discriminator 1))
[ 53.878399][ T80] ? asm_exc_invalid_op
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/includ=
e/asm/idtentry.h:621)
[ 53.878964][ T80] ? __warn_printk
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/c=
ontext_tracking.h:161
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/panic.c:799=
)
[ 53.879493][ T80] ? __warn_printk
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/panic.c:80=
0)
[ 53.880017][ T80] ? refcount_warn_saturate
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/refcount.c:28
(discriminator 3))
[ 53.880635][ T80] kobject_put
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/kobject.c:739=
)
[ 53.881131][ T80] put_device
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/core=
.c:3784)
[ 53.881600][ T80] hdm_disconnect
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/most/most=
_usb.c:1130)
[ 53.882102][ T80] usb_unbind_interface
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/=
driver.c:464)
[ 53.882685][ T80] ? __pfx_usb_unbind_interface
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/=
driver.c:432)
[ 53.883329][ T80] device_remove
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/dd.c=
:570)
[ 53.883831][ T80] device_release_driver_internal
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/dd.c=
:1275
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/dd.c:=
1296)
[ 53.884518][ T80] device_release_driver
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/dd.c=
:1320)
[ 53.885092][ T80] bus_remove_device
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/k=
object.h:193
(discriminator 3)
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/base.=
h:73
(discriminator 3)
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/bus.c=
:583
(discriminator 3))
[ 53.885648][ T80] device_del
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/core=
.c:3865)
[ 53.886134][ T80] ? device_unregister
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/base/core=
.c:3907)
[ 53.886729][ T80] usb_disable_device
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/=
message.c:1408
(discriminator 2))
[ 53.887302][ T80] usb_disconnect
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/input/mis=
c/yealink.c:591
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/input/misc=
/yealink.c:614)
[ 53.887830][ T80] ? usb_control_msg
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/=
message.c:163)
[ 53.888388][ T80] ? hub_port_warm_reset_required
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/=
hub.c:2905)
[ 53.889045][ T80] hub_event
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/=
hub.c:5367
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/h=
ub.c:5661
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/h=
ub.c:5821
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/drivers/usb/core/h=
ub.c:5903)
[ 53.889547][ T80] ? kick_pool
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.=
c:1281)
[ 53.890032][ T80] process_one_work
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.=
c:3234)
[ 53.890582][ T80] worker_thread
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.=
c:3304
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.c=
:3391)
[ 53.891105][ T80] ? __pfx_worker_thread
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.=
c:3337)
[ 53.891687][ T80] kthread
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kthread.c:=
389)
[ 53.892142][ T80] ? __pfx_kthread
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kthread.c:=
342)
[ 53.892666][ T80] ret_from_fork
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/p=
rocess.c:153)
[ 53.893168][ T80] ? __pfx_kthread
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kthread.c:=
342)
[ 53.893687][ T80] ret_from_fork_asm
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/en=
try_64.S:257)
[ 53.894225][ T80] </TASK>

