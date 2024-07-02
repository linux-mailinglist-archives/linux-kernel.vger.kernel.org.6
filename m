Return-Path: <linux-kernel+bounces-238345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74734924899
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08617B224B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C61CCCBF;
	Tue,  2 Jul 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJp1yF3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467EE129E93;
	Tue,  2 Jul 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949762; cv=none; b=T0SkqXi7D9kz6mqAkzrUcSWe3gMdWiS7ymg67pjcpzDnEcPOAXshTABK19NIkQOZN1Dr91UJe4cynYmKzl/Y/Q2+mkg+eZqinGsQ4sGSe0u224ZUjEh8nbNBY4Jxrb3UHb2yXcOprC1m4tD1dYy9YHXu8i8zG1KOIs9xZGx2KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949762; c=relaxed/simple;
	bh=IzPBlqQ/4Tj0Uk881o0FtB2r6D4ok3HgHe3q8VdKMYQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IgzoEwf7HnJTr5NVW/94QuFZYXR0KxKarsWiBMkLy6S4wiOkgbZUZAP50icdQJSM6poQJAUoQZnYL7Rn0bZa+NDpWHAN0d1sGUndydCC91B3gMciXYZwmrrWreW5kG1To3W+M2Hs8qnblTIx5MzSiqN2lBNoQ5aGHdkQ8A182aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJp1yF3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB711C116B1;
	Tue,  2 Jul 2024 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719949761;
	bh=IzPBlqQ/4Tj0Uk881o0FtB2r6D4ok3HgHe3q8VdKMYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJp1yF3ZqPfcjcf1fQipSRB97E8twMHSKw2qvDcIkGsQufK9CbZMjG1tHNofyntZw
	 zVLxQ3TvW2Ex7gPj0v+r7PopNZNh11BDv28j1KD/MzCpH3dP+esWC2JBepOdhde7QT
	 jcWu6vEGnDo3CO6iej+4BBhjQRnNoTX6MC5XAusQjb2eJS9XtyATJ9kpUmCKxigaHW
	 mczEY797vfO1L6B6nON6QiRZoLtiRpGhKiOGDt9wxA7cEzomDz9km1AZxfavq6bgbI
	 i2f2iulHL+yX3lqJ8PHGi9lgiyhb4vaS9FcIaMpD0s51BFvR6+ZvcyFNBohWH9zBok
	 OLk6cHB/FRYAA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sOjV9-009CvD-B4;
	Tue, 02 Jul 2024 20:49:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jul 2024 20:49:18 +0100
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
In-Reply-To: <68b7988d-eaaa-4713-99c3-525a34c5b322@xenosoft.de>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
 <861q4bizxc.wl-maz@kernel.org>
 <68b7988d-eaaa-4713-99c3-525a34c5b322@xenosoft.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <5a6166f107ae31536665d42f410d314d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: chzigotzky@xenosoft.de, robh@kernel.org, apatel@ventanamicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, madskateman@gmail.com, rtd2@xtra.co.nz, matthew@a-eon.biz, darren@stevens-zone.net, info@xenosoft.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-07-02 18:55, Christian Zigotzky wrote:
> Hello Marc,
> 
> Thank you for your reply.
> 
> On 02.07.24 17:19, Marc Zyngier wrote:
>> Please provide the device tree for your platform. It isn't possible to
>> debug this without it, no matter how many pictures you provide. If it
>> doesn't exist in source form, you can dump it using:
>> 
>> # dtc -I dtb /sys/firmware/fdt
>> 
>> and posting the full output.
>> 
>> Additionally, a full dmesg of both working and non working boots would
>> be useful.
>> 
>> Thanks,
>> 
>> 	M.
>> 
> The device tree of the Nemo board and further information:
> https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406

Please post these things on the list. I have no interest in
fishing things on a random forum, and this information is
useful for everyone.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...

