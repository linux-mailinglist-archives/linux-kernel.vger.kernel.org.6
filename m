Return-Path: <linux-kernel+bounces-573380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF3A6D692
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBB93B1400
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3E25D8EA;
	Mon, 24 Mar 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOAIKahB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E477082F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805957; cv=none; b=EWYfaQ/7ijEfu6AR2Iv2Kr7g9FFKfHQhXMJp+j37LDZEkkZbDth+Z5vG8kCcEYnppm7Uu8Dt6bLF1JkKyxT9NjGwNk3cT9Hh4Dwxy683gF5p0sGu2FxeCMoWxqPNdFW9+VgzPslyG+9vlPLAMQSZjfKv9MnIUJmhQ4SMAc1ZFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805957; c=relaxed/simple;
	bh=OzC4/T/DUX/GTvlqXYftTZA4RAOyB/rwDW48NTGa1Ko=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bX5+qfji/xbUbbRv4YJNSbKaUKgTmAkG3t7Sg7J+9liiGOv757zUtekS9o9b50Nok5dDkVldnZeqYOYLw3mZxbQrqXkkw5KpdT3dP1kmYkr8Os8TxqhDbLZE+rs7Xmp9bGfg9euNS8ZJHgF0yNbR8lXDd+vUMAWVMO5CAmNEGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOAIKahB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28409C4AF0B;
	Mon, 24 Mar 2025 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742805956;
	bh=OzC4/T/DUX/GTvlqXYftTZA4RAOyB/rwDW48NTGa1Ko=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UOAIKahBNTW3jWp50XqK0UBRALbDXMbkQPMjRmRw7XVxiy2Z9qCCj3dR8mLgUxTk0
	 i1RQ++OqiWxNa0wvk8h4whkFbPipGfGmRx4Fnfn6W+5u9Ja+JcCWkxtp069NQYiAWm
	 /99jGEUDzl7wnkbnPRvk8D5hMLUhpRTzzYz/2A83D97abS1yd2G9DUcF2QT6goqfHg
	 OL1G0hoAwgWcC7C4LEZFRrrb9QJ2aBwzvcJzPQ+8ZNVpCBRIezyy1bpznXcboaLWQt
	 2W5Mkxg4GPk7n2yKB0ScOBw7cYBQy8rbmzYnhsTcAVKHd4BFoDTUJCVR4DtP5wREPA
	 1TbpISq2+LK8Q==
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 35FB2120007C;
	Mon, 24 Mar 2025 04:45:55 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 04:45:55 -0400
X-ME-Sender: <xms:wxvhZ3EoOPQvOZRDG_7j6rrI99TwaZCB4_c3Rm7uHzDPX0x81xMRNQ>
    <xme:wxvhZ0XaYP4538X6BOkG9QL2xgzPPjaslmHiw8xLRVK59VG1559g5W0fG2xHeqww2
    RhPFryDxfhy4F0gyS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnh
    gvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfef
    feeitdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvg
    hlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepthhorhhvihgtleesmhgrihhlsghogidrohhrghdprhgtphhtth
    hopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtoh
    hrrdgtohhm
X-ME-Proxy: <xmx:wxvhZ5JFU1gZU_lg_ExVvBaP3VWOxOUCdasFtrdS2ehfKnOMHEOPhQ>
    <xmx:wxvhZ1E3cW_DUXQ-SypN0IRjOwM0Z0o2s8uDMsRWYUEM_XdLjcNd8w>
    <xmx:wxvhZ9UX16N3oH2GvbaQOwnE3iGI4sct3xqPao2TE2AhY-e7WmHQlg>
    <xmx:wxvhZwMgQTHPPa9ep648JDjyvPXDEviGHt6TZFkZ3Uc5gpxDX5X0bw>
    <xmx:wxvhZ83k3goTWsEl7orJrRb_RtfdBgg5R2mpQKX7SWsH_bciHFlBg6PE>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02DC02220074; Mon, 24 Mar 2025 04:45:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T54c1b8b1cd0488d2
Date: Mon, 24 Mar 2025 09:45:14 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Tor Vic" <torvic9@mailbox.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Borislav Petkov" <bp@alien8.de>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <106aacc5-e863-4e74-b223-34b7a0be60a0@app.fastmail.com>
In-Reply-To: <b67fad41-3849-446e-8982-1485f42e61eb@mailbox.org>
References: <20250321142859.13889-1-torvic9@mailbox.org>
 <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
 <b67fad41-3849-446e-8982-1485f42e61eb@mailbox.org>
Subject: Re: [PATCH] arch/x86: Add an option to build the kernel with '-march=native'
 on x86-64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Mar 23, 2025, at 16:14, Tor Vic wrote:
> On 3/22/25 12:40, Arnd Bergmann wrote:
>> On Fri, Mar 21, 2025, at 15:28, Tor Vic wrote:
>>
>> Are you able to quickly run the same tests again using
>> just one of the two?
>> 
>> a) -march=x86-64 -mtune=skylake
>> b) -march=skylake -mtune=generic
>> 
>
> I ran the tests on Zen2 (znver2), but this time the kernel was built 
> with clang-20+lto (the skylake tests were with gcc-14).
>
> It turned out that with '-march=native', there is almost no difference 
> compared to '-march=x86-64'.
> All results are within +0.8% and -0.6%, most of which are probably 
> noise. Hackbench, stress-ng fork and xz compression seem to profit the 
> most from 'native'.
>
> The vmlinux image is 0.03% bigger with 'native'.
>
> I guess that 'native' can be somewhat useful on some architectures, but 
> not on all...

It certainly depends on configuration, toolchain and target machine,
so it's very hard to say anything general about -march=native.
znver2 and skylake are quite similar in the supported instructions,
so my guess would be that the clang-20+lto doesn't behave that differently
between march=x86-64 and march=znver2.

Of course if you don't have the same kernel version and configuration
that you are testing, the results between the two machines, the
results would be fairly random as well.

     Arnd

