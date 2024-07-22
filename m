Return-Path: <linux-kernel+bounces-258375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24B938734
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F0728106F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A21747F;
	Mon, 22 Jul 2024 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FJPyLwj4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A246B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610780; cv=none; b=T6F3+LJ1agkXLvKp5rSJSscbVh9M+IeOoqa+Xgo5K6HeUh/kXbL/Mn74au6krvx7np3Kyd0NY4YeKMkGQIT/BIMbgNwgdK039VAYxdDY5HP/BYGCqEY9s+EuZMtKxCWu/mPd4uNSCnbcHeth4h7hUUAuhBz6NWqW0EEPZBDU4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610780; c=relaxed/simple;
	bh=tCut4qU1NxMAK76eXQVTCNfTH1sNoI1sNersotmkaRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KobE/13GocPBbyiOfoSYj7I2IodBgDcroESLb46UdFAm2jw5zAFL9VUpolsA7eNPQcCVp6nIlz5E3zn87pCit5LOLbSgspr0ORWvHA+v52JEOKFsqj6p+sxobX5X4TMevPF8bTikTMp1D7aOs55Wm9jkQnPf0cDRquJu6LG3wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FJPyLwj4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efc89dbedso980569e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721610776; x=1722215576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ks9M3kzBCPwupF4DA1Vj4pSXzb7G5/N05vKszYZASg=;
        b=FJPyLwj4eMDqwmkaHhAuakN4wy2eXVRtHyWEQBokWl+jQN1PcLIswz3oiMfymnOXeI
         PhfDe615UVnO6FNQEtnwLpnVcP9JxozOKlcviup1RFqrhN3wDA5+UkDzz+GRZE6Va6Bq
         xO8b8W3vf7SEOp7uYczOFVXe1E+UOthwyEnWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721610776; x=1722215576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ks9M3kzBCPwupF4DA1Vj4pSXzb7G5/N05vKszYZASg=;
        b=Y/icgpTvdXRX2l+1N+SXb4z/9ykmVEzCpvrWUeNpnVrBMyXgJwRndACSU5FeSPWwyX
         vLtKJJlYQ+LvN/Hrq6IdkecHXDX0rfEDTtU1Ukety4c46IOir8SK90k9D7Fn2KLV68x8
         i7RM7cuWatckwi9bGA2csKTiyfrSSL4nupZA8L97tySBNTgWNgSPLZqbEP6biwmQMSl4
         MX0OZnvKxER0IANLOnhvIUO0SnNYALPqpJ8E2Dt5ByBxk3l+H/mzzZ8vdev4WYw1EcUn
         X2pk8H6JmB5Ak+x03amcQ5vJSxjEg4UCB6PTp6G3IWlQhur+1Xnibqs7pvXSH9Oap5pq
         3nkg==
X-Forwarded-Encrypted: i=1; AJvYcCUi9Crh9jT6qYHB6QdyppMrxvuU7hzjYDKql7OUl1ZXzbDFb+6KiC9G/J3aqan9W7hTnG7/jyvHoqd+3fukDXJ9RaAheVMItNGj7yYT
X-Gm-Message-State: AOJu0YzzA1a1epF+ltanIxVLu0M8G0ZEV/plbMqjhx+J2mclIYz3BxWi
	ZBoqPDXw5h2IuA66au0N1zYusvOoXX0e7o0iA8H8yi8Nfc0Qdrn1/ScJZRt0Ha/0h+S81j8MLbB
	kNpI=
X-Google-Smtp-Source: AGHT+IFhCBMDxJ5hhcdsWGiScMvwcaRukSjSNyO05c5gV6ZWAaLIsqtmKI+RpoJ/m9xYI4J+7MKCiQ==
X-Received: by 2002:a05:6512:3f0b:b0:52e:9b15:1c60 with SMTP id 2adb3069b0e04-52ee5426f95mr10573682e87.48.1721610776114;
        Sun, 21 Jul 2024 18:12:56 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c94fc2esm347922466b.210.2024.07.21.18.12.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 18:12:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so2786879a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 18:12:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1+6XIrgmuGCXA+s2S15dAFte90Har46vv5+zvS+XVrFo7xkX00HUz5VGy9pnbD+FgoEkW0czC+gyTDnu8PevJddnz3yhbIrxK3jvn
X-Received: by 2002:a05:6402:2114:b0:5a1:ef24:e9dc with SMTP id
 4fb4d7f45d1cf-5a3ebea7d26mr4934512a12.0.1721610774619; Sun, 21 Jul 2024
 18:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721151013.b9b331ce79f5f60c54c69636@linux-foundation.org>
In-Reply-To: <20240721151013.b9b331ce79f5f60c54c69636@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jul 2024 18:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqXizOqcpcrqvRJ88Twi4+o=G1Y=5qsLBs5R-8uHjs+Q@mail.gmail.com>
Message-ID: <CAHk-=whqXizOqcpcrqvRJ88Twi4+o=G1Y=5qsLBs5R-8uHjs+Q@mail.gmail.com>
Subject: Re: [GIT PULL] non-MM updates for 6.11-rc1
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 15:10, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> - In the series "treewide: Refactor heap related implementation",
>   Kuan-Wei Chiu has significantly reworked the min_heap library code and
>   has taught bcachefs to use the new more generic implementation.

Bah. I think the users should probably have been converted in their
own trees, instead of having this thing that caused a somewhat nasty
conflict.

I think I sorted it out correctly, but I'm not seeing why the bcachefs
conversion was done outside the bcachefs tree.

(Ok, it's not like the conflict was all that nasty, really. It's more
that conflicts in this _kind_ of code is a bit nasty).

As it is, I do see the Ack from Kent, but I'm going to ask him to also
double-check my merge.

I see what happened in linux-next, but that state also seems different
from my tree (at a minimum, Kent also moved the tiemr_lock around a
bit too).

Anyway.. The conflict resolution looks sane to me and doesn't seem
fundamentally complex, but (a) mistakes happen and (b) it does seem
like this whole heap conversion could have happened in the bcachefs
tree.

Kent, mind checking that I didn't do something horribly horribly bad?

              Linus

