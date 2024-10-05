Return-Path: <linux-kernel+bounces-352173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831DE991B40
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112C61F2235E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE516DEDF;
	Sat,  5 Oct 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IakF279I"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D5148838
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167719; cv=none; b=Njwb38N6pt840ZBIvtHYThx8VTAaCKmF/6hHrjdZ0xH6DTsDiIz2/fIw5MZhHYMqK5QzGyqgW3zyUp0U70xmz0haXmSRlpQJXUQ5r/+s/w57G2mOooQ7HzhiSE63MaEXZgCVRcmxwXr+PxGS9CbH1DjKeNGq5iVfDNwlJ5udQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167719; c=relaxed/simple;
	bh=b+AWARzu8Thd5FUOfHILFpuGGWUetHMUNgu/HGN6+q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OezEX01p/duo8cAm9AcDgZ1cYL7Mn4puSNJBlipX2/yP2DHNbb3EKMPEUFNI94o5UVveFn6S321NzwKx7EiqqK8FookvAZLdjjJebrPqi4CLv3WozxLxy4GIpxMGe65mT8BoizGlPbZlOQTVYHvGAX30abAwk+3ne0GLjjFoCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IakF279I; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a991fedbd04so186208466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728167716; x=1728772516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HQI/L/s5ZU/jfp6TpSnEQe99W437IW863hAyq7v8534=;
        b=IakF279IiZTEE5t5GpvmzxSncwKBajeEv+S8fkPQnEbdi0iAWNwWn3rwi6CwrR/i1E
         CkAbfmgtF/1Nht2Gwe6AYrFnPCg0+J8UXcSSDOiebpciceM3CPs0wHF3nLzo3bmo4g+b
         N6lLFesJRqB5iwzBoqYBC/nNpcSYgRLz+6WQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728167716; x=1728772516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQI/L/s5ZU/jfp6TpSnEQe99W437IW863hAyq7v8534=;
        b=LfwA93wPeWv/iu8In+sGqo9xrvv1h5o3T6YShNODm1+I7nJP8k2XNg5+qCmeqVm4fk
         6q8AD9L6WA2fAcm0tlsGMnapHi2iPh3vU1DROVvmserlCSYT3xW1XtMHs7uF2AXNU3Xj
         ATM6f399DvJoMPEH4HhU78nyj5xnzcZb6D49ZeL5FILGZH/9uRyM99sSvSNZppyiCu2m
         tHMLc2EATFYAbbyZ29cubjBUP9JBTTIPBpq33EPf3+1+0btb9dwDhcedu6VbayTbRQvB
         N6qhRm/9svazGFzttZDVglAkKRvzuRDXnbixR0VRmZIpMFq5YAA+lGBNcgp8eZH1xaGb
         H32w==
X-Forwarded-Encrypted: i=1; AJvYcCVOldqldahRIE+kVcg8Y1/kmD+MXpi2OjRwtMLXa96Hj8bJwgV2RvXsLewdiuUbWnB55+OQYl4Vro4c73c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldkN98cN/YfGo6XhnCC9uMTkCkCyyK7o4ZHR27BtOlXPO/kz4
	vZBEKuOsTXZ3XtGaucat2GR+yW1OZw8f2QKTCgmEJ/8rB19yFWAk/v77gYaUCaJe4rxwMpq0gIU
	8X/Hu8w==
X-Google-Smtp-Source: AGHT+IFHBGxWsEF9ZX1NYFnwE0q0BuBtxaA3mejlU0IqMUB9Me3JFlOJWIjV5DvUbnkWASmKioNRAA==
X-Received: by 2002:a05:6402:1e96:b0:5c5:b7fd:170a with SMTP id 4fb4d7f45d1cf-5c8d2e9fb61mr11450869a12.28.1728167715713;
        Sat, 05 Oct 2024 15:35:15 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bd209sm1435212a12.48.2024.10.05.15.35.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 15:35:14 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a991fedbd04so186205566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 15:35:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvaa/Wu/Z5red1FC/0rFjqRKAORUPdnJ3gFszfWhL99UytdaXT+k/pdnaKAWKi6ShXXhquCyyxeAYrnSY=@vger.kernel.org
X-Received: by 2002:a05:6402:27c9:b0:5c8:9529:1b59 with SMTP id
 4fb4d7f45d1cf-5c8d2e48716mr7992911a12.20.1728167713376; Sat, 05 Oct 2024
 15:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
In-Reply-To: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 15:34:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
Message-ID: <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 11:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Several more filesystems repaired, thank you to the users who have been
> providing testing. The snapshots + unlinked fixes on top of this are
> posted here:

I'm getting really fed up here Kent.

These have commit times from last night. Which makes me wonder how
much testing they got.

And before you start whining - again - about how you are fixing bugs,
let me remind you about the build failures you had on big-endian
machines because your patches had gotten ZERO testing outside your
tree.

That was just last week, and I'm getting the strong feeling that
absolutely nothing was learnt from the experience.

I have pulled this, but I searched for a couple of the commit messages
on the lists, and found *nothing* (ok, I found your pull request,
which obviously mentioned the first line of the commit messages).

I'm seriously thinking about just stopping pulling from you, because I
simply don't see you improving on your model. If you want to have an
experimental tree, you can damn well have one outside the mainline
kernel. I've told you before, and nothing seems to really make you
understand.

I was hoping and expecting that bcachefs being mainlined would
actually help development.  It has not. You're still basically the
only developer, there's no real sign that that will change, and you
seem to feel like sending me untested stuff that nobody else has ever
seen the day before the next rc release is just fine.

You're a smart person. I feel like I've given you enough hints. Why
don't you sit back and think about it, and let's make it clear: you
have exactly two choices here:

 (a) play better with others

 (b) take your toy and go home

Those are the choices.

                Linus

