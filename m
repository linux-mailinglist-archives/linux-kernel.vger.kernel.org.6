Return-Path: <linux-kernel+bounces-520834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F8A3AFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED26A3AD6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA9719F47E;
	Wed, 19 Feb 2025 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipTFm6cj"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599485C5E;
	Wed, 19 Feb 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934306; cv=none; b=fghzTU15o/vybaNrvU12ytRap129JUu/8xT5mwdM9kb/TaDhTArbXCHHnYPDqDnawFBR+pT5Ss1R55MXumv3JpSUT33E1uj7IKlwk14NtjGGkFyuVG6f43mmTR27xqwOGptWnkFqfzw8sgVhliSXKdrZPvMAqZBe/yOoEA2cjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934306; c=relaxed/simple;
	bh=e8A+H2y7XktQhmsGL/DgdGADtxCo9djA5AXEHoodIj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGoDcmx+CVTn/J80XHpz71dStyUVIHA6WS+jCU4eKlWYFtXPyfsS38aCoMWo5nkKPM+GzLha+KL73WjpbI9rKRlPzYiwhfXOSsA4fmgNOleNE4djElMu2fsMP838WPy6rcvhtGjYGmQKXfdZQda3gtGP4t9ZJ3kgI04q8PDp5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipTFm6cj; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd15d03eacso4365616d6.0;
        Tue, 18 Feb 2025 19:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739934303; x=1740539103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BYvLma230HuNlMIuMla/WdfRB1EHLePrdfB/AY0iYo=;
        b=ipTFm6cjNy5FvbQOeE1Psw7tZGHKLs9XGkOWZPd0d8RITSrWcXTVER4uYMHRigiKJ7
         4dB96xIhFPBm6VUtKECj/l5H+9y/glT3SiGhiZNYDIj01UvI3XtaxlISvodainJ4fmcX
         7o4bWzA9hHjXs8bdQCWrbCzK21ypF80NloHmqXabc+BkUySrvclX5s5ET7hKAV5Fx6U1
         CpaFoclX/psv9c8Q0KPs2J0yKMcweScHiat18LDzvMFLePdajO2eEfODJgzVYSnI2WkF
         +r4Tu2ITZRHpnB4EZ4udaFFL5ujnpcK35mXMXCkjkVB6BKkvn92w7cN6UpRekXHA/SM8
         NI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739934303; x=1740539103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BYvLma230HuNlMIuMla/WdfRB1EHLePrdfB/AY0iYo=;
        b=jr+bgUQp8028/bY5QZRJ4YOgfE0Mz6iSiWlKBhv0muxmVDPXjVE525lPQeZkiFD3T5
         2NMfVTgL1fdf2CTmXRU0BrGNi/XYvaWb1PRtqHaRG5M+6HWuiXK24ACwMo0nWfW6mXpu
         RznNBAapK3TY8gOkuO3h9fwfxWqG2jpvD1dicX6D7jiQVoiSot7ZzhEHTdNrj+bzsRq3
         cARlZMvTmDzBcz+qwWvb17I2HjyjOknwdFbed95N/y8LY8dQzAbQW5mWwL6dISAjlLy9
         qFpb1MUB4GVmJ5VBcmaRpdH7AFJ4tEy484oeXR0eeMrojjWbrnDUz3/lczf5PLvcA2q2
         EpVw==
X-Forwarded-Encrypted: i=1; AJvYcCUL2nXRM8vGlPYami4HG911b7jtfx3GXcjlPt+YG8pE9dd7gFhKPRzxXrVuju2Tn5SGtaVnt5dk0XrMDjQ=@vger.kernel.org, AJvYcCX5vPdcm6w8mq1RIufou31pFXrzrhPCD1nAZX6m0HUofHDS1X8GZbnxY5Q/LByaOR/oOuDIhqZsQ0kOKTFVmn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwausbT0ORfovqKZyLRYcTz/BsT0LFU8MiJX3WvdvsiEvhnL6SX
	l4ACBfPnP4X4jXxF15IIjflVRJimfT03ZJPXwVby5C6mI552Eyky
