Return-Path: <linux-kernel+bounces-177840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E468C452F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312BC285530
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247031CD3F;
	Mon, 13 May 2024 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lo7qVFB+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69561CD16
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618312; cv=none; b=Wws9/zjC3jRHc7DiGWyXhZsqKdfwky9Azss8ZKjVvvzmJrQK+ytjc2aFGMbmOabhz7aeWPywqBG9M6mkGMGp+shI1Ku2mbeWnxmyWGCGVgUX+D6hfnMUctyodbW0sS26SZaTGPbRcxhGNIAMWMP95V0NIhzOpSvoeb03Q54rssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618312; c=relaxed/simple;
	bh=Ovx1j7MTjRL6Gty0o2yuKfyr21Xg0c7KZt7RCfRDmCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSeA3DHIS+QogQiNKkQzLTA4rbQ/4lEc2je35tlF6tz92lsVW1ZkoWj0ayLljCRcv6Gxk2PYsAXqOjHp22X0ZDOcWGBB0RL+HRtXEYd7KEyLMqQMUiUms56x7zEczRXKvMaESxRmX3oS+usGccIPeHwu/ludIKHHRXF5/sRrcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lo7qVFB+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a552c8cbaso521585466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715618309; x=1716223109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1Wlf37+51HtjLRgNKMisfOzo70QDhMnfjuuCuIiDuk=;
        b=Lo7qVFB+Jh7cpluQxnVMhaHCsj4WRipGnXSE1xtSvVEKXYIpx6lwZQ1L53APFYjH+p
         au4MlXXjUekXGYIYnX1+3i5LWt+5fZSmovvUW4GBLyXX3Vj5M7wzMtsyZ+mw+3bdTRpN
         tOTuGUpHgf9IZllzgvDR833VM2lv9FejDdOEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618309; x=1716223109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1Wlf37+51HtjLRgNKMisfOzo70QDhMnfjuuCuIiDuk=;
        b=N/NujBZWNXjQanc2vmOt0b9FDs51MBwIE0TdjS5kuGii8jc6g6QOH+8kSgq5sCjKxn
         bLUmIQC5T1NCIMZ4y5Uu5whKR+9sJgvoWPQocnKLLKYJk4zw3aTq1ZMlq3gQssuqmkaA
         l0dw/IJPygm//IXVmjVVuN6u7wiQev2b6pnSn5HV+rC5UlP43FQw8o4jJHD0CIe4hByT
         cpHIoLMqYS8BW59CXnJg740w45rsDP4qwtc8Oa/MvgRUU9l5ALHBExD9K+R6V8QhlKB7
         dPXY9ILKjHeKFUP7MFkJN9vePaB4898lYPDXFqPYfBVuD1wSDKWELGMA6/Wp8Jd6e/m7
         ym7g==
X-Forwarded-Encrypted: i=1; AJvYcCVuIXb8/YiS2Wf2RIXNnJmgxxlmsSEI6nYnJhCwD5Hhq7q2rKNf+jrIo/RRPBzu1bVPxr5+dV2N9DhNhwqNYEt/pLSaMjMD5hNZUhFV
X-Gm-Message-State: AOJu0Yypg/FI+wN8VSfd9ntDjJYDLG7BCzh5F0FLpjZmSr/Xdy+XzBb2
	8NnM8S+BL5DjRbHeNYs+Fb5PJJPEh+Mb+0VpuXImhImcO/PGfwlmtXW96b92N/5CV79COBzM9Oq
	2+Q0=
X-Google-Smtp-Source: AGHT+IEToJl504VJfXVbiYqbFwXrTEDH6muKHpJ6TiLLFp9mMMuUMx1zbCM8Bt0OasynClwkSFjj6g==
X-Received: by 2002:a17:907:3601:b0:a55:9195:362c with SMTP id a640c23a62f3a-a5a2d66a3ffmr800157966b.49.1715618309056;
        Mon, 13 May 2024 09:38:29 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a55275e80sm334702366b.8.2024.05.13.09.38.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:38:28 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cf8140d0so1052660666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:38:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2mq5o1oRIYCGEAKyPC7JeOV7LW2VwrqajK5WilLMtTG4M6FsPvB52NJhJHvrGUEcjvyc+RlOirtEyib4O6NUxVp/ZBmzMTcU8frNR
X-Received: by 2002:a17:906:f6da:b0:a59:a97b:5aff with SMTP id
 a640c23a62f3a-a5a2d680c8fmr687211266b.73.1715618307800; Mon, 13 May 2024
 09:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510183049.312477-1-urezki@gmail.com>
In-Reply-To: <20240510183049.312477-1-urezki@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:38:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
Message-ID: <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes.berg@intel.com>, 
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

[ I should have reacted to this earlier, but I just put all the "for
6.10" pull requests in the queue without looking closer ]

On Fri, 10 May 2024 at 11:30, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
>
> Please pull the latest RCU git tree from:
>
> https://github.com/urezki/linux.git tags/rcu.next.v6.10

Hmm. I don't have your pgp key to check, but I do see that it's in the
kernel.org repo of pgp keys so I know where to get it.

HOWEVER - importantly - I also don't find any handoff emails from Paul
or Boqun giving a heads up that I should expect pull requests from
others.

Put another way: I really want to see proper heads-up and "yes, this
was all intentional, nothing odd going on" when seeing pull requests
from new people to core areas.

              Linus

