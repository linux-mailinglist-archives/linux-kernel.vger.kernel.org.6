Return-Path: <linux-kernel+bounces-187905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426A8CDA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A0EB22E23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0942067;
	Thu, 23 May 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kgrbl/Yd"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CE60BBE
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491021; cv=none; b=hN/iV6qsZ105NxnSinH/yMVZHqgkObSBWntnQbg1wmP2Z1Lvc0+72t4Mc5LYZm5HYRMIJ0S9f+mMt6egF11HVZDz8im7tnJwjFRAVBbTHicYCit/JfwVYghwJ8Xc+t8/Dbg+0IYpmVUWA7YfI9b5+Nyh1+IyYzzT64SvvGQ6l1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491021; c=relaxed/simple;
	bh=qz4H5gdKwMYHrWkklEVDwzWw5jC9xZru8VTxAx5zOpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7wgEghR82wQGrgcKXQ8ZkB0+DuWsi0hqRSVKhuDWFRQZLweP4RcXAMHNZQwionBzNWMKp/Tl/vhJrK43mkQOEzWsfJZHW+NKucahXtQirhlYqVpeuPeQn9c8S06qvRMp7FqC5up9FWYO/S2HYhusEexSd3GzBG1MieyBg90lDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kgrbl/Yd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a626ac4d299so1236566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716491017; x=1717095817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SEOOe222bgD8uBXMvqgINByafZXi3I56R6e176eQiSI=;
        b=Kgrbl/YdpHoleFz6BSXEsznRhZ/blpUtnfoaF8l5WrM6das+tPh/3JiGoj6zbbChn1
         sV+NJPWaHl1nasUAt0Aw+hcHNFHMWRuk9QQP6gohXoxuNrzKDrjj0Hw3B3hduEd7iXUY
         4t+xMBJpzt/rXvoD5OWqBPg0gV6RDSPE9o55Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491017; x=1717095817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEOOe222bgD8uBXMvqgINByafZXi3I56R6e176eQiSI=;
        b=eF+D1tG5uiWY1q5F99Sun5xerRoq11rQAA+HeFHw6Bf/EcaXGqLMrxUOU6utp3oHgc
         dog3+iDgwuOP3NqRWspsqXj14hV0buH1ILNsmDTEkGggadOjFTChwPaZ7DiR4Urf6uPD
         NHsy/9v55gQd778jwa/WrQA0CVMtfFiYylHUusw5/lmEHV7sbaIe/Y0Wm6t3xIc8l1kE
         eAAWQhhaOV1S24PNmF87Z2iWaGeYrEYu00R0uOfhH9wNfP+EP0ZfB8CcuAb/SnLvX6XH
         NJQhtWU7OmgXUyWkfrhxIiNCEWkhHOuqNN7/aABbNbVCoKnTaQRgrWaEFYWYZmvLkPL4
         E1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUK+MMgMPluLVAAUp98KCEdSOkv7dTo7t8TOYueiQ6toKgadDZniGpQw25kilLbcHCP218lnwP44Yj12xXHXow1WJi4NIzzjY7Ss0q
X-Gm-Message-State: AOJu0YyQmxFQ+4Sfk22kpOQMenz8igFZPIlo0rs3kafg+iL7Qz/mhf3X
	7kNZDgj99wqK4f13Vo9NcD+xzIWuWu5vMofhAT16Tnms50ZMD0O94xAPcrAFADOfYpEg4KhWGHU
	m62vT1g==
X-Google-Smtp-Source: AGHT+IFPE+Wy5vzqutCF0GM74HpspXTXaBNeyU28wFiBDjiCso9x2WNH8Znf5IhQmcWjD4dft4KSVw==
X-Received: by 2002:a17:906:648:b0:a55:acd8:996c with SMTP id a640c23a62f3a-a62641cf94cmr14620766b.29.1716491017370;
        Thu, 23 May 2024 12:03:37 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm1249249766b.85.2024.05.23.12.03.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:03:36 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6269ad7db2so2752466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:03:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVytfsTdb1Zk001ANhZGxEiOy+KfePujsuwkmi660GU36FORkvdd3a4uuKO5Sg7gIvl+VPeXN4zAna1ygNFiwjSuIg6gEiv4RSwR31e
X-Received: by 2002:a17:906:8304:b0:a59:ad15:6133 with SMTP id
 a640c23a62f3a-a6265111846mr12629566b.71.1716491015917; Thu, 23 May 2024
 12:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com> <Zk98B1FLIAt2SU4Y@home.goodmis.org>
In-Reply-To: <Zk98B1FLIAt2SU4Y@home.goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 May 2024 12:03:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGatHuK-QYhTa2qF+REjXZ4F=dGkQve6MiURpCZvJWJA@mail.gmail.com>
Message-ID: <CAHk-=wiGatHuK-QYhTa2qF+REjXZ4F=dGkQve6MiURpCZvJWJA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Jan Engelhardt <jengelh@inai.de>, Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 10:25, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> FYI, I would be happy to convert the tracing events over to dynamic strings.

I doubt it is worth it.

The reason I would want to clean up the existing random memcpy is not
so much because 15 characters wouldn't be enough for tracing, but
because it is just ugly how we have this bad hardcoded interface
without proper abstractions, and it would keep us from changing it.

           Linus

