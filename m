Return-Path: <linux-kernel+bounces-171217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2368BE150
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3E91C21515
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A3155357;
	Tue,  7 May 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="l25KanTb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvmzHek6"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421015252F;
	Tue,  7 May 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082295; cv=none; b=QixejoTgCCiv6H7aKiPF9PItUSCVzGTEdUmvQfnqhrdiCCEGq4zcgGn5xTfwJf4ZwvZ9frkgd3oBGTA/wZU6tYeUG479jYawZ92lDORiqYflPxBYFzuc5R2BJ9jH9H+k3ZGmbvzoQA+GHnli6O0AcTnUEchcF+PuSRSs9e3XrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082295; c=relaxed/simple;
	bh=5l9Z1Urm/BZzymLPMlD2GWT3dGvV7j51ig+v/GSYq6w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=a+95Pzi8BR0MNFVjMnMxvl05Nf25CTilgnjycV8pGegwJZr7pCPjPZt14zqGf8cU/AYyS4LGMpFlm+GfMqZFtM3HnXQMOV/kNpuU+miH6RPBPS12B3NwUefsF8leh16wJxYH8ZP8aeaGbbepndU/tQ0a6n6pmhws/psfIPqk/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=l25KanTb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvmzHek6; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 3F9F31C00142;
	Tue,  7 May 2024 07:44:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 07 May 2024 07:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715082289; x=1715168689; bh=ecSzO7Aiwn
	igNqU/smd06vR9/fdGnYG1J6IeAomF44c=; b=l25KanTbH8tO7kcr9GFjrecLwg
	Z38jY6q5DqfCawwG5fjpy8zcT/YNv1FhdSFBn+VSbhay0UEAYYF+9+MIHVx+3f9C
	4h6XRq0bAZmviePUd5dJP1sVV9/dygg3z5csVujvGnhCQTNlM8n/AuKojBdeFEHY
	BX5RMoRXi01OS4CtRsyfoAIWsevQ6wJw0IMoOLMMIExjcIgtPMOANt763ap7/O9O
	Rs/IqGa6U92qQ4VglQJG+QMV3gPLwuzI83jO7xK8CdY1nt0dKsorDO90Pg4nFlsJ
	lNXSLxvh8RPdN8add2Vu1dKs90ijc8FNUtyqZPOzozXvZ6uaLk/bs1V9CqMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715082289; x=1715168689; bh=ecSzO7AiwnigNqU/smd06vR9/fdG
	nYG1J6IeAomF44c=; b=CvmzHek6TFypfJ1RPBnToLT7kzymcthSWcUJhd7JnfZ3
	hi956ge5sXR7a6ozc+SdLsCthpzzBYholC7g/eOPqD6phpCm94RYhqyutTGOFvo1
	CJZtKJCf5HRY9etbVeUyInoik5gIFJ/fz3V8wBR71p3QLzGzrPRr3c7pD/Y8txlM
	R0VgJah6C68E6gB0NdcgF24qDOoF3/FiJL3jSZcZb2kqzZP4aEEAXIhKCYBu35yN
	U6MAULIlG+u3s5gmQRkzmgMcYBxURcDhUvsADnbDpgsB5h6fNpwYKkG9seCJTli1
	V2YJ0G7gLKPAjViF+AHsn90PqMK4gmSvqU4qcTJ6/Q==
X-ME-Sender: <xms:MRQ6ZrAGja7cwKav-14qSh78VkHNmbwbMbQmkRXLP4MgUSUJGaHVAQ>
    <xme:MRQ6ZhgVRBjVtvxLB6_-nP57D1fpRZINSUsOO7UjLsG-9fNw7otV7iGG-bZ29kRQN
    RcYNIbwcEnQKuYSeuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleehueefffevveejgfelveeiuedutdevtdfhtdevveelgfevuedtkeeiffei
    geffnecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggv
X-ME-Proxy: <xmx:MRQ6ZmnjcLkaFldQNiLDyzPzJnD5Gddm6M1Jc4ttt89PRmFoEganhA>
    <xmx:MRQ6ZtyVEFmcby4FEwu1Licg7YFNX1HbfCYP1rbOsIOMVfsCKyRfhw>
    <xmx:MRQ6ZgQ7x_0f1vfI8n93hKIWYCUk2Cwsg-9hdPAhVaKSgnea0FkFOg>
    <xmx:MRQ6ZgZVcG0-mi-NqiXX4vKIBIh9oLhJoPnkzQUPOKk-Jex0-g0e_Q>
    <xmx:MRQ6ZjF4s5pRzqUx7PzFMR6biDCDifQj0LniQvsif9cEsJpA1QjtO-wL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 55BF9B6008D; Tue,  7 May 2024 07:44:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <41191296-0aa0-4010-b70f-efa80b9200d4@app.fastmail.com>
