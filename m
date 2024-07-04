Return-Path: <linux-kernel+bounces-241737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087AC927EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD2F1F2398F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D3143866;
	Thu,  4 Jul 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gt45O7G1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190527344C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720130873; cv=none; b=jk/WqDS0d/XDxEleZsuphVESRXDDSCEY49Ewh8y7RM5+0iUWMP/9bF98GuHVQcatjPj3wxQgJxMSgL4DCDxs/frC16ELJsoUFnqI3f3klcoFjLkDa1JzUigrlzrgt7N5QFBX151wtEFt4P6ea+uYK6U66PevAICozIE4gvwHdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720130873; c=relaxed/simple;
	bh=GWUVxdPGcXX1mpH6TPKKEtsLwyNtnyRyCTzWIvOwWxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfU3zGz8eNBhMuzCpvYElHj+Y8t2sLA65Z3qS58/M4RbSyfy+71Y+TSnnKotYSddMQl0ecH18m+tecP1+ovW2EzhgwPOBsIVYrzG4BwbjhYiTk2awWR+xE+258dz5ns8UpqZvEF7wPZ9VoETze1gkNXDrlAkJeXW4RT22QAu9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gt45O7G1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7523f0870cso116374366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 15:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720130869; x=1720735669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TnP5gGx6FIb9morEegH3ZC5ECuFgZ/ikkGiqTd4q3AQ=;
        b=gt45O7G1zY5Sse+bp6UloQUNUH5z8jKreD1NwJ7qoQ9N0Bc+bt0rtjZB5cHyDvCjSN
         ynKT3HCD72lxj6GINbjGbniz6UvNgE3ur7tdUn8bUZzBHayXcudGzbZGw/3v3XArartH
         uXS7zsNu9jAZ7cq1bbXbdJHBNnME3NGUnT9j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720130869; x=1720735669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnP5gGx6FIb9morEegH3ZC5ECuFgZ/ikkGiqTd4q3AQ=;
        b=hFHZ6sCKTZ7JTJCFZOMlCUAVabD/jYxbFjCMIB1D6krTwjpuqD2VMKUTWAMSua/Nel
         6ymHO2s2gxZqGikyrplZALUVedeBwdytatkPo10zP7AVdcO/J6oYxyd3eLo7p3dRz56X
         YuZ8bvelvSPpB3pNKHiOJp8xyWfIbk56646EIuVOfJg+2GtsGcRX6jCDLFoI12j2hQv6
         dbMZIBVigg5qFR6AkNjbV1BqOvvDkWR49VKiCgV7FZL1/KStZ4j63OIf21gGrF1ojLCL
         5T1M18yyrtn6AqEpjJ/QrVH4ZoYYOmIYYd6YYVIlbI10EUV7kpW4ulP2FsrQHm7rmurQ
         hRxg==
X-Forwarded-Encrypted: i=1; AJvYcCVsRPbaxQtoqAIoVbB7gXXuYoupEGTqswbVttqkvl1zhdsVtnroSYzQgDRcgTHDe6naIlY8VW9tVDzJgFZirlq5bMT6q0aJW6GvrfAj
X-Gm-Message-State: AOJu0YwAMisUoF5tWzTXW4bAfmORJKGNqIYdkbA2Exxzoi2lxtAN7jFR
	AloPrnB1t8sVwcoRUIHmBSdtamKCos1mJ3Dn7Btt6qDiz3L0LFIwiiZc2aQHZq9VBLkOy804ICx
	P9zmzTw==
X-Google-Smtp-Source: AGHT+IFTH22tIGoYqvEskdAxNSAHugJks6XxoAFppNXYVcVvp8gE3mmv3SFM3lktOd853/gc0U6STQ==
X-Received: by 2002:a17:906:ae93:b0:a72:7245:ec0a with SMTP id a640c23a62f3a-a77ba7082b5mr188838266b.58.1720130869318;
        Thu, 04 Jul 2024 15:07:49 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18508sm630128966b.32.2024.07.04.15.07.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 15:07:48 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso87292766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 15:07:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXinjLNO4dBdmnYDOnvQ+5f46nFlMKYVvN3BRciuKJXRR1o+GpeeEQyYgVYCdzZuElDFX9rngb6s+4szn/evXNjNtpRnfhO+gLcIh95
X-Received: by 2002:a17:907:3f8e:b0:a6e:f7ee:b1fa with SMTP id
 a640c23a62f3a-a77ba7225d4mr205930766b.72.1720130867700; Thu, 04 Jul 2024
 15:07:47 -0700 (PDT)
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
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com> <3a138dda-5351-41ac-8c91-f7295036729e@app.fastmail.com>
In-Reply-To: <3a138dda-5351-41ac-8c91-f7295036729e@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 15:07:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whabFzoT+iLSF1A-u-4fBvtLGMBvi67xUOqww7PGp2B8Q@mail.gmail.com>
Message-ID: <CAHk-=whabFzoT+iLSF1A-u-4fBvtLGMBvi67xUOqww7PGp2B8Q@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, cgzones@googlemail.com, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 14:45, Arnd Bergmann <arnd@arndb.de> wrote:
>
> It's not random, it's all the architectures: the ones that
> don't have a syscall.tbl file are the ones that use the table
> in include/uapi/asm-generic/unistd.h.

Ok.

I think it's bogus to reseve system calls for everybody even when it
makes no sense.

But it's also pretty moot, since I think the whole system call has to go away.

All it is is an odd wrapper around mmap() anyway, and it's a useful
enough thing *outside* of getrandom() that I pretty much guarantee it
will be used for other things than vgetrandom anyway.

              Linus

