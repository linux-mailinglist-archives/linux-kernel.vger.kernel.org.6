Return-Path: <linux-kernel+bounces-334959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFB97DEE9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0E01C20C10
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081B322094;
	Sat, 21 Sep 2024 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxpVQvgO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C213C9CD
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952107; cv=none; b=r7pR0vMzdNsmzCzIXpsOBaJ1U8EBgpeIk0WVjGxT9HDyxDOMuprndKk68B1UZ1LC5/yiVGUpSaqrJACMrjotxH78Cht61WWkW1Gcfce4yJKTArDkmeEP2raNSCRX5+jQvqr2+p0zm0ap9yq38S89ShFgZmgqQA4PfmDaaCbN4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952107; c=relaxed/simple;
	bh=zCqpoS5w4f1xCshb9HIsD+o5plreKKm3k8RGLBVK15c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCyS+sYh4P7fphE9/OQ3NfULZE87X3qDw0PYkEpoCo7KZPv04pIYhmPzlxRQ1U4zqNHZut3OuS9H8cyCoKbIgS5gv5Am5zWxiSwwHg5/VeghxMOa1QMyLeWuw0+MauKJ3m7ZH8Xb7oe7Zxk++y1ILqJ03edXRZ0SLmLxNjfRuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxpVQvgO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f762de00fbso32646321fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726952104; x=1727556904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bTCsBF5k6hiXd0BD7pAzfGo+bzmLOlGAZbycow2IC0=;
        b=cxpVQvgOnB9RYQhW9bksqm+HgslffbiariyRDN2827fPUA/gYm1P/3JbCzNa6LSmGV
         1LVJSz/y7wLgEAHvsadmRhRMT38LeBt9R61RRVtiwHHzHeZujmRneFgsQOnnUeDVWLNo
         7A5/+kz+sFKEqvAnrsOHCB6XPcIqSOQ+hKbRXmp7t7+GfkMUIRSDlChk+Nan+IRoACGI
         NXCeMoubInwDFPDqeZt2EoYHBudBSQDA4u9NAgN68URmZ2uYmJXKexfd5k7K9QJSHCrV
         RSdTmQ2MnTjXIGnoMiwzu9uuKl8SLI3AIQ3ZYwxQBPT/ywA/H8hywmuRWTVRHYgRJLeq
         vFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952104; x=1727556904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bTCsBF5k6hiXd0BD7pAzfGo+bzmLOlGAZbycow2IC0=;
        b=Gnwv4kCuUh3WRAYSnKrE1QhCwZbA8IyK2hgAK/w36iocuEyy8M8eoGQg4+w8+I7Fv8
         iwcEDr54r0asT5B0IbL3tJswr7p6qLwJP4c8SGvIxrDv21SAO7QZ/ipBKZyU2twGPWwH
         g0SiBBPP3IDN4vY091KQDORZFkJnDyd3oYYyIQQX/QVZFGMus/O4mHdfcCNkzl7TrfCX
         Gv5W2o2hZTygl6z4T12vengcbOwrRa+k01louuHaIgcgDWq1VBJQqK1bt7SkV8Uo8/cE
         wGwOTHReap5qX51VPVfaPfUmAcuen1xwvY6HmMMWJ7912O+mNgw+Kl9YgoPtCLCZKq7b
         H0VA==
X-Forwarded-Encrypted: i=1; AJvYcCVieHV7yjujOrg/3Lt75CA1bEtQp5ff7LrNDJYu7rEk7cHaCf7pIJZDraS9aWQi3XnrLH6AvSyzu0Wktzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YwZHRclc67aS94YXjMSASndQZ767ae4Aty7cPNH2L22Vp9Fl
	+nyRuFa6hRqF9aWnmGEohZYJtPvQffAB8URv5hXZ6xeFfylliJaPPCXooD4MB6Y=
X-Google-Smtp-Source: AGHT+IGkE/CDmDZd8a6qDrSxzq4ke5KBxWqmH8ZKD8+ZcMk8xb1LBGvp0UT4UVMQ7i9Mrzn6JJ+Flw==
X-Received: by 2002:a2e:9dc9:0:b0:2f7:5519:7130 with SMTP id 38308e7fff4ca-2f7cb360708mr28339491fa.31.1726952103966;
        Sat, 21 Sep 2024 13:55:03 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37f6besm23986731fa.94.2024.09.21.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:55:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: laurentiu.palcu@oss.nxp.com,
	l.stach@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	robdclark@gmail.com,
	sean@poorly.run,
	konradybcio@kernel.org,
	quic_abhinavk@quicinc.com,
	marijn.suijten@somainline.org,
	thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	agx@sigxcpu.org,
	gregkh@linuxfoundation.org,
	jordan@cosmicpenguin.net,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH v2 0/5] drm: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Sat, 21 Sep 2024 23:55:00 +0300
Message-ID: <172695208396.1339964.10365625478619096144.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912083020.3720233-1-ruanjinjie@huawei.com>
References: <20240912083020.3720233-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 16:30:15 +0800, Jinjie Ruan wrote:
> As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> said, reqeust_irq() and then disable_irq() is unsafe. In the small time gap
> between request_irq() and disable_irq(), interrupts can still come.
> 
> IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
> the automatic enabling of the requested interrupt in the same
> safe way. With that the usage can be simplified and corrected.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/5] drm/imx: Use IRQF_NO_AUTOEN flag in request_irq()
      commit: 1af01e14db7e0b45ae502d822776a58c86688763
[2/5] drm/imx/dcss: Use IRQF_NO_AUTOEN flag in request_irq()
      commit: 4380f8624b8bff3637476726351ed7bb8850188a
[3/5] drm/imx/ipuv3: Use IRQF_NO_AUTOEN flag in request_irq()
      commit: 40004709a3d3b07041a473a163ca911ef04ab8bd

Best regards,
-- 
With best wishes
Dmitry


