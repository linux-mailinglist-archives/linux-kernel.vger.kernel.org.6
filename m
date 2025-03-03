Return-Path: <linux-kernel+bounces-541553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D2A4BE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDF7A6A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127E1F8681;
	Mon,  3 Mar 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBu647ZG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC371F5850
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000550; cv=none; b=L/c+qDtA9MlpuPAEAEILSd/O8HURdSVEMtRXxeddj3jdHDv7vV8XtFkFdHK3VjxwBCKSgikVreb7p1VOsTq489M74opJwCX777Qu28irLoecS8MxRYn0fflANh7w5ke4GhdaLZCXIeK29ToaxW8TZI5Ocet9skNdJVkWv3Tqx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000550; c=relaxed/simple;
	bh=5hC/zsYW4m5dWMFoZYSvLKC4QhkY3ONrIAi+2Fa+xC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uROiogaM+kIzlcPmAg0X6fzDzq16jRYy8GKWwkLBadWGcPuZey8W53FbhueF5wbCT1hBZ3pNenPkzOsH4XuJiJnEA6R8VQORXodrfzKj9bPfKSWKaEJbU2ipoYdN9r8A8+gF558Xa333F0UgE9q+XkdkzmSh5r3jpWSLBn7E9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBu647ZG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22349bb8605so80496095ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741000548; x=1741605348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aSxQXnps0NX3/X724vkMJF3+1qjDBVTjDpo2eD773ZA=;
        b=rBu647ZGQ7FavGU9hTdt424Qee0DdYiWJLFz8OxjX3rgtONSQVWBqDEuLT54PJzUDq
         aYOYHab17PUQqk4UM6ydmYm5OmJyE34/vT06aLOQT1JYO1kUCE+NSRZqQB2FnQfH1wGN
         RmBtErI8OtRov1oMZ3USehptc712n6Wy1TB6Zgd/u9cRk9r/7PweBTQFpvBV7AWaE3/k
         HL1DU/wwWki276QoPGegs68X03jMioM5Jbg1n88b7xD+adQdncz9QMh4q6tLiOcXsFvL
         /3Zd2LPHVtgH2wLSkXlfqDHZfzPzE7aoqK14r6ztSWOfX4yh9sVKhGkJGgr9NS0gWKWf
         KI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000548; x=1741605348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSxQXnps0NX3/X724vkMJF3+1qjDBVTjDpo2eD773ZA=;
        b=KTGlNXVfZoscW8raRLUiyNcsRr/zNWZBNFUhy6qENn7EOZj7Y9JoQ8hfHiafNaqH5m
         3YIWTPxYqPNVyt1vDnEUEjntgg/6RQB1spFZ53RfyokoeuH+2U+i7mcP3FeDFbDDM2Ef
         n7TGUOYA2SALm6Yn7nMPmyp9z9BVAzflzunaCX02zVkV1d3duT9r1Ni0VJfVHwlNlZxi
         paZ8nHZgnEvlUSLrxeg6gAQwEf2fktd2MHIq6cJ8DSNJ207U6fm61CmK0BUlINZVOyhD
         8iUpOHomK4IoD1ZHRTrfI7mMPzBpzpdydUiFKbHiI0j7OwXvT2XHgrYKO7toh2mO59I2
         9DaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxAeTW55LPviGmhH3hMzwsduQ3FvWHMo41/2g1gjQgX9opl4P71TuN5GYq9GLbawe4JhJnSDvWmcVjEVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsg+mATTmMbtmL0rIBAYwzHP8+JFORWU7zmiDfEgFTkmPBAKCU
	AP/B6EzQTfVDQKhtQG/3Fw1pO4H9oAM5ckEngLMb1lRjvvnMo1AqZxi57nIhcoQ=
X-Gm-Gg: ASbGnctSbNG5w2e18kiG5dOqgkUTF88IbKh+8h2g/bugQbPappphbPHHRii9x8/1KXy
	S8ostovuvRhmINTTWZRfIMv6gmZ4BKD4uq5joKNOqPzCUXQPUoSlFfLR64kSb5+ZBLdOImDShcv
	TKquGo1OmOEE3j/UO+RTmFT1isBoW8lNn67vVbmDv+HTbLYEXVqOxdzw8xpj769+fEDqRhqAD1b
	qlrFmsIaqj8g8Rtr2yD3lSF6dozCif4jk3kYe47y+9aSMu2CIbn25SDuYYBmoL0zipbNuZyu00i
	fw3NJ6kD/dQBFeoXiAFbJDzN/wLD99bqBQdp9V3SAK6UCw==
X-Google-Smtp-Source: AGHT+IFZbp31fkpQhA+gdP4RfVHPSfPGmjA4KgAfzi0kwaQaY1tDD62JMcHr6vaO69K8iFjA7m+Low==
X-Received: by 2002:a17:902:f548:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-2236925f2c5mr179305795ad.45.1741000548141;
        Mon, 03 Mar 2025 03:15:48 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d29cbsm75815325ad.50.2025.03.03.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:15:47 -0800 (PST)
Date: Mon, 3 Mar 2025 16:45:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH V3 1/2] rust: Add clk helpers
Message-ID: <20250303111545.ekszepspoghprh7g@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <171b6cd811ff4e913880ab33bc11e634f7cdeecb.1740995194.git.viresh.kumar@linaro.org>
 <CAH5fLgjNE7BF7fC6TxO3NjKV1OHXRxZFKn2Bs6fy8h_0zYd1tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjNE7BF7fC6TxO3NjKV1OHXRxZFKn2Bs6fy8h_0zYd1tg@mail.gmail.com>

On 03-03-25, 11:05, Alice Ryhl wrote:
> On Mon, Mar 3, 2025 at 11:00 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Non-trivial C macros and inlined C functions cannot be used directly
> > in the Rust code and are used via functions ("helpers") that wrap
> > those so that they can be called from Rust.
> >
> > In order to prepare for adding Rust abstractions for the clock APIs,
> > add clock helpers required by the Rust implementation.
> >
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Did clk maintainers ask for this to be separate? We normally just add
> helpers in the commit that need them.

Greg suggested that earlier:

https://lore.kernel.org/all/2025010708-commence-exile-0946@gregkh/

-- 
viresh

