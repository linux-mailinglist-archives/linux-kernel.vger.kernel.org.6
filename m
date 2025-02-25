Return-Path: <linux-kernel+bounces-531048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CABA43BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25234188802F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59562676EA;
	Tue, 25 Feb 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BYmSE/vw"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D92676EB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478933; cv=none; b=hsZIcUreJLds8/GW/yzPJm2CC8gdhdeq7wEfImWzO/kv/qFZtKAdWRAY+kYP4Cs/ho9+IoOBxb/G2rDyBpeq3yF0sF91lv4bL7pIezq5YqyMLxaVHx4FQqssg4uq8GMlYZs1uKCBfr7ZBbeVkqbt9F8q60hNKueF6fgX+5d6COI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478933; c=relaxed/simple;
	bh=7jS32IN9BvBO2WdCNC43qfDUQ12l0omi15BL6gdKjSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Imjencbke05uTQM0GZZerl1DOpBaTPEUBf+oY5mzyFrAr1XIKVC2Lv9ylhKpWPY8RdY11XRSLZGb2iwTAcBxJj+v0NiX+icpf0mL/SPRjlujC8aJW5t8r7CESpBDhZZqjBNQvggQLOK9Zpq2Do74KUrW5QLaCe8JNesVir6hDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BYmSE/vw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so8624975a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740478929; x=1741083729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tirQLw4kKN2n7nJcTTMNgrKBrHBCr4gOSdhS88B+7TQ=;
        b=BYmSE/vwCQqhOVHnXgdu2OnPBHYSAN0tc0MAV0xqBuUsGDzq8lNT0fCAr2oLfrk1df
         ssJ+NPzNKFdg3DOfwx6mbmYp/hDrT4yxQC/2f1NXN+sR1jUL1Ri6eB9tvLpZUPIG9EtN
         TD8MVQSZG3KrJw0FEiwcJYw7pQgyJOFWhoYmGJtbdJw1kuwuJ5R50lwDirRMd34u/St+
         lqbx2/K6XAaXn/+RsqQOYnirwuAhmae+df/oXjmdXBkQlDxrT9NBreqjZdKZFg58cyBS
         UdHYpYL+56yqXoraJv+i7epmRGp7AxfcexqKsSjtA5TRszKp2kfoC3McVOjyS4cK6RyF
         OSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478929; x=1741083729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tirQLw4kKN2n7nJcTTMNgrKBrHBCr4gOSdhS88B+7TQ=;
        b=QUkpKOQgxrAB5MkvMEpFOO+GDST0cwiWdk5lE9Y8mcAmE1HEn4Z9hW4yvVy9o4sk0K
         G4HEfJZAjV87WIcu6ferK3QDqibC/4ne2JnDebxoUSWr7Zh4sfUX23oEelkWThkhkXPw
         6gU42C0IIxD3LsRT8Wr0LOpHpVYz7e2J9iB8Gli1IHyFBaSDGjPigdD1LC2yWm7P0hFO
         Cd9PhSmik24mMplX232Ii+N45eCI9JJwHhYlsC7u4BIYojshkvx5yXQwZAzgnUYYZ2sb
         TEOMbhnmO4tZSaQy+KgQf+RclHj9RzZAAWoLapmhMGPg3n+8fIOKbNbSdNV4lg1u8CMV
         aqmw==
X-Forwarded-Encrypted: i=1; AJvYcCXmglbXTmIpQwMKWFl3cRNxJNXOG/swv19cFTEKs9aFLhmhjC07CBkXm27XFeHZixFWJL71l+fYBRXZOtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Sf7gyrtbri0n0dauO1jAGf4YsAtQoXOF11pC2ZMZgb0kERA/
	6ul7JH4kctX/Ul8nSNghgnICgi7HMSLUt1gV4vL2srZgdEFyv27wjTfL94eSZmM=
X-Gm-Gg: ASbGncsEyOcbSKLB53KXf7pULEDQNxJmbtU+jeknkJGQhoCQNqbuMthMnq9e6OVcM3/
	g0yUV2z07RTQgqq0TTEw3OdBL0/EwZG/CABVZNI9nE3tL1YP5YsPLaQyo0KDpXLbaNNrsQIy0w8
	ZqMZvyWsAff0jFCf0SXI8aAba8rfN5TujKHNGPDFRjBKoe/bs29bwZElCZsp1gYKsvK7QB+w36K
	Pvco8wy3+8ycx1rK3+yoPXFLAPUcWkDsnwDrwU3Z+nmcMhDor5T/Refl5vpfRW0OVUMh405SibO
	I429j8UfCD1hzQDYPiv5tuyhuQpkCg==
X-Google-Smtp-Source: AGHT+IGt6pTVXx3wx/wRIHWsfSGAMt1cqb6es2jvkO8FnqdPuOZ02O/dkb0pjA9QIhd5xREqhWrTXg==
X-Received: by 2002:a05:6402:e87:b0:5e0:82a0:50d7 with SMTP id 4fb4d7f45d1cf-5e0b70db116mr11539027a12.8.1740478929084;
        Tue, 25 Feb 2025 02:22:09 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45a8b8c06sm1001139a12.22.2025.02.25.02.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:22:08 -0800 (PST)
Message-ID: <0d9e596a-5316-4e00-862b-fd77552ae4b5@suse.com>
Date: Tue, 25 Feb 2025 11:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] rust: extend `module!` macro with integer
 parameter support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adam Bratschi-Kaye <ark.email@gmail.com>,
 linux-kbuild@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Greg KH
 <gregkh@linuxfoundation.org>, linux-modules@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
References: <JKqjFnoTeEbURcTQ5PpmUZWDS2VMEt0eZl68dWkgk3e8ROFpb2eTWH2mStKkkXJw__Ql5DdYvIR9I7qYks-lag==@protonmail.internalid>
 <20250218-module-params-v3-v7-0-5e1afabcac1b@kernel.org>
 <87ldtv1t1c.fsf@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <87ldtv1t1c.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 12:27, Andreas Hindborg wrote:
> Hi Petr,
> 
> "Andreas Hindborg" <a.hindborg@kernel.org> writes:
> 
>> This series extends the `module!` macro with support module parameters. It
>> also adds some string to integer parsing functions and updates `BStr` with
>> a method to strip a string prefix.
>>
>> This series stated out as code by Adam Bratschi-Kaye lifted from the original
>> `rust` branch [1].
>>
>> After a bit of discussion on v3 about whether or not module parameters
>> is a good idea, it seems that module parameters in Rust has a place
>> in the kernel for now. This series is a dependency for `rnull`, the Rust
>> null block driver [2].
> 
> 
> Luis told me you are the one wearing the modules hat for the moment. How
> do you want to handle merging of patch 6 and subsequent maintenance of
> the code?

I'd say the easiest is for the entire series to go through the Rust
tree. I'd also propose that any updates go primarily through that tree
as well.

> 
> I think we discussed you guys taking this under the current module
> maintainer entry? If that is correct, will you add the new files to your
> entry yourself, or should I include an update to MAINTAINERS in the next
> version of this series?

Makes sense, I think it is useful for all changes to this code to be
looked at by both Rust and modules people. To that effect, we could add
the following under the MODULES SUPPORT entry:
F:	rust/kernel/module_param.rs
F:	rust/macros/module.rs

My slight worry is that this might suggest the entirety of maintenance
is on the modules folks. Fortunately, adding the above and running
get_maintainer.pl on rust/kernel/module_param.rs gives me a list of
people for both Rust and modules, so this could be ok?

-- 
Thanks,
Petr

