Return-Path: <linux-kernel+bounces-432471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8E9E4BB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707D61678C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD287DA95;
	Thu,  5 Dec 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="keKc2QXH"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC614286
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361288; cv=none; b=J0cvuCu85kbDaChJRDpeZCBeavdqJ12r061enWT6rH7Rp7BEN/oEBNpExgmDk7uEc6RD9VV2p2z+2l9J+Ox5iJbSYOOhh2ELX/zoxixX7WiL+QDReZsC/7y5+xqbAUxSI8XM3L8fkSt1/9O53ZbuaVqt8ZbRy/A8yPrTWd9VwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361288; c=relaxed/simple;
	bh=0eT/Lot6+vqxxD9AP/IubXTEz/4Dzp8TBFGS1OmCoxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1/5soX/Y9PjRmoRMOe+aY8YOD9RL5C3TTizTXmwR6PhA5LDfYyHoCEC0CvS/j5DMO+d54wQsFrluYsMIYqQXhLfkCHePERsE/Q4qqlKG1txckh6HlqW5XMvq5SGr06nKTJKrKME1+s+qJIL9EIPcMUbCJmLNMrFxqPxln+hZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=keKc2QXH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e39779a268bso683730276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 17:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733361285; x=1733966085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfZMYXPm/XnOBhZKHxlljIg3cpKjNn+y0on19a7NN2Q=;
        b=keKc2QXHaPNfIrNxvbcI+0AuChtVT9vTPB2nLrm7Skg736Wr4pykskupJ5bIW0FXgc
         rAZSqlYscc2FPdvyLHtoXwrwX3pUr6StmdSpMTij9zIXg7hGiTWwRwhF9rmh8dNnULIA
         mYrtn9HQARMWqvAtdrG13ix+78hXSfmYNYpXqLOFh5YYWmUG7IVRy/4ecu4WGgdeJu+I
         wdqn+cYBWR4D6lqSN8L6uww4wkeJusnkVnb8BPaH2ovyJdxa/VTG3q0cOTjRmLy3XbuF
         s6X/FZo6CP6UZk/tQksyb1N1kZSgL/fOSoWxysLlFRi/E4qWByVJVYZE6MWdvoEMhwnC
         fT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733361285; x=1733966085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfZMYXPm/XnOBhZKHxlljIg3cpKjNn+y0on19a7NN2Q=;
        b=ss4QFHV0rzpFzfIMReAmKIWzngalU7LJWsOHAKZKMo8GW88vwGmNXqiXJizLy53MrP
         nhLlubnkcBrsMVEgbo/XSv+0tqj8HzxXk6qAdN0y+EI5RMXlgkIqGtQ4tFt5epiiy044
         M/Wf/Ee1y4Y9BSfLttbxBNJn2NaAkWrdbJn/oOwABdoOnPYA/Fup+0XjP3WnrI27UONC
         1uYp5YQlUxaMPuDgEa5zf9/1pJ9FkhPJizHkO7h3LshIT6jCm+1EHB4LFa0oVQoako6D
         7nd5UqYCapmPJU0QK8zE563OrjiuEsT51LsILTP3BduZjKXbN/1yGUL+pJICpkPP7JiI
         ZLPA==
X-Forwarded-Encrypted: i=1; AJvYcCWUw2ts9n+K3uvmfAp6oj780srhHDytj9BSKlo5Jbdyf4Cca9IDbzN7d4LaLTy8sSlplICmkCzK5OyJgGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWGYEpqKq+XzOPhsFsdaDrqXWkJlLWX/EFH0KB1IrpxBWTEP7
	nCh7vjh/AZh8ABJCJIuKOo/OiOngZxgotTpnPw80wxS6OR8qYYTBcRAC/7qWiN/PUezo8184DhI
	JqAHlJYmBuG0IkF+v0xsLY6bfjRlJg6VVimA2ZA==
X-Gm-Gg: ASbGncvqVwFHbsTrckCvo6KNfuJKHd+dJ+9Sn3OemgOGVwfa4Q+zXbQmOref8jQuUM1
	odDbUN8iunKU/Zoz5r/piyimwVQf0nbA=
X-Google-Smtp-Source: AGHT+IHA0+z3aYrs1oHL7bfJ5mmSCDhOEW1KC+mJa23OdZXviguzJEU7KjVhNJq4otCChADvbWMuAWS+kWh7228uAqM=
X-Received: by 2002:a05:6902:2b01:b0:e38:230d:aee0 with SMTP id
 3f1490d57ef6-e39f2338efdmr1688035276.23.1733361285485; Wed, 04 Dec 2024
 17:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf> <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
 <20241204084817.g7tort3v3gwdzeic@skbuf> <CAA8ajJnRPB=KRcDpQiAJww3Apv6ZGqWaAg5stSjOE99BOmkCjg@mail.gmail.com>
 <20241204105645.vwhnwyp3gyq5av4m@skbuf>
