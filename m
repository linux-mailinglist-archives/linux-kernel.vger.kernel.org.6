Return-Path: <linux-kernel+bounces-175590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEFE8C220E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC11F214CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316FB168B16;
	Fri, 10 May 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SLY6F6B2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZhLmQsf"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4C168AEC;
	Fri, 10 May 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336700; cv=none; b=Cw+VfREQPUzK+AXrRgZZDZyFqiHd/2oPtxLFD6FDRVNmpNRHP6AyUL5vJc0SZNbh3+zvEh+AHRfF8ZLcSTd+kTsg9kq/yssn2swi5gFQSdWRVej9T65QmOUsQ96v7BFi/kMAjYFY8lsEY7EjMf+g/AoYUwFlIi6xjyPuVS7i8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336700; c=relaxed/simple;
	bh=Hl6kXvzdVfgBxSqvB2M7xmg83KYSmqfYFk93FT/AylA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Apt5kaKBIRfYLTKjbHgMOQbtVsj46Lll7tRg4tRepeupPfLx/e8t/q2yL+cmIITXGm+E88+CVTCCuHCSYKjWXJ/NR9a4WXJz5UnXNGnNLVrg9t4h1Vcx566oqSAfBjDSOZ3Y9b29q78LtheFwD3HHB2zSFY+y6K0jXVNlw1kvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SLY6F6B2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZhLmQsf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7EC2F13823D7;
	Fri, 10 May 2024 06:24:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336697; x=1715423097; bh=RV16UsPZ7k
	HshFR9q+mGzDhSzK0T5+eVMIdSnuqNlDU=; b=SLY6F6B2eaidYessQIvxF2HLgB
	s5090Pe5YP0hfdfqS7mU4pD4KRf+UJmfuGvKw2mvDarEa+r6MW3ep4N+DN5/FRLY
	TsPIh648rVXqnVqS+gnqVVyDObNseJ+DOKfMPdMqlXp0u8pxZKPEVi/uRSIOgwYt
	mBMT77GaRYkeOjSIp4biyAiC2sIfUPzbBvKU390EIK25fc9PXb0Adzy9jy7YSvGa
	YtejdqijxrzC6Jx6PQMsB0jaiSBfBnPjhQ8YZchnmui0vJP3hke0HjVxA5BTI+jH
	HbBy/J6nSAUjSIJyRXKAhT66t37U97M+itVI4jiMOmgc3Ma+Zw/zNx5S8JNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336697; x=1715423097; bh=RV16UsPZ7kHshFR9q+mGzDhSzK0T
	5+eVMIdSnuqNlDU=; b=AZhLmQsfDQlx2APbhbWtRxGvWE4UNrkDsaqZkx60eMBM
	g9xiKjc+F1veqBdQKO7Anf/2sale2wTw/GxFTlYyJ2Znw3JKqKR21UPbz+YAJanD
	yQJmIduuegPtg+c71XvS1qFYyR3mmlnTYsyWOuokqVwbYmshZcy5zuWfPdBOmxkR
	gxt+pcKCNmT+D5nT9/nVBDI2aD8GuVxLyiCTQ8I6NTa4349Etbpw7uuTcTi19wP0
	69BYC34wXcVDcQni/kR4BD36iHkR/9zCatefEE6oR3oGcRF59iWdDjlEzRiveQu3
	h/+FXvQXR86jyauFVzlCohImXL8OatFQFSbTznSDYQ==
X-ME-Sender: <xms:-PU9ZhYwWkgfbPa-0eshJpo0NtX7ukpQmbyKsFWhTUd9crgBTmu8Zw>
    <xme:-PU9ZoZZ2IVXIvk1H9CG9-BbpYgqEWMnZZ1_mADIFFMWR4IN87yP2p2jhfX-RMEm5
    E3e7xqY-ALhHaf66vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-PU9Zj_adBC4n-cN6QpAGMOdOrMC6WWZSQ3SHTRqvln6rXnYl1wutw>
    <xmx:-PU9ZvryzBZj14Z7L0XEk14GUgS-gXl7dumB6gfO7rZIBFkXZ-G3yg>
    <xmx:-PU9ZsrUS94Kkm4NOaj6bAMHOLZinAZuwKyjAp25QYHKZgXtt7KHNg>
    <xmx:-PU9ZlSylZ5GJdrLBsFgjN0XdKKkrYcbtf9_ml77vBZvC_z1R0S8Lg>
    <xmx:-fU9Zuh9E-TL5FOJZWXE-wKCh0cPkLp6ysPIriZDu4c4KPsnoWpN-mDV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B6FC3B60092; Fri, 10 May 2024 06:24:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a1970921-f00b-411d-832d-5289f9812ba0@app.fastmail.com>
In-Reply-To: <2024051039-decree-shrimp-45c6@gregkh>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
 <20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>
 <2024051039-decree-shrimp-45c6@gregkh>
Date: Fri, 10 May 2024 12:24:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>,
 "laurent.pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Dave Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "Saravana Kannan" <saravanak@google.com>,
 "Paul Kocialkowski" <contact@paulk.fr>,
 "Herve Codina" <herve.codina@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "Paul Kocialkowski" <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 5/5] misc: add ge-addon-connector driver
Content-Type: text/plain

On Fri, May 10, 2024, at 09:55, Greg Kroah-Hartman wrote:
> On Fri, May 10, 2024 at 09:10:41AM +0200, Luca Ceresoli wrote:
>>  
>> +config GE_SUNH_CONNECTOR
>> +	tristate "GE SUNH hotplug add-on connector"
>> +	depends on OF
>> +	select OF_OVERLAY
>> +	select FW_LOADER
>> +	select NVMEM
>> +	select DRM_HOTPLUG_BRIDGE
>
> Can these be depends instead of select?  'select' causes dependencies
> that are hard, if not almost impossible, to detect at times why
> something is being enabled.

I think FW_LOADER needs to be 'select' since it is normally
a hidden symbol and gets selected by its users, all the other
ones should be 'depends on'.

    Arnd

