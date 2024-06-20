Return-Path: <linux-kernel+bounces-222231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63D90FE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4346D1F23C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F819D094;
	Thu, 20 Jun 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2iSSOuOA"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8319CCF8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871386; cv=none; b=ONZSJ6d1EvQbi8c8up4wv9v0btFXtvb+GxRsoQBJnKkXl6O96yf/53GOdCVow2DNcCbdAwV/dijosrDQ9vaNgnpKau/Q9o1N7lML7TrowaJpdhg9NfsWgwcLglEaqHjo1L+36wEoHZvZ7sSWLMBBV2vKl0YU137psMhGx3oaru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871386; c=relaxed/simple;
	bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4HEgXfDiTbe7IF5hXTai2hixyb8NKH5rSOKtmxgeiGhZySsoJJ4M889GXpRjs7mMtl9XurWK4UuDxTIhYaXshEdef/K17zIDlvRpo0mRkwVj08PBz2plMydEirfmE0tzOHvLOM6dP6xgp0C/0H3BM1BIP8RpV/yzPzsUCyX/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2iSSOuOA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5136965a7so2122986d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871383; x=1719476183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
        b=2iSSOuOAH3soyq+uvu7LCrAOdIcXdgkvo1xwzMtJW0z+FjyOhO9zR0q5nlgUCxTs0C
         Oh8QB4Kgs9qJFJCVPqSuUljttuW5QaPe8SqOHsj4r87kWfMFtB+kSRpl66TT8q/RDPm4
         /mFqLJ+HxAjmMvT28ONTxe2XpRuKDImlJKTfVQWepoMrG9Wc3ZbGt+xvuzWfbO6D575H
         L83NZlTHRRzamKaEq0Fi7F2fSFuFvXnTzxNbn7sJnSdSt9WOeO4JUQt3f1utCEHMB2lS
         9rzPsLwcDsylmMiVceraGj94uknu3PYN1SePqlVzrKjZwfwMpU4ql5OKGZmfUexWgn10
         +hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871383; x=1719476183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
        b=QZvwpvjo7f9zAt0HtquiBsl3lQht5m1Myfae9acud8iDv5J4LsvOyEJ2wQga80Djlp
         53vJD/VHhi7BHQBzhozc/xFFtr61LNPgYdTX74U9silRV4tPc4EA+1C/CTniE+JFIRK3
         L1pmJE78iOi6LWoGCZKV7IdP9ITHIQoCKr7ALPaXAK6qbeagk+jKHsNyzHh5jfYqacD0
         fHLzbYzE0dOs+bKda9GqDXP9HIncpZg5Iy5k+s3To02CpVyfxtsxyKa+KiT0HFQOQP51
         EGNS92ElOy4nXKj4jgK9hUiMSGIcIyxPXFmoOxzsMRQTQqqC7zz/6xE9AszntnxmP0AN
         g28Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzyUL0ZvNb2arH0Qzd8cqEw4dsfz6r942V2iFJPzG9TzkKbYz57qsF/8CXhbrbNEwB1XJCHsDpaQwQMSheSU32sxcqQoxkRLMcJ3qH
X-Gm-Message-State: AOJu0YykfU2hZnr6vREiZU6PHLpfg6dhZLWd+dzdB0Nck0QFimdpL+BE
	jS4RVbAVgaVNjZykI0kPpFvNud640WDvzBGb7a+fsNbqUpjOHgrk9hGOtjPtODYpZrP94grHsFo
	nJ+gyeW5MpjVWZonIEg2IrerUwLLKu2wTjrWO
X-Google-Smtp-Source: AGHT+IE5Z0Cd5ZP1M5xJnwi7ge1Xv70m2SCP04JaV06E3n16w03DHPIGim1lZXVI8vYMw81NuCMEEgRnPM+mT8nDGyU=
X-Received: by 2002:a0c:ea85:0:b0:6b4:f980:9f2b with SMTP id
 6a1803df08f44-6b501e2487fmr52257526d6.15.1718871383512; Thu, 20 Jun 2024
 01:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-35-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-35-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:15:46 +0200
Message-ID: <CAG_fn=VfeugzYZ05O-XCo5GJA9m2S76VrwS7yc3uPYM6zUpKXQ@mail.gmail.com>
Subject: Re: [PATCH v5 34/37] s390/uaccess: Add the missing
 linux/instrumented.h #include
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> uaccess.h uses instrument_get_user() and instrument_put_user(), which
> are defined in linux/instrumented.h. Currently we get this header from
> somewhere else by accident; prefer to be explicit about it and include
> it directly.
>
> Suggested-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

