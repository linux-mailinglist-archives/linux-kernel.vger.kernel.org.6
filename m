Return-Path: <linux-kernel+bounces-447548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1829F340F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5108C1671A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938014265F;
	Mon, 16 Dec 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EklESSlR"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9513B2A4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361717; cv=none; b=qDCvWB1XFiguY3zTLyYGd3ACAJZzg5MfW/FKpp7QJdfkFsRYuLSHd4UPKqfIqGkC3uxo0QtHbsD+tWcw2QelhlUeKRq+fma+CAQCmS689+0ILhr8zyvHWbngaRzakabOR5KaKQj8fPIt6xnYAHK8VpZdlgCzm1TySyF92KcBlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361717; c=relaxed/simple;
	bh=y/hSn94vqcnNhsYw94s6FXu3f+/P18H8zbeqcBwJtu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLnzYYgMPwZjacvhNgmi2ykcGFOp0VpE3Ck8aI0QucYb5qHoCvyc9LBaC6v62GzGkpjU8LvEynEM55ztfwnPiAMDAf197mwd2Gdu+DAlsTdZgNXyTtt8UZP/KeQFVYsvvwzdx2K5Ax9KY5d4AE0/1Tt1qXs6ODM1vxktmEBHfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EklESSlR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so2386172a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734361715; x=1734966515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHndDb93nJKHf3y12UiyHgWO3egb1uH1jrrMzcjDJHY=;
        b=EklESSlR01l6cX8QdXLCnxqWfgE6fhvTEZfTJfN9X3zWOX2kTBzt2nqOFcFt5Ea0Ua
         Zd3lvEAagFAoDmehSRYCIoZC9EVoPchtQFUDyrQEhM2z7I8u5m9ywksnY/DCZrVSBc/7
         qKlEusR5kv1qoDSr/o8GeuuLj6L4Bxi0qGkzPOs2/RiuTAk2e7VUyeRZ9zDpb5eCHXj6
         6pm8mP2YmQCPEzSkNRAIuo0r2fl5TzMK86C/5Yvwc9Pa7kQJoaT45AFkQQCCekrXGZMI
         MWDgcYJLlV+a70Q3J63P3KcaZPBQpmebuU6X6VfrBrVjGjFeUu5fhWChg8l/ET2CiG5G
         zAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361715; x=1734966515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHndDb93nJKHf3y12UiyHgWO3egb1uH1jrrMzcjDJHY=;
        b=Hgq/KP5YaWy1sHyERMUo6I9h5QHYk2TAqsGfuQ6bTvVar3jYnwqmIeD5tDEQNFQAve
         l/jv9Tr1tWeF3tEyZSKJaLmDty8VabwP2J1aNGBVCtqalXqivvp4/PkpAO3Tmfy9rnSi
         yq3YAQ23OWkZiUSi1+CP+FDgKx/o7OXuovcAYyruqQlMOyXe/E8NTsLeo0BMIDdaKsCG
         04vxm66j+2JpBzCTwTUo/VfBb9/WIV2M+Qd1yPwbH7rnzCfGIsyFzS+dilOQSNER9YKf
         3dE0W5ih7+G7KmUtBDOtKqKu7RDP9MHUH0jiXeyEtACG787hFTy/YiVm3Ofqas8gv+Lx
         PVkg==
X-Forwarded-Encrypted: i=1; AJvYcCUg2mAvCEHVQLCp2HOhGPey5/d5nHg29S5Yc5ZTUvK6qjQN+qBG6+mESEcuYsaP8c0hfmUx0EBlNlrktxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oiCJm9W/+SzZvorrALXLYdAS2IFVBgZ0MtsRaps3f41rCPxC
	Ih5sPYZNYepuzRbeP7ngYNNKwBjiuZYaY0Qu9MwwwkVonTUbify+cU8Bx1V1PU4=
X-Gm-Gg: ASbGncs/AunrduspEaIywU8wt8mFKcztajhzIyY3CVgenfXSLgeTfIcZreqOQTgg//E
	Sh7KZpIMKJOZprqAxIHHeujWg/HPYKlXA9dAzhQAownMxz7/LN5izn4OyYYF4WydD/wdoAptLEa
	JJviCgveTSa5efkqQ5KPSnSVe932RU3cNdY4agZt+RM0NtjH0QES5erlhpmBuXZp3doZfCu8Bub
	j5CgVaKy3xAJBoAUjmHZoHAn1UOaZ96ZzSEYPNiuEQ3eRX0RYd6gg==
