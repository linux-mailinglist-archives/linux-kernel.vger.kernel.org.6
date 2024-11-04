Return-Path: <linux-kernel+bounces-395628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4979BC0C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1961C21DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F0C1FCF5F;
	Mon,  4 Nov 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lF/FjBoC";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lF/FjBoC"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB751D5CE7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758938; cv=none; b=Ecbk5NE50zmsiePWfNR6lVZjRZtravPwgLAksgQaD+FnWgvMAtGX6PzPQ7LGns9sGz/y3kMILgkv8vX1OW5SlrEAmIuwN35LllD9yEuXGvsTS8E0sipGKbwmjlkzJS/S6kBzjrV5rIvNr+dx8YzObgBmZ+9ScE5ip28hvjZFecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758938; c=relaxed/simple;
	bh=MspEb8yUhlhawdk+jUiRAsb+NCtZYhx+SBu+mc1dAkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WawBJpbVpyv7r2fhl2L9F53VFA/lI58dI0nrHp79ugwj8C9jfpgEZUwkJGJ7EPXg5ZujlLIrTccPt5vZo0ynCi13PXE0+x/i5T7TTzzycXtrKFuLZbB/7U37c0hqtF39iT1j+rLFMryH0SqAAr1kUloVVnjZKuOZBGaYyUxDBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lF/FjBoC; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lF/FjBoC; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730758935;
	bh=MspEb8yUhlhawdk+jUiRAsb+NCtZYhx+SBu+mc1dAkc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lF/FjBoCO6MDYKzvmWdz7DVm2epfQM3Sv/at08PJQAmo3YVgOaLeNCXvkCwbmCY9q
	 nHrJ8O5b3uisbIsbBUHriFMG055jM9Vf2fQxyd/FmQlCfcwzXaoMeQw+HwxQHf/47n
	 wa8eV2pVJ31hQP8s52hO9kpMaxBQELOJcmIh9BVc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A203F128182B;
	Mon, 04 Nov 2024 17:22:15 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gj5JWA26JGbW; Mon,  4 Nov 2024 17:22:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730758935;
	bh=MspEb8yUhlhawdk+jUiRAsb+NCtZYhx+SBu+mc1dAkc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lF/FjBoCO6MDYKzvmWdz7DVm2epfQM3Sv/at08PJQAmo3YVgOaLeNCXvkCwbmCY9q
	 nHrJ8O5b3uisbIsbBUHriFMG055jM9Vf2fQxyd/FmQlCfcwzXaoMeQw+HwxQHf/47n
	 wa8eV2pVJ31hQP8s52hO9kpMaxBQELOJcmIh9BVc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7AC1312810F2;
	Mon, 04 Nov 2024 17:22:14 -0500 (EST)
Message-ID: <b4ab9f3584a83418053122303226490b910ab65b.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC v2 1/2] tsm: Add TVM Measurement Register Support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>,  Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>,  Dionna Amalie Glaze
 <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>, Mikko Ylinen
 <mikko.ylinen@linux.intel.com>,  Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Date: Mon, 04 Nov 2024 17:22:12 -0500
In-Reply-To: <f51ce51e-cf78-499f-b03a-cb45d5364b13@intel.com>
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
	 <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
	 <46609f9a-8451-4961-b307-a13512bbd92d@amd.com>
	 <f51ce51e-cf78-499f-b03a-cb45d5364b13@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-11-04 at 16:14 -0600, Xing, Cedric wrote:
> On 11/3/2024 9:51 PM, Alexey Kardashevskiy wrote:
> > On 1/11/24 03:50, Cedric Xing wrote:
> > > diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-
> > > core.c
> > > similarity index 95%
> > > rename from drivers/virt/coco/tsm.c
> > > rename to drivers/virt/coco/tsm-core.c
> > > index 9432d4e303f1..92e961f21507 100644
> > > --- a/drivers/virt/coco/tsm.c
> > > +++ b/drivers/virt/coco/tsm-core.c
> > > @@ -1,8 +1,6 @@
> > >   // SPDX-License-Identifier: GPL-2.0-only
> > >   /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> > > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > -
> > 
> > Why remove it?
> > 
> It's not used anywhere...

Yes, it is; it's used in this line, which the patch doesn't appear to
remove:

int tsm_register(const struct tsm_ops *ops, void *priv)
{
	const struct tsm_ops *conflict;

	guard(rwsem_write)(&tsm_rwsem);
	conflict = provider.ops;
	if (conflict) {
		pr_err("\"%s\" ops already registered\n", conflict->name);
                ^^^^^^^

James

                

