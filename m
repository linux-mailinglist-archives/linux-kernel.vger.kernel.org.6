Return-Path: <linux-kernel+bounces-178511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB28C4ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9CAB20F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866512B16A;
	Tue, 14 May 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PctwNRPK"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B134F88C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678952; cv=none; b=QdEV1MjSG9IDQVc31KGS7dpX6GuMkDV5HWGXTawQkfDa4wAyoxv58y6A4ZDR8hyuphcZl/QDK6LASyD3Mdfql5UDXcAFeq3Q7hrN4bXxeAgHb45M5FOD7Mir5QV2Jsm6z8UZGg0f8rVtsKfpqe+wx/hvBazd+R7Z4oTr44TYILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678952; c=relaxed/simple;
	bh=6kElvBGyKGhIg9Ub8vIkwsBDWPC1/9NSVebBtKq5U8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVvFHKaGnvR+YSNAnTS3hioej/Jk/0atM2bg81/qTn+l/UrysJcSO6hxMJykHqhHXE8CWjpyC7eNXEtezXy7ZJyS3JmkgPOdhtA1/CHOhrN6xsrtCRHx8XVtjMOgyWaGgRNbouQlRmX5aMZaI2E4KG7JAMqYBDRxjQQgv6Op38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PctwNRPK; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e271acb015so69925521fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715678949; x=1716283749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd487ul7+IWRZi/RebRrJytoGxL+pZhiiHH/b61/Eek=;
        b=PctwNRPK4+y6kmroZSJlDZJwUULZeh8E6psK76tBPXNMpYs2JruYs4f4zH4r2OjUjx
         BiDdU4L/wBhOR5cTTtHJWI4/mX+eFn1YrTPybX8x+nRtVnw8COhcaSCJh6rVgczsik/G
         wqIu3aHCoeFUXCoPo7dclJ8aAXQoh5mi7dow5UC/HMdwW/0QKcI40PLQVdubaMkPbAdZ
         AZMum3SL4UKXg0IltrOgOLopEDbFG5QAOl2QQkhN3dh3NSseaqVAeBk+xRgqJVnmNEWm
         IUQXNxNtCtxid+34z3ZH3xRbt+1bVz+Nu0SjiLinRS+JVZpIIu40m+jukL7gqg5YAoe+
         bR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715678949; x=1716283749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd487ul7+IWRZi/RebRrJytoGxL+pZhiiHH/b61/Eek=;
        b=lrxKaMhFuEa5TII50Yz9wF7hl2BMQ6L4dyiwuU+71nVEBjh6s33aAJ5D1ydX9x69bd
         eCKlMTWVhwBRFSOyyA+pV3vBKqY9gTphc4FwaQmaZjMcThJKLXCl4/8Iq9/uyFpPGoR9
         vhs/OdLxn2ilJGiXt5LZMkYmkoZB9xPDDX/2FKAmXzPpwxHsvwSXEkHnUedUpKDeyrMp
         vlU4XkC5TU+yYeuunXeG/R+XPfJAvyVBwNchbXq8quIyzSvoGI9ID+hKx9xYbIdKkcUl
         aUEEcsxuHTGMwEZ0cSDALIkjun7Jqd+4WcroVcwWcW0zbMXGnBubJR6WVRhAMSyNnL73
         rstw==
X-Forwarded-Encrypted: i=1; AJvYcCWSnGwClQq80oOHPpRUz0RnOp0wIQUQ2kbKB/hG7zwvPYO38huhbb6ZNyNPjBsGFBA6ihJaFV17wZ9VDCvHINQt1RMWP0aTY2ma0fRF
X-Gm-Message-State: AOJu0Yx08fWAkTgudlIaQoq4szoEj/NHG15sLkj8oZ45eYvdgI0/Yacu
	zGYqIelmlHrRregl5bZRQbvi2henTSdRwhk7BOwDro0BobC4LzOsOXF22YPbnc5eh9s9+pNcgJE
	DsA6L4sq3QVylxOO3WJMemLc3F+rWWj8M
X-Google-Smtp-Source: AGHT+IFmB8LaGIFrqdP5yidB+MakxIH+DdCGrnSsPu+u5O+m38I1I6lb/KJnodF/KU8Tj7MJ7WGn80IEGpGBR0Ecq4s=
X-Received: by 2002:a2e:b0d6:0:b0:2e2:55:4edd with SMTP id 38308e7fff4ca-2e51fd42b59mr82162151fa.3.1715678948758;
 Tue, 14 May 2024 02:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com> <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com> <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com> <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch> <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch> <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
In-Reply-To: <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Tue, 14 May 2024 10:28:55 +0100
Message-ID: <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, OlteanV@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 8:05=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
> Attached is a configuration that I use on a x86-64 VM for testing that
> is started with:

That's kind of what I expect to be happening on my target, but it's not.

I notice that your configuration does not define CONFIG_FIXED_PHY as
either a module or built-in - could that explain both the fact that my
dsa_loop_bdinfo.c does not get compiled when using the default
Makefiles, and that if I force compilation to a module it does not
appear to create the expected lanX@eth0 interfaces?

I have added some printk debug lines to the dsa_loop_init and
dsa_loop_drv_probe functions, and only see the one from the init
function, which makes me suspect that something is stopping the probe
from happening - I assume this should happen when the dsa_loop_bdinfo
module is inserted?

root@machine:~/dsa_test# ls
dsa_loop.ko  dsa_loop_bdinfo.ko

root@machine:~/dsa_test# modprobe dsa_core
root@machine:~/dsa_test#

root@machine:~/dsa_test# insmod dsa_loop_bdinfo.ko
[   51.742367] dsa_loop_bdinfo_init

root@machine:~/dsa_test# insmod dsa_loop.ko
[   58.485104] dsa_loop_init

root@machine:~/dsa_test# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
mode DEFAULT group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
3: eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
DOWN mode DEFAULT group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
4: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group
default qlen 10
    link/can

