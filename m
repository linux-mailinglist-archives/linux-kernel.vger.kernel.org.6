Return-Path: <linux-kernel+bounces-323981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5280797466B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57E2B22089
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87FF1AD3E4;
	Tue, 10 Sep 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlKWhr3G"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E01AC8BF;
	Tue, 10 Sep 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010964; cv=none; b=NltZweLOdw0TibCP1K2dNMzB478D6GMqb6R+ppuoysX2IYpXGT6NBPyaXkv43WB+gxRELlwKsXbD9v3IewFSUORYOTmKEiVP7cQlXol65hIvT26Qh/YweMqT/AC0nq2VfmnIbSYnpgvs32QKD6fMwv8lAsT8HyKYjz/QZVSflG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010964; c=relaxed/simple;
	bh=DXHCh5WmbOQLHsWyY3zP3RNF0hy1wNjNDwcSpCG436w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7EW7qtV8QKJ7wOwvUoAxMiJpw38NkuQJRltNXuIU8C8KY65pInt3sVSvnxD2I3+78fvXD+LpKjGaW5y+D/esQMkZF4h0PLYAO+24yMOu6pnhUycHz3lGIKE4tEdglSaOZ99sdc/q62FakYM2a35fC5e93TH62A9tabdtI7jrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlKWhr3G; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso1740087241.2;
        Tue, 10 Sep 2024 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726010961; x=1726615761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXHCh5WmbOQLHsWyY3zP3RNF0hy1wNjNDwcSpCG436w=;
        b=PlKWhr3GdIT1csEmL2qmXpPxzJpiDuDXkiJiHZZLWk7TCDQQRmGz4V0oatkDoiz/uf
         8dcY/Zb0pPq4CCULSG7vr+jy8HIU4fMeUUUYUMkNM7L77iJe4Zn0jC4Z0P/XuRSfKm+V
         +Bo48F//EVvkIKKWqiy+afT8KZTBoDye558FnKg1LDCqf7MFdZpf8JAeHFT0GQ5goIDr
         rOKL9Q6uy8mr+mcPmN2ohE5kc9CA5MWBuZhi1g2zvLAWwd5vwn/aMM6xHoJiZGwujR8Q
         bl8qqerqkYNcuQGurCjMC0+Eno/3IB/qlxX9QNuzY6ZgtGYEUsxtoG28EeaGR9cNqDF+
         /YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726010961; x=1726615761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXHCh5WmbOQLHsWyY3zP3RNF0hy1wNjNDwcSpCG436w=;
        b=Os9g3FA0MWL7jd9yy1HmM61p0E/v5x5/e/afrBdA7Km+YjVcR82qGXE9/+Ec2D3o/o
         eUoaBu0PvG2a8pFq0IGDn8SF18OX0E06Ok0XiuuD6P4diPRzW23L2lwvH2SfKhC7+z9x
         sbSZCWcaxsavnhlnyYISPp8O4Fv7nsWD9QebiVhykDIEFJRqY8nlgzIK4ZONscAYd/Vd
         5f/kxfegQVqlY69AbnorWPaEmGOAUlD8CIZup1JDTWY+Tnj1eUglDlF/CB8HCWoBve6N
         VSo4fN7rK/2eRZBiBiT+lUHUgfF14KEr8SgLw0ySk46eqQTb7km2tGp5EvpFVywGl7cb
         n1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZTLHXW8A9J86FQAEG0/GPhCA27JDOSe8g4x0cnovWp9/xFMAnRlACyAPWNR5Gy4/536WDsyLjGzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VzPVUv/2jvrcA+cJI5w5jOB5wECraKXpxSz/0F4HeTetRC2y
	JOYuP+VmasPvHXibWuEZDaps0lR0XxkxwijtFedjgqdxsnhKsnmhvfS8VAx87x7AYzFR1Qsig6B
	TYtyxTrInw8p9803gk6UPo4tf9u4Z7ylu
X-Google-Smtp-Source: AGHT+IEfrJYNqPD8bm7ECaGcqp9j5cVS4QzAB3ai6dRYtgUFK3juxVos7j2KEu1To1ee28aD0zU47js8xIHquRQ4JAs=
X-Received: by 2002:a05:6102:3f15:b0:498:e25c:738f with SMTP id
 ada2fe7eead31-49bde2667f2mr19897660137.18.1726010961582; Tue, 10 Sep 2024
 16:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906195400.39949-1-dennis.lamerice@gmail.com> <87wmjj5gx4.fsf@trenco.lwn.net>
In-Reply-To: <87wmjj5gx4.fsf@trenco.lwn.net>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Tue, 10 Sep 2024 19:29:10 -0400
Message-ID: <CAGZfcdmg_tw7_aT9TwvdUg4FD6P71J8=LG_UvGRhAoNtJp6vQg@mail.gmail.com>
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Applied, thanks.
>
> jon
>
> P.S. For extra credit, you can go back and get rid of all the :c:func:
> usage... :)

Thanks for the info! I'll be sure to create a patch that gets rid of
the :c:func: usage.

Dennis

