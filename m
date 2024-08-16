Return-Path: <linux-kernel+bounces-289868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0A954C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB39B1C24AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2251BD03B;
	Fri, 16 Aug 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ub1ECHTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDC191473;
	Fri, 16 Aug 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819349; cv=none; b=AAfu1eQVFiUHSdolHQvM3tTwC82I7oOJOHUINHLsd4ajklTMygWUGpYcS4IwnVKIcY1WzzmvKsbFEAEJLNwgWbUvQVXRfOEZ4YJxVwoddzGgnjESJ8xmpboBMNf7vyLqF5obfzmu4kCMtSfHGU8JnG0zriz1M/VrZKCCIaXL7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819349; c=relaxed/simple;
	bh=TUkHIeV/zlALbVKyJ8dfPXvj/ynLTnBJxD/KkydGsiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky4UDCC0yOhpv6ufh2LqkGP0K6XrV/ymwlQBMKJPXVxXIO/ETu+JEHaE/yzOeoUCllioG1vI/SPIItuuVdWlIOKankFlLUjV467tdhZf16/f+S2rovmnwzGhqIi2hzpl7hMlmpbI0EuRFx97R6HZkgjw2xvBBuKPFQYngR+zkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ub1ECHTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5EBC32782;
	Fri, 16 Aug 2024 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723819348;
	bh=TUkHIeV/zlALbVKyJ8dfPXvj/ynLTnBJxD/KkydGsiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ub1ECHTVJPwH5CHDKddEBDLHWge4FSmO+DNDuXu4cDl6phW2UV+w3LLNRBhVuGLSV
	 NDA9WFJ0/JRyHcZGI/i6pjVexIdIFKWrfusGPVAgdGRrvs1QouYWppZkaH8dyXaAEM
	 5+3rWKewrTm8hoH6K1juN3Fmz3hH22YpT8noU/jQ=
Date: Fri, 16 Aug 2024 16:42:25 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v1] usb: gadget:
 u_serial: check Null pointer in EP callback
Message-ID: <2024081652-unify-unlucky-28d2@gregkh>
References: <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
 <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Fri, Aug 16, 2024 at 02:19:58PM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> > > Q: Are you running a mainline kernel?
> > > A: Yes.
> >
> > You should reply without top posting (refer to [1]). I'm trying to be helpful to you but it's not easy. The question was if your on some 6.10.y or older version of the kernel, the step to reproduce it, and if you have any automation to test it
>   The kernel version that has the problem is 5.15.

Which specific 5.15 kernel?  The latest one or some random
Android-provided 5.15 kernel?

Does this also show up on 6.11-rc3?

>   To reproduce, turn on the combination mode of the mobile phone USB, such as adb+diag+serial_tty+rmnet_ipa+serial_cdev when running the monkey test.

What is "monkey test"?

I think this has been reported previously, and different patches have
been proposed, have you searched the archives?

Specifically, take a look at:
	https://lore.kernel.org/r/20240116141801.396398-1-khtsai@google.com

thanks,

greg k-h

