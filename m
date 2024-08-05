Return-Path: <linux-kernel+bounces-275226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1A948215
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE15A1F236B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E816B389;
	Mon,  5 Aug 2024 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JUBg4ITy"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740A165F1B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885062; cv=none; b=iuxXtYxooXocW3fqRi18x0mQrhVh6TrraVMXthHKq+ip8aceoRm+bNKgtx7WTVeUB2F3ZmNI399OZD51Z47coK/ANgnpd8kVlrh9h/y217g6DN9rlEp4r7PgYJDVLBy2thdSCStLGjHWEIN29QojZ9a06ctKC5SgU++h84L9FlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885062; c=relaxed/simple;
	bh=CoU8z7rPwlIktTSPXSLvGcHELQDE66WJAH2fIR5MIEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiTW73X9c6pqhaj317tx+MUU37KO1odpaAUabSXR1NN70/wX55DFDp5D4rtG1uYX8/NFttB9Y1Y89/ttNgimi4UpYWvrOJpqZ6kQr6dcjlt0RfUT/a2qQdBnXap7Z5LVjOPdDA/4akTEuap1VsvubsAiKT5TW3whwM6WBHgdRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JUBg4ITy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so10171727a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722885059; x=1723489859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UA5U+6t/BL3dNn6z4KME0ljFM05r+burKxZg1qrP5MU=;
        b=JUBg4ITy5C1yzU5XHdro3c+3qA+QQhKnEy31EADf12/xvJqeCp0/UBM/R6m0RQFN5f
         WshOKPZYNQrC2jpWOzw3u6ljrTy1wqEy4eymx6Fe/UpR5vJEnixHWa5OJ/4nG30ixIwO
         6C8lQX3UjWgZH22B29xRTA48H4VjCOybAQUtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722885059; x=1723489859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA5U+6t/BL3dNn6z4KME0ljFM05r+burKxZg1qrP5MU=;
        b=lxaPZAAu2ezQx9r/tTdXPbinkyczVvI3GbEWdF6/Hk+IBEjQmJ57RThk7gH9xMqQze
         LOwPOeVbKn7YvTzOYLJ/tCmPUf+Fi+OhRyeVvFufRAgrDsVqFPulLfYlAEb708ydE6CI
         h7oAFCicLFS+hJYqJgTYr5ChT5QrAJ4AnL2BKzOvn4xr96MEvKo/526vTFGzyhfHvdiP
         V2I5D+RZnCHq41BI1+Bd1dksxe5ElCjCxfp/7Dc7Dp+b0oqc0q9a9xobaFH8IG117qr2
         1fNjMNRE1JYSOFpKJPFXKYshpcJUp22rV23mvh44rwYAEswHXYdl7yl1km8IVmdrIDhY
         cXsA==
X-Forwarded-Encrypted: i=1; AJvYcCUMmAIyLpbea+jqQk/1HVvMaGIBXpJ763fm1y+LfKxos3Sh8vlRuiRuBAmehXS8axqtg8gVHgyhDuh4Cav0aKZTTiZ33vpV2YrFghj0
X-Gm-Message-State: AOJu0Yy/ZFuQzHG6YLwhUxRUumDFhPO8my40OLeY6kqBUF0MebnUtByI
	kPHsRbToA6LHdeV/QBRRwhcmS/gT+hkFaGsFFKxYxAhWVFNq45lBvMxR9T18ZxoII6d5ZfQ1hq5
	Jy8xLsQ==
X-Google-Smtp-Source: AGHT+IFaoENymcRGKc1ZDCdi/4Wjzd0v0RoDv6wGZ+zJ9MUYQPQafS9RS2TESTbC0LJghSGcF6JpPg==
X-Received: by 2002:a17:906:cae5:b0:a77:ce4c:8c9c with SMTP id a640c23a62f3a-a7dbcbd4ecamr1191871566b.8.1722885028714;
        Mon, 05 Aug 2024 12:10:28 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839708c56sm5241518a12.2.2024.08.05.12.10.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:10:28 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so10171039a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:10:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAQCvl1pkpToT87eZYH71Q52xoPcdOavwM9Sq2hwuRu44YkXPNpAi+VrJ3JbF4VDixxbDogA8OCfOYfR20pFy7tXhlNGY4SvjJVcZA
X-Received: by 2002:a17:906:cae5:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a7dbcbd4ecamr1191867766b.8.1722885027737; Mon, 05 Aug 2024
 12:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com> <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
 <E3873B59-D80F-42E7-B571-DBE3A63A0C77@juniper.net>
In-Reply-To: <E3873B59-D80F-42E7-B571-DBE3A63A0C77@juniper.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:10:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGBPFydX8au65jT=HHnjOCCN0Veqy5=yio6YuOiQmJdw@mail.gmail.com>
Message-ID: <CAHk-=whGBPFydX8au65jT=HHnjOCCN0Veqy5=yio6YuOiQmJdw@mail.gmail.com>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
To: Brian Mak <makb@juniper.net>
Cc: Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 10:56, Brian Mak <makb@juniper.net> wrote:
>
> Do you mean support truncating VMAs in addition to sorting or as a
> replacement to sorting? If you mean in addition, then I agree, there may
> be some VMAs that are known to not contain information critical to
> debugging, but may aid, and therefore have less priority.

I'd consider it a completely separate issue, so it would be
independent of the sorting.

We have "ulimit -c" to limit core sizes, but I think it might be
interesting to have a separate "limit individual mapping sizes" logic.

We already have that as a concept: vma_dump_size() could easily limit
the vma dump size, but currently only picks "all or nothing", except
for executable mappings that contain actual ELF headers (then it will
dump the first page only).

And honestly, *particularly* if you have a limit on the core size, I
suspect you'd be better off dumping some of all vma's rather than
dumping all of some vma's.

Now, your sorting approach obviously means that large vma's no longer
stop smaller ones from dumping, so it does take care of that part of
it. But I do wonder if we should just in general not dump crazy big
vmas if the dump size has been limited.

             Linus

