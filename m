Return-Path: <linux-kernel+bounces-336284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C170A97F18F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85601282A39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5471A0B07;
	Mon, 23 Sep 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N16N0gpl"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A410F9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122465; cv=none; b=Q3uuTHCujesaFU0YNvaSAdwveLiCHWDxHo7B7iAxS2NVnV77lM1CfIJeBPxosGOhzi/SUfIMy+aEnLKKm4YMHLqWGCPWTtXHjupPbRPT6ca82hnObKXwH2uRHi9yihVQvlhc1HCjuFRS7IlpJLGmS43SYVru9oWDOEa+ZzcQIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122465; c=relaxed/simple;
	bh=sfVGPb3s9v3QL5FiPvrqNyXABTCJhg6/F8fz+cwW1XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyYM6ULJ/5f5fJq3l0sh6I+nwPHdh2O1oeLnkGys/xaVayLAABPa+60prU3q8hkFnva35Ge4fgyOJv4K6aY4u/JAbxjtPwmH8Ssgt2mSyap76YYKpYx8BnPYtVnb6RID/t+YFuQuN1n59WeYRJ91X7Q5cB4joxGf2HCYQKrgAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N16N0gpl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so2006287a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727122463; x=1727727263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwDZsvPCpgzPB2vrmN+KoQFTxKd4xFYxkQxKVP+J3gA=;
        b=N16N0gpla52g+3eHDabb9XI0LGCWfYHXapN8bSerXINFTv5eOPF1rKnFHR8yxDFGSK
         W07vvAkpU4XsN5zMA/JG/opiH0f0Mimy7gUT+SZ/a3Ob55s5GGnoEHAEL7K80WBBqB1e
         sEKV02PxCN6d8b8m9MyhcYffckqgfcwpZlh1u4dE00+NeEYxEoBhaIRocITH4PKx0CvR
         ESpcPjL/q6WbKv+B7chzy05fb0MvnaI8kFWTVOr78tfB1zoBF2SFkMpYVLjfOO/m71MB
         8TwwT3W+W2b6Llr71yfKF0TtmdVDzrMIUGPZ78Wd8kfCdnDYR2ntOBxctwDMn0ifnRxu
         OsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122463; x=1727727263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwDZsvPCpgzPB2vrmN+KoQFTxKd4xFYxkQxKVP+J3gA=;
        b=je0YmldCfmhJXcap5KCDjDgD0pzGOHEVUSZjPzeFXe5rqgHhnLioxsT91tBzmzfax2
         E0uZUuPVJIy5euAQodReQjlaG5F6/9H+FC0kT19dTPNw7wg2saGmEzSSc0mjQpeo0g7M
         63K3HNPQnlm2FsqsH/a0N/QhxiIDfgNxR4/GX2z66RtCpA5udFHCTb/1QuXekvHFwMfZ
         qSJNPZfZTOe9QjpG1CE3dKkigump3H+SMSpGUN6H/Ii+hdqDl/vF3jb9y0Psy9LQJHqC
         gQw+FYGk88ORfL4gxBmlAaF38kiyLAtAZVYJ5dPTJHdWOTmXBhMkH0dIPad2/O4yPMTM
         tEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/sbhKVDShAp8TNMLQgioeuZceJxlbAIFrUgvE4K4fXEylCbod1hwqr54Q9TZ8SKoJPtS8iEJ574fzOYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhVGVp/mVGWHSeBj/ZT10THI7pf/yYZXLY+IzGiDbELT/R+3v
	teSrpKh8KHCFJHsh/8OdsytCnwes1T0DBJKHp39L0H+dwWljrFgiINLKAgwCBTa+8NUPfep6HZM
	kPTQaDRIksnUbegMqxd+kMMzO9jJbMud3OfW5
X-Google-Smtp-Source: AGHT+IGB6xZrtrlOd0n9JBzDbp4CC2aAbIAGIwVRIXCoLyvKok073NsaEq8iyPUgf/zyxUQEgi2rI5gBJ0LN8GduSzM=
X-Received: by 2002:a05:6402:5189:b0:5c5:c23b:a06d with SMTP id
 4fb4d7f45d1cf-5c5c23ba816mr7459478a12.17.1727122462312; Mon, 23 Sep 2024
 13:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org> <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
 <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com> <CAHTA-uarCi84OTPNJKG2M6daWi=YsWFgf_wd0gKMULeeOvBwXQ@mail.gmail.com>
In-Reply-To: <CAHTA-uarCi84OTPNJKG2M6daWi=YsWFgf_wd0gKMULeeOvBwXQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 22:14:09 +0200
Message-ID: <CANn89i+bZY8vseiWQb6gye=YayDzgrMeyrk1k5Ex_ux-NcMRnw@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:01=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> Hi!
>
> I'm wondering if anyone has taken a look at my reproducer yet. I'd
> love to know if it has helped any of you reproduce the bug more
> easily.
>
> Patch w/ reproducer:
> https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@ca=
nonical.com/
>

As I said before, we were aware of this issue, well before your report.

We have no efficient fix yet.
https://lore.kernel.org/netdev/202405311808.vqBTwxEf-lkp@intel.com/T/

You can disable dst_cache, this should remove the issue.

diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 70c634b9e7b02300188582a1634d5977838db132..53351ff58b35dbee37ff587f7ef=
8f72580d9e116
100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -142,12 +142,7 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);

 int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
 {
-       dst_cache->cache =3D alloc_percpu_gfp(struct dst_cache_pcpu,
-                                           gfp | __GFP_ZERO);
-       if (!dst_cache->cache)
-               return -ENOMEM;
-
-       dst_cache_reset(dst_cache);
+       dst_cache->cache =3D NULL;
        return 0;
 }
 EXPORT_SYMBOL_GPL(dst_cache_init);

