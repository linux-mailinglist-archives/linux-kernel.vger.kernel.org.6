Return-Path: <linux-kernel+bounces-206203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E89005AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90A22920A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B21196D99;
	Fri,  7 Jun 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="QFWwBGKb"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEB195B2E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768446; cv=none; b=JzjJ11jOzHPiDKsMBNit3oWK6HYILGdsP7/QlI7pliGHbjIaUjcDSxMikeQ7KgHnVCID+GbSSwsg7JkVTy//T5Rl5NXSjtsjyWNaarp9hIekqnURP/vj3qvNwLeD8EfOdToFjaeQYVfPd2i/NuM/jskVJT6Yhypio335iDuHbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768446; c=relaxed/simple;
	bh=Mp5s+leBjzFi1kNNv9MmnZ647UlxmmCA12Jil7R3iA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLsr1GKCE51geMqZyPrAzJndxqmZEUBrCGSLEyKc9MSlZM/BAofqkpSss75kUKs8dqTN6OVt70IFzgsSUPJuB/Pta5WeXpWlD3HJhgTu0B528oNP2gvqjOn1lW7taCzj765lMx/GlEb2WrjQMT65lCJeMPc+czDQVaYlvYr6dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=QFWwBGKb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717768441; bh=Mp5s+leBjzFi1kNNv9MmnZ647UlxmmCA12Jil7R3iA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFWwBGKbihW15MB0Q7Ef6M23/p3loPUKAsnFnOyrG1oZ2XP7kYY3HiIIIjWiv+ZZv
	 4G+j9AFEplaaua/bzDtYmWCLKX2PQ9LTLw89iHwOyV0lmuZVEAZmGomXMW4WJx7zIy
	 d/oL6CQHk098jql2uAE/Mlws//xQeRSKFpd0becg=
Date: Fri, 7 Jun 2024 15:54:01 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <37d5fd30-9327-4b57-8e4d-22af929d3fc4@t-8ch.de>
References: <CGME20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2@eucas1p1.samsung.com>
 <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
 <20240607094053.x3cmkhmrgaw6jqd3@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607094053.x3cmkhmrgaw6jqd3@joelS2.panther.com>

On 2024-06-07 11:40:53+0000, Joel Granados wrote:
> On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> > Hi Joel, Hi Luis,
> > 
> > most of the sysctl handler preparation patches have been picked up by
> > the subsystem maintainers and are available in -next.
> > 
> > Only two are missing:
> > 
> > * utsname: constify ctl_table arguments of utility function [0]
> > * sysctl: constify ctl_table arguments of utility function [1]
> > 
> > Both of them are going through the sysctl tree anyways.
> > 
> > With this done it should be possible to also queue up 
> > sysctl: treewide: constify the ctl_table argument of handlers [2]
> > for the bots to chew on in -next.
> > 
> > My local builds are still succeeding on the last submitted version of
> > the patch.
> > 
> > 
> > Thomas
> > 
> > [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net/
> > [1] https://lore.kernel.org/lkml/20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com/
> > [2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/
> 
> All this is coming together nicely.

Indeed.

> Is there anything left to do besides
> what is being discussed in this mail, to start changing the ctl_tables
> to `static const`?

The changes to the tables also need (as per [0] and [1]):

* sysctl: move internal interfaces to const struct ctl_table
* sysctl: allow registration of const struct ctl_table

I think we do the handlers for v6.11, the rest of [0] and [1] for v6.12
and then we can go through the rest of the trees ctl_tables.


[0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/
[1] https://git.sr.ht/~t-8ch/linux/log/sysctl-constfy

