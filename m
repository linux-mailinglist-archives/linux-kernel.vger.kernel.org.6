Return-Path: <linux-kernel+bounces-230897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67B91838B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F7E1C22380
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459818411D;
	Wed, 26 Jun 2024 14:00:32 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2CBC3C136
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410432; cv=none; b=FfwJ1F9Q5WOMsEj6ATgUBvgN8qvi5wVoiv+Xl1HkLkMYBoihNju0hGYVTWeFzDty4rUCSFBuxx0B7Q2jnt2HsW0P+6o4KszgdYMesRD7E6q+ApucVHvodjRP92WZSZwNgN9FebIfS811Vesqu9OYAiHCe70+ewqK3dcaj5+QoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410432; c=relaxed/simple;
	bh=gN49NjQI2oDX1isFpvDIKMKeo4XbMy61JOUIbU6BEcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd+uleYx85TqH6Vp5gAzUXnAAiQMRAAajVvhTCq/jCkBKgKEw04um3nmR9Ptd8FaznaGwKjGWzMGtAcGxBSaGplkly5oAiYuJyx9QmgqmMk+fMdCkTKxUi/ULc1UvKs6rCeFCkvNedaOTDvsOkvL9uPScKZV9o4CE65WTMbYANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 704740 invoked by uid 1000); 26 Jun 2024 10:00:22 -0400
Date: Wed, 26 Jun 2024 10:00:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
  Thomas Gleixner <tglx@linutronix.de>,
  Matthias Stoeckl <matthias.stoeckl@secunet.com>
Subject: Re: [PATCH v1 0/1] usb: gadget: dummy_hcd: Fix regression due to
 hrtimer migration
Message-ID: <5d7266d4-3349-4414-99c1-4c6154e69292@rowland.harvard.edu>
References: <cover.1719405791.git.marcello.bauer@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719405791.git.marcello.bauer@9elements.com>

On Wed, Jun 26, 2024 at 03:47:19PM +0200, Marcello Sylvester Bauer wrote:
> The kernel CI bots such as syzbot and intel kernel bot reported a
> regression due to the migration of the transfare scheduler from timer
> list to hrtimer. The current assumption is that this is because timer
> list uses soft interrupt context. I have not been able to reproduce the
> regression consistently. So I'm submitting this patch in the hope that
> it solves the issue.
> 
> Do not apply the patch if any bot still reports the problem.

You should send the patch to syzbot and have it run its test.  Then 
you'll know whether the patch works.

Alan Stern

> Marcello Sylvester Bauer (1):
>   usb: gadget: dummy_hcd: make hrtimer expire in soft irq context
> 
>  drivers/usb/gadget/udc/dummy_hcd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

