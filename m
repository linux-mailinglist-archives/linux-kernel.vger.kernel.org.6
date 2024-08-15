Return-Path: <linux-kernel+bounces-287584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A0952993
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D121C21AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AA17A59B;
	Thu, 15 Aug 2024 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="dmqB7oLQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DE41AAC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705339; cv=none; b=Bqsl7vB0gU7rkMBA+HJ4GLeO5zOlZLuxq48PWi2SQr/2EQ5ly0z4LX3c2N92rkYLoSo6Qs/0InqJIWHfR+9nhYhxgDhWRwML0sjigNQgFgglaPY6ekNDNGQt34xF6TghklXgMB0y7tetqEaRokX30pVeLMLAtJtaeCQAKXQDm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705339; c=relaxed/simple;
	bh=0f8oia0kVOYVNnQUoLHlgmHduqJZjTju7a2LblSQ8vY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYQConTs143DP8sQpO2I3YYNqyJvdD9eVFq10HMxybL1QPxQjNnyVWxG1M/CPBEBDMqrfSl2szLe4Akpu1b0Mm15XCZJvQzTpokOAN/lgXaXmh7loCEDhVCNRss3roPiOp2qO4ObL1BXR6vxedO7VIu3cNfX5SC6osIUQ9ihB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=dmqB7oLQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd530a4eso963928e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1723705334; x=1724310134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAslx6WQu0HWG5VYqKA6S6Ff3xwjQguT3tFW108uL18=;
        b=dmqB7oLQfBLsE1AfQdVb4xOpm0xnwix0q0UWi4HgF6d5d8KRijxa00XnWZrUIecM2I
         k9QxVxrS1Tn0F4r8h8jrj+8WNZCOL9NugCb3CrC1Iqe1vPOwt9pZKbhDQVRilwYEUCCO
         WT4aUtax90/AVcnEt7/Apj2d0eZ4CAnwPFQ41P3hF+y8W9ZHpGYkKbnhLHPlYGnD9S6d
         vEHsyBHJMtw73M183JJBRNqBVnon9TcT2Q7uuNe/wUotR/tXoeCq0MIJegtFcgrw2WMT
         4xbp/XDMmyTiMqBW1GSNf6w/7dTUdiupYqcJDVmIW4x4pqbB88lU97UzXSwDtglk9pnf
         SsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723705334; x=1724310134;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAslx6WQu0HWG5VYqKA6S6Ff3xwjQguT3tFW108uL18=;
        b=eMzIvm8DUnPcI4tzcX9JxzYvzop5MP/dfC6ag5w8gmOMOX9sgkVwqPmxZs1uWhabOq
         p3HgsxtS+NYfdgtBEmVAJGdiLspdGWj/hNZ+EiD+oNMz7awnwPgAzCPNGMJaR6UVbvOp
         iehuDtmCBubHygmBvmlRItcv38G4mMgw6340WlkXtSx6A5PLpVR3zHFlvWoSu+ngZKOC
         rL4q4CgaczxeS3eZQzSQEJfYISdi0E5zhhVofOzMtSSnQTnETy0HrL8cILp2ae8jW1Yz
         zsNXYSnlTHpj3nrwpB0CV7lXSJxoUtlvei8oe8UENIRTPPZKaTBqmJr+r0rj8+zXMZzE
         bcKg==
X-Forwarded-Encrypted: i=1; AJvYcCXAvQkanSw/zWFE5zt5udb2wVKXePr5ewWhi0ynZHGQRlA5+c5u7Ocg4VFI0x9yjWOjgRN3IsB3v4svd3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhfFY6dLtT/jAVfIs5seU/b+ZSSVxg0OhK1Ublrpk27IqoMSKH
	goibEYZSVL/acpOdQc7yL3s2gO4ZtPY+lwyqU5IchAVEX1E89VPhL2KcNTr/SrdAk/FJSLEoVSH
	P
