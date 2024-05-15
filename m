Return-Path: <linux-kernel+bounces-180460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A918C6EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134C9B22196
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA740858;
	Wed, 15 May 2024 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fcW6S9DD"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392A39FEC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813810; cv=none; b=OQ1NwPozBQhSkNWwSrdQPZoLxZPqgzBOaDG9EmQU9mCz92YE3491xu3VxY/Ymh9XQHpTI26HL23A26rdCAwEQM+/bl5hU11declnHOFInKzb5SpeguYDlwZBpvMOw5Myzwswjui4ZcRchfPQuAIe5PbOyUM8rRGLPkkOQ7j+HzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813810; c=relaxed/simple;
	bh=gM16T31Z+otHgy3cNvWS1tbGeqNl8wicgPcAlV+QCi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAdWjGZbxwDoDbLccE7eNa8si0UNObHQS0IysFJYsZGDG7QZcD3JqBzcGxpZ0S6XcYESDmhbMOwUMtqZ4HomwIa2UvHUiI0VkFuOdiENmNvTqO19oFAA0fBDEIbhDEdUjrZKbvmDqgSkD/W1SBvNM5hSoWwn/eJquh3SEf4dQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fcW6S9DD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e576057c2bso1427161fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715813806; x=1716418606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rflWttzbWDSOQUcPljiI/Fl7JoN/xYtdVg8WGCfv+UE=;
        b=fcW6S9DDwFgiDMgGG5VxOpJXZugNgJMpIhpQIYtU+gFT1/UUQxcY28K5CyKj+BADpI
         6ze7KetdebibjDzT0IUxy5rvtKr7O3KWLeHk+NXOfuTs/Ko5CgWLWSny7/nyVDeczHcL
         zTUBclVrpLoeN4z9kG8yvffsyrScYwp7Ov2fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715813806; x=1716418606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rflWttzbWDSOQUcPljiI/Fl7JoN/xYtdVg8WGCfv+UE=;
        b=d1lnorYS8JZV5bENfoKvgr2JoxeIAAo2fj9ZNNT+32nsSq23gKO/Z+XQSXh/c/h2aS
         8FQRGcl3yig88rL/zkZLKCdx7ByDUCAZOn3qRYoqIZxe8ZpaqiI6tEIFSyqjmueMM2ae
         MdPE6K535/dektLmwrU8K7fGHRpzxTJI81ChraDaRqyYg2CbByMXmurtfYK9xoddjR0/
         YLo7uQY57JuPkwcb8zFnTXLigE4T6bP9YCMfRcVf7n5X1jEgVMtWVBGYbcCZ3M1WT7FY
         snVT3uH5b9fT7rrCQWIZ/uz87uXY/L3SAhiK+uQncpMqG1fg/Xp5TCcsEmnklyTeyxRJ
         fCsA==
X-Forwarded-Encrypted: i=1; AJvYcCV4YGa2ykWrMBYLYp04TYJZvjqiA053B4O4Sfd2rEU7YdWgXZSdI2AEVIj3f6gyPbtSHUMYhVfvn5uxfIjqa+kFbzn0edZLf9FkJ2XP
X-Gm-Message-State: AOJu0YzVhGgk5IPYCu3NaHjWHcJnF+jql9TsV44b0Ij7+y2f0ufNTrdu
	YQFhC6uzyfoy2kX/ceq4NEIr3izDmjJmvxh9Bgfl9hI79zNJIh+DsaVYZOJYivY6k2/kmfyVlUE
	tHTNtuw==
X-Google-Smtp-Source: AGHT+IFI7gU5s29zLFD4+g5QGR0efW/OIO9ZLQuEvRcfJcQGK27nX8k5BTtDbCH+/P6llA7w5n27tw==
X-Received: by 2002:a2e:878d:0:b0:2d8:5af9:90c5 with SMTP id 38308e7fff4ca-2e520289226mr146268191fa.39.1715813806492;
        Wed, 15 May 2024 15:56:46 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0bbc729sm22515851fa.1.2024.05.15.15.56.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 15:56:46 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-523b017a5c6so155943e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:56:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+9+gDsIqje4/Vxj77782vzrtpMJgoV4uPhPx5teI4AOiD8PDqLdtxQPsjJg5DuJeUcZMT/P7YFaok9QvEwNkgrAP97sdBDQY9NBu4
X-Received: by 2002:ac2:4158:0:b0:51c:fd0a:7e37 with SMTP id
 2adb3069b0e04-5220fd7c82dmr10712859e87.20.1715813805252; Wed, 15 May 2024
 15:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com> <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
In-Reply-To: <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 15:56:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com>
Message-ID: <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 15:45, Dave Airlie <airlied@gmail.com> wrote:
>
>           The drm subsystem enables more warnings than the kernel default, so
>           this config option is disabled by default.

Irrelevant.

If the *main* CONFIG_WERROR is on, then it does NOT MATTER if somebody
sets CONFIG_DRM_WERROR or not. It's a no-op. It's pointless.

And that means that it's also entirely pointless to ask. It's only annoying.

> depends on DRM && EXPERT
>
> so we aren't throwing it at random users.

Yes you are.

Because - rightly or wrongly - distros enable EXPERT by default. At
least Fedora does. So any user that starts from a distro config will
have EXPERT enabled.

> should we rename it CONFIG_DRM_WERROR_MORE or something?

Renaming does nothing. If it's pointless, it's pointless even if it's renamed.

It needs to have a

   depends on !WERROR

because if WERROR is already true, then it's stupid and wrong to ask AGAIN.

To summarize: if the main WERROR is enabled, then the DRM tree is
*ALREADY* built with WERROR. Asking for DRM_WERROR is wrong.

I keep harping on bad config variables because our kernel config thing
is already much too messy and is by far the most difficult part of
building your own kernel.

Everything else is literally just "make" followed by "make
modules_install" and "make install". Very straightforward.

But doing a kernel config? Nasty. And made nastier by bad and
nonsensical questions.

            Linus

