Return-Path: <linux-kernel+bounces-175614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94908C229D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C701B22C48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6B16D4D6;
	Fri, 10 May 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IukzdDqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+jqelir"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99816D30F;
	Fri, 10 May 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338668; cv=none; b=ozwz8dbz2q0O3TOpe0caal09ZdfsJP8wF6hmfYQGNdQMp37kPP5fBySst8YZHAtvnsy32B1bDNADToieKLMqgIt7yVwai2MZk1Ur4ZVo7SJVjIP4pl1HYqyIft4dnr7xhqux1CfGNOSKQaxjvt/SkR9YFBdmO11UAPLQ5D47D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338668; c=relaxed/simple;
	bh=beuQD4HxSaQZV/DNnn/f3oKMqpwYJRIIW3VkGAc9/s4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PC2OsMk7KuxsDSbl4LhTAvER/gZkgEwTdM5gbPNp0XSyBjYD4YrevSafuXzCmO5jS3YTgzCUWfS5UqXLFs9DMWLaL4igKsgc27sCVCxtDnXZ208iOHjEW/t8aBKQ3cr9gmMnT7zFiinhgwTBERbbgbJXSZaFRlERGx0ha8Z58O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IukzdDqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+jqelir; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 35DD311400F9;
	Fri, 10 May 2024 06:57:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715338665; x=1715425065; bh=IdOTLOvVv/
	a4tbDjHTYZHHUrS/wpSNjRqVniwVPoF0Q=; b=IukzdDqg9G5Ko7qJIMQrB4AiaP
	xNGVONnj9Ccv658rkhubj9PNOhNUc/kiw4hZkENyGptsgeSgloiarzyMKQ+z92HH
	32d6AX565Ltmi9YcuWwyM3jjcWlnaM8ZLzYOrHkyolqSkhzQZBGjRIuv6KQe2lQx
	RWMFaeuJKJmyEUlIp7CYF5j/FrL7TQnnwn7ujAt7CWm9rsdk+RnNaqucCAS7XOo0
	Q8qEMAE4PfVH2D/8AIVeACrrgDDn3eNmOHBtU+5mY4J3+B4oWDKPSp5BSb1K0WLs
	HuxpZ9aI8xbyVJo3vC4SCxFMOGFuDVCUIqCB8Yps+V2rxf/MMqZygz6x5yOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715338665; x=1715425065; bh=IdOTLOvVv/a4tbDjHTYZHHUrS/wp
	SNjRqVniwVPoF0Q=; b=T+jqelirQnKYfTqdXqdX+H5knbJoWSbx5val/fneo4Na
	3vSGtYRUX9eThqV4fEKHw08eWp/eoc8Ma4m7GYU6Texvg+BLFrWmS01qBnGXSGqF
	Kn3zIeGSLK1RMytQsadxwoWrCsbfiqiPGBXG7KMz/b4/gog7zxd+PqyJmnJeiHma
	wwfHR1D1+CWiReBJzq6v4uUT8UgXM0NPxvralpaX6QOdkXlk1Th/b3+v7OO3zK4J
	URJNwFZKtLSmQRY9oYjQlFbKudl4utnoq6vjxNaNCEsKoZ9YP0H8Sndc61+mDYL+
	CTbNQD1Jg0jTEBGsTFEBf/gRf2Sg/ON0G2z5TFKC7w==
X-ME-Sender: <xms:qP09Zt3AG2As0aQk88SR1-cDEP1kgd75tDlL9YgbImobKYa8Z5aJzw>
    <xme:qP09ZkHIyZRHcqQ8KFOhn8JaFx0Pd2VnMYIGPIbpuAWgK7zFnlm6CRtoqNg25_nqs
    IL8Y9ij7FqxD3xhTAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qP09Zt4BIZWA0gRZz9KcJZC_2xgAZ2GfqjTMqlcm0VzmucIzpWYWiw>
    <xmx:qP09Zq2rRqi5KxifR6YKFDgPyYewfIGfXgiK1syCxcCWYuDr1etWpw>
    <xmx:qP09ZgFLFKrTREE9g17WpRq-sP5tEFL9t_0w_5sbKaSby5SqVoIY1Q>
    <xmx:qP09Zr9x2Sm1HhAAS1Brq-KvKunnMeerigJJTuyQ1pCb0puQV5TU8Q>
    <xmx:qf09ZhuMjvBQ8GHlGv1UDcSuLTojpEodG-yo-bRA2BwbWHAnmVXqVNli>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9834DB60092; Fri, 10 May 2024 06:57:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4c55013-048f-4056-9866-f0505507d501@app.fastmail.com>
In-Reply-To: <20240510125423.25d4b3ed@booty>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
 <20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>
 <2024051039-decree-shrimp-45c6@gregkh>
 <a1970921-f00b-411d-832d-5289f9812ba0@app.fastmail.com>
 <20240510125423.25d4b3ed@booty>
Date: Fri, 10 May 2024 12:57:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rob Herring" <robh@kernel.org>,
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

On Fri, May 10, 2024, at 12:54, Luca Ceresoli wrote:
> On Fri, 10 May 2024 12:24:06 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Fri, May 10, 2024, at 09:55, Greg Kroah-Hartman wrote:
>> > On Fri, May 10, 2024 at 09:10:41AM +0200, Luca Ceresoli wrote:  
>> >>  
>> >> +config GE_SUNH_CONNECTOR
>> >> +	tristate "GE SUNH hotplug add-on connector"
>> >> +	depends on OF
>> >> +	select OF_OVERLAY
>> >> +	select FW_LOADER
>> >> +	select NVMEM
>> >> +	select DRM_HOTPLUG_BRIDGE  
>> >
>> > Can these be depends instead of select?  'select' causes dependencies
>> > that are hard, if not almost impossible, to detect at times why
>> > something is being enabled.  
>> 
>> I think FW_LOADER needs to be 'select' since it is normally
>> a hidden symbol and gets selected by its users, all the other
>> ones should be 'depends on'.
>
> I see, makes sense.
>
> And as you pointed that out, I realize perhaps DRM_HOTPLUG_BRIDGE could
> become a hidden symbol as it's not expected to be used alone.

It's slightly easier to keep it as a visible symbol
with 'depends on' though, since otherwise you have to
add 'depends on' statments for anything that DRM_HOTPLUG_BRIDGE
in turn depends on, most notably DRM itself.

     Arnd

