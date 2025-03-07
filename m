Return-Path: <linux-kernel+bounces-551612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F410A56E92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49C17A9937
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8523E336;
	Fri,  7 Mar 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVfPzsP2"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907A23ED5F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367028; cv=none; b=SfIEYNM0F8lV+ppFJi53YvK4XoQFn0Jaed2b6Jy5dPU3CLBMg2mg7c/ocOGeu/9db5UejFogX711nzYeKzmiR6/zPgjqA8bG+lclDadXWLYuI/1bm4C81F3m6KioftKLGNCLyO/2muIG1kscVm89kWexfcYQ2UoNWnBsyv1xmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367028; c=relaxed/simple;
	bh=dfiUsq9W5ls7h4Glcsz+kMz9CrSmoycX9lFyV96Twg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cotHo0TlJkG4+AVDsrfdmO/h+HYRWxL065kEaZXmE2lGOMk/brwmfh63uDqUvjk1nWGjYDt1l99xHlVYeW6whxC7O+tSEAXiAAhEcF0nY4m7J39WK1AojHnZ3JMUsYjAdA5y78WTbWjt0U4BZ8WHuJaVlNN6NI8+QdwFIxhYFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVfPzsP2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fb83e137so12499486d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741367025; x=1741971825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiKTsfH4WXXUP4h2ca4OnXKk4k04SEzwaACzL1m5raw=;
        b=WVfPzsP2zHFn5eq8zSHoacmEia9YRpYlTXE2Q9Jb9MXZ1A8UDKgp6+smpDpoUPf9ka
         ODmGj+13K53lfEShgbUwuLwIDWv+9j8GgGykY/KsQGcaTRAcNnHoxl5DVE/cXbF+rL7/
         W3iY96JGJ/r4rE3fQbS9w5LWXgiVjiwSwBSbIUEEVo3Hu2c/iiJ8HIXMn8Wx6+tX9fpj
         vHGvFFrtFgpXwzRneD0FuN1zyh3K4jcOOhddcyFJU1daE+CY/BUj8uyyavs04n0zhJRG
         1+/kDBKJNWCmMJ0X62c2XZHk3ySyUUojd+xLVI0V1Muh36biPDyVUeikg5lAQg74wMmh
         cF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367025; x=1741971825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiKTsfH4WXXUP4h2ca4OnXKk4k04SEzwaACzL1m5raw=;
        b=bIiZCmwen46wk6ijT0IhV1/qNNqG0NkamJJSm8yk3pzhZEuH1BmQ2BABOi6Vc/h9dK
         OW4o+FG22IlkqeXljji560ObINMcOb5qpyiQSByqwEDbT84XNoofyPhrQ0Jws4VgVFRt
         zlm1k5DE05YNmDqD4hcMn/yWqrovhqdbTeFr5vsJxjZbbENTtwBxadaLH3DAkZbyxuGS
         29rSfrrQTTFXSTtySWXY+obDNymR0xFqF71QmEkAgOiYrgt2CgnrvQIxVZXBT+HDFbrO
         m9X6Up7aPleaVwc09dfgubbYb9R93Qeui9FHafcp3aOhq0sKbyJ4yEcvGrcRig3gopga
         +08A==
X-Forwarded-Encrypted: i=1; AJvYcCXQBSDYQBHhP6zrvWuzUwH7+UQjgeQLb3PgAyfTzhkGEK5awoe8BEyyR/ANhMXDv472Hpljj51D2EVYZRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE69754sDPnMzQAPrsbeO18PIiLijiNLdYBKp0w4MCyyuh6pKv
	Cu1qPNY2Hf3oY/qvIhLU0T+IHIgwEGVCy7CR57H7WCRhbJuTtzaSJPcpz5zzRV1sVp6ra8niCUB
	QGxSO1SJicZBRZVPAtrPVvHvSCVw=
X-Gm-Gg: ASbGnctXa8miactUs+n4qOBvJ5gZIcfcXke3KwN6bzSNfDum25fo9cs7LuXGm8CxUYf
	eGNwjPexbkeaiE/wMn3fkd2OTh1kmnWGhNXRn7EzAjh0mWNdal4iZa/lRRN5z0pWt4N8LCQ9mwH
	t3YcpKxxZZcElkVB4Jb1i8vgjh107404yi+5LE1aisxPA+gE1Nc7YDfsa1cA==
X-Google-Smtp-Source: AGHT+IFDUByAKqeG8kqL/TqrXOQ3VWLLMyvQiLw5d3pGfsiCMMwZjVs1Ffmr17Euv9p8n7myqeOQBp4rksyFy+cpusY=
X-Received: by 2002:a05:6214:226f:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6e9005b6680mr47282826d6.1.1741367024662; Fri, 07 Mar 2025
 09:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306230015.1456794-1-nphamcs@gmail.com> <Z8oy0A-vBbGI6ux9@google.com>
In-Reply-To: <Z8oy0A-vBbGI6ux9@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 7 Mar 2025 09:03:33 -0800
X-Gm-Features: AQ5f1JrgxbP54B3olz9OKTba3hhi9h0SB_F7i4XiV2ykaR3qfQRC6OQNfCjFJ9s
Message-ID: <CAKEwX=P+Oh+a0Pducc9v1EGsGVG4vi1RT4xywkvhnnA2hEpzCw@mail.gmail.com>
Subject: Re: [PATCH] page_io: return proper error codes for swap_read_folio_zeromap()
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:42=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> > + *
> > + *  -EINVAL: some of the subpages in the folio are zeromaped, but not =
all of
> > + *  them. This is an error because we don't currently support a large =
folio
> > + *  that is partially in the zeromap. The folio is unlocked, but NOT m=
arked
> > + *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() wi=
ll
> > + *  sigbus).
>
> This is a bit repetitive. Maybe:
>
>  *  -EINVAL: The folio is partially in the zeromap, which is not
>  *  currently supported. The folio is unlocked, but NOT marked
>  *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
>  *  sigbus).
>
>
>
> I would drop this whole comment now because it's mostly repeating what's
> now documneted above.
>
> With the comments fixed up:
>
> Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
>

Ah I like both suggestions :) Gimme one sec to send out a fixlet.

Thanks, Yosry!

