Return-Path: <linux-kernel+bounces-546657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C7A4FD53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4984616B908
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE77230BCC;
	Wed,  5 Mar 2025 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="aWrZ8EOC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyD82Zjq"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965320DD6D;
	Wed,  5 Mar 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173244; cv=none; b=gL18zIReYejnVM9inLbRmuSGBm84igInsRwM0d/AY2TKhgwsNqAZp0WFFDSq+F7q9iC2yPAaO/rQ2w8zUcCzK4ezYu3j41DD1lhYqXFew6Zpdov3NrqvaeQMuj1bKBC9X91lxhZN7N9pGBAzRWSnRJlzb73yg2Cdetvo7pCD9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173244; c=relaxed/simple;
	bh=qvW7Pwf0BHUfLdz4/ffzDft+TDlxo8yRzDf7LYcSjBs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCTEI9HXxARe7RXRN3jbjCcqyl92FAFGL/1lJg+phqAEUd+vdw1nso6beytanz2P8zwA4HpnB/QxXnWnvUnrV4hkNOB10QDvR99PNSqQMu0zqKiwkMHafXRLHPsTOEZ9KVOTNWTr4La5qOVydY//SEET1h4eWGfx85lzPjRlC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=aWrZ8EOC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyD82Zjq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3810D11401A0;
	Wed,  5 Mar 2025 06:14:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 05 Mar 2025 06:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741173240; x=1741259640; bh=N7EyxBWyLy
	ajrG4+9lXdCeKumGTXiAwsgiBLJZor9Cw=; b=aWrZ8EOC+RieG3O+SaJvHntFdP
	aWuLIDSDSs51YA7BIgut+4JUr0QziAtOEDsStpO5P2PcKC17StOwTnvMlA3kza/1
	DJUAI/B55g1foagX9u6pbFNin1f7mbPdqUM39Kh59pZ3AEnFYiFRDI7SdtC+JbZU
	L+IRHgfOVb+0aESCK+vObDZSD7I1RfIFhPO/ir2PxF9c6k8xe+JD+4oCFh6GxzvV
	hwjsF0KO2fiI6/+FpVy2I5paKFTP7jejJfcCv2zMPhMqv7dFsEx91BzJNOaMdars
	/vb0THG8IVj90o/953ajBq+kqWJ67FPrpG9c09Svy0kjp+nUCd5lQH7c71oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741173240; x=1741259640; bh=N7EyxBWyLyajrG4+9lXdCeKumGTXiAwsgiB
	LJZor9Cw=; b=hyD82ZjqGGBxAT50kQ+JdEuzR64zcpMQcNAwlRMNy3K8sTtzoY9
	vsDfERzKSeFggASzD5CxDsxyNe/RzzmcO9/KZRz0a284CQYvyn0Yk7i6cFe1BOvh
	I8EIFrAhDe727en3iZoi6n7hqM/cNqMJhIPutnZOP7zmdns75MBLZQcNG6/Lmi7s
	ucfXbeV6xZ5lW4a4IsF/DK5xakHk5hzbb+Lm2XiNNaCT3JXtnwAk6Nf3Nlelgp1I
	BA4V8Fq/Fi4x9WFsbAOp1Ka6QA6yE9tHQmihtdIj0+YXmuL0FcnEHR2yJZW6mgw3
	qYa/6zN5ELeFHoXtGaiF89QsJLfiC07tv7A==
X-ME-Sender: <xms:9zHIZ3PZ2R2SjXmY10CFjU_jjEJgAZpRCPLq2XvAS_4fzyUQwCbfDA>
    <xme:9zHIZx8EGec3GHlnT1xJUFb1U9RezQ-9acsdTNBgUqnvqfIObe04qDAyz6ue3t_01
    s8BCfKb5Z79bhy1iQk>
X-ME-Received: <xmr:9zHIZ2TzToUAh_ktBodC_iCb9yvJOcU6QKod7TEHroIka6cqYLsIjpI7kUZKZYlTuDL_Esvc-DNPiqRY3CftuQehZg76OqBPRV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeejgeeifeeuveeufeei
    geegjeelvdfgjeegffejgfdvkeelhefgtdefteejleekjeenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpth
    htohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgthhgvhhgrsgdohhhu
    rgifvghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhr
    tggvfhhorhhgvgdrnhgvth
X-ME-Proxy: <xmx:9zHIZ7vlXA4cHOGuY_Qfi0GPXXKwYMkab50FI_C6aG1eVqZ0svdaxg>
    <xmx:9zHIZ_eWm8JQxNMzqVpBmL8ldeeeE15ygXvImEuCnl3-87aIKzx23g>
    <xmx:9zHIZ33Ne4R2-e44jbY_DmGf0XABMUbE1UGHmS0fWwWd4bd6OsCWZQ>
    <xmx:9zHIZ79dLutUTnROV69x7zShglQrEDtYebtnKBUY_TfgQg2RsQfQWQ>
    <xmx:-DHIZwFa71z7HJNY6SaamS-uL37tUjTTzEJPXlG9SY5ujxrgoRqPhpmc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 06:13:58 -0500 (EST)
Date: Wed, 5 Mar 2025 20:13:55 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/27] drivers: firewire: firewire-cdev.h: fix identation
 on a kernel-doc markup
Message-ID: <20250305111355.GA143843@workstation.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
 <56d88f897214cbfc4593b4bb4b2a04d0168865d7.1739952783.git.mchehab+huawei@kernel.org>
 <20250220050313.GA414097@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220050313.GA414097@workstation.local>

Hi,

On Thu, Feb 20, 2025 at 02:03:13PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Wed, Feb 19, 2025 at 09:32:19AM +0100, Mauro Carvalho Chehab wrote:
> > The description of @tstamp parameter has one line that starts at the
> > beginning. This moves such line to the description, which is not the
> > intent here.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  include/uapi/linux/firewire-cdev.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied to for-next branch.

I dropped the patch from for-next branch since it already exists in
jc_docs tree.

https://lore.kernel.org/lkml/20250305135637.51f92f44@canb.auug.org.au/


Regards

Takashi Sakamoto

