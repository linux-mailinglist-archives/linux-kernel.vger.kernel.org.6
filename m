Return-Path: <linux-kernel+bounces-196488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893F18D5CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B961C2094B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375E15098B;
	Fri, 31 May 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="DWDORLjd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chlzhL2A"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168374E09;
	Fri, 31 May 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144725; cv=none; b=H6UYUtd0gVQqDgOvuw4JqBmi8Xosj3wbuFPpn2rhsijxVNz47th3MKivai61s1bmieH2GSpK4u9TRwDFFcHPY4aAIkbks5IVm4t+YzjxDJqWGQqfqJ/UoSW6452IHaGB0truxKA+7xONKo2KWg+acEkZHj7DqwT7YrzY8SuIfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144725; c=relaxed/simple;
	bh=MG6LYpllHmnJXtgJOt/alUy0Z1+D5pDhglGk5gH5q64=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Cr7N3m8o2sC3O8s2f8IP9V2ekx2ali6IVFUatDexGKFfCzUFSlkk500+hD0xZkZpOgXJw7IjHRnrTT/kwb69LDbUak3XiMWRpwOVPrkRAUJ8I9Tw4mRFQ4m65IWg7tyXCn25gONlFS5u5djR6OM4ghagoz6AqtmLm6qRDHwMR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=DWDORLjd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chlzhL2A; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7E22B1380150;
	Fri, 31 May 2024 04:38:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 31 May 2024 04:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1717144722; x=1717231122; bh=MG6LYpllHmnJXtgJOt/alUy0Z1+D5pDh
	glGk5gH5q64=; b=DWDORLjdbmk4tl1FU59msoRJmHQGiFrXHMPkuNI15jaUogpy
	bKkJBA9BaP9GGdlVujXHJQcMCdyxmo/3UuQmv0vNw8NCNzQZ1kELKLtACAeNVMv/
	6ZKnJzsjhzehmzS68T8Yx/av0urEkSfqhLX1DTx1YtPZgbSUvcLvOKwWleCgwsoq
	sfnjwOMdXN7yqUpMURKiEFnLXQBCSqdCV8Icziq42lx0OGaJvBrnVdwAipfHUJpP
	aBR3FWbBt4G3jpxovuvFBLYlDkAolQp4wj13yRjOAdv5NrfpR3bdBsV8qS54XV8I
	uD1TJ4ZPIdKhdej1iY2sevFuU2731FLxvbEiUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717144722; x=
	1717231122; bh=MG6LYpllHmnJXtgJOt/alUy0Z1+D5pDhglGk5gH5q64=; b=c
	hlzhL2A062qJIl6SaoPmO/xGl9XwZ2fygnJudOYlfUzA4cefi/nz9+VbU8wYJfdG
	/cL8dIOxd0ka7BmCQJOYE/ZeyIhcdxvAHfDw27C6maXN2BV/LRyXFo3DDAqecKAt
	wDdjCejignjSk/UErTjdVvAdITAUyEee1S9Nw5sejinDQPU6xyG0AGMEEsoeZmGP
	I/5B7CLAXa9wBcsJdj+lOLNjh496FUXUktWtpe0cagCrvxH6p2QeX2Z0nnRkUAYU
	gc9u1lwMeWb5zM/vVpcwOWwF4x9iYRdaSnZ7XqWex3nwkDnc3uBOUwGxuCokGZ2Q
	csiof3Y5zSe6U6oMj6Ghg==
X-ME-Sender: <xms:kYxZZjQZybnWdagLKRyq5wu3Vlj694bJ1DlN5vM_Y6qlrQSBixNjxA>
    <xme:kYxZZkyPKmM_tapOuPeo5fWRiaaqA7_1MLFlw9MogW-Ke7m_lu44MCqByDYKIC6DT
    i9AiVJyV_aa4z8Lyig>
X-ME-Received: <xmr:kYxZZo2jTW9cGswgRt1VHIklVETmwA7Ok7TM5DGQ-LcI_eQ_Sgj12Oyu4YSQFvU6mKrYFsS1D_MAB-vUKHLfifgtCrhyUmuco6H4sXwBzrkVPOCvbFIFywOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefuvhgv
    nhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvdfhtdduuddvueejueffgfdukedvfeevgfeuieeivdeltdehgeeivefftdet
    kedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:kYxZZjC93nUGwlXDKszUwMtwIgbwTDrHKXp0RKodNQN4YuNUcrEIQQ>
    <xmx:kYxZZshxU5LiQn-YdhIcw93ZdLxWx4RAENapjv1MT5JMvT5Hfx3BUg>
    <xmx:kYxZZnq-Bxsn3m7hCHTqlitekPxDxXhSjXBH4Oq04dn2sb6GidzAzw>
    <xmx:kYxZZnhHg06x4apEEznsdQcOWD_3n3AipBxUAMBJtB8GUPYrJus7Cw>
    <xmx:koxZZtYV8P44-h6v_o0yn23f6Hc8gbJtmPAeMTcdZjeZ1453k_veuEvZ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 04:38:41 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
Date: Fri, 31 May 2024 10:38:25 +0200
Message-Id: <F36A6A33-240D-4F88-B0D9-5C08E35DBC8C@svenpeter.dev>
References: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
Cc: Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: iPhone Mail (21F90)


> On 31. May 2024, at 07:16, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:=

>=20
> =EF=BB=BFmake allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-a=
pple.o
>=20
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Sven Peter <sven@svenpeter.dev>



