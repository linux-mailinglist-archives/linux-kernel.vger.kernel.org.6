Return-Path: <linux-kernel+bounces-337094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598BD984539
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35F3B25494
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC81A706D;
	Tue, 24 Sep 2024 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T8DwmpgB"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECF1A4F27
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178709; cv=none; b=hiZ7cAiQ1tF6ecM2XZ/lCcCvn/3Dcq7npCkt4EmdVxxj9ZmQ/85HuWEai9YK77DCTZ9IX3rnAkrVMAf+da5kkK2baD3Q9Y79K+n+SqQ/GnlmgXzSH0px4+bABqBNX/9+iza2UugIZLBRMtcGH/z4/A9NU9/cw4u9kaN0o239fP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178709; c=relaxed/simple;
	bh=8wd0FhMm4eRlxVqRY+JtLSOUT/t3jrckmmXJshW/lYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7TwFx6jMEW2IgNtTyHN6VoqdZHZxCSLdoj4pUEt9QaiWUXz3bB8txrPEzRMj7Vg9Ojp24KwMPqUbkI/AiqMc49fJwr17SJyMhyDFXmmshxMkXM49Qqomg9UD2TVn8dY3o8ctI+1+O3fPMyciVW0M26ltV6CIWfaoM1HlrARQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=T8DwmpgB; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f7528f4658so47390851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727178706; x=1727783506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5Sg1xu00ac914KvYaBgVFfpg+QdE6LOenp8uycdRIc=;
        b=T8DwmpgBqQBBoflKh5vouS2GWZLXSygxz9xZRaHoWB8O7WHYxGHNQlJjnFsU8VKXQY
         zqRp/74L16KVaUuo6xsaARU3z+OUmk3S8/IbiGEdcxtocz/XqAxeZn3QG7SSVgXyZO+5
         YQm1bt3L6C3Sh0mjYMAQJ/JfeygYJK+ZCgZ+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178706; x=1727783506;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Sg1xu00ac914KvYaBgVFfpg+QdE6LOenp8uycdRIc=;
        b=VnrNn9XXCVtnjBW77t7RIZYwHTmem1J1lQ6ER+4e3dXquOLfTWTL2g11kjMICeuMNb
         WBRwshRBX/O8z0n+GfjdG+a18TmXYrj+ljVTk67DX/Zm74Xtnj0GTUrC0gusXqmy5d5H
         fVN5Wfz9DgqV95c9YiQgoFdfZdhao5C274rkHFXeCHwQqQWG5QC63hxBBAaOj6/gf5BV
         lwGKtbMeEjeHr7p9E/+EGEPejfOjRFLdk846TcXFi46DXN/x7awSW8/f+LUiDHCLI4Z+
         cLMa5dtuYwXJD1sD/8wLZnyn5NGqalXJe8u2lkH6IjywF4PVTrrJf3T+C+4LNmgASr0Z
         E8vA==
X-Forwarded-Encrypted: i=1; AJvYcCUFKENHP7kuJO2xIfx7laNlCizz0hlQ+LngWiZwU96XzkFBmxKjeiry1hbGj2fY7za0K/gPKKyDhkTssB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WB0Y4qJk3cyA07/nUFndZ+nq4H9bQVlt8UGLaQbnHEVUuVy1
	aV0PEeJ9+sFQBk+8y2DCwV17Wx7S1Oq2HVEVdU7eRjKpRv2R6Co9CpJuKYiMH2Db+G5wG3g4qjn
	8
X-Google-Smtp-Source: AGHT+IHyOMspr60vH80D0irmgDz0HF04iiepmTwjpL26y5GL25/8xcH7v9+GVtxBnKT9XjmoxKFW9w==
X-Received: by 2002:a05:651c:221a:b0:2f3:aed8:aa9b with SMTP id 38308e7fff4ca-2f8d76d29bdmr1390711fa.5.1727178706495;
        Tue, 24 Sep 2024 04:51:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm656463a12.61.2024.09.24.04.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:51:45 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:51:43 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Sima Vetter <sima@ffwll.ch>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.12-rc1
Message-ID: <ZvKnz7QzEe3jMbaH@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@gmail.com>, Sima Vetter <sima@ffwll.ch>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9txujwc-GoV6qB1DpKjbDi-8uDcJLnJFSY4OBgPu=ZAVBw@mail.gmail.com>
 <CAHk-=wiehYLXmbf8eZ080n7LEeS9=O5kEpGKjeP-01dj0EAYbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiehYLXmbf8eZ080n7LEeS9=O5kEpGKjeP-01dj0EAYbA@mail.gmail.com>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Thu, Sep 19, 2024 at 10:12:39AM +0200, Linus Torvalds wrote:
> On Thu, 19 Sept 2024 at 09:48, Dave Airlie <airlied@gmail.com> wrote:
> >
> > There are some minor conflicts with your tree but none seemed too
> > difficult to solve, let me know if there is any problems on your end.
> 
> Christ. One of them is due to you guys being horrible at merging.
> 
> Your tree had
> 
>     drm/xe/gt: Remove double include
> 
> which removed (surprise surprise) a double instance of
> 
>   #include <generated/xe_wa_oob.h>
> 
> but then in merge commit 4461e9e5c374 ("Merge v6.11-rc5 into
> drm-next") it got added back in!
> 
> Please be more careful with your merges. You can't just look at the
> file contents, you have to look at the actual history of it to see
> what the *cause* of the conflict is.

Uh yeah not sure how I managed to butcher this one. I do check the history
with gitk --merge and then the result by both looking at the merge diff
and the new --remerge-diff output, and that merge looks like nonsense in
all but the last one. Which means I was asleep at the wheel when I did
that :-/
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

