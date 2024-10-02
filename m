Return-Path: <linux-kernel+bounces-346903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A198CACA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F740B209B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6B63CB;
	Wed,  2 Oct 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANB83mLo"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA95227
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832335; cv=none; b=bzfjl0jnmo96F36atsM6pVvAQPeBf4dgUB6f7Eq+EtJ5cozOLK7qPgGUVtmbCjeSgncmZhKTvF3ZbDSPEKaii2UvnNpq9VR8M+O8q5sCMe6/2vGK2T2J56esVuC92WdZDXKDLgnryjBLLUQ1eWTsuHSG+8dtH3BP14jGk109mMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832335; c=relaxed/simple;
	bh=mDTzs8Xq43Y8ZkoSipsGCaSQrrFdFhMF8NlAEZw3ZKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIJejvb39kTsl4pn1P6JiOTIP0pbrUs7jM9IGL3MsmnNdRhHJiRIuaoO8iqM/4Ymb5mucLeWS3EcUGLGPAInbYx3UVaC1UD1CCY28FwDMO7x1STVlZm8Wiao6YJPzgkqbUTdLzDenyckTtSll1wMsnI6xnfcc2DY09PSoWZ1fFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANB83mLo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c548eb3354so50351716d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727832332; x=1728437132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDTzs8Xq43Y8ZkoSipsGCaSQrrFdFhMF8NlAEZw3ZKE=;
        b=ANB83mLoYmTP9ISePKxBLjPuk0I7T+bcUwFBK2HYo5Zvv+lO3cx+FXSAvHuy7Chvt5
         mnLZjY68mLho5kIBMbC9OqBgUYIhLUbE/Vx7tI2XuR16xZZ63t5gLzmtLAHDIgbTbIU1
         18tCc9COmxqMTd5LI3mzX/XxELn12wfe115luXhtr3wO6hNqXsW1m5yXDe0OfVZYnu+z
         SgMO63qgKXI+a6RFRRExxrqOvs5a7xWUBFNaMs5jlRO68jLj8CsH7jARXJyxASFjbNWw
         cFdt4T5jpvJ+c6bLKIjuqQAq68oIh2ZymebDVjCgiVgL6NQ3Im1zSXnDrutR6HKNPGke
         Z+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832332; x=1728437132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDTzs8Xq43Y8ZkoSipsGCaSQrrFdFhMF8NlAEZw3ZKE=;
        b=CeTdluebF5iggJ9NertKJTCVvwVl7x2zLa+pxKcV5tinasr0OHY7JQ480movmh+vJc
         qnhpM59KOCZaRmz4mPT+dNlIF1RgiB0HzPDBmUmg4FvgP/k8hZMbw+AjpHRypuQqh+RO
         TKV+zipWhZSs+ZMa85m33my64mAmmYC+xbPluHYRavSUmrRQPv6R3xvVh0M5nIyxiVGV
         XKahrzrZvhS2mSDHnJZaAUMCKZXR1kQHpzwVWF6Udjzws0Yc4LPNiXlBD3sQYcVpH6Wa
         oz9oawSob1GlFseZsj/5yYIwZfK6yBM+3P+6ZOEFME7LfYg6TjA3MiFgSs7GEE6tl1rJ
         cekw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/24aWFGzaGeRZ/Y7S/utch7vm99aZd0JuXTceBG9Gj342F5Kn2MjJgpx9MTap9B9AOUPxdAqEm6iJP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnV+Zd7qb44uxLCvh8pskTZRn9x43Kx0K+4jqe6CCvsj3/lHzO
	JwUA4GnHIQjAqJYn3Q4dpbqhyT0yjUc/9YvWu5pQtHTjCiZ5Ch0iZ7XUTJE6hGfJvN1JthegJTF
	ienzLoLBJe+/PyZ+/DsqirlrD7yo=
X-Google-Smtp-Source: AGHT+IHjmJNqB3J7KchL49VjanqwnFonGm1Uuntai5myBMvNecYUW4BQGaTWFHbYcnVzZgs9nQKC3Ee3Xb4F+Ae2K4s=
X-Received: by 2002:a05:6214:4801:b0:6cb:32ef:d55f with SMTP id
 6a1803df08f44-6cb819c7ff7mr27184766d6.6.1727832332609; Tue, 01 Oct 2024
 18:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <CAKEwX=Of2U7x+KHikU5p94=qL5VeO_JfysEWKz+=VR3jyq0B5Q@mail.gmail.com>
In-Reply-To: <CAKEwX=Of2U7x+KHikU5p94=qL5VeO_JfysEWKz+=VR3jyq0B5Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 1 Oct 2024 18:25:21 -0700
Message-ID: <CAKEwX=NXs9xurOG-PTK6-_-1LGrk0rzOLtKUipT3Q6HvWxp0Fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] remove SWAP_MAP_SHMEM
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:22=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Hi Baolin, could you run your stress program again on this version?
> FWIW, I was able to trigger 64kb mTHP swap in shmem + no-fallback
> swapout, so I think the issue is fixed.

Ooops, I think I missed Baolin in the cc. My apologies.

