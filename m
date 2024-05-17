Return-Path: <linux-kernel+bounces-182617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC18C8D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C411F23BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE713DDDB;
	Fri, 17 May 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mH+oa/U+"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24671E89C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978475; cv=none; b=A2foJ051Qv3xzM/rjCDijb9Ta3Qw+vbwMijc1yk4PJdEcx18YPvnWyGlXT7qZY6HXb8jGx/tXqwp8I5z8qiJSyVYczbmwzhrP1+g5r3gzcwM6uFRhv2JH+XrIPxeXdCPj3nxbEI9hw+l7aGL8XhzvTg53YRTDOwXuV5CgoLT9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978475; c=relaxed/simple;
	bh=1zR4oNwvnA8BkAHQhbNCPpvycGJsy3kDip8fLJUMvs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNGcKT5qiiZ3U8S8Xynt9Zb/UpOGO/1m/EGOSKEndqhpOwMYu1oRsvdts4o3ThexxF8zAA0LhHBpjgrT+LalhXNGiNAlPCEgNkYqnqalZGPsqMwhgt2Vv1Jt5xJ5x4T5+qHP9m8ZhWXR6ekZHn6KUbP/Hk5bLOQp5P2XJnL34PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mH+oa/U+; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7fbbb2cf3c1so414254241.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715978472; x=1716583272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R30tVZwDgV0/d0XFfhvgj7VuYYCEcxfHEIQCyiSom9Q=;
        b=mH+oa/U+pZw9M6PdpQ0Ikf9E0v+oC4j3gECWwxWWr9cRfLqWdCjLZ3Tq/F9vO3H8AZ
         RJX2aEPhAz6oT7DMFisz6xSAKeosAs1p/h5fj9zJMg3WmlrbLt0bEkQiS6Cwk+pp7yeq
         mFkspH4SPjy0Xt/0azA07J7te/vpitJsbEUFmnliPiiRzb1cmVR6eVrcuC0HhD5tL48u
         fPOOzWJrBCkTZlYbsl+TdPT937jCX3bVLOj/c0Agmd4k1GWtp3+lwuvPRm9vfLtMq/mC
         DLReSp6iscWNBwxP8tz6NRgSreGqkrovduvwEGc9qfvIJ3b6q/PWf367QqFqPfWHGWdY
         D2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715978472; x=1716583272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R30tVZwDgV0/d0XFfhvgj7VuYYCEcxfHEIQCyiSom9Q=;
        b=vh6S66QpLl2+LzHA4bMUE53LjePKHfIPZZylsykxzmUJrKegDBo9tCsIdR+EPW8A/n
         5vbIisBQa779sQc2fClt06KXZ/pcx6I+jA0FvX5FjrAfc7O/iQynuCkAT0YYnEZifneJ
         RaKKTN4G/1diTZNuALBkha0Qx7e2XjNPIyxLpBpFVzlV4W5gbwlyD48KDBALu5yPuP3C
         YSsVdX1d2y7DLwqOC8urhuBhq/0Liga3CDTpWbBMHcbmTCcUVKn+8Q8u6oPVFXjj0oir
         /DrBBjTpMEI+KnbHBp+094Sy3t+PdRDs39Kd30qF7nZsMEdQ0d8UtxwDgZYmXYc8+97O
         xuDw==
X-Forwarded-Encrypted: i=1; AJvYcCWGPPEpRCuVXSdVmbEI0pnK1kFzf2nsZ/wcgJTPDCPpWQFEjvB5bKgSZR7+JQZXGm8aPic39txqVLM8sBfA68lqWAZqQh2OHATr0bZP
X-Gm-Message-State: AOJu0YwIMnwMpsz0ivaJkriW89VeMZHMlsOVGSoWgzS7N5Wk1YGC8AgD
	+O1Nbp2qxsJWi9EDpBYBmK/8F+UEN7pIXzWHD4934QWTTPzs+EcvLrsa8JGsrDU4EIjMOs19lju
	EMTmFJLxl+7LWKSB2a6wKC9G8yUGRIm7ZSYE8
X-Google-Smtp-Source: AGHT+IHmfBLbTvuWZDrq9Mhu7TtpE/aaISjoWzyeUMYFC/bgu3kwTmD10Cx24kOB+yYtazT4c5jmMdY6e5JklVkmxy8=
X-Received: by 2002:a05:6102:390b:b0:486:2c0:1d86 with SMTP id
 ada2fe7eead31-48602c02a3cmr6067630137.7.1715978472478; Fri, 17 May 2024
 13:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com> <ZkavMgtP2IQFGCoQ@casper.infradead.org>
In-Reply-To: <ZkavMgtP2IQFGCoQ@casper.infradead.org>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 17 May 2024 13:40:59 -0700
Message-ID: <CAFhGd8pQKE_uak2gqUXjbQy4LCGoJqVD2XCZrOC606u-tzS0mg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset calculation
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Bill Wendling <morbo@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 6:13=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > When running syzkaller with the newly reintroduced signed integer
> > overflow sanitizer we encounter this report:
>
> why do you keep saying it's unintentional?  it's clearly intended.

Right, "unintentional" is a poor choice of phrasing. I actually mean:
"overflow-checking arithmetic was done in a way that intrinsically
causes an overflow (wraparound)".

I can clearly see the intent of the code; there's even comments saying
exactly what it does: "/* Ensure offsets don't wrap. */"... So the
thinking is: let's use the overflow-checking helpers so we can get a
good signal through the sanitizers on _real_ bugs, especially in spots
with no bounds handling.


Thanks
Justin

