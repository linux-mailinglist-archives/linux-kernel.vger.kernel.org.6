Return-Path: <linux-kernel+bounces-371429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BA9A3AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CB4281A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE5201245;
	Fri, 18 Oct 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPFuveRX"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A520125E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246133; cv=none; b=nWWCVCmrOgDMZ0gvM7op1jYCtZ4qTvETKZvx1neoGFonDbsnTmWKhDXWDLQvGGdoZdJVfIUhfFMj8BSawHUEZzfTCNn0W4vWflNkcDWp/75NUg9UG3Jk6+WyLEFd4UvmUdxhoRcWdlI36zDNla2MSqLiaMdMEaTqGk2uExAkIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246133; c=relaxed/simple;
	bh=paimzVpVUpBZVr3owZb7ekMDMYIrzcINjTH+/k/s9GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csOV3wAU7r9llxDQqzLTwaqNWRk4sCumNhqDrcgEqwAkZNju541RYK+jYOEajQiohF0uzG2dUSjxiYC0JIF4cKoY+5HnShyW1zLbdLnbEdV7O22ymv4T7RMLGKj44lmaPcCoH6RC8p43jh9QsFwTezn/txTvK5xuwHASFT/N/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPFuveRX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5743074bso15104251fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729246129; x=1729850929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk9WTW9hJ0HLpI2frlqV2574MIbcC9FM2Cyz3zKihm8=;
        b=cPFuveRX+37WpGSkw4XWhIPDT/RKoVyCWDCqt/8vYdOCqmuqrQhFKXIfW+fsaTSHru
         6UeL7lnt9iIdR5ZFOeMit+12/vPaFDYoeZcYki/33t+o8NP3pUpXnCti5c3kQROD+fDu
         CZtbUAUWsR0Dn6UqfDeT60SnjHo8tKPsJejBROrkk5Pu1NWhditZPtQ7zFxYqgVrwSsU
         k2eaO78NcQB58Y4/iuOXiWoYG8BKr7woT3uPn/0ub+amS4Ia3193r+etZ7dsbtkqzQdE
         puxohSi79mtqVkWWL3cnWtQp0U3IP2NvvpzZUJ05buYWWYVfr1TurX+wybC/Dg7nJ0Gu
         bzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246129; x=1729850929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk9WTW9hJ0HLpI2frlqV2574MIbcC9FM2Cyz3zKihm8=;
        b=ptk7HDViOYbTMmtE2ap/3Mp4TGfiNSSJQNv4lmoiHloVDfW8osDDNAubNWe1bOVO2z
         WXAne2Wkf0RKcR+FFC269M1iOuQQ9Tp9hB72Ym9bNMp4yYI8LIkmeeRjxu9M9amnsLld
         hYcqrn+ReVRvIHh7bXBpwuAc3ltSDav8dd8x2iCMoMC6GWOnJNITb8X5QchD+KeJahXU
         kcwLZ8cIeU+wyHU9tN5Y515tTlbl2M7R43yHO5d5QWMc3jwd0uPK02rla2DlVR1iwPKP
         aGZSlT/S/cRR8ByAZ2SDJL7t54/RMtPLQotZaXa1vdGdLOmEmKJN0/llAf4M7vjMWij5
         yDCg==
X-Forwarded-Encrypted: i=1; AJvYcCWhPSQ/IWAZJeU6umnDya1t4Bs3NHk3fCYwj9Bal8XNVaF9cIUXsKh+jS9Hx6mT5fw5ufEsO7ws8IFuNUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVtIutAzsN7fOjW63W5BERob4syhiX4d2zW1IpPNCOlivU0vu
	WX/kFsABQJswC+WXelqGsjCNZ/aJbhfu180v+xgNqqSmvdvy5s8Wg19PbEG0chPBc2aIDmpQ2rz
	xzUk=
X-Google-Smtp-Source: AGHT+IF5BdtYgj8eLuIeP4n7uW2ZtO7LlEmm7Isl+ir5rs31M8lPn9H8E0qea2dNKu8q0aBrINVKoA==
X-Received: by 2002:a2e:bcc1:0:b0:2fb:5ebe:ed69 with SMTP id 38308e7fff4ca-2fb6d9cfa6emr24964591fa.6.1729246129451;
        Fri, 18 Oct 2024 03:08:49 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809a6cadsm1832361fa.13.2024.10.18.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:08:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jean Delvare <jdelvare@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v3] drm/display: Drop obsolete dependency on COMPILE_TEST
Date: Fri, 18 Oct 2024 13:08:46 +0300
Message-ID: <172924610467.2547396.14111365804696461882.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015134606.5b87093e@endymion.delvare>
References: <20241015134606.5b87093e@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 13:46:06 +0200, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> To avoid reintroducing the randconfig bug originally fixed by commit
> 876271118aa4 ("drm/display: Fix build error without CONFIG_OF"),
> DRM_MSM which selects DRM_DISPLAY_DP_HELPER must explicitly depend
> on OF. This is consistent with what all other DRM drivers are doing.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/display: Drop obsolete dependency on COMPILE_TEST
      commit: 2063ca42486bc07b49bc145b5dfcb421f4deebaf

Best regards,
-- 
With best wishes
Dmitry


