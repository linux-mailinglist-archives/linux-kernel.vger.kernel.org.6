Return-Path: <linux-kernel+bounces-409795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34749C91C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B10FB23DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C630D19993E;
	Thu, 14 Nov 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IxcF9nUw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B8198E81
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609651; cv=none; b=IGHtoMb1Fitrr8W2jG7nee0ezA06VhiXe2PvI5dJmhEEcLRY/onv8VGJSoPlG8Y5c1ZP7w4VKuFlD4CK6vCjux8m/Bgn7ph1QmXkcrlgLAJKvllDWW8YEUtGlNxm5T+HeVUcKC5G/zfCvUAXdlW2dT2tylrQlbzS+R47r3Vo8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609651; c=relaxed/simple;
	bh=yQga4oATU7BAhTeiJXrO0GYPE/pnGSUj4/FtYK7YdnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnZ3GFbPT+yuTudRiPmjuIy74aV63ggTRiwcqYuu3GrbxrdtjE/EBLDZqET2jJBnG2KYcpFCPv/JMhTuacXR9SjRuDS7+ylVhKdLSdFPa7Q42+gyTFD/pQrbXf+n1glxdxyZv/I4d/M6DZXczGMST2dV+EWZrXbP+kAfifJZFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IxcF9nUw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e71401844so121029366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731609647; x=1732214447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVKKcMuTV29ZR/6oylMMphkdu4mxNTAVjAxFHNzjeW0=;
        b=IxcF9nUwEFeOu/2p3TqxhuYekPKKQvlFMtrHhkaEBXbwL5utnrTqJUGLdeldrxpoqq
         EN60B9p0D3L8o0UmPQ1Q6214DPu8i4FAObSzIbIlc6244vYMzWTtviQPuEIE0LsokeWy
         G3OvbK38ItmNAFuG4dr5RR1HRb1qqPrsaav7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609647; x=1732214447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVKKcMuTV29ZR/6oylMMphkdu4mxNTAVjAxFHNzjeW0=;
        b=j/oBLw2I5fACBku7LhM1xDXUkmkUCD3rlsM27ITHbH0lYaO1WDwGgMGCtpiy7dLY3c
         kv/jDduTSxmX+QQtRejMZX9UJmvoAU7v2NgaJB2uy4LT5qrRPkCOUmgedOy83sXbRvwU
         F8COazjnhc0+SuA9mjfkihkKBdX2dKjgWaelcEamSqzaZ7/MzLHpTIffHoimfaOzJiEA
         6y0OCBlA5EiJRotGSXyVX+0It5X2l/z20QkF0hAXDqdyaKHVqhvhSFJ5Tad8FMeXqsvu
         h583BfPA4/MQccYwmf1t+w1jOdeE/AQxLRlK9281E+WYHQ7RKYF6yQG+/9Keahf3MQe3
         R1jg==
X-Forwarded-Encrypted: i=1; AJvYcCWCIMw7XnhY9B7gDASaU6BFcTJNRZBW6H8UfsSCWridksT4Ri0WAyfIAWzMtap0HT6HJVvUwx7UsSqxIMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbU+TqRLPKlnQAgm9+P/ZzZI1gE6/gPIvyyvKk9lZXErl3wFTQ
	4DHY+Zto43PA/urLhInFFupdsUDPZqf+uRwj+ToSSkxB2/mdcdMG/6epOmm4s+XsMiyLlhrzIYN
	CN8Mprw==
X-Google-Smtp-Source: AGHT+IGu2RuI8U/tBdTuNzdfXDbsXInZ/lcd+R+mSs/ZYT0ygVJYfxQoEP2qcjgYew3ZaAOIuTA8iA==
X-Received: by 2002:a17:907:9808:b0:a9a:c03:ebc8 with SMTP id a640c23a62f3a-aa1f8105bb8mr662398766b.37.1731609647230;
        Thu, 14 Nov 2024 10:40:47 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd695sm89998966b.114.2024.11.14.10.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:40:46 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ef275b980so165799466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+5RaFMBiwqlSEwGMQRvMRhs7JyFnaJnEw5n0uWKB9TSIbuKnU8zdZj2UerDr4DDob8IWIUkGFBCfZirI=@vger.kernel.org
X-Received: by 2002:a17:907:368d:b0:a99:f861:ebd with SMTP id
 a640c23a62f3a-aa1f8055032mr767816766b.14.1731609646162; Thu, 14 Nov 2024
 10:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com> <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
 <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
In-Reply-To: <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 10:40:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
Message-ID: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Philipp Reisner <philipp.reisner@linbit.com>, Kees Cook <keescook@chromium.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 10:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There's probably some trick I'm missing, but yeah, it looks like we
> need our BUILD_BUG_ON_ZERO() thing with that crazy bitfield hack.

.. and right after sending that, I figured out the trick.

You can use 'static_assert()' inside a type definition.

So the way to turn it into an expression is to just use the same
'sizeof(empty struct)' trick that we use for BUILD_BUG_ON_ZERO:

    #define Static_assert(a,msg) \
        sizeof(struct{_Static_assert(a,msg);})

works as a way to make _Static_assert() be an expression. What a horrid hack.

I don't know if this is worth it, but it does at least have the
advantage of having a message, so that the error case can explain
itself rather than get that odd

 "negative width in bit-field"

error message.

I dunno.

                Linus

