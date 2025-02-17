Return-Path: <linux-kernel+bounces-515638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F6A36729
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D471678F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8101D89F0;
	Fri, 14 Feb 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/ZCoP5R"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7D1A83ED;
	Fri, 14 Feb 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566746; cv=none; b=URlejnfAD1AvO9X02DJOnjyXuW2rbbtnp/o5ri5jK1PMuHFp+L10k1SeCZbXUISJ2faensOwpNPMpnd1435HoHoai0U7Lg6aGzmG5uq3ezkmr/pZ2Nu1sxKbuOwpog5bC6Ab9tHvR7DbcwSXhQbQR+xcbCF/LL8H9/1Zl8v43+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566746; c=relaxed/simple;
	bh=H2cNc1aX4F0Q4gWS6uIBPMkCD42ZScjGxPQs4UXIEiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk7ijRvAPhbJ90V1gCxTCn5phhb0SDYGgIBA8C+/clI1ZRD+klMuqFeEPjOlIaQnf2IWA5TWUKiztkpAFt/BP+bZ8RE5eQt7zOJY57iBHLWcUa/VXRpYbFezNX5F6KA65gaKvPy6caiKiHuUBL9Q70qloJ7jDACBXHMd9mUGPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/ZCoP5R; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa8c788c74so525399a91.2;
        Fri, 14 Feb 2025 12:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739566744; x=1740171544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2cNc1aX4F0Q4gWS6uIBPMkCD42ZScjGxPQs4UXIEiY=;
        b=M/ZCoP5RHSWdv4IhqSy/1BxjBZPVSuP0RDTAR70Zgv4GtYszNIZuOqRINvnYidtZzn
         m1of+B18uL4qIHHwmDryB/mIW5spwLZxkOuP03gES/ZWs9Yo0ZR7m+UGvd5L22pwlPkX
         ehZffjFAfoQcnGXlDSdkfz9hhjOLlC/AEsoaLsrzoNhKCAaKWa+jlqUFxh6n4ai+dHt7
         FOLvSZ/spPCtGaFr+GFtxsnYkHjWyoT79ifym6xROozgNyUjfvOZWG4g0Y4/2aAKS36t
         vOQuk7KYxplSutFjF6LEoy891Q33T1y/bWiNJj1ByRUFUcHlIXoGpIN4euCGyKXHwazX
         rmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739566744; x=1740171544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2cNc1aX4F0Q4gWS6uIBPMkCD42ZScjGxPQs4UXIEiY=;
        b=Yh/2pKECEkRoS5kyvDObNANOrODs1Vht0JWq+2UcWqEZHrJZOZ2jaUDedEEkyggx+t
         69iK/G9LcO3jJM1u7Os1Ma//uWy0HYg+4R22v39kBQjIFJI/iHsAnspZN6n61hmBAj5P
         RsTIGefqDM/WAfgAFkLUSMFNYX0zw1X2u1moFza84a309fxAM1oLVMlxiOh3tZFl7idw
         OZbPIkyZC0xJbNoDeLxO5BDfTn5WXfE4DtHZzWf6BVrvIjw7eWSG6RzRJaETVjE/dyoR
         c2ttIykyKJJghcaDLJaT0CnsszEHvvXK8yrOHsVy9Kq/STbuQxo9pCs8dFbxJI4IV5qb
         Y2cw==
X-Forwarded-Encrypted: i=1; AJvYcCUwSWrQ5IvMuskv8Ii5Ro0Sudm8WT+egCr1fooT4Z8N9NzF1AYWi4JmCs63N1aIiq0OfZ5Q1K3i7YsJhgo=@vger.kernel.org, AJvYcCVH4AZ/o8P6wn387o9rePxuqZPDAvQ7CJhR+097HW6zRd9pU7rt83ed0Z3tCxf3eFzc1TdnpSU1G6XkayFoufI=@vger.kernel.org, AJvYcCWUvrcx+HDVlp7wIYGV54TjDpugBQMKNQbAMrJoNxxBK6ipei46Klh0xuN0WpQ6eKmOyYs+BUd/dXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTvOMjVltPHZZG5fSvmSRMg20NpT0LS3pArQXq76r0ug91cwY
	j6aRvpHuFQ9HMXEiqpLIAdofICOtAkZ7lgE3an2dOV+TkJBBpaNJWxpWHjFdJblUPb4cF2EIrdq
	0fnhyZolVRqh4UDeMNfvv/8Zw+CE=
X-Gm-Gg: ASbGnctsoeTF69lNyWjurBDCgpFi60Z0dBI93uuO5/wXZk+K3REehBIcbXXFOPCijmf
	nJCwyN3ZtnzhnfLyvLfDhKau4LxjlAiW/f6JgrutAzRR8eU48RheKa/oh8oOI6BhACN1hKDtD
X-Google-Smtp-Source: AGHT+IFVZVbHdCpMFS++gVmeCdw7EseksGV4n9xOJLGAgoTbNNSnOQqLE6P5cle8eM56V0ellIYQ8zK4VM8AKw+YE3Q=
X-Received: by 2002:a17:90b:3504:b0:2fc:f63:4b6a with SMTP id
 98e67ed59e1d1-2fc4078f0a1mr365983a91.0.1739566744109; Fri, 14 Feb 2025
 12:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad> <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad> <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
 <Z66oWuLwY4X9Ou9D@thinkpad> <CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
 <20250214191103.GH3886819@nvidia.com>
In-Reply-To: <20250214191103.GH3886819@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 21:58:51 +0100
X-Gm-Features: AWEUYZl63yy9VCOe9ontb_-fLX2oqD0JTPOslbrPOyjFSHRApIrQfDyu9KUaM0k
Message-ID: <CANiq72=io8McQ+N2-dxF6L4CC_CLJpRyCoqco3U72gfOMzXfSQ@mail.gmail.com>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>, 
	Philipp Stanner <phasta@mailbox.org>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:11=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Philipp
> Greg

Since they were mentioned by name, we should Cc them out of courtesy.

Cheers,
Miguel

