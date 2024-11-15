Return-Path: <linux-kernel+bounces-411440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E19CF97C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635B11F23D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD420650A;
	Fri, 15 Nov 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R4AoMegB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B6204F7F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707913; cv=none; b=Q5cs4Ldxd1jDHcxuYs21NJ+BkNCP2/99HTVRNd1HP8iwk+d/2qtHPdnl9iQ24aCVFBq4tOj0Otx6qIfsSEqWx6skFHulkqpI3KwlCLsp8ipv6NeONArPc6k2Ic7rt8DWpo7lQptWPu7i55f900YLJahKsb40GNEC7slehkOcfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707913; c=relaxed/simple;
	bh=g4WTLpGaO43c1cY/RMUGBtFzSuXgKas7YywAQYBkRWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTXKJ9VCSzFxTNB1o19Z/Y4WOPwor0CqWDu72R/s3IerbAeU/8qOgL+BW/P1OMy7jGKzHTde48Plzt58rsRM3fuizGfYeo46kGYzgXbBYMmHTBI3Pt8qZBMKPixjVL3Z9Rw0AZ9NApCRE5nJmA/V7P36M7QPR3k5sGQCYf3kDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R4AoMegB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a850270e2so4385466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731707909; x=1732312709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wYVDpD8Nh4uJBmCvYiP2LN/4+G5l094gMFhZFvM168=;
        b=R4AoMegB6KLw/hNgmipXMYrVf0lRmVLYFL0cwPRZI9yVkp4CBWLkqs9A6yyTxBHK5j
         H2cAn773rLhfKiYOPe8YlzFhV6ZFfH0zTpenhQEKcBtr2Qr/Ng4A0nEF+Mv5wVCVOIRl
         afuhTRnCN7w7JNkbRotJyDCBLNWXL+FRQhTQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707909; x=1732312709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wYVDpD8Nh4uJBmCvYiP2LN/4+G5l094gMFhZFvM168=;
        b=oDSgxxkccBXodlqGAqWbU0JtqHb5hhOHjCpnQNKenVwX0SLvyOxu5YzopAYluP6VhQ
         51B/ZMgwG08nX6XT6SGsuZqpNoiEwgExSxwjnFfvRt2+01Dnqq3oiKVkmx0dYkqgnPJV
         qgzsdVhA0jTmTCatJSbEzh/1rpNvQHdV8ryyvx7YxRdCszD9AVYf3phRy1q0sJpil6oI
         P1HsI0qPkQrhaMicbHEltUdKE/+LFj8kcAFDdSnrInKbZ7dxhTRhrAzGpjXZYKrIMn1B
         JHENipP7QFPNd58rLvb4coG68O65275Gm+5jsStMgwY2Y1CsDMlDHDRSnqz5wGnThQYE
         k2cg==
X-Forwarded-Encrypted: i=1; AJvYcCU4u2g9Si0+FnHwMo7PBH+/EyxdDoThIR4scguD1dzCdyaL62M2i/c6QHzsnp3go3E8AYB40ulPxMRGkDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkXiCCd9Vw+/KeemLEhr9y/3xW4sYVViXfwQ/o3ZgfsbV4f6C
	ilOOw5wo8vQaFBq5GwYURrz0z+ON54nG3PDtTVfMqpc6TK/AtpT9sti7TtqoUDMmeTuJ1L1RUpi
	pcJ8=
X-Google-Smtp-Source: AGHT+IECZU8cS1Vogo7eNHxKVy3XV+GrqJyjcoJoV3S7TuFcst2pa0vem0zWE9g8074xt7w88Yg89g==
X-Received: by 2002:a17:907:1b17:b0:a9d:e1d6:42a1 with SMTP id a640c23a62f3a-aa48347e790mr382555666b.30.1731707909380;
        Fri, 15 Nov 2024 13:58:29 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df2664csm218346266b.7.2024.11.15.13.58.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:58:28 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1e87afd31so1411766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:58:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpklxc9s+2E+uXT/MEKKDKGDGHBktU+0Mlozsf4l7XyfVwc+SLjIygy9oaccmU6rwrro0PGRtYeq/tpM8=@vger.kernel.org
X-Received: by 2002:a17:907:9344:b0:a9e:8612:f201 with SMTP id
 a640c23a62f3a-aa483555dd8mr383253266b.59.1731707907350; Fri, 15 Nov 2024
 13:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
 <20241115204602.249590-1-philipp.reisner@linbit.com> <202411151247.280F316C83@keescook>
In-Reply-To: <202411151247.280F316C83@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 13:58:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3vaB7kaU9q3+0jEtBDWMbT9EhRnJ+sPdxL9v0vdwSjA@mail.gmail.com>
Message-ID: <CAHk-=wh3vaB7kaU9q3+0jEtBDWMbT9EhRnJ+sPdxL9v0vdwSjA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
To: Kees Cook <kees@kernel.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:48, Kees Cook <kees@kernel.org> wrote:
>
> Linus, do you want a PR for this, or will you apply it directly?

Well, I'm certainly not applying it this late for 6.12 - who knows
what compiler issues it can trigger - and for the merge window I will
have forgotten it.

So put it in your tree and have it go through linux-next to see that
it's ok. It *looks* fine to me, but...

            Linus

