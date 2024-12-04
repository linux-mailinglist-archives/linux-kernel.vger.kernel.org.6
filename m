Return-Path: <linux-kernel+bounces-430922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D43CF9E374A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A82B25952
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317D1AE877;
	Wed,  4 Dec 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="EzytqyZx"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88961199EA8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307152; cv=none; b=Lg0aFI0z5kTX+UTZH0fjqHLtRFAoZHTccEbL05pM/BdsG53YNLI8p/em7rqk03pj6c73+kYe5kBPyOVStX9GOuCNV48XFkRw0RYjCTLTCBtNehTC461sGlPcqmgkoTD3jSU4Zg9h+HPcISzw9sD/G+mgZKnLpPOl6HFFMTJSIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307152; c=relaxed/simple;
	bh=bDcBWgVILMB12NHWB4fcs1W4araBsBKWumSB2kQnUP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1LsZEdk6xvHxJB9nuAdo727z2hpZCfFNsPp55J1o9YjMsZ9gLhm8TihT75JyZgDDxSiF7RZHGuLzL208rfXOzDUQsdShSAvMdbG1t+FlmEXMcYqvHhRo73K3dVWCprM/0d23aZHyogdZBv/kEtEd1kZD+UERH5Rmh1jKDuc4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=EzytqyZx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef824f40dbso39113157b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733307149; x=1733911949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8yJtp0VtRWCyGUDMUPSKyYrOKeXIERy5/6YkYGZGIw=;
        b=EzytqyZxKNKvA5/TqCooxuF2jLO+c5FGJAlsaYPPTuSi8ZC68Q26O5WRzENi6ZIOz1
         qgCYcZMKs1BbKetL0drec+uD6DyIDMyeLda9n6pseBqHz4ILj8DpDVKMnoRLBpB0uMBj
         tA6FbPb+FahgWhkDVFGsS7kqQVaoboyPDjZeLmtwuE+9BLN03zXy2S7XfV16hIsDU8QF
         FObGw7bQuSPuQlOH6rhV6F5sIH6UCQ56VK7+awQ/ftuDAEXu/ifqENySMtt3T7Sl6uyp
         uBOTD6YqwZsykpshi4ZZYcYfuuz9wkzTr3Qo19wmImXonJOGeFVGVKHLPl0WvqX6zvN8
         fNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307149; x=1733911949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8yJtp0VtRWCyGUDMUPSKyYrOKeXIERy5/6YkYGZGIw=;
        b=TiD8nrNusEQZMDyonqFHh3lzXyN2IbO+RJ/UVHw1dPQCSOuJHPX3uLHsWCbdVMVBha
         Yrr5+j0IBU1m5HGSvHQDqqxj8YOBVf78w10xpk9p+irqx2a1uNCymsUb6xt1UlcR8oif
         cX/yKqCwr8yFRDdIl/xdr7QZONp7Kdms7mR8AmkT6NADJqtSJHQwxUVbTQZbsdDZdOuA
         4IZjZhP7Q0oSB2xxBc97YVHjULRk59AD/2l61MBkveAq7sxbjXzER3wqPkHLDNS+0buY
         eSKsbm1hgO5Mcui2RqX5dc5SQSs5mHIIJ1ukCDDgXwlUvAn50pRvPXyACaffUQeL+P/0
         lveQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2aUurDAVyrN9UZ5GMBJ5hj0+cPRSsx2KxQWhzbeAb09A8fs1KUHnbNs2IU/O6JT47EHbFuFdre2efCwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LK3Hy/DkUgFh5RP8TVAhoRins69VivnW04D6Xjt8DN76JXv8
	gq9FHoChj2AWujJx/5xTQW561bTVNmUBlNkJ92I4YkhW8zxgKCtsy+s07349fKNjMRHr2EwexRl
	krL2C+bduBzHEZo5Lp57s319BRoLjg40xZsresQ==
X-Gm-Gg: ASbGnctmIA0+kadvf4HuV5Dv4QiFQtI9OALmVrF4KM3eygpHgMIqVyDsWDLiZUtFiDX
	UI7QKQWOu10ZHYq3nprqF5OFaBtYoGbU=
X-Google-Smtp-Source: AGHT+IFiZwav0lkXcdEoC0k0swq2tYz4RZsKxcJnENpHGhhnbUCXatljeleEVM5PesTsKopimNNDdHD+hwBm2MoI2HY=
X-Received: by 2002:a05:690c:46c7:b0:6ef:69b2:eac with SMTP id
 00721157ae682-6eface0164dmr68389077b3.4.1733307149315; Wed, 04 Dec 2024
 02:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf> <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
 <20241204084817.g7tort3v3gwdzeic@skbuf>
In-Reply-To: <20241204084817.g7tort3v3gwdzeic@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 02:12:18 -0800
Message-ID: <CAA8ajJnRPB=KRcDpQiAJww3Apv6ZGqWaAg5stSjOE99BOmkCjg@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> I didn't say "tagged". I just said "not PVID". There are 2 independent
> bridge VLAN attributes: "pvid" and [egress-]"untagged". I am suggesting
> that packets in VID 3, 4, 5 all exit the 802.1ad bridge untagged, but
> every bridge port has a unique PVID from this range.
>
> bridge vlan add dev port1 vid 3 pvid untagged
> bridge vlan add dev port1 vid 4 untagged
> bridge vlan add dev port1 vid 5 untagged
>
> bridge vlan add dev port1 vid 3 untagged
> bridge vlan add dev port1 vid 4 pvid untagged
> bridge vlan add dev port1 vid 5 untagged
>
> bridge vlan add dev port1 vid 3 untagged
> bridge vlan add dev port1 vid 4 untagged
> bridge vlan add dev port1 vid 5 pvid untagged

Thanks for the clarification. I think you meant to have the second
set of three commands affect port2 and the third set of three
commands affect port3. Please let me know if I'm wrong
about this.

I gave this a try:

root@OpenWrt:~# bridge vlan show
port              vlan-id
lan1              3 PVID Egress Untagged
                  4 Egress Untagged
                  5 Egress Untagged
lan2              3 Egress Untagged
                  4 PVID Egress Untagged
                  5 Egress Untagged
lan3              3 Egress Untagged
                  4 Egress Untagged
                  5 PVID Egress Untagged
root@OpenWrt:~# bridge fdb show dynamic
f4:a4:54:80:93:2f dev lan1 vlan 3 master br-lan
e0:3f:49:47:9a:38 dev lan2 vlan 4 master br-lan
f4:a4:54:81:7a:90 dev lan3 vlan 5 master br-lan

Like you said, this has a FDB per port. But I think
I need to have a FDB per inner/outer VLAN combination.

Connectiving works as expected in the above example,
but only because of unknown-unicast flood, which of course,
is suboptimal. The switch is acting like a hub.

For example, ever time the host behind lan1 sends a frame
to the host behind lan2, the bridge is not able to find an FDB
entry for the VID corresponding to PVID of lan1 and the MAC
of the host behind lan2. The only FDB entry for the MAC
corresponding to the host behind lan2 is associated with
the VID corresponding to the PVID of lan2 (which is a
different VID than what the packet arrived on).
Hence, there is constant unicast flood.

I also don't think that this solves the issue for
https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
. If you like, I'm happy to explain why. But before I do, I want to
make sure we are on the same page before going further.

Thanks,

Andy

