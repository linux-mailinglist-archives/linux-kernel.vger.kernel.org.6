Return-Path: <linux-kernel+bounces-271925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DA945506
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12AE1C212D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659E14EC78;
	Thu,  1 Aug 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+Jc7iz6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8A14EC57
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556295; cv=none; b=P9MFu36rR5nB+Ld8p0CITP3m5wfBa3wnlNK2pctQgCMZq/i/+3VzidX3+m12DZpgk+nj0p0vlWZPHqgVbjnUbwBnb0vjM2NccVHejD36vLjp8vepbxdxfqtMKH2fj1gAT+Bz07S+9frg/c+QB39v7oWB0yt7zz36YTvA0OeY6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556295; c=relaxed/simple;
	bh=eQxlU8eev6jnNRcfA4wEA1+aQibw5bEMR3sThiTngOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dRxDPUiPnl6CkNHXvUZFjr95XfQieY+8Rq/QwsGMdiJSsZdlbFrK4IdB/F0QSbANH9fT1mwHoZugOuC15ZkdJUL3t4soq1Fwcp7jSg3Y/n/aGvxoZov3QYLvu04u8FRcKLfyPFFMlZO/uBFQ2Kh9NTouDkMPWIPKp1epJDomiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+Jc7iz6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc611a0f8cso57106965ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 16:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722556294; x=1723161094; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFvxalt/XnEivZ3koHVdSp/ZabV80Phmkm5THmVQQjw=;
        b=X+Jc7iz6oubRyOl15n4YwNVla8Ch8J8rdoZhit1vPn00xsrRXdG7ZQagl6yONezhBw
         VkNLk4YeK1ZvPHKOgCHHeD1ShgwYeKsiUI8PBVsZlOHsVrwnQHG/upSGvf/U11W2uoIP
         QB8DVH3n4GFx1rKjjvySxybyfXRNCt7EZF3A+m3j9FjmTwCt2szhcUeIKWdy78YR8PM6
         iQjOlnZSRpOKeHFgsKdFQaR4Jk+qpwEy46SAABqEsQEQkLJjl8tiND0YmuX2FIibRAy+
         Ll0YEYaK/VE4oB9pfYsQiRlRFvfMI6/aRh/jAy9NoLEjbCiP2Hf6cX6Hib+4ItBJUeLF
         6qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722556294; x=1723161094;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFvxalt/XnEivZ3koHVdSp/ZabV80Phmkm5THmVQQjw=;
        b=IhEzmCFIF3jjZGE0L4ajbUoE7gRaaVgPGEsDvQtz9s9WH4Hkv8cx3iWuUmNYjrnAsi
         1XRKrO4ONBANhmX13YG2Go+QxvclwFiBgHobndLTFMz3CPLA9o/zAlIojty7FmThZwHi
         QejgJ9l+Wp3NDrc6MmrOGQpH9bpTIjZzzsb4kpOsuN/kW4WSn8m4jpAOe1o/x3SARITi
         YkdcdTl2kzuD0uETp1aDA53vbYnhsrYC6yK8xZmljNZMIqS3tdmude2GgvzEIOTE9B0b
         /LXm/KZZfz8OHGLwCazoV8JgQc2OlMGl3+trYMWEM6aXPiuK1mM14hyI/ZPlKU6OpGtl
         uA7g==
X-Forwarded-Encrypted: i=1; AJvYcCWXr1gn9D9Mu4y4PvVxRBFxqUYZutIQxq1dIFcZkajNs7RWoulpNpZKgED/fyiPPz26trzu34Ow/J5NtS/ZXFx6z6jSW6wj950Lou2s
X-Gm-Message-State: AOJu0YxJeLdA59DWdf4LzIiz84M18v5RfuRfpyRVANR0zmTHv30DJSxv
	pi0Gb3QRKFcIFXqBCzpEvAGpHXtUBTx/EJJGp/akAkY+oUtx0/wD
X-Google-Smtp-Source: AGHT+IGhKCk3TzDExgt5EpDOgW6N5/0tNjpEVbX4YXp6hYZyxPbAxlbt8jTBZJGThk70AA3uv819cQ==
X-Received: by 2002:a17:902:d503:b0:1fb:6616:9cd4 with SMTP id d9443c01a7336-1ff5735b795mr25553445ad.38.1722556293582;
        Thu, 01 Aug 2024 16:51:33 -0700 (PDT)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917829esm4622965ad.215.2024.08.01.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:51:33 -0700 (PDT)
Received: from jro by jrotkm2 id 1sZfZq-0001LY-0W ;
	Fri, 02 Aug 2024 08:51:22 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    linux-kernel@vger.kernel.org, kernel-team@android.com,
    Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
    Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <Zqu2_OvnXIrCMMu8@google.com>
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp> <20240723164018.2489615-1-cmllamas@google.com> <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org> <Zqu2_OvnXIrCMMu8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5177.1722556282.1@jrotkm2>
Date: Fri, 02 Aug 2024 08:51:22 +0900
Message-ID: <5178.1722556282@jrotkm2>

Carlos Llamas:
> I simply dug up this patch from J.R. which avoids the BUILD_BUG_ON(),
> but perhaps someone should limit the rest of the configs? In practice,
> nobody should be using these 30 bit shifts.

I posted the patch in 2021. It was against the commit in v5.13-rc1,
        5dc33592e9553 2021-04-05 lockdep: Allow tuning tracing capacity constants.
It is a little surprise for me that you could pick up such old post.

As I wrote in the old post
	https://lore.kernel.org/all/30795.1620913191@jrobl/
	I don't know what this 'multiply by 5' means and why
	ARRAY_SIZE(chain_hlocks) is limited to (1UL << 24)
And the post is just to silence BUILD_BUG_ON().
There are a few more "range 10 30" in lib/Kconfig.debug.


> > btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> > bitsize?  Maybe "bit shift count for..." or such.
>
> Indeed that is odd. I'm also not sure what to make of the "*5" magic
> number. I suppose it could be the typical lock depth? I could try to
> clarify these points, if no one with more insight wants to do it.

Also the original text comes from the commit in v5.13-rc1.


J. R. Okajima

