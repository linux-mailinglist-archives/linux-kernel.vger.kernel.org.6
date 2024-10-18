Return-Path: <linux-kernel+bounces-372513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362CC9A49AA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2981F24BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12318EFD2;
	Fri, 18 Oct 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EG1QC+s5"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074918FDC8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290545; cv=none; b=hc+ANv/9M8NkOSYkOxNtwDtZKxsLJUou3ek8qJPRrAM69GoSNvn0bxXPnRmSUBdo3AlKIU3RGcMjUdN9egQ/RPGE+cBXER+UwjBWVRTmOSwhABOwcGsKcj/gLFOVUNHnkYjTk+kSvRYbjsWx3tL1lzmvFPIbnRqG0iekU8KNPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290545; c=relaxed/simple;
	bh=03wjyWFtvc6Xih/NdlFTEfxmotvn8//AVR5offvvlkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6KW1HqnewUJ2OimPZUgdOxBCrhTd7qwSazzpZebgaSB1SBWx+AtBtfuUk73IFwC3FdrD1U7+sSYxTP/x0CCEV0oTZdcOpzals+KYv8ma6zaqwLnNhn3/c22UQwplfO6RZATbcwcIyRPXkXKoakqiGY4qKaEQ74l0Di0dYz7y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EG1QC+s5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso288497866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729290541; x=1729895341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=judkw8O8sSJO6cXFyOVA4iO8bRDGeONqQ6yqYjr3e3g=;
        b=EG1QC+s5bzQkVPHisWHn+j7chNwbk60ryBMshaEnrRepksLMb8F2na9gpC0/vTayFD
         /tqNFqai6NsttaGAVGxxF0cf+HRV8ffL4MWW6kRL2hTzKz9Ius8p7kAGgwPq6FkR9nNp
         B3kRoIG2xnd4FHzf5n2gOpGi7S7WxsfVGaEUrNRyth1fa4HgOJvVXhZKwZUG2yI6IVEy
         T4ah7/7uN5OSrkWY64+9FXOfsAAjmjZGRYI2iNJCg75pPZyoGtfHxJjODcoA/bRKW20A
         DcXL+ojE5AqGF0Kjmjb4sLRXpjvC/D89T3fjKYtq/OJUwmYjEskqc+FcyXKMq6SIDCnS
         56Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729290541; x=1729895341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=judkw8O8sSJO6cXFyOVA4iO8bRDGeONqQ6yqYjr3e3g=;
        b=nZ2djXwTcO+CvU+0YnpylECJhvmPhG+ETWvTUmG0BcfonlEifBIchVgvzy/ccLNrHL
         /KHe5i0/7rO3m7mdnd5Kf4473MOdOH1EDPDl825lsYHOjRKbwKWXD/1wCwy7u486ypwW
         uNCVt4Y+S8csy515+Sk+9Ox8CfACq4bI1ImK52k03RkvtPn6iFljQOcxNiwrriqG9MV3
         d5l7wgbwWamipvaQCVSZy9/D8SYfWztWEKZOKUng8R4UMw9GC38G3xY4euP672hUqK2O
         ODmKl9BbH6Cvt9lfBIK8fhU1EhqgIYYweiN1WezXkxcecESWaTHhJqiqk5c39p3C21cf
         3nXg==
X-Forwarded-Encrypted: i=1; AJvYcCVAbgbY3xdbVZNequhKASSnConOKUVxSsBw5bIKIdTwEU/mNbbyaAed7sDYwPcCoymIvg4tcrq2WQuyE18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIMqKigmb/KUftVPWla6SfXPh16UovQlqYTXufWQyz/ItS20Y
	LHyO8IrcF4nHdkhIowz61VGCsuQ5qkAqlizIbC4v0dqK8YOUUZkMtsvFHEtg+nKEUUII/Z4+8Af
	9T43cjDnxurCYU9ClIUJegyY/l4L1ZB3+GQOT
X-Google-Smtp-Source: AGHT+IGOgAJ6LnmbnDiKfkl9xZZzFY0FfHd2A14Wx40MUuYwgypPAjhNEqxQhhHeA4IFlxGcQ5lTjOCrHCkyWUwCrao=
X-Received: by 2002:a17:907:980f:b0:a99:fa4e:ba97 with SMTP id
 a640c23a62f3a-a9a69bad21fmr340098166b.39.1729290541002; Fri, 18 Oct 2024
 15:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018192525.95862-1-ryncsn@gmail.com> <ZxK7G3S0N42ejJMh@casper.infradead.org>
 <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
 <CAJD7tkZMTJKYR+au2rjP1v+c8PvdP4D39j86tHg=o2riKGYynQ@mail.gmail.com>
 <ZxLLNfbLifp-b3W7@casper.infradead.org> <CAJD7tkaycBYvtTCoGsuNUekSDNnE5SZb-XyS5a8j83JsKQw4FQ@mail.gmail.com>
 <ZxLVSkEr_Zd2Ai3Q@casper.infradead.org>
In-Reply-To: <ZxLVSkEr_Zd2Ai3Q@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 18 Oct 2024 15:28:23 -0700
Message-ID: <CAJD7tkZdTtqyZVKOB927YkYsoW76ZaTNrKV3KJnAbA_omaz9fg@mail.gmail.com>
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:38=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Oct 18, 2024 at 02:00:16PM -0700, Yosry Ahmed wrote:
> > On Fri, Oct 18, 2024 at 1:55=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 01:40:18PM -0700, Yosry Ahmed wrote:
> > > > Oh I thought xas_reload() is enough here to check that the entry is
> > > > still there after the lock is acquired. Do we have to start the wal=
k
> > > > over after holding the lock?
> > >
> > > Yes.  The entry is guaranteed to still be valid, but the node you're
> > > looking in might have been freed, so you can't modify the node withou=
t
> > > making sure the node is still in the tree.  We could make that cheape=
r
> > > than a rewalk, but you're going to need to write that code since you'=
re
> > > the first to want to do something like this.
> >
> > I see, thanks for elaborating.
> >
> > Could you confirm if the current patch with the xas_reset() added
> > would be equivalent to just checking xa_load() before using
> > xa_erase()?
>
> Yes, I think it would, so it's probably a poor tradeoff.

Thanks. Kairui, please feel free to drop this or if you want you can
check if checking xa_load() before xa_erase() helps.

