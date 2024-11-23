Return-Path: <linux-kernel+bounces-419283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105299D6BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A9E281E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E31A08A6;
	Sat, 23 Nov 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="N1CLjlot"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92719CC21
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732399955; cv=none; b=l/aT4gfXCyrIfkU+IuXptYQwLgHGz6U+r323l/pby74i2ES6bWjxSsMhukErXdris9Ega5dU+tI7bpv2WaL76x2X8jM/Nio74+ODU3mlJVHiJtkHLH1sPpadYNb0Ym7Y55INLbTicbs2SpeF28dpBXXKjxOBQomWgUiJsX9ZZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732399955; c=relaxed/simple;
	bh=cnT8cxB4f5vl4i47fA3TpvN9eokvJjXCcRbdJWJ/p8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iwyK3n0+7tev49rqs19z5UAjLvXFZoh+VpcMsejNQGsheeVn6nq1rDaDhsXE2+ejXN0701MXt6ZIxo4kAi62Ky/u13kCaT2XNJPPHwMhpVmF/wAxDDAoUc2tB7B9qvJ2LRnrgqtjSni8uNUlzGsGtN3CNqcod9i+REHhF2HV32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=N1CLjlot; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so39849365e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1732399952; x=1733004752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hJMk1Q9thPNNORDbV2y9r+sPvljGjGuxKg/TqvIb0s=;
        b=N1CLjlot5/Hf+oN7kS2Pw3JtiBmYdhn5SIpHmpJjXRTMNN7d9Iq7WaFVybsEwJUF9T
         ERsTe6Cu3iCeXJ3sa8f8j6rAZMk5uDg0dO6gwZigndfW7B23ptxe8wQfCsqD7NY4PTNb
         ckSzMcTix4EBrUlfvJmYxNWcpkOZELTeRVZPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732399952; x=1733004752;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hJMk1Q9thPNNORDbV2y9r+sPvljGjGuxKg/TqvIb0s=;
        b=FOuD5PX2LNlkWQVSEthkI7qNTqYPp3Q5xbr3rHVCKLy10+rKgTlrbz2ywAoegpvEkT
         h0B8JRI7xkOPt88KxhJ0GWnLdxvPurj70uiUm6l2QTrxkphvBS9AYITEPESPNH4cn+tZ
         D68l6+nVQveMcVw23MYa4cqTqdtETrUcC2XxzPWtaVlYVDu3+wg8O8TtLxkp22Deh88p
         pJQ6UKB+bpQ2G2IHGl6jE+xXg/BPPzi/gHLInE1NStCfVKKwsOt3KtcH7eGp08sVGE3f
         WC/rUOvas4lpeuNbyXMh6Nfy83asdIhFNUQ3Vl+VEeRrrbHPzl19YHzsHKEPUuJ2xNIZ
         Sb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVW6OrHKp01bb7JEkk65ZQXydoceA0CWxgBJlNjVwkgo5XxMAwqXxdcClE/Y9mFKxCBzTZFDIZE4KG7onA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pUzytxkZxy0YmBoYWv76FfCtOWZiF1nKeabPwcn5w7PWR2pV
	IjoRhd05twMKDIUfhL1vGkEUWVQPrZZk8x5Sh0agIius9nt1TEBw2o50bOoXf+E=
X-Gm-Gg: ASbGncul0U9dzBv3IWUtr6e1DR2fx1zkcgqlUA7MLaanjYEGr56q/lbwTO9xo3ZenVi
	HEsZR010wBrvRVvWK3baM5EuwelGAfWonPv8Hklm9j9DQT0TJOovTCwJ6QoNfrkGo1a5MsQwZMS
	/149aU79arxSIIjYarStMheP3K87Y7M4QqsXFRT3hqGJ7F6ajFwn0N2XBJ3PNBWbBcBWlzheDrr
	CRa0ZndFui9J++fmiJalC0dkzRHE+6qvmFNa69y2E7+zjxI9w0OBU53btmd5Ua0dka5cBGm5KMG
	Kd1+vAJk
X-Google-Smtp-Source: AGHT+IH0FJ1dScWxXh3gke0ac3724CE5YTFEz4/6/BNARCRAO2i7EPuxXcsfzjRgGjmKk6XA9cy/hA==
X-Received: by 2002:a05:6000:154c:b0:382:440e:4e88 with SMTP id ffacd0b85a97d-38260b52679mr8610591f8f.16.1732399951587;
        Sat, 23 Nov 2024 14:12:31 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b58ae64sm270623566b.169.2024.11.23.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 14:12:31 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Sean Christopherson <seanjc@google.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>
Subject: Re: [PATCH v4] setlocalversion: work around "git describe" performance
In-Reply-To: <CAK7LNAS6aU4L+4JyDXzncMVsY+6XRYTD=RkhcXSUXTRh_WxWWw@mail.gmail.com>
	(Masahiro Yamada's message of "Sat, 23 Nov 2024 17:06:50 +0900")
References: <20241122150037.1085800-1-linux@rasmusvillemoes.dk>
	<CAK7LNAS6aU4L+4JyDXzncMVsY+6XRYTD=RkhcXSUXTRh_WxWWw@mail.gmail.com>
Date: Sat, 23 Nov 2024 23:12:39 +0100
Message-ID: <87iksdk3ag.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23 2024, Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Sat, Nov 23, 2024 at 12:01=E2=80=AFAM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:

>> v4:
>>
>> - Switch the logic to make use of the return values from try_tag,
>>   instead of asking whether $count has been set.
>
>
> No, please do not do this.
>
> As I replied in v3, my plan is to set -e, because otherwise
> the shell script is fragile.
>
> With this version, -e will not work in try_tag()
> because it is used in the if condition.

I'm confused. Previously you said that "either style is fine with
me". Now you've invented some necessity to add "set -e", which of course
yes, is then suppressed inside try_tag. But there is not a single
statement within that that would cause "set -e" to exit anyway: The only
one that is not a simple assignment or is itself a test is the "set --
$()", and git rev-list failing there does not cause set -e to trigger.

Aside from that, I'm skeptical to introducing set -e anyway, it's simply
too hard to reason about what it will actually
do. http://mywiki.wooledge.org/BashFAQ/105 . But you're the maintainer.

>> +try_tag() {
>> +       tag=3D"$1"
>> +
>> +       # Is $tag an annotated tag?
>> +       [ "$(git cat-file -t "$tag" 2> /dev/null)" =3D tag ] || return 1
>> +
>> +       # Is it an ancestor of HEAD, and if so, how many commits are in =
$tag..HEAD?
>> +       # shellcheck disable=3DSC2046 # word splitting is the point here
>> +       set -- $(git rev-list --count --left-right "$tag"...HEAD 2> /dev=
/null)
>> +
>> +       # $1 is 0 if and only if $tag is an ancestor of HEAD. Use
>> +       # string comparison, because $1 is empty if the 'git rev-list'
>> +       # command somehow failed.
>> +       [ "$1" =3D 0 ] || return 1
>> +
>> +       # $2 is the number of commits in the range $tag..HEAD, possibly =
0.
>> +       count=3D"$2"
>
> Redundant double-quotes.

Perhaps, but sorry, I'm not code-golfing, and trying to remember when
quotes can be elided when variables are referenced is simply not
something I spend my very limited brain capacity on.

Feel free to make any adjustments you want and commit that, or drop
this, I'm not sending a v5 as that seems to be a waste of everybody's
time.

Rasmus

