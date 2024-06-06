Return-Path: <linux-kernel+bounces-205116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C71D8FF7A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB26285FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E113C814;
	Thu,  6 Jun 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MuHAu5Oq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E62224D6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712543; cv=none; b=OcLSsRG+wxzkydwLMZnWJuiUeKCzPBITgYI9+VKKpeEaAxUSuJ2V7ESZTQ3pyqM/m2n7vXZfcyMk8L8laAyutKv68125y3t+2VPwhaUT7qFeqeeOoqrnd0lBywolgX5SENXqMctmS3VyV7HjOqRVDgw/Z8WEsrA+BBPVe8vaYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712543; c=relaxed/simple;
	bh=/42Lk3rNVRxuB4doXZKhDHXe/9xzm3ve3J2e3+7e8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WocaXjMRHnPmkNVaTyFmnhmBvZfyYaO5VaDi76bAVQFU3QfOIQ5hIz40uhvJK+o/W8R7jbw9IZp2KW788bsgmdlru2b3+sqlmR0RXP+i596QKKDCX4pN/Nl6gL74s/ME+8rpNgdW6sBnkxKuEPbIlQRg+uaLMaHp3DhOnltVlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MuHAu5Oq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso4290152a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717712540; x=1718317340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch35V7/zJQlvtjwyeXUgERfqnvOqF1FgOOA5wx1Q9Ak=;
        b=MuHAu5OqXy63LtV9zZjOddn681OI1MM2o2GP9unXrR+IeIfvJebPaAZYCa99uB5nSE
         vy9SIT+f4Kg8+g6Y4QFqoj+hp7dnawqrfmTgshelkkzMFKss+8u0tExOSWtJKz3k+pTv
         Ibor1i+C2hxL0uhoL7q/aIDj6B6dbHEqrzwcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712540; x=1718317340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ch35V7/zJQlvtjwyeXUgERfqnvOqF1FgOOA5wx1Q9Ak=;
        b=jo6Ul5seHW1AtOgV1IhxJHCMqQGN5S+ct07O50us/h6Em3CQAdBJooErl5Eyf6Dt3e
         m5r0bgREZ3YjASQA5OVnjpYi09tiXr7NbCs0Hmn20xFvSrmak5ThMZT5qwX2PK/UlbVh
         p/BWW3mdH8HLe052GUmPckjTzr0pahFJ2fccglwCEBLX1JlCFBlu3Q65L0n1rd/4gz3b
         MvUCLi/Kb0XKTmm+dbxdbFJuDcG0+x/k71Iqai9ReK5Wp2Z8xQMpvYevQ2dp33WFJeTs
         +p2g91Ke9KiUehMeT06x7gwsCtUlI4HpXI1dNjTPGvfJKnSZXExxqWkp3WDTGLgRrE2v
         N69A==
X-Gm-Message-State: AOJu0Yw5Z15vCwz+wWjy/xMW1sLS2MrfMFP8raKvS35dKwHeu7gwOqbj
	jLGvcjwZ2I5ULCvk5xm+qqEd6o/2QWq50jQOd7m6IhNsIhtuX9T8UqX3QZvHl6zhorzKk+6tGZc
	i2BA=
X-Google-Smtp-Source: AGHT+IFPRKs0Mb/t2R9g3uRMz8OICY3KcEKD3zwDRMBMS4adeJ3eZ6c1VU9JIjgKP0yrrlPM4Yj31w==
X-Received: by 2002:a17:906:7749:b0:a61:7f85:e31c with SMTP id a640c23a62f3a-a6cba5962damr74985366b.12.1717712539828;
        Thu, 06 Jun 2024 15:22:19 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80582030sm151051266b.33.2024.06.06.15.22.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:22:19 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1311426a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:22:19 -0700 (PDT)
X-Received: by 2002:a50:9e69:0:b0:579:fb7e:2112 with SMTP id
 4fb4d7f45d1cf-57c4dee1747mr773861a12.11.1717712538914; Thu, 06 Jun 2024
 15:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
 <CAHk-=wh5Odts_1ZL3gLuxmQBveTWveeWn3equ2JcH2yA9cyjxQ@mail.gmail.com> <d17e8d0c-b292-4915-a61b-1a4c2c496bae@I-love.SAKURA.ne.jp>
In-Reply-To: <d17e8d0c-b292-4915-a61b-1a4c2c496bae@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Jun 2024 15:22:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgU-ybmkd7rA+GcN1fSE+w3Hbm1E_Q0YHO2q5Uoo69pUQ@mail.gmail.com>
Message-ID: <CAHk-=wgU-ybmkd7rA+GcN1fSE+w3Hbm1E_Q0YHO2q5Uoo69pUQ@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.10
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:13, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/07 1:50, Linus Torvalds wrote:
> > On Thu, 6 Jun 2024 at 07:40, Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >>   git://git.code.sf.net/p/tomoyo/tomoyo.git
> >
> > Tssk, tssk. I want to see a proper pull request from a signed tag.
> >
> > I did find the tag in your repo, so I pulled it, but please don't make
> > me have to go look for it.
>
> Excuse me, but what did I miss?

Note how it doesn't actually mention the tag-name anywhere.

> I think I made the tag using "git tag -s tomoyo-pr-20240606".
> What is "a proper pull request from a signed tag"?

Oh, the signed tag _existed_. And it was in the public repository. But
it wasn't actually ever mentioned in the pull-request itself, so I had
to find it by doing

    git ls-remote git://git.code.sf.net/p/tomoyo/tomoyo | less

and then look for the tag that pointed to the commit ID that you mentioned.


                Linus

