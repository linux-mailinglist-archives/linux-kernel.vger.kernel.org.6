Return-Path: <linux-kernel+bounces-364861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FA99DA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E241B285326
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63C1C243C;
	Mon, 14 Oct 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Gzsn8B0"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA91E4A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949665; cv=none; b=n1bbGiPvsREKDMWpWYbJBJ64RsFzxFKxPWvUiOrdUTgWU52sDJ667G3AvCmHju9tsm86Ls3t3mYzqfUNdqvNSV77BHuIUygaL1l7W4vdY0Q/GTtC+z7XU0KWLRKAZ8V0yobQgoFHtFWq4E99U/0fyyE3yvnQynegLmIHXnu6vZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949665; c=relaxed/simple;
	bh=HfyQqOu88Xqk/Fj8XROBrZVNUA+QhiWptHmm3U0UJ2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAwje2/Vf8O2WTSL1XObojhLpZYI9qVdWK+7S/5R/yIGoGAcaDJI8SBGBa67+vtMC3EgkTmJ4GQd8QUfH6buyj4Cq0cXg2Ute/ud5EOvwQBFj/xontooe4A0v+ZwsiGXUfPNAyhe4Ju9ZG6mlLavZog6wohp8vTybx3SMSzxKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Gzsn8B0; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a47dc2ef46so641858137.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728949663; x=1729554463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4B4kN1k4jTmj8IgEJwW1vDAaceerwdCVOF8d3ajOmg=;
        b=0Gzsn8B0aQHY+ir8seHKARy8JrRR6TWzbTKTuSKRHdZ+vxYhFzportr1IIhmRMSV5J
         vH8dLo4MFRLhsKT8V8Cb5/VULMuEewvaNsG/oveFBcuG5mCxR3RElDL0+QiAB2F5hHhS
         2S1s5J/Ts93ZFEku0M/zIZpdSiaZNeWdryVHVzDr5csKGVzZUARkztL6bNMDki0yZMeh
         aw+FHBdNOeGJ1jQDM2PVDqfns8rfwsTJRR9SvPw7S0PhVj5AnMIfQ2yYd+iS8TmFNCd+
         NDPz4X9oyIgIUzd7TTEtIv57ejB7r3vWhVg9S4gLlTNETr1H9XogWDWsdhcktp975zBV
         0ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949663; x=1729554463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4B4kN1k4jTmj8IgEJwW1vDAaceerwdCVOF8d3ajOmg=;
        b=eMN8vYs+2CtnzIrNpufhfYB85NONKcfNAC3TSpBmsYXPF+QzR5imAK97VBRBMFzDbO
         RSjHsbiOl3Oa8bmsJ96+5qsJk9nyL94dv9JO40FsaqVxbBGBZAUx5XN1vK6SGAcJTeT5
         O/Ix48/qL+J1v5SK5i1e3l1JaP9WvAV7UoZx+DHkThXKcCkUVDaFReqwxtdXhrKycbCv
         0dLfdFIdOWpK5QW3sQ5DZZMKwHFImFu61qWJKVpwHRGwSNvJgHSaJKZO2KImPEQuSl4k
         InpPm+lKkDrQmdN1n3ag0rjQGjDCOaqQBwGOww5tjreMeGpN7OZjgO5hd69zeBoJb7bF
         Jk7w==
X-Forwarded-Encrypted: i=1; AJvYcCW+PK/oC8HuE0oEyOg7MSuxmc1ciLYrIww6fcLmmrje7kOtmgYxEmSYstT8fA7j6l4KazNSAs0SeUmj4q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wsT1yqeYMRtNO8YEwonppmQgXPJEWDjOPgU+YVFqxiCE4YVg
	dtS0FZhoFAOw0ArDwRu2yaKfELCa4zvV/NTlC2RxJ8pyjZneoB+3A8scsFBcWnE4RMe5AZk5VWq
	dJI7vlGJ99AVbicQnNxly1xTKhdm5GKx+pE5D
X-Google-Smtp-Source: AGHT+IHJknmAk8KebDgu9Yyb3Rxak+s+Kyaq1plzdl27i/1/yKnJoV65h8NfCSSqqdl5c90040R9iqfbEnXHxsjSq2A=
X-Received: by 2002:a05:6102:440e:b0:4a3:c6f3:89d4 with SMTP id
 ada2fe7eead31-4a475f12a78mr5268274137.5.1728949662971; Mon, 14 Oct 2024
 16:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014221231.832959-1-weixugc@google.com> <20241014162730.fc48f2a53b89639a6207ba9d@linux-foundation.org>
In-Reply-To: <20241014162730.fc48f2a53b89639a6207ba9d@linux-foundation.org>
From: Wei Xu <weixugc@google.com>
Date: Mon, 14 Oct 2024 16:47:30 -0700
Message-ID: <CAAPL-u_Pxt-xb7wChDsVntVXZvHGXAMkTAqBC+XgwJSrVpwY8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/mglru: reset page lru tier bits when activating
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>, 
	Jan Alexander Steffens <heftig@archlinux.org>, Suleiman Souhlal <suleiman@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:27=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 14 Oct 2024 22:12:31 +0000 Wei Xu <weixugc@google.com> wrote:
>
> > folio_activate() calls lru_gen_add_folio() to move the folio to the
> > youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
> > lru_gen_add_folio() doesn't reset the folio lru tier bits
> > (LRU_REFS_MASK | LRU_REFS_FLAGS).  Fix this inconsistency in
> > lru_gen_add_folio() when activating a folio.
>
> What are the runtime effects of this flaw?

It can affect how pages get aged via the MGLRU PID controller, though
no bad behaviors clearly related to this have been detected at
runtime.  The fix is to address this inconsistency identified via code
inspection.

