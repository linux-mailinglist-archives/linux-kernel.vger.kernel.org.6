Return-Path: <linux-kernel+bounces-220261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E839390DE94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF651F24E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53317B50E;
	Tue, 18 Jun 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EgRq9jIK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CF17965E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746831; cv=none; b=FaLiiIVgud9JqtnNrluvZXElPzoQUS4Z+ttSnj/Taum0on3mAkTz6fFeVBX1jGf8LnSW2WiqfiS8rC/H0cV7XvfC8ApAxpMZIP4gr9IYSzBpH3jKi/bVL1tdmRAu5seaE7diVC96u5aTsYAEJGEBVQx9GSbH/qC9gN998z+Vbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746831; c=relaxed/simple;
	bh=DGSDIZNzOB7EP74kRaVZRQkMcJutKVSH4GwWSZZcB4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AadV/iaMVd68CifLlpZ9wCCIhH1qTjggi1mXOUMtE6/Uwdw+l3FPB/ZXszuiNTmHAZYQbmgBv93++pFeI1DjjfVVDffyWNeJKT66Ih/3Nb1+R9SLGQtGzjra2kHT77AkTPnZqpPkQkfmA73Y94p95EH1dyQWg6qatV59c8w9TrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EgRq9jIK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c7ec8f1fcso7091327a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718746828; x=1719351628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t2sFsCkBK5Jgj2XfBETPiTRynBfNBU9KxoV9zhHNOLk=;
        b=EgRq9jIKNN9uJbq//JNmG6IhzzDzUOVQinylb/rToZjVJ2gidFTnRZhfNMX6sSVVho
         3Zl0F0zq/mhxlqhennU1hTQDxOj+RFhNV5GUJ1idyXcJj7RPExvygA0p1Fxt57Y429q4
         HA9x0R0JWYPSboLrlEQV7FcmX3P4RZTspC4dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718746828; x=1719351628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2sFsCkBK5Jgj2XfBETPiTRynBfNBU9KxoV9zhHNOLk=;
        b=YV6lU7J6GGNLl8qnVkcXl16p/5Yrb81GhMmnptaVAglU35vN56mxm0KZmuhV1w7Df2
         jAoixmrSC0b8Qke3O/zl3P6Vx+AP3EpaFNen2rlpRzoRZjleJTpY8KTyoSkpFJlmVVre
         3ao+enXMH4Fs3MufA4+EiAQb5a2w+0GD1PwAr1LCXD1QX5CftnQx4px6BET6574DCe2E
         ehDYlV/L+R/W6t4xvWo2kH4dZPGsDyXbwpERAe+dgsnorORAWXgs2vrdkqYFML9H9u8D
         LFWvOT5c/hbpBK/fMIxijT5WZK4VzaZuF7VvkPaOdoC18dek3vSWo6COmN3rR4w0v+Cs
         XjTA==
X-Forwarded-Encrypted: i=1; AJvYcCU+upFAmwXB0SmJhSzp0DHV/9CvvubL/xi+H0+2RN05z6209ooFOeG+zE9Cnqp9H80Yhbw8uD5ty2XSQLcaLbZkiu89v/LKPWeou8SN
X-Gm-Message-State: AOJu0YyloYHa5O/CJH5W3zpn8AJgXhaRrxKGPXduw260VUaqhotoFq3P
	iaJ7dx8JmM3mUVBLXqup+zOedWUAqo8d1AjsQq9EZjxf6/9Mv7MrYKFyOE8VhQvZLkwU24DI3Fa
	LIsY=
X-Google-Smtp-Source: AGHT+IEJiPS5yjC0DTFryXg0GdD0WQyX2x4oLTrb37mfuS3IOgvAxEoCjI8B7rfB7dx9MMdXo5H/ag==
X-Received: by 2002:a50:9f85:0:b0:57c:5996:cfc8 with SMTP id 4fb4d7f45d1cf-57d07e6baa8mr359903a12.5.1718746827630;
        Tue, 18 Jun 2024 14:40:27 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdfc4sm7916362a12.19.2024.06.18.14.40.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 14:40:27 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6ef64b092cso740709466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:40:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXipWWHFM66IaeMuZMrgfZIwrT3NdIuGjp+EN+YuxjX6hck5bldz2VDr1FuiUDwV0dA5XhQU2aMoGAD+7ZyV0QpSyzjQ+P6jP16kGlM
X-Received: by 2002:a17:906:6d08:b0:a6f:e4f:65ff with SMTP id
 a640c23a62f3a-a6fab7dda71mr36334866b.76.1718746826235; Tue, 18 Jun 2024
 14:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
In-Reply-To: <20240618213421.282381-1-shakeel.butt@linux.dev>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Jun 2024 14:40:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh97fGxpyzKTUCrug_uhrLHJHh5W4wLbLkZ9cJSFh7RHQ@mail.gmail.com>
Message-ID: <CAHk-=wh97fGxpyzKTUCrug_uhrLHJHh5W4wLbLkZ9cJSFh7RHQ@mail.gmail.com>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kyle McMartin <kyle@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 14:34, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> Simply replace WARN_ON_ONCE with WARN_RATELIMIT.

NAK.

Sadly, the RATELIMIT cases are useless.

The normal rate limiting is basically "burst of up to ten, every five seconds".

That's going to completely swamp things and hide any other issue.

If we ratelimit it to "at most 1 per hour", maybe something like that
would be acceptable.

But honestly, I do not understand your "first abuser only" complaint.
There should not be *any* abusers. So just fix that first one already.

If you have more than one, you have bigger issues. So what is the real
reason for this broken patch? Why didn't you fix the first one?

            Linus

