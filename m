Return-Path: <linux-kernel+bounces-447498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D09F336C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1B41633AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E9C2063C9;
	Mon, 16 Dec 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AZtqCNaA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D17205E25
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360198; cv=none; b=gomRCWEZJ+u79GTEuVu62V/Rrh/8aoQZW2ojKi+d4NhsQ031bP97w8GOgFhZweMN/omqdl7/KPcxvhK/hSKc16NrRidBdMorQtFRhznnTYPbvsdZB3VXPZJ55LdIhJ6Kx/9cg+ehGCpprCU+FvmpuPIShRSf7HxR2xwpQ2kEJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360198; c=relaxed/simple;
	bh=vid6eL2+9lF17Od0L9ytahZMwPP7rZ9zJw0QfkIJvkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WA/zgoK9fYYoIrO0MrIfIxA1LwV0ZLcWlde0aJy7XbG3EE7Zsww9e59Gi6vfru59xThVtqssc0zbyPR8Ne1OoOQW/n+LMZef45WechyZGrT0sAzKXkSyf2kTMSRtdQXuCMh82AhsibqL50jxrYkowHF1j79k+FCFmMf0JzAHpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AZtqCNaA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2167141dfa1so34241965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734360195; x=1734964995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmrCxqpDqjESJ70QFxTBBLdJXAN7riBEqPMzA//neTs=;
        b=AZtqCNaA/Z0SYtsDC+ARqA8ngylWvfVuCm4l/ErosMiGE+oEkeJOp3h6+UlhgQknn7
         b1uDWcXd+oqzCOtyOYWTC0TlOg5rlfPK0cN8ItwErecLdOfr2TrXYAJXXHskyoxnfs3l
         9mUCx/BCYspbEY+GMFcxGEsncWocHWh6hoZ8XJmxMsIs3913LnmEjuhLoRywme2HCQ/J
         e1M1eOuyMdmdoCpqlKO1/tKmD5KK77ObrcntN51Fft1k59SwVjE0gYaX3Z2gnKXDIeSe
         hxkFb8m4Q4VXoOfoTgppoN3KgDjaGnh86lQhWSqMGJ4TdP5aDi6j88SnEqA/FsWAc0cD
         d+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360195; x=1734964995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmrCxqpDqjESJ70QFxTBBLdJXAN7riBEqPMzA//neTs=;
        b=tg5X9LhbVmtuhWfG6elJSWQNcIml2FQYOaZ6zlm5F5tuDvC8IietZyH5c/OdElXGBZ
         pqIRGB+OiqweIjn5gq5EWdsS0LpBrEbBlCzzW3WoFDPatu299ZYSdrBF/TXtLN0s5TzC
         ZNbqXvKYFkpctqQpsc1rgxe8vyU6klHECdRfRH4LwLO9ipXBrtmVceUbpI7f7kUPpwTL
         qxlV7ChWnk7l4J85fUoLHQ9LQ0bewauL8C5jYfJ+l9hJFPO0d84uKUETStoCc72nrLJn
         UzRLdZ+5M3L+TRTvdqJi+J9sBY4p/hetgKHeXZ/S/MYm44MeTli4K43eVaHt4kBcS7pC
         z8RA==
X-Forwarded-Encrypted: i=1; AJvYcCXGDZ0V+SKZOM3AlViQktQYYEIWPyOZDVrsEILlkd0EU8IUC9ysfG3hvYlbwIIAKM0oLg96b++776DzwHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vKo5k3aWgUgA0WtPJzr+3/hIndyP9NAHJh9eaGrIKvlJ768d
	wCKMySBcFeA6cJ+cO58ntew6Kn89v/y5PSNOQoOuxhgtO6SlljOxV1EBvS53kRo=
