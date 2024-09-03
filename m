Return-Path: <linux-kernel+bounces-312536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CC89697DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CA71C23341
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E011C7662;
	Tue,  3 Sep 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AzpIw/e1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E561C7669
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353525; cv=none; b=gMKJ1GDlJkMLLPFhTcnLaL/YYTRHxSJH9MsNlwjC8wzBa2Ph+32yESEyFoHG9+8LboFFwiysBLhPafUD7PrJosVY1Bo91Sz/a9LwaBl5jadfYSTtqW5XH9Iozovjjs6S4+JPpQYbnla/RQaBfnoXoCgQ+I9J28PfXAtU/21vpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353525; c=relaxed/simple;
	bh=i0oGTjh45vEnDbHKzWjA5KAnXTgP/DDRbIOzpXhfJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=milk/9QGfSudOrFML4Zabhl00vFM4kX/bwcMl0H8d4nL50pukwZk+Hg/EJ35gY+4rA+HZzRlNPKgxn3C1meoDcKr8NM08BMDOx0Tz4UCbE04KwSShEuny3f7F188EfbVsUwV7RxZaRKuklDvzgZn2/2egHOUwxHiABQNNsvJdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AzpIw/e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA774C4CEC5;
	Tue,  3 Sep 2024 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725353525;
	bh=i0oGTjh45vEnDbHKzWjA5KAnXTgP/DDRbIOzpXhfJJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzpIw/e1qS8KTI9f1kNbG+y5GM5dWJ9J8AJi6xOd6MNK7ljsCh+pa/1wz+Fphyi/F
	 KHII4sQxLHI0HGDDlJ41vQ6sWLFr7e4a9r3dvT0t/zttTO5JjevxDO+0O4w6RrYEyY
	 P0xv0WjwycV8YBsb2QIJfUbvt2pc++QOfDDc82uA=
Date: Tue, 3 Sep 2024 10:52:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: bajing <bajing@cmss.chinamobile.com>
Cc: arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] binder: modify the comment for binder_proc_unlock
Message-ID: <2024090326-recycling-factoid-2c81@gregkh>
References: <20240902025720.2334-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902025720.2334-1-bajing@cmss.chinamobile.com>

On Mon, Sep 02, 2024 at 10:57:20AM +0800, bajing wrote:
> Modify the comment for binder_proc_unlock() to clearly indicate which spinlock it releases and to better match the acquire comment block in binder_proc_lock().
> 
> Notes:
> v1: https://lore.kernel.org/all/20240830073743.2052-1-bajing@cmss.chinamobile.com/
> 
> v2: Reword commit log per suggestions from cmllamas@
> https://lore.kernel.org/all/20240902013636.1739-1-bajing@cmss.chinamobile.com/
> 
> v3: Wrap commit message. Add version history.

All of the "Notes:" need to go below the --- line, as the documentation
says.

> Signed-off-by: bajing <bajing@cmss.chinamobile.com>

Please use your full name here, not your email alias.

thanks,

greg k-h

