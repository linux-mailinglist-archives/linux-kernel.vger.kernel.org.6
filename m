Return-Path: <linux-kernel+bounces-214413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73ED908407
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D05D1F2278E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B931482FD;
	Fri, 14 Jun 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xd4GfH13"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804691474B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348052; cv=none; b=j7egzozmC+tbi/znGqNV62KBljLrH1zK+ExuCIzdQwzrl2N1S8SkQMiSMGuHfq/eiaWu0EqQmneFNpsmEF6XgTszrvTB8dHptDB/qHaIJV5SPE0jUyuzqcAvko6w4MRnFbsQ1Jvr+UL6IB2bI6WAoSzYcDJDcSy1eL8csP4cDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348052; c=relaxed/simple;
	bh=Jl63cl122kli1IlKKr3jwcVyICkX4UhQtyR+h3iEowQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XihSxokQ+VM6PEbOphB3CP4+se8kj9S6J7V5LGFNyXm1vGFjMGSeaVZHXBTEHqYJvqedr3ZWvA07vrYYpJBhzMSgpmOEILqmHU7VhAIqHsIwdBzwNpTa7DRgfhFY3cI9ZRKEJSpAf1qqEjeK34eJ9BqCARLHOOZPsQPmdB1LiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Xd4GfH13; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso289175466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718348049; x=1718952849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl63cl122kli1IlKKr3jwcVyICkX4UhQtyR+h3iEowQ=;
        b=Xd4GfH13WBFKKWUWOsUJupp8teugCLQgQo/vLyIjw08Gmheq/5SqBgBKePJRWvgV2L
         LJdXUHKmSwPUxl/TBTIRMWsN+waAyBFW7pBPr/CbyGv/pWlVjdjOACmSsqfUyJGotZsh
         7s/3cC1UwD7KrEgW3ionPelWEoRSzuDKZZ02g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718348049; x=1718952849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jl63cl122kli1IlKKr3jwcVyICkX4UhQtyR+h3iEowQ=;
        b=JKyF+4q7akplY/FoRERo7SFbTh+F1DxMjliS98QZezGh4HBvKlkUxo376RFNP6ADs9
         Bc9rOx47kgBRaaJuhcssncXZPxsI82T6DDwsiepwGqj7+obAuI6Hybg7+nKvSoGZCXXM
         c19z4bpKEOKFk9N0v/dsGYssE4uLYgeO8U91isNn8z9ucpSWStlkBVK9Bj3KU96L08PA
         bKjpXj/wf/YG3fnUHyAqc6CmN/ts+rEpQib0R/X2rkAVsUuLZELeeQ4h38wCgZuVZ4Ve
         OFyV01Pb1Nk94uj9DI5YZT9o3fRUyfMuINCuXDL8/cnBgIF9+7yD0G3G9P4bBrfcJ+GI
         SR/A==
X-Forwarded-Encrypted: i=1; AJvYcCUX3WS9s96CBnlbyXNw6Lhwkxa2I8uVFvZhA1IWP763D/nhk/K6ChBncwcWxDs/0971/1hulFQ+wSD7xDs7U+eNE/qjM+xW11OhJ5H2
X-Gm-Message-State: AOJu0Yymbual9SyXEWvOFcLpgMWKccwBCnA4VHwLqu+2BFc471KY8/17
	1kelKdff5iPkSGp8uhE3iDVaKQuI9DNqcoLMWlBvQo/zMwEmyyUeaq7zM8bxkyPNIgeDSfuW2OO
	WvL0nYOP8IqB20x1fbg+MZTbT1AtoMxbE1TyifA==
X-Google-Smtp-Source: AGHT+IFvea/cW4emLRNHFxJN0gw0MbDpL6G+wrsVPjsnfO+GhFJHv8i/1XtY537FV7KEcm2aGQvRbVb+q4y4gSNZzqw=
X-Received: by 2002:a17:906:b0d4:b0:a6f:510b:5c88 with SMTP id
 a640c23a62f3a-a6f60de343fmr108502566b.75.1718348048635; Thu, 13 Jun 2024
 23:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000871190061acd8fed@google.com> <20240614010522.2261016-1-lizhi.xu@windriver.com>
In-Reply-To: <20240614010522.2261016-1-lizhi.xu@windriver.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jun 2024 08:53:57 +0200
Message-ID: <CAJfpegtiqWwr93_rtXU3YyJLmtHOtP8TAKQN0FLKVN5Yaz1EZw@mail.gmail.com>
Subject: Re: [PATCH] ovl: avoid deadlock in ovl_create_tmpfile
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+b778ac10fe2a0cd72517@syzkaller.appspotmail.com, amir73il@gmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 03:05, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>
> ovl_copy_up() will retrieve sb_writers, and ovl_want_write will also retrieve
> sb_writers, adjusting the order of their execution to avoid deadlocks.
>
> Reported-by: syzbot+b778ac10fe2a0cd72517@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Thank you.

This is already fixed in:

git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git #overlayfs-next

Will send a pull request to Linus in the following weeks.

Thanks,
Miklos

