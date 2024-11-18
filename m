Return-Path: <linux-kernel+bounces-413276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB99D16C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C69B21959
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323C1C07D5;
	Mon, 18 Nov 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iNG5vNci"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCA1BD4E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949816; cv=none; b=KztQGNv12Ki3GujOtLuhatI5f3kLdBDY6uYUJmXoFz8g5ajgXpPqmVNzYD44ehWt4w5f/0Tc/owqPy2tAsE2yqJf0JUv9UnyAAzXllRZDih3bsJz6Ac/2Spt8ye4YajUgLWbKw1TdUVIB8u4YxGUpGPUjFxG33CZF9GqhmTBDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949816; c=relaxed/simple;
	bh=W0Jl5ocHSP4PGYw8LxtnuPw3akkRY4E9C/tdE6Gbf2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftVB/yUtoB7ufO1A/3f9ZjVOvM2uKVxlLOXF7UpNBs0fFfhklPH9FXuqCj5Da1o7bolPU0r7XfKbts8Ik0SBiii09w0m5EiRCTWceDTEj0DzZMHFsuGPwNqVnmhnwGcRSEq5k8lrlYKoCEXz3xx77FARX6gpbNFY183BRtr+cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iNG5vNci; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso1865780a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731949813; x=1732554613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHhSpMFQSzvTkKEefPe2mtAUvRV1u6SYwiNS6wbH29c=;
        b=iNG5vNciWnZuo40+8zsdGU6zhGHAZGz3dyl7X482LRMdFv2GmvVQLi9JPlutL/z++D
         jWA3lOfSc4I/aGYuH/QbuuFaojUazbRlRe7MB52kfB7/cBFObRjLR22W9c+lF+c1CfPj
         gjmPIer5IL6a+axphpoA2g9xb8PMjQ9nsAfF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949813; x=1732554613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHhSpMFQSzvTkKEefPe2mtAUvRV1u6SYwiNS6wbH29c=;
        b=lX4rmZSahOif+/dJ56kWU3kFXk8B3FNZJ80IqdyxoW9oRKmPKe7q0MbacnGYcSl+ts
         80KXpMaG+MmcMlUPKD7twwd0DUJW7rgyCv1/9N1aTtnBB8x/sBnoBZzHgv3ht8MEAKF3
         4SsccXp/Z62s8tc4csSq3M3YqJGmk/nGFUjuKkfaM07aOhsj2OChludzEOtyENnJB5m9
         x2ABTwE5O0k5N9tyDfx2u2rd3JNBw/x8/PaE+D16jIav9Ox9jxMZqUQuFhWYWluhMlm3
         nsfU0eV8d7ITVQ/DNsEDg2UTOiWQnNdbjbHcQfQyuHfz4iHAs1tF1IfRIN6V3JQjTn4V
         s7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXE2u4G1pH8oSed6zhVkBhps8CazvvC2Wm4Fzsdc/tYJXoqbKRhVNpZDMQj4oCV+0OyQLQUzMctzISrx/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHF+fOv1lJazRX9WPRE+kM5c/fUyGDLXPDYdxv5YpuqWPuENH
	sqx7orYIPbP+y2gqCfcJL9vcTToUD+Kl85nKPOm75nN8jakE6IMgpL65fD85HhEDVkKES+GA6u7
	qPYyskQ==
X-Google-Smtp-Source: AGHT+IE7ZBEpnNtN+jqn/Wh/RUVCVpZYwrtrHeeOuYDg7iJQvGWYO7srbeHe8Znbn+qFJGcDyZxciA==
X-Received: by 2002:a05:6402:5252:b0:5cf:c007:87ad with SMTP id 4fb4d7f45d1cf-5cfc00788f2mr4523774a12.23.1731949813076;
        Mon, 18 Nov 2024 09:10:13 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfaca26fdesm2726365a12.47.2024.11.18.09.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:10:12 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso1865740a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:10:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLaXDrYaWKaQdMLiSWwhI4yZ6/d6wfD+QF+gSX19rBvn26nGUO8OBdBVJeITtLSnvqHMrx6IPocp4VD64=@vger.kernel.org
X-Received: by 2002:a17:907:2d91:b0:a99:f8db:68b2 with SMTP id
 a640c23a62f3a-aa483421ca0mr1154348466b.18.1731949811840; Mon, 18 Nov 2024
 09:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com> <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
 <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com> <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
 <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 09:09:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0r4XutgSRxzeEi6QQUJ4oej5o-kdS8j02KrLEXT4WnA@mail.gmail.com>
Message-ID: <CAHk-=wg0r4XutgSRxzeEi6QQUJ4oej5o-kdS8j02KrLEXT4WnA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: David Laight <David.Laight@aculab.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 19:22, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> I did a tree wide replacement of __is_constexpr() with is_const() and
> did an allyesconfig build test. It yields a -Wint-in-bool-context
> warning in GCC for both the "0*!(x)" and the "0&&(x)" each time the
> expression contains non-boolean operators, for example: * or <<.

Grr. Annoying. But yeah, replace the "!" with "!= 0" and I guess it
should be ok.

             Linus

