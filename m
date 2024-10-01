Return-Path: <linux-kernel+bounces-345661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A292F98B8F1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6856B28385C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277441A08BB;
	Tue,  1 Oct 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Nw9REgsM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKr5OPMn"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2B1A0706
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777127; cv=none; b=lgpyR2GUKAolAi158BIM4L5i+R6Bkn+86yYep3kY+IQKJDEtNLsPzks+xR3sIUoe3rT1rL5e4QA/TdShWaegx4NB4Kgoiq3A/3oR23DgAwYBau7KlmV7lgTvdQyiEurNaE2K3lxeIrCQUfpVdSVZb8WD5SHmnNfe7ciR4uD/boA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777127; c=relaxed/simple;
	bh=HRQUeeqLqOu5sI5kTak+2dYGTfLCAmo5wAcSccTL05U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8FtujWgplMD6sYzEi+y/vs0qOGDafN75aHFdZXTxzLBB8/au6rGZes7YeL2qzFLu/6JtlpBG05Kr0qihZlO0T0uT88tOvARzTs45p+jxtdD5HpEZ7OAzcijaxvoyAV2SHR5wQCZcfVSOKWiRmHERVf+ZMdLDqRLGu2UaKMRxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Nw9REgsM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKr5OPMn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 70E071381639;
	Tue,  1 Oct 2024 06:05:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 06:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1727777123; x=
	1727863523; bh=wOxT5KYR+N51EQ/NZEM7g5lytidSXxiuMO+mQvUywYk=; b=N
	w9REgsM6BmIsqCKAITxVr15Bdos23Jt8SZ5gyOoiVKzzTFHzwxbeBxA4Uc+Ayo+l
	bSWeHLR7lyvIz+a4bLi4K2h0W8VHjW7PlR2bcs6A1ofD01eIYGnilaJQaRg6tTQJ
	cFMgDYAWPS7CE/1USWCd84fbGZ45JVPYEzgj1HqNKBGcRXDaePA4MS3ZcWt22JoA
	7/pQ/nF2aDC4oNASmreaCNIJfJn4fygTUSTbcqHGcqar/2Mt8eZi10lOmBC77z1e
	vDeF+TFhggzYnFfWqzOVFFEmta3rmxTxOMAiudmkZIXUErofhROSJpvkNRA63KhW
	nFD5uXuzWzRV2N4aPrY/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727777123; x=1727863523; bh=wOxT5KYR+N51EQ/NZEM7g5lytidS
	XxiuMO+mQvUywYk=; b=HKr5OPMndUwNomjSf3tYIcRUGSvC3F8UJLnNHob7Zr07
	rtJlUYQKj+8HUuj4lz7g/1Xg5kp4bB1GXNwixkdOEFoZEvooKtcCkj28jykvj0a2
	g1Tvgw0ayFwAxXFA79SUCRUjUwMOFwX3GvmDEoqODDcfx+gLv/5Q4NcvdYo5BnWf
	n9UMniwdjx+asMkjdiWgy/MrvqnqhQebvmjWCtlr8d5abDyOyeogXGVs0JVGbOFE
	Wdt5jR7qoq5BCRoxwJl4kRgyWeQarigEkk4UTzP3WBg4u2QrcinKmM0JkMxLgEvo
	5VlDYdAS19UKNdBhi6+lBjW0LZAmW1BMOu/I/uKhVQ==
X-ME-Sender: <xms:Y8n7ZnkMNLPDH1KiF8sLSy4Xhli8OzJFRoGbe2AUWVywWt8P5t8rAA>
    <xme:Y8n7Zq0h4MXQN712d94ouYB0OTnevhwov-Ca0AYEydAvBYgS3fLycVog1HlntzAO9
    ryqaquLjnVuf6QSHB4>
X-ME-Received: <xmr:Y8n7ZtocjKdVgydr6IoxLAXIPID-BEoSDWF7yBV7qpxjXsqY25AntBFQm4ViIhF9PcO5YVDdU5WEadbBRzUTVXKGPD-xdJ5LFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeu
    ffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhhvghnlhhitghhuhgrnhesvhhivhhordgtohhmpdhrtghpthhtoheplhhi
    nhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvth
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehophgvnhhsohhurhgtvgdrkhgvrhhnvghlsehvihhvohdrtghomh
X-ME-Proxy: <xmx:Y8n7ZvmQbyLM0kz_6Wg1VKdsMmPEMyRAt36zndiRj-1DnpEGazg0-w>
    <xmx:Y8n7Zl00kLVTRtVo94HJvAXS55fqKN-AO2mNt65GtRyJuP3JyUNcZQ>
    <xmx:Y8n7Zut1FEqflWsVRr_VTPk-0paFHmhdf_DmXqSzHRzQumVyjthpZw>
    <xmx:Y8n7ZpXo6N0eKgzfqV76ydY7PVrg3fvvPj42Je2I0ZXiscbKwvZaSg>
    <xmx:Y8n7ZgQV9cDK7Ih6YYbtFPXBvKqiIupwfHSVUlE2fS_KEol3yF92Pwqr>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 06:05:21 -0400 (EDT)
Date: Tue, 1 Oct 2024 19:05:18 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] firewire: Correct some typos
Message-ID: <20241001100518.GA124709@workstation.local>
Mail-Followup-To: Shen Lichuan <shenlichuan@vivo.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
References: <20240930023344.7535-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930023344.7535-1-shenlichuan@vivo.com>

Hi,

On Mon, Sep 30, 2024 at 10:33:44AM +0800, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> drivers/firewire/core-topology.c:59: containted ==> contained
> drivers/firewire/core.h:83: reenable ==> re-enable
> drivers/firewire/ohci.c:1387: apppends ==> appends
> drivers/firewire/ohci.c:2216: superceded ==> superseded
> drivers/firewire/ohci.c:2617: litte ==> little
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/firewire/core-topology.c | 2 +-
>  drivers/firewire/core.h          | 2 +-
>  drivers/firewire/ohci.c          | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied to for-next branch.


Thanks

Takashi Sakamoto

