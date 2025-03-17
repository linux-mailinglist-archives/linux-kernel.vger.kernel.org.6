Return-Path: <linux-kernel+bounces-565163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D328DA661F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70624189DA34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC3199252;
	Mon, 17 Mar 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SuvLgFta"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A831FFC55
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251768; cv=none; b=t5U+vjig/+6M6DAB/QxHgK28Okckmq4lG6r9s7mZJb/KXpdJ4PYPob6MZmFVXqj32IgbcNrQD31/YDVRQr2BgQy2oydskj67v8aWvZozxaowB9laQ9XGfVkX2QPO+1brCE9SJl6twPzlmcZrFcMudDYOH7ayIde5UISvbJlCT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251768; c=relaxed/simple;
	bh=fB8FGrr2ALjQXEKFIHjpIgEAY9CqnvKKSNv5Y2ogpRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhMfGlJEBTLEJz4FiZh3E609CRCmn4ZCH0r5NaiMaq39yTRGJC5KnYXiOt3aXqikvzOrKIqqdDI7s+tU0GrcggZusCJ4uOMtQ5eUNxe1F2BVHg7oFGqhcmvajgpGsJYGzvdR7xSNwUnpoo/j+WkPxjHl033Zwja8sXcCCFebs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SuvLgFta; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so778887966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742251764; x=1742856564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/YjBKKl4rNXm4mmw7yANbNTNotviEtgwXyBYhBWZDc=;
        b=SuvLgFtaHjyx9dNYd0QaVWFMEMwH+cQMzzB0yzU7q1T76wtx5sG+zrpffVAhF5cQx3
         Anaf6uC6rLmVP4pqYZWIz7HfQ4gyzbzCWgnS7+fegGHvyYTP35wWVmDGjjh/nzk8aqm8
         AVINbmhAd+StsbiNMdynaRapS7H5NFJlwdTiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742251764; x=1742856564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/YjBKKl4rNXm4mmw7yANbNTNotviEtgwXyBYhBWZDc=;
        b=W68k1kjeuhwo8tV9PXyBehFAy3J4Nwir4Exz4UkiLEv7WjFDVJ9BHbZcS4cQjkNRu/
         NIR48n2q1kFjwZrK5mjt/byp3WVUeHQjl52jQgO5rQbsN+JqASKjytS06wY/pSiRC3s/
         EU7DEomHwnOiCAwMKhZy8lQcy6O+BLJ9sTyniFdgzp8wG6+fQ7VkUxYh12paPdZgXcx8
         GYnjpzW5BlwrWXBYVGn8a4BVIwZ6S+1Iuy3amO4RC5Pk4iPcCMbe3mx3GdCZcGKHYeLy
         c88CP2NBvHkziFpny7pJp6JmCRZsBqJ0D9NbmsPLfsNSDhIjlFDXVMBmcRo7Tagavth0
         Q+jA==
X-Gm-Message-State: AOJu0YzzGwsbIexAD5ef6ovWYeIRKyreS6108nRO5JW75megmtmTUie3
	do7AU7vVJs5uCEYFHYCM43rf1ZPtVuWqeZBzFqs2NiJNhJHcKi9+UQwe2yJKjRluHLvUkRY6zk/
	MLG8=
X-Gm-Gg: ASbGncvZkbim5/TTPPUjYHdBJAvEKsr/EZyvlgbZMa1FP1+XK4AzCM9YpAaI28O/PwB
	m6BGndNpzDA3VupvIqaBVV4AYRFJIHeRQyoT5j7yOgXqrvHFn28iANMCSVO3PAGDYH3CdiweFxu
	k1gWYcn91kxHldVs6VYcvKj7EoLTJ+hYJ8qL2I4uE/LKW/brL4jmfU2ITXqXlyE+FnDrLYyxu6J
	FDea9rDpx/sq5sObVVg0+jftXKcKgZ76wepCaqK/IVICAt5FDOCJJVRdAATQIei6wWk6BKdDsQn
	JreJg3I08yzkpbSOdKvECAneLIh3tRGADNad/8/QpeAJCTjeE4AFyjTrIEpoNQKYLOjMxxbAsrB
	ljwX/yloo9U1JTTbsw7I=
X-Google-Smtp-Source: AGHT+IHjcJCmlZtW0UIX6uEv/B71LPF0ccvt/QekOdDTtZIzGx12IpIcMjffHR2VetI3lHttLnYYPw==
X-Received: by 2002:a17:907:9488:b0:ac3:48e4:f8bb with SMTP id a640c23a62f3a-ac348e4f8f6mr984816566b.41.1742251764636;
        Mon, 17 Mar 2025 15:49:24 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefdbsm731454466b.3.2025.03.17.15.49.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 15:49:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so7171358a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:49:21 -0700 (PDT)
X-Received: by 2002:a05:6402:d0d:b0:5e6:e68c:b6e5 with SMTP id
 4fb4d7f45d1cf-5e8a09fd828mr13691573a12.32.1742251760629; Mon, 17 Mar 2025
 15:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317223039.3741082-1-mingo@kernel.org>
In-Reply-To: <20250317223039.3741082-1-mingo@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Mar 2025 15:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBoNCepPiOv8V-D8xcBW3O+SG1cs5ARMwvW_n5SEXMxg@mail.gmail.com>
X-Gm-Features: AQ5f1JpSG78XWCpmXZFNqUG8y9VVY3kUHOdUuZbVt8rD1wOBbhf4hBwc-8Xu1xs
Message-ID: <CAHk-=whBoNCepPiOv8V-D8xcBW3O+SG1cs5ARMwvW_n5SEXMxg@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S . Darwish" <darwi@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 15:30, <mingo@kernel.org> wrote:
>
> [ This is a resend with a proper SMTP setup. Apologies for the duplication. ]

Yes, now it looks correct from a DKIM standpoint.

But please still fix your name. Now your "From" line is just this:

    From: mingo@kernel.org

rather than your previous series, that had a much more legible

    From: Ingo Molnar <mingo@kernel.org>

in it.

No need to re-send, but for next time...

              Linus

