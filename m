Return-Path: <linux-kernel+bounces-412232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221959D0598
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C3B21AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B871DA63F;
	Sun, 17 Nov 2024 19:56:01 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369F2629F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731873360; cv=none; b=XBJLQJj152BMtZ6eZF2AG7t2p5X9tvrXliwyARaTLDz7mFhkndP/bAcz2SK6SUqFZko+L8TomuLTZ6DFkJiSO9bco1fmXjz+tzS/uXj3O940Kk/IllMPY70HPF7WOfbI79dwUjcjiKTz3WN1L3OqlzmQmA1aw5530Xy7XFDOTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731873360; c=relaxed/simple;
	bh=n7XGudOLGovITogP1axb0THO1/byVmvU56YQepMv1hs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roVyVZt57mLeDk38bGccS3VAcGyBWil+CR4uEclmHUw1UI1ZNG7fY42lfur/L4aBMuH5Re2+ZxlJrVZNT8+hFrGA6iDvlNZdTZimGnJxfSCIk6BnwsO7pxZ8HbBnk8Uq0xTi0bFdBLeK/UyRVuBi8evcwUj4J7HniMkrS1YLnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id eb150528-a51d-11ef-a0de-005056bdfda7;
	Sun, 17 Nov 2024 21:55:40 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 17 Nov 2024 21:55:38 +0200
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	David Laight <David.Laight@aculab.com>
Cc: gregkh@linuxfoundation.org, andreyknvl@gmail.com, b-liu@ti.com,
	johan@kernel.org, oneukum@suse.com, stern@rowland.harvard.edu,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v2 0/8] drivers/usb: refactor min/max with min_t/max_t
Message-ID: <ZzpKOuZeWidsyGis@surfacebook.localdomain>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>

Tue, Nov 12, 2024 at 08:58:09PM +0500, Sabyrzhan Tasbolatov kirjoitti:
> This patch series improves type safety in the drivers/usb/*
> by using `min_t()` and `max_t()` instead of min(), max()
> with the casting inside. It should address potential type promotion issues.
> 
> Scanned the current drivers/usb code with `max\(.*\(` and `min\(.*\(`
> regexp queries to find casting inside of min() and max() which
> may lead to subtle bugs or even security vulnerabilities,
> especially if negative values are involved.
> 
> Let's refactor to min_t() and max_t() specifying the data type
> to ensure it's applicable for the both compareable arguments.

max_t() is okay to use, but min_t() is quite a beast. Please, reconsider the
entire series and tell how had this been tested? I can't imagine how many
subtle bugs it might have introduced.

min_t() explicitly casts to the given type and this is a huge problem for
the cases when one of the parameter is of signed type. Besisdes that it
diminishes the type checking done in the min().

As Linus told, the many cases when you want to have min_t() is actually 
clamp(). In some cases you wanted umin().

+Cc: David.


-- 
With Best Regards,
Andy Shevchenko



