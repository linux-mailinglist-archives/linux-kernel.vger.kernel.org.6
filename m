Return-Path: <linux-kernel+bounces-364132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30E99CB76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F611C22E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F021A76BC;
	Mon, 14 Oct 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rc5n9kzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636382E659
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911999; cv=none; b=Socnwv83UcWVasq13o1YWR4isXIFov8jAdFbbboShGioBl4afPC83R8zKSmCeaKsgg9CB5WOxnEZfvfOjigfLczz0WPOiivZEw8bhDRhc0+W11Po5lSEdgmzpz7572ferJCslHVD9Tn0x45BtyUG7AaH0rlmZi6kCy+gX2yi9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911999; c=relaxed/simple;
	bh=2qcrfv8L2BfrXb8SGAygqCXAsSGIMtogFy11FDf2ihw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X95BxmXvEidny4YTkzYN6L1OTJot8pFR8WqlrnExD5+w/mybaNmJHZTG0Dez9UBeiN+/HSjkBQ5XryUyLTxo0ygbtH0nRm9UJyHjfme527vxik3pbfRqkYeFOAlJGpP3x7CRcHRxsO0mIwQktIgNpYBvNx8YZoTqo01w84FVBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rc5n9kzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD7BC4CEC3;
	Mon, 14 Oct 2024 13:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728911998;
	bh=2qcrfv8L2BfrXb8SGAygqCXAsSGIMtogFy11FDf2ihw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rc5n9kzPYKY8HOmC2qbI39U/akuMtuSOT5GyLcOzzs5tbca//eG1WC4jeIIcV42Ba
	 LyJfKEQita95+vpMQ8bRD8cnQY44hfem/XZUe1cU38/vDW7ry5lbzsxeLEGzoR01OT
	 XcdMzSIaPbTwrYsjdV24Ygn+ayPfHQYhvn2OVoKY=
Date: Mon, 14 Oct 2024 15:19:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, vimal.agrawal@sophos.com
Subject: Re: [PATCH] misc: misc_minor_alloc to allocate ids for all
 dynamic/misc dynamic minors
Message-ID: <2024101416-scouring-upbeat-b658@gregkh>
References: <20241014131416.27324-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014131416.27324-1-vimal.agrawal@sophos.com>

On Mon, Oct 14, 2024 at 01:14:16PM +0000, Vimal Agrawal wrote:
> misc_minor_alloc was allocating id for minor only in case of
> MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> using ida_free causing a mismatch and following
> warn:
> > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > ida_free called for id=127 which is not allocated.
> > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> ...
> > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > [<605acb82>] misc_deregister+0x171/0x1b3
> 
> misc_minor_alloc is changed to allocate id from ida for all dynamic/
> misc dynamic minors
> 
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>

What commit id does this fix?

And I think we need a test for this somewhere, care to write a kunit
test?

thanks,

greg k-h

