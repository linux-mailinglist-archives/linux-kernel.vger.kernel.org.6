Return-Path: <linux-kernel+bounces-358497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F36998022
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB8D1C209B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275EC1BD4F7;
	Thu, 10 Oct 2024 08:09:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00F1BD03C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547773; cv=none; b=R9aiCupPUEXJs6/2Mgmy9zzVMBimJve1hjtxMN3x6xZ6YYAOOxpnHBGr73sgr6+EL+Ung6Rky2vB43xiiCYwJGQuCRxb5Ajc4MaHyS3P6vQjw72/kk3zaARJHzDaSi+ACcRFFUxNQnhOaH0NYMyCbR8lSk3F1i4Lozln0RIry1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547773; c=relaxed/simple;
	bh=UXAUmCCgWw4hsCqVFZ6jDKg0+f6nhEfKJ8CTkDoDtE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiG7KGFR4PSjj8O7f15GegnUdS6ub3ytlcQjA3xP+bbSHb7dkz0zrepgFd4ByyqLnrb+y/PEvLxTjK2SRSAA+AZ85HCyFJWooWOGpv8ka0y+Wyl4QccQJ5FEmeNdpD9sjwsMqbHWqZIOHFJCaCMq7BB2KCeLTq1aHUlrrligWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D079C227A8E; Thu, 10 Oct 2024 10:09:27 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:09:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
	brauner@kernel.org, sfr@canb.auug.org.au
Subject: Re: [linux-next][20241004]BUG: KFENCE: memory corruption in
 xfs_iext_remove+0x288/0x2c8 [xfs]
Message-ID: <20241010080927.GA7980@lst.de>
References: <ae6217b4-7b62-4722-9afe-f8379201cc9e@linux.vnet.ibm.com> <20241008063307.GA22312@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008063307.GA22312@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 08, 2024 at 08:33:07AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 07, 2024 at 07:34:18PM +0530, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> >
> >
> > Observing Kfence errors, while running fsstress test on Power PC platform
> 
> Is this new or is this the first time you run kfence?  Any chance you
> could bisect it?

FYI, Marco Elver ever pointed out that this was an issue with kfence vs
krealloc and the offending changes have been dropped from linux-next.

