Return-Path: <linux-kernel+bounces-412218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 445029D055B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE69B21CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02A1DA619;
	Sun, 17 Nov 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hGX2bqXj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210691DA602
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870192; cv=none; b=uGJxA3ItOLYol9D7O/4GfGJVAcHvWAnbiwK0Tq0bVH7ITnhjNGNvi3OjJWzcGEVdS+2FxUV5BvvaHrRem1QSp44TlO5RXCRAR247MNT9S36vi0tiWGKF06T+qoM8RzzubXIlUpwk3es7LZ8InQqx8gww4DU97zRNVKkc15hrToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870192; c=relaxed/simple;
	bh=PbCBqaJHyFRDMeonXV3O7iZF9Acjc/0jknvwxclpPpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsF8onf95AKSdfRG9GK6JNqKz8atw5HCiTfYrd6jgOrtevrDDP+FFP5dKB9/yVJJ04sg1hb/XULB94ldDG6HVBDoTz5uhTHfeiUR5vYUN1DL5ZHZmjW4cBoDuN7AA6uEtQL9S3OboX+xFAf50s4gn3k10L0ecTdWwTg9b/UyfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hGX2bqXj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so607594166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 11:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731870188; x=1732474988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpvG0qQDXuWwD4N53pblBbRWNlYroopV0zVsAjj1jLo=;
        b=hGX2bqXj5Z9gMLHhHgN0F6nDg4iFRMQzCn0mduZkxiiutLE6yUBQcgocZ9y0T9x9Bi
         0z6mnmu9L/EVGynI1FT5Gp5VdeAVVQHPmaPzDA8tgTJNwAji7Ox6vzn4JXYHYm0E//FI
         CfRO8uvnzHkY9ahGxuICS5qvnTrG4zuw1ZZzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731870188; x=1732474988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpvG0qQDXuWwD4N53pblBbRWNlYroopV0zVsAjj1jLo=;
        b=HCFpZrzDDZ/lgEgOgZ1iyYH2ngfbfZhJpJMB7Q2KzNesQg8AM0t5u0e799sjr0fAoY
         szhdHEKmaAgEW1iAW3FzjFbGXEzpQFwI3PTn584KY5QHDSvtWgl61HGRErKbFMgbdkm9
         NAlF5QHIkYx9pYOBUQsshn8A7dDkHROBRZhrGB4nltQgKujWROcDuJZhHkbJhchvrYoS
         IZH4fp9M1KXPW+6yV4SdLubuF8oaYEnqBhUNpD7heSNlubHFJqebY6cHVxdT/QSmkzBM
         oEqlCxr2Z+EMO+RFmlgebzdjUWkEyxPZcBkWJyxMOJw0cpbsV/57GvUmU66RAxWNYeH6
         5bSA==
X-Forwarded-Encrypted: i=1; AJvYcCVcyhI2rPAjCvzVX3ggGgrSDcC+/BXmqkk+R7UJ583jKcWThxftH1/vVp6uil9Ch7EKZPmQw8s9r7AWWWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqobzx4on36CZTZj7ICLdOXpanjznL+BRliTAPC8dbyJUDD38G
	8dOclx/f67ppkkSgLtQg6T+5zK4OK7YEGYxO8MQkxOj7bGGJo4EU+xsywgU8ayx1ud2k9IhEinK
	9ZPr82Q==
X-Google-Smtp-Source: AGHT+IG1S7exdDL5fZcz3DBPgfC8Pyz7U8P3I3TS+Atoz+AMhYM8PYotucVeb9b0Ib5xIuGBsiP7MQ==
X-Received: by 2002:a17:907:25c2:b0:a9a:6b4c:9d2c with SMTP id a640c23a62f3a-aa48354e48cmr873857666b.59.1731870188277;
        Sun, 17 Nov 2024 11:03:08 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c5esm441243466b.32.2024.11.17.11.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 11:03:07 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so5961455a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 11:03:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEuhpQNs4WDiIxiu6C+LC9sVXMHPOZFJPUOBW+Ge7ZB0spz2syWLwvA3OdmhnsrWom9UOqT94uWU1FslU=@vger.kernel.org
X-Received: by 2002:a17:907:809:b0:a99:5021:bcf0 with SMTP id
 a640c23a62f3a-aa483454541mr826309666b.34.1731870186621; Sun, 17 Nov 2024
 11:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
In-Reply-To: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 11:02:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVDzempHTWHMRpbSdCpFhSyfcLyfx2XvSTZNT-MNSS0A@mail.gmail.com>
Message-ID: <CAHk-=whVDzempHTWHMRpbSdCpFhSyfcLyfx2XvSTZNT-MNSS0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 10:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, something like this:
>
>    /*
>     * iff 'x' is a non-zero constant integer expression,
>     * then '!(x)' will be a zero constant integer expression,
>     * and casting that to 'void *' will result in a NULL
>     * pointer. Otherwise casting it to 'void *' will be just
>     * a regular 'void *'.
>     *
>     * The type of '0 ? NULL : (char *)' is 'char *'
>     * The type of '0 ? (void *) : (char *) is 'void *'
>     */
>     #define const_true(x) \
>         _Generic(0 ? (void *)((long)!(x)) : (char *)0, char *: 1, void *: 0)
>
> should work, and doesn't do any double expansion of complex arguments.

Always good to test things, and it does seem to actually work.

Interestingly, while testing it, I found what looks like a (harmless)
bug in gcc.

Gcc seems to think that "!(void *)1" is an integer constant expression.

But technically, only *integer* casts can be part of an integer
constant expression.

Both sparse and clang get that odd case right.

Practically speaking, this doesn't matter, but I'll claim that my test
coverage was at least interesting since it seems to have found a
compiler issue.

Maybe it's a documented gcc thing, I'm not sure. Regardless, I think I
actually prefer the gcc behavior, but I don't see that it really makes
much of a difference.

               Linus

