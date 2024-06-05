Return-Path: <linux-kernel+bounces-202913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98A8FD2E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361841C22815
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0D15EFDC;
	Wed,  5 Jun 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ZT0Wj6/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVOjhAum"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036861FD6;
	Wed,  5 Jun 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604682; cv=none; b=hwMlOscbNbvEeU/1IUVNX2RJiiwQZVAWAEui7pV7hBIDKsbusk1AgwKC8ftvR4F3Uc2Vq9Xmi4em3hZ0rwQgWypzr4TJNQS07cm1ABo2ifL0TvlzDJB0KsG1VDktX3gjA+Pm/RW/Dy9UWH8iFccpOA9z5ocd9mKNSYXlEN2hyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604682; c=relaxed/simple;
	bh=rL1AnJVgXZFiKvo0ZxjEe1wHlVFnfj38mHTb2OSBu1E=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=s8th6ZS/qyn4+SuxR98IcZLLH43ViKfd2ZN1/68F7NFRbWc8bRctfS+jwavhG8HW5K6r39fV01RsDJTdSOQtd04jNDhWcyD0Baj3HJPoXHlrW0MqIA9OJVYyaw+psk6T0N9yHa0pz2K1wllEQ2EIgSqlEiuIxeLD2bmPp3RWEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ZT0Wj6/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVOjhAum; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 87E1D1800110;
	Wed,  5 Jun 2024 12:24:38 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 05 Jun 2024 12:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1717604678; x=1717691078; bh=rL1AnJVgXZ
	FiKvo0ZxjEe1wHlVFnfj38mHTb2OSBu1E=; b=ZT0Wj6/3mSAf33wnAjTFHKYWJS
	nMb6AkMZ9iQTSGIRGNNtjEa/5sjlJGvtgIJlk1KVLYCM+azvPK9S+KIUyPxWelfM
	hPmSUdyVc5+G/dDCF5UpC3BqW33b4A54L1qr23VXwjcoSpCVlWf/TekRN1t3dU13
	VhNSnMa8Qf+TPe2Yevz46MtdxQY++lQ5/1AnuD1zPsm6D0FRh0y8IhGFgkQ8mhLU
	Iv6M+bm0cWgxjMAsokuZcqEr/lbNPZSPcXU8g5DP4+UinnOcUt6EWZL7ATjEh2/v
	C5rFoGB0XxegzOgnGbVyUY1o+im3wOLOo6f9HrjWz5RNJsadmtyPi5Z6QpYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717604678; x=1717691078; bh=rL1AnJVgXZFiKvo0ZxjEe1wHlVFn
	fj38mHTb2OSBu1E=; b=lVOjhAumCPKHeqXbJpImAuCmr4jTutmFpavTEFPnwVrU
	c+3m+qLnOmutWBFhvDgNxBeJYcBfp+eVH6bVJjZcjizpl1G0h12lqUm98/CGGrps
	irHgWx8q3nR/m5rWQP+YPh8UwcNNyE2zYGuBaZGW5XRHKIX5HMDW77+FhsWZpC5z
	tIb4Yjm071s6kfzoq6BsCHTirsbA2CGpOdAkBWe3HUnajxB8g8f61wB1eC3v1a31
	IpG54HrSw3mGqBEvUqmr9HksmmHZFQqCenzCYYDNfEIu7cGPoGvlip83MnAF9xsH
	WUwFbCJSNpChLsNxawdJ3NXPP6aWCnJ6F6IjAb2SPg==
X-ME-Sender: <xms:RZFgZvDiTn93za5R_Mc-VV5FYXeSMPzNBUw6LZzrc9Ziw2OjSE9IvQ>
    <xme:RZFgZlhcsLGLoioehVd5Cg1AQ3r9QZVhZVAWF-ixQNTdDK5qZUz_pnqSiTQwQc1oG
    BgrQ06xMrg8rBZ66ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:RZFgZqm5joN5qOPai4gkHcnynIcvuT66FlcqEwkC33ywLDjVLYXFOw>
    <xmx:RZFgZhxPQjm7MH7IcJY9GGt792ce2iNbXowvP4-fkY5-dSGjWqkLow>
    <xmx:RZFgZkSbYma4eP8PgaZisPNTf4_bXN2EXTXK--VuVux748bm-53jDw>
    <xmx:RZFgZkbQEcvQzZDt4Ujw6ON6O-GtZ7YZ6F7gQqCjca0TRkwTviQg7w>
    <xmx:RpFgZqNIJZJ6IHOZUfubIasVS4pIETZoZNc8izaVAmd5vagjTDLPXQhB>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BE9F7C60097; Wed,  5 Jun 2024 12:24:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a1439ae-ff5d-4a8a-85cd-cabfa06d74d2@app.fastmail.com>
In-Reply-To: <20240605152911.167179-1-diogo.ivo@siemens.com>
References: <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
 <20240605152911.167179-1-diogo.ivo@siemens.com>
Date: Wed, 05 Jun 2024 12:24:17 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Diogo Ivo" <diogo.ivo@siemens.com>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition as info
 instead of error
Content-Type: text/plain

Hi Diogo,

On Wed, Jun 5, 2024, at 11:29 AM, Diogo Ivo wrote:
> Just realized Dmitry said literally the same thing as me. Sorry for the
> extra noise, please ignore my comment.
>
All good - it's a good suggestion and I appreciate the reviews from both you and Dmitry.

I'm looking into it, to see if it works out. Will update to the thread in a bit.

Thanks
Mark

