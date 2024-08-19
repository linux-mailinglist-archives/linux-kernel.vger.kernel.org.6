Return-Path: <linux-kernel+bounces-292473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A0956FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0AC1C222DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC213B5AF;
	Mon, 19 Aug 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNDQTW/r"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89016D4EE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083926; cv=none; b=fIQRdTxs8vDKlfD/gzikJED9fPj5xHLd18K8dK9jmhzHMZ8XDum6xzzZdY1c2+8kXAadf05+zFlW0BOstZXghKnPTJVmHK7HPWRnxSx2QLxzxUe+3gEJ1CvZ2F9hgRCeDXGdgLO+urW9NIEKwJOGWKb57uLs1h7QiUpu85JMdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083926; c=relaxed/simple;
	bh=MUqAWJHd+rVkuzRALzYsOev9OsGlvfzYLJ8MoZr/O6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ig/YxUCbt9DKZaRRmS7g2WHOih3qsv+ZCaUw7A3bQ97zlcqo1HX3cK/p07BNXuJxXpcQwygKxSAljs8OCGEbBy+BYVzJlo9iEomWbiEmo5KN/UVj7WuKZ3thPEzSbEtqMH0viXW2pkrMV9eIjC1JccMLd4yTPaN0SCdh025tEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNDQTW/r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371936541caso2016929f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724083923; x=1724688723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QO7rOXvGcwG/xm+Vg7omaBPUcYU0DZnvYiHuU9lyzA=;
        b=zNDQTW/r0hYbusbHlaIBrWvnzHEtBA4y2dF52XFCblm4FhfPLmCRmFKHo30tFBMsFZ
         sXaPIhdzMmZhTnU4ITakClidJ5AppOQneQ7I2mvjU5Phf3DwGaJAg75ppMysSY7aXi9a
         aXvjqDnsPZ9MwmweWg7mjjA4CE9M0IQPhWilu/NvstxOzjjZlsqZzQeesXOc5FyU26yn
         3t+V1AzqAmJ9U7Y+tcQWWkYLe8AW9eA/X9gtSLAI9wFhdrHR1b6pzfkD9m98yRWkQM+X
         gZUg//I14Orvvp3/8VcSp+09f2WBtQ3sv2B27NMflAJUUvHcIgNYcA4z1tb1xck8EZeg
         dg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083923; x=1724688723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QO7rOXvGcwG/xm+Vg7omaBPUcYU0DZnvYiHuU9lyzA=;
        b=YKzlHoHfzK4dDQDl8tc55xM7E7YfXDOFdPg43fJ32kZz4YWWo2vH2eMhZSoCPi4kbs
         XKq6rR3CSp6Q5GdXy7rgdD42ISuTL9K5NfVWQ1mPgORmvGcM0HSB4DLS3mj7KSh3vrzv
         odae2X7fgTHK4m40seXj4wts4D8H+zoiYDvFChNDpHc+xmFEcd71mIYt2LSg/zU0XTfl
         XIgC8KesF9FA+iDGcFoZm++wnjiDpLYS9jvoCpanioFq+enA65PbN9JOIZBtMmtaL/3/
         EGry6YUX3MsQAZzvUEX9OEve7mvyoVJ9jm3DJyGWbzrlzdBriG+CFCFnQNK7ExPHKStO
         4nTw==
X-Forwarded-Encrypted: i=1; AJvYcCU8NiJPitV0tAnrpPwpc4bj4yadV27zjhcCzkuKcjYSb3/c8vITGM1CiTM+tpjK/RQvrBioasLsJ2FQu8RW09AgLM6AihDm4tJV16x+
X-Gm-Message-State: AOJu0YzjE18f6TVNmmwJneYcGd2ss3c9Zl78rtof6cZZZcXa+orqOYrl
	CKaOJXDn3e3c9g51qPRlqyuw8+s/zAkDswpuJ668671t6RhhsdwuG2ImptYaN/aNfpkN0W5y5Qy
	1SuyBpk6umlXdtvooBEmTfPWmT6pOMAUcWtOZ
X-Google-Smtp-Source: AGHT+IH6oJi9xR5/rkHAwmlPsJloUdfYD3FTZymPOtI9IwfcXJOFs8ZuhfzuvhPvP5Kq9vHrZzGJvPCtUqxij65o2tA=
X-Received: by 2002:a5d:4b84:0:b0:371:7dda:d7d9 with SMTP id
 ffacd0b85a97d-371a73dbc8bmr4733954f8f.9.1724083922647; Mon, 19 Aug 2024
 09:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <883bf552-f339-474f-805b-4355ef49e526@redhat.com>
 <905d6a3b-d0ac-4e5a-979b-40a49e345305@redhat.com>
In-Reply-To: <905d6a3b-d0ac-4e5a-979b-40a49e345305@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 Aug 2024 09:11:50 -0700
Message-ID: <CAJuCfpFGsWO+zyerjSwB7b0hyh8HYy4dsebe94Tqg0KqzVA6tg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: David Hildenbrand <david@redhat.com>
Cc: gaoxu <gaoxu2@honor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:21=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.08.24 12:19, David Hildenbrand wrote:
> > On 16.08.24 09:48, gaoxu wrote:
> >> Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfre=
e_fn:
> >> 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it's
> >>      moved to the LRU tail, it allows for faster release lazy-free fol=
io and
> >>      reduces the impact on file refault.
> >> 2. When mglru is enabled, the lazy-free folio is reclaimabled and shou=
ld be
> >>      added using lru_gen_add_folio(lruvec, folio, true) instead of
> >>      lru_gen_add_folio(lruvec, folio, false) for adding to gen.
> >>
> >> With the change in place, workingset_refault_file is reduced by 33% in=
 the
> >> continuous startup testing of the applications in the Android system.

Was this improvement recorded with MGLRU enabled or disabled?
CC'ing Yu Zhao as well.

> >>
> >
> > The patch subject does not match what you do in the patch -- at all.
> >
> > "mm/swap: use lruvec_add_folio_tail() in lru_lazyfree()" ?
>
> Ah, sorry, I read it too fast. Yours does make sense :)
>
> (mm/swap might make sense, though)
>
> --
> Cheers,
>
> David / dhildenb
>

