Return-Path: <linux-kernel+bounces-296545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1372C95ABEA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF741C21007
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997A1F95E;
	Thu, 22 Aug 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ury7Hfg3"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790F1CFBE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297491; cv=none; b=mG2p2+wyMnfPt1k6UX02FgRXU1sZxOHILxxohyfLHQx7cSNruIVUMJseMfbna2Jh6IKgi5HdxXxuxlPs7R2h5P9pczgXTTdcCWrZGX2cS6mZhs89T9Q57bDLMUb5Kesc5zrs50Qx0CLaECyffrejuLlL/MUo3Q6UqIFIGODtGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297491; c=relaxed/simple;
	bh=a46l7iXz0WtBz7CZJjdmIJHzpbuIfnkkjcvh23FpB2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrkTBxs/s8q6RBCOKr/mOGmWpI3TTA8qNrAU2ICgH9hY0u+M11YUtVd6RYY7w/MkbEpQftwhNGshx0uu4SEybCIG1WoZmrME81LfCfJd/5I6g0+75t9bGw+SX+imq5l1BqCPOMej1hbdazGiZ6XFxZPPCsHt0M2EO/xsdFlMjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ury7Hfg3; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 23:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724297487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a46l7iXz0WtBz7CZJjdmIJHzpbuIfnkkjcvh23FpB2s=;
	b=Ury7Hfg3udj2aBnMoqgyI/N4faNnbpyy5gEUUS56RJ8JdBMnWWWFBN0bFKl2BjfZQFu0St
	7XoXqea2nLZspW4BlwfLOxDl+LPxnB5d6bsys7uAXflnBHBEH8LhNFIUvoiVv8ENOXdJWO
	+8A52YmygO3ILSCnB4UKNiv9Pj1EKKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+9e0404b505e604f67e41@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in
 percpu_ref_put
Message-ID: <wsianmy6cqt7ok2dosx5dp4dufneu2ekykfzvlvvcvbwv7qint@2zr2esze5ur5>
References: <fmgmxhirocusm3zmnki4m7miyqemwgxyjybjr4wvq7u2xupjyg@qwqjonwarhcl>
 <000000000000108bb406203d368d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000108bb406203d368d@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix bcachefs: Fix refcounting in discard path

