Return-Path: <linux-kernel+bounces-276751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E323F9497F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF711C20C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE814EC51;
	Tue,  6 Aug 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hSyqRyQO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB018149DE2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970943; cv=none; b=p/LwSDDfElOjRpkJKGtGlX6sav8TKB1jZttf/J2ZIue30bJS3+NZ3HVTX8U7KM3we6BuLAjWVGRGHJO7fjaywy01DgiM04f/yJdSkdVuoDt8xK3Pfbfsyk3eO1h/hFUC5DfhD+FVK2eavqJtpKMsSVPztsgK0LDe7STOVlMz9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970943; c=relaxed/simple;
	bh=PJTPlupeD76Ia/bH//Hxc92U19lHKicSKX8SQIwk0cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6DNe3mT9yleAbR2LE9LBmMEU27jtqmUjFJGAFfTngpxttxzwY/ReEIhdhLllx88ZojHN6h4I1MfxO3KQEoK592WQTKbWLXlDUxmSV8bg/xAZwxE/zk91i/T210b8fTkpCotxWv+a6JhbN3tdjvBblDU+dnN3KP5OqMTNaOxwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hSyqRyQO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1553101a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722970940; x=1723575740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7OpQ24xTWKUtgMGYYeHm4cTkwdIfO8nPqlqE9Blx+8=;
        b=hSyqRyQObHqXHpWmW9u6MZLDMEpMzxlPemfmbhuU39nUV42cSxj/u/oTu7sgYY4xV9
         oNGQhgJDPg0CIamrgffRsHALbeUF60KWDJrj2HmjnJx3oy485gSKyTNAO9xM6RsqAKGs
         r2QTbcROu9e7/jowArtRnY6S8vqyC+wZKgWmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970940; x=1723575740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7OpQ24xTWKUtgMGYYeHm4cTkwdIfO8nPqlqE9Blx+8=;
        b=qGJjQ1baHYeja1PB9CsbqfokD3U1PgGbUxrW6yABO730bu8goawVFUCNf7ggqUrfAT
         3MM8HpfuqHnjQ7TLeDykwuyVbh2vwnlHhrEnjvpw34ijpvqlmht9i07rdKuqU9zstXA+
         WKFNsxHAsukNO0fAbSSysqWOD/9noUDYuqcezgsANO5AVLIpe3dPOAv+AY0vnCQ8Aa/X
         EoEMLefjAR1qRs2MTE/GYFNSFQQl2EjRMX79Z9OgZDQ7m4A/mGXi1/v3I9TJCblWMLsX
         G77OiuzYRGnjqe9NhEz0RTEiqfYRqbFlu78c0T9EJr2JkGt5WgiwPT+c7ScPqNiVc2MS
         Bh1A==
X-Forwarded-Encrypted: i=1; AJvYcCWTw4qy3KbjsyEeGCvbV98gzFmRvKM2YHHydygvx5iDOcWve/FooWm5ylj0edTnm7ooRfkxjduHkICMNMdFY7R3aek0+SQIr1Z2ISUk
X-Gm-Message-State: AOJu0Ywae7MAzDZrlGFWWvczIcwpWfQ8aJd5hV4eTYWhHPZ+hDFnDjE+
	eQVSP2TKKSRS/HPkVNpGI2oGlkPOAAjRijfsaxUVocY8L1FFJdS/uKLWr8Q8+0bU6OP2bPlGSd7
	kabjl4Q==
X-Google-Smtp-Source: AGHT+IFNGcN/xqP+dJnR1H93ZTVr97uAz6KVAHp0zSIBlNhjTaDxNtB/UhkFhwwX6sGQy+F26wE6zw==
X-Received: by 2002:aa7:c996:0:b0:5af:30d9:e2b6 with SMTP id 4fb4d7f45d1cf-5b7f5413f64mr11270812a12.23.1722970939764;
        Tue, 06 Aug 2024 12:02:19 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83960f26bsm6197488a12.14.2024.08.06.12.02.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 12:02:18 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1553057a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:02:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3CbAJAU/2rvM4MtRpjaJfmdbbFTQZsmP1TYRj9ymkkn4on3VSJESSl8qW3UzLCjI0RIFAhFqDqbh/WkeO4dXzTMeBTZTbL+zqSABL
X-Received: by 2002:a05:6402:22af:b0:5b9:df62:15cd with SMTP id
 4fb4d7f45d1cf-5b9df62178emr7137033a12.32.1722970938444; Tue, 06 Aug 2024
 12:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
 <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com> <20240806185736.GA29664@openwall.com>
In-Reply-To: <20240806185736.GA29664@openwall.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 12:02:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1w6+Xup=amYtYUCLO-SRYoy9R0z6BG-uGV=y2f6yFWA@mail.gmail.com>
Message-ID: <CAHk-=wg1w6+Xup=amYtYUCLO-SRYoy9R0z6BG-uGV=y2f6yFWA@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
To: Solar Designer <solar@openwall.com>
Cc: Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Kees Cook <keescook@chromium.org>, 
	"Thomas Wei??schuh" <linux@weissschuh.net>, Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 11:57, Solar Designer <solar@openwall.com> wrote:
>
> As (I assume it was) expected, these changes broke out-of-tree modules.

It was presumably not expected - but for the simple reason that no
kernel developer should spend one single second worrying about
out-of-tree modules.

It's simply not a concern - never has been, and never will be.

Now, if some out-of-tree module is on the cusp of being integrated,
and is out-of-tree just because it's not quite ready yet, that would
maybe be then a case of "hey, wait a second".

But no. We are not going to start any kind of feature test macros for
external modules in general.

                 Linus

