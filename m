Return-Path: <linux-kernel+bounces-307943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26570965543
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AACB22DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145213633B;
	Fri, 30 Aug 2024 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HLN2eZw9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B520323
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985156; cv=none; b=h5pKnu4cquZ5y/SbtkZED5s/bZ3PMrq+RxC9comyYR7DvKnsZHHEZIpsz5tMdO3bsjqYfCECHoqK3SjKZOI6FMWklI4r1g7dAk4O+wvZJKRk2ap9vbg0JTNGjJbIyJ2B9A3XueMhtxhrgGo9uyI6XW5OKH47el61F2cWEcy7JP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985156; c=relaxed/simple;
	bh=IaPQqRnc20q7dXoWL6nr1eUdV/091q55RMZ1PK+2rOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWDFKSjdu+YaKDnSBEjHC9IDnUGuKLmNlRzHyjIezmwN58EoKqf8RS6nma0tjd74i0rGpCNfXVDCeDX5Z3XnLChTwX5bh0zHv1XtEx7/sMjWDgT1ZSw9axsfA/Ah2U3tgbe0TlJE56oaW5EDznJTNiMgb7bMCY6TyHXEMFyb764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HLN2eZw9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so1434658a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724985152; x=1725589952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RmoB069VF6EUIaCnpaVhJcQLLGtyhrjfKVxZgKUoxGE=;
        b=HLN2eZw9kYky7KTZ7cL1TBxvwHXpaE7sf8VkdFna61NHVPysPxctHMtD74N0pE8hsH
         svMirfL1xWDBos6DneMOc/xGLCw8EcGLng1wseNdMJbbsr2gMk4ii9NI7DENIQhSWajY
         3ecAJ2vAgELoWQOsw53okvP/xCWB/RL2AGIQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985152; x=1725589952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmoB069VF6EUIaCnpaVhJcQLLGtyhrjfKVxZgKUoxGE=;
        b=aTvszf9hc1eI0j5N/M+sFkxLTDKqNJZXoc0uKCQ/tcWlqQuGOGdn4Qo+DvH6tjIjzQ
         LliJpytFssqAsCPK9ZYrDt08k1ZH7INMi121obYi+SF9H3zHirY2eV7JSUMBbkfzSHpy
         3YdlHUheY8ficbqgXnubXuey1aITZjCDbyWFMKbarQo4VmDImPVOpkPG11NVOo32wxIk
         haD2RFM9fWCPmjiuJmYjURVQWlkCvRfVE/8/9NpTbfqQWC3oevCQmwo4zxxsIIdQLJDP
         pM/BVeF9ejvyrxUtclWkNQlkp0AmRCgS6ZDHeQo1pa+BSqMzre/hoVXSty1G9M7xp72M
         +hgA==
X-Forwarded-Encrypted: i=1; AJvYcCXp+ZLomGS94jL7gNiRk7WFX8Og4+bkw3uE2pD7k89KTkR7I5vYcYCLKZLyS12SrtI6m60Qk03HRoZv3Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7MS0hQdkFCoHiVsobhG2cq7y1/tzg2JQHiVxDS5c9D45p/pnz
	XTP3ph93mwqG+rp5RLRclqwfPPWftMmKNLfdJwT66D0946ah4PRavmyvvobs0rKYpAmjppzr/My
	tF4roHg==
X-Google-Smtp-Source: AGHT+IG9NzzStgFDRkHSiK99Vr0M1hklIuZlazuEAJCOuV2ZS+1IxR3Ky82B0dp/4qH7u7fLYYoxGg==
X-Received: by 2002:a05:6402:5256:b0:5c2:106b:7194 with SMTP id 4fb4d7f45d1cf-5c21ed34dbbmr4388840a12.3.1724985151598;
        Thu, 29 Aug 2024 19:32:31 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a36fsm1340789a12.16.2024.08.29.19.32.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 19:32:31 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so1402920a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:32:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVS/SEi7FM7Jw3Cz2zLH0ieYDT+57iw+n2B8KVVWHjept/dctgw6YZ1RGuhT5Ra6TgQRiDjOAVhJQehUMk=@vger.kernel.org
X-Received: by 2002:a05:6402:1e8c:b0:5c0:c223:48a1 with SMTP id
 4fb4d7f45d1cf-5c21ed58cecmr3849130a12.21.1724985150681; Thu, 29 Aug 2024
 19:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
In-Reply-To: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Aug 2024 14:32:13 +1200
X-Gmail-Original-Message-ID: <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
Message-ID: <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.11-rc6
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 14:08, Dave Airlie <airlied@gmail.com> wrote:
>
> The TTM revert is due to some stuttering graphical apps probably due
> to longer stalls while prefaulting.

Yeah, trying to pre-fault a PMD worth of pages in one go is just crazy talk.

Now, if it was PMD-aligned and you faulted in a single PMD, that would
be different. But just doing prn_insert_page() in a loop is insane.

The code doesn't even stop when it hits a page that already existed,
and it keeps locking and unlocking the last-level page table over and
over again.

Honestly, that code is questionable even for the *small* value, much
less the "a PMD size" case.

Now, if you have an array of 'struct page *", you can use
vm_insert_pages(), and that's reasonably efficient.

And if you have a *contiguous* are of pfns, you can use remap_pfn_range().

But that "insert one pfn at a time" that the drm layer does is
complete garbage. You're not speeding anything up, you're just digging
deeper.

                  Linus

