Return-Path: <linux-kernel+bounces-353302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D4992BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8069C2812EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430D1D278C;
	Mon,  7 Oct 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qgSi7B4R"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226EF1E519
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304548; cv=none; b=Vb3LhIXhmjj2Kl1VOqf4k6joi7slQze1zOZPrb0cA6PVVVnd+yykGq2s12W3ln2WcfRvbSDjEQIAmNHCiUyicuXC/d65NizuFM5nhWBDzFoYa82s4LHBmW6gFyFuIYK8fVAMAcrs7OTaaZHAOM2o17bnkqCsKrQ3K4gV7hPI+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304548; c=relaxed/simple;
	bh=w1umpy6jXToZDVxKpGcGFXq9OzBf72ZHi2mnV8uEt0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtqxsQ+Oyy26GOW+v1GgHx1npbM+jncf+3YrZihZLS7EdNTkX26XmpAuYrHcD4vqRUunWErAU2qNkFBfTr9Qb5e1ci3GJC5VT+Br9WvaK5xSxCvBbdRPQODbYXkiERqWRAG433dXzINDvjdKc0dC0IiwaFCJnhfHeMf2q1yX4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qgSi7B4R; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53995380bb3so5154496e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728304545; x=1728909345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w1umpy6jXToZDVxKpGcGFXq9OzBf72ZHi2mnV8uEt0c=;
        b=qgSi7B4R5AlJ1ef/aGPAh3oIbzd/cZND23E+6H/xC5KehXodV0dGmwg96ZLBpD3Eqn
         SF6Wz97z7r1NtW3+xSrSqIGC19rqcIDrng8+gOMY/xGZbuMMGu4DOl8UlLgyoB+yBR8Y
         vufW72vJGXNaNV1HG782GFVa0UL0qqxDJiD60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304545; x=1728909345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1umpy6jXToZDVxKpGcGFXq9OzBf72ZHi2mnV8uEt0c=;
        b=IPnaiHgVasWrFzbVy4wOn5FXCxg2FD7upV9WRrkRjkVP6da4EqyDm0Fbj3LFNOEZrm
         x7aEHyq9UFCA2yg/ZM4Aof842nIzk9dpUFk/HpTZq53SQiDj48WgbfZ9ncpLOaBvzg+E
         0nwTZlLLpnwiyXTAf36ENltj/jTyHNIsTg9fehzgxwvkkEQ70VlGAEaeZWHWJUCG4cza
         wIi9lU94E86sXv4CiCYRlfK9Cg6Xk0i8ylUSqU8SUw4IXBxl+Il1g0KdjC0MvqkBxKBg
         MzQzbto7oQZonIaXZc7ZNQjpRCq0hdk+gC2s9JVYADQTabJpNuhbZV1pm844BBvboboU
         2VKw==
X-Forwarded-Encrypted: i=1; AJvYcCU31RfvZ+myNVcajVYEQ8QX4ziHszxcahQymz461PzI7+ldyYhiLezX/okXCDkC5DvytZxrWwwgf3G4T2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmwOtEJJlyBKe5sdmiYZU7bvaP3RIWJW+PbJ5bl945J2KTxaK
	hK7CiqIi/TYatLIRAeQRGJoSuGaqHGnwZ0wtTLI3CS73QNHrShgbOiVVN+N5PATDnfS7EcW2SnX
	gIWzffPRudo5oESmeCA3Uq0oiRs+PAEv35Y6BsA==
X-Google-Smtp-Source: AGHT+IFN/63kduzVL0hs+1/wL01jUFIDJcPBzbtC5mFPviEkspucyY5LG6IIVBxMd3LfgP+Bkr2TWZ3QZJTtg0gkRuw=
X-Received: by 2002:a05:6512:104b:b0:533:901:e441 with SMTP id
 2adb3069b0e04-539ab85c04dmr5508241e87.10.1728304545111; Mon, 07 Oct 2024
 05:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <efc65503-15fd-4f8d-a6c4-b3bacb7481cb@linux.alibaba.com> <20240827115252.3481395-1-yangyun50@huawei.com>
In-Reply-To: <20240827115252.3481395-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 14:35:33 +0200
Message-ID: <CAJfpegvTm-qniu8OOY2Riy-0xFg2=wy3ROOcrLkQ2hcZCzKgMw@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter
To: yangyun <yangyun50@huawei.com>
Cc: jefflexu@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 13:53, yangyun <yangyun50@huawei.com> wrote:
>
> On Tue, Aug 27, 2024 at 04:30:04PM +0800, Jingbo Xu wrote:

> > When the size of the user requested IO is greater than max_read and
> > max_pages constraint, it's split into multiple requests and these split
> > requests can not be sent to the fuse server until the previous split
> > request *completes* (since fuse_simple_request()), even when the user
> > request is submitted from async IO e.g. io-uring.
>
> The same use case. Your explanation is more explicit.

Applied, thanks.

Miklos

