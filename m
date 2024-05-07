Return-Path: <linux-kernel+bounces-170712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85E8BDAE0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED071F22419
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821B6CDBA;
	Tue,  7 May 2024 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvhtHqee"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499E6BFB8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061278; cv=none; b=dBwxZL7Y/SH0OUO/88aMK52oXotJYiZvY2HFGoKUeWxx6FG3WIbKHZU8/cegJibDle8n0MOP++L2vYC39aDnUZ54SSVTCcJis2YLAHDEdfVgprwvlnvKm/Cf65hr6HPsDAakkjnKj6Z9If3WnkoezPu+NX2YxbykEJS/j3qILYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061278; c=relaxed/simple;
	bh=20gKwB9Y6Kzn276qfDDgtF9coeWsOEFWeBLJyVE9dWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrYI/dLE3BO6EfXhSZ0HIbB7+5MjXk7Ln7ZYXESDj2O7ZmXwGC2VGyNYHlKk8N0mvpwJWfUrkPzF84QxEVRVIo/MMZV+4+ABmzb/10ccmmkfFmy/4dNKCYxDhDBHexqHWohWH8utZgjrVuo82k9ch63XrOV9WihsPWgHh73B7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvhtHqee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715061275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20gKwB9Y6Kzn276qfDDgtF9coeWsOEFWeBLJyVE9dWg=;
	b=WvhtHqee2d74EDOkolfvUrijWhXUKOOVxyVfygjoON0E/k6LroZ55Gf36zw1fy9ZUhTs6V
	qVkw3+OdPZwsRVvlgT1UDMGFevUyAdPdHSaMi5KJFFdrbko9R0tqJE5SG0yDjHZzMV+Tk9
	e3R6ZNC/UIZxQLIc2d9hSNQH56T+c4c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-xA3m_X_dM8-JyjSjDlNVqw-1; Tue, 07 May 2024 01:54:33 -0400
X-MC-Unique: xA3m_X_dM8-JyjSjDlNVqw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-61c6560f50bso2471373a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 22:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061273; x=1715666073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20gKwB9Y6Kzn276qfDDgtF9coeWsOEFWeBLJyVE9dWg=;
        b=Rgc64I6zp5zyarxWyjYjjLpWMH2DhwEhwnpcFWfUHmIqtRnxoJqDIudxeRwRpmlGdu
         Cgffpzg93sW6VgrgXD/ruAJn65gHUboLNbBec1hNd+IAQoOJOeyGMJQ/OLlN8/Z9a8b4
         aoKivJ/6sD+cUgSIRJ3BjpwlGnbJ9F7jKZitAMUCK+hTnhtVQBWgcML7aVIxIdChn1+u
         8MsdtGccWdsaiXGeVmZdJ4rNrBPqWGB1+eFz8ikD9H4SEWWqHmEr6IUJ09rtOoqA6qn/
         hYOGBQ1Qo9/OkIssm0IEIOM4s4nl/Ify0dlcvltT+u/ur9yRNzGZZ/8M7zL+3geb+qkI
         Fr6A==
X-Forwarded-Encrypted: i=1; AJvYcCX+rVdpqZb5VbpSbnmJt09emgIKMMDEzyUe31Yo1rLCu+yehEyT5TbTBYmHbUKm6wPmqWUVH6Qy4iPSV8g4a52aoVCtQKVNfsn2x9wv
X-Gm-Message-State: AOJu0YyFpCwuKNQRuQlpcpWXFFsWhn65+urs+zfn435894BS95F87sZg
	218f42PEvkviFq2zdeYJUBpTe99vedsHNiDgHN/SFeUdu8Ozc9YK2DwuOES3jPgCceLN8Q61x6I
	IKsQJbjzh7i/yA/t/SDfGM8gfjQh7GCd6HaW11qpkp8+vGuGaAuezmmxHpcNnmcO7smt3mdAjjx
	9AmZJfBAbfsr377OlGoX60W788EC/rtZf/nU8M
X-Received: by 2002:a05:6a20:dd88:b0:1aa:590a:9668 with SMTP id kw8-20020a056a20dd8800b001aa590a9668mr9789611pzb.51.1715061272711;
        Mon, 06 May 2024 22:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoxUCyw3G7woiyN90q6fdiBQFxnnK13PtUXk31OQzkOeF3E8QTAUwWsRlM5FhBKV1dlaYhsPqjvs3jr7pn6iU=
X-Received: by 2002:a05:6a20:dd88:b0:1aa:590a:9668 with SMTP id
 kw8-20020a056a20dd8800b001aa590a9668mr9789602pzb.51.1715061272390; Mon, 06
 May 2024 22:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502081641.457aa25f@gandalf.local.home> <20240504043957.417aa98c@rorschach.local.home>
 <20240506-cuddly-elated-agouti-be981d@houat> <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
From: David Airlie <airlied@redhat.com>
Date: Tue, 7 May 2024 15:54:21 +1000
Message-ID: <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify qxl_fence_wait"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maxime Ripard <mripard@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>, 
	Timo Lindfors <timo.lindfors@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:29=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 6 May 2024 at 05:46, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > It looks like qxl is not well maintained. Please send the revert, we'll
> > merge it.
>
> I'll just do the revert and we don't have to do the round-trip
> overhead (since we're already in rc7 and I hope to just do final next
> weekend).

I expec this will reintroduce the other problems that caused this
change in the first place, but I think this should at least bring us
back to regression equilibrium. I can't recommend anyone use qxl hw
over virtio-gpu hw in their VMs, since virtio-gpu is actually hw
designed for virt.

Dave.


