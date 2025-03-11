Return-Path: <linux-kernel+bounces-555542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C987A5B951
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFA47A64AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9301F09AC;
	Tue, 11 Mar 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QyYU6EqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CB20B22
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675062; cv=none; b=aiuyItjbqRoynVXbfwsdjoBH5ksKuDS68afxf8TMJ5rSu5A9m19vZXEz+qEXHrlf0EoEv7Ymr0EdRnm8hJb/gjz3aZS5FlrNOnz671XzfwjName7e9p84Utw3DbPeEo4HHR9MW8mopmnvJ86nJ2WOnSDxWHCpaw+aivQJSeYXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675062; c=relaxed/simple;
	bh=7Dx/02eJ/SX/h6USt8YYSv8WT2B5bIjFotP82bWP5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1GYVYdxG17pk429aCWQZKWetnhJEk/h2Q3PyaFHrbrwXlfaXgrmarGfKuNP3LLgOeA6DJDJ3g98RSOm/syhBzv3FjbIhyqT+mbE50VVN8WjoRvfQXVHIbIrotXT53qe0TLuaXhThe5PVv5qgtB/GMs2ikqY6d0o9F+QUN4y/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QyYU6EqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF6CC4CEE9;
	Tue, 11 Mar 2025 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741675061;
	bh=7Dx/02eJ/SX/h6USt8YYSv8WT2B5bIjFotP82bWP5Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyYU6EqGfITDsG/KrDr3tfVA1JWz7h/yXLRt045l76yrCPFNauVphJmBhCpM/0zDe
	 RdE40RaGszT4wsAU8y4rd7fwfNAoi3LT/W7DZ/AHiKKQ36GJ7suVTPjlIke+0yzcB2
	 Fs54wpo131/EddZceDvd7ZFqgOuyCMuVJQ7hc7fc=
Date: Tue, 11 Mar 2025 07:36:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: conduct@kernel.org, Nhat Pham <nphamcs@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Qun-Wei Lin <qun-wei.lin@mediatek.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram
 compression
Message-ID: <2025031104-ovary-uncommon-2007@gregkh>
References: <20250307120141.1566673-3-qun-wei.lin@mediatek.com>
 <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
 <20250309010541.3152-1-hdanton@sina.com>
 <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com>
 <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com>
 <20250310103427.3216-1-hdanton@sina.com>
 <CAGsJ_4w8cFgdPmHH5KLeKoEEVN1LT4-z0sX_2vtV5sc7yOQb8g@mail.gmail.com>
 <20250310230902.3282-1-hdanton@sina.com>
 <CAGsJ_4xFxLxX0=DrbiO3Mi5yCjCfZiDuJrbhTEra=rOnrD-W7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xFxLxX0=DrbiO3Mi5yCjCfZiDuJrbhTEra=rOnrD-W7A@mail.gmail.com>

On Tue, Mar 11, 2025 at 04:57:19PM +1300, Barry Song wrote:
> On Tue, Mar 11, 2025 at 12:09 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Tue, 11 Mar 2025 01:44:27 +0800 Barry Song <21cnbao@gmail.com>
> > > On Mon, Mar 10, 2025 at 6:34 PM Hillf Danton <hdanton@sina.com> wrote:
> > > > On Mon, 10 Mar 2025 09:44:24 +1300 Barry Song <21cnbao@gmail.com>
> > > > > I also feel extremely uncomfortable. In Eastern culture, this is an extremely
> > > > > vulgar word, more offensive than any others.
> > > > >
> > > > If culture is not abused, feel free to show us how it is defined to be
> > > > more offensive than any others in Eastern culture.
> > > >
> > > Having no manners is not your fault. The ignorant fear nothing.
> > >
> > Oh lad, just tell us anything true. It is not difficult.
> 
> +Code of conduct.
> 
> I know there is already a ban for this person in another thread [1],
> but I am also
> officially requesting an additional ban. Having contributed to the
> Linux kernel for
> over 15+ years, both professionally and out of personal interest, I have never
> encountered a developer who engages in random and irrational personal
> attacks[2] and persistently did this despite clear requests to stop. This is
> utterly bizarre.
> 
> Please give serious consideration to extending this guy’s ban on a
> case-by-case basis.
> 
> [1] https://lore.kernel.org/all/67cf7499597e9_1198729450@dwillia2-xfh.jf.intel.com.notmuch/
> [2] https://lore.kernel.org/all/20250309010541.3152-1-hdanton@sina.com/

We will consider it, thank you for letting us know.

greg k-h

