Return-Path: <linux-kernel+bounces-404334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C31039C428F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98999B2836F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE01A0B13;
	Mon, 11 Nov 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4u3Dzsp"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781314AD3F;
	Mon, 11 Nov 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342158; cv=none; b=bEBsMSE0JD1d+bJtJcF8y/FKx6eNvTHKnPzSHTmr8kuhWX4kf4jrpHeb/c9GAnnyuLw1dSNGOEcq0pKOMmpmbnAtfod5RcGIIrBuGN5IgbSeZoo/yWbr1NLoKdiCPrB7Py74DhvarObswHUcJbW121Qhj2b68rsYcDcMPq/A3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342158; c=relaxed/simple;
	bh=xTNhME1VdFsNUJWfXk4ApwmuFATHXp8LJHT4mlO0noo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACY7fQvYOwVe6VbKoBkjL6vKuW66iv130XAZYQjA2tiSFNHG6bujBs7tF/q0P6AFvbkmdPKuymN2cv14KN98ECIr1PLXYZA36PWNv6qCvem2L4W4e4j9FT3AOpZfmycL1fYgcxnjJ7cq8qIcL2zNv+11tKtLDquLiIxQ1HrHvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4u3Dzsp; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5111747cso40124451fa.2;
        Mon, 11 Nov 2024 08:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731342155; x=1731946955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xTNhME1VdFsNUJWfXk4ApwmuFATHXp8LJHT4mlO0noo=;
        b=V4u3DzspELuf0lGTtvO/jwvEy2LIlIfQkCJEnS5nAqjXjMlcljMiCqq5Mc28IZqJGc
         gHFOwR9m4wvM51ztTGAY61ronGzPnHfNFfaoLkvE2AGJy2j1fyGYMv9KWgnGGycNZKl4
         rFeCRpVmDW966giUKT1308Ql3bHG9K1ozpwXuquXIpmh0PEmFgIgzm1R5lVR8jfmRK/4
         AdC9Ey5ggk/GwOAK+DF1EshcpOK2SGoeCrgsK14MidBfssEJC0nhWwk7iXKaIVlVnB7m
         UtWoPpYFpNs8mUbmfoOST6rM2QCDWXdy7saaFo4iGl+8inYiI37h2pLjioap7vO3/66X
         YyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342155; x=1731946955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTNhME1VdFsNUJWfXk4ApwmuFATHXp8LJHT4mlO0noo=;
        b=tSA7G9KVYdTFFq9X/7rENAYulwBoT5DFy+Tpr/IWvfvWVmeydOTK1Blkp6epdUwo1z
         CLwARfVFZPSb5jDDBnAnQvbkDKzFu8jjloaiCSvN7E5m49tWdt82kAq7/fjfOwrUYDB0
         /D+jSF2MqKNSs3jORwHb8pdNpyrc1JdIDNafGA9p627hDmsYUlB0inm5ilewUCrYoliL
         xxB/6bqpj+O1Xaj01pXggRLrlDYMkItExorASoDNrf4nmliTAo+izj86nBKlVcW1TmPv
         qWOt8rIny2r7BCy35UIqJhBApk5z+uwMxZgBPMtJucCyTTl6B4X++hRxWuw+i5dY8oY/
         jVag==
X-Forwarded-Encrypted: i=1; AJvYcCWSjTwqjKffNXsllvlcgeuswsZ38f/DOi+xt1sk9IsbOCDVrXFANC6POWloPMlOLLmUNLAgV3ZSK2bYpTfaPSM=@vger.kernel.org, AJvYcCX4fXLo2T27wky18t7HnJK87yioTG6kyUGXZkji6ISx0DuKFuOJIjBmDSMmPYGc50DJ5FHhrc8n0PAY81g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+zdDfc/wSQkrUfyXNTvfFDm6bylvUN4Odn+VI7CM4K9Rae5BS
	SQuKnTMfBwKksJe/X7HHl/hBuEqm+RH1EDHWqvTTdaEQCLURXJeBp6mRWJZzpFuBDGfgumRjxA/
	wOatS5Kb1KTWtUlO5HXJH6O/c008=
X-Google-Smtp-Source: AGHT+IEzoBHnroavSqPI+DyXBy2o7Y8WhVjAAjjvbVHDpyFmTEohP3B2n4rcjwe0ybUCz9Ezm7pjvAfpZJxbjroObh8=
X-Received: by 2002:a2e:a994:0:b0:2f6:649e:bf5c with SMTP id
 38308e7fff4ca-2ff2024a683mr53160041fa.17.1731342155064; Mon, 11 Nov 2024
 08:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
 <20241110-borrow-mut-v4-6-053976068215@gmail.com> <CAJ-ks9mSu0Wivnsn605ZTFHiYqK4VEhURO-7rj5jFAwSxJsABg@mail.gmail.com>
 <CAH5fLghAJFbCaOF8YPKJaKow3RdPXAqRvkJ7Ua5Mo5LcFo2WbA@mail.gmail.com>
In-Reply-To: <CAH5fLghAJFbCaOF8YPKJaKow3RdPXAqRvkJ7Ua5Mo5LcFo2WbA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 11 Nov 2024 11:21:58 -0500
Message-ID: <CAJ-ks9mnGvcsCZUjyjkYUSNSAv3004rtFcczBA-Wo58w-L+-vA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> You should probably wait for Miguel to decide what to do about
> https://lore.kernel.org/all/20241111175842.550fc29d@canb.auug.org.au/
>
> Alice

Thanks for the pointer!

My reading of that discussion is that the new `crate::ffi` module
isn't going anywhere, it's just the later patches that diverge the
types that might be dropped for now and taken later.

In my case though I have a hard conflict as the patch introducing
`crate::ffi` and this series touch the same lines so I think a rebase
is unavoidable.


Tamir

