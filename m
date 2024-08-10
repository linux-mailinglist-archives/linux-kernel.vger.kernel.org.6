Return-Path: <linux-kernel+bounces-281742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A341D94DAA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1382DB224DE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BE13AA35;
	Sat, 10 Aug 2024 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3rGzmPX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6A4438B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723263512; cv=none; b=Gek72IHK99hmlXgReUwBU76T+L8g4zYcLQnzhvxQ5mjbvxxFlZ9rtOISju+A34xwYEVvA4KivnIOcfZSNA4y3CxcFm8J0vfZl9D7br3UGowfQ2wOvVT7OE/0w08GKHYhZ2a7ltJOSc3njQJnCp9k5KQLCUqfFr1MDQk8VPMnRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723263512; c=relaxed/simple;
	bh=FE3RXVpoNHBCXWk6ztfgMYmPJ16jVDYUoJHp645GAPQ=;
	h=Subject:To:Cc:In-Reply-To:References:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=Dbq/VNDsKRC7BBNiJ/TRc8xIEpU1GOOhzzLjqWdfm8tX5wufgLJ/bhM4FfZD22OEiEHJqJXEG/xUzQvCoM3s8xtITooEHscvm51BSrVBfwB9z6o8l3XVHJnXnUm7Wcw+rjZhJ+nUP875E2dSe/ukaJK8zB0h9jz2OPFqjqCLK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3rGzmPX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc66fc35f2so26925495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723263511; x=1723868311; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=FE3RXVpoNHBCXWk6ztfgMYmPJ16jVDYUoJHp645GAPQ=;
        b=A3rGzmPXkj5wuJQR8HQDGHqrKluuk7IEl45BpwIbQ5a7BgckSx2LvxFIP0nWAbol67
         fsponSWcW+R91N/rBvF8zrWA++CeOHOjeG9KeCCqfbiNHccepg3v0iidXjh7J6jvqW8e
         1BDY8D11UGQ0zU/nunNE99mE7LAv50y6e6GgQvLvjBoNcNF4EW1q2ILtdwiglNHyivB/
         kWI84tn0Ih2CvHC4r2jCHHVPV5H9Yd515aHaxdsP+lrBe/c5O0C/hYU/wnueFEc3Vakh
         dG4tjthZh9TknpwX4Cg29gkz2avllp/PuP7Wlm8UFhc4lyZI+gVFqXFipkOby5biwPt3
         p7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723263511; x=1723868311;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE3RXVpoNHBCXWk6ztfgMYmPJ16jVDYUoJHp645GAPQ=;
        b=OlkYYMvjQGFt6bVFv7Q0EEJBhNFhhvZGPAnlb4OiOyl4pv3q5BhfMcxlR/8QIetdjq
         cBb0xkFFasCqOHgF6ad6Z9+PfF2Cf5saDHzmaIdpeknl4r++gjWuIgdukINPJp3B6POc
         MsJqNuCWc1dANMb8W+SuZzVBlx6LMhLDmu/eKQRoYRQPnzUxRm2wWQqr7ecsQgtKKuhW
         e7MaMLXYqEVxTVT1HB/+eMgdmVafseWdeMe9QlQSaiFQlxuO2WkM8K0RpBoJukyY+cDR
         w1bdBUnFTYkN7BspNcJp7lBIdT+0iFCBpYslsUaxnptwef7vpciN50pMfb3Wi49GdOVK
         soyg==
X-Forwarded-Encrypted: i=1; AJvYcCXqE1qZ1oxD4GaMem7lkISkVYYVQ9oT8p3OxxoNDsLBajj7D8ZhUE3k3dvGshzxfp0GtoE2C1MUYVjGBDDPfzAksu7q6Ed9k5VjtK2A
X-Gm-Message-State: AOJu0YxM5UPdvkWfPr2Pl9OaLrQa3n/8yN4fRZ2R9gt99j3KmPbcT8LG
	PVP9fZLnxdLuQ85tZuNCj51k9akGzwWuzv/MJ0l2ZnGy86GqAL3p
X-Google-Smtp-Source: AGHT+IGzmnBHlj8tYo55BkjEKYkGabt/XhXe162vvHGU5FptPWptWBC0emyH9Usq39y9mLT1GF4ptQ==
X-Received: by 2002:a17:903:182:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-200ae4dacf1mr52885255ad.4.1723263510619;
        Fri, 09 Aug 2024 21:18:30 -0700 (PDT)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7eed50sm4856325ad.10.2024.08.09.21.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 21:18:30 -0700 (PDT)
Received: from jro by jrotkm2 id 1scd1K-0002Dx-2d ;
	Sat, 10 Aug 2024 12:43:58 +0900
Subject: Re: [PATCH v2 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    linux-kernel@vger.kernel.org, kernel-team@android.com,
    Peter Zijlstra <peterz@infradead.org>,
    Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
    Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
In-Reply-To: <ZrZlY-5h5N28PMH7@google.com>
References: <20240807143922.919604-1-cmllamas@google.com> <20240807143922.919604-2-cmllamas@google.com> <1503.1723080058@jrotkm2> <ZrZlY-5h5N28PMH7@google.com>
From: hooanon05g@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8551.1723261438.1@jrotkm2>
Date: Sat, 10 Aug 2024 12:43:58 +0900
Message-ID: <8552.1723261438@jrotkm2>

Carlos Llamas:
> Yeah, I say that's expected if you bump these values to the max all at
> once. The values I gave were tested individually on top of the defconfig
> and boot completed fine (qemu x86_64 and aarch64 with -m 8G). I think
> it's fair to leave room to configure these knobs individually.

I see, understood.
Now you can freely add Acked-by from me.


J. R. Okajima

