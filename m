Return-Path: <linux-kernel+bounces-540561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D49CA4B235
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A23AB8A9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7551E3761;
	Sun,  2 Mar 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8ymg5Q8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99391519BE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740925624; cv=none; b=imOKZLJI2sZyAOo2mdFHm+gbG2A6EGTdTaVZui6Q3sZ0UKxCxf6LRQaZuESAnzKnTCbK4Zkmqu+jR26eRCUw7n6GGbuqg9GuxKfkxhv2+9Zxyigv/Nd1wqW6XXmAV3H8oIN9K135xePjcRXR5BsXQMdz0jxjJGhtXUpBxujeKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740925624; c=relaxed/simple;
	bh=aKaIxUY0VRW52Ui8iC6HgHNpx18yvJM6J9k61Z/ZbQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Fq6EUu8OqhP1Xtg4bR6JAHnukBkK0h0RvaLJogJi/oZWeElMGvC8QcOQ9Tn1ejVBeThbquNW6hCNfy6/Zqu0OZpepGB6qXGzdXYG6sufRqnIvJfPhxi6b40SKiKFlL1ESF1HB7D1F6pxLsDN+aTeZElIDHBw8cf3yp3qiRSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8ymg5Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF3C4CED6;
	Sun,  2 Mar 2025 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740925623;
	bh=aKaIxUY0VRW52Ui8iC6HgHNpx18yvJM6J9k61Z/ZbQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8ymg5Q8bIdFt93m2U5HK15vHs5s9VHwJLvssNBmSdTgto4kT8YyHKGg5EfGXcC20
	 O5lYoo62RjrJMbBbD7UJrfoqoV6m2+6r7KlF1Z9YU2ScjF+mtlB7YPDAJuQXqr680c
	 nump01TzP46udHSDNQMEwEbRWRYsh6thp384BZ54=
Date: Sun, 2 Mar 2025 15:25:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2025-21818: x86/xen: fix xen_hypercall_hvm() to not clobber
 %rbx
Message-ID: <2025030236-item-coral-d4b3@gregkh>
References: <2025022710-CVE-2025-21818-27ee@gregkh>
 <f78c7925-8057-4503-93ec-c50386a63862@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f78c7925-8057-4503-93ec-c50386a63862@suse.com>

On Fri, Feb 28, 2025 at 08:28:48AM +0100, Juergen Gross wrote:
> On 27.02.25 21:03, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/xen: fix xen_hypercall_hvm() to not clobber %rbx
> > 
> > xen_hypercall_hvm(), which is used when running as a Xen PVH guest at
> > most only once during early boot, is clobbering %rbx. Depending on
> > whether the caller relies on %rbx to be preserved across the call or
> > not, this clobbering might result in an early crash of the system.
> > 
> > This can be avoided by using an already saved register instead of %rbx.
> > 
> > The Linux kernel CVE team has assigned CVE-2025-21818 to this issue.
> 
> Please revoke this CVE.
> 
> There is no way an unprivileged user can trigger this issue at will.
> The issue is guest local and will either happen very early at boot or
> it won't happen at all.
> 
> So no security issue.

Now rejected, thanks for the review.

greg k-h

