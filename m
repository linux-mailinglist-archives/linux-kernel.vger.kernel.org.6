Return-Path: <linux-kernel+bounces-189600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CDC8CF2B7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D432811FE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F07848E;
	Sun, 26 May 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0xixKiF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896E2905;
	Sun, 26 May 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716706576; cv=none; b=EvqGMyNqraMdI9+gkEI1sMsIXwEAfR6k5oan1mpH6IBt/e7IzxFdsRag9qpcvLpLd9oSf+whnolV2WIR3fuCJ7GiVDbyBQi+OeMAy+6mQBvRgJqIb2z8zsACnZx9b/zE2/baHfCq2fPqbztYMYPfoBaMOBmh85v3rYfDvPcMEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716706576; c=relaxed/simple;
	bh=iDflbs2DKVpnTi/ynlss6l/cZ3iQIxPqW+zBEqhqjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUV4HY8O1TA80Wi0oEvakQEqlzcuNp4dep90w4ir0ztZWDGU8UyLYlUNjq0a47rtebgXNdU6NSqMs67/xqkzdvArPTwyrHlpQmv23wW5kplVZCF//qySlSX5jvkIU5GTKL4KY7/dGl6TfLi2fTdYBLJMIx+VqfGi6C/dk3wr8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0xixKiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9FCC32781;
	Sun, 26 May 2024 06:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716706576;
	bh=iDflbs2DKVpnTi/ynlss6l/cZ3iQIxPqW+zBEqhqjx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0xixKiFSa4PGHtezhve88RoU29l2yzZji+CKboJinmupm97Sa5J3wO7VKyN7E+4P
	 vtdvaDm9orKHsQzKuLttLgLRra34WQjAOV2xk8/xs+x0z+FIpNr40+PTysXcX1Ak5u
	 c8hU6cx03FxDyg1boNUDJOpZM50Tc6tZ9E6cyRo8=
Date: Sun, 26 May 2024 08:56:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shichao Lai <shichaorai@gmail.com>,
	usb-storage@lists.one-eyed-alien.net, linux-usb@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Xingwei Lee <xrivendell7@gmail.com>,
	Yue Sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v6] usb-storage: alauda: Check whether the media is
 initialized
Message-ID: <2024052647-battle-sacred-83b3@gregkh>
References: <20240526012745.2852061-1-shichaorai@gmail.com>
 <79ba60d2-357a-45f0-93af-78879b9f4b02@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79ba60d2-357a-45f0-93af-78879b9f4b02@web.de>

On Sun, May 26, 2024 at 08:49:02AM +0200, Markus Elfring wrote:
> …
> > Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
> 
> How do you think about to omit the text “[PATCH] ” from the tag summary?

Then it would be incorrect.

Again, Markus, please STOP sending review comments that are obviously
wrong.  New developers do not know who to ignore and you are telling
them things that are wrong and not helpful at all.

Please stop reviewing patches, this is not ok and is actually harmful to
our community.

greg k-h

