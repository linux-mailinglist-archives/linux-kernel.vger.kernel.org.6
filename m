Return-Path: <linux-kernel+bounces-273364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F2946869
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA41C20BB1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F714D6F1;
	Sat,  3 Aug 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yN/elBXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8E136354;
	Sat,  3 Aug 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722668191; cv=none; b=HeQNY2pyeoRreA+3OHhTfkvW3pA2oQyjN4QTnQbZAxFBb8YI2sfUwzrMoxjAlYp2qQcgyms+DEUwQCQXKWO3klDhPQ1otfFFMtqKTEP6cdJoJs/fzV0X5FEvAuHv82nHT9441CL3yMFDbasBHHuxffpKEppXEiY4y/ufF48qJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722668191; c=relaxed/simple;
	bh=Gzu04ImuhgiEvZcUsAQKxqRe2pvjQd7xwrOYa4rImDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZAM1uvLnbpnukVQJl4/1n4O6cKBIQCUVZURrxl9niFP64f5zURPOtKULed+J8f3fDb2mk5coZdr2Bav+dMToEo6uI/Wx5cqzcdIZyJF6aojzyEb3wbXTpVsyhi6PnNs9o2c/fUz4Iup6O2JgTxCa+TA7xyP7cPkbNXDZqlWtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yN/elBXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED2BC116B1;
	Sat,  3 Aug 2024 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722668190;
	bh=Gzu04ImuhgiEvZcUsAQKxqRe2pvjQd7xwrOYa4rImDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yN/elBXZ+rZznTDCWe/J/Dc1rJ/YMbQsnqyGsYF5hq9k+zxjdVypt/kQ5V+LpeVBD
	 61yAQkdf60esny1jAviLW5KYd5X7xVSO7juMo5I0s7lGdSU6g/wf1hPCplAamFTDcZ
	 lk6OJ7XDyxDFZ0/XUD3vjkZiKB6Nw5uXynpT96pA=
Date: Sat, 3 Aug 2024 08:56:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Don't destroy workqueue from work item
 running on it
Message-ID: <2024080311-legwarmer-ricotta-d4fd@gregkh>
References: <20240801121126.60183-1-eli.billauer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801121126.60183-1-eli.billauer@gmail.com>

On Thu, Aug 01, 2024 at 03:11:26PM +0300, Eli Billauer wrote:
> Triggered by a kref decrement, destroy_workqueue() may be called from
> within a work item for destroying its own workqueue. This illegal
> situation is averted by adding a module-global workqueue for exclusive
> use of the offending work item. Other work items continue to be queued
> on per-device workqueues to ensure performance.
> 
> Reported-by: syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000000ab25a061e1dfe9f@google.com/
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
> ---
>  drivers/char/xillybus/xillyusb.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

What commit id does this fix?  Should it also go to stable kernels?

thanks,

greg k-h

