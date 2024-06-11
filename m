Return-Path: <linux-kernel+bounces-210710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C69047C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78552833BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC184D14;
	Tue, 11 Jun 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T/oJx7Xh"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE04502B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149753; cv=none; b=Jgm3WQbQR5/JirIwYiwt3NiG0dH74lPKdVftCjhE4U0t6a/L/lN9DzNIIO+GgoiGIVayxp/bucRP5KqU2pTMsBJQqwIKXr1fdz6s34/JY8R5WpIB6osbTtDXV7T6/uWv98E2sIqkixeZ58V2QGWVB0xfIBNvIYZ8fKGG0pcX4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149753; c=relaxed/simple;
	bh=MfCuiDlGE5fVIpNHzQbptf92l3+tLlaspIehN8mGxu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIaXsGCOlQu8VVeULLdP8KmSH9ZByBNeg2p1cCMOrTfRyjNBJIoPnboW21alzDUG/uAwE/EY254cGcTBSRBLyGqziGODtEIePYUDH1GaPaj+JpDgWwNgCAJKHFcnzXGJXeGBJCIwRs4ufXoP0VX6/+61/wiSX65D7STt4vgaa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T/oJx7Xh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebed33cbaeso18099611fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718149750; x=1718754550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EqkLHEUnRpx3bEdLAK1LvE4jsudBYwa4x2JWr8tT2p8=;
        b=T/oJx7XhoEM/HKIfCJb5/bpEH9dGAEXjJNJQbaNCHNiwtV9ooumbQtitNUDoKHVTIH
         Up/0vJf4Q7LWVFl67B/tJIN20A74qHe4iIsP72Y2eF7BTkf9FeGAIi+/S9RHSs0cdMyG
         4I3pKIVQ/3O441/DZ1q4tklJW22WhQ6Z+BEvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718149750; x=1718754550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqkLHEUnRpx3bEdLAK1LvE4jsudBYwa4x2JWr8tT2p8=;
        b=oLULJRHeAj6BpItyzTVrybwD5jz0KCj8GdbwYlNeFE+jQWkVxIuZSMNt5EzNu2jCTc
         3yeUxh7daGKkrS0/S8sJlFTmsVTmJKmszMeebFkZAxApnQ3dOU520Jc5dLL4hXCjgJbk
         kVXiRv7GNYmSce4JQuaAcIZLq/ABLahVbzFyeQ3W8LrGSC6cEb4l2nO1GPKwHDVnKWOe
         uRHIuL8J4LWR9KnCg+8Y4ps1NzyFXd9uZ+5Y3NBa2NNLbvCvk95kVmmdnTJV8poRt3v7
         T0rcbsel/lp+D7++lAks39TeumQyo7YI0s/kmwzE3osRLn+mVYE2nqgfCd1PnOO0TdRm
         Kw+A==
X-Forwarded-Encrypted: i=1; AJvYcCWCQzSPK3sMOUtrDok/nupLgfpC2X7AxHVren4ZeJqAfZ3cdtzdG9TFlTHClUlzHhPhvWZtjFZmp18+7HWUytDx/1vDoi1mqoGV13IO
X-Gm-Message-State: AOJu0YzB7OxlvNrxDbST8yP9nmX7t2ndRLLSEUOLY2ye1HXLBk9fXaxL
	hfZHPCL1RenfjRwncSNb8tnF5ZfmYAFu28gG+qe5kY1LCycg4ZRfz/b/3lSqfHY9LG5eX25vQ05
	upk7agGKt
X-Google-Smtp-Source: AGHT+IEbUI66hxt6dY6ApHaQDXi2ich+v5S0s51bo1C0DjO/MeKmF2EDACyi7uvn17Q/BFrQloK43w==
X-Received: by 2002:a2e:300d:0:b0:2eb:e365:f187 with SMTP id 38308e7fff4ca-2ebfc9bbf37mr987361fa.6.1718149749710;
        Tue, 11 Jun 2024 16:49:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebfb5cc4b6sm882141fa.16.2024.06.11.16.49.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:49:08 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so16264841fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:49:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWzrj/xAif6vQX/1GPvSuMZeGBRQJdROyH5wm7MuvkeFSg5R0d3tkVZsMlwMTLPengs8k/BH5sf2OpCnxVVP1idbARGdmGahDsNdKS
X-Received: by 2002:a05:6512:3a87:b0:52c:94c9:a403 with SMTP id
 2adb3069b0e04-52c9a3b9889mr116248e87.13.1718149747613; Tue, 11 Jun 2024
 16:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com>
 <87tti9cfry.fsf@intel.com> <CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com>
 <Zmi9bVdd8uNeqkWl@yury-ThinkPad>
In-Reply-To: <Zmi9bVdd8uNeqkWl@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 16:48:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRWi1cUPQ2BrWCi-Tm3Xv3is0SbAktqkYQx5VBF3cNoA@mail.gmail.com>
Message-ID: <CAHk-=wjRWi1cUPQ2BrWCi-Tm3Xv3is0SbAktqkYQx5VBF3cNoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] treewide: Align match_string() with sysfs_match_string()
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Lee Jones <lee@kernel.org>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Johannes Berg <johannes.berg@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Robert Richter <rrichter@amd.com>, Vinod Koul <vkoul@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Nikita Kravets <teackot@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Eric Biggers <ebiggers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	John Johansen <john.johansen@canonical.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Jean Delvare <jdelvare@suse.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jason Baron <jbaron@akamai.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 14:38, Yury Norov <yury.norov@gmail.com> wrote:
>
> On Mon, Jun 10, 2024 at 10:08:00AM +0200, Linus Walleij wrote:
>
> Hi Linus,

Real Linus here, not that other non-real one.

> I think about renaming set_bit() stuff for atomicity at least twice
> a year.

Yeah, no. The double underscores are historical, and not always great,
but when it comes to the bit ops they are at least fairly obvious: the
double-underscore version is the "unlocked" version.

That is, in fact, the very traditional logic for the in-kernel use:
the traditional model for double underscores is the "this is the
underlying implementation that doesn't do the whole thing, don't use
unless you know *exactly* what you are doing".

So for the bitops, it means "not atomic".

For user accesses, it meant "doesn't do the full checking".

And for a lot of other things, it meant "you need to take the proper lock".

So there's actually often that kind of unifying logic there.

For this match_string() thing, that was *not* the case. There the
double underscore just meant "non-array interface". I NAK'ed it
elsewhere for that - and other - reasons.

             Linus

