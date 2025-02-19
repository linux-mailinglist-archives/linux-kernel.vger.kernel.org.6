Return-Path: <linux-kernel+bounces-521771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90189A3C218
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E73A88C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB61EDA0B;
	Wed, 19 Feb 2025 14:26:31 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633401DA4E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975191; cv=none; b=uAUWY7ah6HkLp3YWPfDfcB7f3HJ6TycNGKy5VmcewceodA0SANSdrUnvgViSF69/U3zAd6TqKXKqLEDPYNmR0LfI0OL/rzr9UpRyIZ6APR+YVECXmWX0jf19cpGdnr2uHtwmrDhAmxhTk39ieL0tW55WFdOioaJqg7cPNyfbCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975191; c=relaxed/simple;
	bh=LmCsVIfClxEc68y0yhdklX+uWl4E+t7/RUn1SrdwPA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ejb78ENR0VqxtBEZ+10fKVcrmFVvel0PQ3Z2m0bWu6XSXGkgPf2VwgHoZQY3SambGNzi2Jheu+4oO8UTQz88QjAbRaRBpYSBLiTbfkJMf6WgghpiiKtl0QCYA0f60Ixs8LysX16isvE9eg8aSSpamXfckgdevOZPcQiB4yAcwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5209dad13b5so967058e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975187; x=1740579987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4yhCNhUGPCcd5Tw/szBBHBjKZ5YnOzqe/Gd4cj1U8Y=;
        b=qre9lbQYZYMoBqchKiccbNzPu5vgoAbGroWMfB+AhcN1HrmjqnRVXAEceOeGXZvcsV
         oR5qZozjy8Zx4lS0gZE+0IQBrafXpEt4wWSD3f1dwQLbEN1k+RLg9KhaVdIB156W/HGU
         w32BKk3kiUlMcZsMKu/NxP+CZ1CMEQK9H1iD7pMESfS9EAlAy2UL2H0WzcCkxCpgbfMH
         YrLbwGMJYx5Pku1u1laZAiQdj3UR7dZ/qbJEPpLAfeJ1IcvDLGSIveuGZgBbRluI7pLT
         QrkdEfX7Cy60WJSra45StzT0+YfdKHEaL9iIxtw46jfDBESSMmAf8YwRiHOf3fN6O+3y
         p0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVS4TMi1zy5UMyigLB3kewVk93Zj4fubcVhdqamMF9vaiEw6PCLrF10CUly9RZO5cV9OFO/iZAB35oHl8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtuSIo8CLXjRE+4zcKWYAFeAFOLCsJs+CoudEUCZ1TnAlGv27
	d0wxC52wuXzERbFIOO56/5ctt0iMpukPjDJ+gafO3yAFJOSVsaQQ1QZI0wF2
X-Gm-Gg: ASbGncv9GipoRUhr/z2YU8u21Zg6e8ORWQEzxS35o44vHz85k9QqHj7f/PpxkzfCd2n
	2gstZfdM8MyqT3CwdYFxaxPSiMAB03a/N/AYioPwjb6u6NHT8nHA0T57AtjZo9R3SzP2PcBy0PM
	oML5diDJo2rTE19H4Y7lO4oJwcpUy2SepSBWrfN5YDSDL6PkzV0EpwhAUZ4Y75NJ0ooLHYhYsKo
	laidNWOvFrpLBT4sQg+/cNenBE7BJYjngybdg644nZT9qhiqRLxLV7FldJnUoSxjQqAOa41hqjZ
	fIukahu/LnNvh+mcR2fCwtRb/jVshEwUAyzcWOfLAtRhJEfP9xVdPw==
X-Google-Smtp-Source: AGHT+IElvMY9aI5kxd49nxU0zjesGX7OhkIaKn/+kYe89bR/sDWobEXrmy6H4e9MvcUjwlmrGHHpoQ==
X-Received: by 2002:a05:6122:134e:b0:520:42d3:91aa with SMTP id 71dfb90a1353d-521c43c13e6mr2304712e0c.2.1739975187293;
        Wed, 19 Feb 2025 06:26:27 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5208911ebb6sm2885197e0c.11.2025.02.19.06.26.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:26:26 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-866de72bb82so2214222241.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1KsTg8nfLL4UFZ2v9NCTxAaAFuDlg3sPeZifO98V4Uj7ReqIbBUzQcQvFMcJsxKX5yOgMC2xGtm+pxxs=@vger.kernel.org
X-Received: by 2002:a05:6122:4f9d:b0:520:8911:df12 with SMTP id
 71dfb90a1353d-521c46a1fd0mr1816456e0c.10.1739975186522; Wed, 19 Feb 2025
 06:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219111445.2875-2-thorsten.blum@linux.dev>
In-Reply-To: <20250219111445.2875-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Feb 2025 15:26:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcDw0E4Hwx-h8AffKnHbvmWFARY1hCBc8Eoew0QwOWQw@mail.gmail.com>
X-Gm-Features: AWEUYZlPk9uUTLgJ8RmktcmMksJ2NIHrHmUhnGZCLlfyQvp90kK3BHGZUFgC9r4
Message-ID: <CAMuHMdWcDw0E4Hwx-h8AffKnHbvmWFARY1hCBc8Eoew0QwOWQw@mail.gmail.com>
Subject: Re: [RESEND PATCH] powerpc/ps3: Use str_write_read() in ps3_notification_read_write()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 12:15, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Remove hard-coded strings by using the str_write_read() helper function.
>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

