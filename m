Return-Path: <linux-kernel+bounces-532486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A6A44E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91BF3AF641
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE81A2567;
	Tue, 25 Feb 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z2b/nsVg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FEC40C03
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517650; cv=none; b=U/5j/XYqh61m3MTV4hy+KPWkCjF5es1uY7kU0vxo972mtZUe6aCzIOiVt0cY+BIkWlmW42KNc1DHSP78LCvUYM9+zDmXq+azd61AYsRusekFVynlSEalfyXPH9jV8ygFDAtZ6YYkHSpX7OEjBeprus3bV1qZdbHfUC4OYKWAPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517650; c=relaxed/simple;
	bh=QStLP7kU/H6Q5DTwstCE48OEpuJLb+0tRWLJd4PpdqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pknlg1gD1X/L9KyqFGG29ZdSWkzcZQVr65/oTqElbJjN0ocvY/XEwMyndkxR6yYKRIF0kQ+fNdmru0qRJuTgyZo90fqE1IFncGiYJrgNn7FGphZRRAQKKJHshY3Ig5XzxUbq1YXSfxS4OwkfOZaMfk8/4iN+vtitG9Ca+9wF/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z2b/nsVg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbda4349e9so891933666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740517647; x=1741122447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KS0+F21mT81i/tWAcFhVBiWxytCvW0/3x4Qj5tX3R9Y=;
        b=Z2b/nsVgZrz2zmmCb4yNefgWWgzHpWnuNIzVjERBbept4wMZFjHpg3ux/3143+jMPU
         1GD9lIA2bNooTuZ8x3LI5MPbWUw2BCYxpfbdEu+8lFcVLFpGN5U9HuAB08cR2vMaPMVC
         S0wQxNoeEz3fsR3xWXc/J/pgO2wiSCrg1l7kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517647; x=1741122447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS0+F21mT81i/tWAcFhVBiWxytCvW0/3x4Qj5tX3R9Y=;
        b=EIQQ2VZDfiGrcRR6nV8c18PLyW9Mn34Y1g0O67jknl3YQOY6dPVmRDicKy5wWBmaQq
         MqE4Dq6V8B9PZisujfWU5bg+0ovwc0UX6iZg/c2r4LWZSdzZsP8BhVEN6um/i+raXfrj
         QcG+RLXTE4Kd8MXH5r8D0bz95H6c5rtmbpQgyiWwu7lNZrWMupB754ns9C6Jdej7s1tX
         n2hako7EDRGPQLaAp3sa2L0P9+QmjcVZzHs2YDhfU2L4hxVryfukKMFPBi0DkuGF662z
         7sRBWFdyDA/CxdJ/m/qBJbvTpYd2tLgpbJqO+Qx20LQBMl+k9RrIUFOXuJ9jrpcGHfmp
         NdLg==
X-Gm-Message-State: AOJu0Yy13h3zX9S8PfWCw/7+Z23UMV4e5Sj8Gucf9UY1t7M4jHIz+gFY
	t3CyKBZTJvDoVeyfQo2DY4J7SUZR2qCG8Sq4GnZxEWgGye3JyJuynTIUOelAqhbY4e9wfNj2EEy
	BysQ=
X-Gm-Gg: ASbGncu8JcXXuqJtcYkLc69UsTEUL/FmIikXI6I0wyZ90iA6lW1i46rO/GAHtfMwdct
	GCBctSK91i9VvdRv+m1EqSp5+nqA9VuIfK6ggDqTP7gU5jFuU8HO7CWZmCJ9Hc0ECWLGKPnkxl+
	zWH+G4F/tHqqWOMmjhAY1Nuae4bVTrcHI2f8GU3hOVVbPObkvm8dzQdfQUnFgT3Aw6nIj/NgCk8
	AbU1Pad5J/l0c8ORR6DMwN/IXhnhLOkBeyqI3/PWKPunHryg6lspg93bLqsrJM3ZqRqHg7RKHT/
	9YdIMiHP3Hq2ZuTgJxvt1Fvg9ZYc8j+Al6iWCHhydU9BbLVuPNxtdSEZwiK9/C4EciOgve5A4x6
	M
X-Google-Smtp-Source: AGHT+IFnsmp0IQlDrpU2vXyUbTk8WYG6IMDd/FhGJh2EEEOYQSmJmYZYMZHiJPQAumtqTZ8vRPIa7g==
X-Received: by 2002:a17:907:970c:b0:abc:b96:7bd2 with SMTP id a640c23a62f3a-abc0d97d421mr1848911266b.11.1740517646630;
        Tue, 25 Feb 2025 13:07:26 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed204647fsm201364366b.124.2025.02.25.13.07.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:07:25 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so1014643066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:07:25 -0800 (PST)
X-Received: by 2002:a17:907:94c8:b0:abb:e7b0:5453 with SMTP id
 a640c23a62f3a-abc0d98781bmr1537905366b.12.1740517644705; Tue, 25 Feb 2025
 13:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
In-Reply-To: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 13:07:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
X-Gm-Features: AWEUYZmZfC87y1L1tpnGo4waiHehm2rxjxpr8QrJwMJwrZHzArD8aGOgeNgx2jA
Message-ID: <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 12:10, tip-bot2 for Matthew Wilcox (Oracle)
<tip-bot2@linutronix.de> wrote:
>
> We should, therefore, clear the _PAGE_DIRTY bit whenever we clear
> _PAGE_RW.  I opted to do it in the callers in case we want to use
> __change_page_attr() to create shadow stacks inside the kernel at some
> point in the future.  Arguably, we might also want to clear _PAGE_ACCESSED
> here.

This explanation makes ZERO sense, and screams "this is a major bug" to me.

If a page is dirty, it doesn't magically turn clean just because it
becomes read-only. The dirty data remains and may need to be written
back to memory.

Imagine writing to a shared memory area, and then marking it all
read-only after you're done. It's still dirty, even if it's read-only.

Now, I don't actually expect this patch to be wrong, I'm literally
just complaining about the explanation. Because the explanation is
very lacking. That's particularly true for the __set_pages_np() case
which also clears _PAGE_PRESENT, because then the whole shadow stacks
explanation flies right out the window: the shadow stack rules simply
do NOT APPLY to non-present pte's in the first place.

So honestly, I think this wants an explanation for why it's actually a
safe change, and how the dirty bit has been saved before the
operation.

             Linus

