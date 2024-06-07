Return-Path: <linux-kernel+bounces-205442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D38FFBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1B71C23D07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E614F139;
	Fri,  7 Jun 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxik1tDj"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FB4204F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740708; cv=none; b=C5S6Z53T+cd5VxfkmN2EALLaM0HAtdrJ3sT4NyrY4aVdKRHdWbrwQHqCkqheHUpL64Qp/WupSxBqThdem2ZKQs4o/g6tQvur1mpnLY77hKrYvQAwkXlNyjzwPapsk+lCo0ncXp2XN0baoH+Ic97lKw+iaEzYY4qXTdTXzFGM98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740708; c=relaxed/simple;
	bh=LuSmB8ozvajneAVBdQxHqE6xooqWC/z2zTz7YCvdOTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTU2c8P+5iuYerxwBBv1HMX5lbagNq6gROsQWYQ6+4FFgesb526fK5Yc5PymxKlZkXtGYeuz9hPVcnjOhlF2T3c02I6NWJSkz9l1cr84V0HLd3IMJEBnQ7pMxP4W87Zb8Zsky/XpIb4tJtWPmwElBeKGMQQUK4pH8sBIFKQUzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxik1tDj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4400cc0dad1so230151cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 23:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717740706; x=1718345506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsZI/xHYSQm/+dnfipss02DR7ScDWJz4B6NrYN28zeM=;
        b=zxik1tDjvL0fsKzmMyE7EtftQsuV5c8fDrG4bmMQZbUHx7uFRJ60/rybmsIUDbU9t5
         t3YgWytpqe62QqxYpVpzKeJmXJ4KAqwrdlogQkJFL30aJ9dd0b5sp7sWdyb9hxf1eLfc
         /CVGVw/1fo/+V9Y5RnvmbpP4gn1onKolmnsVxdx/3QwtCJtuqHJouBGjlFnJUES70U9X
         OjQC8Xyr8lb3pZD0xYVGvtvEkVqOvKLnk0O3B6YrP1BRRnN5Jz/hZYqobN/4gi3AsXtH
         yJ1XuU6j75mIaPXTs/6WmJLWLtZoiYCe04I98eB2nsR0LJLv84IdCz5VnHvOeOBACPqa
         VyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717740706; x=1718345506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsZI/xHYSQm/+dnfipss02DR7ScDWJz4B6NrYN28zeM=;
        b=QSAlf/KUQfwB4vniqeYl+3irGilwNYHeR5nhyc9B3N//zZcmtMj3+Nnk+m4SwUl7GQ
         b1xgZ9oOZEiaWta5qd/+vZcFpl+G9gQdmj8CClSgYniouz/Zy+prKZ/CrQQQjEBP7BvW
         lj3rNgrzbnRXdVLL+tVA3eJF5lLxgSSvRaJQxkdO8Tv6FSZuySG0AnxhXh2B0NIVYOxO
         IBuzm/DzgLk11gI33hjeeO9qREAZ642zWJ+g89j3e+Qyw9jxKcPReiTt9x54Zme+BSxT
         qN4kaJO8unnhyF5lQISiu2bamLvirZQ2z9+gJIQ/U9IOoroDl3UUCBh3udlwFiCbGWhT
         wfxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrpk0td75k8w3vSZ3BvMNnhCljch9swg5/QBmOkQQy7S0LXM0cs3TwUnJsOsjnO3W+q37yj14HvH75YqnGfo4SY7wg003bY1XQM3BI
X-Gm-Message-State: AOJu0YylSkUqqo3z/pzaRKY9bhHlM/VIcSVK0zJOye6G5lRR2uSxa2SR
	nx/TxetVCRrt/T3Az8SI+CN78WF0sqkMoNIvDeYwi+S/YH78uK2lOxMtyYp2Vo3oPYwxMw4fWu3
	1udUVjwGcxoJPtSLu8v68Zc3IBtQcfhiDZRHE
X-Google-Smtp-Source: AGHT+IHIGntdfVER17jbc4kETFkRliSQf8UfFv43Za9kOG4EzKX6QZI299z1mCNGrB6uQfkliufbSyrPWQ/1PA9ZFII=
X-Received: by 2002:a05:622a:6104:b0:440:2d56:488b with SMTP id
 d75a77b69052e-4403726cbe0mr4901381cf.14.1717740706174; Thu, 06 Jun 2024
 23:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606124816.723630-1-aniketmaurya@google.com>
 <3c6c319f3aaa60428fd28f4d95c71dc9a8150081.camel@codeconstruct.com.au>
 <CAMmmMt3u=DB5onXdayMN5ZHvCmdnam4wOo0hKizve4K0LnZLZQ@mail.gmail.com> <3decb5293cb8fb2e8725600a8c5c930c32178602.camel@codeconstruct.com.au>
In-Reply-To: <3decb5293cb8fb2e8725600a8c5c930c32178602.camel@codeconstruct.com.au>
From: "Aniket ." <aniketmaurya@google.com>
Date: Fri, 7 Jun 2024 11:41:34 +0530
Message-ID: <CAMmmMt2guEx1jajb2NC0iBnMGpkd2vaSiXg_BqgZhwrA=FARLQ@mail.gmail.com>
Subject: Re: [PATCH] i3c: dw: Fix IBI intr signal programming
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeremy,

> This is more for handling IP configuration options we may see in future.
> For example, I believe support for target/secondary mode is entirely
> optional too.

I was hoping to add support for target/secondary master, we might have
different drivers instead, something like what's done for i2c-dw drivers. But
that's a thought for another day.

> I think keeping the mask value locally would be best. this means we
>
>  1) cannot get the counter and mask out of sync; and
>  2) don't need to do a read-modify-write on a register that is only
>     updated by the driver.

Sure, let me make the patch.

Thanks,
Aniket

