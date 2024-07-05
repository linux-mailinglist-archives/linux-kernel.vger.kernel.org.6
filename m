Return-Path: <linux-kernel+bounces-242512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0774B92892A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F581C2146E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062114A4C9;
	Fri,  5 Jul 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLVuOg7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13014430E;
	Fri,  5 Jul 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184472; cv=none; b=FhWpoBkq5p05PYWaYbP2m1IPbaKEYideyOMHHtXaV6asLM/Ta/58Vp36mgWAVQ16IUcgEN+bWWrhOVXx9j+NESGOldSbD+36as4RPboaLpj/GChZ6nZjRDFeQbYW/h/E1X6T0In2s8ijzdJW1gYXeduVsue2lP6gsBiLLgmaFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184472; c=relaxed/simple;
	bh=wFLfSOenR7Pj3La1IrKKOJzJRYxUmpXInQGcTcg3mhI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VvzgIfzyT+NOvYeYoM5+weuWkUz864xNwcfjMorhWI67PrSXM4Sb+nvqcrplJV73rz/0nbyBoYFfyzg0NDwf+KwBcT5F1d5eIJjNohBNTLCQmes1qRQSpwQWIune3CYI8u3kZb0rkFg1a0/i5cWNR5N61dYa7u71iCnxGEcz1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLVuOg7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81799C116B1;
	Fri,  5 Jul 2024 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720184471;
	bh=wFLfSOenR7Pj3La1IrKKOJzJRYxUmpXInQGcTcg3mhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iLVuOg7IwK1qRdMOX8r6PS1ljKUMSs3jcgOHvAATvhN6+m4Fp//ukq23sZYqi5/qQ
	 hK1Q4kuGuVIWDsoKdIZzt4G5+Mgjf1xewR8D/3M/Uh12mwAvfScEmDzccVfYLyjR23
	 Kv4WGfiqdf+yV5QWBo0KP8jny9ZVntXHNbyD/5SSLv9/VVW4RL5Aqkyu7gCwKxFSno
	 wpx/L0wU56Eseo6AJzkhItK5PBNkbKivgSVxc4No7qQAPpaD40al0i9pz+GreFfIPl
	 O3hZ1i2oYPViRWJ7KmSQVyPtzNskIA7GEeHworNWXUU9nbDKo6JAttL0NVkgaDCFT3
	 vM1ok4JgSOblg==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sPiYn-00A3gM-2Y;
	Fri, 05 Jul 2024 14:01:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jul 2024 14:01:08 +0100
From: Marc Zyngier <maz@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com, DTML
 <devicetree@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>, Christian Zigotzky
 <info@xenosoft.de>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
In-Reply-To: <C7B869E5-95D9-426E-A2CB-8336CC9EF432@xenosoft.de>
References: <C2FBFAD0-DEEE-4906-80B1-5FA745CD9726@xenosoft.de>
 <C7B869E5-95D9-426E-A2CB-8336CC9EF432@xenosoft.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <12665d67dcf74cd9a2cd8388d8106f8d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: chzigotzky@xenosoft.de, robh@kernel.org, apatel@ventanamicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, madskateman@gmail.com, rtd2@xtra.co.nz, matthew@a-eon.biz, darren@stevens-zone.net, info@xenosoft.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-07-05 09:05, Christian Zigotzky wrote:
> How about the other patch[1], which would be far preferable?
> 
>    M.
> 
> [1] https://lore.kernel.org/all/86ed8ba2sp.wl-maz@kernel.org
> 
> - - - -
> 
> Marc,
> 
> We will test the patch as soon as possible.
> 
> Christian
> 
> - - - -
> 
> Our tester has reported, that it doesn’t boot.

Does it mean you are not testing this yourself???

> 
> Link: 
> https://forum.hyperion-entertainment.com/viewtopic.php?p=58627#p58627

How does it fail? I've repeatedly asked for dmesg outputs
for working and non-working configurations.

         M.
-- 
Jazz is not dead. It just smells funny...

