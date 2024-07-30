Return-Path: <linux-kernel+bounces-269525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5739433D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A5B253A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B911BC092;
	Wed, 31 Jul 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM4UOay6"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCC1BC074
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441917; cv=none; b=dMpNp0oJhlx8c3P/NJYTeG+FRJ65gLF1Y57xZz6CSx+UTmArxCmIlvabNBee8/X38I52tK3aCPhWW3D+anxyEz4j4QjKU4UFpggRk87NL8+qsT0Gu83+TK++K3JqbNRiPR3HcXNrNzFOzXLvVc+Rj1SNJyAMMrP/DdZ07suIbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441917; c=relaxed/simple;
	bh=a6TO/KMWRyZ62evV+V32rHbVhpWXfPPpsymd4oMdEK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgn6STl4UphXG2+lHdUSwthYcvdTe2jfYw+55q+X1Rl7vscs652d0HkqNUoNezWgAmQiEhLk5DonPZdA/wF4HFM8PyMmVoY80b3k2K4Qgs0pispAtD9Mrfl9mPE5g5qXP99ZAz/E3hODz6CsxvqQQI7RzEo27CtPLYjoxOzBIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM4UOay6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db1657c0fdso3696922b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722441915; x=1723046715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXyhYvjtECustBaF35QTJ0n/1JR+w0RoGMaJ7n/9KQg=;
        b=mM4UOay6nZFJrASPcPA7zA3QCIKb+r9CYQd+EwxmnZLAqkQRJXYX9ieuJFoZocaedc
         wzf+wLFqNJluVLxXaXtd62AL5ezOXv5sN2nmvaxX5tPi+VQId3w/m+R1Yx4hlRuDyiDu
         PGHPZ3DiKph6+KvT1gK+9TgSxRd4ho/Cbdz6YFuRqZojbtbSpszLx2/z2GB8pg+F4DRz
         iuX3TikJ1Uax/j+XYFrPPtHEGaJOYfyXTlhY0YHS0pNfiSt7NnI6h8bVZ5KN3GyJNaW9
         k2bAE2nGq85PSdmsqqmT1T1tlr8YTRTxhReAF+cnEOBwHtA5RLcp1jkT2npXRHqSs5zA
         ErrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441915; x=1723046715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXyhYvjtECustBaF35QTJ0n/1JR+w0RoGMaJ7n/9KQg=;
        b=TCh/eRJp8m8KhToxO4Xok97C37nd3GqpR2SvJtt1tRWOP2ShLAA6YB10rV+c+zU7iH
         ZADe6p/3HPg4Uge1PYbSdrN2wfCuNfgd4gllFdULy9ASv8YmBoeU7m4yvMCT2fZTeQ/4
         ADCaw+b0om0vRO31kiclvzLzf6+Pl8rZjcx8OVAne4FFKyu0bZ2oJIThYZsdb8anZaAS
         Pawg0JSt2fWCL59mnONfhfiqqGf/FvPhMB1Abb7m+H6YHA4X9GaMV/HLnTeIK4jbHASU
         4rxKSGaNm45fxm7udQgE77GxCdgeKk+Qyf+Mp+93iktDQnYWHVseM3mCwgueMbPQlagG
         9hrA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXwgcnP9/MI6YlDlk1GzphW90z/3MB2LDqIzLpWlgYEy+pBSzkWC0joZglmdR0+kJqrY/kiznaabXoOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPVIsIPXh4r0IXg/8sELY8+TcX19IDtcilJ3CxfYntfRRvQ+/
	9afEKMi7X/rZhzqcbgskIMmb58rFot6vIejbh/LX9am+/TlE3gQCHKeddNi5URI=
X-Google-Smtp-Source: AGHT+IEWqqB12HAG5XXwGLWqO3LTdY1XVVq0hNmyNyCXnKeUBxbjaS+soaAUYehjzReJQa3OriYoHA==
X-Received: by 2002:a05:6808:2029:b0:3db:215d:71f2 with SMTP id 5614622812f47-3db23a2f80amr17817651b6e.35.1722441915021;
        Wed, 31 Jul 2024 09:05:15 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:c572:4680:6997:45a1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db46924878sm492607b6e.4.2024.07.31.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:05:14 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:41:34 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Santiago Ruano =?iso-8859-1?Q?Rinc=F3n?= <santiagorr@riseup.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, helen.koike@collabora.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3 2/2] staging: media: sdis: move open braces to the
 previous line
Message-ID: <3f885f2a-681c-42e8-bdd4-fd2e2c077f5e@suswa.mountain>
References: <20240730212854.474708-1-santiagorr@riseup.net>
 <20240730212854.474708-2-santiagorr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730212854.474708-2-santiagorr@riseup.net>

On Wed, Jul 31, 2024 at 06:28:54AM +0900, Santiago Ruano Rincón wrote:
> Fix checkpatch error "ERROR: that open brace { should be on the previous
> line" in ia_css_sdis.host.c:253 and :258.
> 
> Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
> 
> ---
> This is one of my first patches. Could you please if is there anything
> wrong with it? Thank you
> 
> V3: Insert the change history (including for V2)
> 
> V2: Remove spurious [PATCH] header from the Subject, inserted by mistake
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


