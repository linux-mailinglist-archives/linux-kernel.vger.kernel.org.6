Return-Path: <linux-kernel+bounces-172929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CF8BF8E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D411C22697
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802B6E5EF;
	Wed,  8 May 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="X9Dksld9"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0C6BB51
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157527; cv=none; b=Nu1Upd24xkTU3nDXp2ax88IK6A6Ri9/5nEqEKGTgucPhnwZTcSXrbtLpBJY3tBdsMWKqQKXyOGlxFc4CopknhUXkViTJC9hu+GquIo/Ua3RIBijvCxZjoG/qROXp2M/VKgWqZChlx2j4hIB8JsbtXFLFGHsJgMbDmj+89wnW+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157527; c=relaxed/simple;
	bh=V5spKHAJYycDPIb8qjonfW7CCAIoHcDr+o3JbjTG3F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=h1EGQgX0tT1CYzcxwFLrh4Rm7dzmx6uBuLk0dc+/bU0tjgv2koN5+nlo7RkMwpBbZrvbHBCB2HYz3WvdRmLF8mKEZFonJVOm3UuqKnWrOP+GWq5jRzqokSHA72uy8jW8YOr1N7BQqGBZR1F9WkcEX3XWiKFz0PhSY7U0uLPkxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=X9Dksld9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8d989e8so9762485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1715157525; x=1715762325; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5spKHAJYycDPIb8qjonfW7CCAIoHcDr+o3JbjTG3F8=;
        b=X9Dksld9Hez5TXYfe0vX/RwJZUXUSojsLUbLwU4I1s2L9JAR8+Tcev8RFoUoRJjEA8
         KV6Kvcb4Vxh9qgcnT+BmHh78QJCPk12NI9GOapqf73lHse6mqJ/zd/5vb2EzoE9uLx1l
         NytKZoC5ybMLpv/O75by4/gSjyCB3GJQ2Zi+g3NEDXT3WC4sbLEuG9+qPjmJ5m8RKetj
         L5f3k4PTY+4THtT0DciShUX5uw7vdOLJnagUZhQu7Zh+WIkh5K2sZf9GWHiVTK8QCxGj
         bPC2gUyNxYCG4MYbCdmQD3DyvyxZILEqhziLxv4OPujtgGOSCQG7JpMBkjhyRZPhfzN3
         9D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715157525; x=1715762325;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5spKHAJYycDPIb8qjonfW7CCAIoHcDr+o3JbjTG3F8=;
        b=lG6XAbMNwDDi6BmU+MkvvErIqk1S6piArf9Ucemo/YdrjuK9EIUOxMYq3HqCqXi90K
         zQSveewX+7ptRu0AXaM/o4rquQryH31YdUYDe8VXjQEH4fPFLjhKPJlfXbsQ0gLcEf+C
         9KbwVk7H0CVajqbQE6d1XlVhuSk3WQicooZQzqG6TtI0AehjgGv9ho117UVuBNQTK5rx
         SIiZfMJKkLGBssnksuABtrq69KoHUNPkGw8AKxm1YNKUlC/ch+erBZyLp/tFa9Mh0H2y
         HNXL/tvFb6LM/nJce/azqVNGBQQw74tmlSjgkIVuJXStLxiVeuowKvCfkOkO6hMbyXIr
         r/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUA5RBANXPrDluVqEG68E5KlYM08Xjr4Do9gpw55P0JAzPhg4LcRsjUrRlVk+9Wq1d78rXV9irDbvMLHhp8OzvP6CUVcBvTkW5myPVK
X-Gm-Message-State: AOJu0YwijhPwpeu378uk4AcFMM7D7Th1kNYxgEfS9WDIhjjjUoQv9wjs
	IZId9ImSagoivHgrlrBvYbOmk0MAyygGWweTrp61RaVd3CIdlqnDNsoAjFfJ591NZoSg7dGHdHT
	i5OdCC/r84P3z9v5nwFVKVLYwPvnkeOI+gllMnA==
X-Google-Smtp-Source: AGHT+IGBmSz6eFLsDLHd1HFg7kcp7kmSokUNcM7b494MpO41SWF9RR8A0fpKHutyvvQMYFPwHGwiGt9z4eDnQ5YljZw=
X-Received: by 2002:a05:620a:4593:b0:790:b14b:21b9 with SMTP id
 af79cd13be357-792a6481401mr809884385a.18.1715157525012; Wed, 08 May 2024
 01:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <20240506-dazzling-nippy-rhino-eabccd@houat> <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
 <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com> <ZjoNTw-TkPnnWLTG@phenom.ffwll.local>
 <CAPj87rN3uSZoHpWLSQqz1SW9YMZNj9fkoA_EDEE_bzv-Tw8tSw@mail.gmail.com> <Zjs42PGvilLlF0Cg@phenom.ffwll.local>
In-Reply-To: <Zjs42PGvilLlF0Cg@phenom.ffwll.local>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 8 May 2024 09:38:33 +0100
Message-ID: <CAPj87rN-wSbGSAoB8y3MXCS20_MAQvfpWSeUKYR6XzQ+Oh0FZA@mail.gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: Daniel Stone <daniel@fooishbar.org>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, 
	Sebastien Bacher <sebastien.bacher@canonical.com>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 09:33, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, May 08, 2024 at 06:46:53AM +0100, Daniel Stone wrote:
> > That would have the unfortunate side effect of making sandboxed apps
> > less efficient on some platforms, since they wouldn't be able to do
> > direct scanout anymore ...
>
> I was assuming that everyone goes through pipewire, and ideally that is
> the only one that can even get at these special chardev.
>
> If pipewire is only for sandboxed apps then yeah this aint great :-/

No, PipeWire is fine, I mean graphical apps.

Right now, if your platform requires CMA for display, then the app
needs access to the GPU render node and the display node too, in order
to allocate buffers which the compositor can scan out directly. If it
only has access to the render nodes and not the display node, it won't
be able to allocate correctly, so its content will need a composition
pass, i.e. performance penalty for sandboxing. But if it can allocate
correctly, then hey, it can exhaust CMA just like heaps can.

Personally I think we'd be better off just allowing access and
figuring out cgroups later. It's not like the OOM story is great
generally, and hey, you can get there with just render nodes ...

Cheers,
Daniel