X-Gm-Gg: ASbGnctdQ8pQ6XMxh8r3it5rNHubXTx3+7+LAtf9PFAyQn7CoX+J31DEAdCTIYuppCE
	V5JsEuuW5LAKFzWRtjFNoeAASNGOZgPc5sCrz5mRtNYWDGChJGMml2Zire9QXCuEWCorua/GISd
	8pp1PiYjuDs/LA3LdYTHSDooUDeLbOyIpUgixHgWPifI/1WNPi75V+4LvEaMncIG93qWl/3Xk/g
	BEm9BW1d2q3UgtXOeTuxwhn+IGySrD4UY9Oot6IwtzziS+UYGBGGo9X++IngPB+xa64ULxnaaPk
	kWzkKPBLWMMlVspvgPtuze2BROPe6EfjU7Gz1yFVR0jkyFNEXW78O6iiS5MhSgy52S6kvM3Tr1G
	2EBizBg==
X-Google-Smtp-Source: AGHT+IEpwLJUfuLuhmgXxM1P44u6J5PghjbG8Z0zrez13XdfxdvL+e3xMCDuDpHACWHGgbPI08KK1Q==
X-Received: by 2002:a05:6214:29e8:b0:6d8:b81c:ecc1 with SMTP id 6a1803df08f44-6e6970a062cmr27704776d6.13.1739934303405;
        Tue, 18 Feb 2025 19:05:03 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dce9b56sm70371876d6.112.2025.02.18.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 19:05:02 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3C2C51200043;
	Tue, 18 Feb 2025 22:05:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 18 Feb 2025 22:05:01 -0500
X-ME-Sender: <xms:XUq1Z6tK4ps1TBNrszKb6OYR1jJLYLxzgSMg55hZskBqMSHduihTXA>
    <xme:XUq1Z_eICRaGMKv6le5sJyERTAtqHH06lmmIe-phZJEWC63BUQKPKGOvUJaDrXa0C
    JG19SnpSiRObxTOfA>
X-ME-Received: <xmr:XUq1Z1yTMWAOfIEpRgiqLyIO0yu1B8S_AfivWLecuJGPXDMMui9a7FHq-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtph
    htthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    oheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkshhumhhmihht
    sehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:XUq1Z1PSM2WIqYp5_V8nHtKpf6OiFsq3fOe0Ir7UYPRbDsJwEGUYUg>
    <xmx:XUq1Z6_jzsChztG1BEB1qD9bxXDBs-vdaoNy1LxF_YS0s42KcsTEKA>
    <xmx:XUq1Z9XH4CAn_ISf4VA8-ar0avdJz9VAgjkbpFpQleOcoBmxbFL0gA>
    <xmx:XUq1ZzcFOFTTDIEClzgQ3_1kFg6eRaIbP3UT9fZIp5zaNTWcMx9h3g>
    <xmx:XUq1Z0dv7rkKMWgmOzawS2Pmzl5a9C6eMw8vrSwlb2TlMe7E2k19acGz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 22:05:00 -0500 (EST)
Date: Tue, 18 Feb 2025 19:04:59 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7VKW3eul-kGaIT2@Mac.home>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>

On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
[...]
> > > David Howells did a patch set in 2018 (I believe) to clean up the C code in the kernel so it could be compiled with either C or C++; the patchset wasn't particularly big and mostly mechanical in nature, something that would be impossible with Rust. Even without moving away from the common subset of C and C++ we would immediately gain things like type safe linkage.
> > 
> > That is great, but that does not give you memory safety and everyone
> > would still need to learn C++.
> 
> The point is that C++ is a superset of C, and we would use a subset of C++
> that is more "C+"-style. That is, most changes would occur in header files,
> especially early on. Since the kernel uses a *lot* of inlines and macros,
> the improvements would still affect most of the *existing* kernel code,
> something you simply can't do with Rust.
> 

I don't think that's the point of introducing a new language, the
problem we are trying to resolve is when writing a driver or some kernel
component, due to the complexity, memory safety issues (and other
issues) are likely to happen. So using a language providing type safety
can help that. Replacing inlines and macros with neat template tricks is
not the point, at least from what I can tell, inlines and macros are not
the main source of bugs (or are they any source of bugs in production?).
Maybe you have an example?

Regards,
Boqun

[...]

