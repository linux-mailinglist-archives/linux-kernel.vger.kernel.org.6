Return-Path: <linux-kernel+bounces-264900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1043893E9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25FD1C20CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3678286;
	Sun, 28 Jul 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUla2Myh"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947B37708
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722205401; cv=none; b=f4xwbbW50aRjqwJ8iKk5/bScClWcAXGhIFUoHdmwcXUUiCReeIELV+6y11GwnihNsT2PDFd0E8kb0ctubC1B1V+BnL3/Wsgdd9Fg255EGTLVEaM+CAdJPjLkpf+QAEm9XI6Nxn2qk8DqqpMwULZ7A/nZ2L3VoNnv9xl2zswgHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722205401; c=relaxed/simple;
	bh=5aF4VW/plJEHqkcOhf/0zJID9mpRwLAT3BuHbf7gcjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb06IQAFY9nOedpv88ZjTgMuT/fz2b5gCGM2gFRtIrGPP1x2Ru90zoWw/7JWju8u0smgT0sEc+rmH9ZcR+YlDi3pN8bLU7xtbmVu+YOvl652tlIGoHYUtlLuZVg4v3RKS74ao+1gtv4KaVWQ7J1g0ntUKa6KNb8y/6/LVm55QHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUla2Myh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so4049112e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722205397; x=1722810197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1sxZTRzwpCQhsO6um3jbebpk+88gE7Dcq+c4bF5JKc=;
        b=iUla2MyhO2ED0lqaHnhu99fQP2XXJ6dJHIrNLr8DPlJpZzfveIORItnIqDsX7ROCz0
         hs/G9W8JOg9mqZuXsK/pBSRKXhaQJNQ29s6fKfqEhkmGrF56IQOwXbKBsOM2ZiaywJHi
         r7GwRJKUg2dFwp8OPCFtSlQkX2clR71s5p2F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722205397; x=1722810197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1sxZTRzwpCQhsO6um3jbebpk+88gE7Dcq+c4bF5JKc=;
        b=kubYyEmcVvXTGQtLDLu7sAc23hLwPOynJo3IQpn7mpJBvX6iRiiGCnKt6wITFZpKNN
         6S4nMHNzUGpt8BG9YmxjhQqFjY3KfCjqbnljUQZyRpGOoVkHo3qP9jjyW4eOnKz8mc0Q
         qLBEzttKJLTHR+TpG85Oo1fX0y8KODLkWMUmI+H7fmcB0N/2/X1PDqbg3XBM4jqLbdjv
         MscXTWPe/a484CqVsiff7BRriD5Nz+3NmWptq0UHIz7AOzDKpXUuuXi3+bVbl/t+wCku
         ID6bWCE9fqE6UVidvkYX+apwsN1A61sH7FbJ1vcwfdkc830xGU38rP1OUMOpHZEx7aRn
         VjEg==
X-Gm-Message-State: AOJu0YygVShGsrGiIOsorZydKahP3xUBb7BSbtsGBNYfjzhg/UaT1k21
	Dd3FWPr9/sPvGln5phYG74uTcDTo6UXFcmKOtK9ak2vC3gpZNa2lah+FYw5UqHzAbsv8TIjuxhQ
	9IPPNiQ==
X-Google-Smtp-Source: AGHT+IEKrTgjnzgpzY9sPIqZJYekg92icCq85OR2QYGA4p8a71kHtjjCO4XYO4yjI3HsIcj/zdGQiw==
X-Received: by 2002:a05:6512:3414:b0:52f:cb5c:b083 with SMTP id 2adb3069b0e04-5309b25a268mr4009818e87.5.1722205397385;
        Sun, 28 Jul 2024 15:23:17 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad930e4sm429342266b.181.2024.07.28.15.23.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 15:23:16 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so2290775a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:23:16 -0700 (PDT)
X-Received: by 2002:a50:9316:0:b0:57d:524:8818 with SMTP id
 4fb4d7f45d1cf-5b021e173f4mr3707995a12.20.1722205395767; Sun, 28 Jul 2024
 15:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com> <CAHk-=wigkg43sZJKuRuYOzWzj9bxczE2toHNc=yxfyMM3m_kcA@mail.gmail.com>
 <b89b80c7060c43f8a937b8021b4fd7cb@AcuMS.aculab.com>
In-Reply-To: <b89b80c7060c43f8a937b8021b4fd7cb@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 15:22:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicdsz3bvy9g7RJ_XvugjxAT0XDitwTQLZmxq40JtHbzg@mail.gmail.com>
Message-ID: <CAHk-=wicdsz3bvy9g7RJ_XvugjxAT0XDitwTQLZmxq40JtHbzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
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

On Sun, 28 Jul 2024 at 15:14, David Laight <David.Laight@aculab.com> wrote:
>
> Ok, but those can't be used as array sizes or constants.
> So the temporaries don't matter.

No, mut I don't want the insane size explosion from unnecessarily just
forcing it to use min()/max().

> Don't they just work with min() - if not where is the signednes mismatch?

David - this whole discussion is BECAUSE THESE THINGS ARE A TOTAL
DISASTER WHEN USED IN DEEP MACRO EXPANSION.

So no. It does not work - because core macros like HUGETLB_PAGE_ORDER
end up being used deep in the VM layer, and I don't want to see
another stupid multi-ten-kB line just because min() is such a pig.

End result: I'm going to make the rule be that when you do macro
definitions using constants, then "MIN()/MAX()" is preferable simply
because it avoids the insane expansion noise.

Then in normal *code* you should use min() and max(). But not for
things like macro "constants" even if those constants end up being
some computed thing.

          Linus

