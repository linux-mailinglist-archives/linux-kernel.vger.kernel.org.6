Return-Path: <linux-kernel+bounces-531271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA983A43E55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F3420FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C1267F46;
	Tue, 25 Feb 2025 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuNZN2h6"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD793267F49
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484367; cv=none; b=aUdtrJ8TeM40zLvq2iqaY3hn66A4oX6cxCH7dL50zav2zBWFraG20bb1FnQfKS8sxHsXu8w4A5edaYKLjRZWG9i5b77m+wM6+0LJqtmzMUxnoi2wXZKs8n8WpNWyk55JsyaFOTeVAVp6weKNCoYpZit07oKCA9ffEp9PWEWzCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484367; c=relaxed/simple;
	bh=iauTMNsGMEck+UBS5zMelSzVlcGUNR/zltR0cFu/GS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohyzqj9jn3KHd1pXBTYs2lcFE67Fab3D3Pbuhv7qOb1Xel8aPQ1rLxhIuTwaR4bcCsSS4K/9RQH0OjAYXEMB+zNLEeZpaBcnLK9zf8rHofHn5D8dhGHsNgojs6jWOcCf4lQR8TYSTEhqICqU+SnZSFFqx9TTFVP5t9x9zFHQ8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TuNZN2h6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso8463119a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740484364; x=1741089164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UKkZk3XYe10sI4SqCfaUF2vUj6jiQSGLjxCT1Jj6tXs=;
        b=TuNZN2h6263tUqtvy+c8SZE/abdYlsEl4V9HK3+qeZirzxzwbSYjjqntQTD+kk0vs5
         eLiZn7FIZ2nDMaOcbIzKemuqnLXOoLcWmys1llhktTkGB5p6dlaC0BfyP2xNc6q7euAY
         PldzvRxto0RTfjIyfZ590+sp7YMw00zLIAh+EJ/P+AYUktLg8v+eLK19y3N0K326PoWA
         ypCfXJlf1vnWTcJKXbcuwIl+F2j+q1WiQ9tvpcGz8NW/CR4QNTFYEBczyEPoTqyvjv3+
         4Ocd98HT/7fWqqhlSV1jtAJUMeD51Ah/lo6oV7ZiluaxsnAf+o1NMU+/AYbwf2EBqWCk
         8wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484364; x=1741089164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKkZk3XYe10sI4SqCfaUF2vUj6jiQSGLjxCT1Jj6tXs=;
        b=T+WFAtQJU1Uy7hE9aIKwog/IT4bzNQxfwWBxy48bdThTppi8uR0Pb68pJ2/h2Xigil
         TSwE7b3V2jCkYvZnm4+ecabq6OjAKpP1bjp0iyNARllmE2n2LiOuPs6ktCejDNlKxOY3
         B24RJrMqr7LcY+SW6zmbgDSKY3OPlHrGhkdbiEE8GDn8yRdValUUUNg/a7/vQYPcgYX1
         dha6E1cHUm10rtYkqR8iIuYAZvRh0pbV4qFG4R4OK8ZvGB4p17xzhj31ODr6eR/BwNvx
         +CPFoD+VXJiIpLRY9Ktx92kN6hs4/4TQuJell3zBRpSXxVPXjeOnM4tPvHAfvth1n9Qb
         qBtA==
X-Forwarded-Encrypted: i=1; AJvYcCWe8T8vPl23uaUpGXXoZJj6gOOhQ/WdtLY28AMkLyIDp5rJfo9R9CJrce01gBxopBdFsJNT1UkBvLGM/98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD83YStvBQdRxStEFjhkWvhe0Hf2sUqzw9LF6SxY0GDhH1TRN
	CJ83ql0aInbmUlBm9EAexsHsCFkraECXiG4Ws40EfRm+9MTncuTYTpmn/eewFqo=
X-Gm-Gg: ASbGncsPfr/vk13KqyhITXObpW5Fracrs1RIehLnC432QIY7M5nEMctI/WWfh4Tho2T
	seNNNhbMcR/qpcWalzQPb/a5aAuNjJ0EPr8UDdd+j/4FNAMT4GC5+jPQvpLNW9ZWWH4Um/4FBm5
	zN3U328qfeS2bZ4xVfxzb4DKW2Dgmykk5B1IAg2ZwSQux2i9WgsDO1exFgx3UrFRRpCf1huUUPl
	P7wG1hCsODAlbJK98ozT7eRcZ6go38f8TH2CZ1+U4KxCgpgeplx0qNGTgq5ThqaZJFq9VSbIi+B
	tSDTR14Uj78icYT2osHSAVrxZKs=
X-Google-Smtp-Source: AGHT+IF5Kl4zanHSbJ5ugAs5izPcChWCGh6n67Lw/yDYylYVv6mlKOvTyZomHkrigKbNsZ2kNLDp1A==
X-Received: by 2002:a17:90b:3b81:b0:2ee:9d36:6821 with SMTP id 98e67ed59e1d1-2fce873b2d4mr26764094a91.27.1740484364195;
        Tue, 25 Feb 2025 03:52:44 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1346475a91.20.2025.02.25.03.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:52:43 -0800 (PST)
Date: Tue, 25 Feb 2025 17:22:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
Message-ID: <20250225115241.cm5qdpa22gzi26fr@vireshk-i7>
References: <cover.1740475625.git.viresh.kumar@linaro.org>
 <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
 <20250225105425.ooqvefiae5bmr723@vireshk-i7>
 <CAH5fLgjbW0yGm0TQcQEG9cc+i3WxbF8JKaqBUFD7=pJ-JkJ9zg@mail.gmail.com>
 <20250225113642.5fek3cy3jvmusunz@vireshk-i7>
 <CAH5fLggYMHxuoc1m385UL7sNB1ojAg=pwZ-_xfgHiFSV1-xpfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggYMHxuoc1m385UL7sNB1ojAg=pwZ-_xfgHiFSV1-xpfw@mail.gmail.com>

On 25-02-25, 12:39, Alice Ryhl wrote:
> On Tue, Feb 25, 2025 at 12:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-02-25, 12:34, Alice Ryhl wrote:
> > > Hmm, ok. I would have expected it to format on one line:
> > > unsafe { drop(KBox::from_raw(self.ptr)) };
> >
> > I did try this earlier and rustfmt suggested to format it the way I
> > have done it currently :)
> >
> > > That is what normally happens when the semi-colon is outside the
> > > block. Not sure why it did not happen in this case.
> 
> Very weird. I'd guess that the #[cfg] is at fault.

Dropping #[cfg] does make it complain with current code and suggests
to format on one line.

-- 
viresh

