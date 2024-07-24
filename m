Return-Path: <linux-kernel+bounces-261408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF493B6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89075284EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADAE16C691;
	Wed, 24 Jul 2024 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QMdb2nWp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130E4D8B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846597; cv=none; b=Ne82YRvULCU6d8vTPTexSOjbwWLDkMGx0iXBwPM/IhEuaniqigt/0XcFyXdOZPYRQJr+dxOI4sgk2Ps2WKt8PGioEprtmlOEt/423eeItPlVzgCgpgoky91VTu0ywnAw4TbC26TAO28896Ccj/nE5YY2o03Z+pxzhnSo+ezU6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846597; c=relaxed/simple;
	bh=Br/NEEvBU8PR2mBSYNoIal96755QejFyRGN1CwGNi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MosNGUvZb7NWcawNwYszMuzfsJrWSbRDUdDAKtzwG4jaV0I6qQDLkc922riQp0uq5/HImJkDuB4IZ6xdhhtZeY4u2VUhKh/v3aFcwWHBXv2ME9VQ6h9I+j0rnvmoyIAS1v8FD15nQPfyN9e+g/0AWruePVY3VS8dWtqnQg4LyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QMdb2nWp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721846589;
	bh=Br/NEEvBU8PR2mBSYNoIal96755QejFyRGN1CwGNi5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMdb2nWpODU/EYTUmmaXpLdYgkzNWBjgXKt6nNZ7EnuDeO09D2SNe0PFSsG/lBIac
	 Vd7Ol3dgRiNoyb+kcp97cguY9QhvIcKZMsVyqDgOC7/oQRRiRdnZ6eoW/VaCFwGo7t
	 R16D8KGqkoeGiH+/jbYhn0Gowe/JTm2T/BEjIrtI=
Date: Wed, 24 Jul 2024 20:43:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <28c3d8b8-201e-45b9-b7eb-4da3e0acf7cc@t-8ch.de>
References: <20240716152705.juet6srejwq5o6je@joelS2.panther.com>
 <cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
 <20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>
 <8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>
 <20240724084124.hbbn3jfcbsc7pyov@joelS2.panther.com>
 <12465755-1df4-4231-9bec-1044bfcdca4a@t-8ch.de>
 <20240724091817.eohhckduvtjscibg@joelS2.panther.com>
 <CGME20240724093233eucas1p148db81823daa1babc0b2a74ce501bbda@eucas1p1.samsung.com>
 <84dc8f21-78d2-4ea2-ad79-3f85b610c0a7@t-8ch.de>
 <20240724182058.svxh3ux23p4fnqqf@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724182058.svxh3ux23p4fnqqf@joelS2.panther.com>

On 2024-07-24 20:20:58+0000, Joel Granados wrote:
> On Wed, Jul 24, 2024 at 11:32:26AM +0200, Thomas Weißschuh wrote:
> > On 2024-07-24 11:18:17+0000, Joel Granados wrote:
> ...
> > > > > ```
> > > > 
> > > > Yes, IIRC I got told during one review to drop it.
> > > > But for me it is also necessary.
> > > I also remember a comment from the XFS part of the patches where you
> > > changed the formatting on some functions. What did you do to address
> > > this? Did you change them manually? Or do you have a script?
> > 
> > Yes, the style fixes were done manually.
> Ok. I have created some sed scripts to automate this.
> 
> > 
> > > > Thinking back, there were other "virtual" lines, too.
> ...
> > >   int , void *, size_t *, loff_t *);
> > > ```
> > > 
> > > > 
> > > > (It doesn't find anything else, though)
> > > Maybe you are missing running it with --include-headers?
> > 
> > There seems to be a slight misunderstanding.
> > I meant that it does not find anything *new* on top of the existing
> > patch, not that it can fully recreate the patch.
> Sorry, misunderstood you.
> 
> > 
> > (I used --include-headers, undid one header hunk from the patch and
> > validated that the hunk gets recreated)
> ok. That means that "--include-headers" is active.
> 
> I actually made further changes on the cocci script for it to catch all
> the corner cases that you did by hand. The patch changes substantially
> as now there are much less formatting issues introduced by the script.
> I'll include you as co-developed-by and in that way give you proper
> credit for your work.

Ok.

I ran the scripts and for the result:

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

> In order to reproduce what I did you need to run [1] with this cocci
> script [2] and then run [3] with this sed script [4]. I have checked to
> see that the same files are changed. The difference between what you and
> I did is mainly that coccinelle does not make any formatting decisions.
> 
> Will create and send the PR shortly.

Ack.

> Best
> 
> 
> [1]
> ```
>   make coccicheck  MODE=patch SPFLAGS="--in-place --include-headers --smpl-spacing --jobs=8" COCCI=SCRIPT.cocci
> ```
> 
> [2]
> ```
>   virtual patch
> 
>   @r1@
>   identifier ctl, write, buffer, lenp, ppos;
>   identifier func !~ "appldata_(timer|interval)_handler|sched_(rt|rr)_handler|rds_tcp_skbuf_handler|proc_sctp_do_(hmac_alg|rto_min|rto_max|udp_port|alpha_beta|auth|probe_interval)";
>   @@
> 
>   int func(
>   - struct ctl_table *ctl
>   + const struct ctl_table *ctl
>     ,int write, void *buffer, size_t *lenp, loff_t *ppos);
> 
>   @r2@
>   identifier func, ctl, write, buffer, lenp, ppos;
>   @@
> 
>   int func(
>   - struct ctl_table *ctl
>   + const struct ctl_table *ctl
>     ,int write, void *buffer, size_t *lenp, loff_t *ppos)
>   { ... }
> 
>   @r3@
>   identifier func;
>   @@
> 
>   int func(
>   - struct ctl_table *
>   + const struct ctl_table *
>     ,int , void *, size_t *, loff_t *);
> 
>   @r4@
>   identifier func, ctl;
>   @@
> 
>   int func(
>   - struct ctl_table *ctl
>   + const struct ctl_table *ctl
>     ,int , void *, size_t *, loff_t *);
> 
>   @r5@
>   identifier func, write, buffer, lenp, ppos;
>   @@
> 
>   int func(
>   - struct ctl_table *
>   + const struct ctl_table *
>     ,int write, void *buffer, size_t *lenp, loff_t *ppos);
> ```
> 
> [3] 
> ```
>  sed --in-place -f /tmp/constfy_formating.sed fs/xfs/xfs_sysctl.c kernel/watchdog.c
> ```
> 
> [4]
> ```
> s/^xfs_stats_clear_proc_handler(const struct ctl_table \*ctl,$/xfs_stats_clear_proc_handler(\
> \tconst struct ctl_table\t*ctl,/
> s/^xfs_panic_mask_proc_handler(const struct ctl_table \*ctl,$/xfs_panic_mask_proc_handler(\
> \tconst struct ctl_table\t*ctl,/
> s/^xfs_deprecated_dointvec_minmax(const struct ctl_table \*ctl,$/xfs_deprecated_dointvec_minmax(\
> \tconst struct ctl_table\t*ctl,/
> s/proc_watchdog_common(int which, struct ctl_table \*table/proc_watchdog_common(int which, const struct ctl_table *table/
> 
> ```
> 
> -- 
> 
> Joel Granados

