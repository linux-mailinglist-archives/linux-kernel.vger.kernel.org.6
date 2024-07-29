Return-Path: <linux-kernel+bounces-266367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C606A93FEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E387B21EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCE1891D6;
	Mon, 29 Jul 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hug8X5U8"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7643152
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283891; cv=none; b=qpiIoLONGyrKC8ROHgimcpxQxvZdOtjT2Q4BHy2q1kEeSgcPbsPYWYrtipTHZeyW6ET7DcmZLggRsog3cyTW1YMUEqbdDFq+70Z/SlzKCxl1mELvc5I3LkP2RgKJh66YagzvJlRbruAL/+qCjbYndzwcaBcOoJmHn6TSIBxGlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283891; c=relaxed/simple;
	bh=Us5cH4p1DCLdO3IJT0XAkOggiA7NrSukIU67HcECGrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmj/vJgVuTpwKTgS1Xu87brZ3Pbtwefa4M7jyboNBslYObQd5CmWQW2WperJ1kforxhuXLnaIYylB3oYkS6eOk4Te0o1VvraWmfwypHYMdRH0SC1nP8JFqmr98LK80EW0+eCa4wzbBLGI3l4MdUbL9HDLlatHoHiL7svWdnTjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hug8X5U8; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4928d2f45e2so771450137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722283888; x=1722888688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPLL7oK5NWSnf3Du8VFLvWdadYL/N547QaYJmd35X80=;
        b=hug8X5U83/kCw3AjS02eBjw578isMPFslhR4LfyGXZgwp1uvXcHcaNotAqchdlo3nP
         dus/wmbGrpDg9KBiFMLBc9wrC4u1MRnpRcgjVOOPIV+8VBjoR9Ns/xUgkh8xfGCIqvdm
         SMViI4r9eMjxE6A4kEANw+2SXDbn6kthP6Zu05xwZ6el0ImBUTDgym4p5E5Tl8PUM6Kh
         Ibv9FOs+G6GbNV1fFyPmWjWrFr5zapyIqFNoDc4hkospNcxaz5TXOkm10OGrdn8vDjsT
         gi+qmfCJN6W2gNPmRmoM2tZIQ04AmYVioxNxxlvb7/aOdRuB6JrU+PgxgoON3b2lOq14
         ZRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283888; x=1722888688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPLL7oK5NWSnf3Du8VFLvWdadYL/N547QaYJmd35X80=;
        b=hovuHtsPSbEdjovq/8BsuNhw/i7i+GQXl7PFvj2wkRNB0dJ61mqo3RLcZElqsQ19t/
         jAxxHFbVpO3bURPwiGxsOgu1tz+QlJUjEaWI3eXjGJz8TicrAraYJJLM1oabFN0S3hoV
         bkJ6Tsbxkb+1OnCZFo3+HIursLadn0Vbo46zFoRaWXMybJPsH2GJ+zF0xQFsTLfL6pgV
         RcD7UzUg+UHzKiMCQ1U9ZfHX4I2C8ka/8IbbJ/lH/JT4RIUm18eYKaJUwWALN8oFxHy1
         PJWpBhBtbBQioFvyrFu3/EdsAeWK/CMiMz3iggQes+uvZA18OvjLDqQ6zXOPvzVyMzct
         J5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYVK6kaDD/INeVaKqCcihQybt97e0sPG0ZaxTuEC4Dwse6bYAh5mORyNCHUXesJp40cepm4E3wRprnBXKPh1zakVlxyCjxdObUD+QH
X-Gm-Message-State: AOJu0Yz5mKs81YzFXk2HoxkBf1hYZ+6XO8hKrUmKhzh7xUdy2Cl6O+97
	zM72sZ3I98cFJDrgkI6WFkA4LX4sy9Zr1sZ/HeJJ69Llyd1xSBOsFSXNmV5NNVcA2Oj/ptkVHDt
	KxtUaHrvffORVbN0FZfWOsO7nfwk=
X-Google-Smtp-Source: AGHT+IHd+nBXvg6pkdA+BF/xs2oc5XnZGbHOsQZcL7cT6AxlgOvYwlNzjIsDUCBcU0+re0Ax/kHIWKPT3WmZF97pqDE=
X-Received: by 2002:a05:6102:944:b0:48f:2afe:88f1 with SMTP id
 ada2fe7eead31-493fa1e8642mr10606701137.16.1722283888443; Mon, 29 Jul 2024
 13:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org> <Zqe_Nab-Df1CN7iW@infradead.org>
In-Reply-To: <Zqe_Nab-Df1CN7iW@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 08:11:16 +1200
Message-ID: <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	ying.huang@intel.com, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Jul 29, 2024 at 04:52:30AM +0100, Matthew Wilcox wrote:
> > I strongly disagree.  Use the same sysctl as the other anonymous memory
> > allocations.
>
> I agree with Matthew here.

The whole anonymous memory allocation control is still used here. this is
just an addition: anonymous memory allocation control & swapin policy,
primarily for addressing SSD concern not for zRAM in the original v4's
comment.

>
> We also really need to stop optimizing for this weird zram case and move
> people to zswap instead after fixing the various issues.  A special
> block device that isn't really a block device and needs various special
> hooks isn't the right abstraction for different zwap strategies.

My understanding is zRAM is much more popularly used in embedded
systems than zswap. I seldomly(or never) hear who is using zswap
in Android. it seems pointless to force people to move to zswap, in
embedded systems we don't have a backend real block disk device
after zswap.

>

