Return-Path: <linux-kernel+bounces-423972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9A9DAEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4142820EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F7203708;
	Wed, 27 Nov 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QGRZEF1Y"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12612036E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742580; cv=none; b=q7WO6LYGJMFHFgNxEB/0e8K3oJpJPxKzTZtVD33BX+4Y0XgCJE1RVkPIIrbpIU256gRdb1viJMj89ToSuthhRE8jZ+RR/9ZowvgvRO6R7dNTAncQOa0dluN1XC8xfnC8k8j90anTU2cGzW13XPDEHmXymOHEFPk0rq/f2eH6RaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742580; c=relaxed/simple;
	bh=mDS1XojcKgyKV+qhf+mZoci6ei6W3HBx9/RajVFqU1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtAtfex+J2F9jRJtHJtTvCBBoXyTho9YrmKLn3OuBlkuo1g826CjabuaQa087KIbXA4f/eVpq8mSyGlovzVKwigGQLrUsRxyFz3AH0FXj2hqw4dMHp4D05K6WoCH6t3KjDPfEcbvdiK1JA2xJlwkU48Z+STfMkZiA0rN10T3k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QGRZEF1Y; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de79c2be4so135687e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732742577; x=1733347377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Au3QzJwj/0l4623aVKpu/uhJ436TUkwvUw3oPsNH4kU=;
        b=QGRZEF1YwLLeloe9qwsLuGiFwxjdY1Mvi87D4krYVbz7LL050UZ0OszBg+fEHKoVIz
         ZKlCHVHQK/A0oM8Wj+MACPFKJVsS9cntG51lHtfwSxXYUsdEjXURw0aPEA+YnF3eFby2
         tJB8WG360P1JyI38wr73Lulx9VJpUrlpoQYDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742577; x=1733347377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au3QzJwj/0l4623aVKpu/uhJ436TUkwvUw3oPsNH4kU=;
        b=ODwL9tWteNrSJE9lM5vmOnahFlL1Nj7y/UneO+6Yrgl87vyrzZEzyDyoYpFlX2K+Fv
         MlKkvljKuxRyB5b8hNN9jdH5xzKBFm/GxJji7Ro7X3hxflZkScN1CzqpeLzFKdFEpwOP
         fp25Fax8gZO47DLiMqgiz6YHzOsuovD99F75iKZI3GSkYE7k9NvndHhjBIWP3aiIkC5+
         o1m5Ihk0UtBdCIi5NN+wJOYrdLo1t2j7+1aakSDDYoGvUqE63HOptmz2+DA4jEteit9h
         Zvaj8B/DuGHn/389so9mHvHqyc74tjHtyGE6EDBLIwU2I2te2f2Q7QQuIGb5Pvjby4TI
         yAFw==
X-Forwarded-Encrypted: i=1; AJvYcCW4CjqsOQOFq2jdLrIaNTIDpUTtyD7DwolcwFMgxaL3mwHbkCugdXjpMBQ9Tt8PRXwl07NgfsrL6Xbwcx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8M/eXmd8L8rTDtRijf1na6Jw9HwkDLLn1OrNI28sHs+4g+SDq
	Tf8I64kbd3siSHzBFc+Va3O5Yfmhtu6uNZh87GY/V6k4V7Bt8BZWiF2lHvMH8nnikdvuOyY10m9
	FfOM=
X-Gm-Gg: ASbGncvAJqEmwXtNSVd4jGAAK1E0+LNKRxUFKSYc69v36mNpLvUsfR8kQW/VO+J9zpF
	8PVf9gdqXVigRzpv4p1A17PdXO2QY2+ZOwLUGZw7lMPqb2ogi74Bha5bmT/EkrBlxrLbQJg4LQb
	WBlDIWFierPsyE7wWIGxoj2AfrzX3EvMSm+t02IJ3zwEtWmPJ9trbTiwtxNBWYwhJ/LDkuGCyqI
	uZkvoMOq/LFWg48pWEsxTGbytXFOFOnJiSdCcm4YT3skCNOBVrJ/wj8WppWLh9sT/VYBCYrQicd
	RkSgSMpD5otnfn5l6KoG4IVc
X-Google-Smtp-Source: AGHT+IFNTWK6ifFDZitychEQK6rlsmM7tO/ajbTQnE6zy9ZardH0xJy5bPh4XCxeKf44tjShYgd9HQ==
X-Received: by 2002:a05:6512:3d19:b0:53d:de1b:f961 with SMTP id 2adb3069b0e04-53df00aa17dmr2999302e87.7.1732742576735;
        Wed, 27 Nov 2024 13:22:56 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b178dsm744061766b.170.2024.11.27.13.22.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 13:22:56 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e8522445dso13715766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:22:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzmbT3Z4WfB2kdPmYGixmu8nSj1X5gi1l0C5Qic3EPs7k9cHdpaQ1X0w8oBJmjrWPPTh9ngwK3bnDEwsg=@vger.kernel.org
X-Received: by 2002:a17:906:5a5f:b0:a9e:b471:8008 with SMTP id
 a640c23a62f3a-aa580f6add9mr299720866b.34.1732742574156; Wed, 27 Nov 2024
 13:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0ZxiLw9hauUynTS@bombadil.infradead.org>
In-Reply-To: <Z0ZxiLw9hauUynTS@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 13:22:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
Message-ID: <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, masahiroy@kernel.org, mmaurer@google.com, 
	arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 17:10, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Highlights for this merge window:

Lowlights:

>   * Adds a new modules selftests: kallsyms which helps us tests find_symbol()
>     and the limits of kallsyms on Linux today.

This is completely broken.

Try doing "make allmodconfig" and then do "make" twice in a row.

It re-generates the tests, so you see this:

  GEN     lib/tests/module/test_kallsyms_a.c
  GEN     lib/tests/module/test_kallsyms_b.c
  GEN     lib/tests/module/test_kallsyms_c.c
  GEN     lib/tests/module/test_kallsyms_d.c
  CC [M]  lib/tests/module/test_kallsyms_a.o
  CC [M]  lib/tests/module/test_kallsyms_b.o
  CC [M]  lib/tests/module/test_kallsyms_c.o
  CC [M]  lib/tests/module/test_kallsyms_d.o
  LD [M]  lib/tests/module/test_kallsyms_a.ko
  LD [M]  lib/tests/module/test_kallsyms_b.ko
  LD [M]  lib/tests/module/test_kallsyms_c.ko
  LD [M]  lib/tests/module/test_kallsyms_d.ko

both times, and this has made the empty build slow down by about a
factor of two.

Which is a big deal, because the "empty build" is actually fairly
important for me. It's the baseline build test performance, and with
small pulls it actually dominates.

So this isn't ok. Please fix asap, because otherwise I will just
revert it - it really does affect my workflow that much.

                  Linus