In-Reply-To: <20241204105645.vwhnwyp3gyq5av4m@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 17:14:34 -0800
Message-ID: <CAA8ajJn0+tBL=5YtuJt5Y6NKWKf_sEctq6Jm=h_Jht4DDnBRkw@mail.gmail.com>
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

> Here the same thing. The 802.1ad bridge has the same PVID on all ports.
> Why does the FDB lookup have to be as complex as to take 2 VIDs into
> consideration, instead of just the inner one?

In all my examples I'm using the same PVID, because that's a required
condition for the issue to happen. I omit that the other .1ad ports in
could have different .1ad VIDs configured for them, to focus
on the concept I'm trying to describe.

But other VIDs can be configured on other ports. So, there could be
collisions of .1q VIDs across different .1ad VIDs. As such,
I don't want to ignore the outer VID during FDB lookup.

In my use case (topology-sim) the test fabric consists of .1ad bridges
that are connected to networking equipment under test.

The topology-sim user configures virtual ethernet cables (point to point)
and/or L2 IVL ethernet segments between multiple devices under test. They do
this to construct an arbitrary ethernet topology that they want to test.
topology-sim assigns / maps each one of these  L2 segments to a unique
.1ad VID.  This is how it keeps the "virtual wires" from interfering with each
other.

So if one virtual wire (ie .1ad vid 3) is connecting to a switch under test
that is emitting frames with .1q vid 7, I want this virtual wire
to be independent from another virtual wire (ie .1ad vid 4) that is also
emitting frame with .lq7 vid 7.

I acknowledge that we shouldn't make this upstream change just for topology-sim,
considering that I'm the only user of it. But these same problems
can affect, for example, metro ethernet carriers that use .1ad vlan stacking
to differentiate between their different customer's sites. I'm not
trying to claim that
metro ethernet carriers would be inclined to use this feature -- I'm just
providing another example to point out that this same concept applies to
use cases outside of topology-sim, because toplogy-sim uses VLAN
stacking in a typical, conventional way.

I'll now proceed to go over my hairpin example,
https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
in more detail. I think that it will help demonstrate why I want
to consider the inner tags. It's an example about a circuitous network
path where the same packet can enter the same .1ad bridge multiple
times, with the same .1ad VID, but different inner .1q VIDs.

Like I mentioned before, this network is contrived. I've never seen
this done, and don't expect that it is a common topology. But my
goal is to prevent connectivity issues that only arise due to how
topology-sim constructs the virtual L2 ethernet segments.

The network under test has a bridge mode firewall that is used to inspect
traffic as it passes from some subset of a L2 segment to another subset
of the same L2 segment. The way that the network operator achieve this
goal is by creating separate VLANs for each subset of the L2 segment
that need firewall interjection. This way, communicate between these
different subsets are forced though the firewall. The firewall bridges
the two VLANs to merge them into one L2 segment, one broadcast
domain.

Say the topology-sim user wants to interconnect two .q1 bridges via
a virtual Ethernet connection. topology-sim accomplishes this by setting
the same PVID for both ports that that face these .q1 switches under test.

Let's follow what happens when a packets it transmitted from A towards
B.

When the frame is emitted from ".lq #1", heading toward the .1ad switch,
it is .1q tagged as 7.  When the .1ad bridge receives the frame, it will
associate it with .1ad vid 3 and .1q vid 7 can be seen in the packet,
if desired.
At this point, the .1ad bridge can either learn that A is behind it's
left port, for
.1ad vid 3 (current implementation), or it can learn that
A is behind the left port only for .1ad vid 3 + inner .1a vid 7
(proposed functionality).
When the frame leaves the .1ad switch heading toward
".1q #2", it will just have .1q vid 7 tag. ".1q #2" sends the packet
to the firewall,
via its left port, untagged. The firewall bridges the frame, and
therefore transmits
out its right port to ".1q #2", untagged.  ".1q #2" transmits toward
.1ad with .1q tag
8. When the .1ad bridge receives the frame, it will associate it with
.1ad vid 3 and the inner .1q vid 8 can be seen in the packet if
desired. At this point,
the .1ad bridge can either learn that A is behind its right port, for
.1ad vid 3 or it can
learn that A is behind it's right port, for .1ad vid 3 + .1q inner vid 8.

Without my change, the .1ad switch's fdb entry for A's mac, .1ad vid 3, would
flip continuously between the left and right port.

With my change, for .1ad vid 3, the .1ad bridge will always forward
packets destined
to host A's MAC to the right if the inner vid is 8 and will always
forward host A's MAC
to the left when the inner vid is 7.

I hope this example explains why I want to look at the inner VID. The
fact that we can have
inner VID collisions for different outer vids, drives the need to examine the
outer VID. This is why, collectively I want to consider MAC + inner + outer.

Does that make sense?

