Return-Path: <linux-kernel+bounces-283237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882794EEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540E7282242
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AA17F374;
	Mon, 12 Aug 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uter.be header.i=@uter.be header.b="muIgzAd7"
Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27C17C230
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470915; cv=none; b=fNSohb19gVFbExOseJnbKC4fQdu6Htx8YuLmbR9rqOUXnmCqZu3XAAqpmCzy6f8f//KrGtg0ftiO7V39zwDgiQUJT/dyjfjXqr0wf7L6rS516+6HA/KfY863ZCwl3HPkl7mfDhtsso1HHrX5Tp+mdEpMaIqISKnMzK8kGbrebmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470915; c=relaxed/simple;
	bh=VrDFm2znvH0Xam8Lf4Ov3deiQ8TtNeXvK2GaXRqaEj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkNYLgcf/lkmp/FX3h22jWd6dLFJMi/FoOAkb1dlaQnHMwMPQSqCL4sRS9Z5RyG4HBJ6VE39WhLeI95fyfbhIGc03af9y9hV7gIQhA4R7emhAHi0mXTBnnl6jGdZKu/u36T4//dp2ko+/gYRE9xFSIkbU18GV72whWwjiJg1NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=uter.be; dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b=muIgzAd7; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uter.be
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
	s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tsOaNUnXsW8E+PfttAxy3/HK27PU6Ot2r+AEqAMuPS0=; b=muIgzAd7z2Rrw4e5+fjQK9d4nq
	Csa6WTM0ct0M8SFKikpETUDEtg+RZrsERFdS4aPh1CDhygeVDd78aSXZ3eEr8c8BwNr9I+AKKcDsn
	thLbNmEitzcrxADd+wz42zQ32bYeDeyktXIrdDVQuHMxHR6ILyYXp1aJIqu7G43hbgnT94RXP2S7H
	TV1tS4dqFcHbXqrtalY1HVsDBeuLvh9+c+8fviS7EOtMZiuUOerZC8XANq6L4Pw2VwPQXSY/98vA1
	Yjyran9KjtgRtEo0rbrWIKuehyd/6JBUHeUA73nWdMQVly2iq7dRSv+indXCtPvKd+JdS1cDJ8z8Q
	ZI3L/KRw==;
Received: from vc-gp-n-105-245-229-160.umts.vodacom.co.za ([105.245.229.160] helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <w@uter.be>)
	id 1sdVVw-009ZOe-0f;
	Mon, 12 Aug 2024 15:55:12 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <w@uter.be>)
	id 1sdUyk-00000000Twm-1jVC;
	Mon, 12 Aug 2024 15:20:54 +0200
Date: Mon, 12 Aug 2024 15:20:22 +0200
From: Wouter Verhelst <w@uter.be>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] nbd: correct the maximum value for discard sectors
Message-ID: <ZroMFpaP69uUfC14@pc220518.home.grep.be>
References: <20240803130432.5952-1-w@uter.be>
 <20240808070604.179799-1-w@uter.be>
 <20240808070604.179799-3-w@uter.be>
 <584a1774-0268-4b3c-9a78-0f00073b9d74@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584a1774-0268-4b3c-9a78-0f00073b9d74@kernel.dk>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none

On Fri, Aug 09, 2024 at 09:34:55AM -0600, Jens Axboe wrote:
> On 8/8/24 1:06 AM, Wouter Verhelst wrote:
> > Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46
> 
> This isn't the correct way to have a fixes line.

Apologies Jens; beginner's mistake.

> In general, please don't nest next versions under the previous posting,
> and it's strongly recommended to have a cover letter that includes that
> changed from version N to N+1. Otherwise we have to guess... So please
> include that when posting v4.

Right, sorry. "git help send-email" gave an example of how to do
something like this for a "v2" patch series, which made me assume
(incorrectly) that this is what would be wanted. I should have checked
first, I guess.

Will send v4 (hopefully the last one) shortly with those fixes.

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.

