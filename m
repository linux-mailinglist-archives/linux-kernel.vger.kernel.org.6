Return-Path: <linux-kernel+bounces-296520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A7495ABB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A822EB2634C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384020DC3;
	Thu, 22 Aug 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jrpsJGnP"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E81CF92
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295825; cv=none; b=fwa3wsGzdupPMzhH8oHLVvcI7PboxipNFbPU91PScVc9tghN4MPRAxgoHKf75raWaIagpq/7zzlNQQRI52lZVdoDC+YtW+9fc9FpIwvU7WEJN2SdcVl6q3hB8P8r/vVhIpoJnvC07AiVe2Z5C24Vc53XWe7yJmjRJEvtfp4/2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295825; c=relaxed/simple;
	bh=l12OZtzbmMQS3Ep9CoLmE1rli/fH10kTxO2s7q+hv9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jknIf51nF7HBbd0YzzEEsJYH+//G3dUXRHGcU5uz81wL3k2n9h7Jd395rK/xxiWBW6w5eimw5yAJyP2ichiXSx5YeCuEpZ9A8GMFtCSHnPKleYt8nbrfaxL4xTMAQqvtkRnVM29e68Y9uXVErC82uho6elHQAwffuHls11xHPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jrpsJGnP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 23:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724295817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l12OZtzbmMQS3Ep9CoLmE1rli/fH10kTxO2s7q+hv9w=;
	b=jrpsJGnPD6osXOTX4fF7LnR8hkmv0vcbpsT6wArkjIPkizrJEBOg3lP3aO9VdoI5gVjSmS
	pPMlTBK0dMKsRSkxqTwXXy8c2bjo/Vi4Tj7/alDFvWrl1d1IyheLjARoMRG2umReeKRKFN
	d41ZhkHi/AZNiRixc6EfxqjG9+yeC2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write in
 bch2_dev_journal_init
Message-ID: <h4gag7jchx2iirjj4nipeju46bep5vi4qi3cyudmny6a4r6mxu@dkkujl5op2r7>
References: <00000000000071b7c5061ff83639@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000071b7c5061ff83639@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix missing validation in bch2_sb_journal_v2_validate()

