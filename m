Return-Path: <linux-kernel+bounces-544774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E1A4E51D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E758179B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5328D07E;
	Tue,  4 Mar 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBu647ZG"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEF281526
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103027; cv=fail; b=rPZOTfRgDxGsb5fC4wSCSLnIJjamBrDksPByRAavTl/L9mu2kCP1iAZVcZYdORvoZpmGDOn/LHsoZFqCkAlPZbZgEtV5YW1kaS0M6hjDk87xvtrkPGwX3nZqG1cotkcqKh1UGZAIET7uh4jKs1q/SKvl54seKWDEGLkrt96ARNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103027; c=relaxed/simple;
	bh=YHDjXuCeNTFglnAemWe8fLQSa12wISBfmsB4F/eC5lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc8JDoGm+HR2juCQMb0ZZqbCvVCBNKQhqOEgc3ES7wm2Ga9LBOwZsCHtfpDSJg5FJIkWKmWcEVeQyKEAPWKFC6vS4ZahkOPePuRsuU4obC6gCvquOz2D6JQPL03nXY5ElUExjAOEUYfVF36zQcF4eNwbbfvWPj605w1rFrR1pL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBu647ZG reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.178; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 82A7F40F1CDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:43:43 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rBu647ZG
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g0d1LV5zG13w
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:42:09 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 839654271F; Tue,  4 Mar 2025 18:41:59 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBu647ZG
X-Envelope-From: <linux-kernel+bounces-541553-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBu647ZG
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8A9E842881
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:30 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 3FFE73063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943CC170817
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286421F875F;
	Mon,  3 Mar 2025 11:15:53 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH5fLgjNE7BF7fC6TxO3NjKV1OHXRxZFKn2Bs6fy8h_0zYd1tg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g0d1LV5zG13w
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707740.65922@LUTv6h/dQtzpDrsPtDl5Bg
X-ITU-MailScanner-SpamCheck: not spam

On 03-03-25, 11:05, Alice Ryhl wrote:
> On Mon, Mar 3, 2025 at 11:00=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
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
>=20
> Did clk maintainers ask for this to be separate? We normally just add
> helpers in the commit that need them.

Greg suggested that earlier:

https://lore.kernel.org/all/2025010708-commence-exile-0946@gregkh/

--=20
viresh