X-Google-Smtp-Source: AGHT+IGf+smvoS59QpQDtpSMbkWGFu2UiUmXrboM7kAbTjxnXldadlUv/Nc0OfK4ij/LahEWFimnlQ==
X-Received: by 2002:a05:6512:1322:b0:52f:c148:f5e4 with SMTP id 2adb3069b0e04-532eda7a53emr3287550e87.21.1723705333693;
        Thu, 15 Aug 2024 00:02:13 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d42503fsm107070e87.283.2024.08.15.00.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:02:12 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, netdev
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: understanding switchdev notifications
In-Reply-To: <d3244cef-9c6b-4bba-b184-4139f12224df@alliedtelesis.co.nz>
References: <d5c526af-5062-42ed-9d92-f7fc97a5d4bd@alliedtelesis.co.nz>
 <87jzgjfvcl.fsf@waldekranz.com>
 <d3244cef-9c6b-4bba-b184-4139f12224df@alliedtelesis.co.nz>
Date: Thu, 15 Aug 2024 09:02:11 +0200
Message-ID: <87h6bmfevg.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On tor, aug 15, 2024 at 10:18, Chris Packham <chris.packham@alliedtelesis.c=
o.nz> wrote:
> Hi Tobias,

Hi Chris!

> On 14/08/24 18:54, Tobias Waldekranz wrote:
>> On tor, aug 08, 2024 at 12:48, Chris Packham <chris.packham@alliedtelesi=
s.co.nz> wrote:
>>> Hi,
>>>
>>> I'm trying to get to grips with how the switchdev notifications are
>>> supposed to be used when developing a switchdev driver.
>>>
>>> I have been reading through
>>> https://www.kernel.org/doc/html/latest/networking/switchdev.html which
>>> covers a few things but doesn't go into detail around the notifiers that
>>> one needs to implement for a new switchdev driver (which is probably
>>> very dependent on what the hardware is capable of).
>>>
>>> Specifically right now I'm looking at having a switch port join a vlan
>>> aware bridge. I have a configuration something like this
>>>
>>>   =C2=A0=C2=A0=C2=A0 ip link add br0 type bridge vlan_filtering 1
>>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p5 master br0
>>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p1 master br0
>>>   =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev br0 self
>>>   =C2=A0=C2=A0=C2=A0 ip link add link br0 br0.2 type vlan id 2
>>>   =C2=A0=C2=A0=C2=A0 ip addr add dev br0.2 192.168.2.1/24
>>>   =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan5 pvid untagged
>>>   =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan1
>>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p5 up
>>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p1 up
>>>   =C2=A0=C2=A0=C2=A0 ip link set br0 up
>>>   =C2=A0=C2=A0=C2=A0 ip link set br0.2 up
>>>
>>> Then I'm testing by sending a ping to a nonexistent host on the
>>> 192.168.2.0/24 subnet and looking at the traffic with tcpdump on another
>>> device connected to sw1p5.
>>>
>>> I'm a bit confused about how I should be calling
>>> switchdev_bridge_port_offload(). It takes two netdevs (brport_dev and
>>> dev) but as far as I've been able to see all the callers end up passing
>>> the same netdev for both of these (some create a driver specific brport
>>> but this still ends up with brport->dev and dev being the same object).
>> In the simple case when a switchport is directly attached to a bridge,
>> brport_dev and dev will be the same. If the attachment is indirect, via
>> a bond for example, they will differ:
>>
>>         br0
>>         /
>>      bond0
>>     /    \
>> sw1p1  sw1p5
>>
>> In the setup above, the bridge has no reference to any sw*p* interfaces,
>> all generated notifications will reference "bond0". By including the
>> switchdev port in the message back to the bridge, it can perform
>> validation on the setup; e.g. that bond0 is not made up of interfaces
>> from different hardware domains.
>
> Ah that makes sense. I haven't got to bonds yet so I hadn't hit that case.
>
>>> I've figured out that I need to set tx_fwd_offload=3Dtrue so that the
>>> bridge software only sends one packet to the hardware. That makes sense
>>> as a way of saying the my hardware can take care of sending the packet
>>> out the right ports.
>>>
>>> I do have a problem that what I get from the bridge has a vlan tag
>>> inserted (which makes sense in sw when the packet goes from br0.2 to
>>> br0). But I don't actually need it as the hardware will insert a tag for
>>> me if the port is setup for egress tagging. I can shuffle the Ethernet
>>> header up but I was wondering if there was a way of telling the bridge
>>> not to insert the tag?
>> Signaling tx_fwd_offload=3Dtrue means assuming responsibility for
>> delivering each packet to all ports that the bridge would otherwise have
>> sent individual skbs for.
>>
>> Let's expand your setup slightly, and see why you need the tag:
>>
>>     br0.2 br0.3
>>         \ /
>>         br0
>>        / |  \
>>       /  |   \
>> sw1p1 sw1p3  sw1p5
>> (2U)  (3U)  (2T,3T)
>>
>> sw1p5 is now a trunk. We can trigger an ARP broadcast to be sent out
>> either via br0.2 or br0.3, depending on the subnet we choose to target.
>>
>> Your driver will receive a single skb to transmit, and skb->dev can be
>> set to any of sw1p{1,3,5} depending on config order, FDB entries
>> (i.e. the order of previously received packets) etc., and is thus
>> nondeterministic.
>>
>> So presumably, even though you might need to remove the 802.1Q tag from
>> the frame, you need some way of tagging the packet with the correct VID
>> in order for the hardware to do the right thing; possibly via a field in
>> the vendor's hardware specific tag.
>
> I did eventually find NETIF_F_HW_VLAN_CTAG_TX which stops the packet=20
> data coming down to the switch driver with a vlan tag inserted. The=20
> intended egress vlan is still available via skb_vlan_tag_get_id() so I=20
> can add it to hardware specific tag (which for me is part of the TX DMA=20
> descriptor) and I don't need to shuffle any bytes around which is great.

