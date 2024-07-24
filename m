Return-Path: <linux-kernel+bounces-261308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD693B586
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C36F1F22DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9915F3E8;
	Wed, 24 Jul 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ika4koDS"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4715EFDF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840709; cv=none; b=UePQqj6XZgXzDnWiFgwD1//GEu6jr41I7CP+nG2N/a9FqUPZvdZHolgEsd+d6xkCulix48O+d94YaS0+g8CeS/9UfjjIfrqQpPihFNfuyjxdpzqiIZAl4dTnI4s4yfIcC+zvIQkZlsCef0CfaqBu5RDxFyboGtB1ofCU89dq6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840709; c=relaxed/simple;
	bh=gP5o8HrBGIhBZe88z9e6IYQSPdBZY9Z/Z4kBE0yEFVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/wLW2QWCPGgg60bYi7sbi0Ru7DunIFlN+zOrRF487yQa+gUaTbyZYN4jQkrLeW1xnDVdO+/IniJNiumUNC4vZwH/O1p/QatdzBpOKYgo4x/gc2tdH96kJ16U5pOH9bYyXxannBYqhzmmHta6Mzyw0z/cSJ5myuIDJ/++R8OI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ika4koDS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so13550166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721840705; x=1722445505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MtL8RkoaQ1vk5r9hq79DrEjgulqqHqTEQUIMT0i31RU=;
        b=Ika4koDSq2WCFKL+fvsmKvxaL2aotcioJqO/Z90Zgnk2dwLn3l8oZw2b1BY9tfb/T1
         fDSbVsQ1pUxB9KpJR2KcOtMPtb2VoVQlFXf6blAbOwEUEWrm11MZ0Zt/GsslQzpcB5c7
         huVNVK83LESGAQ4fglEXGZdWOKiqWOpGkEaWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840705; x=1722445505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtL8RkoaQ1vk5r9hq79DrEjgulqqHqTEQUIMT0i31RU=;
        b=dwbtT+B0Lnj2EHUMgn+Jyvpad+ZQEk0mb7zQh6i0vTd/03ZOWHB+agNZpi1RNZT340
         Wodk3J0iyadkiNCxnLbohmOzfAkHENofbTKBsgdWlHiFRWcNugpHrEoxBV4W2ARkooX8
         6fXg6Huh2AE3Fy2EfQKZUXz0femV0pRg90Lh7IYkjg2mltj96v6PMArk1yAvOoeuzZK9
         Y+/r8fqdpwbIi5s2GSLVSUwG7NGFpnwDyM2F0S18HopF0sgTIzRcx9wR7BzyzzNRY978
         BRJXTRLQvqX/TICPigQdFwWKH6fvvhQrOa9Cmr5MEUYvs0u09h4+DWhvCMsbrZHHNyg6
         iVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXch//s0kzDrFDIuxP/yoYHC2MTzueKPcF91yL2Y9bfnN3vVhldRBdjI1H/n76mY4JysHpOHM3MZb4pORQ3fLr9ggXjcN02akAVjYm+
X-Gm-Message-State: AOJu0Yz3Kk0P+Wk/0qMSsgqyHgC4Su2lZ6+FmwlPwgh7UQECBoynHVE+
	1dVrWgnmB/AczSrpZ4L+jYw/sGNbTucfWRpDfC6G0DuOcz5z42Ru595lfrQRQkWzu1dJvrJp99F
	xPCJ66Q==
X-Google-Smtp-Source: AGHT+IFVk5PWIuMoTY7pTM/v0pEiM3ePcqbmM0VhFxRP/aDzKsTjVgoQ0yg6DNm8N4HDEWevm3598A==
X-Received: by 2002:a17:907:a584:b0:a7a:81bb:cee0 with SMTP id a640c23a62f3a-a7ac469177fmr14847366b.28.1721840705144;
        Wed, 24 Jul 2024 10:05:05 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922b5fsm667131566b.178.2024.07.24.10.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 10:05:04 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so112582a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:05:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRRJlhLS9UuJL/xjbefh0pttuoXjaC5cim0AzHtOcp+G5nf9g/VSwMkLuEb6cXuo852X8P/ImX6s5ixJ5uQMEen/3C74L9RapjKgUa
X-Received: by 2002:a05:6402:3511:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-5ac123a7ac3mr287347a12.3.1721840704253; Wed, 24 Jul 2024
 10:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724010550.1755992-1-willy@infradead.org>
In-Reply-To: <20240724010550.1755992-1-willy@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jul 2024 10:04:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4_5KdXq9HoA6L_Oy3vgCo8eAFAMNMmO9eBJgu9sW6QA@mail.gmail.com>
Message-ID: <CAHk-=wh4_5KdXq9HoA6L_Oy3vgCo8eAFAMNMmO9eBJgu9sW6QA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove PG_error
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 18:05, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> There were four pulls I had to wait for before I could send this to you,
> but PG_error is now unused and can be reclaimed.  It could wait until
> next merge window, but I don't see the point.

Well, I was initially inclined to agree with that, but then I did a
test-compile, and that immediately notices that you never tested this
at all and that it's completely broken.

There's still uses of PG_error in fs/proc/page.c, and in
include/trace/events/mmflags.h, and neither of those two cases are
new. One is unchanged from 2009, and the other one has gone through a
few code movements and re-orgs but also goes back over a decade ago.

So clearly this needs to be in linux-next, and as such this very much
is "next merge window".

                 Linus

