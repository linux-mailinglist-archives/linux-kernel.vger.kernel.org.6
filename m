Return-Path: <linux-kernel+bounces-245687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9C92B613
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85161C221F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94502158201;
	Tue,  9 Jul 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOAOMrxm"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C642155303
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522969; cv=none; b=YsaxdPS21pzvRyORXJWKGSWbwEGv33h26CMGGzN4ccr4oeAkfJP5aq/s5DIdFT4wTSfPzh7dOo2it+jcJvKzXjMwVIswIkN5QXZH9DsrMN/nE5N+sNavPBDVLCQbgxfmjAblnuJ8+kI2a1vJOAk9pFx6zwchO3S6C/d5zzyWu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522969; c=relaxed/simple;
	bh=ICwC8hHB4nssKkN75Qlzvd8rIcpX9ZQoWm9Hdqy5DwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJkeUK54l+u/fSH13o4oBW7ouJbChWRZO6M64GbqK4YtCQCIJPO7iV4Ee/YK23EcdM05sdI8wWwbuUa93dJR94+v0K9zpatfBHcYzJ9iDN1wvmUiXYWqGNU/FTa//PEl3P02epbJ3U+De1d0SBhx7o3QeQFQvaNOFonoulFdaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOAOMrxm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso3180583b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720522968; x=1721127768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yz8rqRMqOY683u5fU+cnnte1WW97jEHEhVYRD53PDio=;
        b=tOAOMrxmF5SX9/yidFT9l3oQFPMmITisdEw0c3YjacAvBaG4OwL32ijQGjOnU4tScA
         loK0ASFvIfha/dDCuOCQj6Hj/fVeAjpoGLPdHHUHYvBkG2Kr5FRmefmd8CUe5/rQZ3XC
         kjR/7HQuMuD1uzpIiX0NW64A3E7kkdkOYJS+F7PKXOo5fJs9TX+fNzVeBVh5sKBCBfuq
         5uzEWpnI61a4f0qdHO6hnDA35m3vFd28VdVyRaQZc8cycXWcFfAMS3Ac6Wog94+v5eBb
         VyjNFC/xBaaZzMl7YOe/9ryJ3QOOBju2zUgCSc0iMlbdtBpnxmeKL8kEL+reOMeXTUvw
         vfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522968; x=1721127768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz8rqRMqOY683u5fU+cnnte1WW97jEHEhVYRD53PDio=;
        b=fA/unVpHO86ZTmZ5WoXLM+uIx0/kS0lpPUe99I4arjSb4XCAlKmxOHmuIX2rV3PokV
         WfEwOaOMPfODTFV1chBXm8lMtLBErdpwUUqG4Kh2QymtXReWjOA1xcbPMs63mp7jymR/
         CkdKUjxUen+Jia5cknhVOQqdNpB8JuAuj4gEODhkYPZR5yd1aMiFIMEO3zZ9McRpbhbe
         BqG6Rt8F6Ze+IXuSbuKxyd3ndCzcXx61BVi70aNPZCoLK5OQ1YV+dMz+gEHgFkhaNuOI
         GFewLRxOkWiF4k8c9ENJ/T6xZnchFqB2pLMLJJdvbxijR19QH7MZJAs0Ar108VkjYp9L
         R0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWBkKXZx0LgSZv+UlPbApmDuVF2cCARhU42CBjVhPB3evsGHbvAwvbeMiPH/VAgApdV1zuQjWdA6cgijLLOspzoegyUlK0XMCFKQ1zq
X-Gm-Message-State: AOJu0YyqmbT+dqVMTTBMGf57UI+v8ihXYOM/8iuyffGK5EDTFSD3z7Wj
	zHYFoTeCBQ5qhr5u/HbZhRZbwDs7Yb5GuN/RT+aGdb9UUYVzQpZDn+wAP4TRchg=
X-Google-Smtp-Source: AGHT+IEnZeyyy+JNipf3YeCIVNiI2S39fnrN1eQJ+5u6wVxKp7TogZLRs6I2FcH4SNfru3myy0T1dQ==
X-Received: by 2002:a05:6a00:1d0e:b0:706:6cb2:ed17 with SMTP id d2e1a72fcca58-70b435220f9mr2429638b3a.2.1720522967959;
        Tue, 09 Jul 2024 04:02:47 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c0996sm1513827b3a.60.2024.07.09.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:02:47 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:32:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <20240709110245.o73xnrj6jsvz2v2w@vireshk-i7>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>

On 03-07-24, 08:34, Boqun Feng wrote:
> On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> > +// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
> > +unsafe impl Send for OPP {}
> > +
> > +// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
> > +// thread.
> > +unsafe impl Sync for OPP {}
> > +
> 
> Same for the above safety comments, as they are still based on the old
> implementation.

Do I still need to change these ? Since we aren't always using ARef
now.

-- 
viresh

