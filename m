Return-Path: <linux-kernel+bounces-296211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625495A7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3903B1C21D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5498517BB2B;
	Wed, 21 Aug 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRfxaHHb"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D316DED2;
	Wed, 21 Aug 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278613; cv=none; b=L9t8nIp3jF2qFiyL36pkKM9Pt55MgJMfJrzRqKhiqtGhjDQA3RsMznasU6W1Bekj4tge7skA8ldSyTtrWB2KeaxhSULHrdl/rLFTZrBGyOFxB+mDNK8csyqsmPmThDKhn+mZQ3NXbl1CuB43gTjEpUPR0NpdchcBfaLQurAUt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278613; c=relaxed/simple;
	bh=KGn/Lap3NquCQGHYpATicRGUctT61k7ang/T9HKvS9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRTvsYb4QMP2n6adBrcWpNA8binTpttCRYIsz8JG1wVR8fPdnXicBpCltX2RIajXUSSjxj31QA48uFmsjDhY/tp8L4ahdE0ETDUNH5tKNzHr6BpAgAG+RtTGr2dg57cmGNtDDDlPcuV7bdqbiVPJ/xNN2hq8Vkiw+RHHRs1wmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRfxaHHb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3badec49eso19513a91.1;
        Wed, 21 Aug 2024 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724278612; x=1724883412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGn/Lap3NquCQGHYpATicRGUctT61k7ang/T9HKvS9w=;
        b=SRfxaHHbw0XclUaK2rgEgCTj2a36H8d90mq/bHDrP9DgzLAPcM1zQjTw/nNQg0YTqV
         9BdozcRFFU/GBdXPUvQKKlLYOpkOMRvRtI8/zAUkR8mfhJemJ/S5Zp8L/oMSZinXJFmx
         g73XnDJDFFha3JSl6ob8JHSK0oM0azEMv/Wz/fJPHz4/pH71T4D74o6vQDMamuyLuCQT
         IKj03REntcPJIFdjM0ARFZ48Sd74rdceFIFlh5LI5cLleBreSASgKTU/eutDIiALj8Ez
         enKe56wu6ocVs5lBawok0puC5WXYw5PDOJn2NIACXyclGdER/kgbiHu6HJIaepoVnwfu
         PBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278612; x=1724883412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGn/Lap3NquCQGHYpATicRGUctT61k7ang/T9HKvS9w=;
        b=ZBuNnAIkhlUoF0gyy9HMOREh9aRVwaGOBQNU0fEmPfbDayC06komRDEXmqolZGxtjS
         5v5KWpvkwtd4p8BQtMiz2G+yhhvRSTW4GBhht0jczLFqKmyHW4CnP3a8UKBklhe2nt9Y
         V5DEFKiS2aDnFfaoZyolmC0RXzHXWkX4HbRixrz0SnBccXwg3cHaregjOg+lVb/MFWYe
         k5Twg8RFfZRRhQpGF82sWPGfz1fzVr8iN9AtYU0ThGAWyeebLc0Qf5+67Uxs7wupRrd0
         76R9Mdn0+zZhje8DU76mO4tKstIo8eL71G5SpAGjbl2zgK2rgEABEfbsXPS25dGORUwz
         NE6g==
X-Forwarded-Encrypted: i=1; AJvYcCV8E+V3mN6N1LXac2Eg52ay5kC6+mqh2srzvoGTrBHgAZehtbHavEbOISpvc5KpAwZzm8vHTjN9KfDphjg=@vger.kernel.org, AJvYcCVDy+IxsB6RjEozIKMRJrOGmMbKz1eOBD41hlMYtc2yp3Noe1tiRULgzQDVR++YESSlj50Ggb6VILCpUWztq0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQKSyMvXb6Re327x9uY3UuT/MMBmRJ7WF89cEIEOnWdjMQJHM
	aLhcTS8KKyeElFcPm0sPI3CbP/t0i38XEOy2pRq5XsU8gEZ+kl4CHLjX8qoxUPge7Mm73MO/qu4
	e1tBc17A4c1P4IgqxQQTzDJD6BqU=
X-Google-Smtp-Source: AGHT+IE2lb0AB+9KUA1H6OgmCsm0tTNOd2x0di5wefL2xeTjUdO7tTGDtqlOVZpkLQzMtvLEPmXIv0JKr38o+6MP45A=
X-Received: by 2002:a17:90a:9c18:b0:2c9:6920:d2b2 with SMTP id
 98e67ed59e1d1-2d5e99dea60mr2464396a91.1.1724278611636; Wed, 21 Aug 2024
 15:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819112415.99810-1-benno.lossin@proton.me>
In-Reply-To: <20240819112415.99810-1-benno.lossin@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Aug 2024 00:16:39 +0200
Message-ID: <CANiq72nXC-Ck+7ikmYgELA+wnPpTrC=zZvOtd52yuTvhVz7fng@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: kernel: add `drop_contents` to `BoxExt`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:24=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e=
134390ce@google.com/ [1]

Applied series to `rust-next` -- thanks everyone!

Cheers,
Miguel

