Return-Path: <linux-kernel+bounces-362677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1F99B7F0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 04:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0275281670
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 02:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B508836;
	Sun, 13 Oct 2024 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whg+Vy7/"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F656FDC
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728785015; cv=none; b=BTwiqsruaUPiaC/ggPy8LXhcYfeVDQLMw3+JwBoKdyFwvVZgLNcGp4PFTGlzzpzi3yOPZ80g1aNnRnBZ56gLMTLxjuKLWqMWJxfNJo0G3V9WcjmywDCbCFLFWQfhT4PBAGUy0jtRISFRQb7JXR/fYKmOaaguESdXO0fOPXmF5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728785015; c=relaxed/simple;
	bh=mYABvBvrzcLdzpIVir3DZTNBI4y4Oeg9oiYtOeU1eSU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=go8ZTouo0wExgz9FTNwL+DRLAHVy/laGIVG/alpXAW7U4xmJ8oRqogWoVwXAFH3FG5uU0DTeObKRLzEAyM+cDSgFs4l1NG0iVi/+3ftnmROayhQAnE/YM/v8jOhTaFtPSITgj46CztsF0KS6C1cAwfFxZix+iWjvOgjgqs7FbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whg+Vy7/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-502aeeb791eso1825983e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 19:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728785012; x=1729389812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mYABvBvrzcLdzpIVir3DZTNBI4y4Oeg9oiYtOeU1eSU=;
        b=Whg+Vy7/hnfae7cOFiPFPMXAEfCbriJgOxEKOw77FIUEjkdDWec0a8XErRqztRP7hu
         nhd/5hEaWodxvYnGiULD52jRPW5fd+UaIgEDEyFHJiTT6/v5PNgK5cNfukXR957F7Z/7
         q82OHE5S76cAK7HmH2HO0D0fCQ4XGYB/VyKuwq6gzK3rz6vE1yVWxssBBlh3KVljEr0i
         WavFwaSCQTwij8oBUc10gnFBxH9UlUL6P/ITPO1zCVFXPcRJOeVj9ThMnzuqXCSuFwuN
         A1oSsE2XoKi+D9DP8FVHvIIE0z5lksmg4QbfQg9+HD0HaDOBRB40Kql3N6v08vuaxOWD
         jekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728785012; x=1729389812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYABvBvrzcLdzpIVir3DZTNBI4y4Oeg9oiYtOeU1eSU=;
        b=W3D4KEXIdz3j5yqG/gaQxU//GgnTlFRf2pTWoN6zbUsjn9UNbMpvLrG9rNOEs0B5YN
         cFRFyQHaiPjHSMoUvUtUWJR31MJWIl5TnejLb7Kr4T5xwpVFrL6UK9TCk1yOFbIT/gyO
         /1E4s8oBOi0msXyWJc8j82z62sQ26MSuOCJoGdTh24zDvaSgfq+Nhh9wbn7m9w+O30cb
         I46qLkwX04wUmajrr43FM5BkqU2272lHB/cfygDIt6aYzbTUrPUorvnrE/TVBXmpkQqR
         v1srkLq4ym/tb3YQtoX2exKKzPFaw1SFXmFjutvWNh4VIn5rjEOe5GaGAn8+skjjiqsd
         EzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYD4WjP1ETzJ0NOAyFrUqvZMj/dYbFXn8Dnm7XBfNqpNabH27Z7QRhTXo5QMIidNIocwqDmk3olISmV1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywam6QXQSHwURSUsNZQ+qScFPpHGKHScB6jMkz00Ke+RJkp6kh4
	ALh9tBWy+6g+4tuLeYOXghbfKzcbCkKV1p3fV1drTrqoZFtfYBHprx/lmdoJnlkd0nOF1lqcSbW
	qmRelnKEboI7MwCiopTt3eZ4KOdA=
X-Google-Smtp-Source: AGHT+IF66h6oFegQtBX039NkprUv4lusziFsdmoTctYDICKR9w6R+K7D8J+VqJOad6ZJ5br4q1x0YcRCW9yAOQHgrQU=
X-Received: by 2002:a05:6122:923:b0:50d:4b8d:6750 with SMTP id
 71dfb90a1353d-50d4b8d6cfdmr493864e0c.1.1728785011666; Sat, 12 Oct 2024
 19:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Sun, 13 Oct 2024 10:03:20 +0800
