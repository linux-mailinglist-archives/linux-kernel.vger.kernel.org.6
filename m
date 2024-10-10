Return-Path: <linux-kernel+bounces-358676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE3998257
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E6B23A31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4181BBBFD;
	Thu, 10 Oct 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqw3SfPg"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D01B3727
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552820; cv=none; b=c0jUkG3PNmXADZ3hE0ZyW9j8PyFszdS5Ms7n8iPyVN/Odb99sKR9pL6w4Su8htcNOjr7xJkfypGWvhblHvKTEYYtkbh3da6/ztnSLvSgydelFfDvbDLykQYZfzR9C7Ju9I53dCTy11NE4tbCLnKi4wrtXeFPR2/6uiju4KtiEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552820; c=relaxed/simple;
	bh=9g2GZgX7YLMTfizr3uLJ3YSM33EUN4l2EdYzFB7P/Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao2qhCFNbuaukkY4KfGBF02I7ZwgK7qt6NMt3DhDsdObyUaQdzBND0A/IT515hd5PXP5lT82YqS+E63L9OCAIN8KeY/dR8oKHFhR2gDz+Ugb2AcVBIlqXXq1dU8d8eAcOwnz0BdXc8DRcC3CovbRvs+jGjti5XNgjG9nyXalUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqw3SfPg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso859234a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728552817; x=1729157617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8ZN3sGcHFW5cNxDCNYw4XoVBsmt6TsaSDQA/98TMGs=;
        b=vqw3SfPgzp4NoN2ZoWB7a1BuB2ORuvLRJPLdD8w6A/wwSty3oR4Do5EBJ6iwsXzKhU
         iTihCQkygvoGPz6orjSj+9DbyOLxMpFtx9KS+dS37LWry4e51zWMjPp/wae5xs51EYw2
         9lbH3SbkmQdCHWBer+j6LdsU/T2NfarTx0yfkDeC7zbpFRAKtIRa9OG4sn9wOpsBjyqP
         pvFY//leuna9wO9yzYr2bFjVk8qh9iUKdKsNOn77TSeIixYSKBfNafXrAm74EsPDNAPO
         wE3LeBdBvkxqPb3rBgYom+7ZuMF/WTmnhpIW6qn7JgDfUqEexcGk+nUOrwquvIKWf4Hz
         MonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728552817; x=1729157617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8ZN3sGcHFW5cNxDCNYw4XoVBsmt6TsaSDQA/98TMGs=;
        b=f2Ay/Qq6Ul4v/Bkk4eiJkjTydKT3yqLfsTlyjIuZXM6VL7tOgJjJ3a9RBiDHK0YLgR
         oJFkOjNKdSEiouNAWo7xypA/A2l2RTJ5b+qLQ+79ycNL26HK8zH+mGX4MSBHjMbcCXEl
         vbm5TCJMMaZ37Pa2Y8gzMiOsUt+L0BDzU1bVO9rwp9U/Bp5w+cHDUVCg1J715rUTUGMX
         8RdAI7Ib7oa/YRs3xUyKLXzfBnumJwXatM3mdGiJfYcU6ilViE4z8eGBWJlM4tEtkPCz
         82jI2YhrI4ceYDleOY86tfpqzJjWJJRoPgjNp1UDFL7KLUT1vXpifUeZK/GL4xrAVj9o
         5CZw==
X-Forwarded-Encrypted: i=1; AJvYcCXWg/vRyVLP22QVyVAd4OunGyKpecwDDHzNdCykUZTTKbFkzivvECtrX0sRWBulzbx+oC8B/A9Kr9M58uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmlTFdQMt6BBD7tVkw1SS0o4f7d7swSGKmTLnbsd85SU13agL
	qb8an0mUdbbz0xMt+BA4MOyXuG24J1h3+97SI+rfEsIH4KI5Nj1RRM4rj1TMQ5KAdSmAP6K81jQ
	TpCbQkiXiR4HA9B7jc8HW1oxL75AqB0oJuUku
X-Google-Smtp-Source: AGHT+IG6f+1+cShAjm+Q/P4EmH5hUmriaWo+nOB8KCxL3gEZC5cUue+lZ847TKGtOySucv9TQcoW/3Agr6kYOY/k8iY=
X-Received: by 2002:a05:6402:51ca:b0:5c8:9f3c:ea01 with SMTP id
 4fb4d7f45d1cf-5c91d54d157mr3661316a12.2.1728552816698; Thu, 10 Oct 2024
 02:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com> <20241010090741.1980100-9-stefan.wiehler@nokia.com>
In-Reply-To: <20241010090741.1980100-9-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 11:33:25 +0200
Message-ID: <CANn89i++SBxvJzPb8Xp8_P6gJEaBm0M50SFB=z+xNQrmM8jVfA@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_get_route()
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:12=E2=80=AFAM Stefan Wiehler
<stefan.wiehler@nokia.com> wrote:
>
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
> must be done under RCU or RTNL lock.
>
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> ---

Please send a cover letter in your next version.

Please add a 5th patch in the series reverting

commit b6dd5acde3f165e364881c36de942c5b252e2a27
Author: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date:   Sat May 16 13:15:15 2020 +0530

    ipv6: Fix suspicious RCU usage warning in ip6mr

This way, tests will detect more easily if something is wrong.

Thank you.

