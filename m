Return-Path: <linux-kernel+bounces-246676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F21692C51A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CB21F22D04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D1185605;
	Tue,  9 Jul 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3x7Wwh3H"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676713B7BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559017; cv=none; b=i1kbDBg8WFwNUloh3Mekt10Ft0quuGaNAyiyvhoA6s3fgOkI3OplY0oN/Sj7e8SK8kbNYUumwAvw6HJAYWmvCV6ePAw6cSWU68Z+mL+eym6LLx7klu2rPof+AbLuP1XHuZ5ZYAFoLABs3jh6t/DYqk8L97V8x1SJ9h4jCek5maY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559017; c=relaxed/simple;
	bh=gaP6XG2rMSS5IJkfuqSil8ethRRMLbIOHXoShahWYwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf9jGHq6QajmIU+4jDh13zUi4u5RQiuNnoa5IyDhudVKKjm14/3M15Tm50MCD6rPDf5aUBATOY6OXddmCJd2u4ZWIUoOo2I1lcY8+U+6nlkt8Gf86mmN0p5sAEnTvFV6APQ4Pz+LU8njeBRhiK7QKTbCKzrUi6+sraAeVd7xd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3x7Wwh3H; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4ef765e6dcaso1680379e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720559015; x=1721163815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEEVtKYtkpBGMMntNLgt1VflFU8iMiYE2mInhS30FFw=;
        b=3x7Wwh3HjGW8b7VMJt8SLWxc3vhpDb9wSGmnCuvG6eBlSCgfsTQTF0fg64JOfxk6sl
         aC25f4Xw9tkDKwLI6eM/6UETceecVHhhsc3EZ2wXEm1qz18J17spg8q7nL7lNK21xUKH
         EOBhk5B3R/GNBXjCexxIPSwMMMSWK8CrtvH+CbPmL1i+qyJOavtOReIgD3iNY8vUfka5
         n7geqCAn4BMib5AqIKhdvOguSS+k5Ohd/H+Du2uzDaCloGzD5Ya1RAMjqJnmnlHOlv/f
         a8fKLQOc7KW9PHt9p0ox6TDW7ghv/U725yEokQyamslf0u8LE1JoZvcVKqc/66kluu1k
         9KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559015; x=1721163815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEEVtKYtkpBGMMntNLgt1VflFU8iMiYE2mInhS30FFw=;
        b=ARS/qK1VVifR+Dbp3SE9bNOWzh6AQ9B9RBFQRTnytyBnyBvaBYNZzGeHSgyb/+vHEK
         8p1Hz1G/8Ak8NbJ6uGsCQX67B0wcJHLeE/hLXlthcy5iObuNUZyWkqZJhmlhn3B56Cfp
         SZXdMBxwefnIT3cqQVGi7QiooCwYx/B4PDNzREDvyQKwJu1N+WbkgSZYnq/vZlPT9JJ9
         IVngqPRsvzHB2+SeAYQ8DcC0f/OtuaKUnAqfoN+ar5b61JMwzCft6eLsXYTxjz9v2pTM
         McRUtDfMroajZTfjb7zAquWS747n/NFxG32f79QqI7rdAP2oQYidtFN4rIuCweG50+zY
         T/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp0tOCbBlUBaiXHoy7LjKMt6e34pHtlpIj1rshRAdtpT+oILVRwLw5bW65uwxL/mbWbPEfecgPFG8BukZnjYQ89PZveZBe4AmD42w0
X-Gm-Message-State: AOJu0YzyLKDPJCc7l5uWeo60+neXzqbEdGfzMOvonXV4aCzz4rIQ3x/D
	69Yd3D+DJb+UZZYQHZ0nL9/SmDduar3l2JnlDjFbUb640CD1NefFmXapB+k22oP4pdmzQpdtv+y
	RuK0PTDhUl7/v5tEYzH5fR9zc6ivGNJ0PFE8S
X-Google-Smtp-Source: AGHT+IHU1E8fzuJxDgkkRa8V51Zp91URQNvMI7d/QwIPp6TAjb2CXGR3nGBcdKh6trunZV3PhvoQJWHyJO0iWBgRnhg=
X-Received: by 2002:a05:6122:d13:b0:4f2:ea44:fd2b with SMTP id
 71dfb90a1353d-4f33ef758a0mr4208200e0c.0.1720559014412; Tue, 09 Jul 2024
 14:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708190924.work.846-kees@kernel.org> <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>
 <202407091327.AEF6C020D@keescook>
In-Reply-To: <202407091327.AEF6C020D@keescook>
From: Marco Elver <elver@google.com>
Date: Tue, 9 Jul 2024 23:02:55 +0200
Message-ID: <CANpmjNP2BEYV5Yp80yS6+x90YFpdAUyYSR5mxoj9q7JZQWy3UA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] slab: Allow for type introspection during allocation
To: Kees Cook <kees@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Tony Luck <tony.luck@intel.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Mark Rutland <mark.rutland@arm.com>, Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Tony Ambardar <tony.ambardar@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 22:28, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jul 09, 2024 at 10:26:32AM -0700, Christoph Lameter (Ampere) wrote:
> > On Mon, 8 Jul 2024, Kees Cook wrote:
> >
> > >
> > >            obj = kmalloc(obj, gfp);
> >
> > Could we avoid repeating "obj" in this pattern?
> >
> > F.e.
> >
> >       KMALLOC(obj, gfp);
>
> This appears to be the common feedback, which is good! :) And we can
> still have it return "obj" as well, so it could still be used in
> "return" statements, etc. I will work up a new RFC...

More macros like this only obfuscate the code further. The name would
become something that makes it really clear there's an assignment.

  assign_kmalloc(obj, gfp)

There may be better options. Also ALLCAPS could be avoided here, as we
have done with other language-like features (vs. pure constants).

