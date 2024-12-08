Return-Path: <linux-kernel+bounces-436241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A99E830F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 02:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185B81883D79
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3617BCE;
	Sun,  8 Dec 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cBmPfzJ9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4F136A
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623140; cv=none; b=vFO+eGsJIadCHFWyp4iGP0AR35utsa38xrev3emrtmzWFujpnQD1mF9Qw4+TGzRFpkkOctI4R/1Fp1o1aozmjI4zvlGY2fxZjO9yYihez3gM6tXOUzeMbQMUPO4o2+nqHdoTZ55SFkFpEw6GTrE25PHVKMyYHBTXNUFWz5hnQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623140; c=relaxed/simple;
	bh=IAtH1QPZVCuHz2tcdeD7lZlJGCLbl6dYQADoubFHbLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8jw5JHbcK/jj5f6ulb3BonDJPo2eP1K6wRMjOlqy39lk25NtL/JkJFyZHb4mRT0DivV+LAuz0tpN2mZNVhZ3+mDFhJd7MPCsQq8OIJpr78eeH9cTfnufOZJQYNnvl3jK5Gu/uLH2RVdlbvnQ5J6S1YLbgDcGquxYK3AkFCDITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cBmPfzJ9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso434870966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 17:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733623136; x=1734227936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZjbRKhMOCLvsh/fbuGewVnDsfkV1Y6IoPuC3JohNPQ=;
        b=cBmPfzJ9s/ZqmRU2JWImdwfJG7vJs8Y7q3P6lt0T2psOHUd7Za0NJRSVlwTGT2O/kR
         EzCkHVPj0UO3F+KmgoEy/PE8P8bR4bFcUpHlJFm0RWq0wchw3pzktaxNUArDElitrMCi
         H3qdARXzUOZaZN5fNd6A2XI4G0O/x/prVcEAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733623136; x=1734227936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZjbRKhMOCLvsh/fbuGewVnDsfkV1Y6IoPuC3JohNPQ=;
        b=BdCDyj6hpZt8ePu5xU0weFP41yOH5AdM4Rs8HTqcCxjAml+j+I+qLurtFALMDE+Mjj
         4UD5aXll7GpJ/+AbBNuiSUAAwjLTi4kLtRxHXFwO3ZwsFvLXTxcsqw322J00jVrreLS/
         IBl+RfFIIT/0cf+bChuVkVRmauVuVo0ArXtXKCz7ra7U64YPf3p0wIisTnJmrk3Yojjn
         m+WWWAnThsAO+01RyvhmIb8e5nfSYPPIDtoTNylwpPBKRtuGrac5ycBR2RiVLKA4rzMe
         ileRALhDQfbEGkx/HQZ8TxMv2XnWPg0sAisZyuw9KIasC5mbWuF1pV9CaX9WCDBAmTln
         1wxg==
X-Forwarded-Encrypted: i=1; AJvYcCWkQilgKmVrmRYEVOq4a6Rx8Zs/+Z4B9OaEoxdNRgOI9EDtDDHfsFrG17UaGbJtbHBl2+1fKbNEhMSy7+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvu+w4O8UZu6nLrvOkOvkpULEPKdMmXlAvMlEfHTYQwTb4khiQ
	q8ISAY7e42ZNPRL2mayxnx2px3ogopuwMo8fvZCYffykDZzPMhUP7c8D2Ldcs3hcDZLYcAD75Bm
	OPYZ3ag==
X-Gm-Gg: ASbGncv2XDXWnS7Wpbw+qUOAMJVSyXskj21h4hv299GobJPFtkM+YwONVOz/ZiKsfpC
	e+h5eqCiSxGEbfmqZcuKQVSguaSS5itEqlOLqH6RkDyOiODS8lOHR3BfOsVYh/tFjCIM948omFL
	c5fpdDKzV7fzrkHd0Eo4oC8WQgBrJiKPja2wZ37+xwfV17ni2WczvDcjCGnHa2WYoVLU3+VLiss
	dmiDKPUOhXztiOMrxgmhlSFClrI8oLX0DMI4yZQRkzSlsFeXRxwQBjh4Ly3BxHSRgVpQDDmMks0
	lVIkjjM3YvqTaUMZBgJ1i+If
X-Google-Smtp-Source: AGHT+IEV2dRQMw7yLO0woQ1gEgmFf4MHqFiTfvocV2jOb69TOa9okl7s66O4cAqYjkKjsaYLmQzzZQ==
X-Received: by 2002:a17:906:3d29:b0:aa6:3f93:fb93 with SMTP id a640c23a62f3a-aa63f9405dbmr511995966b.42.1733623136326;
        Sat, 07 Dec 2024 17:58:56 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6552b29a3sm151389766b.86.2024.12.07.17.58.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 17:58:55 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso434867266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 17:58:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWG8DMTNuMMfd55E4g+SyO29GglHWdvhgnyYsMoJWS72UbDvDm+eKYb1/XPqptWy1l66/D9QEtVarN+o/Q=@vger.kernel.org
X-Received: by 2002:a17:907:84c8:b0:aa6:2fc7:71aa with SMTP id
 a640c23a62f3a-aa63a24f1famr565813866b.55.1733623133832; Sat, 07 Dec 2024
 17:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de> <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de> <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
 <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de>
In-Reply-To: <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 17:58:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVGmj+nAju2XuWWD_FZHdeytRW2XX5D-L3MqDuRRciVg@mail.gmail.com>
Message-ID: <CAHk-=wgVGmj+nAju2XuWWD_FZHdeytRW2XX5D-L3MqDuRRciVg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 15:52, Martin Uecker <muecker@gwdg.de> wrote:
>
> Can you point me to some horror stories?

So the main issues tended to be about various static verification tools.

Ranging from things like the stackleak plugin for gcc, where handling
VLA's and alloca() (which are pretty much the same thing with
different syntax) was just very much added complexity, to perhaps
overly simplistic tools that literally just check the stack usage by
parsing "objdump --disassemble" output and then building up
approximate "this is the combined deepest stack" call chain
approximations.

And even in the *basic* infrastructure like gcc itself, VLA's simply
made -Wframe-larger-than= just simply not work.

I also have this memory of bad code generation (again, this is 5=
years ago, so take this with a pinch of salt: dim memories), where gcc
wouldn't end up re-using VLA stack slots, so VLA's made the frame
bigger for that reason or something like that.

We explicitly use "-fconserve-stack" to get gcc to reuse spill slots,
because gcc has been known to sometimes makes insanely piggish stack
frames when it just creates a spill slot for *everything*, even if the
spills aren't live at the same time (think big functions with lots of
case statements).

We also had several cases of the VLA's just being silly, when a simple
constant-sized allocation just worked fine and didn't generate
pointless extra code.

Pretty much none of the code core actually ever wanted VLA's, so the
end result was that we had these bad patterns mainly in random drivers
etc. Don't do that.

                Linus

