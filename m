Return-Path: <linux-kernel+bounces-254173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29455932FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7366B21B55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B11C6BE;
	Tue, 16 Jul 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f+hw0mJs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B13101D4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153743; cv=none; b=Af9cwHF+M3MRDA5Iz1pAznYpu9vErNFQBWRMgmXfNB+Z1N6A/HS1fgvZ2IOs+NMSmnO3yhHv6l73WVhK0rVFQGLuH0kXGaITggyxXklQ90xy+m6Yaok6YDB4EZSyMLOE3TQDvBt5jvGGu+4IGhxie26kI+eGjG0UN/hvSCE1vwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153743; c=relaxed/simple;
	bh=Ov5AqF/TqUDlIXJ7SONYF77/j2acXUtxSYPHjwYBQ2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNHysmMUfsP8/dGmeHU3V8Udk2rk4zZmXm+rAi0w7+q2Mb8PSoMFIeKwWl4jmY+5jTuKUhNqwHPd8LaFreWwjl0s71eoDFfO6WOKSqr7R8jWTO8vo4r5USzrrDS8o8uOdifPm6Z3LowmxOGCUlxbo0ypFC38xLLAHPRittFAUoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f+hw0mJs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso7571626a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721153739; x=1721758539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQc+Ab11eyp0n56uBG3WXP2OvtIjsn1n8cUj3fJGPJE=;
        b=f+hw0mJsFWuKl7oELj2FYpqO5nv+NOCpWk+DKnHAQyuUG14nywyj91kRYi17D687dR
         OBPciZrFAn8ZM8BSOwQMEDO4b4lxKNEUGSS3NPoIFSuPKDbuUQlv3svE/+f14BuX+SVP
         RWDA5F78qhTH1uepXbBK92/kS2AMsxEtWX44s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153739; x=1721758539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQc+Ab11eyp0n56uBG3WXP2OvtIjsn1n8cUj3fJGPJE=;
        b=ptknEARU8z4VAiU0fyFuIIP+O2W9sAIrz+IC8MKQTq2y6ffbf9N3jXeFujGJS62imQ
         ovyMBmjqs3bPRuVcNcY/eSpDzbQCKTkWP9v7Rm3YAll3Bx+cXzw2LyrxnqAmsJgGZ8F0
         IVTVkvHQhqc7BZkof/BGvpfqwDSfMxPkE82pmkWnwQwP77mDLmcqIRi13xn7j8f6H+ga
         B4q570+AMFkhIUOhkmNRwdnY601aCokA94hq8ki4xvU4K9bY4InZFRFsPd/qbkxrjJbi
         OZTFTrEVpmHWMW2MvM7dM3KIqDo7+Jkd47YAM00RTUeXjyI8TP0dA8rrbF1o1k3/fsav
         EPYg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0cG0HoPswjskG6rZ2AhvlnRrc9dWHmBMqL0gGwR89+NzjkILynRTZ2FcDdMytnkdlWDYWSqprPZfU/qEDTlJpuRcGcwm6E1lAUeO
X-Gm-Message-State: AOJu0YwFIXjgue9mSZhPnmWmzvOv4pnaDTrKxQrJK6mK4/zYAhgyDMfI
	S53CIzy9RanXwgVwckqOzY9R7E8XBwV8Cfp/P0ZjvFnZDJ0MCr/tn6Ah5ytzuq0eeThYNruyQTX
	vu+kFgg==
X-Google-Smtp-Source: AGHT+IHCW99+99axaKpyusGaRHzowVoEGkx9MX2soKL6fgK+XMc+mwG1iXq1jn7jgGzRkwCX3eH2TA==
X-Received: by 2002:a05:6402:5204:b0:58d:fd5a:eb54 with SMTP id 4fb4d7f45d1cf-59eeea3e69cmr2220527a12.17.1721153739442;
        Tue, 16 Jul 2024 11:15:39 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a28ddsm5317018a12.71.2024.07.16.11.15.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:15:39 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so7519648a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:15:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp0V6S2vA7DK2TAEkBYyu3qc9QgXGS3+alE6bgYEdIuaQ10iF9qHaBFsptf8L4tWuVeurOaylW8GXOUZdhzl3yzUK286Guuj0Wca34
X-Received: by 2002:a05:6402:26c6:b0:57c:c2b6:176d with SMTP id
 4fb4d7f45d1cf-59ef00abb97mr2248314a12.32.1721153738007; Tue, 16 Jul 2024
 11:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
In-Reply-To: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 11:15:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRLe=TVzGE8sLKL6140evC+NDxP0=a81WjxqCbs9npRA@mail.gmail.com>
Message-ID: <CAHk-=whRLe=TVzGE8sLKL6140evC+NDxP0=a81WjxqCbs9npRA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/sev for v6.11-rc1
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 02:56, Borislav Petkov <bp@alien8.de> wrote:
>
> There's a simple merge conflict with your current tree to which I'm adding the
> resolve at the end of this mail.

Apparently it's not very simple, because I'm pretty sure your
resolution is wrong.

>  +#define X86_FEATURE_DEBUG_SWAP                (19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
> + #define X86_FEATURE_SVSM              (19*32+28) /* SVSM present */

That line should be

  #define X86_FEATURE_SVSM        (19*32+28) /* "svsm" SVSM present */

as far as I can tell.

               Linus

