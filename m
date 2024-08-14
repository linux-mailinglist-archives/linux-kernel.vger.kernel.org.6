Return-Path: <linux-kernel+bounces-286047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3E9515D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D29285A11
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4D13D51E;
	Wed, 14 Aug 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgADI9D+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969713CABC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621701; cv=none; b=iCZ9yK7VgzNg6pB/c4b0xrZFTPwMPD6Ufyt/zEnLQxJoF8nlJyAINWewZsnQ6oDl3ngP7pHfL3ZDu5Ozl3V8uzDNjA47ted7eU6gwbGLMd+pbUgjkxFhPSODGsNDBKi8MB9nA9xF5qUcr9ENG1wj+Jbuq8kc13fUELTzhRWXcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621701; c=relaxed/simple;
	bh=JZkPj2Cj5l6KrmXL0vbqvyYLl7gc6iX0WSxoSoidQqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDyFuSwgxJOg5gw7F24JZjOZm7jBmHPyHVnze26DtKSN7J00mDgukxWKbUO8hnPivb2lIsUBEov4EvNlMHTrwio2GNyUwKTn8VNiyiensJC1+7fiyR9+NL6etw+lmXeJCgd/JzKPDtlkVX5xudhPEFrUxEzz5pZOVkYr/AWXPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgADI9D+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so991838a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723621698; x=1724226498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZkPj2Cj5l6KrmXL0vbqvyYLl7gc6iX0WSxoSoidQqY=;
        b=fgADI9D+gR5x2mh9GZg64+hbX+ciNIADAOttC/YGkaJG6Lq04IY64kqr8w8O2skpiE
         KSfPlUv7HkwCvZZES44knERJASd1J22jK6f8V9S+0DdvJhfWqCS6BjmFsnpNA98BVb5i
         tgXedKmsbTdLIgrEHC81vWQ22WR5eShRSMmD73EwNKioOJiXsCImJVPHqUAKew8Mr4VN
         Mw5j3SJNr2VyrU+Eg7pFwdh8dEzdyl53I7RD6PzhvS7jedtTWQBEvIARruRCc+GtH+5r
         o57cSqmzepEy7lgPYKU+B8cWsYifeN/r26XDzHjen1geVTQa3fWbelbP6XGJxFHXWFBc
         yanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621698; x=1724226498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZkPj2Cj5l6KrmXL0vbqvyYLl7gc6iX0WSxoSoidQqY=;
        b=Gbsnv2J1AvGHhkSyrhGBN8T1EJz5HQNIR0LoOJVPcsF496MBHl5/79oTVK951Cd/rD
         Ib7NAR8Q+rYzpR15DrAK9asTMzdANNHMBnErLuzVfD8NLZcoc3LIb1KIpiAzSrnGvoNK
         1lEo9M6QaPWdy9qNbHGA7VUObfXacVHJQSSVCkVZXpGI3uF2jnvRYBwvwpzmIdfOh561
         pPlyJMf8d4XHvobYwPtPr93YQ62+p5hzVlZM+IOaAaFoPhSMiAT6bZdjEHgMF9RO0Khx
         P+3pNRTOlCUvhyyfgltVl8DW9e+98/3US0zv1JZrpO0heez8iAxwy4bZKi0lnzMJnzwb
         R7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUjNk+XPqYjR/1WmOAVWiA5zS6R+rKHvZWTmMF6dFZRtHpibCyeRmHMMTwNYJbEqfszTtbO/eO+pWz5NAqxm4rohS6cMml8gfpWReYC
X-Gm-Message-State: AOJu0Ywvst4bBmFnjuIYcWB/E23qbtje19+BPXrgEk+F+WAUIY9EtN2u
	ueFV/f7BCBPXficJJp3n9v6NviNbK8AI9dcEUQB0msyS+oNnNpGVNbFOeRy8VOybWXiBN4Kvk5y
	3DcKoDTUoczdN9IGKZ1l/QawHGmReCBtvdeu0
X-Google-Smtp-Source: AGHT+IEw0FWddU2VM7FL4SB4ziEIiea9ZyXl/wiMmVamK8vTcv4llrjwTmWjCDjcfsY7rSUg1pZnLpq0uxNNch7PRO8=
X-Received: by 2002:a17:906:4796:b0:a77:ab9e:9202 with SMTP id
 a640c23a62f3a-a80f0a778c1mr394590666b.4.1723621698031; Wed, 14 Aug 2024
 00:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
 <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com>
 <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com> <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
In-Reply-To: <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 14 Aug 2024 16:48:06 +0900
Message-ID: <CAKD1Yr0SkjAKLpsvRw9J82f0vHfqLv_VTFQjtZvamzJ7jwVcHw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Xueming Feng <kuro@kuroa.me>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:43=E2=80=AFPM Lorenzo Colitti <lorenzo@google.com=
> wrote:
> though unfortunately they don't pass on unmodified kernels (I didn't
> look into why - maybe Maciej knows).

Actually, they do: just git clone
https://android.googlesource.com/kernel/tests and from the kernel tree
do path/to/net/test/run_net_test.sh sock_diag_test.py

