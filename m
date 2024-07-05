Return-Path: <linux-kernel+bounces-242752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0E928C91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42AB1F240E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4416D4C4;
	Fri,  5 Jul 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KDPL9xTR"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356C2B9B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198770; cv=none; b=K0KpmRG8W1MlLSJSHBphSloIF2MTT3zoMH/8/VMOGGwM4/ELdr2QOX+jeZKR2kLEYlWJRwQdE/5NAE13iU2h5T2Emgns7C/4U3Xhi6FqvYFuoXWsoqxBx1xnc3DJMcZdebfmR136Azoaeko3Dt6L4J1sCrXIjMw9NRzV7pnWxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198770; c=relaxed/simple;
	bh=+lp5T+Xiw0lfUim6DlMOmUcyDwXcWwyrA20JoST3g3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttes9250uIz+KQFqhyIKaqjgyNv8Mab6aE65ADUWbD3cd89AWb/ELm8hZv7Cz6t2e/rkTL9ubPj4FzBhwYamepwyb/RYLk98XiAT+a4YUoBOI7Cm8BnJ01EuKDoKx01KAC+/dij4ldaIuJSgd//Wy+U6bpO0b1iLVDYrjZRNX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KDPL9xTR; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-81013580bd5so530229241.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720198768; x=1720803568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UiS+ZqGUnEqkne7YH6cjX305RHpUbbshzvRvuKT3C+g=;
        b=KDPL9xTRwC1aT3k31YArz4xQQNhwYJ7pq+DnBn2U8rXAqzkL/7Xqa8RpxA4WvpFqCu
         iIuapQA3bPE9hKhS/+hytSUrrUYJrrT00BUSlGJRFEnIDoldMV5TjshthGRadjK2c52c
         2ViQmOpFFJLIYZREEYkLfFxKvaMRFkxprLwc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720198768; x=1720803568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiS+ZqGUnEqkne7YH6cjX305RHpUbbshzvRvuKT3C+g=;
        b=npBr26oSXuWhHHGCDMvZbEzXKrKClluvsQuxVGvNMSUKs4VrnVbAJIc5vSyzv+5OCB
         Pj78GzuwSJKBiYIUeHNnQFNRSmRHafYKg8EelhfJPrn1vL79JcnkG/qlnQFpZJ2G3Ng7
         vsCYoem6wWbbm683mTAJdDpTCNK7Ur2Kpb/LYtgHxzcN8GumxBwa5ixwS/OKrU58rS1+
         mDgPlJXps3E4pveLGS7USdZW9aM7/AYAd7B9QYoINMyesEWICZZCMneAjlUqkOrCGAUD
         4KbVLithG65lI2HKddoHMJ4p9ZgMQ3U6BZf9KJ724ZIqwZ2/+Az04Lxc/bQf56dPPH62
         48Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWLYR21SGLrmC2EnEyvMlI9vI2fnI/dl9Kcpssb3Fsz7vu+B5N1mY7MKf957dXRp3kPOc5ekxwTaYY7WpsCy3scESkkvxW3uR34PWhn
X-Gm-Message-State: AOJu0Yw2a/t9K8bKEjSRRsn6SmvB4YTlpCdoOB/y+oJI4mYzUV92dS8K
	UoBX3NAG8IrzaleIPmTdiE1QbV33X+KV2Sjdpf1vM/yxNL9o/jf66G4wHBCeaQcy793p7Ru6RWZ
	/P4JErA==
X-Google-Smtp-Source: AGHT+IEPZNjyAWdyxZRKP1H9tz/CnC9qo9ELyCTsi8veGArE+18D+d0oiq1pQWfT41uv7RhfcrhdBw==
X-Received: by 2002:a05:6122:4e8b:b0:4ef:6865:8ffd with SMTP id 71dfb90a1353d-4f2f3f3e28emr4839861e0c.10.1720198767161;
        Fri, 05 Jul 2024 09:59:27 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f29225aaebsm2239068e0c.43.2024.07.05.09.59.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 09:59:26 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80f8dc709eeso501937241.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:59:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcCIDW6HR+m87+O6BholiA+q7BBGOoBy4LOJaaU4uhw4g9dCyFbSsrcU0a0/ibkVcLIzxCAxKbVwSJh2WQ7/mOjtb3KrVH255DXpKU
X-Received: by 2002:a05:6102:21b2:b0:48f:e759:94bc with SMTP id
 ada2fe7eead31-48fee6b57f0mr4721289137.16.1720198766445; Fri, 05 Jul 2024
 09:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <3a138dda-5351-41ac-8c91-f7295036729e@app.fastmail.com> <CAHk-=whabFzoT+iLSF1A-u-4fBvtLGMBvi67xUOqww7PGp2B8Q@mail.gmail.com>
 <cb2f5427-521c-40eb-90fd-f253b41d5422@app.fastmail.com>
In-Reply-To: <cb2f5427-521c-40eb-90fd-f253b41d5422@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 09:59:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjM4kDjVSMwJoasuJDFfzh+sZDxO0qxMCPLZ0G1xNoKqA@mail.gmail.com>
Message-ID: <CAHk-=wjM4kDjVSMwJoasuJDFfzh+sZDxO0qxMCPLZ0G1xNoKqA@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, cgzones@googlemail.com, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 01:34, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I see. Just to make sure: do you think it's ok to still
> reserve system call numbers everywhere if they are used
> on most architectures?

Yes. If there's a reason why a system call might be used, no problem.

             Linus

