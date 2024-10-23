Return-Path: <linux-kernel+bounces-378647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C249AD3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15D32851ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F51D07B8;
	Wed, 23 Oct 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QsGJZKqc"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED11D016A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707007; cv=none; b=be4s8qf/JLkIr5i4GuCNUi2wtDJ8/rnYt/imYpyVf+pKPHqS4ATB6i+DR38nB2fYPQcmpAft/pdi4qOXGBBlzuTPMlr9ExRWmIaNRyVVWuQnbMz+DRID368Hj1y/wnDQ8YoC/0HV3tVmio98PsXt2p291YWNT/jzErzuGkyvpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707007; c=relaxed/simple;
	bh=lE42JIL6vSpDwSorqaxpEBJHVYXGViylruSIlLVPi3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv6VlnI+DcaYWz1eLoX816xEoHv02+6h6k02UWvsSDfEem8xiljJ/40YXg5WHI0isxoRWnn8zByt2as5FoB/EWACgr0UJn7BJO0SIqpKKybwP5CQwz/KR3yRlvpQyiUPP+H6aqewMyG4QTtvJ5JZNNuY/JwLXIMFAQxcVk1Vu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QsGJZKqc; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fb49c64aso130786e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729707003; x=1730311803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbORvIuwugQ76782JL8neziFCEgBQQicaiJEnwAdmX0=;
        b=QsGJZKqchhORgb0Y2r7u1eXjGPxe7F6ZleKNgEtGRdrv7haPMNDzuf0ZriBH7yRMNF
         I/qeOWkJe0cgWwBDlRzZEb/zYYB4nu9Dc4L0d7Jgi/9GJs6yLXdTXMOKLQRtmk+C9x9S
         J/3fk/pA0JVsA7zgLqmL0IwEHB/YLkDLHo0TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729707003; x=1730311803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbORvIuwugQ76782JL8neziFCEgBQQicaiJEnwAdmX0=;
        b=kc4c0khtmcK2Mfy7/SlavN9MyFln+1Lv8E+I1R8juI374k2/9EVeMHvHx7K5rBEhln
         pHxvQk5Ff8cDx+Xk58RiwhXQtAEblug7YIGRI8fUCE8dsmBmA08ML03X8IdZsCkWrjvo
         Q8BH15upND1T3GopMMsOo4VDmiZSFzw5a0FrjP9QYqX0pvsnm/Sj23DzaELMrdZws44V
         D5w6V5/WHwHJPacJuhU02KOUqIThBhh0JufYOk+LEiPjxiXybPgq+7E5MUCXydjpIeL4
         mF+j1PIYdwHhXnvednSyvb4Hk0HxUMLy4coYt2RWOqNH++eMnQEJ/q+0hOLIts8bByTP
         COIw==
X-Forwarded-Encrypted: i=1; AJvYcCXmQHNLxJRaRWFzvIt4SYZv7R9rT0rEf0wqa/vEaE8Ev+8YhklOb7rby8q99C+nC3Oigj++2KUnJeHRIyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLieHTo2rzT/k0o5EATEDSgu/FyQ1rMZtjkB8LZClP95GLWrf
	020pcEMaLq1r97lX7f82SdV2wI2lvwbTaiKBecmjwAX/1Y+Gnq3Cz0YJx5PVxrndHWW/rbxglqW
	nF348Yg==
X-Google-Smtp-Source: AGHT+IFXB2okYwd5EOa6RsD8qpdwVKtH+so8kjjhugqL30zOROQcDR+D5lTzexNJPLval5vT3MA+pA==
X-Received: by 2002:a05:6512:23aa:b0:539:8cd1:848 with SMTP id 2adb3069b0e04-53b1a3bae89mr2805744e87.61.1729707003343;
        Wed, 23 Oct 2024 11:10:03 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b1403344dsm559455e87.238.2024.10.23.11.10.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 11:10:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so601731fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:10:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNndowlEoS+0XVWn6WS37m88l5Tkc54ffnx0ou2ICSqYN5kwA45xn/BIvAYWHyAKK+CNSmsEDcu1XaeyQ=@vger.kernel.org
X-Received: by 2002:a2e:a991:0:b0:2fa:c5d9:105b with SMTP id
 38308e7fff4ca-2fc9d2e53c7mr35431771fa.2.1729707000802; Wed, 23 Oct 2024
 11:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org> <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <61e62ab7-50d4-40a3-8230-9c5e6814829a@roeck-us.net>
In-Reply-To: <61e62ab7-50d4-40a3-8230-9c5e6814829a@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 11:09:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1j+yj6X9vaj6i+oy+CtwnUvK+2J9LkheLjHtKAFYrjg@mail.gmail.com>
Message-ID: <CAHk-=wh1j+yj6X9vaj6i+oy+CtwnUvK+2J9LkheLjHtKAFYrjg@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Guenter Roeck <linux@roeck-us.net>
Cc: paulmck@kernel.org, Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>, 
	Kees Cook <kees@kernel.org>, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:05, Guenter Roeck <linux@roeck-us.net> wrote:
>
> And that is a good day. Sometimes dozens of builds and hundreds
> of boot tests fail. Analyzing those failures would be a full-time job.
> Who do you expect would or should do that ?

Yeah, this is the problem. I think it's only useful if some automation
(not humans! That would make people burn out immediately) can actually
pinpoint the trees that introduced the failures.

And I think that would be absolutely lovely. But I suspect the testing
requirements then have latencies long enough that getting to that
point might not be entirely realistic.

              Linus

