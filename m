Return-Path: <linux-kernel+bounces-538901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB3A49EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F8A189AB46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B626FD90;
	Fri, 28 Feb 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhOxPDwR"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF826E637;
	Fri, 28 Feb 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759701; cv=none; b=ryLPI+DrlCIyNsjSkmlK/+xSaSFeK1gJRKJRGIwdJnth3Rkw+zRA0sPhbgF51AWMCQUoh354x4janDErqnkQ424/9ElukDAdNGkOBu4IN6WZS4si/oRhh3uCxUolElg0JEC6j6EAepksCbYRSUhKuwla904ZllJ8C3i7Ao8JT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759701; c=relaxed/simple;
	bh=whEU6+qCSUcv67swUXPHIYHZo4U4OTSuWGIrr5XP1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXehlduFTVM8BFxC6M7+1B+IlevFLtwtK592KUo5w4e9kqMyaLjl8FxFBa0AiQc/2F8MYWaADihOaYg2gjCCLLbyZ1AgAwZcTvpb7aQwgZ6q9r48AqBn9O/fKpI4ZhEKbBFbJ6Ro4GF9kO1UmhXMLO0aBOwkLrpkMj2zRX8gbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhOxPDwR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0bb7328fbso263448585a.2;
        Fri, 28 Feb 2025 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759698; x=1741364498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQl32CI0pAq/WBlG7lV6J6gN/Hz0VRJrHHZws5/ugF0=;
        b=XhOxPDwR14HKmR/49ercbEg9rdQQlOenuN0vKLomdS94rjobEc4WXLlaEqICrPEp4m
         NLO0JhUWVr40V9peludDSLmSuFGE6RzoXNxtG7C/C7uh1zm/GAd72FlY38Rm+qGMiJMX
         HTODu4VInYwyFG3FNsa/F++qNvtb8bmb0pz6nsPakgc7qECkXuO0sm7h/g3zFvDoCTqm
         8GlKykf4OXsnOJ3jG8fM+o5DXCK0gU9eWZNWpwW2h9FGcy2Jd1NjHGdVq2HB7ywiCNFs
         rf9etXSRa50bSFotqVy9GfKkH7ZfbF6fbbPPKzxpwm0l0Ai6rVE0zSd8Ry3XyLjEIfdg
         goxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759698; x=1741364498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQl32CI0pAq/WBlG7lV6J6gN/Hz0VRJrHHZws5/ugF0=;
        b=FW+75zSW9NwNlzqcWA/aBdiZ2jm1SGNMnbxNWWad/tD6WTZwa5+nhq3EInA3VJw0QZ
         ksmtcUIyI/tCawvK+LdvmplLxmFuSY40bAlva2oqlE1wxIDdwya4OVc3nlOTl6RxYTfz
         f39dnSXZEV4gN1gzjG5oQX9XmLOPeDUrPBnzEccNrS7X8zLL316eYMqReZsNC5m2TyQU
         97Yd5Z0JLThIByXBREzLSVbIvzhadNiQn2khf6ADaauB0MVUN1Bcrrauy1aNbaFW7g6d
         Fe44ukUJvIo80SbLr8W/52+diZ8HmhvpP5jPrQ8iXkaOHTMqi4Slpv6yC5rCwqKt1759
         L+bg==
X-Forwarded-Encrypted: i=1; AJvYcCVJz0A55hMpmOPtOWDcBY9ZTL+AO30I4sAoKCKwx+CI/mxMBitXajViAJsHX93+93dQ2suXXnYWzipQMew=@vger.kernel.org, AJvYcCXR77Q9R3zdsTAyxnYo0vkdXFuPYKX7bT+Q1hVMQOBu7Zebbq7722vHfBCyuRwzQOQjOpsw9DH4PHIG/tWBb4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXsq55ADzenfV8Zpi8J2AOa8G02pUccsbq2oUbAKSkW3SOWoI
	C4FyxuuT2eGto71lfoWVPtkjD090ao+Vg4TPhCXeEuTH9AXTuZTZ
X-Gm-Gg: ASbGncs+vcDz0Zq6RoLmleaSc7LoF5EdLTjHvJygvfji3rHP86JAHlbX5R19vzqeRaY
	T0rOSS/P5LTcle3h29HX5hJNWKAMbNjd9YQy23x8oy4t9Lu4//MxWcgO8a+slbslb+H5WrRUMNw
	vAmASH7qT2HOYajlaPNXtvDjrX2l/ePD8a5YSDlwZ82zYKqyiZjyUI99VXtxxWIEJCDs12iaNNM
	7USyvDsRFsZd+VUtnLVILQXcZpmIiYrqDQ30iO9IN10LIy/82c1rP8Cd7EHIabfrWdhlpD4U4XU
	w6PkNdjy5G/xd/LzPLhUV4SEoK1NZ1geB4jyjL8FA6CrZNjF/d9D7gfq0f8wn897bMVj82fxwH6
	eO485tpqH+zhAN2KA
