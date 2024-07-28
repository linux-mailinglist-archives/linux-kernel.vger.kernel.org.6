Return-Path: <linux-kernel+bounces-264813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B893E8B4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7841C21706
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED75914C;
	Sun, 28 Jul 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dw8zuzjS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D5A35
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185973; cv=none; b=gicbZ+0vM/bi52ixLzeZq+hesx76dWFt0sxFfj2xqOosHBnTbq0r5xzZLVE+1f7xdfGVa4/KEn9+s1GB0swS7+tpOlv8uvwjdfFK3dXaqHP/isKWpww5XDeyq8F3n3ZFCtAyvcrdGh4QNh31ytcTr9ZRbwL1/n/Tt/zKaRQ0cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185973; c=relaxed/simple;
	bh=sPBbjGbm+H6BNdofqxEcuhhCmH/zbbnPPEK/qJdbCS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or+XmRkgWggF3KnvOW7MXdqxi6JofqGl/pgqd6v6lqlj0pBF52+5FU+Nf9AjMac4zUGX8jGlorVHAlNd0Vno2GwKCbSVweOgROH+r1EYARpaaLF4NZgqB04JNvaC/G/T9Zdl5BIpDvTuPJBwDXMahyBygckxkNMzIxL03a3oT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dw8zuzjS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efba36802so4645725e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722185970; x=1722790770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e2ppIjnXbr3VRL6keIK16n0+/3K9zuU18fsz4d+lC8c=;
        b=dw8zuzjS3T6gpNWVuf/zJMhmvlxqiK+iA76rm6//ouDmFF/JCrO0BYUUvrSMFU0iDv
         oZA4jym9AQJU/DvHcl8XepvCi709n4O+Y2Hmy2lGczS5fBUGOJGIIxFI/0kSXdu3ISbw
         YBYkEHVvu98akZlepA7HKtjacg6P+q1vjeEts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722185970; x=1722790770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2ppIjnXbr3VRL6keIK16n0+/3K9zuU18fsz4d+lC8c=;
        b=VtvkkACQO4W44qKN8Y/UZEDS6eySqwRFBwPIix4+M5q3Iljyp0OWdh3C4uirIqalvP
         cVy9TUSTcodAwWkXJ7LSR7lzImxyyIvZZIARp1OScAjQcwAj6BqYEfPzKfzBIAnwbhfz
         adLbzGOXx0iiFxWGPx49tnQx5EuwcfcO+WweGxX0CSeH6kdghgp33bjNoKMi5ACFvU/h
         OkjON37PQf3yLIcDecCtX//FPcYGIGVdwhcmSaTCdeCmvNiNGNAMxhMvfxYZNhU29N50
         2f8xjdop+0YahYprBOJZtVZae95iFHsldrx+hgbElcWpWbGc1xTx5DsZFneuO1yP7M4u
         Eb5A==
X-Gm-Message-State: AOJu0YwCSR1fseb19+CkbBx1WLxnu0bplX2r1u5S6135Gbh4WPmBaT+q
	A6se1ECateLlSqfMNB68sdi9i2k0eWySw4oriXxLVPgK5S2QE2pk5YsNsjBhpX6Px6aHMn/VjCQ
	ftUBKYA==
X-Google-Smtp-Source: AGHT+IEjOE4A6EVTbfn0sSixO9H2oy+3i4kFfkxPcvz8WyMNxEYWRFnjmXf5i6TDEA15xeKd9l/abA==
X-Received: by 2002:ac2:5597:0:b0:52e:fa37:f9ca with SMTP id 2adb3069b0e04-5309b27231cmr3753696e87.22.1722185969934;
        Sun, 28 Jul 2024 09:59:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb021asm403772166b.188.2024.07.28.09.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 09:59:29 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so1343146a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:59:28 -0700 (PDT)
X-Received: by 2002:a50:998d:0:b0:5a3:f5c6:7cd9 with SMTP id
 4fb4d7f45d1cf-5b021d22068mr3788756a12.26.1722185968628; Sun, 28 Jul 2024
 09:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com> <431f7c45e7294d4da4f8abcd57ce7b5e@AcuMS.aculab.com>
In-Reply-To: <431f7c45e7294d4da4f8abcd57ce7b5e@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 09:59:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJY5tT=Jk5EC+JV2nqqVjxsOJHK8_AE8YnpPMT3AYu9Q@mail.gmail.com>
Message-ID: <CAHk-=wjJY5tT=Jk5EC+JV2nqqVjxsOJHK8_AE8YnpPMT3AYu9Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] minmax: Use __auto_type
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 07:24, David Laight <David.Laight@aculab.com> wrote:
>
> Replacing 'typeof(x) _x = (x)' with '__auto_type _x = (x)' removes
> one expansion of 'x'.

Ack. We should do this more widely, but the whole "typeof()" predates
__auto_type by many years, and we (and by that I mean "I" - the royal
we) have just years of historical mental baggage.

              Linus

