Return-Path: <linux-kernel+bounces-326770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1C976CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B811F249EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1601B1429;
	Thu, 12 Sep 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUf5fSA7"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BB55E73
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152755; cv=none; b=aW/sajlu8o66Oy8amsrxrWUfFGlASomzcnLweS4T9xKD/g6VzHYHiuOWLAqEojoeGlsNnpSM9c/hwSGtAEFG5vFqIkqwRCtHYc5e3TwPDU0SIWoEX0LR/MnfKDAZjpthN/gwVsBL/MTekJ28DwkfR+datrvUJ+xKW0FjKzRq5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152755; c=relaxed/simple;
	bh=5L3XjKyZGaCGCMFTycvEKhMmfORP1Kz/ZknLYi1DA68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1//DqRXbGgVpgxy6P1E9UeSd5w+dmo4A0KWqQLujDDnmsiY70cd46ROSXL05Jpij6RDjaq0ZNSi54i4VBv9qYWiBhF5AOjRB2sg8nDtUSiXeKiJ75rY8iWvSEz3RDw9+XzYcSyIt7Q/FsZ+2ZGx1wscrfPmFHdZlmXeHVbZ1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUf5fSA7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7528f4658so10530091fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726152752; x=1726757552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+ATcCXBiLqkkadSQyOJBHhfQxxwHzkaV8GIwKqvbrs=;
        b=bUf5fSA7rV5IMWPLniTdJT9UJDgjSL94hfVQcHR0ujuU9eU4xuhTBN+AdA6LIGxnBk
         lE6/OxjRLNO0FebMOXLqDxNQS4ii2r2bPaHpwtymy9sA3wIUKlfP2DGjUckX8JKk3QPi
         48dqThT3mPhIO4eaxNRTEyqExSxolR2qTKy/LpdO96RXSadI6fWkacxCfcEEz9LWrCfO
         amR7/BUV66Wufh60neXpupsenoI88dVBtYM/JhkOo6vOW1aGLpGY+fw3kQ8djpJWEg2f
         X62Q74pHV46andl/kwvS3TPWCH54gW0oHf4soqS3Io/xcZ6MylDUdZ67kIatC/iuTx6g
         KEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152752; x=1726757552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ATcCXBiLqkkadSQyOJBHhfQxxwHzkaV8GIwKqvbrs=;
        b=HG0ZqT9l4AoNLAf/dsssTowliqhUMM/aqBZoBfOBXdNlhxPfqnKSeKjnc+D58j5rQT
         e2BxDRP6jS91yUZJzDskScvPKVtL4DPRN/GPOC9HELznAl9GTekym+ce+ZGRcUPVaz43
         0XYNWA/JtO5GqaMqmdKZKrdUeddUECYCsdjgZpaFNvYMGQKqETiifjEtZw6KoDbwbR/h
         npjnw1GLeRhm+e0/G9OUsleLOEZByf6+VE7a0+x9S85XY+/mRn1MTGsJR48MYNxoVpO6
         O3xGFqKa2SCJr3fZ/qUHrk7MPOqejMBxTin/i+y6g4o94+BUiwaM1bfyDs2aMKD3uqIc
         Q8CA==
X-Forwarded-Encrypted: i=1; AJvYcCU9iLuxyK7Zqtk60zEaT2i81YLVEgBKUv2qkQ6h3KwP0LRf70KNcufOxw1xOga7cAx/u6zTxhoYxs4L8mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UmRApXvgnvdnWJ/mFlqYTMqQCg+9I5+UXaJ05yfKCU9KdQtJ
	oH4plUkhNKVcUe5pTOoYs0W+dJ6sZuJK5/v6EukuSMF/mLMhPnGqK4DcMV0IRWE=
X-Google-Smtp-Source: AGHT+IFscth7W2wIMjxwp6qUxm+Laav01ta16an3zwFZlQ+VWEWM+4Xv25f74tx1msWeY+s5nqGk1w==
X-Received: by 2002:a2e:a7c1:0:b0:2f7:543a:3b1a with SMTP id 38308e7fff4ca-2f787d9e337mr20696161fa.7.1726152751355;
        Thu, 12 Sep 2024 07:52:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5245dsm6705327a12.52.2024.09.12.07.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:52:30 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:52:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: prevent some integer overflow issues
Message-ID: <b1158552-d899-49e5-9c4f-bf6a5b80c163@stanley.mountain>
References: <0f03d569-9804-4617-a806-f0e5c32399fb@stanley.mountain>
 <87v7z1yyok.wl-tiwai@suse.de>
 <20c99f50-948e-4076-ba28-9640c3cd982d@stanley.mountain>
 <72907305-eddc-4fb4-9c74-7e1d2750f4b9@stanley.mountain>
 <87r09pynn5.wl-tiwai@suse.de>
 <e364e109-5dac-4a24-b179-af0ee5659990@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e364e109-5dac-4a24-b179-af0ee5659990@stanley.mountain>

Actually there is a check in snd_ctl_new() which means that although these
integer overflows do happen, we eventually return -ENOMEM and the whole
thing is harmless.

	if (count == 0 || count > MAX_CONTROL_COUNT)

regards,
dan carpenter


