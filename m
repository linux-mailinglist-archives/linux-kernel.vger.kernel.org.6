Return-Path: <linux-kernel+bounces-378448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F99AD058
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5312812E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141691CF5CF;
	Wed, 23 Oct 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bEIR1wcS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FC1CBEBA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700737; cv=none; b=O2Jbygpu/nkvqt2zZ2CjWcaBpfWzPPcDxZayMydH2isLR8ZDaWbGnEF4PlNmrN9kVux1WfJPDENlVaw2ClMxtZz8l/TabXTxAgE3ju1ROmY1uKwgScsQ+3UCP2r8RWb563RCR3+idJngDO2d3V8fdLU9PZbXkKTSh1CTukWPAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700737; c=relaxed/simple;
	bh=77LpD4OV4E+Ga3+0yNWBek1q4fGhav7xENGbU0b1A14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uqWOmSfrlBE3jcXJAgjjd8bDVL6Ac5GT1VirdsEgYpRbIIQsXCqLVlM6gLDKyZ2ZkYcQh2V99JmbzFp7LPdf0P73Wr8TzxM96LSfXOrc3Avt6j0eebEQMyHQ+kxRm2/JCj4z/6lTXK4DyyORFqw8EIPkDq2Ry0YNZiBlOIf6+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bEIR1wcS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso108538671fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729700733; x=1730305533; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vyRJzq9SE6S3u0SzDMtXCUEzA5YutsiEsRxl1MT3JE=;
        b=bEIR1wcSTquQKISZIiaEpXkOPzBGlf6sDXaMYI3VAgnQHO9HZqHUyMc7RVdMkL5ivn
         PjC9iDOVlxRqSfk12Wj8MB60PNdLGB2UNEXkOWdIHPwaSzBA86rR5J3/EpBlFwnHUboS
         vG/Y3R2s1iPxLkSihWSJdXncHfKTBoV5SBXEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729700733; x=1730305533;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vyRJzq9SE6S3u0SzDMtXCUEzA5YutsiEsRxl1MT3JE=;
        b=WylvqfXa9O2EsUNKBh4Kk3VNWOf9dicACeaslS2UwvFMa8GHF1Z3AsWQ53Rdi0G7gV
         sxuYS+ZW3baehLMyXhWU+c4OI9usOI5GJQwYqq6YPwn5maWfM5AattK9wHFQZF7lsiTi
         j9rx7cy70ImHz8HtDemar+sC30S0hHMTpz8wi8mZZpSdN1tvBAjb9qadfNTMMOcykstD
         N1+5KN1lqVCJi+CuIbv4CD6yn4mNYmsS1GrF8dGiJ8u10fEW2qdELdzuFQhtZrpw/2Un
         oCGXMiXCmsP6TYKriwRpnGl7DEIvmLnR32wG3U1xOVxPPzSg83L9w/Bq32IohyDbfunq
         whoA==
X-Forwarded-Encrypted: i=1; AJvYcCXTvK64kxfQkZqqQCS6vXFfUVnl3SC/3DQiiT1x5IlGoRWjtjHZtpCiYgw06ug1VVZm/Rzk3oPVuwXEdkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8WaEsxtEXKcPGFr5+09T1HWcIUqAoewoH59c8+EO9TjdJbtP
	8Ad9DkzULm/uGt4J5EbAZqXGoDpyivos3wGtpHCYNEbGkUIci2XUS8Na2G1QnjGHOB7R5m2jEoN
	P
X-Google-Smtp-Source: AGHT+IHicLYUw1CBDi+H2Yp3I3lJc61FHK0RMHus8PZ3gmblPVuiT/5MuWKe9rmoQmlO4UuaEqoKwQ==
X-Received: by 2002:a05:6512:12d6:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-53b1a39bbfamr3242764e87.38.1729700732794;
        Wed, 23 Oct 2024 09:25:32 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b13cf24a0sm544204e87.273.2024.10.23.09.25.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 09:25:32 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso108538231fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:25:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaeMbfOBhOoi25EC/CGgrUpFMNea3LP9GYf91OcNYHxd/rUcBg0ekfq4w0OUFwtx5Oa1+WMouLYOGbLLY=@vger.kernel.org
X-Received: by 2002:a05:651c:221b:b0:2fb:3881:35d5 with SMTP id
 38308e7fff4ca-2fc9d38ab4dmr26516541fa.35.1729700731684; Wed, 23 Oct 2024
 09:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
 <3de53e7fmsql2t7byzoqonyt7e22bztucjcypykvqiystbalw3@2vwnvh7jcfed>
In-Reply-To: <3de53e7fmsql2t7byzoqonyt7e22bztucjcypykvqiystbalw3@2vwnvh7jcfed>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 09:25:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzj34fgGwK2+G3NkW7nNOkgiC28952Q+Yt+EVWEKaB3w@mail.gmail.com>
Message-ID: <CAHk-=whzj34fgGwK2+G3NkW7nNOkgiC28952Q+Yt+EVWEKaB3w@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 3/8] mm: refactor map_deny_write_exec()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 07:30, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> Nit: somehow "new" is special in my editor.  Also, I'm too lazy to fix
> my editor so I'll live with it.

I think your editor might be in some "edit C++" mode, where "new" is a keyword.

So it might be as simple as telling your editor that it's just C.

Or your editor just doesn't know or care about the difference.

               Linus