Message-ID: <CAHOo4g+uRs3dNNps0uX8=Gma-u+YJs1yyRKPK5=oUR5L4G7VJA@mail.gmail.com>
Subject: kernel BUG in binder_alloc_deferred_release
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "kernel BUG in binder_alloc_deferred_release" (it
seems a bug in
drivers/android/binder_alloc.c) in upstream:
This bug seems to have been triggered before and fixed, but it can
still be triggered now.


HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/main/6.12.config

console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/ff31cdc13bb8c6774ccf08dc80809804c2afca4d/lo=
g0
repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/ff31cdc13bb8c6774ccf08dc80809=
804c2afca4d/repro.report
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/ff31cdc13bb8c6774ccf08dc80809804c2afca4d/re=
pro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/ff31cdc13bb8c6774ccf08dc80809=
804c2afca4d/repro.cprog


Please let me know if there is anything I can help.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh for better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
2024/10/13 01:47:52 parsed 1 programs
root@syzkaller:~# ./syz-execprog
/data/ghui/docker_data/workdir/upstream/ghui_syzkaller_upstream_linux_v6.11=
_3_upstream/crashes/ff31cdc13bb8c6774ccf08dc80809804c2afca4d/repro.pg
[ 192.759218][ T1331] ieee802154 phy0 wpan0: encryption failed: -22
[ 192.760941][ T1331] ieee802154 phy1 wpan1: encryption failed: -22
[ 193.852410][T10982] Adding 124996k swap on ./swap-file. Priority:0
extents:1 across:124996k
[ 194.963864][ T8462] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[ 194.964921][ T8462] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[ 194.966160][ T8462] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[ 194.967171][ T8462] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[ 194.968160][ T8462] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[ 194.969268][ T8462] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[ 195.032829][ T64] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 195.033922][ T64] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:=
50
[ 195.035791][ T58] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 195.036719][T11007] chnl_net:caif_netlink_parms(): no params data found
[ 195.036895][ T58] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:=
50
[ 195.054761][T11007] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 195.055659][T11007] bridge0: port 1(bridge_slave_0) entered disabled stat=
e
[ 195.056539][T11007] bridge_slave_0: entered allmulticast mode
[ 195.057395][T11007] bridge_slave_0: entered promiscuous mode
[ 195.058310][T11007] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 195.059247][T11007] bridge0: port 2(bridge_slave_1) entered disabled stat=
e
[ 195.060148][T11007] bridge_slave_1: entered allmulticast mode
[ 195.061150][T11007] bridge_slave_1: entered promiscuous mode
[ 195.067586][T11007] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 195.069248][T11007] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 195.075434][T11007] team0: Port device team_slave_0 added
[ 195.076398][T11007] team0: Port device team_slave_1 added
[ 195.081710][T11007] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 195.082631][T11007] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 195.085913][T11007] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 195.087436][T11007] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 195.088343][T11007] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 195.091832][T11007] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 195.099719][T11007] hsr_slave_0: entered promiscuous mode
[ 195.100699][T11007] hsr_slave_1: entered promiscuous mode
[ 195.123720][T11007] netdevsim netdevsim5 netdevsim0: renamed from eth0
[ 195.125065][T11007] netdevsim netdevsim5 netdevsim1: renamed from eth1
[ 195.126308][T11007] netdevsim netdevsim5 netdevsim2: renamed from eth2
[ 195.127564][T11007] netdevsim netdevsim5 netdevsim3: renamed from eth3
[ 195.133923][T11007] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 195.134876][T11007] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 195.135840][T11007] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 195.136762][T11007] bridge0: port 1(bridge_slave_0) entered forwarding st=
ate
[ 195.143016][T11007] 8021q: adding VLAN 0 to HW filter on device bond0
[ 195.145225][ T120] bridge0: port 1(bridge_slave_0) entered disabled state
[ 195.146438][ T120] bridge0: port 2(bridge_slave_1) entered disabled state
[ 195.149103][T11007] 8021q: adding VLAN 0 to HW filter on device team0
[ 195.151119][ T2565] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 195.152048][ T2565] bridge0: port 1(bridge_slave_0) entered forwarding st=
ate
[ 195.153737][ T2565] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 195.154627][ T2565] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 195.174758][T11007] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 195.196944][T11007] veth0_vlan: entered promiscuous mode
[ 195.198374][T11007] veth1_vlan: entered promiscuous mode
[ 195.201965][T11007] veth0_macvtap: entered promiscuous mode
[ 195.203128][T11007] veth1_macvtap: entered promiscuous mode
[ 195.205343][T11007] batman_adv: batadv0: Interface activated: batadv_slav=
e_0
[ 195.207346][T11007] batman_adv: batadv0: Interface activated: batadv_slav=
e_1
[ 195.208989][T11007] netdevsim netdevsim5 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 195.210145][T11007] netdevsim netdevsim5 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 195.211297][T11007] netdevsim netdevsim5 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 195.212454][T11007] netdevsim netdevsim5 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
2024/10/13 01:47:57 executed programs: 0
[ 195.296225][ T8462] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
[ 195.297345][ T8462] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
[ 195.298341][ T8462] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
[ 195.299689][ T8462] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
[ 195.300884][ T8462] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > 3
[ 195.301922][ T8462] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
[ 195.324278][T12398] chnl_net:caif_netlink_parms(): no params data found
[ 195.346760][T12398] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 195.348487][T12398] bridge0: port 1(bridge_slave_0) entered disabled stat=
e
[ 195.350195][T12398] bridge_slave_0: entered allmulticast mode
[ 195.351707][T12398] bridge_slave_0: entered promiscuous mode
[ 195.353382][T12398] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 195.354876][T12398] bridge0: port 2(bridge_slave_1) entered disabled stat=
e
[ 195.356344][T12398] bridge_slave_1: entered allmulticast mode
[ 195.357846][T12398] bridge_slave_1: entered promiscuous mode
[ 195.365927][T12398] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 195.368413][T12398] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 195.375016][T12398] team0: Port device team_slave_0 added
[ 195.375945][T12398] team0: Port device team_slave_1 added
[ 195.380224][T12398] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 195.381137][T12398] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 195.384351][T12398] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 195.385766][T12398] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 195.386648][T12398] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 195.389878][T12398] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 195.395573][T12398] hsr_slave_0: entered promiscuous mode
[ 195.396340][T12398] hsr_slave_1: entered promiscuous mode
[ 195.397057][T12398] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[ 195.397905][T12398] Cannot create hsr debugfs directory
[ 196.052170][T12398] netdevsim netdevsim0 netdevsim0: renamed from eth0
[ 196.053474][T12398] netdevsim netdevsim0 netdevsim1: renamed from eth1
[ 196.054690][T12398] netdevsim netdevsim0 netdevsim2: renamed from eth2
[ 196.055933][T12398] netdevsim netdevsim0 netdevsim3: renamed from eth3
[ 196.068366][T12398] 8021q: adding VLAN 0 to HW filter on device bond0
[ 196.070649][T12398] 8021q: adding VLAN 0 to HW filter on device team0
[ 196.072163][ T120] bridge0: port 1(bridge_slave_0) entered blocking state
[ 196.073063][ T120] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 196.074915][T13028] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 196.075858][T13028] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 196.096752][T12398] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 196.102091][T12398] veth0_vlan: entered promiscuous mode
[ 196.103529][T12398] veth1_vlan: entered promiscuous mode
[ 196.106919][T12398] veth0_macvtap: entered promiscuous mode
[ 196.108089][T12398] veth1_macvtap: entered promiscuous mode
[ 196.110056][T12398] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
[ 196.111378][T12398] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 196.112809][T12398] batman_adv: batadv0: Interface activated: batadv_slav=
e_0
[ 196.114725][T12398] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
[ 196.116099][T12398] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 196.117515][T12398] batman_adv: batadv0: Interface activated: batadv_slav=
e_1
[ 196.119427][T12398] netdevsim netdevsim0 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 196.120550][T12398] netdevsim netdevsim0 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 196.121647][T12398] netdevsim netdevsim0 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 196.122751][T12398] netdevsim netdevsim0 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
[ 196.199683][ T120] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 196.200795][ T120] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50=
:50
[ 196.204740][ T2565] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 196.206663][ T2565] wlan1: Creating new IBSS network, BSSID 50:50:50:50:5=
0:50
[ 196.213519][T13446] FAULT_INJECTION: forcing a failure.
[ 196.213519][T13446] name fail_usercopy, interval 1, probability 0,
space 0, times 0
[ 196.215262][T13446] CPU: 1 UID: 0 PID: 13446 Comm: syz.0.15 Not
tainted 6.12.0-rc1 #5
[ 196.216313][T13446] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[ 196.217531][T13446] Call Trace:
[ 196.217975][T13446] <TASK>
[196.218375][T13446] dump_stack_lvl
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/dump_stack.c:=
123)
[196.218998][T13446] dump_stack
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/dump_stack.c:=
130)
[196.219556][T13446] should_fail_ex
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/fault-inject.=
c:53
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/fault-inject.c=
:154)
[196.220201][T13446] should_fail
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/fault-inject.=
c:165)
[196.220761][T13446] should_fail_usercopy
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/fault-inject-=
usercopy.c:38)
[196.221429][T13446] _copy_to_user
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/u=
access.h:184
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/usercopy.c:26)
[196.222024][T13446] simple_read_from_buffer
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/libfs.c:1125)
[196.222749][T13446] proc_fail_nth_read
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/proc/base.c:14=
81)
[196.223431][T13446] ? rw_verify_area
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/read_write.c:4=
75)
[196.224072][T13446] vfs_read
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/read_write.c:5=
67)
[196.224639][T13446] ? __pfx_proc_fail_nth_read
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/proc/base.c:14=
71)
[196.225399][T13446] ? __sanitizer_cov_trace_const_cmp1
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:302=
)
[196.226251][T13446] ? fput
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/file_table.c:5=
03)
[196.226786][T13446] ? fdget_pos
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/file.c:1190)
[196.227380][T13446] ksys_read
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/read_write.c:7=
13)
[196.227954][T13446] __x64_sys_read
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/read_write.c:7=
20)
[196.228558][T13446] x64_sys_call
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/sy=
scall_64.c:36)
[196.229192][T13446] do_syscall_64
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/co=
mmon.c:52
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/com=
mon.c:83)
[196.229788][T13446] entry_SYSCALL_64_after_hwframe
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/en=
try_64.S:130)
[ 196.230584][T13446] RIP: 0033:0x7f491599b02c
[ 196.231175][T13446] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c
24 08 e8 39 03 03 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24
08 31 c0 0f 05 <48> 3d 00 f0 ff ff 78
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: ec in (%dx),%al
1: 28 48 89 sub %cl,-0x77(%rax)
4: 54 push %rsp
5: 24 18 and $0x18,%al
7: 48 89 74 24 10 mov %rsi,0x10(%rsp)
c: 89 7c 24 08 mov %edi,0x8(%rsp)
10: e8 39 03 03 00 call 0x3034e
15: 48 8b 54 24 18 mov 0x18(%rsp),%rdx
1a: 48 8b 74 24 10 mov 0x10(%rsp),%rsi
1f: 41 89 c0 mov %eax,%r8d
22: 8b 7c 24 08 mov 0x8(%rsp),%edi
26: 31 c0 xor %eax,%eax
28: 0f 05 syscall
2a:* 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax <-- trapping instructio=
n
30: 78 .byte 0x78

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax
6: 78 .byte 0x78
[ 196.233702][T13446] RSP: 002b:00007f491683af90 EFLAGS: 00000246
ORIG_RAX: 0000000000000000
[ 196.234802][T13446] RAX: ffffffffffffffda RBX: 00007f4915b65f80 RCX:
00007f491599b02c
[ 196.235850][T13446] RDX: 000000000000000f RSI: 00007f491683b020 RDI:
0000000000000004
[ 196.236895][T13446] RBP: 00007f491683b010 R08: 0000000000000000 R09:
0000000000000000
[ 196.237927][T13446] R10: 0000000000000011 R11: 0000000000000246 R12:
0000000000000002
[ 196.238973][T13446] R13: 0000000000000000 R14: 00007f4915b65f80 R15:
00007f491681b000
[ 196.240020][T13446] </TASK>

