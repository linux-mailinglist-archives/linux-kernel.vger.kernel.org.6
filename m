Return-Path: <linux-kernel+bounces-529918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D5DA42C82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1217A72CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E31448E3;
	Mon, 24 Feb 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gmrfz3Ry"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70F1FC117
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424504; cv=none; b=qji7uKSgb0wON+9cdo9u6XiqWIEf8F278cKcESddUK0kx5HtRHcDTvKWAoHnuUu9uFC4/BPdB194wxNy/ftKJcsJPDqyz1tOBVFA9oVkxuOYljzt3BjgATs8r9ZHfQL3gYI1fTzBjsjbn6BuAT0fOnntDmsIRnCoSTS3OTd1WnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424504; c=relaxed/simple;
	bh=PyPR7g3RvZN5snMxXyy5cQHXfPJa7xrkkt2SS0hf0F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0qj0CIg40NFXQT4jb8C5/ujbYBCVc8svIlnb1/cRVnPq5wA4z+Bo011FuSNmBAnIdZj4P4TKPvzQB25QvFnGuM9uEO6CZh9Ek6G6dA4OCamhkQYs75o79FIzhq2qXFYFSuNJeqZOQAXC1V8KUVQG0PMhMM0yag8SoC7oL7yUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gmrfz3Ry; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5452efeb87aso4800210e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424499; x=1741029299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFwWACfJvly3TimpIZIv2QEBJArjKTFr1P6UvNu7FGg=;
        b=Gmrfz3Ry2h3d+6gC7+llDFhR8FDh1VfgGKJUt8Eo55pbG1y+iN+GvLHNJ1XpDee/Ti
         rgsU8icogVsxt6v/2lMIuVKX5fb/yzHOKJ6arT5xMB2+o71G4BspfX+unyaWlwKRDHE5
         Qy0mSNYECLMUk6dkHmWLivXdgau3bv0JhG9h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424499; x=1741029299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFwWACfJvly3TimpIZIv2QEBJArjKTFr1P6UvNu7FGg=;
        b=jxFkiF1xngeryKGoodtsYyg7DN18fgGZK1eh+6DfrKHx2hF4B4/rM/liW8rzIs5aLA
         cUSGLN7k5khmTORZP7btkpyeNMyebDZzfQ8Fn9MYfvhDQ5ehZJhfT4Zr0f/kOiEQHb7B
         1x+kJANrvQIfMT7OgIg9Is+fDPWw917UHm6AX31fPcY4ROCUj3YBPte485Pw5Ivy6nE5
         HN2fvGE0vyM+1yiOwY2N1V3GvzrzJy9mqPDo44pJDiL9WTlu8xYuLubYxE2BXKvLSYVe
         iLbqhxuujN/dV65Hk8CmzrqwaCiT13emYnIRBf9VKJa42rGSa8rsl7LlJKt7RVpzWBgu
         9sKg==
X-Forwarded-Encrypted: i=1; AJvYcCXn5WX/aMQATsszRNlONVldW4UQXTF/5w9KDKmTxuFYP023oV3FqaMVyCDXXPku9eUC9Cy1nh34HrPSvss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/aaMcLQ3QaKxD/yVwXUzaaxh7jIhURIv+i5cviZwR0SXce5j
	TLZhJN3QTGU/hr5Y+BwQWs1YVYwI53fZqXIbtZoL0Tg7AUa40cUm9Fd7r3dptpCKkfob0sup31y
	E1Q==
X-Gm-Gg: ASbGncvACRyelRfCY45BcQaQiiHF25TbuJx+yUs4z2KyjIf37H8AU6gVt2YZGUEvZL7
	QLyWbwlmFFxe4DBIQN1Lbjw35U1RFgbkKwmv26GgLoio6vQKy2cCoco93gsyId0dw3kxAVfNS7l
	J/NUyibXfrGjvXZJ8C4tiGRAni00cdgnPnYrx3FqdTDo23XUQap6wkvn3lmmcK0kHz/lqAQNDl8
	+ZLwjb14PMoosISovFgiNir3QoS+AvgkXsHhZOwmAIUTISa6t1puLR0Kw1KpiFD+MDV5AO9Uvvs
	WziSQBhTVa11NTXa9q7pi78FcNJ8rIcQ+UnWTJtbCIKhoetviUTJM37vulSqOcTkxg==
X-Google-Smtp-Source: AGHT+IFQ11324rtl9UgCxdsjDeGpqOQ49PF081S0BemmwAz0e21lASIGP1XAIFVMWWQ3el7uHcMPsQ==
X-Received: by 2002:a05:6512:3d88:b0:542:a73d:a39c with SMTP id 2adb3069b0e04-54838f79d62mr6484265e87.49.1740424499398;
        Mon, 24 Feb 2025 11:14:59 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530b2aeb3sm2971642e87.175.2025.02.24.11.14.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:14:58 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452efeb87aso4800177e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:14:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLoF7f+x03xKeHtAZSyCcX0mczph7POXP9pC2OfvWNZ7gSPLV32Ixs5vjcZ3wkU3JrIE5lw8I6oI16ji4=@vger.kernel.org
X-Received: by 2002:a05:6512:a91:b0:545:ab8:2bed with SMTP id
 2adb3069b0e04-54838eff589mr5600639e87.28.1740424498000; Mon, 24 Feb 2025
 11:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214172958.81258-1-tejasvipin76@gmail.com>
 <20250214172958.81258-3-tejasvipin76@gmail.com> <CAD=FV=U22kToVeyCBy_TV5hNKuMZv-QBUg0WTyXsMSu=bHLd3g@mail.gmail.com>
 <260b1542-a9b3-4541-abbf-0edb796918f2@gmail.com>
In-Reply-To: <260b1542-a9b3-4541-abbf-0edb796918f2@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 11:14:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xn=ZztJVGA46eeRn442BnPAOwefwNid6Lm5ZHnLuCZcA@mail.gmail.com>
X-Gm-Features: AWEUYZmO6vGLyUBmWDxm78XuNqM9mknBitSEQMpTZlilUORJ0saWZ4Ayv5wcIFo
Message-ID: <CAD=FV=Xn=ZztJVGA46eeRn442BnPAOwefwNid6Lm5ZHnLuCZcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: sony-td4353-jdi: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2025 at 8:46=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
>
>
> On 2/15/25 6:12 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Feb 14, 2025 at 9:30=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail=
.com> wrote:
> >>
> >> Change the sony-td4353-jdi panel to use multi style functions for
> >> improved error handling.
> >>
> >> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >> ---
> >>  drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++-------------=
-
> >>  1 file changed, 23 insertions(+), 84 deletions(-)
> >
> > Nice diffstat and so much boilerplate error code removed. :-)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> If I rebase both the patches into 1, should I still add the Reviewed-by
> tag?

Sorry, I was away, but it looks like you've sent v2 anyway and what
you did there is fine. In this case my "Reviewed-by" for the second
patch was more me helping myself keep track of the fact that I'd
already looked at all the contents on this patch and I was happy with
it.

For the record, most of the time it seems like you're expected to just
"guess" a bit what a reviewer would want. The absolute safest thing
you can do is to remove the "Reviewed-by" (like you did) but then also
"after the cut" in your new patch (like where you put version history)
indicate why you didn't carry the Reviewed-by. Like you could say:

NOTE: removed Doug's review tag in v2 because it was only provided for
one of the two patches that were squashed together.

Then if I wondered why you didn't carry my tag I'd have my answer.
Some reviewers get upset if you don't carry their tag forward and you
don't explain why you didn't. ;-)

-Doug

