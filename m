Return-Path: <linux-kernel+bounces-391576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8C9B88DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D91281D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B874BF5;
	Fri,  1 Nov 2024 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/JFupgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A78289A;
	Fri,  1 Nov 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425797; cv=none; b=QdoQgurthr/5RnWHcEXBHytWSd48E+Hel5oIe+omkbTH3GgiNH+hx/4U+4oc88doIkFKI2/XW2m4vJXAu1QfMG2gYxPQhByFZGzmaizRRFgc3z8oitwhnenYNVratQE0p9/B2KrBqu6OmJ1aHj9SLzdRskrs9HBtokFVPKrpFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425797; c=relaxed/simple;
	bh=dE/ylJ6ge1HqyoW9KyWdTWFUjztcM0sAXkdF7dnXeaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsoWvAabJPuli6zbwNczelqKRXCRQDIINjH4F5Cv6IyUjpSribnYwwRYn5Ui+zDHj1AjC/6faATal2tnob7gsyb87BfxcEtcGcu5WvQ0muIDVuQZImTedFeeSvESI2j65pVJXRjG28ijvgdWIc5aDEQBxVWYu9rz4/Kw7Mkjd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/JFupgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49094C4CEC3;
	Fri,  1 Nov 2024 01:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730425796;
	bh=dE/ylJ6ge1HqyoW9KyWdTWFUjztcM0sAXkdF7dnXeaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q/JFupgbMKZgQ495HX2P33PdvSIrJV3/NNeKT6CPJMaxh3c+rPteRAj09A9L1BA0+
	 XxZ/pzQjTauyOBmEODAKVygey1QRUEjQoUIzZCos/sGERIgLSQgOy4tWM81T0aWeRb
	 DX3kRIHPwrV7UxA06/B9Bn1o+C05DIUdy3N3bVsFSotoAyt4rOxc8+wC76/QphYtaO
	 rqymvrECTI9m2erJ0zmH/tQTow33Zacx2SevANUsuldp182fQmPYg4re6Vv8zxDlIv
	 2gkdCXaBPNOxIU2kUcXBwyJmhtYkE2AQLPr3pRdamKSZSKZPYBB29IX3lmTC+x9PDT
	 /i9hDMMjhGTNA==
Date: Thu, 31 Oct 2024 18:49:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] netcons: Add udp send fail statistics
 to netconsole
Message-ID: <20241031184955.159d2211@kernel.org>
In-Reply-To: <CAO6EAnW4LwZax-UJf8s1uNS=V7FYJ6e1N3MekNjzaoyVDCO_Tg@mail.gmail.com>
References: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
	<20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>
	<20241030184928.3273f76d@kernel.org>
	<CAO6EAnW4LwZax-UJf8s1uNS=V7FYJ6e1N3MekNjzaoyVDCO_Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 21:19:26 -0400 Maksym Kutsevol wrote:
> Thanks for looking into this!
> 
> Parroting examples, e.g.
> struct pcpu_lstats {
> u64_stats_t packets;
> u64_stats_t bytes;
> struct u64_stats_sync syncp;
> } __aligned(2 * sizeof(u64));
> 
> in netdevice.h https://github.com/torvalds/linux/blob/master/include/linux/netdevice.h#L2743-L2747
> I don't have any strongly held opinion about this. I'd appreciate an
> explanation (a link would suffice) why this is a bad idea.

No entirely sure why the pcpu stats in netdev are aligned like this,
but yours are not per cpu, and not fast path of any sort. So aligning
is a premature optimization in the first place.

> > > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt,
> > > +                                     const char *msg, int len)  
> >
> > This is defined in the netconsole driver, it should not use the
> > netpoll_ prefix for the function name.'  
> 
> netconsole_send_udp_count_errs sounds better?

I don't think the _count_errs() suffix is needed any more

