Return-Path: <linux-kernel+bounces-262467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34993C775
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF861C217D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CB19D892;
	Thu, 25 Jul 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JKNNq7gu"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A661990CD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926535; cv=none; b=ZiBQ1wBw6WPkHk1qdfh+rqg88n54kwm6i3Ps4MYOnW0VZ9c67TwxbPe3YXCK2Mf8Hhxle3k4mC6sRR4HWCP8951DJAE4KkAzjGi6FKzdUAljw/JSEot5c2iHxZpxd2ImUDGsTvTGU8laHZvMKXQZAe+IFb1Rms+8n49MwLAcnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926535; c=relaxed/simple;
	bh=Vs2jCGfatgskfZrrtostsFVwX9PhXho+J0SPl4hN8uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiaQWu4ttL5OLA0krytzZvwM8ooK7u/tELFid343Fdt7Qf+EaWFHEITl7Oa+xJ136KSWQwo8KPqDYXaj3/B6Qw/CVY9p52BQxfx5VkgFxBp4s4NsbeYkVYf3vFDKam5fm0t+MGj0eoQxx08NYNnbDWhZb7sAK2cn0NOUHxX22Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JKNNq7gu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efa9500e0so537424e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721926530; x=1722531330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/0Kl5sw++soHUU+LQGAu88XFfYB95M5wIm7NPuOBaZ4=;
        b=JKNNq7guZ5Iw6q2zTl/vZpBdDIDT/DD6W2fiY0Z7AVKYFjL7QO+t/Kc3VQfVnIJThp
         KDZDNhpmYFAfgPwIFYVUPjGfrOJ6UAVyq1NJjuxSwCNngVHQm9JrE7FgKF/dMLCJoeij
         j4Y2qy+0GgFqcGd18X4ni2yR5WRTzQ4n7tXQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926530; x=1722531330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0Kl5sw++soHUU+LQGAu88XFfYB95M5wIm7NPuOBaZ4=;
        b=TXhc6Gc8D+LMEOAsN9VhH6t8MP+Zqpm4tWxa68YtoDEeUb7s15xxa9kMFMRekmupdD
         w8098r7HHr/J5ulicxZGCpgMMn42NtvVnpkavmBSCEXN+NKNZInS2vgzdANAkSuZDper
         GCNR029O2+EAPRWUElcsHawgY0+Mwkwi5fBf4Q/55cpp5/kU9zLT/WgD+QP9Fnhy/tat
         dI3rvVI30LSuSo5dViBj9oHwf7YkDE/2aRERp8MgypYlsu8CKOKeCYGVK4bLckxuFxCT
         9dDjlMFOjR8t6jaGa8kvUeCr2O9iKCn4H66qqNGSnx3edscTgzO5D8udLn5IN/TokSu5
         KDwQ==
X-Gm-Message-State: AOJu0YzLtwYh/8S6VT7cOhZh+sgK85+sQ2hy7DDs2VAO6eScs/MrmB7L
	5SP4mZErnewyE3xc8GSFG9bx3RqWJInh0a0t9cnXCpsIjmHJIZOEaoxcgxLaH9lU0y4HPm6sL4h
	slFc=
X-Google-Smtp-Source: AGHT+IGHkJoDMkjce8yzXRVbNyXjvs3p1GxqsdKy7Wbzk6cldF9zm0UaoJ2/tOUBlgBkheNumNUc3Q==
X-Received: by 2002:a05:6512:2c0a:b0:52c:e1cd:39be with SMTP id 2adb3069b0e04-52fd601885emr1468835e87.8.1721926530043;
        Thu, 25 Jul 2024 09:55:30 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2d8bcsm274383e87.283.2024.07.25.09.55.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:55:29 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2d582e31so4275441fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:55:29 -0700 (PDT)
X-Received: by 2002:a2e:9ed3:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2f03dba65a6mr19727201fa.29.1721926528798; Thu, 25 Jul 2024
 09:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
 <CAHk-=whAfNJKeP1WhdP9y0itF_AkgQJMyz8B9TCfAWWQRhDRPw@mail.gmail.com>
 <5ad7dffa-204e-4d37-acf6-0206d7a87f37@I-love.SAKURA.ne.jp>
 <CAHk-=wjYB_aeCxtBW2+-GqcF2PxwJ5061BFrAMp3mJgBy3GGvQ@mail.gmail.com> <28a0f793-b0d6-4abb-b83c-f54e5a588994@I-love.SAKURA.ne.jp>
In-Reply-To: <28a0f793-b0d6-4abb-b83c-f54e5a588994@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 09:55:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg74E_1NXafYaemRT7R9dqU3DSOf+YGftD832BJqXBwoQ@mail.gmail.com>
Message-ID: <CAHk-=wg74E_1NXafYaemRT7R9dqU3DSOf+YGftD832BJqXBwoQ@mail.gmail.com>
Subject: Re: [GIT PULL] orphaned patches for 6.11
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 04:06, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
>
> Do you mean
>
>  void profile_tick(int type)
>  {
>         struct pt_regs *regs = get_irq_regs();
>
> -       if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
> +       if (!user_mode(regs) && prof_buffer &&
>             cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
>                 profile_hit(type, (void *)profile_pc(regs));
>  }
>
> because prof_cpu_mask != NULL is guaranteed if prof_buffer != NULL
> because prof_cpu_mask is assigned before prof_buffer is assigned and
> prof_buffer is never reassigned?

Yeah, I think that would be much clearer.

What would make things even clearer is to not have that horrible
complex conditional there in the first place.

The code could do something like

        struct pt_regs *regs;

        /* Are we supposed to profile at all? */
        if (!prof_buffer)
                return;
        /* Are we profiling this CPU? */
        if (cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
                return;
        /* This is the old kernel-only legacy profiling */
        regs = get_irq_regs();
        if (user_mode(regs))
                return;
        profile_hit(type, (void *)profile_pc(regs));

and each line would be much simpler.

I think this code has grown all these historical barnacles, because
this really is the really old kernel-only profiling that nobody should
even use any more, but is the only thing we have for the early boot
situation.

                Linus

