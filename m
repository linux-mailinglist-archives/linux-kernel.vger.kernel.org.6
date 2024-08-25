Return-Path: <linux-kernel+bounces-300595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAC95E5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73B9B20FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078A7829C;
	Sun, 25 Aug 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K5op8Ip2"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27575FB95
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724626609; cv=none; b=UDSiJnjRbXUSszC7e+wG7HnjmqaZ3Yh+6xjj4+lyl5BVPk5/Q5P92v7jtXTPBUd+CZxHzIzqPNiHRjMWR6yYnzZweQ08856kQB2hsVsiXr0UaHML4ncJv/RGQYJaWEek5+qdNqT1GNUDrQ6HFFNdxDEtbJ3cmEi9UBeDWfSFg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724626609; c=relaxed/simple;
	bh=o/9/dp7m+vJ6ofeCsjLpgogIu9jFAw+16nSLtRlYMGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3bYG4oO+tzXa5fofEVjNuE0RXbwnpH/5du45kpSj/k7wbL97XVQH/XrmQtZrnJ3TCfxvVybtKeeeAVut6dxsBXgxntuBJYHegCV0ZGSn8VEHa5DYYv6x2dqfNJ/ZHTC7ysxcq798MytVXY1V/EJclXyNVRsu2l/0dKPlSsasKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K5op8Ip2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Aug 2024 18:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724626604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUU2IrjoS9nlFdQljMH4vMe883KRBelEyTsR9JLtyC8=;
	b=K5op8Ip25btqj+AaqJ4p0e89IWib/+k7s9cMkw7qo83l0EH9vcm0GtB28wLtUCr1cvWCeL
	sFVOqlUolsVhhYvKeDf+qgBYKioP9loQQxaBWlkcT8jZBEuNKxkG0b3BIv552hrdjpFQtc
	Z0l0uOo2TX25quJnYXk2sQSep7aLRhA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Annotate bch_replicas_entry_{v0,v1} with
 __counted_by()
Message-ID: <b7eqkyfv4nvxlserwuknw73y4c4n25b2i36xfsn4cfhjg4yc2n@oawo2z4ye6lo>
References: <20240825133601.24036-2-thorsten.blum@toblux.com>
 <cqyrlfpjprkwdteljmtcnl3z2etzitvodrlv7v57tuizvklpcx@gg7dbstowwd6>
 <4911B345-A37E-4FB9-9339-83029033EE4D@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4911B345-A37E-4FB9-9339-83029033EE4D@toblux.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 25, 2024 at 10:41:55PM GMT, Thorsten Blum wrote:
> On 25. Aug 2024, at 20:43, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > On Sun, Aug 25, 2024 at 03:36:02PM GMT, Thorsten Blum wrote:
> >> Add the __counted_by compiler attribute to the flexible array members
> >> devs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >> 
> >> Increment nr_devs before adding a new device to the devs array and
> >> adjust the array indexes accordingly.
> > 
> > The nr_devs changes are pretty gross - please add a helper for that
> 
> How about a macro in replicas_format.h like this:
> 
> #define replicas_entry_add_dev(e, d) ({
> 	(e)->nr_devs++;
> 	(e)->devs[(e)->nr_devs - 1] = (d);
> })

Does it need to be a macro?