In-Reply-To: <ZjoMI5bJSlqhtOy1@phenom.ffwll.local>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
 <8e1867fc-34da-457c-b95a-2d51ea97336a@app.fastmail.com>
 <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
 <ZjjXtEwWWZX43c6l@phenom.ffwll.local>
 <47c63c4c-c657-4210-b476-c91c4f192483@app.fastmail.com>
 <ZjoMI5bJSlqhtOy1@phenom.ffwll.local>
Date: Tue, 07 May 2024 13:44:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Vetter" <daniel@ffwll.ch>
Cc: "Florian Fainelli" <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, "Helge Deller" <deller@gmx.de>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Sam Ravnborg" <sam@ravnborg.org>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Content-Type: text/plain

On Tue, May 7, 2024, at 13:10, Daniel Vetter wrote:
> On Mon, May 06, 2024 at 04:53:47PM +0200, Arnd Bergmann wrote:
>> On Mon, May 6, 2024, at 15:14, Daniel Vetter wrote:
>> > On Fri, May 03, 2024 at 01:22:10PM -0700, Florian Fainelli wrote:
>> >> On 5/3/24 12:45, Arnd Bergmann wrote:
>> 
>> This is the current Android GKI config:
>> https://android.googlesource.com/kernel/common.git/+/refs/heads/android-mainline/arch/arm64/configs/gki_defconfig
>> where I can see that CONFIG_DRM is built-in, but DRM_FBDEV_EMULATION
>> CONFIG_VT, CONFIG_FRAMEBUFFER_CONSOLE, CONFIG_FB_DEVICE and
>> CONFIG_FB_CORE are all disabled.
>> 
>> So the console won't work at all,I think this means that there
>> is no way to get the console working, but building a fb.ko module
>> allows using /dev/fb with simplefb.ko (or any other one) happens
>> to almost work, but only by dumb luck rather than by design.
>
> So using /dev/fb chardev without fbcon is very much a real idea. This way
> you should be able to run old userspace that uses fbdev directly for
> drawing, but your console needs are served by a userspace console running
> on top of drm.
>
> vt switching gets a bit more entertaining, but I thought logind has all
> the glue already to make that happen. Worst case you need a tiny launcher
> tool to get your userspace console out of the way while you launch a fbdev
> using application, but I think correctly implement the vt ioctls to switch
> to graphics mode /should/ work automatically.
>
> I do agree that this is only really a good idea with drm drivers, since
> those do not rely on any of the fbdev infrastructure like the notifier
> under discussion.

I'm pretty sure what Florian is looking for has no dependency
on VT, fbcon or logind, but I'm only guessing based on the
information I see in the public Android source trees.

My understanding is that the Android recovery application is a
graphical tool that accesses the framebuffer directly and
is controlled using the volume and power buttons on a phone.

>> I suppose making CONFIG_FB_NOTIFIER optional for FB (on by
>> default if any of the consumers of the notification are turned
>> on) would not be a bad direction to go in general and also
>> address Florian's link error, but that doesn't solve the
>> more general concern about a third-party fb.ko module on a
>> kernel that was explicitly built with FB disabled.
>> 
>> The GKI defconfig was initially done at a time where one could
>> not have CONFIG_FBDEV_EMULATION and CONFIG_FB_DEVICE without
>> pulling in the entire fbdev module, but now that is possible.
>> Maybe that is something that Android could now include?
>> 
>> Alternatively, I wonder if that recovery image could be changed
>> to access the screen through the /dev/dri/ interfaces? I have
>> no experience in using those without Xorg or Wayland, is that
>> a sensible thing to do?
>
> Uh ... I think I'm confused about the requirements. Does android's
> recovery image need fbdev (meaning /dev/fb chardevs), or does it need
> fbcon?
>
> Note that fbcon runs (or well, should run) totally fine on top of drm
> drivers without the fb notifier. This wasn't the case a few years ago
> (because fbcon also used that notifier), but nowadays fb notifiers are
> only needed for legacy fbdev drivers. So could it be that this "need fb
> notifier" requirement is a leftover from rather old kernel versions and
> not actually needed anymore?
>
> I think we should nail the actual requirements here first before jumping
> to solutions ...

Right, let's wait for Florian to reply. From what he said earlier
though, the only reason that the notifiers are getting in the
way is the link error you get from trying to load a separately
built fb.ko module on a kernel that was built with FB=n / FB_CORE=n,
so I don't think he even cares about notifiers, only about
allowing the recovery application to mmap() the framebuffer.

     Arnd

