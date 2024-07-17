Return-Path: <linux-kernel+bounces-255133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468E933C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFE21F246E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40701802D6;
	Wed, 17 Jul 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AwfCWxxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2bxGJsl"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF918002A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217001; cv=none; b=QZvrA/xpheIv1l3DheaELozDAWCtzGnOe9gFIos7PRr5txmDqWOJmljc3ABDdufAaFHhuQ7prJLxoZCQwBljR43eoGqaUVaWUlKtvYR6jgp9LVKZTWYLQy8EvWkHO33oF7UpHlN4T3QHnVgqLFVk1pvf7C1c+63TD8WLoFPKXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217001; c=relaxed/simple;
	bh=JFIHfQ50RGZrVQnIeC5q5eayE9PE2BWVZpNlsYT8Bfw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=AdRSlJeYFravXiwBx54AlCPJoyx5ahVSHq4S+HXNH41pDSEUTkD8AQkAyifNQsT3cilVN5SRHbIzt7n13hTbSn64T57sKKpKx7hiFhqvhYVU6Nx5osRHLV5ag2AKBOmLFzwu5gJaIfXAjcjL0XmGOJsr9FLlQUXJ4WD+39D8ULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AwfCWxxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2bxGJsl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D92C138008A;
	Wed, 17 Jul 2024 07:49:58 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721216998; x=1721303398; bh=U1vlZOzFkY
	ZM/mArph2LA6zESvl4iI1xFdrbO602QyQ=; b=AwfCWxxZYIVQBNYu07L6UMdbKj
	NghjT7y6ETV/i206imKI8nT2UtcQ6UYkj6C5BeGnSNYRIa+rvK0VEfWzgeg6vYlt
	jh7atohAsNA0W4acDNcytOWUNY7XltrUSc28qSkUEgWjiS58bBb1xapUi5UPQlBJ
	nFiC/GAX0mJ8PXUX6fG0NogJCcundFK9zd5lR2XrVT16qLTyy00jgUq6HdCWUAWL
	9ojR3V2GqkLGgpA+68VgfqlzVCdb0jG2+CysYsWQYMRCVpDvln9GwtIhsotEzFGN
	2ruTqxSpPHUNZJ250TBijWKXNs/aLxJqSEKbVMmBkC0Zih+uzFjEoaxcZtbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721216998; x=1721303398; bh=U1vlZOzFkYZM/mArph2LA6zESvl4
	iI1xFdrbO602QyQ=; b=X2bxGJslVUQzkO1LdeW4LE4WqDuWmu44XilCmTAHPXZO
	VvNGzZKwQPVWuOmMQFimmyGeOIkkhFMtZh9lRS0MuXbcESVPp1jXYD0Mi6Gms9L6
	7EFVdQtndJGDdQyr6Q23XozMOWGvUciaddntOoG/7nPN3N+VNSTM8M7FXauM6rq1
	Zje5x43O1aYR94bp2Mc9w4Ct8kzYtf8KNMJwaWy4vZl10U+vHIO5bvgeRrTsLObZ
	s3itnU1um8zZdg9Q/3jvZXSY9Jvx2IRoVmSTgOQ2zQvBjKFcYidkyZPSck009pRN
	kjC/b/EOXuFzHdXd8Palggm3lOTi2jOGNCJq2GZ5hw==
X-ME-Sender: <xms:5a-XZmIlY6bxLymo8tc0wqaboEDc8sj0m3IY75QQWOd-Uw3MIiQXkw>
    <xme:5a-XZuISG6ZGI06XHV7h2LrAJHD4rOrYhzXkYU9JzNXMe7VNp9JJRtBat7bAdeSOt
    3ZLmbX01gtXK6FwsOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5a-XZmtuNmhI-PHpSFZZlxuB0hz3Mmi_fkngUE1wJryDTeOdviauIw>
    <xmx:5a-XZraR6B8ZIdy7QQpl4OGiLoO3Rt3sUkcJkEyAHcx_w1H2MOfiZA>
    <xmx:5a-XZtZS--zMAB-1kLN_owSilPjQOAofte5k4shDRu6ASQYUY_2ABg>
    <xmx:5a-XZnAlnSWh--gWTB2gT_JXVJr696WNP8ja6OpTDn6rfHIUl1M0qw>
    <xmx:5q-XZsWBjJMcw9DHe_Ezqi6zi6MCz3Qm0Xw_QeDLIXcxWifogmVkviz0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 20D9119C005E; Wed, 17 Jul 2024 07:49:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <024d85a1-6a4e-4552-a5dd-adebfb195be8@app.fastmail.com>
In-Reply-To: 
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
 <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
Date: Wed, 17 Jul 2024 13:49:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation issues on
 32-bit ARM
Content-Type: text/plain

On Wed, Jul 17, 2024, at 13:45, Vamsi Krishna Attunuru wrote:
>
> Neither of them worked in our case, HW folks also confirmed that only 
> 64bit access work correctly.
> I will just include the header that address the compilation errors with 
> ARCH=arm, anyways nobody
> will use this driver on 32-bit kernel.

Please just use a Kconfig dependency then. If the device
requires 64-bit register access, then the driver should not
use the fallback.

     Arnd