X-Gm-Gg: ASbGnctdYjEAJoYLb3Ad0Hbzgg9e/48FsXdN5LriQiCNTouSGsvFUShsBBdmBIr2Gem
	q7ut8Zmqo2KlK0ZIhqxrJ8yrbOgdocW64mNPy1UMESLyGjbBqel9Z5feIjUDKtx9lvkG+QdpGke
	5YXLrh1oJMcw1cO3SNtIQsE8XUFumOOScELoo7gLn5cRidz7NvIjZOiLBZdqj2c4y/QVaiJFmrK
	sJFvM9RPIV3eKAXs8N2wzIv4GPHkIvXwIrkIG7Or1zK2YvSJuUlog==
X-Google-Smtp-Source: AGHT+IHnVO9LhhiLRU5ZRt5v3Hbaaa13fz1HBag4AymzRth1YKtvqbofDh9Crx+RLV4GTPXrrpUfPg==
X-Received: by 2002:a17:902:f607:b0:215:98e7:9b1 with SMTP id d9443c01a7336-21893b53528mr185076855ad.5.1734360195579;
        Mon, 16 Dec 2024 06:43:15 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db7976sm43700335ad.53.2024.12.16.06.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 06:43:14 -0800 (PST)
Message-ID: <8e1b5c5e-52ae-4332-a49c-990add7611f6@kernel.dk>
Date: Mon, 16 Dec 2024 07:43:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] rust: extend `module!` macro with integer
 parameter support
To: Andreas Hindborg <a.hindborg@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Trevor Gross <tmgross@umich.edu>, Adam Bratschi-Kaye <ark.email@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20241213-module-params-v3-v3-0-485a015ac2cf@kernel.org>
 <4Dsa69UGULRGsMbRbwOJNp_puyfsSSFt1QTcYU9AL4azd8vbfEFFtc7YNSsGegc40AfCZqVqZETfxg4TggUlSw==@protonmail.internalid>
 <2024121324-overdue-giggly-bdb8@gregkh> <87frmrepo5.fsf@kernel.org>
 <I0v8YGJe3e1ex1oF3mki-7QKimYLCJHnBy6g1taHgoOFvpNmQSrSnsMGJyGS064pGJsJDsTsei-pInFRz5INWA==@protonmail.internalid>
 <2024121309-lethargic-ended-5f99@gregkh> <87ttb7d24p.fsf@kernel.org>
 <hmmCwoNftQc5Mj4BLjFC2qTABem8CvuXSx3ucXzjIfQSwLjULmZgsw7vpq3Zxy0kk5H3Zjpz-vd4d7E1sb4LHw==@protonmail.internalid>
 <2024121344-excusably-resurrect-d01a@gregkh> <87h674c5vq.fsf@kernel.org>
 <UW-ATumT4L-13ZXX-lO1inQGeZK7VgQWNAHE3688ulGj-rvzxWkUdrmnAUlufI1W5-9d6vzH3TXZ4VOmYh9wxA==@protonmail.internalid>
 <2024121646-shelve-series-5319@gregkh> <877c7zbx2u.fsf@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <877c7zbx2u.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 6:02 AM, Andreas Hindborg wrote:
>>> I understand that you would like to phase out module parameters, but I
>>> don't think blocking their use from Rust is the right way to go about
>>> that task. If you really feel that module parameters have no place in
>>> new drivers, I would suggest that to be part of review process for each
>>> individual new driver - not at the stage of enabling module parameters
>>> for Rust in general.
>>
>> I'm saying that module parameters do NOT belong in a driver, which is
>> what you are wanting to do here.  And as for adding new apis, please
>> only do so when you have a real user, I don't see a real user for module
>> parameters in rust just yet.  If that changes, I'll reconsider my stance :)
> 
> I guess we disagree about what is "real" and what is not.
> 
> In my view, null_blk is real, it is used by real people to do real work.
> They get real annoyed when the interface for their real tools change -
> thus making it more difficult to do this experiment.

I'd have to agree with that - yes, null_blk doesn't host any real
applications, but it is the backbone of a lot of testing that blktests
and others do. Hence it's very real in that sense, and the rust version
of null_blk should provide and mimic how the C version works for ease of
testing.

If this was a new driver where no prior art exists in terms of users and
API, then I'd certainly agree with Greg. But that's not the case here.

-- 
Jens Axboe

