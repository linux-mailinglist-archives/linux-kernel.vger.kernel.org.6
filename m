Return-Path: <linux-kernel+bounces-434886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5659E6C5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D782716ED27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575B201114;
	Fri,  6 Dec 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ns8Z/+Ib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eUkNJxI9"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AA201035;
	Fri,  6 Dec 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481082; cv=none; b=t/fKK3LEYsGCO+e+HqPzl17CxfiDqOEVoQc7RN7vQC+gmo0bWFriREAfZZyQ/dLi2JD8uGwNF2YM1BUm1jUqKu6Bs7BVYoAqvVLqP12odT2+gInsb+8AjTLv99hJ0O4KwlYY6YqRWoyyKelAZ2ieS8ruyzwky49o8mmVpU5D/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481082; c=relaxed/simple;
	bh=gWZNdNWRxdyJxIbmFkWqSPMcmAdyUWXwTK9eTjdGkYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j6UQCYTRUB3mrL+IIZ7eWAhJDU6FONnDJqUssnREuAAo1+4Bb49gCS67Yt5h19Fo4ybzcEiTLNSJFqZagxEwZh2M+VRzRziaaVykW7dc7AU9WwW0rPjWFI1MCyo6irn3zF5F6lT2YPhGz77vW4CiPpRITz7RhzALY3lEg0vocvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ns8Z/+Ib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eUkNJxI9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD4F62540134;
	Fri,  6 Dec 2024 05:31:18 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 05:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733481078;
	 x=1733567478; bh=AdLmQGIIUKBirRkpyUI0P99kdi4WSI3dP2Dl0+NVf5s=; b=
	ns8Z/+IbhFHq/R78L834hEXScXlgOA+XC1BMnjt6gI/Ih/kLXJSbZcXvcVgu75fb
	TngHBDHQOok0/x/CXBVU+qZa4nGvA3cPUVxV73lqAocfvxKP2Q/hMpcynyZdBab0
	3miH9FuPsTJpkxAkyA3CDTBzTiiYvVqDyjonyNHFHhMW3QOTwkmDG+zp42/l9KTi
	cf2LckEK7lffuAA6hKB+PVAK4L+wOlR4EM1EkYcgrDnvfHmXImIHSaRFwE6OztNL
	K08W6ewINWJ/JKj0UuD6H18Z7yVHBeQ7mcPQYRog9kOwbX5zuRHCfOziQ1tou5gw
	tdii2Em6dq9bRv/PPhm+ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733481078; x=
	1733567478; bh=AdLmQGIIUKBirRkpyUI0P99kdi4WSI3dP2Dl0+NVf5s=; b=e
	UkNJxI9Xi/YPf1B5zGOAUqVeyKLcpwWLv7Hw4RiM1e9iqbdxhwROfR03D033ljJn
	vr9evcU7+MqNy8DDt+plpxGgDevytYgGJDPV1Ec+X/qlNwPkSdMypr59oKlNE1aM
	Lygbw0AQ6IjZWXGz/LLGm8/0yS2qzawYHL715HJf3KBkkjH8r9JzDFcvnT8evnou
	V+Srhe0/9Yii3bCGJGvHtfArNERPWoag54+WddHPIxPN4HgKRA+EeNpRtY1oK99i
	1oBh0JGB7n5XhwG4+dkgucVk8xsiW+v50WLNiAxm3HAMcDoMl+JmN97nOBbrM552
	A9a6+UPkrJE6v8fkCJotg==
X-ME-Sender: <xms:dtJSZxFlZOzu9JPLtpu7KxZw3EqIIvNrNKX6E8N1SJ1Myg0bQpAn7w>
    <xme:dtJSZ2VqLgsX1nuMnS5XhBAuQ0xyEe-rdiYVEm2x5KBKxtwZgR1V-BBSwaFbCk1id
    EOwjzDSvnvAxV6Ox5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeej
    vdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlh
    hoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:dtJSZzJj1hgbdsMbC6FkRCkHEJvWLQM57CyhC3-ing3nI-MmGXirsg>
    <xmx:dtJSZ3GUYkO8vJTnvH_tdv6PpXfc6jglJvlic3YGWNSdLo6_1Gv3yg>
    <xmx:dtJSZ3V-xlSAUhP-4WkBTrrDSbXUEM3kF6CexcX9dUPICnZNoBbleg>
    <xmx:dtJSZyOS4_hScRTcvZ3v93PzYsqeqGwU11StBxiDLOy_-zBi4JpVJA>
    <xmx:dtJSZwsyKsS00-Qkwy2adpFw9buo8R_35yq8sjFVrU6rcG3F1QtQZIcP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F0A12220072; Fri,  6 Dec 2024 05:31:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 11:29:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Lee Jones" <lee@kernel.org>, linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org
Message-Id: <2073da49-37c6-4add-9450-47842d05cd79@app.fastmail.com>
In-Reply-To: 
 <CAH5fLgjauL-1QbnkVVK34COD_Ch_rcdpUEMKBsC9HB-TKWNscA@mail.gmail.com>
References: <20241206090515.752267-1-lee@kernel.org>
 <20241206090515.752267-5-lee@kernel.org>
 <57c35f7f-76e8-4e21-8288-c66a1b6e7069@app.fastmail.com>
 <CAH5fLgjauL-1QbnkVVK34COD_Ch_rcdpUEMKBsC9HB-TKWNscA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024, at 11:09, Alice Ryhl wrote:
> On Fri, Dec 6, 2024 at 11:05=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Fri, Dec 6, 2024, at 10:05, Lee Jones wrote:
>> > This sample driver demonstrates the following basic operations:
>> >
>> > * Register a Misc Device
>> > * Create /dev/rust-misc-device
>> > * Provide open call-back for the aforementioned character device
>> > * Operate on the character device via a simple ioctl()
>> > * Provide close call-back for the character device
>> >
>> > Signed-off-by: Lee Jones <lee@kernel.org>
>>
>> Could you include a compat_ioctl() callback in the example?
>> I think it would be good to include it as a reminder for
>> authors of actual drivers that every driver implementing
>> ioctl should also implement compat_ioctl. In C drivers, this
>> can usually be done by pointing .compat_ioctl() to the
>> generic compat_ptr_ioctl() function, which assumes that 'arg'
>> is a pointer disguised as an 'unsigned long'.
>
> The current Rust logic for building the fops table will use
> compat_ptr_ioctl() automatically if you specify ioctl() but don't
> specify compat_ioctl(), so this already uses compat_ptr_ioctl(). But
> maybe that's not what we want?

Ok, got it. It's usually the right thing to do, but it's easy
to get wrong if there is at least one ioctl command that actually
needs an integer argument instead of a pointer.

Almost all command definitions are for either no argument or
a pointer argument, and compat_ptr_ioctl() works fine there, by
doing a conversion from a 32-bit pointer to a 64-bit pointer
by zero-extending the upper 33 (on s390) or 32 bits (everywhere
else). Integer values need to either a 32-bit sign-extension
or a 32-bit zero-extension depending on how the argument is
interpreted on 32-bit architectures.

I wonder if we should change the prototype of the ioctl
callback to always pass a __user pointer and just not allow
the few commands that pass an integer in rust drivers, and
worry about it only when it's absolutely needed.

     Arnd

