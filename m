Return-Path: <linux-kernel+bounces-242852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77157928DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B8D1C21E34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81013E024;
	Fri,  5 Jul 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A85uOe2P"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA132F32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208819; cv=none; b=IHsc0nZ/aMN7jbO8MIvaaVZQgZRhxfi66ne0bPCV9twSL/axB+b1OTNd8qAgFvjMH9N7DPnjmMLT9/jvJxzV/dJDgaKW20TTimWDfEyaamfnHX1TRNwaf8mybfuZHoygdorDgkeHKeOjgNeJYPSMLEsW1gtY+A9yGnrS1z19xRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208819; c=relaxed/simple;
	bh=0Gw/9BZ6eJxZB8LrE5YMswjAtCqek1J4F1GwkFhL+DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtXSLFccra1zjoQf41thUCU9m3AT1IekMVGRn/tNjrpsquOJQ/CUvaNJQv/5drc9pztkMG2RJ465r7pJfHo81XOGyeThE+p6myDgaHGwkdogjclZd684qBW49xEYhC982nBNo0agdC3hYCFLMOo7yb2W9F69pbDeOHgq3fvh7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A85uOe2P; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so965565e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720208816; x=1720813616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=exfu7O+1OvgkjH5S5EA/V3NCAdsFsSdYN2eRcNHvdAs=;
        b=A85uOe2PFbiwZnOwmWotwA2KqB/VQ01euOjzaeho0OgmX0uXQWMie4QSuPEtKdkxZT
         vOxlXym0ITJ1ZZyLwcdvox/ywcsrEIrzWJOQyh2ydEvLICXSvWaG66AOUxalAAmY+w95
         xcgpbPuBvznTI4I0Du0+TSfcy7922sbWY50Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720208816; x=1720813616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exfu7O+1OvgkjH5S5EA/V3NCAdsFsSdYN2eRcNHvdAs=;
        b=cg0YXlJDM4SaUMAQdB9+3D9h1NsYtIpvCB0zooS4tbje1qjYRGaF5Brp7iqm3+nXaN
         3uXKXRoIMxJwsznslJyFWOR4C4MvV2aPX2MTEkIFthWMU8h280VXR9jueG+2ukspoogd
         2zZI3Pldc3JldMF6lWQTB1jQPidjqHlD29XAJ7JDuX+pIzhxn6hKr3YVXXXetPT5eLbW
         gyLgs3JmMBS/0yZrEH04FZJpmng7V6zBOZMzGvebDNk2nSfBPqPLAyLChEgwx3LxAyia
         IJCQgd9o0u2nmdtAX2NDHWZk2JfOYXnTrOfsnoKqwQIlc9mYBvlIzoiGD3UycrfA4xln
         v/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9RL5j7wC+TbAn9Ja/2pKE7EW0vzeZwyHh+P2t12oLHgF9ebVnjR4V2Oe+WVgt5S85t68qIQxIotTlN8R7yxbnIpTJ3j0cKFgx8lA
X-Gm-Message-State: AOJu0YxPQVyVDcoguoKQULBZbXffYaNi79HCK1XCn0kcE7FNWd04FrfO
	52d+YDBA0mFvouSQmj03JSDLqsGi51lTRPtqNgD5GCxic91ysfYQIdoYPqNRIWGhx1yLNQQ/8UP
	8Thw=
X-Google-Smtp-Source: AGHT+IFiLeWeHa9PmVaIUyNvoTSMZIu6yYRFEpAFN+RsBD/DqclsI5CS7qDwdIHWLKI+trAscTivbg==
X-Received: by 2002:a19:7610:0:b0:52c:def3:44b with SMTP id 2adb3069b0e04-52ea063aba2mr3230604e87.31.1720208815757;
        Fri, 05 Jul 2024 12:46:55 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d242037afsm3607740a12.51.2024.07.05.12.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 12:46:55 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77b51631adso234955466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 12:46:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe5JN8WPTbguj8jSr/ctBj4UzBHSQ2aoo12O+8iZOaz5sO6to+1BgKx4pT3Cn/MAihHbcJYDVIH2S7yQfSGCc7oy1V1HGRHNwU2JDH
X-Received: by 2002:a17:907:c10:b0:a77:d495:26a2 with SMTP id
 a640c23a62f3a-a77d495271dmr190755666b.55.1720208814751; Fri, 05 Jul 2024
 12:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com> <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com> <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
 <ZohB6uPAVX03Sc96@zx2c4.com> <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 12:46:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>
Message-ID: <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 12:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> KISS. Keep It Simple Stupid. Make a sane decision. Stick with it.

Side note: you could just stick the size as a constant in the vdso too.

But honestly, what's the argument for more than 256 if 144 bytes is
the reality now?

Does anybody seriously think our current getrandom() isn't good enough?

              Linus

