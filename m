Return-Path: <linux-kernel+bounces-189882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94C8CF62E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FF4B21141
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA5139D1B;
	Sun, 26 May 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LZyyW1fn"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8B947A
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716759986; cv=none; b=V+4XoMfMNm8X74sTvAIfw/RG6fquiU1xOdnyeG6vKlJ+g/HugtMDWl7MiHZHkGQTnw/O1qBfIOjjR87y3Fot+RGgIx8NYoIhd5v3uprFuBeM5rik5fkDle2+J5EEveJDlrCvytrJ+q5Ynv+KnXt1nIJLe4ej4bZltR6ZupafgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716759986; c=relaxed/simple;
	bh=BZTyDxjsV/iXo/QKJ8gIKWeRlld6EAlqgh0Mqhycfrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjvjwdqXoHRv6K56JXJUBgTrVI5WGuAEgeu4WZ1UVar/fduBqUm6c2z1LPfNmr76Li2kVQoQGNQM5+Diq/o2NPsAH8R5vTeATeabw6GooGQ83iAdv6z4X2wA/MZY/MOgeTrtyQh8LRbh/BAdBiQ2BTMQ5SuoStWdTsVEmX8i9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LZyyW1fn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a61b70394c0so849375766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716759982; x=1717364782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SaOgVZCxVtqV/z4sdUNnjYMBPOoDFXTYVgkydMgh0gI=;
        b=LZyyW1fntDG1A0z8FrZKutmn06TdXeLZkhKyd2S/rvf0c5/X9TTIhyYqSaf4xdTwZJ
         J7S3yQywZ0qwVI4Xc5SFFABOu87RCmdmj1PKm3/aNYd/YmJje8Gvtt4LukPNyA6RSXf8
         hURpynGKivM8lWwTPD6AGigfCpGxNvMpfTurs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716759982; x=1717364782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaOgVZCxVtqV/z4sdUNnjYMBPOoDFXTYVgkydMgh0gI=;
        b=eZ1XW0inshhZ2lP5wmPYlzZVsCKVXnhK7ZN+Exf7Sf2ScrfBDgSbFfWhcp9TqPqKT2
         j6GV1nzZy+TKD0VQmwim409UzXgnwEN0+VGJzS+EKi3HOHIzCjjXrRVPkd+yvYpZAu4B
         jE1zHKyWqEWXwxg9mj36xxaT5q4h+JI18X/M9K7k2Ck21aN6gviM104J1PxknTEfs0hF
         kj51MWIA+xyJvYB1TmjslWej+t7V1OoRSEOWkxxS0OsA9R2jcy/L6eY8aGM47iXD/7zV
         R0G20dp9tHomJqyDKWTSkEgdk+LJknvk5gnpQn1E7h9vYUjpSBMBY+pkAhozNvKgOFTQ
         3L8g==
X-Gm-Message-State: AOJu0YwUMqZpSmrx8X3TJg3Apr7EyiYsXZi0E83DvlWU2sWafHwniJSu
	sZAHnJRQbrhl/R7OFJa5PsbnSp6r0NVoCgazLTglhUVowXmDJjOVq15kawNKaRPYB0KJ0WpO55G
	D/FAM8A==
X-Google-Smtp-Source: AGHT+IEjsB8F34YFcF6bEPXMGDA1GgpX9WYEPGY5sNJrBS9uVrz9rAS2t1uAPWroQYcGeU/t2x7pHQ==
X-Received: by 2002:a17:906:491a:b0:a59:c844:beea with SMTP id a640c23a62f3a-a626511622emr434981966b.73.1716759981979;
        Sun, 26 May 2024 14:46:21 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c937b92sm419904366b.68.2024.05.26.14.46.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 14:46:21 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a61b70394c0so849375166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:46:21 -0700 (PDT)
X-Received: by 2002:a17:907:7743:b0:a59:aff8:c713 with SMTP id
 a640c23a62f3a-a62641a69a5mr464689166b.10.1716759980771; Sun, 26 May 2024
 14:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <h23suk5s4hhkf7prhkzxp6a4kmhpgqxyl6ioski5cg7ciihxmj@j4zif6l6dqxc>
In-Reply-To: <h23suk5s4hhkf7prhkzxp6a4kmhpgqxyl6ioski5cg7ciihxmj@j4zif6l6dqxc>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 14:46:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMS56xLhb7cAmTri2sXtGxK_zKWhZVX87YzjwAfVqTqQ@mail.gmail.com>
Message-ID: <CAHk-=whMS56xLhb7cAmTri2sXtGxK_zKWhZVX87YzjwAfVqTqQ@mail.gmail.com>
Subject: Re: [GIT PULL] header fix for riscv build failure
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 10:03, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus, this fixes a riscv randconfig build failure from memory
> allocation profiling...

This pull request is odd in multiple ways.

 (a) it's unsigned, and I really don't pull from unsigned sources any more

 (b) the commit message is strange. It says "bcachefs", but I don't see why

 (c) you say riscv randconfig in the pull request but then when I
follow the links in the commit, it says "mips-randconfig". Maybe the
same thing ends up happening elsewhere too - including riscv - but it
sure is confusing and I suspect it was just a typo.

 (d) there's no "Fixes:" tag, so then I had to go and look up that
this wasn't stable material (it doesn't seem to be, the "Fixes" tag
would seem to be 24e44cc22aa3 ("mm: percpu: enable per-cpu allocation
tagging") from the current merge window

All of which means that I ended up just fetching the patch, fixing up
the commit message, and applying it manually instead.

             Linus

