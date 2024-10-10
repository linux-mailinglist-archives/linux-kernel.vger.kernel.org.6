Return-Path: <linux-kernel+bounces-358480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D5997FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F6BB250D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA850202F69;
	Thu, 10 Oct 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WAc+k4/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43511BBBCD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546913; cv=none; b=o9hJn8qEVb3qOfCBagggaUnQcO39TVq3nXGf4fscUUy5P1jDnNjz9lxfFBuTCerb+nqf0Ao+DHPt1O5Iho7+lx8wubDXNzBxjvaEiskCOCRQgxlp8QzqbGMAbJ+pMD/tJ2G2P50Ac3zoKypkPOTOSAlryihFzOZ6gwKIeBU/V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546913; c=relaxed/simple;
	bh=TlV3g42Y8W2VC/WGMkkTMms4/8FYUEorHOFIiXFAeT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCQHNrO0/4fOg9F/1mc4MBDAOFLzGwnz9I4r100kDoWvvUA3qVNFr0sgnwEi7613lNiv5b9ShnHsoYZC1PWzMt9QTc1yPavpMG2A55RaMM0RX8C63llNFo3c952QWHR6iGPMM/wDHMRMKvZ+0FFFb4t5ge/UpHJ2oUyXrOKUNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WAc+k4/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D0DC4CEC5;
	Thu, 10 Oct 2024 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728546913;
	bh=TlV3g42Y8W2VC/WGMkkTMms4/8FYUEorHOFIiXFAeT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAc+k4/M+UZAe8IztD4HojB8IKP26NlNbaYsn8TdJGkQhuNFeBFhpeRQGZB9N3GWf
	 8Ar5yRJ9IRsCpG0R6NcPc4ulgtL9THFO1/Bai9Wu/WUNbsDg8+vu7B7pdyhvtwX1mo
	 ZNdXCsAXbpGkKLH3PH/aOeCysNZ8QEIwGp3GNezo=
Date: Thu, 10 Oct 2024 09:55:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: sgi-gru: Don't disable preemption in GRU driver
Message-ID: <2024101051-yonder-doing-f793@gregkh>
References: <ZuwaasSf0ZzcYHiN@hpe.com>
 <CAHk-=whVb6ahr=-YpiVqvhCKj+GHME_J0cRi6tn21TPwV7B9SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVb6ahr=-YpiVqvhCKj+GHME_J0cRi6tn21TPwV7B9SQ@mail.gmail.com>

On Wed, Oct 09, 2024 at 12:49:23PM -0700, Linus Torvalds wrote:
> On Thu, 19 Sept 2024 at 06:16, Dimitri Sivanich <sivanich@hpe.com> wrote:
> >
> > Disabling preemption in the GRU driver is unnecessary, and clashes with
> > sleeping locks in several code paths.  Remove preempt_disable and
> > preempt_enable from the GRU driver.
> 
> I've applied this directly, since it didn't come in through any of the
> normal channels, and I don't see it pending anywhere in linux-next
> either.

No problem, I hadn't gotten to it yet in my large patch queue, thanks
for picking it up.

greg k-h

