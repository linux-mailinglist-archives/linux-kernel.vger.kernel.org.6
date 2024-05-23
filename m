Return-Path: <linux-kernel+bounces-186968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B18CCB54
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC11F2180E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A437C086;
	Thu, 23 May 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/1g6jTV"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9F339A0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437883; cv=none; b=HNIK1CnDJ9h07njlT3VaPclX22rf5c2d2ihabOwV/ZKcr2tBPBgS3N2ukBphsJbMgu5cqm12Gaqdyj61AVWEcSOzX1z/hEykZ2rct6UX+vKDZ+YBVv1PdfTyTl+K5hcModLbnefdYSic+qLkCiwuqRPrQpumjeRP4SZ93PpXb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437883; c=relaxed/simple;
	bh=GbFSOG9GIAlbCFwXl3iK2a2xIn0SGwFHqJmyiZfbwpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi4dcKtwCr0JNKv282NJ7JKYhw+iEeo5kxWScALCst84eNU6AC2FAQpbQtY2YBrkGxWjbLZwGVhSTp72nVgjiv58HjYcJsnAnI46NkqXOb65NYhycj6KpXNZ7+J4oxzM8P+bV3/QOXxxJKY+W7sy0ZunpUBJoKLe48nDkDKqtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/1g6jTV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-627dde150d0so16836727b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716437881; x=1717042681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0AowVZMPa7u6e5KLIEun2YKjWG2qpejnyGcGINzJ0c=;
        b=T/1g6jTVCCRt6ouxIhQs9dEpbf9g1f2gk+S68EarS4RXXoZOiNg+AGPM4tRd6Ulw1S
         /RN630nDTA1wAXBHaodeBKnW9ou8mVaD7TDFF+3Ar9yNNvLbNkIWCDfK/0zwlKx0ECZE
         esL2M1zgZ6BCihUcLDPW8tWzBJU/zA6yrXFMU3SIDb6U4OAvoe7Xp/IP8ixauf0DjmsU
         4N1LTGvhxFhxS+jjzkJ3HqJqaOFaF+KGkjD5gr1XUrxW1h1+7n7NIpql/4gJfe+37vDt
         3bW9hOJWXZTlOyGO2di/Uxp++SdBXiHIE6Art6AfSiHlywbWKjZy+gt3C5ptmEKhiqcM
         Bpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437881; x=1717042681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0AowVZMPa7u6e5KLIEun2YKjWG2qpejnyGcGINzJ0c=;
        b=c45W0NsVfjDnippxy7aqY2Z20qt6vssNBsaqlyzD0iWzvGVov0Rxnt4YV1PYrX7ucu
         PqpJ45vqCuNgIkMAMPPzme0vHIkjayR2mvXlezwUJI6sFPdzjLO0zPLZlMjg/2w0sR7O
         Hcxmr7YZdSE0c0fQh64rmLEiGozRix4lADojyrcS/XxOKOJugO6jKgu7D9uy0tTx34WV
         wTNFNcgPOLVZZ036BYCxs39SAOwGr9HgE62Q5M4girqHmYk0BZ8qfIuudkI2EjNkGjg3
         uPj0MN4PI/P3QcKvSelnJkr3YsljUyuFWOeSHkePg0pDxDI7s09JF+NWbcwrhkXlPBtM
         7GMg==
X-Forwarded-Encrypted: i=1; AJvYcCVEkNFpPc225oLA2dOJ5qdmunzw+ZdeZx9VQRsxrnEzR32FZoYTh/YE5vXFqNY0reDjHT9BMVdUgB/aqFXNh32v0Is8JRaxvR+h5cGz
X-Gm-Message-State: AOJu0YxBwvFbhU7NlxBpfxV+R7BUalPbXIqqMLtzWE/E0rc8upDdqn2I
	cvzs6dbp8nMurKl/vLcyurh2kjFaGodIeYZW5ka1s5hk35FNNGwb/kyKxs2gw3smAaFYbtBhlyL
	QIMPl42o+xrtZL6Ia1MylZzNUeBNki637TtVlpg==
X-Google-Smtp-Source: AGHT+IECtJaV4ktOjw3xeRQOL27efpUlrVmDS3eWOWwjyesv2pFJSpT8QDS7HAip0CnL/cY7cSKZ5IEpz01Tke9lhTg=
X-Received: by 2002:a05:690c:fca:b0:61b:3484:316b with SMTP id
 00721157ae682-627e46ca8a9mr52170097b3.14.1716437881214; Wed, 22 May 2024
 21:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
 <20240514070033.5795-1-jtornosm@redhat.com> <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
In-Reply-To: <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 23 May 2024 12:17:50 +0800
Message-ID: <CAMSo37XsdqWZUd3ih+zSaMf7U5hSJ1=-4U2SLUwU7Qaru+J9zQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Tue, 14 May 2024 at 17:14, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi Jose
> On Tue, 14 May 2024 at 09:00, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello Yongqin,
> >
> > I could not get a lot of information from the logs, but at least I
> > identified the device.
> > Anyway, I found the issue and the solution is being applied:
> > https://lore.kernel.org/netdev/171564122955.1634.5508968909715338167.git-patchwork-notify@kernel.org/
> Ah, I was not aware of it:(
>
Sorry, I was in a trip last week, and not able to test it,

But the patch does not help for my case, here is the output on the
serial console side
after I cherry picked the above patch you shared with me.

Could you please help to check more?


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

