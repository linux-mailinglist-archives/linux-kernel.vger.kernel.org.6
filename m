Return-Path: <linux-kernel+bounces-315276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E896C04C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42161F2687F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF61DA635;
	Wed,  4 Sep 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xep+shN9"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84441DCB38
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459799; cv=none; b=jkQVmfK1/0Q60nHas3CM4FUJQC61oUFhUKjCZPKQjnNYAkJ2IkFaBeLbkEE3twKrElFF0QrdHtnIYaRYDegj2KD0RfVV52WRB5BmJ7o0/MSi+SOXNWKGuJr4djL+H0/Rv2UKu7TCk+twYCZD4xn5nJUuuJOX+AUaV4bQ3dMgwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459799; c=relaxed/simple;
	bh=uHWFMjkXthFKkwc21Xfpqsjb5Yk5pcnJDRm1kauOd9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXyZX4SJqT4j3uqvGxVlLMwDc8nBZ4WV5a5lKzlAAMhBViq1g2QnLxgvMTxXY/4hWXbNnr7N7OU6XMXAlMNQbDlJBOOi96UeJN2WAwv6t5e3tpRSxKXD8HU15SWvTBi5tsY7DiPBmH8LZw8vN4iJyt2KPYnrJbKYQ3XWpF3w//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xep+shN9; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1651f48c31so6988602276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725459797; x=1726064597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m6Q3XqGIlbZjyYooay9Pnx0IaHEWZeV5bCVZM3wfRk=;
        b=Xep+shN9RaXKXkZChCQ7QnpiYt6KV6+UFufseSbDKtKr6Df4egiNpeLrfjgj75AvSQ
         vscebkHJc+VeTpGOIoRlMG3nwJWxiCLKuYrJavstN7aeEFZbSrM9f/nfrCxE/T3BQ5WX
         S7daaVy0np6p4KBViOGnKdk2uKkD6Iw6uUxfFXr5h8oMbFidkctKfF4UJKbciGM19BB+
         SMeWR5AvpqBs3BoyTP0OzeL2HmcCqIDzm3DvxvYu+l3AHKOoJfH73Xi40mSFGdvNvMES
         NWmD4ZlrLcCGIhYBqEJDfqlzz/EBECzj9KKPXKLJ0Py2XCHBhSeeJyh1BfFwwARd/ZFp
         L5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459797; x=1726064597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m6Q3XqGIlbZjyYooay9Pnx0IaHEWZeV5bCVZM3wfRk=;
        b=r8F6QNCNIq6/fjZLaRaNiSFziPOycfkYlxlzsxxvp+6Jxj2iEchmP+yA3slmWjtJd1
         0eLTcVwABZIT5hvUDTDtxMFAegNJGu4RXjMHm62Z5f9TW8K6T9olOgJ7krmEwReKnO/H
         qjg6Qx2Z4CsF1YufXn4C3mHuCcTY89/SJQDkZpg4jleBWT1qjc4+olfiWIjeyqw98rBY
         TeqSxZSWWJWnDhsI3HKVrCilGNHDkSWBCkT2JYP3Ebkq1fiQYMbXL/fplgPS1aUs8uQF
         /0EIBIivLJYr62kXzFDjM+gRj+UYqvHHP2HMv6eQciwvWjC4q7bAOxjWJRGQd0YLOTVj
         fYiw==
X-Forwarded-Encrypted: i=1; AJvYcCX7LIDgKGFuFs75fojHILVKJXEeT3gE8BkASPa2zC4cYh5YdYLwqEUlJs8bGLp8CSGXSRWsC7x0TVpPPJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Kyjby3o32QpGQ1CjBPL0c+rlYhQ98Z5wUZHDDV1yH7VACTW5
	h70EsXnBcJAhPASgB9qRJH5r7xNGWSSkmlTYtZVVyzmCHo8us3QsTekcAc8KPDuytyWvF8ekLuC
	2mXD5EtGqpXuQDbGomHwV15Dt1wXOJdzut9YG
X-Google-Smtp-Source: AGHT+IFB5F7DMOWkLKCfWyKdUy8S7YwDbSHdcIxU2ngKOEIFd2UbeJ3ymRqS0hTytMC8ghB8E4xsO9iWyWM25xE8Fhk=
X-Received: by 2002:a05:6902:98e:b0:e1a:a2cd:5d6c with SMTP id
 3f1490d57ef6-e1aa2cd601cmr11495199276.56.1725459796711; Wed, 04 Sep 2024
 07:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
In-Reply-To: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Sep 2024 10:23:05 -0400
Message-ID: <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me, 
	tomoyo-users-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:10=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Until 2.6.23, it was officially possible to register/unregister LSM modul=
es
> that are implemented as loadable kernel modules.

...

> Paul Moore has commented
>
>   I do not intentionally plan to make life difficult for the out-of-tree
>   LSMs, but if that happens as a result of design decisions intended to
>   benefit in-tree LSMs that is acceptable as far as I am concerned.

Patches that add complexity to the LSM framework without any benefit
to the upstream, in-tree LSMs, or the upstream kernel in general, are
not good candidates for inclusion in the upstream kernel.

--=20
paul-moore.com

