Return-Path: <linux-kernel+bounces-200079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F88FAA5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB5B288599
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC113EFE1;
	Tue,  4 Jun 2024 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCnhakrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BA13E3F2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480796; cv=none; b=Kn3LqcnQOPdKN5HuTl6MfpmSIVDAqzqXrjJNnb5YHyeXK8oHHX1i7ehhH3ae/wcgDrPHURQrBeQl/x3yChvRqKgPa7S5e2kj6UOF7AMoG6uhDFZbyGXti5TrT6bZ4Wpsu/GaJXcoxi4tGD6dMWqK9CSjMuSA+mpO2bllDc36HSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480796; c=relaxed/simple;
	bh=Ckf0ovplH5lI/Jy8+5S/19UVx5VPM/Jncn3YBcF4M0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2+KPi5frliJM24Fo+GOZmnNVm9U3TJm1er43voj0TQmeaZNUmUi8Hy4rq7L3hMnuR+Zqm2q0oqqr/L26ELiBs3vSwL8H+zSQXpS6KqBv8JAnvf5TdsHucvFMb/CwZtr5ssGYG3cYD5xAh2uPpprgUl/oxQJse5mIU/maC2QczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCnhakrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD07C4AF07;
	Tue,  4 Jun 2024 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717480795;
	bh=Ckf0ovplH5lI/Jy8+5S/19UVx5VPM/Jncn3YBcF4M0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCnhakrsZoz//aDMnmzLkfalR6VF8Cs3+FUOfBfhLqcwwIBHSeW4qeNNpoeWcd3xQ
	 tvJ4t75M6iwjmS2dQXO0pPSAHgI8xnP0SSl6jG5lWKGLYLssvpEAB1pdqO19H8p+Iz
	 MbI7bQP98l/S0t8M6QNmOR+nfnxWPtU9Fd4m5sPY=
Date: Tue, 4 Jun 2024 08:00:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"Lubart, Vitaly" <vitaly.lubart@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: me: release irq in mei_me_pci_resume error
 path
Message-ID: <2024060451-lukewarm-matrimony-2c38@gregkh>
References: <20240603132928.977787-1-tomas.winkler@intel.com>
 <2024060419-stoneware-staff-b840@gregkh>
 <PH7PR11MB760572C6EC68727B2F1B1BF1E5F82@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB760572C6EC68727B2F1B1BF1E5F82@PH7PR11MB7605.namprd11.prod.outlook.com>

On Tue, Jun 04, 2024 at 05:45:56AM +0000, Winkler, Tomas wrote:
> > 
> > On Mon, Jun 03, 2024 at 04:29:28PM +0300, Tomas Winkler wrote:
> > > The mei_me_pci_resume doesn't release irq on the error path, in case
> > > mei_start() fails.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > >  drivers/misc/mei/pci-me.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > What commit does this fix?
> 
> I would say 33ec0826314734fc4f3c9bf37 , kernel version 3.13, it's very old. I can respin with the comment, if you wish.

As it's a memory-leak fix, that would be good, thanks.

greg k-h

