Return-Path: <linux-kernel+bounces-391444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C29B86F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9582B1F22A44
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768B1E6DD5;
	Thu, 31 Oct 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEN9+VpJ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6121CF5FF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416677; cv=none; b=Ykn/dx/tYMn9SLrpMWAZT+Tz77x3hCbGlDRCKuZ2xz6WKzfuinvr3ILDkSK68KJRycFI9ENdahcOU6lVfmjEE6GG8HHhEXRsgwBANgrATEqAMyvr9KVTNgrPbpVTBplQzDo9RBRSVc/tH5MrvVWfB/at9oR2anEK9d5VMXMLWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416677; c=relaxed/simple;
	bh=zEuzDU9Hs/Ppg5PEjhCjDAMSLN48boI9R2fQhtzK3Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFOzMTh5ZlJGYmZK2SDNXtyV2C73oKvU/PSHCXgbavu6Nu4h6DXIQZI9UwozL6SYLhnPvh8/rqayFOIH/6MLM7TfPUemhAIJZt/Ol7ahvGCreQH9rwAyuxRrhNMIlK4VzAbf6EPKYvE4mcxHgtiemWXEdd+RivHRcHGEgPJNt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEN9+VpJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb587d0436so17480201fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730416669; x=1731021469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lll2oecR05rxr53p0AjzsKoWCjFTY3cjM1CQZ34f94Y=;
        b=zEN9+VpJWnGThPaLwxviArsd7kQyDDBxWnbLDTrUxfP7GNpAcXawp/vsFlNJH9LnfN
         pswpGfqbMXPAzIbXM917DmHCpuUKB/p+7NdkFCEgv6IrSRM3ZAjmg2FI67y22VupXEbD
         avZ9gecWfqm+fEtu3f6Mh/st5F+ebz/7WaCjGUgieHUFJpgVQUfFprG6rYX9Q5YjBbn4
         81WsdafLDBbraryDFYE7UgEoIJRPIVAGsjHhve97yh2/uKtPuORPq2srZaEqGeelp7HH
         Ef0MpSwYBzU7IcwMNlKtgKj4mKvx09fBDgMxlCk+ogOsgccl+cCiDBI0E+uzQ6rfVSra
         tmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730416669; x=1731021469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lll2oecR05rxr53p0AjzsKoWCjFTY3cjM1CQZ34f94Y=;
        b=QWHWnONknnOtkvMW8HD8FkI6ThdnpaaNSlEQT/HO7y4FIgyO4T0LKhNxZQwwP+e5uX
         nBx6g0ccEVkqBg+I0DPoJ5RWbgyNSJ3T5QjblamYShE3oVSCtHH3kzFWSAMaINmMl8QE
         o1KPA4MvqyBcZnNPoELkTJSSroYUKLHjgXOfk0Gjk+5fdtLtL97H8nW8h1DbnYHypuOr
         QoyTZI9Bf6S37ZzVFA3BNtbyjV+7kqu7hXbY+u9Lzz1gv0rrTke+PtagRmFOWCTW1Nb1
         106EkkZOA3tcHXldxW0u+NQDyYBOxf8J7HouNiYL8Eg1GmqOASguQjx0DZcSMOxWvr7n
         4Vqg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXT/ARXGRyvxJkI+tp7ZcFxKwH0bs0L8jb4MlR1nHiAe3ABEqScgIdBt1gp+o8hfqefn5RKzeQJrZohY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWE7yChn4UT1jhgtV7d8irV+wYmpyfmvH7+is0NgoQZ4QdfPy
	kPgnHtDlPRTqOZgSK9FoqUqygScq1fccaj184qH04IctNbQc+4iEKHhJ1XEQ1A4=
X-Google-Smtp-Source: AGHT+IHu3vlLdbVEh7NZJQs0I2jnIdpwbBUwg2vKoG77QJiTFiqvwPTZ8gS1SAL6o71LYqNS7hbRag==
X-Received: by 2002:a05:651c:160f:b0:2f7:64b9:ff90 with SMTP id 38308e7fff4ca-2fedb7964a1mr8398921fa.9.1730416669178;
        Thu, 31 Oct 2024 16:17:49 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef617ad0sm3536041fa.67.2024.10.31.16.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 16:17:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 0/3] drm/msm/dp: mass-rename symbols
Date: Fri,  1 Nov 2024 01:17:42 +0200
Message-Id: <173041664077.3797608.9986077411364114965.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029-msm-dp-rename-v2-0-13c5c03fad44@linaro.org>
References: <20241029-msm-dp-rename-v2-0-13c5c03fad44@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 29 Oct 2024 22:28:23 +0200, Dmitry Baryshkov wrote:
> The LKP reported [1] a symbol clash between the drm/msm/dp and the HIMBC
> driver being sumbitted, because both of them use a generic dp_ prefix
> for a lot of symbols. It's a hight time we made msm/dp driver use
> something less generic, like msm_dp.
> 
> [1] https://lore.kernel.org/oe-kbuild-all/202410250305.UHKDhtxy-lkp@intel.com/
> 
> [...]

Applied, thanks!

[1/3] drm/msm/dp: prefix all symbols with msm_dp_
      https://gitlab.freedesktop.org/lumag/msm/-/commit/fb7d509b1710
[2/3] drm/msm/dp: rename edp_ bridge functions and struct
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f47e87b07935
[3/3] drm/msm/dp: tidy up platform data names
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c36a410780a3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

