Return-Path: <linux-kernel+bounces-568357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4246A6945A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22C6881AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415531DF987;
	Wed, 19 Mar 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mve8MFSN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572F1DE3AA;
	Wed, 19 Mar 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400421; cv=none; b=RKIPe/lwi08+yhlqprR5qDUGsflrMK8FtENYgZpfCffXYOONgVkRQ3ADALL51GVGJYlht4sD2EWhKRsXMhlt3pzvOvpBLJc5DXBZpr78FYiBwJRsxV04jnJtWtcbRcE1bXDf/yXT48cRCS0DHHoMg82dKIDDhAhVGHIOECoY8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400421; c=relaxed/simple;
	bh=QT0GuWhMfzcfyxlGH/RH2ms1bLQNjqGC/NE3qMLr4qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egI8HgJBCoIepCswTQXE4G2TNmekT+vAkRkO8kxIt3DimmwtMuPorT5MhYJ9qzySUyq+7EA37OsUw1TNkHRoA727Oae66aMlEzAWH3u+ENMVIXnEWJhswvQMjtngMU/Y5asGKdgkganbFl8FM50XJfx1x40UVMKvGnw6m5COFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mve8MFSN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225fbdfc17dso73954745ad.3;
        Wed, 19 Mar 2025 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400419; x=1743005219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKJDA/dDId3Esj4Lemw4mM+nB5Kzyt6ZrsLmPv4i3Nc=;
        b=Mve8MFSNQKHXmZMg3N+k6FAXXJG0zs3a4g+5J5Fs2cP8ac6dibqg8znnYzLyStBQ8G
         cgYCsA8EeDE5iVm3foXrZJV6vdgVoLA5aKCiWTplf47ZZ2atT7bsS4PlbQtYO5gZcNNv
         lG7LRcpVo0v5j5Alj9KrABACj/Tw41DkT0yBZzmcPUzVwIJd9oWSk8wcDwqMS4ky731E
         AaApWlM6L/UACec7lY9BZflSQxiS6LfpenHFU52AQGj5ULR//g4m6Oe0nmhnrinTAQ/h
         LNFlYtlBqlMQ2+0q6GghK5+BCYxfRKad7I+G+0LeS/gNvLTfQqQIY36hYGy78avWZinP
         cM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400419; x=1743005219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKJDA/dDId3Esj4Lemw4mM+nB5Kzyt6ZrsLmPv4i3Nc=;
        b=ZFMIqGylGRA0eHhmDJG2kv9zkwyyHkPIDl+jSm2FnRxWcFqe8DPrw6oend2uKYYWDb
         cnvz17X4WbfykladpGjvVgLGGw/NJ/UKEJJ3jyPBl+RmHjJtvn0q334a/2IqGXRc0PW9
         rqhTPgtU1M0cgocyhJB08+OUomk8+jcmm4weeeETr5IkuPZZSnbQmjN4t5S0s/pwT7AB
         SmhWU3dQsthFsiQ9ZMijh/E/Pqqfgn2OdniQANwl/QQyRpQUSDwq7zzQQvG/KJ8T2izZ
         hjcGjmBpFuNx85wvhIa/SUepw4t3Ad12PtQYoEQk2AHp8cTRjOVNR87LyiYiqjst9mQh
         M/og==
X-Forwarded-Encrypted: i=1; AJvYcCWjeYUUyXqamukTIY/zBnBpR983JDViRBSr2esS8he52zuVIZejP+LMmqXVs6kaNGfUMsFxuviI0cqZQtrbuXk=@vger.kernel.org, AJvYcCXmAyeXCDH0XcycaleJEahH3H3dHiRD+R8XlCC4KZm++0IA9e8qZ0UXO6fO6Lvv4y+m2Vja5SxwsRy+XCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPP4mI2bxdpc6v1N4EshxTJZa2dW0Kx8al+PpJjtLgRp5N3hj
	StpLn0rAu0pfl6/cjwJOMYsqQNFn6IZnHD+E4/kP1wwmKWe856KY
X-Gm-Gg: ASbGncu/9Q8rzCu7eJvVzT9nX6yfDMuszAjKuA32zA1xO+pHyOsXf35IyM3XwGskQFg
	aGSOYCy0uLiBBIF7vp8rSDl0XPp2TzfYC98Zrl7PE1Y4AI5Mm136OfqD4xjBNZJqqHF/F7bn5g1
	9cXi71t+GZxMSh+lJfqqSbuIGXrnImYd2VF5zpfvVVxzb6DvafbxH47zToobI+E/WLdZsXhx+GQ
	rCySGTYgm8brjMm+wjr52E/jUKopWvme5fbMm0tfZSrk8LVOScSnLwt5Nbfkk+YE/eaVUueHxRc
	eMJgEciEK9QbaUixvEFntadid86vHuIp5PZ53abqi/XI
X-Google-Smtp-Source: AGHT+IFDNUuR1/pAujkQm5tujG6ypvEZ2piQK6Qgl0neiLzXFI5cG3ACWX/2gDjCRPpGZ4cqkzdJ0Q==
X-Received: by 2002:a17:90b:1b47:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-301be1e7519mr4767708a91.28.1742400419364;
        Wed, 19 Mar 2025 09:06:59 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5a1d1fsm1799250a91.27.2025.03.19.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:06:58 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:06:56 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: adds bindings for bitmap.c and bitops.c
Message-ID: <Z9rroCn3MAsXz1Lw@thinkpad>
References: <20250319112822.1961241-2-bqe@google.com>
 <CANiq72=fBJLhgW64vohSopsR0RQLch+_cKqRKDQT7yR9B6A-mw@mail.gmail.com>
 <CACQBu=UC-DmLGpg30=Dyp5hhWV7HGXG+bL73YBSq5vSa4t3mig@mail.gmail.com>
 <CANiq72k8-5YRwmcn1h+avuyusAC36ttOqwsMH_eO-DLxTm5gpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k8-5YRwmcn1h+avuyusAC36ttOqwsMH_eO-DLxTm5gpw@mail.gmail.com>

On Wed, Mar 19, 2025 at 04:43:50PM +0100, Miguel Ojeda wrote:
> On Wed, Mar 19, 2025 at 2:58 PM Burak Emir <bqe@google.com> wrote:
> >
> > Thanks, I was unsure about this. I understand the desire to not add dead code.
> > Yet, next-20250318 does now contain helpers for `cpumask.c` without
> > corresponding `cpumask.rs`
> >
> > So, I will include this in v5 of the rebased series, but with BITOPS
> > API BINDINGS [RUST] in its own patch.
> > Thanks for bearing with me : )
> 
> No worries at all! Perhaps wait a bit in case I misunderstood and Yury
> wants to clarify.

Yes, the general idea is to be able look through the all software pieces
in a single series - from C wrappers all the way down to rust end users.

This way I'll make sure you are using the API in a right way. And I
think I already helped you in that department, right?

