Return-Path: <linux-kernel+bounces-256606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF636935101
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E49B1C2110A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716914533A;
	Thu, 18 Jul 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PbCWL21E"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2552F877
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322003; cv=none; b=UekkGbdAs87LoloRp5r7k0p0KGIOqTXuKZzQ4qC5tLn8SWpQhxIw9E86OdV0nZ/8fAEYRU4orBfyotIzk0/qegXCcMtx7fCfi8LvSPdmyP45aW/f/OGGdC2IpTyffpl6nVL0zON9gR7oA3olFG4Ll9PcL/xMQinirnXw6U3CY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322003; c=relaxed/simple;
	bh=b3Rb/zJ3ozODcMP2exN+exgUj8ajxq6pYf09Xb2Z3C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoIRVXia9m6cO44tl0B5jQjs0OWGbCehHEHybaCqe1BFIc3nAoip7zYM6eDLMM0LvLfeFnQtSsipvUS7T71QRRzgPRpl/4DZJYQ2vJSEoUOXT0d7KSQ2JB6yHbM1OGAJUYo5ypBXEaw8iiI5ztdog1o6RX4YVWbPPoWPOPlfbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PbCWL21E; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so601978e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721321999; x=1721926799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XB/G5/lCpr8LXyB6hdPS+Rp8IXDY+j4QVXuVYTkC0qM=;
        b=PbCWL21E3fw2+jEvRcPrDv7itai+3fh8rIVCVUt+GQbtQwioaBvDDjMGsFZyg9oEqm
         N8iiO7emXIC4R1lKR47i5rIK2F8OjHvGrnS+c8xNOK2PIwH5ibWBoDnb7LL2Tm0O8D8U
         tcYnSn40rOeYJ9yEpqrWH+PJU2guNPCya+sJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321999; x=1721926799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XB/G5/lCpr8LXyB6hdPS+Rp8IXDY+j4QVXuVYTkC0qM=;
        b=K8Jc6eZj0NsKzZRcOlAixARk6oUDLRvAPiFxY8r581aCXLHjOCbNKK65MnJrcfQASe
         TUm2rA60w8ZRbbvbmtYK1JeI1JC5b4K7Z/5zv7zFzOlQnaY4q5Eo+17yV90tD551dIWn
         Teph8R8i6KFS7krwk+6s1tlUaU4NbE06cVFn1zEOYBR+WIPa/YS3osrJe5237v0Q586w
         6+hdNnUBJa8k/pwUamPmDDiv/7dCXrAobWRLOeYZ8noOjhX9vtAFUsIHZynDIY2G4KTk
         Zvwgh33sNFiPrDRvaKurvO1XHQYAQsRYVnROTs+WvAVbdcFL+mjCbijHSOooim6ri0fZ
         OmrQ==
X-Gm-Message-State: AOJu0Yz9C+/RFSDxsGwda4d018TlSoIeimOrjMPxoDYFG07lnd5ktPlT
	KzB9pl/jtHS5p8s1yi7WsXD5jBIaa8xO7MWq3z+74R1z5WkRek0V7PxdvPKATnjX5LSa5p6cNeP
	a3WGfFg==
X-Google-Smtp-Source: AGHT+IF45e7EGd7fxGB8eR2yLCDphL3HzuZiJr2aG31NKWLnCiKQ1OQOOY2RhhNEtgPbzOcDfDsVbA==
X-Received: by 2002:a05:6512:39c7:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52ee5429228mr4034623e87.42.1721321999099;
        Thu, 18 Jul 2024 09:59:59 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef077744fsm144453e87.228.2024.07.18.09.59.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 09:59:58 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so11712441fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:59:57 -0700 (PDT)
X-Received: by 2002:a2e:9091:0:b0:2ec:5518:9550 with SMTP id
 38308e7fff4ca-2ef05c57e09mr21434381fa.10.1721321997478; Thu, 18 Jul 2024
 09:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718120647.1115592-1-mark.rutland@arm.com>
In-Reply-To: <20240718120647.1115592-1-mark.rutland@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 09:59:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVvVfZM-cakf49j7XixrN9mNimyL0P7zZm-zoYKpp0_A@mail.gmail.com>
Message-ID: <CAHk-=wjVvVfZM-cakf49j7XixrN9mNimyL0P7zZm-zoYKpp0_A@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: remove CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, alex.coplan@arm.com, catalin.marinas@arm.com, 
	jakub@gcc.gnu.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, 
	seanjc@google.com, szabolcs.nagy@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 05:07, Mark Rutland <mark.rutland@arm.com> wrote:
>
>  config CC_HAS_ASM_GOTO_OUTPUT
> +       # Fixed in GCC 14, 13.3, 12.4 and 11.5
> +       # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
> +       default n if CC_IS_GCC && GCC_VERSION < 110500
> +       default n if CC_IS_GCC && GCC_VERSION >= 120000 && GCC_VERSION < 120400
> +       default n if CC_IS_GCC && GCC_VERSION >= 130000 && GCC_VERSION < 130300
>         def_bool $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)

I'll edit this all a bit, because I don't love complicated config entries.

Let's keep the "which gcc versions are scrogged" as a separate config
entry, and then have this just as a

     default n if CC_IS_GCC && GCC_NO_ASM_GOTO_OUTPUTS

because we've been here before with the whole "gcc version tests", and
it got ugly, and we have that whole "CC_NO_ARRAY_BOUNDS" where we went
back and forth on different gcc versions, and it was just really
annoying.

So then we learnt our lesson, and for the stringop overflow code we do

  # Currently, disable -Wstringop-overflow for GCC globally.
  config GCC_NO_STRINGOP_OVERFLOW
          def_bool y

so that we can make any possible future "this gcc version is good /
bad" in one clear place, and we have

  config CC_NO_STRINGOP_OVERFLOW
          bool
          default y if CC_IS_GCC && GCC_NO_STRINGOP_OVERFLOW

which is readable and understandable and if clang - or some other
compiler - were to add their own issues, it would still be readable
and understandable, and not some complicated mess.

Of course, once we _did_ learn our lesson about gcc versions, that
-Wstringop-overflow hasn't actually gotten any more complex
afterwards, so the *one* place we do this right didn't actually need
it. Yet.

              Linus

