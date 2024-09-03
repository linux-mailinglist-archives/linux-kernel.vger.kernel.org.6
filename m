Return-Path: <linux-kernel+bounces-313531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0C96A6BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53D61F24BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2319191F87;
	Tue,  3 Sep 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dLdHfM0h"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3315574F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389018; cv=none; b=LGbNJRdYEzfDK9gnJIWtylbpT8SmtxQOaQbegGMnEenu0LUcHzMimrHlvH3TwPVn0eUimZOU3cZ3rsLwG9UbfcrwXjs/LwmB6AtTNFN+GmpO+Qf07CuHbgfW1mQ4O565IdaS+eilYYlFNsFlgH1LAbOa5rkJ4q53kRUmHzb1qU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389018; c=relaxed/simple;
	bh=Vrj6/05jRt2uY03EgftYD7q7dWPhXqzaJDztOoZvlZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwKdKssZoZ9p2+fCl2GzGGDDm9C7ZJtbPXJs0UP9vCBOQn69VmqtF8kQzCS0NDcqxm+fUsBCpJIzLOBun4cs6HmXx51U1p6X1b3HAoSahubA32lamyJYENvfvi4go7QAM65pPBwdv3ypgSCwxswY4dn9FIV9V8oHhZcEhstboF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dLdHfM0h; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c7a49152aso37939225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725389014; x=1725993814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ODYdcN8Hxw4ndq6m0wtriIL/Eaism2Bz3VxeMOOInA=;
        b=dLdHfM0hJLKBcVGZZOUcLqZ0oNEvSd4gX3oGNEmi5h8ZVOD7WNfFqrevkcHgXBv7IG
         WGRzXwX/R6vBbym9CZjtVwlKtWx1SvPh0uWT8eZkk+/xI5u9djvVfToz82RNkCXD7rW1
         +rue3F2rhg83zYWulNSHT2Ej3hYCsXJMpsq/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725389014; x=1725993814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ODYdcN8Hxw4ndq6m0wtriIL/Eaism2Bz3VxeMOOInA=;
        b=jQdNFuQu5v2p6FStwdDLcdolGTG9bI7O8irBJTubuDcpffGlXL6aBdGVcvWE7TPB0Q
         hGB7PRil7iLGg04wOsY8dPLySnSt46t8gDy8UUaSM8o8bRKiYvMHX2JwN2HsHUHBcvfr
         kTfJjlwKFH/wekHu5wLVnZoR0sBu6Vs6vIaGDw4Y2irsFNtMmJe1TRGLZOU7v4fGUIlx
         8h3bUmt8kc/7PDrJ+fT2mWZ7x8Db3j/QQjXMCVG9N68yCpJbSGW5MVz4UAUlkN5TWhgO
         1XwjAHBWnuKqkGlRdExAlUrSJvqWLf/OYcaKpzuE731nKEPxVLv1Su+iPEXHrq7KCFaA
         sMcg==
X-Forwarded-Encrypted: i=1; AJvYcCXp2zzPFfkklxUitZhI7cTzeDtfjjnTrwUbhyGNXVoywnP5Q/QtQWkQDaJCYqcmdOycWeRBNLrSPfKy8hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJx/eBRJgF3TPD4x9rZpuuDigoksGU8CDlDwUUYGzz3g1aJXu
	NrpXOl5SIkc+UkdV4YzSj+csLzM2+fG9PRWcbMYmLyGwkdU3Sjq2Vc0YqTvqBgaMRhbet1Prmnd
	zPsP+9w==
X-Google-Smtp-Source: AGHT+IEXrUfVK9pDBc5V71JCWRjhm86aBEDzyl0fLZcZzRTj5apGCSY2sZK3tuCzG+kw8b39zr9kgQ==
X-Received: by 2002:a05:6000:c8e:b0:367:9903:a91 with SMTP id ffacd0b85a97d-3749b526808mr15068272f8f.11.1725389013606;
        Tue, 03 Sep 2024 11:43:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dbf2csm703108266b.186.2024.09.03.11.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 11:43:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c0ba8c7c17so2515125a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyP1Esfe/9DK1k64U6b5vgL2OR892+mb1jPReDCsAqtIiQ7TW+9X0qJ+GJKwSwhwdX4rjAlQGvlNMQN8U=@vger.kernel.org
X-Received: by 2002:a05:6402:27c7:b0:5c2:5620:f72 with SMTP id
 4fb4d7f45d1cf-5c2562011e0mr6545096a12.0.1725389012268; Tue, 03 Sep 2024
 11:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx> <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx> <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
 <250f3ae6-3a81-40c7-a747-4713e8888510@gmx.de>
In-Reply-To: <250f3ae6-3a81-40c7-a747-4713e8888510@gmx.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 11:43:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWchFofUF9cai6QUixbZNGU=pqDxNUdtZvtBkbFc9QfQ@mail.gmail.com>
Message-ID: <CAHk-=whWchFofUF9cai6QUixbZNGU=pqDxNUdtZvtBkbFc9QfQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, linux-parisc@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 00:54, Helge Deller <deller@gmx.de> wrote:
>
> During packaging the bits there is a qemu coding bug, where we missed
> to handle the PSW-V-bit as 32-bit value even on a 64-bit CPU.

Well, that was a fun bug.

And by "fun" I obviously mean "let's hope to never do this again".

               Linus

