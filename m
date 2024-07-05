Return-Path: <linux-kernel+bounces-241992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E178928246
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5971F2800B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E173458;
	Fri,  5 Jul 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NI8NGj9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937F79F3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161948; cv=none; b=UeDI91V2kttKHpM/DUueipyPOY51/xEVjRIGm+tBuQ33IvDg/7uW59APCOcFQwVwRASYHgwIZcj6VA18loTdePIK9cTvuiVgn+lKrUpqJkXpvnTEMr5SyvfjaYSAeC0n+rTB4BFj/ZYf30CyaMk2OC3Vo7Agv65G719saUjFnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161948; c=relaxed/simple;
	bh=g60DJPZf14GhQyq4l7Hof+bcx8EU5keGZNrh0O2+H5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxXKyVoMqy1MERhjZ3eV6brkQxGBOzxwoUH7k4BMJlDVEIEuIYwTOeRDTHILwbuiuxKa293Zm/OT836+U8SX0GwMWRjb9AF1ui5xjb6KmFcNrkuWvlG8f0e/ixeinAJfWSFce8E7/2tU/GM6SfMnkJbpCLqBBTnKow1rWyrE49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NI8NGj9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BD3C116B1;
	Fri,  5 Jul 2024 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720161948;
	bh=g60DJPZf14GhQyq4l7Hof+bcx8EU5keGZNrh0O2+H5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI8NGj9dr0DlIrxeIacOtuYpCYmFwktgmqwTyl8udrHV8O0xCMUlTCuHYEqpuMhO9
	 9C7MZcdhr8wcGeVgj4Kcc04ogKoS9cmpaA3tr2fGF/SD0uOKWn6nIixsCVYKEXqddj
	 +6w/p50V/vQ5Y3i6mODEASomswRq9arK/fTY2yXY=
Date: Fri, 5 Jul 2024 08:45:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tuhaowen <tuhaowen@uniontech.com>
Cc: alexander.deucher@amd.com, huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
	wangyuli@uniontech.com
Subject: Re: Re: [PATCH] dev/parport: fix the array out-of-bounds risk
Message-ID: <2024070503-concert-mummify-dcbf@gregkh>
References: <2024070413-obsessive-stack-7c62@gregkh>
 <20240705063658.8782-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705063658.8782-1-tuhaowen@uniontech.com>

On Fri, Jul 05, 2024 at 02:36:58PM +0800, tuhaowen wrote:
> On Thu, Jul 04, 2024 at 06:07:47PM +0800, Greg Kroah-Hartman wrote:
> 
> > Usually because no one actually has this hardware anymore :)
> > 
> > Can you also properly test the buffer size when writing into it so that
> > even if the math is incorrect, it will not overflow?
> 
> 
> As of now, I have encountered these three devices: BUNET BU1L02,
> EB-LINK EB-2C1B01, and SYBA FG-EMT03A-N. When these PCIe to parallel
> port cards are installed, the system experiences abnormal reboots.
> I am not sure if there are other devices with these issues.
> 
> Below is the stack trace I encountered during the actual issue:
> 
> [ 66.575408s] [pid:5118,cpu4,QThread,4]Kernel panic - not syncing: stack-protector:
> Kernel stack is corrupted in: do_hardware_base_addr+0xcc/0xd0 [parport]
> [ 66.575408s] [pid:5118,cpu4,QThread,5]CPU: 4 PID: 5118 Comm:
> QThread Tainted: G S W O 5.10.97-arm64-desktop #7100.57021.2
> [ 66.575439s] [pid:5118,cpu4,QThread,6]TGID: 5087 Comm: EFileApp
> [ 66.575439s] [pid:5118,cpu4,QThread,7]Hardware name: HUAWEI HUAWEI QingYun
> PGUX-W515x-B081/SP1PANGUXM, BIOS 1.00.07 04/29/2024
> [ 66.575439s] [pid:5118,cpu4,QThread,8]Call trace:
> [ 66.575469s] [pid:5118,cpu4,QThread,9] dump_backtrace+0x0/0x1c0
> [ 66.575469s] [pid:5118,cpu4,QThread,0] show_stack+0x14/0x20
> [ 66.575469s] [pid:5118,cpu4,QThread,1] dump_stack+0xd4/0x10c
> [ 66.575500s] [pid:5118,cpu4,QThread,2] panic+0x1d8/0x3bc
> [ 66.575500s] [pid:5118,cpu4,QThread,3] __stack_chk_fail+0x2c/0x38
> [ 66.575500s] [pid:5118,cpu4,QThread,4] do_hardware_base_addr+0xcc/0xd0 [parport]
> 
> 
> The array buffer size is 20 bytes.
> When executing code in a 64-bit CPU environment,
> up to 44 bytes of data will be written into this array
> (the size of "%lu\t%lu\n" is 21 + 1 + 21 + 1).
> 
> This modification will resolve the current issue without introducing new problems.

I'm not disputing that this change looks correct, I'm asking that you
redo it and properly check the array size when writing to it so as to
ensure that it really is correct in case our math is incorrect
somewhere.

thanks,

greg k-h

