Return-Path: <linux-kernel+bounces-386481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E09B4404
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C88282B20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1F2038A0;
	Tue, 29 Oct 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pm93qVU4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FB20371F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189973; cv=none; b=BGH//JbZ9pCRjv4hWWtOp+hwUcITgeiIFfPoxHNWozpCeEXy/bERQDi870qdDXUIAVQGSdbtPiCAlTOHYd4B15KLwFhcV4t0NYz1Ci4c3OGhVAD/W4ZqBseZzslmAnL0WdpA0gJCGQ59i96cK0/NW34jI8etSoOhJOXT3ycZKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189973; c=relaxed/simple;
	bh=tJx/bThf7RRPQy522W46SjHhmJvOpGhuopQdRLvGDtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Elcc864eP8vvqa6tTaPv8KC730f7pfVR8IL3deKj42H498EG8v9yoD9lRwXTxbd/3TFlbD9o1E+hps+vzQuUFr1ciBBGFXiWile0k+7JeT0d968Qna+Xlr1fD9jH0BE9v9W0KEir8VvOxqaQ/IxacPo2zkhrHGXh9eranzpa464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pm93qVU4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f58c68c5so8534383e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189969; x=1730794769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVOexIS3SgllZm/pW9Ena+nrB8MLfcVMF764exL0AQM=;
        b=pm93qVU4qXczc760kD8bNgTQvVT79BgVXhtSOWSUMFf6dY45RM1xKjFPBJcEcpHCjR
         iIkd54WmHlG8GllAQ9ovf/iuYh1qaLMkhUt61dIkvAjMEDHPxiyo3VrO0pHgNfK2wPrd
         SG3g9AUCqaNhQgi+MwcHZa7Ipz4al/wRdgiP375RJRXIYtJlbcWoVszEGk5FtwXSjJBe
         nkThsIKPtp1kCp9046NnuFR0GpcQVP8sEBvaPkAlouxK59SXeHeMatX6icCo1lBOs4kT
         YkQ4rqjW7d5RCRhT0+FsxdUUzwr76prBj2163Kfksdxk6cgx2BEXhxdVqLRBrolXUr2l
         Ji5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189969; x=1730794769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVOexIS3SgllZm/pW9Ena+nrB8MLfcVMF764exL0AQM=;
        b=doIAG7qP7ByF/hZSU5lcvDadYiEKEnq3sN51BSblXBgzJDCBKSn8xoaGQ8d8nAdPWL
         xOtLR+0uTref9wib4pg6YsWuzXvCzBv5QxQir46oMLCUgjC4lbKWahHZd/VLRhpNRGwr
         HUBZN3+K4VBNe+DFatbRiIlXhFeRr+Uv8Vtz9BAX1UWmT7ErnTFhX88YAR1bgHYJY9Zh
         I6l7Cr0lEi+tQXJlGQFI3L1Hzrs95Os/g2UTbZ9UM9cM4aCWpuPotcL3ARe0fq+YGPSP
         AQujZefRvtV7PfSzXUUFEn+yBoXPA3ncxE3W8GPb0c4yovUjqvtOTt8IVQRAdzQoF31w
         LXCg==
X-Forwarded-Encrypted: i=1; AJvYcCVro9ga/iQ72+Y8lIicPuFpocypwCJcReyEYKqLOvWu0YPwizDVnpp5bpmmzaCi8ze/7zbIAQn48KsIYLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvgfpR6uNjJUJDlFrlkq7f1CAfPfNr+4nLkRRKrvVvH3dhyXo
	3IEJ2bsUzobZXQoodnOm2u/duXZCohCaEqWHCwSqhY3VEeIW5M10mDZzdlOPrsY=
X-Google-Smtp-Source: AGHT+IF3Rxjs9R/r0CPhhUw5+OUfR7VXHsix8wHKnE253K7lQLZZUQcp0acowwY53IIl/tZieH5Tmg==
X-Received: by 2002:a05:6512:b8f:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53b34a34602mr8913570e87.55.1730189969117;
        Tue, 29 Oct 2024 01:19:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297204sm445856166b.116.2024.10.29.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:19:28 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:19:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philip Li <philip.li@intel.com>
Cc: Matthew Sakai <msakai@redhat.com>, oe-kbuild@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <68866f17-f327-4df8-ae17-dfcc50362d4a@stanley.mountain>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
 <ZyBQa45RTWXiXJke@rli9-mobl>
 <ZyCLo51ZyjxX7eQK@rli9-mobl>
 <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>

On Tue, Oct 29, 2024 at 11:07:07AM +0300, Dan Carpenter wrote:
> 3) The kbuild bot detected the bug, but unfortunately the cross function DB
>    doesn't scale well enough for the kbuild bot to use so it didn't detect the
>    fix.

Aw crud.  It does still print a warning on linux-next actually.
Smatch says that we lock "&pool->lock" and unlocked
"&pool->discard_limiter->pool->lock".

Anyway.  Points 1 and 4 that we were running new checks on old code and that
the code in the email did have a bug are correct.

regards,
dan carpenter


