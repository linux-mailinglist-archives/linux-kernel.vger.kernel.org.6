Return-Path: <linux-kernel+bounces-289624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B52954862
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AD71C204AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE31B373E;
	Fri, 16 Aug 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uvA1ld/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20961B29BF;
	Fri, 16 Aug 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809427; cv=none; b=b/9lHRnC8/c4gymUpBmGHGUVAVN2YvH01RL14FZLBwUYdpYGqXWrxTRbfmQhODZGTsYY/hQJ6RkAvD6v/1jkV3xA4wMqMd/l4RrofaqkbE2Ji8bRbfnx9zJElKg8rzAjFdW+B304QFrZ3S36m45bziHGz+7V34MngBPyIpNWd5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809427; c=relaxed/simple;
	bh=sJ7sr5hXNIMPV/I9YvElbTGYiyND24WiN3dkqSxv/4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8XHvktIQFLS+GCHbdo6nSjDDR4BH30yhHWGyeH05Yfbh4SC9quObaXQo+9wwN5T7w5LpEnVxAV+UJVsxT/xuj14WiDi39s648Jh+ma7EAExqgPAtz4rJpdPtCSPUp/U82iLjW6HaKzah4todG2/5RAKTot79w+zG9yzA3MfCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uvA1ld/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B540DC4AF09;
	Fri, 16 Aug 2024 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723809427;
	bh=sJ7sr5hXNIMPV/I9YvElbTGYiyND24WiN3dkqSxv/4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvA1ld/kBKMFvx99gG5SXYtHUwxhUWz5LZlJUaSLrQgdo/95LAAMgNwW8kDsGf5eO
	 Yq15mLOX2kpWFL2rAPxgJ4Pftn9iIq5Y3A/gg52MdmWeJjZc0vxniaSOKvMhOoNQeL
	 stKd5Xx8Yhs018YXg407GWzvFNCVhZZoV1gxIYeo=
Date: Fri, 16 Aug 2024 13:57:03 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= usb: gadget:
 u_serial: check Null pointer in EP callback
Message-ID: <2024081629-nebulizer-harvest-2303@gregkh>
References: <TYUPR06MB62172CC6BA9647EF769D4DF2D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081635-slacking-buzz-acce@gregkh>
 <TYUPR06MB621717DE00C464BE67650C16D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB621717DE00C464BE67650C16D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Aug 16, 2024 at 11:16:08AM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> Q: What is causing driver_data to be NULL?  And what protects it from happening right after you check for it?
> A: This is a very in-depth question, and I need to have a deeper understanding of the code before I can answer it. 
>   Judging from the crash stack, this patch currently has improved the crash problem.

Please figure this out, we can't take changes that don't actually fix
the root problem for obvious reasons (and you wouldn't want us to
either.)

thanks,

greg k-h