I see now that I might have misunderstood your original question. You
just wanted to avoid the VLAN info being moved from skb->vlan_tci into
skb->data - good that you found the right netif flag!

>>> Finally I'm confused about the atomic_nb/atomic_nb parameters. Some
>>> drivers just pass NULL and others pass the same notifier blocks that
>>> they've already registered with
>>> register_switchdev_notifier()/register_switchdev_notifier(). If
>>> notifiers are registered why does switchdev_bridge_port_offload() take
>>> them as parameters?
>> Because when you add a port to the bridge, lots of stuff that you want
>> to offload might already have been configured. E.g., imagine that you
>> were to add vlan 2 to br0 before adding the switchports; then you
>> probably need those events to be replayed to the new ports in order to
>> add your CPU-facing switchport to vlan 2. However, we do not want to
>> bother existing bridge members with duplicated events (and risk messing
>> up any reference counters they might maintain for these
>> objects). Therefore we bypass the standard notifier calls and "unicast"
>> the replay events only to the driver for the port being added.
>
> This part I still don't get. I understand that there may be scenarios=20
> where switchdev decides it needs to unicast events to a specific device.=
=20

That's the thing, switchdev (really: the bridge) can't always decide
when this need arises. Imagine this transition:

      br0                  br0
      /                    /
   bond0      =3D>        bond0
    / \                /  |  \
swp1  swp2        swp1  swp2  swp3

From the bridge's perspective, the two configurations are the same:
There's one attached port, which is still a member of the same VLANs,
multicast groups etc. that it was before the new port was added to the
bond.

In order to get to the right hardware configuration though, we typically
need to add swp3 to all of those objects that bond0 is a member of. If
it would be the bridge's responsibility to handle that, then it would
have to consern itself with the inner workings of all kinds of
interfaces that can be attached to it.

The current "replay request" model instead places that responsibility on
each individual driver, which is the entity that knows about the
particular offloads that it supports.

> But why does the caller of switchdev_bridge_port_offload() need to make=20
> that distinction?

AFAIK, the core idea with notifier blocks is to decouple the publisher
from its subscribers. I.e. switchdev does not know anything about the
subscribers listening to the notifications that it generates. It just
publishes information to the chain and checks for any errors
reported. In order to address an individual subscriber, that subscriber
must instead be the initiator and pass along the callbacks.

>>> Thanks,
>>> Chris

