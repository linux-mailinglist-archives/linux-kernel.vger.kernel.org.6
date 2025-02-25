Return-Path: <linux-kernel+bounces-532659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A97A45069
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84C93A9396
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2CC222563;
	Tue, 25 Feb 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbpcqzSX"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A232745E;
	Tue, 25 Feb 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523371; cv=none; b=SKJAOBUdFgT6AV+Z712IEhF+ld6Gu3y376js4IIo8eIdhvLWcXZzPyNLA7yBojn2fHSwTYTcDmAmGQVrvtNF1Rkdcy2GLfpMn0dNJsnOQM+qVdzsSz+HsuMEaOKGBzqheVNkS63vlQaNv/XMK8x38wahuOyx/4sM+0TIf/XKKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523371; c=relaxed/simple;
	bh=b+LeoWD79JHqCNmXmfrX82I1MTihVlt4+Y014zmulIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAfg1JNSPKlkbbsAYYF6GQB4Ihg7FhnGUkBywRgnpq7QuYfQxE01PCFZ7Hwja6u8cd3ML+XHF49WrGK5PbWGoG4Q++JaBbk5S3YxQnEz9ytprdM2n9aTERkILwz7VALC9C1W0vzmxG9XOZ3Q5viJNj2cQ0La4bnFQpEDaDv6Y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbpcqzSX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso941984866b.0;
        Tue, 25 Feb 2025 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523368; x=1741128168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b+LeoWD79JHqCNmXmfrX82I1MTihVlt4+Y014zmulIs=;
        b=FbpcqzSXkk/ICoxkA03Fr8gT1nVDnCnPCIJuxg+qumgrlXj5cEuUcBphWdgVTi89Mg
         /uZyh6LlEdvQYR4t/phElpXglLrXg39sbWBlVrfFUoK222hnFshGX9gGPoifqGxZh0Hl
         XZfw/dEc3mKNbJjz6n6bp89vklfuhJlsfOw6FMwmtIlsHrnPqqxcvDLYcy1SWiW7/T9m
         ox2Ss4XD0IZFf+8yz5HyQK0F48pDsi6GWVesBmU1o6GKvs933TYAPFwSxnITcmt1VQio
         dcGW9Jphl+kHBMLTW0bdswqSEOZZ6VBMZVDJIhFxl78kj+DhyPzg7QHUiBecZNz+wnLr
         Xf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523368; x=1741128168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+LeoWD79JHqCNmXmfrX82I1MTihVlt4+Y014zmulIs=;
        b=eIYp4NYjQaK8uoIEtvq7nYkPnt4OYr09/4Fm3kPy6hr8QaskyOkc0w8YkRaA3tswE5
         UXNhpsjxjVZD+97ec1TFe9gTE8n++nn8+i/fT1FJVpD89gMxBjix4SzyjrQFhAP9Nd9L
         r90DQAWXFbbJccCW8QIOFUD+NQxwTH+HIHxIMQiDQHgc2GK8nZPP/T4c43zHRlbu+rQE
         8KauDROTSVByD45MOf4J+EXagmJfnMrQh4VtKlZHavfWe1Y8CPqJEm81PaNF0C+FQNQv
         HPemMav4nW++sNrQGwwqIx8BCZu2fHNWjdX6/uFZa7Ynk7mJIyKpg7EWHR57wj5ruLgn
         ahqg==
X-Forwarded-Encrypted: i=1; AJvYcCW5MPmtb3LKvUfl1aLroA70OnMLzh0GYVh8YXGpXwouNFdP1/U9jbT/hhFk+k9fRDA4u6vqvx+XbDIy/sKmZ+c=@vger.kernel.org, AJvYcCXcxwKxjwcMPuGsuY++Jypnds9bXvwAE+NSEOc4NA1n1M/0kgFBi1hclSq3nGu0/F766Z54pUFcTw6MszA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3ccQfXyzgHF+83OMS0MEeA2Z3X+AcpPraxXHCNo5N3M6DqnR
	MiCwaRPk0eFCDWG0XUgi8CpuzYEhBN+2A4qD+a2wpe2r3HCMALBjXfEO3+Ulcdog7GHx+D6ucm0
	FomzLmb3ra5uQIc2PZNHGen3YgmU=
X-Gm-Gg: ASbGnctnlE0zCrvocPr7cZfVAjI+j9g8x5qNnQjqLdnXVUZWItl9cxZictGX9buJ6tE
	2TO91gVEya0RFies/sQnK68p2/mXRMiaO/TKR5dfyYQaBIWifCeIW/yX48sUwV1gQZUDR0q4TQc
	GB8hbl0A==
X-Google-Smtp-Source: AGHT+IFifrc/55FE/o7oKNACzTd5eIPpMN3RnO7ka1K/p5yqQNOOgOOnNnXkfu+qTWAXrjJTu1ZcDxRLPqb8lMW9yYw=
X-Received: by 2002:a17:907:7d8c:b0:ab7:d87f:665a with SMTP id
 a640c23a62f3a-abeeef36285mr65939366b.46.1740523367894; Tue, 25 Feb 2025
 14:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7OrKX3zzjrzZdyz@pollux> <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com> <Z7xg8uArPlr2gQBU@pollux>
 <Z7xh5bEyh_MII4WV@pollux> <20250224184502.GA1599486@joelnvbox>
 <Z70EcwNIX0KtWy36@cassiopeiae> <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae> <20250225210228.GA1801922@joelnvbox> <Z7493C8_IvvYDbm8@pollux>
In-Reply-To: <Z7493C8_IvvYDbm8@pollux>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 26 Feb 2025 08:42:35 +1000
X-Gm-Features: AQ5f1JrXlW948cBSgISkGZ98vaN4OmpvDgQrRNGPSuFQf0Efsh9Vf4MvRVvuzKk
Message-ID: <CAPM=9txkwr3_sdNESa9ufu1j4V-XsJ=EuLFuNLb_dLCfwhYD3w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Gary Guo <gary@garyguo.net>, Joel Fernandes <joel@joelfernandes.org>, 
	Boqun Feng <boqun.feng@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, paulmck@kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

>
> I'm saying that extending the time of critical sections is a concern, because
> it's more likely to miss the unplug event and it's just not necessary. You grab
> the guard, do a few I/O ops and drop it -- simple.

At least for nova-core I've realised I got this partly wrong,

https://gitlab.freedesktop.org/nouvelles/kernel/-/blob/nova-core-experiments/drivers/gpu/nova-core/falcon.rs?ref_type=heads#L305

However in this case I expect the sleeps small enough to end up in
udelay perhaps instead of actual sleeps,

but I wouldn't be too worried about the overhead of adding a bit of
extra code in the wake up from sleep path, the sleep is going to take
the time, a few extra instructions in the poll won't be noticeable.

Dave.

