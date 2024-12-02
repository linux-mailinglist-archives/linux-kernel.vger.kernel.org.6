Return-Path: <linux-kernel+bounces-428266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481569E0C34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137C9164F35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247D1DE88C;
	Mon,  2 Dec 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WB/6Uvsw"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735251DE3BC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168061; cv=none; b=mL0w8qBemvNA48NOd/ZsQTeiTXkITvIBNpclk07KrwSZ58DV7rEnRbj01RFNPHthniRqf+AfAnWZu/pryPOLW74YQrU+Ge5tOhvW16lh0FcjKhYxxFK6Xh5Y1TTrsXZX5JZ7WHy7w2DvYt/vgHXIDd0dvdILJuEvJpzkByUGGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168061; c=relaxed/simple;
	bh=R1wjqLCnK/jl668F/7xiZbuQwwYunoRzMSm3GVh/kRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1vA2wvKG2mov0vbfuTbcl17LYqhPaTRCI8ZXOwzi0j6XFKSAmpShoC8PXIeCe1Ze98s7o1xy2lUxP23GOmsyjtksVM8HTwJwT1Upj1/cfiIgffFBDF76zRiT8QjRyg2fq0jF9ZMPM3P2Hd93IgOiLLL3Ag3oB4v6AuL2sAZua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WB/6Uvsw; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de579f775so6493262e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733168057; x=1733772857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NKeXocoBU43F0p08iiIssomLE42KNiU+OuyoZjKEnbw=;
        b=WB/6Uvswi0iKRnuA6adQ/zmwnSM34eErILizMXXPwnhxM+B4xw6oa6N1Xd+WmtsAbj
         aS7AbrxNcu/m3MigHk94PawZE3AkF62cfwJfoXTcocF00rTq5cNITFa6vVoBScMeYtlu
         CsCM6OgLzItnUcOoMEfZ2mv2cLlm/jCLI+GRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168057; x=1733772857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKeXocoBU43F0p08iiIssomLE42KNiU+OuyoZjKEnbw=;
        b=As7pyiLP0YVG6PCnILzXRwflIUrWwkP3Q4W6MgoupTX2D0qY4mNNVLRKLMP/UmpIyY
         kRhaxBB4o++meRZdvQEL9BTUDlCGx388xI9dhTki0jp19ZTck0voc3pSFThpNm1fApN1
         noobm6hM/o1rsn+7BHyKuP5yC5XbobkvQ5ZdJ4AGw2bBN1sJ6QegMif5O4RzGxnu6fBh
         NufV+7HrHsvj4/ThV18YmYd/ET2Y+g5nTKLFw9Us2IOJjQaa50i8A0O/i7uW95tqXApn
         fZBNTyBHusFBRDUU4o7etp8a7SVfYXzvHP2XWQD2ACCEGrzMhJqtSeeVIJpdaEwTWftN
         DikQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT6NVv/CceY/TnQCS8GQZhskUdWnFke/+Vgs8a/DzpNd2XyAuLRbvFHNHqAewOCYWodH7BXbe5rCObmis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHX82tLvnjpE05n7cpCadwTxhizdJlsnB4iuyDwavmH3572JUE
	qilvmUTPI7j3Y3LAWvG50yOMMLyCij83u9L5OQ0a9fZebF9W1MLb+6GLZhqhp+oID2QolxLR+Bt
	Ifgm7gQ==
X-Gm-Gg: ASbGnct0+PZQooPws4OIAnLcOmSAO7AXqIdpG3H65+OHL2vStbiowEwV4wp0OJE1mrw
	mz98eHMHCA9t/IOKIfoYecQy1vx0oGDXkEvEqn5nVK0MLa3qUZa+Tiu7e07xVRojn2KY8nkRTgS
	2amXTnDyDVnx/SZSls1gWPqAVdQRVZJvu9lTqsWPEEksDydYrRLWML4Kj91+VuuwWpY1Cka2rSa
	eil76Z/ESbPH/+euTWbMLysyLQtL46YVtdrQrlPiPd5ekOPZoXuyLR6pG+8ZSRSQ5/64tz2PSXc
	hAwwKDmnYkQfcDnVvYI7DMCJOau8
X-Google-Smtp-Source: AGHT+IGboFL+Oj6aq9L6pFMCOx0Ib6KBzzWXBZ94Pna/BmejdrVm3/8HASUwcxf2RhULB+ZU2WgwIA==
X-Received: by 2002:ac2:51c6:0:b0:53d:a132:14f5 with SMTP id 2adb3069b0e04-53df01172f5mr19533690e87.57.1733168057158;
        Mon, 02 Dec 2024 11:34:17 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6430e7fsm1564651e87.57.2024.12.02.11.34.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 11:34:15 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so69756891fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:34:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSBsQaGaKwyRlHxQUpNn7HuHTgI6SoQbjXL2nK8sMEZEmMARkznIBRcyfojOUJEHIWla0YZ5HyMJ8re7Q=@vger.kernel.org
X-Received: by 2002:a05:651c:508:b0:2ff:cb81:c016 with SMTP id
 38308e7fff4ca-2ffd6028d77mr201405821fa.19.1733168054547; Mon, 02 Dec 2024
 11:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202145946.108093528@infradead.org> <20241202150810.048548103@infradead.org>
 <20241202151533.GF8562@noisy.programming.kicks-ass.net>
In-Reply-To: <20241202151533.GF8562@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Dec 2024 11:33:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7KugYO+R-1DMmkLz4fD_-A9BMyrWTVsH_K0a86Ojn4A@mail.gmail.com>
Message-ID: <CAHk-=wh7KugYO+R-1DMmkLz4fD_-A9BMyrWTVsH_K0a86Ojn4A@mail.gmail.com>
Subject: Re: [PATCH -v2 1/7] module: Convert symbol namespace to string literal
To: Peter Zijlstra <peterz@infradead.org>
Cc: mcgrof@kernel.org, x86@kernel.org, hpa@zytor.com, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	hch@infradead.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 07:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Perhaps we can ask Linus to run this now, before -next fills up again ?

Sure. I did an unasked-for scripted 'remove_new' removal right after
rc1 for the same reason.

If we have these kinds of big scripted things, right after the merge
window tends to be the best time to do them. The conflict potential of
leaving it hanging in linux-next can be somewhat annoying. They may be
fairly unlikely, and easy to resolve individually, but it's one of
those "one is trivial to deal with, but even just a handful is
annoying".

So I'll run your script and take your commit message, and we'll have
this part over and done with.

Thanks,
            Linus

