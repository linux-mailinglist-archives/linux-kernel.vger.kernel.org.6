Return-Path: <linux-kernel+bounces-261472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360093B7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C2DB23D98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE415FA76;
	Wed, 24 Jul 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jxu75j48"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7806EED8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851391; cv=none; b=b4kgnqdfE82xehxv6V6/ebEe300APgnBqD25kbEwwOjSOKbSBCTztudOQn1ZnL1tunQHzWwXVC9ImhhyiAJ7npk0uof8trWTWtIyEgNpRIwflh1PiU2PWX/ONSWUxkcPRBIOyebkUE/YtvF9gSkr8EAC4TQ4grVMCnX0r/RfJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851391; c=relaxed/simple;
	bh=FgC6T84VIIXRful68ZweZxPtVHGYFbPoyeYg7Pkkp5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE1cGN4e1CSzUcjjJnhHWQkpLw08yuZ5sScqwhJGDBnhriajRo4kXr6WwkLMgDByZOvVr9xSSpnM92iN2snQv6bhgTyYleiDlJ1I3zN4bjBfO1OgOKc62GxDeY2LEyd7LBJ34OtpmpSxjf8VzNxMhXST3kiJSNETKlx+ZXoYi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jxu75j48; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso22192166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721851388; x=1722456188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lomV1atdSgU0uSbgjxspjmfWfMuhMKKB3Hl+Hsile+U=;
        b=Jxu75j481dkgTXmOUw9jqBp01nOX2tQ+ZoRW+JLjZId+LnOhaymNn0V4mQoRWqBXlm
         krr7fF8eiKiJ7Ms5eNZ2riopc7iiOmzU2KfmHf+T6nHQM+xm+QtDesoVWT9I2U3XFkq1
         oQOHtC1kDg/xc2rAeQPWsdl96llNklza5UeMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721851388; x=1722456188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lomV1atdSgU0uSbgjxspjmfWfMuhMKKB3Hl+Hsile+U=;
        b=on6Wx7m1aHdVIF6VW0fMARifj6EsK/0r93x8w0Cfs6SeBKejdudbUf9th/uvVX6DZc
         3Wue5o+XFFk4uzNHlEY92qwwyyzMvqPapNht/qfh+EJlmA93vbCB1w72X/MeJW+4TrMk
         iakbQWilKoXXiZjkibX/ZQFV6eiU+XURihUv9As6rHbSv5lNwPas3lPivNtU8NmP5/8j
         uD8h66GtWFaLOo3DD3dZPdry4qk/VcvMJ37bM9Kd8XGzirIi/PQavvHvWhs7DBTNgEsG
         qrii/QXhZNuNQR8cq07bEZzYFfAscQ+J2XrxD0swSxlZlVyONBX6W2N+hN3SL2Ha1QNF
         7M5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/Vn8dIr41xWVSui+cCqIX2u632cV2fqMFS81tXK26DWIsUC6ELyKM7FLUP3C9IrdoB/f58cWt2+utFYfRrjt7u6ACFazSmznClp9t
X-Gm-Message-State: AOJu0Yx7smtJdYCAF/SBE9XdiLGbPN39wcGz+HNIpFcaqNfyexQzo6ZV
	FNJiaXK6c79PhhRcqZyhmlMQKOMRgj1K6dv5GGNDZzxv5JILi3q2ubaaq06QXJ+mi3ddW4XT5Ai
	osrA=
X-Google-Smtp-Source: AGHT+IGtv6FB5DrhVYjiEnW6CNDrVKn9e+E2RIZzl2I8UrQvzehwV07JP81wE8jMDqd0XoxcJHaqAg==
X-Received: by 2002:a17:907:7f1f:b0:a77:e55a:9e8c with SMTP id a640c23a62f3a-a7ac5245f01mr33072966b.47.1721851388094;
        Wed, 24 Jul 2024 13:03:08 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aaa7a4a76sm128403966b.96.2024.07.24.13.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:03:06 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so317620a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXc8dI4zRvDvzNbgRO9ct27ekFM3Z9VMM3V2yyHExeSdlCWXErj/XFFAKs+O91KrKJLCbZhQJJf+8i5aQjt16OiW3VfWqmL3O7VOoTQ
X-Received: by 2002:a05:6402:35ce:b0:5a2:2ecc:2f0 with SMTP id
 4fb4d7f45d1cf-5ac2a2dd11cmr245013a12.1.1721851386493; Wed, 24 Jul 2024
 13:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com> <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
In-Reply-To: <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 24 Jul 2024 13:02:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
Message-ID: <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
Subject: Re: [PATCH 4/7] minmax: Simplify signedness check
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 09:49, Arnd Bergmann <arnd@kernel.org> wrote:
>
> I don't understand why this return '0' for unsigned types,
> shouldn't this be
>
> ((is_unsigned_type(typeof(x)) ? 1 : __if_constexpr(x, (x) + 0, -1)) >= 0)

Yes, that looks more logical.

Plus why do that "__if_constexpr(x, (x) + 0, -1)) >= 0)" when it would
appear to be more logical to move the comparison inside, ie

  __if_constexpr(x, (x) >= 0, 0)

but I also don't see why that "+ 0" existed in the original. So
there's presumably something I'm missing.

I do get the feeling that the problem came from us being much too
clever with out min/max macros, and now this series is  doubling down
instead of saying "it wasn't really worth it".

              Linus

