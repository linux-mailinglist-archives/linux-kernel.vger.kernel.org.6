Return-Path: <linux-kernel+bounces-563663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075EA6464C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DE81891130
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FE2206AA;
	Mon, 17 Mar 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anG/Z06Q"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA908634E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201622; cv=none; b=rTcRzjEsmDkEIkyAZemoECQIkirwbhkXlSXpxhigqlb52daLNCnTq+jRTqWUazlgvesF2Ctg3PHsEdL+U9zbFm4wLA9J8Q8t9MsIzMF07IEvdG1TS/uprIUKo1pQkzWvJehs6Oyoc++oqJ3azyvMFQEWCNbC78Ga7UPoh76U30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201622; c=relaxed/simple;
	bh=5TLinsCFZY6ypy0cnZ760RF7CdaufS9N1m06Lm0tnw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNmaK+rEQw7juDR2udrUBQing5gYF2s/dD+UZQExL2AiIX9AnqaOwcbsjxd5C8LdY1JejorCnI+wchRerizsAVIwPm0MPGTMc6sOXxnv5h/8HzFTLfWYCu91KXzB1nHQgc80T93kJLK76y+PpSyaX2ktYmjuflc59v3OYIq5fNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=anG/Z06Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd89d036so78965105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742201619; x=1742806419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1gfFdT9yc0ID86bAZQcBXC/s8a7FX9Kfok55CN+i30=;
        b=anG/Z06QSOhuaHYtTZZNDN4jrc5wAD1zubQKxfrDEye3qYCrDdRBwOTuGtpLmttUfK
         3ZiVnzR5M5s1H5/TIvFcFFrCsGs+1jtybSXBcy+8ILEWdI16pjKpS4aAiH45IAuwjVuI
         b9HXo400YMy7IuXWwD/RcUGEqbYacwdzAVdEKtaeNTSM8XRiElJzRar6/VJu8NcTmYLU
         PK1cz+10+c1xXxamovm3jY+cweWnchFRLkNVjjRNWcwCKPlFbWA2zAXH7rMjH9PedCJK
         aDbtpe17gvdxjMle57L4SPARnVzNZNh7NKvFkoimpHdAU1R4sqiLtEqfz5UjnPpMGfJj
         o4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201619; x=1742806419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1gfFdT9yc0ID86bAZQcBXC/s8a7FX9Kfok55CN+i30=;
        b=D+3lmJx3K13qPHd1TS6bKpv6p+1ER5b3SGEidLMa8LT/tZaC6B6oYp5ERjTwgwAW+x
         OmT2JXkgHBKGo4L03rK80Tq7B5dvkjDK8y1Wbvg+ghd/+BhCSwtGBtclc+crVlGhFAVM
         zfSyILSfDXMIaqtgrq8CARxTzf37jiwnqUipF1GIvVutnZnWbgN3doA7jiIRHdsaoaRN
         Klm/W4cNAnbNjpjZW5xym+FbCBpCDW7uywd+yGT0ixuiaTIC8AfbGzLg9JSLGigmYB9p
         0XYO4m0+PztkOzsVOnxNyW7qrX0FAwF+10mlWad14Gf5adWYdrPzfBmLUDeRAB3oCLuV
         9K/w==
X-Forwarded-Encrypted: i=1; AJvYcCUmulMNsCpExMThzFxq2pLfm/t4RQkM2bXFdiskl+D605GOFcnvxI1DWFX6G2llCmOpctkzLPvuSTPVDuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4H+D0ROMN54PWfFXmUFA6gX6xJEYMDEMvWeLFtS8aqTIJuxB
	709b8vowVrqFtW2in054gvQwD5KT7ysfu/jFXz4LVIH1eK4Gx2hQ/4pWsrzzt7hzYrufrpZyHnE
	l
X-Gm-Gg: ASbGncvQsdKUMVU5LQtf6GhWIVPnEU1qWe84zUaxKjA0tVOLz+lj3Bn9P8q5bLicy8g
	TwnWk9tETKyhFlSHSTkRQt4WgsZOFPwEhRWN4vJXtMp0p1GuX0/j2MMDzOREfdvf9ageVeWTYDq
	pcFZoSKIeNlxlbwrGDgKNICMrzyWox6G7rlhIISd/BSIt53RsounCR6oOikmAP8HlGYKb0jdEfT
	ZZ7UKRlZpbrll5dvkVCopMQgzt4ySL3WVB2P9k+6IVrkqxFCjuD+riPUoqoohYNwi8b8auT4H8s
	zh3nStXISzr4eg2UD04jR7qOlpvbg6L67W3DXPEGKatHiQ==
X-Google-Smtp-Source: AGHT+IFDNnj2E/5Q4qSJV0JJLbClWNS4V04i4NWCWhKijLjJLsNAdu+JYl9z1X7dvEDSsRoDUhQEtw==
X-Received: by 2002:a17:903:2f86:b0:224:93e:b5d7 with SMTP id d9443c01a7336-225e0afa057mr167261555ad.34.1742201619619;
        Mon, 17 Mar 2025 01:53:39 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbeb89sm69895575ad.204.2025.03.17.01.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 01:53:39 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:23:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250317085336.tlmuvpq663m4krkb@vireshk-i7>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <20250310155301.6db5033c@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310155301.6db5033c@foz.lan>

On 10-03-25, 15:53, Mauro Carvalho Chehab wrote:
> >  /**
> > - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> > + * cpumask_first_and - return the first cpu from *@srcp1 & *@srcp2
> 
> I don't think this would produce the right output. See my other comment.

I see. I was only looking at the html output earlier and that was
showing up correctly.

   return the first cpu from *srcp1 & *srcp2


Tried with "scripts/kernel-doc -rst" now and it does show

   return the first cpu from ***srcp1** & ***srcp2**

-- 
viresh

