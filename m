Return-Path: <linux-kernel+bounces-282212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68B94E0E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3291F217C6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5A40870;
	Sun, 11 Aug 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="YL49fnmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7BvG/K/"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E66C8E9;
	Sun, 11 Aug 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723372846; cv=none; b=nEc53SrQGxaz5IbZaF4vh7xPHcaqxVxEiqX2mWI1OTz0Fey1Jy7KjgrSNTGUr+ifHZRcuPPsgCTJqIyQoDQvbQZVk7DvKWiL2298y2Qcg3kGe9bVdJujI745sDZ2IQxNIwytE5IayEpVEr9MqHGhbWwoZ83OaWQzd7GQFxDOdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723372846; c=relaxed/simple;
	bh=5BY5GBS2JPVxYDq5Dfnz+Ns5AObLEPgvnHb6asXZvek=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J+MhFP7I42tnCWyQx64FfZcH2yhcQwcIpWQ/9ZcMDSgUkgW/6cYA8BVGU2iv04R50MJ/Rd7fwbEDivMZGIojMClvW6+ZznGrqQnlhepFOE79dWKrRAh1F/xWz3G0yyEBf4ha0Fq+RoOmrbiQA4+SddvMXSvYv7EiLnMhSRdHEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=YL49fnmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7BvG/K/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id DAE2C138FCA5;
	Sun, 11 Aug 2024 06:40:43 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Sun, 11 Aug 2024 06:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723372843;
	 x=1723459243; bh=u7zYXiocmfhkndQ+rVNAKKdxHzSFNUhXi4QyB95dfnw=; b=
	YL49fnmcM75sLpdvqAPTNnI8fngCgQAkcmN/e24ipcKKGtp8hQ8glU2kEAMKlHrm
	/5eMwqi1sjTBsN/Je3MIetysbvpZIRwuFwcI7wfj2lcepYVocLIUo7Oy4g0dertl
	ae5Yoy6HaRk/GOfjxBJNZBzC/FJv0GoMTAJeFaU5hUIo3gH/x6emVNfWcyCIFLnr
	9eTNk5c6JxP3ota1+N5prQri/+jHB4oPm4vYstOzVzZ/6KEBGc/ObKIkkWqHe0qe
	v8hcGJcPv5vjUl+MDKLHCCl+R6wxMHsvdrB40ngCjX34oPuLGMa2jYm5OHQpeXlx
	zsvvrDoL1NR6dEw7M1fo9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723372843; x=
	1723459243; bh=u7zYXiocmfhkndQ+rVNAKKdxHzSFNUhXi4QyB95dfnw=; b=N
	7BvG/K/NnYnML2F/fidHljt/cPV9YQ06wK621Xrkpt8jOlV7+zWYLE8jhNDaCcGe
	eFKy3Y1a7/y29tk/Rploiw9KdhO5h6TMyb+9LFqUbHGL2lhwk+OmXZ82HvGbyNZ4
	u6WcpAtfqp01/6VMXKCBBYJBVhfc+iVOK0oDVwItOiEJqa2hgcI9mR4vx7k3Ddwf
	pNy/yDpO0fBabj+v9xz0XqmlVSgr0mgjBu08WmXLPBAHDYscroxVOnKxAO83JODZ
	V6twppIe9h6C4sTHRFhGXCAkv0CIVTC+q9txr0C0L0aQB/snCsOIFleQF6mgdsR4
	nr5q+tV8skqbbQVR0Ln7A==
X-ME-Sender: <xms:K5W4ZlqItvxzP-wq4RZwtkGuxdOg-k4Vi8be5e3lkBazGs1dmJZsAw>
    <xme:K5W4ZnoGJ5_gjUxQ-aHPKK083kHSpDPFS5TpR5uI_UutWvGyBFB1jrVmfwvtQyDBw
    w5Z5lMRF8KcNR3KLNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleekgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepgfeiffehtdfghfettdeiuddtfeekvdejgfevhefhffev
    tdfhjeelgeefffekvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghorhgvnhhtihhnrdgthhgrrhihse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K5W4ZiO2R4_QSZVhbht20MgRM-T91S_BHzk3r85-P-RuuBmVXGS7YQ>
    <xmx:K5W4Zg5rU_atzO5rK7P5rBvtZoADO-lr7-AlxK8Fb31et_zbBjahvg>
    <xmx:K5W4Zk7t3uTf57Xmjhya8rx9NZiYraMxOhH_PYHRy3Oday1dFcAO3w>
    <xmx:K5W4Zoi67aQ9f8LRp6aol3VDeIB8Ok6QjttI3Km2T7N5Ns0q9Sla9Q>
    <xmx:K5W4ZinpzzwC0FwQ9wl8wUPQ-wypy1TWIIdCNOKh0HpjHsT_0YFhTreo>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AC19A2340081; Sun, 11 Aug 2024 06:40:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 22:40:23 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com
Message-Id: <e4dced3b-004d-44f8-b8cd-64a4a53965bc@app.fastmail.com>
In-Reply-To: <bb056dee-508c-6186-324a-d45bbd1c2306@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev>
 <20240806020747.365042-3-luke@ljones.dev>
 <bb056dee-508c-6186-324a-d45bbd1c2306@linux.intel.com>
Subject: Re: [PATCH v2 2/6] platform/x86: asus-armoury: move existing tunings to
 asus-armoury module
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > +{
> > + return sysfs_emit(buf, "integer\n");
> 
> Lukas Wunner might have done something to make emitting constant strings 
> easier, please check out if that's already in mainline.

Found it, DEVICE_STRING_ATTR_RO is what you mean?

