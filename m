Return-Path: <linux-kernel+bounces-174741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF628C1433
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2383D1C21DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1500A5D74C;
	Thu,  9 May 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YZi/LcCQ"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12E54FAB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276418; cv=none; b=RPDanpPZGENSTLyKI341i+25UQllMNGEBp49xtTFC6JFFLJByGooTzFwKhtndLFx5YFCFEZjQ+m1v1hl3JmrBCbaWjWnPwsonXrL+QnkBnfwRFM8LjXe6ink4T9W+g0NEQzUQ28V5JB9KTeTuHb4knhAaxXwEvuj1eoMtP5bdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276418; c=relaxed/simple;
	bh=+JJ3OgJl4Lh3xvKOAMjBnHajAacDL9RZkh7lLjWbwrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNsXLMXH+qLqZTatEl02TEf387BTeur0nXGxJRxJ0O/cy6Crtj69BH1vjIdTwSGCCPZNjgPw18YHHWshbTzOH93qYZP2X4WhCNBkYuZnQGxDfwNshG9r2dCENu72VztOZKBzHLU+9Lhc+yxN3Q/w7PMTrgUneYypVtJTPT/3GTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YZi/LcCQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D55E9411F7
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715276414;
	bh=ainzmkdiFZatTBBNnswuHUf0cvHV/VEu7RERUQouf94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YZi/LcCQr1YYasisWBZyh0SM/lE8xac9Kfyc51R1SKeSsOTaFFgrZGdSHcJxpzdZI
	 KTCQ3A4UD6hVu8MQ0tOMsglwa7qz8fDnk3Z5rqu7ZGVYEpGFoTZxEUsecIxcHWSaP+
	 G3yH3NjEN4f1vyKqH4EGGOYRxiphcykaUvozuQWO9QjJTHjrjwbHGo4hbhjwB5NMWm
	 le/+9G+aR4SBuwpTloslpdOsXubK4aL/XLqkOj9nUKDORasD7fuTW6Bd1ytki9ay/d
	 7V0KkxOUVNzv9N4AUqo4z3SWV3XI/MAResqcjrr5hvuWWZ3Uut1E0Z65Tnif5kSd7G
	 OqaC2AvxNHKxg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34c68b0d27eso615221f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 10:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276414; x=1715881214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ainzmkdiFZatTBBNnswuHUf0cvHV/VEu7RERUQouf94=;
        b=ex0zbd/g718uxOvyRu8WBy96EvEKdoulzsLZqjXsdL2VheHOHF893XBUJ4ov9cCpp0
         DlbPuNkDjMrARNdWnkBMMUjDuOSa/VdOel7ITRxS164TgfZy+DLSZM1GxUU8GZIp+l7Q
         4eDF3fZdnBepAAMopeYk1NXDjsO09JB7Fy6+7Cv7huOhSVdDc6RnhEgZtXsayb1xIY5q
         BWa3hBKJDv4QjgWpQ2kuDZda4UAI665UE4Jf35KFRYCJGsSTU4kcRk+iW1lYEijcUtlS
         sb5wHbKgMicSeodGyG5Yx7O88NEbtFhufAGXYVmwS7lrt5iE6A5mbl8Eg+fwo7m2Wx+L
         e6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcMPblNZoMSywQ1QMfchCO0ff8uZWeixugC9VxH3K+8eSKTfnffnpgT0hQ/Ymq1q5ZAHFwl05ccUWqODEu28bb15kayzKEtTMhc/sA
X-Gm-Message-State: AOJu0Yy+jbe1Ol4EZ7Cwek3KY0WNyIa8Pg6Leayr3jagPU40Zxu7bPeW
	J/UlXCyYYtZrcNeL6Xn8NL8mIoqooeXEO106RyIOpcMURHJhvjn2DO5EmEqEDAbktQrl4yR0QQy
	d2/uPFYAi+3BFiWLzdiKuqcN0BtBpos5AosIRmShihlonmD7gnolPvpvw0KY3oF5fB6ro2YkgMZ
	HevTQIzZpnKMkvm0+axNOdsOSZEg8NDo/jYcgYEL1KiaNHOlv8Q0Dr
X-Received: by 2002:a5d:45d1:0:b0:349:ffed:792d with SMTP id ffacd0b85a97d-3504a7372a1mr278047f8f.30.1715276414421;
        Thu, 09 May 2024 10:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadpoJUBLPLrGbKTI6NrhfHgQFMupVGgJHWXb6ctPt9UXT1JRQDQhiYxpWoe+IrnBQi24ZmA5VglKX5yH9fA4=