X-Google-Smtp-Source: AGHT+IG8ylAyvJ563yD2ApVoFFKkI38hsRNw0uPv0/auZJxRF/Br2XdjCl2RKp5RbA71Fc546JHKuw==
X-Received: by 2002:a05:620a:3712:b0:7c0:aea3:9b48 with SMTP id af79cd13be357-7c39c4bea54mr587837185a.21.1740759698366;
        Fri, 28 Feb 2025 08:21:38 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef6b25sm265332385a.44.2025.02.28.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:21:37 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 87C581200043;
	Fri, 28 Feb 2025 11:21:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 11:21:37 -0500
X-ME-Sender: <xms:keLBZ8kZqd0ueQxtjJayuiqMD1XZene_mX_T-kXu_w_6Do5WFkUN7Q>
    <xme:keLBZ72sbKnzxLDE2_6azybIWt3RBhnS01kLZ82D2gvkJ8KlLTn1mYoFZI9nd-4cE
    cRcf96UH3V3mn4ndw>
X-ME-Received: <xmr:keLBZ6qyE-KV5CoR9sWmr7--8Pv0JIHfK63mSfgsKtYhQinmXAaqHgzwIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepieehuddvueeutddtteeiudekhffgtdejkefh
    jefgveefgffhgfevleejteehgfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprg
    hrtgdrrhhspdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhivhgvrhdrmhgrnhhgohhluges
    phhmrdhmvgdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmh
    grihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdr
    mhgvpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:keLBZ4k6g1oNteuIVnMk3CzjnSnDEJjH9t1ZgJJ4TD9hVmCZulE6fQ>
    <xmx:keLBZ63GBnEqwMBA3IgN87zE7zbVwSzmPw_ZMMuaOFOzAVRKckfESg>
    <xmx:keLBZ_uhxOQs5Lf7dI__Q4IKRveGwavC-yBaEuZ9mrzKZq492hkOtg>
    <xmx:keLBZ2ULQoFPjEtz7y3lswP45BhtUucr5gwyUNVk2cu4ss2VTG5l-Q>
    <xmx:keLBZ91kKH9AtEAXzl__M3E7fGLDkqtAOlnn396ibYrokVGu7ZzYnGoS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 11:21:36 -0500 (EST)
Date: Fri, 28 Feb 2025 08:21:36 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8HikJloVjoZXBbc@Mac.home>
References: <kQ8hbiYXcV2MseWnElEexwgQswt23842ggoLF2xsd1hDd-4K106zO_gGho5K6KI147luazt2rZNOY3NOJP4JOw==@protonmail.internalid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kQ8hbiYXcV2MseWnElEexwgQswt23842ggoLF2xsd1hDd-4K106zO_gGho5K6KI147luazt2rZNOY3NOJP4JOw==@protonmail.internalid>

On Fri, Feb 28, 2025 at 04:06:01PM +0000, Oliver Mangold wrote:
> > 
> > Hmm... Something went wrong here -- this patch looks broken, e.g. the
> > SoB is at the end, the title does not say v2, these replies seem to be
> > part of the patch, etc.
> >
> Hi,
> 
> should I post it again with a fix, then?
> 
> > (Also, by the way, in case it helps, the message got marked as spam in
> > my side for some reason).
> > 
> 
> Cannot comment on that. The mysteries of a spam filter :)
> 
> On 250228 0754, Boqun Feng wrote:
> > 
> > One meta comment: could you add examples for the usage of UniqueRef?
> > Ideally, we should have example code for all the new APIs, so that we at
> > least have some test payload on them (doctest will be generated as kunit
> > test).
> 
> For now I can point you to the implementation for block::mq::Request which
> Andreas did on top of this. So there will shortly at least one actual user
> of the API (which uses all the features, as I believe).
> 

I meant the "# Examples" section in the function documentation, you can
see UniqueArc for example:

	https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/sync/arc.rs#n592

(in case I wasn't clear)

> https://github.com/metaspace/linux/commit/797b90ae0f83b45495364d4c31651bca06471ef0
> 
> But if you still need a separate test, I can do one during the next couple

Yes, we do because we are trying to maintain an API here, and we need at
least some unit tests to verify the correctness of an API. Thanks!

Regards,
Boqun

> of days.
> 
> Best,
> 
> Oliver
> 

