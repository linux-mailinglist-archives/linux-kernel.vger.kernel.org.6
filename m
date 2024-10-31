Return-Path: <linux-kernel+bounces-390210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D19B7715
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2134D1C222A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA419343F;
	Thu, 31 Oct 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxJPTwe1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62D14EC60;
	Thu, 31 Oct 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365642; cv=none; b=cjU/mMA7FPFzgBBYNLFzIbH0TBxe36XQOTkbkimUnmOH6GnxbhPeefIyYhsTIly2AxIf26q7VYpulQfuA0h7LR9YgO4TTutB6LIXUkbvcRBSmx3vDiHaumCJBApQ6bx13T670U9Xxaj3hpCZouAwogel506qcFjKRi5tkuz/sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365642; c=relaxed/simple;
	bh=w82c8jQJu8P/YWO3ddxnxLhXNDwTYWL8Y6qBaTjBRCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3zobGFOHQGiDgFkV4xm8WHmpWwXIiezLybaj14KosykJvUS8koKMNBe4VQNwZgme/7rq+w+O3ACSv2qFQ35GRK2MP6jQylQLgSF2jYXgzHP3giTHe31+HU71TCaOf5eauyN93mG0ixdOE+lsOelwahSvtmTXIFG8fFkHe4vVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxJPTwe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76165C4CEC3;
	Thu, 31 Oct 2024 09:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730365642;
	bh=w82c8jQJu8P/YWO3ddxnxLhXNDwTYWL8Y6qBaTjBRCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxJPTwe1Yv21y5QUCEYKGlnvRqeNT+dSkfhLxfVnz+jIXljqoLrC5j07OCbGWzLHT
	 D+CKnZP1IRfHJVMAUsaESMFQ+pfBpQMGoh2J+o++q/HmlaSBGqtAbNesu3+eWRBVEl
	 1Whahn4THyMpWv8svxLLzV4mGqIZhVlrF46obi4igKXxhDfGilu2bm5JhI6Alv3eui
	 ZaWmKKFtJ48VXAL7TeGn6oTkI3+o0rSumwauxhE5SXPXkwP6jo8CBIr+AzxupwQOs/
	 8qYkKdmMVjt7GhcJHyODHAVFRGJfjjpFj55NT912nUuEHghnRn9Gb91g94FsRdRfQG
	 KL+Oht6Ijsz0w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6R9a-000000000hX-449U;
	Thu, 31 Oct 2024 10:07:43 +0100
Date: Thu, 31 Oct 2024 10:07:42 +0100
From: Johan Hovold <johan@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] USB: serial: Fix use after free in debug printk
Message-ID: <ZyNI3rQw6q4pkqpD@hovoldconsulting.com>
References: <7d0481da-5852-4566-9adb-3a8bb74cb159@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0481da-5852-4566-9adb-3a8bb74cb159@stanley.mountain>

On Thu, Oct 31, 2024 at 09:59:10AM +0300, Dan Carpenter wrote:
> The dev_dbg() call dereferences "urb" but it was already freed on the
> previous line.  Move the debug output earlier in the function.

Thanks for catching this, but please use a temporary variable for the
struct device pointer instead of changing the flow.

Also make sure to include the driver name in the patch summary prefix
(i.e. "USB: serial: io_edgeport: ..."):

> Fixes: 984f68683298 ("USB: serial: io_edgeport.c: remove dbg() usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Johan

