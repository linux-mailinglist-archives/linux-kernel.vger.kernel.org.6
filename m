Return-Path: <linux-kernel+bounces-523260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A4FA3D472
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD7D165570
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331B1C3316;
	Thu, 20 Feb 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j0iRhFnH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8D8BF8;
	Thu, 20 Feb 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043157; cv=none; b=H6/GXBgcoyd/FxxSUZ06XsbPjpPTXb+Sj1G4U2VCY0aqSzWuIC+Ve9AgQ3G+HaVV/+O0RvDXmb61VgZWeTvP5QvuvDGAiSb0rMoCF3cNnB6jMKViSVQvFIYbO9KVliB+UiI3iJWnZandcoSFjvLcjJCNxlAn3fZ8BcRzeVZuNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043157; c=relaxed/simple;
	bh=l7VM8Qnv+yvJFBEiwVX+4DYl4O1wFRtSVAwgp1c4pbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkFDissCVjmEuMUD1DQfLWcbCcseX9TG7FsHpj8sooufk5jwp9FWeALZhgIskx7oNbo5gI3quPiF0sLB2g4cqD6PiWFDkHwcs3HQK+BjeucEo2tpCot4XgijI2HQwVIX2MV0Ipwfd+L75eo/+p1ILwfYJT1zNv45AKlO2i9lfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j0iRhFnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1461C4CED1;
	Thu, 20 Feb 2025 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740043155;
	bh=l7VM8Qnv+yvJFBEiwVX+4DYl4O1wFRtSVAwgp1c4pbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0iRhFnH5U63RClJ+XpfSJ/cDrqGjeV3jKm1nfl8CtTh4KNiGnnSzPm3YUv74M7h6
	 0EZrn+u3g2Xt5DDIh7NxiF3+tRtxszHbeZK09iTm7sYLh6JoJEj+qVod1k2jUwm+uc
	 ivkknIJKacAclxtgxFKHp83ef6TLvYY3yF08ST2M=
Date: Thu, 20 Feb 2025 10:19:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] staging: gpib: Console messaging cleanup
Message-ID: <2025022050-ramrod-dislodge-cba1@gregkh>
References: <20250214114708.28947-1-dpenkler@gmail.com>
 <2025021923-leverage-endpoint-c06e@gregkh>
 <Z7buAACkugsEOa13@egonzo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7buAACkugsEOa13@egonzo>

On Thu, Feb 20, 2025 at 09:55:28AM +0100, Dave Penkler wrote:
> On Wed, Feb 19, 2025 at 04:48:39PM +0100, Greg KH wrote:
> > On Fri, Feb 14, 2025 at 12:46:51PM +0100, Dave Penkler wrote:
> > > The GPIB drivers printed a lot of spurious console messages. This
> > > was linked to the level of code maturity, often using console
> > > messages for debug.
> > > 
> > > This patch set cleans up the console messaging in the spirit of Greg's
> > > recommendation: "When drivers are successful, they should be quiet"
> > > 
> > > All pr_info's have been removed except for one which is in the module
> > > init of the common core driver indicating that the GPIB subsystem is
> > > initialized.
> > > 
> > > All dev_info's have been removed or changed to dev_dbg except for the
> > > attach and probe messages in the agilent and ni usb drivers. This is
> > > to facilitate the creation of config and udev scripts to ensure that a
> > > particular usb device is systematically attached to the same gpib
> > > device file.
> > > 
> > > All custom debug and tty logging has been removed or replaced with
> > > dev_dbg.
> > > 
> > > Error messages where the user can figure out what went wrong with
> > > errno have also been removed, particularly timeouts and interrupts
> > > during reads and writes which can occur quite frequently uneccessarily
> > > cluttering up the console log.
> > > 
> > > The patches are 1 per driver.
> > 
> > All but 4 of these applied, can you rebase and resend the remaining
> > ones?
> > 
> > thanks,
> > 
> > greg k-h
> Sure, thanks.
> (Could only find 3 that were not applied, will send those)

Sorry, might have been three, my fault, it was a lot of me typing 'git
am --skip'  :)

thanks,

greg k-h