X-Received: by 2002:a5d:45d1:0:b0:349:ffed:792d with SMTP id
 ffacd0b85a97d-3504a7372a1mr278029f8f.30.1715276414106; Thu, 09 May 2024
 10:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
 <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch> <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
 <334396b5-0acc-43f7-b046-30bcdab1b6fb@intel.com> <cc58ecfc-53f1-4154-bc38-e73964a59e16@lunn.ch>
In-Reply-To: <cc58ecfc-53f1-4154-bc38-e73964a59e16@lunn.ch>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 9 May 2024 19:40:02 +0200
Message-ID: <CAMqyJG2Xnn7VtT1CrCXK7ojuUmP+ig8uwB30uK3nprPo5hLiUQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: fix link fluctuations problem
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Sasha Neftin <sasha.neftin@intel.com>, 
	netdev@vger.kernel.org, rickywu0421@gmail.com, linux-kernel@vger.kernel.org, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	anthony.l.nguyen@intel.com, pabeni@redhat.com, davem@davemloft.net, 
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>, "naamax.meir" <naamax.meir@linux.intel.com>, 
	"Avivi, Amir" <amir.avivi@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"

> En-Wei, My recommendation is not to accept these patches. If you think
> there is a HW/PHY problem - open a ticket on Intel PAE.

> I concur. I am wary of changing the behavior of some driver
> fundamentals, to satisfy a particular validation/certification flow, if
> there is no real functionality problem. It can open a big Pandora box.
OK. Thanks for your help. I think we can end this patchset now.

> It is normally a little over 1 second. I
> forget the exact number. But is the PHY being polled once a second,
> rather than being interrupt driven?
If I read the code correctly, the PHY is polled every 2 seconds by the
e1000e watchdog. But if an interrupt occurs and it's a
link-status-change interrupt, the watchdog will be called immediately
and the PHY is polled.

> What does it think the I219-LM is advertising? Is it advertising 1000BaseT_Half?
> But why would auto-neg resolve to that if 1000BaseT_Full is available?
I'm also interested in it. I'll do some checking later to see what's
advertising by us and the link partner.

> Agreed. Root cause this, which looks like a real problem, rather than
> apply a band-aid for a test system.
OK. I think there is a clue which is related to auto-negotiation. I'll
work on it later.

Thank all of you for your help, I really appreciate it.

On Thu, 9 May 2024 at 15:46, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, May 09, 2024 at 12:13:27PM +0300, Ruinskiy, Dima wrote:
> > On 08/05/2024 8:05, Sasha Neftin wrote:
> > > On 07/05/2024 15:31, Andrew Lunn wrote:
> > > > On Fri, May 03, 2024 at 06:18:36PM +0800, Ricky Wu wrote:
> > > > > As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> > > > > Intel I219-LM reports link up -> link down -> link up after hot-plugging
> > > > > the Ethernet cable.
> > > >
> > > > Please could you quote some parts of 802.3 which state this is a
> > > > problem. How is this breaking the standard.
> > > >
> > > >     Andrew
> > >
> > > In I219-* parts used LSI PHY. This PHY is compliant with the 802.3 IEEE
> > > standard if I recall correctly. Auto-negotiation and link establishment
> > > are processed following the IEEE standard and could vary from platform
> > > to platform but are not violent to the IEEE standard.
> > >
> > > En-Wei, My recommendation is not to accept these patches. If you think
> > > there is a HW/PHY problem - open a ticket on Intel PAE.
> > >
> > > Sasha
> >
> > I concur. I am wary of changing the behavior of some driver fundamentals, to
> > satisfy a particular validation/certification flow, if there is no real
> > functionality problem. It can open a big Pandora box.
> >
> > Checking the Bugzilla report again, I am not sure we understand the issue
> > fully:
> >
> > [  143.141006] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Half
> > Duplex, Flow Control: None
> > [  143.144878] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Down
> > [  146.838980] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full
> > Duplex, Flow Control: None
> >
> > This looks like a very quick link "flap", following by proper link
> > establishment ~3.7 seconds later. These ~3.7 seconds are in line of what
> > link auto-negotiation would take (auto-negotiation is the default mode for
> > this driver).
>
> That actually seems slow. It is normally a little over 1 second. I
> forget the exact number. But is the PHY being polled once a second,
> rather than being interrupt driven?
>
> > The first print (1000 Mbps Half Duplex) actually makes no
> > sense - it cannot be real link status since 1000/Half is not a supported
> > speed.
>
> It would be interesting to see what the link partner sees. What does
> it think the I219-LM is advertising? Is it advertising 1000BaseT_Half?
> But why would auto-neg resolve to that if 1000BaseT_Full is available?
>
> > So it seems to me that actually the first "link up" is an
> > incorrect/incomplete/premature reading, not the "link down".
>
> Agreed. Root cause this, which looks like a real problem, rather than
> apply a band-aid for a test system.
>
>       Andrew

