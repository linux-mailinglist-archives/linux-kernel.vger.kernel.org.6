Return-Path: <linux-kernel+bounces-408049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7059C7996
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A21F222C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535E200123;
	Wed, 13 Nov 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aVXR1PMv"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C2167D83
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517579; cv=none; b=uYaqmpE1uYHVbK15r+YqLPL7pk77z85NwkvcojN0WpXZvpwxKsow8NH7irWC5cEYLP0asjQkojcrbAMWxm+VqvCMQAKP5XH3noAZBvxurvGzNGZnTs1GmnYIz4vO9O4SJr33O1lg2qAMygFGDXIM13l4elBzMviCkuYJFWVPILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517579; c=relaxed/simple;
	bh=U9mSmdvebpc7SIfdO7D2vMyeVPrF3HfFMdaTvCTXFnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btaE740edLZUlKwuhK+PeYU/xGmZMFgex2lkjoSlFE9CU7o9AEoHWy9wMPtvqLcgvQPI5msuSBUnH+DvH+kK42NoW9+JfUH93c74d/WrrBtyWQCM6Io3cK+TGK4cA9swK/KFXb383AAyx8hjw9WTGhMCCIpl4wxIkD1z6jbDZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aVXR1PMv; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso6888142276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731517577; x=1732122377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7HNwvxjs7/kFqm+0Upt4VZLTejUABVboco4/4FyZBQ=;
        b=aVXR1PMvD8u0N/v5WwmtBrctnrDp5NkJvJ8B/kv7Lh+adIUE/fZ6FfGUjyqbgNw9KO
         36zZzwzrVG+hzunJiycvbqw0/F7YH0ivss9xJ21PUq8Hxk19ZNDYSZNNSb03nBOYzLNJ
         wP6xuGv1YlIPmkGqCTU/2Lk6oAt2g8kY4HsCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517577; x=1732122377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7HNwvxjs7/kFqm+0Upt4VZLTejUABVboco4/4FyZBQ=;
        b=JRJd7uFqgwHRhz51DNXwiLEj6V184xokwVMluz1Vjvo1iyK7/jChH278k2rYmK8X+2
         Qp568Dz2bikdJknT8qqK4/MY7okMN23NO1xAT1dI2M5JkaEuEYdKymueIxThJzc4aHYM
         k+Nt0fAfyHx1pkt4JOJ6TythH9HiRjVTpvXTnP5tV+EQI9/795ha4JB5vp9iQp+6xZj0
         rgio53V+9OCbgBRA0AAXC06wyzRvPIqBVb24WzCtolTfQ6rr0YO8OhcYoRnneNpKRpHr
         w6eW7G/gGgfRwN492fVskDXNWPSFKcak7KHMHq3bv1HV1aqJ7gXKFnQXi1FVSafDCz4X
         g2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXLR77un/7F0ULpK3RzgFG9vdajZK78fbjqdsyo4xs+fJjFov7VByRh9cN115SMxJynD+MX5ZNYhtWG+Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wHpCFGsUuBj/k8M3sPSOmr02RdWf+juXoGLlLlaIfN+Gjxfl
	jU9j8ScDGsCfb0qVMU22alYx89L0059+7Z8NRh2+WpA0rZlgZw5XMXeeO4jySEAH5I18iFLrtwh
	qKMBvHoLNpsePD/EwS7qT+zrVFF8SVZ9PjvtjiA==
X-Google-Smtp-Source: AGHT+IG3duG8a1UDQht/mWeuhARKmr++5c3TJaN8LKjjGCuT1HlbkFbDsA3tyK+oqirwuGtWZGK1XLeNQvJ3rvg3ziw=
X-Received: by 2002:a05:690c:6d0a:b0:6ea:8bd9:6b2f with SMTP id
 00721157ae682-6ecb32af35fmr39075867b3.4.1731517576775; Wed, 13 Nov 2024
 09:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113124857.1959435-1-chenhuacai@loongson.cn>
In-Reply-To: <20241113124857.1959435-1-chenhuacai@loongson.cn>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 09:06:06 -0800
Message-ID: <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:49=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> LoongArch fixes for v6.12-final

Hmm. This email was in my spam folder. I'm not seeing anything
horribly wrong with it, but I do note that loongson.cn does not seem
to enable DKIM, and that does tend to make gmail (understandably) more
nervous. Yes, you do have proper SPF, but in this day and age SPF+DKIM
(and a proper DMARC policy to enable strict enforcement) really is a
good idea.

Maybe you can talk to your MIS people about setting up DKIM and DMARC too?

Yes, it's a bother. But spam is a scourge.

                      Linus

