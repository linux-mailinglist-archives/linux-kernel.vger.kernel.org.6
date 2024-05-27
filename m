Return-Path: <linux-kernel+bounces-190152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687368CFA47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0111C2102B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694B3A8D2;
	Mon, 27 May 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WM1qBeR8"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3839FC5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795591; cv=none; b=o26Sfk4F8TSNO+MfuGZPQ6IAbv/G6mUmP4+iwfFU0Lf+JcIkkF3jtCjed9UATMIYIqXpnU1jeA1oPV6lImIGAeFykQCZq8mtWgm/Gq8EHGP+o1Ujg9QzUmvHDRrscEcFpF0229Px5quBPycHkijRJqQgQG7AP5JH39T7bCFRqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795591; c=relaxed/simple;
	bh=04u4dQCtGcXS38Akhe0zrrj/sbwxvvlprltkYuVA5Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otEofjsq+YrPTAGVKh2zW+4XMjUCoMtjMv3W1sXK4zVpMiHE/X65YwJWSFPH3iEI1jtyhO7jFsJIXxaIVSvWec0kP0UiQDWxKxto5Cr0hvpDYyo/RypFYALsIyD+KzQjyAYWzgPqab4vlQ1K/lj+bI8BP5wI7u4oYf3g3iGiVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WM1qBeR8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5786988ae9bso2125988a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716795588; x=1717400388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz0VrIh5WbRJv1JirmWuslt3IpDSba63xN+Qyimt8p0=;
        b=WM1qBeR8yHA7P9/hCigVmmNQrdpRpAJ8RRgqe09yWqdauvjJqLvSqek3VFN95mQHna
         i2LZuouLT0horK8bDfzrpYYJp3mGLlVHIhZ0QEOGd+QdZyVp3Bm6L4nxsVIlz+w8EH+Y
         Kv1GsRY9iVkF3gBqjLLM9+4hrEEzWAOhqNjBP66DVLXCQH0NO3Sbh1c01tR6vV8baKpx
         KWl6zRtUmc6S54a0lXFFb5NRn0fsL9HOY9VJwd2sTR+Js8xt3MLQXakb2X8k931rhBfv
         bNE4uc2HG1bQHfejFPg85bAmQ6AuUA5HOTNQbgMy8FvETifBzlHtatOtSnUORtuvz3Cj
         PTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795588; x=1717400388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz0VrIh5WbRJv1JirmWuslt3IpDSba63xN+Qyimt8p0=;
        b=WyeSvLuumf+xWx2h9qeWvMuiZBx66NRgCQfGPPSFmwC+FASH0+h7B9MxzEPT+W8Ml8
         hOzfSRJ73UVfffvwCDij1rm4RPpdf1K0nJfSlBqeWeDsGD0QPSOdioU5VsY39bZ3JzR4
         EK2fBm2zMyfYkCdafR1ri1Xb8CV6sLdPDnBHfCXmL8IGTglN+5GOUooeIUB6VZu2SnM5
         frxxHGtetHhywilDcKaSPv9Dw3+feA/7fzgZCy6AROamrtpFJbg7ZjT/CkjmzRGho4Sd
         DAQj0AhkMG7yE9EnZGDOVCSz3B7CHQidAODSLhCeaku4vwEm5GBsM15QRwfzLSMBWDsn
         gE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeCpDArHQhzRF/OpvXUoimaDuVF9JS3JfX88+7p5DNQYp/kcKg24PH0viRXNwt21yycCcplEa02RXhv/WVKHmV0LIE9ZDtQWHKyC9+
X-Gm-Message-State: AOJu0YxFqa10pGwl/BuUdWI5piqYLntvIGQelXWEmUofyeQJgi6pi+Wi
	JPX/CttilUV3XrRGvrnFrC8LNRMJjLH88hix9HCfIXWliwJla6kKbTCwsiWpLWnK3zAIWQK3Y68
	s
X-Google-Smtp-Source: AGHT+IG/HLXyHbW6yeseNbj0NSVOG4AOMaoKaf0CmG6jhGtq2IkEwO6pSd2/za8ScxvEWTGn9C3Xhg==
X-Received: by 2002:a17:906:55d1:b0:a59:c319:f1db with SMTP id a640c23a62f3a-a62640779b9mr555490366b.1.1716795587600;
        Mon, 27 May 2024 00:39:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda6cdcsm459010666b.209.2024.05.27.00.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:39:47 -0700 (PDT)
Date: Mon, 27 May 2024 10:39:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Straube <straube.linux@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8192e: remove dead code
Message-ID: <9802cc9e-5962-44a1-a384-3e5ee226cbcb@moroto.mountain>
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-4-straube.linux@gmail.com>
 <20240526143100.FmVupNWq@linutronix.de>
 <e25831a9-9913-43da-831b-d37bdc4d9dd3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25831a9-9913-43da-831b-d37bdc4d9dd3@gmail.com>

This patch doesn't affect behavior at all, but to me the original
author wrote the do nothing case for readability, and I don't have a
problem with that.  In fact, I applaud the author for caring about
readability at all which is not a given in staging code.  :P

regards,
dan carpenter


