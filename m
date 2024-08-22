Return-Path: <linux-kernel+bounces-297982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B5295C002
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABBA1C22FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB51D0DF6;
	Thu, 22 Aug 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LXHle41i"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69F17965E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360339; cv=none; b=AQG7X6yg+7IsWAXKqpzq9VOhPAuFJYNRxgYlUOeHdM+DDuyrhaWYmBMQ7g8RTZmXqaXteQyD3s8O/ACmy/HJ9jE/cSjE69hmQIr+CReMBhu2KVlwUWnIAjuu31NwxUqY8KT2gZAFgTwrPZmVTNTbzBC44/+g9env+BdhOO38HMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360339; c=relaxed/simple;
	bh=dEwsnfjXIyI6z712CyPIkoA/TgzpBgSIgyyAUGvh91Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9w0mw1OnfXD163z83vJKo5aa9XSPlYfd0pMI9y2+a2vOcf1aE6IJnEXNQ52mPYAHD+c3nepj7uzECdL8VW0r+8340q8YkE+HL1nbUwHVAbL/pR40hgXqIYWGR2atIy3wSruG12XWxk4CyHRgIlOIXDZKkbvsPXJ1w6Q8ACkeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LXHle41i; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e13e11b23faso1298554276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724360336; x=1724965136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8N8bN2ci9nm0ep6oCOlsfU0RlABxLI550Pt8fOG+QY=;
        b=LXHle41ip0UJJQzSEaH+kTddNAncFD9X2kbX08mVW4kF1wCoGJnjpN9BVo5CbfNoHn
         hcUlGvUXM8wW/maFWUBwpDbSOGdu804BOqzwEJNMY4/NE0f/lpWUrB1O8rxa8NdcHuxy
         JV14srjn+wj9if88SaIOWHFpmRpuJD3gtEMm6zWOTSxYpHTJ8/JddpNsTyqd43TSXt5y
         eKKQiTSyMdTfHTf9V8UKeNEcpkqUIjuuA0wdNNcz42tCm8IJKZBAN0kwOiX0bxSeroTL
         qCsDTjbN1PmfV88wZ5aSQIj1t39k93/JAlRVTh/w1X9BBHjmVD8mBhLsrVd2de9A58qa
         p25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724360336; x=1724965136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8N8bN2ci9nm0ep6oCOlsfU0RlABxLI550Pt8fOG+QY=;
        b=TszBltpTmScoWh/PhMzneONHOO8Y10ru3CYYH8JOCP52u0Pb9EZmB2KkHJn4DVC1U9
         TypuQZxMxYADgd10oBD1UiM5DfJNlqM65HOU8cBca9SS1iPOILX54ceo5J3Wxr45wDvE
         FnpVfPksVM6gcfOclCt4cYOIXslj2Lwk3cKId7IZ/MRgnFWSco5r6cmv48C4e9LRP+LP
         P1pckFGWMzYewPTYizm0q2yRGZxJvjRvDCjaSf/9pfNC0f1+T1BnWeOLMSf1qnMQUYXT
         VaKBlzhLhjG/BtZlO5l5G8DZeu9o1iPGhFA30+qWi4EDbOYNhdeM7kaRtzmyTLt99uP2
         GhIw==
X-Forwarded-Encrypted: i=1; AJvYcCVaefxSxB31SxSUa2Cjv9YaGzAXFDQC59qVuK909x98P4daNFz+W6kPLX7aqCCN2Wb9hAEk4pn7qw0Vhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95L39myMOipw1w6TQ3jedoSusuX5tyFpOb+SBnL/G+VRermMA
	eEwQR4nLWq2QM32daWMjEBjbsBzJlnfXTde3qEJQsmE7tbuO/aEnvlQ2KU2GEWiG1fdKLq/BetX
	idlWnwUV0+VeVIYiBukVtlZ/Uwi0dmyNPoaXd
X-Google-Smtp-Source: AGHT+IFUzoqh5If8UewR14wwjbtLRahoz/yxEpbOFIRw01N1HKbimey3PkySJkjy03S76hs2Ti6RicZKOHQVJqmZkdI=
X-Received: by 2002:a05:6902:727:b0:e11:7fcf:40d with SMTP id
 3f1490d57ef6-e17a83d0b16mr274259276.16.1724360336240; Thu, 22 Aug 2024
 13:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com>
In-Reply-To: <20240822131542.785546-1-mjguzik@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Aug 2024 16:58:45 -0400
Message-ID: <CAHC9VhRNMMtZ-_-sON_jz5_pkyFTyH5VOOVmPem=AbLpA5Y6dg@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:15=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> The refcount shares the cacheline with uid, gid and other frequently
> read fields.
>
> Said counter gest modified a lot (for example every time a file is
> closed or opened) in turn causing avoidable bounces when another thread
> tries to do permission checks. Said bouncing can be avoided without
> growing the struct by reordering the fields -- keyring (enabled by
> default) is comparatively rarely used and can suffer bouncing instead.
>
> An additional store is performed to clear the non_rcu flag. Since the
> flag is rarely set (a special case in the access(2) system call) and
> transitions at most once, it can get placed in a read-mostly area and is
> only conditionally written to.
>
> With this in place regular permission checks no longer bounce cachelines
> in face of refcount changes.
>
> Validated with a simple test where one thread opens and closes a file
> (dirtying creds twice), while another keeps re-reading *another* file in
> a loop (ops/s):
> before: 4353763
> after:  4742792 (+9%)
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> This is a resend with a reworded commit message and added Linus since he
> wrote the non_rcu thing.
>
> Note each process has its on creds, so this is not causing bounces
> globally.
>
> Even so, there is stuff I plan to do in the area and this patch can be
> considered prep (only one store to non_rcu).
>
> I'll also note I don't see a way to *whack* non_rcu either. :)
>
> 0 rush
>
>  fs/open.c            |  2 +-
>  include/linux/cred.h | 31 +++++++++++++++----------------
>  kernel/cred.c        |  6 +++---
>  3 files changed, 19 insertions(+), 20 deletions(-)

[NOTE: no comment on the patch context yet, just process comments below]

FWIW, I really haven't commented on these last couple of cred patches
mostly because I've been assuming someone else would emerge from the
shadows as the cred maintainer, or at least someone who felt strongly
enough about these changes would merge them.  Unfortunately, I worry
that isn't really going to happen and I'd hate for some of the cred
improvements to die on the lists.

If no one starts grabbing your cred patches I can start taking cred
patches as part of the LSM tree, I've done it a couple of times in the
past and Linus didn't seem to mind.

--=20
paul-moore.com

