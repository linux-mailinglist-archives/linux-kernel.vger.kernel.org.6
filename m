Return-Path: <linux-kernel+bounces-182905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE98C9191
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94A1B2112E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD964644E;
	Sat, 18 May 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLRV83qm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C515AF1
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047777; cv=none; b=DUvpBw+Obn7l9m24cSWi60vx8wSO3tN4le64LT7xpSpc0lnvpO+6wWmlP3xpl4NOzs0KzBq1auHhkdPGPxONJIPIsZ22gXNGqqEXFWMsAsqDTO+ZkKdpbrlUXm+4470tv4sQA9on5+vvH/73adWqw8n9mZ08OEqEOmBsRfQ3cfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047777; c=relaxed/simple;
	bh=SXfWLsYP4xO1fcibCHqgCOo6Cp6knVav2OwezPj+zsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C01oNkJ4cOZDjftoqL/nMQNkrVE4+E+/SzkmhTcOoFwlJfu21cmh/YDfur43Tp5JNLYvsb/4iKsUq/ziJbSvc4FEgdXJJrANmhAWQdkoglSaJarLH+XpbrsuB24VhTLUBDPUhVVHTPZeAa93Rpc2ZpaqX2STCqAukGqcOTlt49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GLRV83qm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so23429611fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716047773; x=1716652573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGl/ypIf9+AIU59blmBwfVnkcczybxZqLcx5RH1o85o=;
        b=GLRV83qmPm5fIKm8QkEbdrGui0H7+QrdXTlCXc/vnQf2K88Bl1ZVdjKNJYQr5FCPjf
         3CNuWwn2WtX7IBbsXsPBKmSqGC57kxTanP6I6S6Wt/zU1x6crFdSCQFFdxGhH4WSqyD/
         az7n/0p+jtpcbh6ys3JLLZIw6nSTGMgcGxiCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716047773; x=1716652573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGl/ypIf9+AIU59blmBwfVnkcczybxZqLcx5RH1o85o=;
        b=uK9lDTo3e5FS3u1oHhUVAmKVnWp0tcyJKE7E1WKyD/i4qIW0+8VptV0k4JZTcctA47
         riAeho6luF1bA0Vddz06maQBMLxPdLvLvovprh3tULU6HDoyghNEkobpFRHlmQsFWqpY
         MatAoYBsza3NWip/mVBtn4QUtqVYYfKegW42y0hLrYHH+0nwroLTT+ui0BMto4VbdtpC
         A4vNkx35LPxAGTwkLlWPIH+t9Iq5dbxpjnC+ypqXbEIk3822C6d5zvPwC2HOJNA5HQTB
         dKFx3qNGTw5YAPQNcO6e4LY3CNuOeqCvBHVJ3zpwB1D16LjgoNIygeOdAC6qxYOypxw9
         nh2A==
X-Forwarded-Encrypted: i=1; AJvYcCXtamzctEY+JIVlg791Gi7THZ1tKobx5w/zKXDWavM8poHo+v4bIH3UW3CuoJwxjC5NxW53yRKn+uL1MixDNoQXRTYPgNOs4RrKXFdP
X-Gm-Message-State: AOJu0YzT/q49r1aZ3nGM4RxBY3DyarFUt9Ev1fH3PzeK/nGFxV7CtM13
	8WIvm0z2tFJkOB/xXPmfFj4G095RzCPESSFjfLTy01DJtQ7ZQav6ma3yltycTLZ1YDrgQCjlYLR
	WTZUXPA==
X-Google-Smtp-Source: AGHT+IF7qLjmGlwd/9TdKeUYTfwhF71/L4aeTyQ4EX8Zqfo0NRiUSOHTfZlDdc2CwEjKKLf0rRDFOg==
X-Received: by 2002:a05:6512:686:b0:522:33bb:ff7f with SMTP id 2adb3069b0e04-52233bbffddmr25075049e87.26.1716047773213;
        Sat, 18 May 2024 08:56:13 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5225132505csm2610931e87.116.2024.05.18.08.56.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 08:56:12 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f71e4970bso3456592e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 08:56:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX92JtvqU5G6WbqMi3xE3g83slBPN5SToDldmQllrzWRDRoftqmJugrWV8RxXB3p3VM6uSMXOh6CbtqkpOxnnrI1KjBqWj9ngx6YVNo
X-Received: by 2002:ac2:5e8e:0:b0:522:34a9:a7e7 with SMTP id
 2adb3069b0e04-52234a9a8d2mr20924915e87.22.1716047771846; Sat, 18 May 2024
 08:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
 <CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com> <20240518233824.360de206ba709473495f89d7@kernel.org>
In-Reply-To: <20240518233824.360de206ba709473495f89d7@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 May 2024 08:55:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMwMviFKdSDyTDdgvapN0W9gFB-DH_1FDP3TDpkMOeGw@mail.gmail.com>
Message-ID: <CAHk-=wiMwMviFKdSDyTDdgvapN0W9gFB-DH_1FDP3TDpkMOeGw@mail.gmail.com>
Subject: Re: [GIT PULL] probes updates for v6.10
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Haslam <jonathan.haslam@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Ye Bin <yebin10@huawei.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 May 2024 at 07:38, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Ah, and I missed to build it with W=1.

Note that I do *not* at all expect people to build with W=1. It gets
very noisy depending on your compiler version etc, and a lot of the
W=1 errors are not at all worth worrying about.

But what I do expect is for merge window pull  requests to have been
in linux-next, which will give it at least reasonable build coverage
from the bots,

I'm not sure whether it was because I built witch clang (which gives
some warnings that gcc does not, and vice versa) or whether it was
just that my clang build has a different Kconfig. Regardless, if this
had been in linux-next, I'm pretty sure that it would have been found
before I hit it.

             Linus