X-Google-Smtp-Source: AGHT+IGl28jR0r8TWcntTfBPiwR4SLoZRHONQFu6tyJH1gWCvGyfOrg5K7EgV6Uhd6M9VqjhOxm7SQ==
X-Received: by 2002:a17:90b:3848:b0:2ee:d797:408b with SMTP id 98e67ed59e1d1-2f28fa55c45mr18636200a91.2.1734361714814;
        Mon, 16 Dec 2024 07:08:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc305dsm8237518a91.52.2024.12.16.07.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 07:08:34 -0800 (PST)
Message-ID: <64a40555-e3f8-4671-8ece-3c3b677ccdfb@kernel.dk>
Date: Mon, 16 Dec 2024 08:08:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] rust: extend `module!` macro with integer
 parameter support
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Trevor Gross <tmgross@umich.edu>, Adam Bratschi-Kaye <ark.email@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <I0v8YGJe3e1ex1oF3mki-7QKimYLCJHnBy6g1taHgoOFvpNmQSrSnsMGJyGS064pGJsJDsTsei-pInFRz5INWA==@protonmail.internalid>
 <2024121309-lethargic-ended-5f99@gregkh> <87ttb7d24p.fsf@kernel.org>
 <hmmCwoNftQc5Mj4BLjFC2qTABem8CvuXSx3ucXzjIfQSwLjULmZgsw7vpq3Zxy0kk5H3Zjpz-vd4d7E1sb4LHw==@protonmail.internalid>
 <2024121344-excusably-resurrect-d01a@gregkh> <87h674c5vq.fsf@kernel.org>
 <UW-ATumT4L-13ZXX-lO1inQGeZK7VgQWNAHE3688ulGj-rvzxWkUdrmnAUlufI1W5-9d6vzH3TXZ4VOmYh9wxA==@protonmail.internalid>
 <2024121646-shelve-series-5319@gregkh> <877c7zbx2u.fsf@kernel.org>
 <8e1b5c5e-52ae-4332-a49c-990add7611f6@kernel.dk>
 <2024121630-steed-grating-6352@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024121630-steed-grating-6352@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 8:03 AM, Greg KH wrote:
> On Mon, Dec 16, 2024 at 07:43:12AM -0700, Jens Axboe wrote:
>> On 12/16/24 6:02 AM, Andreas Hindborg wrote:
>>>>> I understand that you would like to phase out module parameters, but I
>>>>> don't think blocking their use from Rust is the right way to go about
>>>>> that task. If you really feel that module parameters have no place in
>>>>> new drivers, I would suggest that to be part of review process for each
>>>>> individual new driver - not at the stage of enabling module parameters
>>>>> for Rust in general.
>>>>
>>>> I'm saying that module parameters do NOT belong in a driver, which is
>>>> what you are wanting to do here.  And as for adding new apis, please
>>>> only do so when you have a real user, I don't see a real user for module
>>>> parameters in rust just yet.  If that changes, I'll reconsider my stance :)
>>>
>>> I guess we disagree about what is "real" and what is not.
>>>
>>> In my view, null_blk is real, it is used by real people to do real work.
>>> They get real annoyed when the interface for their real tools change -
>>> thus making it more difficult to do this experiment.
>>
>> I'd have to agree with that - yes, null_blk doesn't host any real
>> applications, but it is the backbone of a lot of testing that blktests
>> and others do. Hence it's very real in that sense, and the rust version
>> of null_blk should provide and mimic how the C version works for ease of
>> testing.
>>
>> If this was a new driver where no prior art exists in terms of users and
>> API, then I'd certainly agree with Greg. But that's not the case here.
> 
> Ok, so are you going to drop the C version and go with the rust version
> if it shows up?  Surely you don't want duplicate drivers for the same
> thing in the tree, right?

Maybe at some point? The rust version is already there, it's just very
limited compared to the C version so far. The point of the rust null_blk
is to build out the API so that a real driver can get implemented as
well. For now, I think the plan is to just have it be the rust
playground on the block side.

Given that null_blk is the center piece of a lot of testing, it's not
necessarily an issue to have duplicate implementations of the same
driver. In fact it may be pretty useful for people coming from either
side and wanting to compare implementations and how to do various things
in either language. It's like an actually useful skeleton driver in that
sense too.

Whether one or the other will be the only one in the tree in the future
depends on a lot of other things that aren't necessarily driven or
decided by the rust null_blk driver.

-- 
Jens Axboe

