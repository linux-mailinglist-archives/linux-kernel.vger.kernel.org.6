Return-Path: <linux-kernel+bounces-412074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25829D0382
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706A11F231DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91F167DB7;
	Sun, 17 Nov 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OZ4rD0SU"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A326AD4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846024; cv=none; b=mkE+HeEh95fc5qEph7nL5Yg2xzbEC1gnf4qlXeyxQtdWVOI3sf+Xpz3/8ui4LeeFweHwNKuzlgAV5iRrMgEE5pBTOh9CEZ/6251uTySTrDEa67aXEzjK5Zwyr1HZ7dvtMNxsDJYuCRA4eYoEoITurah1zLO/6Hzywfx9Jn1IXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846024; c=relaxed/simple;
	bh=Xn9Aff0GaEHMgTe+qpIhJ7LjEw7nEzMPjRy8ZHxAwMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctDAKxdNlS52wFUv6MU+HItbJJr1sPBtK7WzUWFCucpOquMFMENODY8ANXC0nSdhXaH7z3dn8xzKvi5C8DqTIdmmc4sgKOtEE1PGzRNvXRyfHMv78zsMEGvqPLKEMrMcHyCP2/dtERH9xsMgb3WWCKLeaWVctGvNYw6ufzBc83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=OZ4rD0SU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so5577969a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 04:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1731846021; x=1732450821; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4XseF3OExb84Zjt30i5aIBrFrlbM4+RglTBqSWdxcg=;
        b=OZ4rD0SUAXlG0fhtCR+RvWygMUUf7kTS2rCdzn56Y0Psst7wfcDr3bSpj5Nd1WZPod
         AbSI+MvrF01UdCizukG5BdiSou7KrSLztezpY4xx0jXQzNIrOQTrI7x0tP7LUaVrBjPZ
         aQxpZofcjz4gi/kSwh5ZcZ64nc9Vr0gM7UkDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731846021; x=1732450821;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4XseF3OExb84Zjt30i5aIBrFrlbM4+RglTBqSWdxcg=;
        b=vvoSGcXuf25hpqMjC2Sid99YaWiAV6V+75rb0XG2TvjA991j3vyoYMJlZhz1ZI1jcc
         v1R0H32dHf4M6kOjr8+Gt2aM0+WqLnynI2voVXcC6ozVazkXnat29td4CGcnKTWqd4lM
         4Pm6j6Gjo5ff9UrCFxt82h0fAmTqiTDBDr0DkSX0jqHXYW72DRRvvwkH++M8yBkHyHb6
         kRUZ6kVe6dJ4U0IuyMcRxhe0vnaVpfSgif5OdV0xIQgRlq7MpK5DxsYFtt0pxFplaj9P
         cY+mSjmyv9enpSVLDikC6UfyQw9ixIqmC4QuSnx62oNNev2JmWdBiws6/HG9APjt9q+B
         8o8A==
X-Forwarded-Encrypted: i=1; AJvYcCUrqM9SRYKyjYXkNHOXDV2M36gTlYbYmXwsgfSCYUk+1eqSRwAwMNYuleBA4M8+M1VOhQY3ZiBxL7mv5rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQy+6SuVsu1zreEuf7pqXCP0UPqpSjyErHFLWgCLd4G9Ert8wc
	6LMdI4AgXRLN8ZR8hBwHg8uScVBLGTnth+jnBJMFzU0ewgwHOGWez6dgIrOD4LA=
X-Google-Smtp-Source: AGHT+IF+Wz3ni5Ixv6eALqeuB4zReAiuZsSnelqBtluHJ3O6ewqSVF5EXdKkcjZjCGFIcDQ3nGUWPg==
X-Received: by 2002:a05:6402:520f:b0:5cf:9ec:1b05 with SMTP id 4fb4d7f45d1cf-5cf8fc87683mr6543838a12.11.1731846020605;
        Sun, 17 Nov 2024 04:20:20 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9f4e6sm3558728a12.29.2024.11.17.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 04:20:19 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,  linux-kernel@vger.kernel.org,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] setlocalversion: work around "git describe" performance
In-Reply-To: <CAK7LNAQdxx6yHGc9-+=aQxeOkBs-qGxf_1namqWp-gUwQ-uo-w@mail.gmail.com>
	(Masahiro Yamada's message of "Sat, 16 Nov 2024 08:17:36 +0900")
References: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>
	<CAK7LNAQdxx6yHGc9-+=aQxeOkBs-qGxf_1namqWp-gUwQ-uo-w@mail.gmail.com>
Date: Sun, 17 Nov 2024 13:20:27 +0100
Message-ID: <877c92m4qc.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 16 2024, Masahiro Yamada <masahiroy@kernel.org> wrote:

> This patch was not sent to linux-kbuild ML
> (and it can be one reason when a patch falls into a crack),
> but I guess I am expected to review and pick it.

Sorry, but get_maintainer.pl doesn't tell one to cc linux-kbuild.

>>
>> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
>
>
> Maybe, the comprehensive tag list looks like this?
>
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/lkml/ZPtlxmdIJXOe0sEy@google.com/
> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Closes: https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org/

Fine by me.

>>
>> +try_tag() {
>> +       tag="$1"
>> +
>> +       # Is $tag an annotated tag?
>> +       [ "$(git cat-file -t "$tag" 2> /dev/null)" = "tag" ] || return 1
>
> The double-quotes for tag are unneeded.
>
> "tag"  --> tag
>

OK. The current script isn't consistent here, though (--no-local and +
are quoted where they need not be), and I find having the quotes on both
sides of = more visually appealing. Not a hill I'm gonna die on.

> This function returns either 1 or 0, but how is it used?
>

Well, you're right that it's not used currently, but I might as well let
the return value reflect whether it succeeded or not. I played around
with some variation of

  if [ -n "${file_localversion#-}" ] && try_tag "${file_localversion#-}" ; then
    :
  elif [ -n "${file_localversion}" ] && try_tag "${version_tag}${file_localversion}" ; then
    :
  elif try_tag "${version_tag}"
    :
  else
    count=""
  fi

but in the end decided to keep the current logic of testing some shell
variable (previously $desc, not $count). Still, I see no reason to make
the early returns do "return 0".

Rasmus

