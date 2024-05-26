Return-Path: <linux-kernel+bounces-189725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31D8CF41F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6868D1C209A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF6DDB2;
	Sun, 26 May 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EWUGtPpD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07608D524;
	Sun, 26 May 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716723823; cv=none; b=odimQaAD3C36yU4G5Z2PB17O3+Xjjf21ufeu2cjp/+mX2TmywDClSQ5vFVXC5RA9midyKev2ueSnyyj2JBQiQHI0AUje7YfsD6JPEW4hhDyop4j8l/M7/imOcoMy5L0VIaqjJIjXG4iCiSwoE1Iovwy0WMVTIBEbb+7drUTmZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716723823; c=relaxed/simple;
	bh=rqHuiOvWxVMRZFLKsP2j06Dn7RS12NEGCqXnMDNN+6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtMLa1dRlq6H94y2zEawynJ5xgsJm4R3cxO5GSfOryOlrqUF4vOhKi2Nl+YdN6xLWpP1YHRjlTM/Ui/2pqDpOv+YoDu9Elx0Om+MUQAio2t5PMGXe9lpv0zptV4VL0tApPKwxyJi//lvTKgFBWkm7BHViAxFSfBPR2yG7zUdiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EWUGtPpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2237FC2BD10;
	Sun, 26 May 2024 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716723822;
	bh=rqHuiOvWxVMRZFLKsP2j06Dn7RS12NEGCqXnMDNN+6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWUGtPpDJsnO8SlczgT68Atd3NKmghBz591zxzCkElvJFDmRAnDIX8z4vTs1IQ9qd
	 Rv/gmzxR+SfJJ75ygmyRLTPvRXw8GvtE2NMhg/xy4sq/pgkZ9LXi7cFDi5YTzjBSB1
	 HDrQDhc1T94pJP71k9JhBY5mFhcdlczRnJHHVkh4=
Date: Sun, 26 May 2024 13:43:39 +0200
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
Subject: Re: [v6] usb-storage: alauda: Check whether the media is initialized
Message-ID: <2024052632-refund-basis-a9f6@gregkh>
References: <20240526012745.2852061-1-shichaorai@gmail.com>
 <79ba60d2-357a-45f0-93af-78879b9f4b02@web.de>
 <2024052647-battle-sacred-83b3@gregkh>
 <ce266282-029f-4333-9ef8-6ddce64e661f@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce266282-029f-4333-9ef8-6ddce64e661f@web.de>

On Sun, May 26, 2024 at 11:20:23AM +0200, Markus Elfring wrote:
> >> …
> >>> Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
> >>
> >> How do you think about to omit the text “[PATCH] ” from the tag summary?
> >
> > Then it would be incorrect.
> 
> I find this view interesting.

It is not "interesting" when you tell people things that are flat out
wrong and trivial to prove wrong.  You are doing nothing to help here,
please stop or we are going to have to ban you from our community,
again.

greg k-h

