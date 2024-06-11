Return-Path: <linux-kernel+bounces-209380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D49033AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D371F2A573
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C90172769;
	Tue, 11 Jun 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WO7QdA+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4A140378
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091055; cv=none; b=oWAYcOi3VnGaLF0G6I2FpqsY4QT3fbHKdSBYyd6h1ER+j6yZ0amUg8TT4fk7jXxpFMn+Lbd0mS07kwKz/MJjHx0JTXRFJrynJ01TfJxx5w+g8H08Im9P1qW5S9XSK79MN4501dI4fOyBM2fZ6ONjPT1NN0z/KOpbPap+35jyUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091055; c=relaxed/simple;
	bh=Z3zVSYFQQvxFm/uK9oXwIg7UIxS4JE3vCPkTXHHvdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhnRory3t8USSGHN/vST1iDfPKizq4qTAg7F9in8mc5wDyWkAgEUE84phlXYuJpaHUTuS1m8Ab06IqhuBq8dgjLoqOD5HaTpV2xHNb3XUpSx3x1KWqryeoESom16L0WF2STGZnsQbBR+lPKVEAyjZ8as20cbOdshk3vSiIUvA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WO7QdA+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A571AC2BD10;
	Tue, 11 Jun 2024 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718091055;
	bh=Z3zVSYFQQvxFm/uK9oXwIg7UIxS4JE3vCPkTXHHvdyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO7QdA+N72LKJw5XsdRR6DEnt5Zb7nLFstakMxZpTjXfiMcY/rcRtqg7C9BZ9S80Z
	 m447BK4OiM7OiFswUA5YnZzRiGKjTmI5/9N8y0gq2iwX6al9kyikragAeHoWS+DwX5
	 i8cd6T/iIdXbd2IXzQdr17xT5qUKW/rXR+D+ATlY=
Date: Tue, 11 Jun 2024 09:30:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, rafael@kernel.org,
	javier.carrasco.cruz@gmail.com, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 0/2 v4 RESEND] drivers: arch_topology: introduce
 automatic cleanup feature
Message-ID: <2024061146-unless-deceiving-ed55@gregkh>
References: <20240607163350.392971-1-vincenzo.mezzela@gmail.com>
 <ZmbhjYdRC4ucv7Mh@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmbhjYdRC4ucv7Mh@bogus>

On Mon, Jun 10, 2024 at 12:20:45PM +0100, Sudeep Holla wrote:
> On Fri, Jun 07, 2024 at 06:33:48PM +0200, Vincenzo Mezzela wrote:
> > Hi,
> > I am resending this patch series rebased on top of -rc2 as the old one [1] might 
> > have got lost deep in the mailbox.
> > 
> > This patch series introduces the automatic cleanup feature using the __free
> > attribute. With this modification, resources allocated with __free are 
> > automatically released at the end of the scope.
> > 
> >
> 
> [...]
> 
> > changes in v2:
> >     - check loop exit condition within the loop
> >     - add cleanup.h header
> > 
> > changes in v3:
> >     - split patch in two
> >     - fix misalignment
> >     - fix checkpatch warnings
> >     - replace break with return statement where possible
> > 
> > changes in v4:
> >     - fix commit subject
> >     - fix coding style 
> 
> Hi Greg,
> 
> Can you please pick these couple of patches up directly for v6.11 as I
> don't have anything else ATM ?

Sure, will go do that now...

