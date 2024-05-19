Return-Path: <linux-kernel+bounces-183216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D38C95FA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7201C208FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C16D1BD;
	Sun, 19 May 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPsz894A"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071426AC3
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145218; cv=none; b=Y4aBEYQ+Qwt4cacp4ymTw0kFlCv+DR6BX/kuqSp78y6Wrt/pcPgVUbQ9w1fwDTALAgz5sIvm4Qdg39utUzhLxUw41lwSS82JTa+2i9KzFFR4Avn3N+J+Tj5VlkoUo3msYtZiOYH85hyydQvtFnOSbQ4bM9VxwUOMhI3B2w4+HVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145218; c=relaxed/simple;
	bh=DHmSszyfjhEcPAzaxAqwGfnCK+56Q7eIRYpFVGQsK6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHF1GTZqw/lLE5lhjKIzz46MJ0ol2POq0wac1DjF6nMOce5XS0H/Z6nrKeGHx+3KZ/bwJoWrJuL2l4dX3IeeFyC5BBTOVvDH1PTx10o2AMb4JRaFiVj70G3IcLhxBknR13Ft9V71r2KDUuqp6FoapkenMuC5+PltWdsYLAql/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PPsz894A; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59cf8140d0so526518066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716145215; x=1716750015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rcdyva3+VOwNI8m9OxNo40+uCy3eJX0+lP+NPNz1Ok=;
        b=PPsz894AVrYuFog75nLPSCACuhOqiusQUgvSz422T8TfT0KVT11rg0TsLUSHQhAryp
         g50VQ5CpVo2cNHKHzZTr84BJL/A4e5AaviJEcgPx4h1iBl1XqoRJ+S2YOJCJ0wmDPQgl
         xbb3XlLG8xFOM8XEKvwGc6bJaSzFVX+hdVuRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716145215; x=1716750015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Rcdyva3+VOwNI8m9OxNo40+uCy3eJX0+lP+NPNz1Ok=;
        b=gPrfZ2xEnqx2fPUxLzrOg+brvXdvIy3Wz9w0B/YpqyP2/gV+VZDURfuuwE4is4sWSI
         J/iPyW7DAlF/c7hEiTL0kyIestquKghfe+goFchs3UbmQIZM5QK/fTGt5H/UMj5Np9lA
         qQf2GXkJKEu8ouXtbEvx0Kx+2B9s65Aea9806mowtRYSaOJxKYytCakUmmlAbt3PIdsB
         3grRi07q4LNHaUbPahuKebGrbNT4FW+u/gseF/ooux8h1KDegSo1SeuIWqGp7v5axKXe
         ejeSeRb4SM/UV6mDeWHL/5PINyhMtNY8W7eP462kIoKIJ5vEJAnAHOAZow6A0yI56vtJ
         Bvig==
X-Forwarded-Encrypted: i=1; AJvYcCX71KqDRDlTDuoqBlOQe9zcBBIyQ6bCR0ltgn2qg+OOK5691II9BahvO6Z8OB/+gNd2AUx+4RAX1H9zhBe/5j5Bx/VTnePL6ur9W8BO
X-Gm-Message-State: AOJu0YwBVtx1t3H5ORlEPxoX4rHhx2MVe4RXcKOIP5IE/Pfg5wwmLoFV
	YHclBogXoq2qfFezEBYTKgaTrFN06PWmCg2DNKxqe0ihkTD47Fxal8dv9scn3ge3G9kwEnzppvT
	KziiGWw==
X-Google-Smtp-Source: AGHT+IGQWFx3Z3i5li/tymYzappyTae9EsAYGcGt8mpqZEU19iPzDY78HlvcC4OBirXtOWsit4Rthw==
X-Received: by 2002:a17:906:3155:b0:a5a:1b78:9450 with SMTP id a640c23a62f3a-a5a2d54c0aamr1684027166b.6.1716145215097;
        Sun, 19 May 2024 12:00:15 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cebb0bb03sm465495066b.17.2024.05.19.12.00.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 12:00:14 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a7d28555bso697921066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 12:00:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlRQfTiM8YZtUZFKw46YGpxVowAPdj02yjOBTE4gvySW2Rfue+XeO5q+Vb9Ss1oWYpXBJ0ZZ1QjFFvbJ8XrsOjFIt8RYvIPTQFCUMp
X-Received: by 2002:a17:906:1401:b0:a59:b136:e40f with SMTP id
 a640c23a62f3a-a5a2d5d08e0mr1738036566b.38.1716145214360; Sun, 19 May 2024
 12:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org>
 <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com>
 <20240519113639.db3fe5f80d25be4e7666751e@linux-foundation.org> <CAHk-=wiy+25i1VZhDaV-b_m4aXGNELuVok9Prv4=oYqiun--rg@mail.gmail.com>
In-Reply-To: <CAHk-=wiy+25i1VZhDaV-b_m4aXGNELuVok9Prv4=oYqiun--rg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 19 May 2024 11:59:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5uUJfZEh7hG_iFcR4kzAwwCrhBmuBDLc3+roZTov5kA@mail.gmail.com>
Message-ID: <CAHk-=wg5uUJfZEh7hG_iFcR4kzAwwCrhBmuBDLc3+roZTov5kA@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.10-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 May 2024 at 11:56, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Instead you seem to merge _and_ then rebase. So you do the worst of both worlds.

Hmm.  Your non-MM pull request doesn't show this pattern, so the
problem seems to be purely about something you have done differently
in the MM branch.

                 Linus

