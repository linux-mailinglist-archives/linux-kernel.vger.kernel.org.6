Return-Path: <linux-kernel+bounces-394256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9549BAC7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ED31F221A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D018CC1A;
	Mon,  4 Nov 2024 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQEN1ezd"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2A18562F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701560; cv=none; b=n1jYalxKPpr3ALXHohBfkYNjBYCge8Y6vaXhQOs6zHzgR7eaz52/EsbHh74AUDIVELSKs/LbHrOnSsuByIQ0ZRjbJ5ca4nIF8wlOgD+IxYr1DZzFjXGhdtJaTrWrg6WKOhP1ETIPOTpmqKwCafUs7J/xWePk1j0kH1i+UmrJnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701560; c=relaxed/simple;
	bh=XsTtsn3hdBEJWqJwOlBbKqxovqNHWidcaWmpZlyJYXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmxgqmmPvT5goyPctk+uQbYLuUmjl3SwJgvfmKXqDfCYVQwgt9nQPX+fa/cObchZdVElvL5PNTEn2iMxYofxpcJ0wZ3fnTyUuxRs4bmOkJqpIkpjMV6oQFXA8b8oUea+m41fvuBHF9b2kve+7WflyHJupCzydItQ6OoZDQdYwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YQEN1ezd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso41258381fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 22:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730701556; x=1731306356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBzR4qyMN91FRimR7/U3Er005yyZVpanRcq4msuzFs4=;
        b=YQEN1ezd+lEPFR7QAL2P9cH8te1agw+Q4tEl70b4T7YUKjy+VM8lDjhJgjmQYdwgJ+
         8g5YWXHb02Fts6669jMqwX4EcPpOrRHHZHWIYSBvjiLVkLvkC2KRkJgI1Uh3Das1wO4p
         uGXCgC+JhN4UnOTcKlpb99JBF5Anh7RJUFkAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730701556; x=1731306356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBzR4qyMN91FRimR7/U3Er005yyZVpanRcq4msuzFs4=;
        b=v/2Ay86h1BwO3QLvDqdvVxeBqa2G7SJS3hduf1MgbuDvRbXR2141EF3s51dSVOQv6q
         x6/n8+1UvV6nJfxp7QJTsEzSfk/FNCNnsIZcuFvsjNlHr1nv0o1CzzZMcZyYriH4Ogau
         G8IysJiBN8jFCavhjeFIvb3W8ZnKCEw6h89INclJed5GD5aL14XvpA1f4WGXlOgsCM+a
         8o/TKW2dx4TjkeBFnLI244jI0lI7po5SRIEOBPTHbLKEiXCvNvmROzJl6oAG91w5KpJl
         WNjkOmMxa97dwMNCAFmC+2mgJB1WAfxaAX7G4kyjvAKVIy615nIiP48V+VX3CLd0OuP5
         suCA==
X-Forwarded-Encrypted: i=1; AJvYcCVMAXXGPnuPDJKjVNC3AJPVw9Y8CGJ0XCqa6qV5Iijv476E+lBrCySDclwsAQ55pSsje8Yvigdv3Q7Yj6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33KZWnzlIWj8qWQA9fTBA3x0puycqHUXDotKhEtRovCND+6t7
	1A1y6hmgpWdjeYq3pqtptLWI0N7Od7cJzjb3tvLH+k/Z/ho2WxoPxaEcbElZe9jneMf65xZgIE4
	r8PlRO102hOcDvuI0N/oyevCjWlEJU70U6Lw5
X-Google-Smtp-Source: AGHT+IHM+UnWnkbIWhA6LBG4BcD2vaEnPjcAIjqDv+LZBwE3AybzTpIkqH75u0xdv1cI+K2hsUNbLgWJnPZq/NPTjjA=
X-Received: by 2002:a2e:a54c:0:b0:2f7:6371:6c5a with SMTP id
 38308e7fff4ca-2fdef2a14e5mr42956221fa.16.1730701555834; Sun, 03 Nov 2024
 22:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031092504.840708-1-dualli@chromium.org> <20241031092504.840708-3-dualli@chromium.org>
 <20241103151554.5fc79ce1@kernel.org>
In-Reply-To: <20241103151554.5fc79ce1@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Sun, 3 Nov 2024 22:25:44 -0800
Message-ID: <CANBPYPj4VCYuhOTxPSHBGNtpRyG5wRzuMxRB49eSDXXjrxb7TA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com, 
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

> > +/**
> > + * binder_genl_init() - initialize binder generic netlink
> > + * @family:  the generic netlink family
> > + * @name:    the binder device name
> > + *
> > + * Registers the binder generic netlink family.
> > + */
> > +int binder_genl_init(struct genl_family *family, const char *name)
> > +{
> > +     int ret;
> > +
> > +     memcpy(family, &binder_genl_nl_family, sizeof(*family));
> > +     strscpy(family->name, name, GENL_NAMSIZ);
>
> You're trying to register multiple families with different names?
> The family defines the language / protocol. If you have multiple
> entities to multiplex you should do that based on attributes inside
> the messages.
>

My initial plan was to use a single "binder" family, which was more
straightforward and cleaner. As Android uses multiple binder contexts
to isolate system framework and vendor domains[1], Grek KH suggested
the netlink messages from different binder contexts should also be
isolated for security reason[2]. Personally I'm fine with either
approach. Please kindly advice which implementation is better.

And I'll fix other issues you mentioned above.

[1]
https://source.android.com/docs/core/architecture/hidl/binder-ipc

[2]
https://lore.kernel.org/lkml/2024081350-establish-direness-38ee@gregkh/

> > +     ret = genl_register_family(family);
> > +     if (ret) {
> > +             pr_err("Failed to register binder genl: %s\n", name);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
>

