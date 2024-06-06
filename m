Return-Path: <linux-kernel+bounces-204735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7E8FF2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856921C25A94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E4198A2F;
	Thu,  6 Jun 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hXjytcMV"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFA197A64
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692683; cv=none; b=Wpx5p+cXxdGy3WiQAhn/tCDkKH1Xx60qxgyWBCb02ZgzqPa1qUxynqoe33XLNnFbs1TjGIaAK/MSyokfJeP02RW0nE5P2QDjKiSEt4RRDT5VItv70mOIUJ6r+R/wKCosu1SaaCbNsQOJ3Vx/swrJwyv5N3k6gOMkcBde0IEyLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692683; c=relaxed/simple;
	bh=bKpeu778JKpqTN8yxCi240/BempwAareVjVpUPWGihc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxhOgiS57xXO+ioLcRv7/Ix4EG2/uxOQaQrUQtXkYx5cso9tcH4QeIXoGcHe6QvYCxT82I7DDIdr4r8BAORSdSkLGDlevX6GJN2fim0rQSjbu/7Q5YwS9uuODzaalqDZ3EQjm/zKTs4VKFsYGhkziFE+lHlV8rBdm/Oc7HRkqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hXjytcMV; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4eb270d92eeso415924e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717692679; x=1718297479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TW/2Lq7z+rb35iNQBDv5GkJ2CFmMmGZC0g9bO7O51/w=;
        b=hXjytcMVnOtZ58lr7N2a1qLS6XLeXlei0Ck2SLgslalFcGbT9uxrLtsK6qEQIGuMRZ
         TzYpjMr8+C+Sjf/0jBaQwrA76MSAX/2gYwCDMRKmHMY8Mx9bRPugTbY6s5zVxQpPfJpu
         QjflyUVhI/17tZj7GJh6e9lEhu7ETpKP0U6d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692679; x=1718297479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW/2Lq7z+rb35iNQBDv5GkJ2CFmMmGZC0g9bO7O51/w=;
        b=fU9/9ticOC3FJwPFCpyT51fOGd1sHB69kEtOr53L9XuLrjKOEPeQrx1fCtGBpDmHuD
         EZx/I7w6/A+5GTCbsq1SOGdBHTXsDAI8ZJP0DsLqHj9596ZNWW6i2DEU9UNPHlF2NIRA
         waDya51doW6eCAsqEu9QaBx7nG8yuSx09Ly71COEpkciuJxfK9/fj9eXzZ/+Rfm2HQ0P
         fB9NV7je58PUIOOUWJ5EqICy4UOCaftQuzpaOnKBmTDOPdAXwnpA/OM4+4vaEe8PMITh
         cOj+Bj8aPGM6131ExHePPHmSZ40UzNmXQvDOV9jto9hGfqs1VAnOvF2611S6sQBOGWzX
         oxMw==
X-Gm-Message-State: AOJu0Yx2W8Fiobr4Qc2uTceNqe/KrpZBpeQWQzGRavS/8a8CQewGXKWA
	J/4mU/gGcleWpwUR6JVIb2gwEe5RZnfEIAZgoCsdYCmeboaKvD1v3o08uKAuyeYsn9eu2u6rL92
	6gEg=
X-Google-Smtp-Source: AGHT+IERIBng6OB0et8Um5KIH1tS91P2xrAtqUVxPXvLb/PvNm/N4jYCAZsZQ0wPAt0TLBhqex456Q==
X-Received: by 2002:a1f:db04:0:b0:4eb:554f:20a6 with SMTP id 71dfb90a1353d-4eb56235a53mr172486e0c.6.1717692678576;
        Thu, 06 Jun 2024 09:51:18 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eb4aa34555sm246747e0c.0.2024.06.06.09.51.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 09:51:18 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48a39b54e22so364197137.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:51:18 -0700 (PDT)
X-Received: by 2002:a05:6102:160a:b0:48b:a84b:8cb8 with SMTP id
 ada2fe7eead31-48c0489340bmr7697108137.11.1717692677902; Thu, 06 Jun 2024
 09:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
In-Reply-To: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Jun 2024 09:50:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5Odts_1ZL3gLuxmQBveTWveeWn3equ2JcH2yA9cyjxQ@mail.gmail.com>
Message-ID: <CAHk-=wh5Odts_1ZL3gLuxmQBveTWveeWn3equ2JcH2yA9cyjxQ@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.10
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 07:40, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
>   git://git.code.sf.net/p/tomoyo/tomoyo.git

Tssk, tssk. I want to see a proper pull request from a signed tag.

I did find the tag in your repo, so I pulled it, but please don't make
me have to go look for it.

             Linus

