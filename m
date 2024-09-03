Return-Path: <linux-kernel+bounces-312227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E49693CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876011F24397
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC731D3195;
	Tue,  3 Sep 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hajXK8wW"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAF1D1F63
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345365; cv=none; b=bkRKwaogZa6qsTeOfi33J7jU6YuX+NucWisfdubnk6YT7yibPnrFGbnKHVuiZiqrSuhaTNfomtWtpA+iI2LKYAUa0LK7CC6LdIvE0wtFmkF429RuNX7ITsIzrCxjD/RxbbtR5jzMSt/nncCVQbctRo/TtFRiJGZjdu4ZeHM46t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345365; c=relaxed/simple;
	bh=VPZudvRVHbus4LXrbfoMkcg6cOhLHcVHXr99PO6hzJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ETm7q7hnfoyQ2Mf1GEdJv9mETx+K6sg+AwAyI9Muhh2b4u+rxopDEZu6z3uZOiuz8FnYtm2XGi1iSzRP2Jp4HoPs6mkpyDY8HxCQWN43KdH+ZPDZB7gbHHt7e4+oZwyvJhwwl8HTpxrTireZ/EwGl0CdmQY7ER+Cz+UG86WX/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hajXK8wW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a82d1ef62so3633170276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725345362; x=1725950162; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPZudvRVHbus4LXrbfoMkcg6cOhLHcVHXr99PO6hzJo=;
        b=hajXK8wWGEiEnEp7p6c67laIekBPpgZjOkgYyqoY+73rQ5caD45AKhOqKxYE48bzCv
         PCutU+gdFGzVBUxkWJa7nDjs3pOxwJVQB1njzJyWObN6JvZShBJQJ7NuMG1buaZbFztX
         Igz8RV9hFpydBGhghxQyZYVRb/NwxIT1k8N8cEjWdyUiArvbjNzv/peKvXGsy32ATHpX
         dfAwKSCHLJGRWVV0VxfkfH7VuaelAg2e/HQ5eljZABTL2zURyOgv/RgMGzY6M3hkAkMy
         oCg+myQ06p4adbpsB1e5tEjqiVjxaINXb/V9ypBAUykFcJeZJU7gj6ZvCSQsabYuvmPI
         kL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725345362; x=1725950162;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPZudvRVHbus4LXrbfoMkcg6cOhLHcVHXr99PO6hzJo=;
        b=ilnptlpgaJMHrH4lTCuuiag+vgoc2p0lB8qWTxlYsH68a9TUGomHMLoXOCIHbM54MW
         lMWcv7w+/3de81TyYhdrq5kDoJYwyN9pjRCOiV8+K+DwLiLUFvha0ObD+gUUoS5jkqIC
         4S4fE90Pg5fbXPEEIGB5sdCefCSWbkLouXjHf6YrZNhEyn58cdItlmwvIPDVJMmnuMDx
         YBG3WoN5HXTWWP5psZcX36JlZxJW/PUae5LhwV5WdWAkrmzV0tA5WWbhmlmAZeZKFqel
         aMfnRhsfyaQEcck2bkF/2l3xKZeZQQ9GM7vg17fhg1HbOB0mbPt0W1xp0uYGa/bA5oiO
         MheQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlqksECT66LOXB8WmIKZxipzqdyfc3H0116Q3m6gFYvseF7aNgpGehoNkuPaj8Q1PzTiZHF1pbRL0i8FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2PfS6ilsaTOy6KBZwTB0PxvDfbNCfmmJNLDQExK6mMESipWC
	Dj+V8ZeJRiXEFJy7O893Ge3ZExdjCPk+RszFLD+Ql9FihW8Qi05VM0LYCxuhZXzkkqYsSd5k2HJ
	jsd41wn9ZK1NTG4XiCZig/4H+I4c=
X-Google-Smtp-Source: AGHT+IHR8tpiw3igY6qGfaRdI1dxqyE9jFzmjN8jYW30VTbpCYodS9kwBwFF3bZihMwsgZEMvLsrfMZBR6/T790BhzE=
X-Received: by 2002:a05:6902:2313:b0:e0b:ba20:7f87 with SMTP id
 3f1490d57ef6-e1a79ffa00amr10498144276.25.1725345361902; Mon, 02 Sep 2024
 23:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
 <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
In-Reply-To: <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 3 Sep 2024 11:35:51 +0500
Message-ID: <CABXGCsMdxHJ-MLkS0pm51Sk8g0PTghsuZxmowvj5t44bVN4ndA@mail.gmail.com>
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com, 
	pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 2:12=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> Is anyone trying to look into it?
> I continue to reproduce this issue on fresh kernel builds 6.11-rc4+.
> In addition to the RenPy engine, the problem also reproduces on games
> from Ubisoft, such as Far Cry 4.
> A very important note that I missed in the first message.
> To reproduce the problem, you need to enable scaling in Gnome for
> HiDPI monitors.
> I am using 4K resolution with 200% of fractional scaling.

Sorry for persistence, but I'm afraid there's no time left to fix this
regression.
There's a week left until the release.
A month later, no one has looked at what the problem is.

--=20
Best Regards,
Mike Gavrilov.

