Return-Path: <linux-kernel+bounces-241538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DBB927C57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B3B23655
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811983BBE1;
	Thu,  4 Jul 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ShxSFVLr"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDA29428
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114454; cv=none; b=Rg+u7FeygsxQjuFFbUc35Y53/2oIHREG5rN6/wWY+edISXz1sCed178F28qSGQPi+SuZ7Covre+qoUvwD4V4oIVxNc0dOJNA7K8Wh4hOQ8AtdWPcWWrGW2hDGWKXhJ7idFVAD4Telx0g+NrLI6OFIX9QRhI4swwjbcvlcwsbryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114454; c=relaxed/simple;
	bh=4LXNq5OIsqjN+mnBtq43+rzH6YE+UNFAsBmTpZ3rxKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+dm2q4ObVv5BRe2bftOrxBekfxIJlf5ZmkI7dOn8m9Xbk4BF9WUzVgbbpNV9zlgfFjZK+Y+iMY7W4CyOH5JeoeXn8352fSF948qASI/CQOfJ0YVRaZWVHnGFJsEPDh1TVl3LOJ2sZ3j+eNDFWnTzvLOrvImgzMOsJxapfhw1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ShxSFVLr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a729d9d7086so349031766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720114451; x=1720719251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbCJAxMLAY9WdRrq14kecU2wGhpWXRXaDXLxe5dz22o=;
        b=ShxSFVLr0WD9KNBdwJOuofoFORePX0YbtlHQ2gu/hyVaVkq7bvBe5SRVBB7krS7nWY
         Vk1hx03V3m+k88fUSfmG74vonX6qPqzxYLTyt1mv/iYpf2MmK+wzqqBNwg5TA2g7hfmx
         kCtUkA0j8J8t49imFb9lrEqnWuTcjVozouXAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114451; x=1720719251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbCJAxMLAY9WdRrq14kecU2wGhpWXRXaDXLxe5dz22o=;
        b=Vgd694mskv+QOioP9SNzg1IWFE77bv2pawCd5/B2KS9QNey7JAp6cLJRKwQTnNI6ZY
         M10r1LKSP2Iz2xGOP2W0td9olXbXsq2IBD/PJBLNdICSndxLPIP++6FDaYku4wQi6S8F
         3Vya0FW+nSNUatgTAAK28uBztGt23lKPaeEempDVZWtEq4U8V3L+MysETy3kFQ3LcQzM
         ADVto6xjvXUWMhs8TOlc1pl/LVRDcWnZCd31paN9uJIqP6sZXc21GelzxabIbJvo1JPS
         FY41UzVY6AKSVXyCCSeRr7WMzcQBdARaeSzKJSxyJcUt5NcOhUSPBm61d4yIpT97nhfj
         iEfw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ANaXL7cUeGsm75TpAW0wD1v/tbUiqefbI9NNer5eVOqn7jGGOeNNkkYFtpPfGajSkes2gdGAlM5ifoubTWkK5Ie9Pp3N4uo4jvJ/
X-Gm-Message-State: AOJu0YzILj/gjZ4t2LZ563mYiDusyHis/bDBDKH1bbroxJNNRn3opwfS
	5fQ1J4TeBdGtMsrbbPWlI0iy9kGCJ0stNq7x/v0//We0FeYhwOGk9BKAQuGlpNdWb4czkYgIR1s
	HvLkRCw==
X-Google-Smtp-Source: AGHT+IEY+oeQoEWKTFkFMpdE8yoCmvLYnuMngI4sx1/v+tVnp3F2wPrJ0RcNYuZjv3ZlMC19hPDJjw==
X-Received: by 2002:a17:906:1b43:b0:a77:aeb3:83f8 with SMTP id a640c23a62f3a-a77bda06940mr193725866b.19.1720114451064;
        Thu, 04 Jul 2024 10:34:11 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b341fsm614457066b.196.2024.07.04.10.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:34:10 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so1410429a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:34:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsse9GJq2uufQlHfWiB/5t76sK7WqPTN7EvBPREJn1HTvwGNxtbvfEfjzX94Y6JNJYzRCHylWkripz+5JmvmYo3zAm5trTVjIiZslP
X-Received: by 2002:a17:906:2ac9:b0:a6f:c24a:721e with SMTP id
 a640c23a62f3a-a77bdaa1ddfmr178602966b.30.1720114450094; Thu, 04 Jul 2024
 10:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
In-Reply-To: <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:33:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiqw3q_W-B4faLHXgkDMvz-wdUHYuSweg0LJvKuw0qzg@mail.gmail.com>
Message-ID: <CAHk-=wgiqw3q_W-B4faLHXgkDMvz-wdUHYuSweg0LJvKuw0qzg@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 10:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We don't add stuff "just because we can". We need to have a damn good
> reason for it. And I still don't see the reason, and I haven't seen
> anybody even trying to explain the reason.

IOW, I want to see actual *users* piping up and saying "this is a
problem, here's my real load that spends 10% of time on getrandom(),
and this fixes it".

I'm not AT ALL interested in microbenchmarks or theoretical "if users
need high-performance random numbers".

I need a real actual live user that says "I can't just use rdrand and
my own chacha mixing on top" and explains why having a SSE2 chachacha
in kernel code exposed as a vdso is so critical, and a magical buffer
maintained by the kernel.

                Linus

