Return-Path: <linux-kernel+bounces-519360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED3A39C03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9604162E73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859324112E;
	Tue, 18 Feb 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcbIPFhq"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C9653;
	Tue, 18 Feb 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881121; cv=none; b=C0M8pajy3A6WJh2O71C6yQO9TQiytr1GxgnGSpMbyy4EYpUhgKZZ6pUpZeqbldiblB1bk2hMAvg00LZ203xJXqnTyUMyyOAcwS9kb7Oudp6U+zPaz6Le5B230PUvknQqNk8U5ZAWUdsVookutAuGpwZ0M32jIModYtlysi56ksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881121; c=relaxed/simple;
	bh=UXMGXKFPk66kxCTjhHEVzYxn8lEWZHsKZJL5YAmtQuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPxINIsaw+vLU5FeqhmKvHUcLsZ4NYxZGU4d+B57ooZ+ktHd6wKIdobSVB+XLK26A0j9MOnvvKfbc5AG00gL0pfCwAJJc7LSUEx9QW5WfFkGtS6jydogShysNLyG4VfskELNlcLWy6Xm/8Iq7O/5ZQ+ttIUULVONVR6AHh7hjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcbIPFhq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc8482c62dso392885a91.3;
        Tue, 18 Feb 2025 04:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739881119; x=1740485919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcOf/+mAe7HjVKdjr7yO9VSKEbj6DVv1uV/KGTc/++g=;
        b=AcbIPFhqVGnKwmd48hIlhXJZIifrNo4gqxOViIzUs9WZGuY5U2OHH4UcJ1j06sMmOC
         cnFVADBG4fUQMQpIKIaXXP/Bnj7ezEkFTLt/VprUOLqLdqhAZKmPg3RIFVNQeEMpV8PD
         HvrG4Hn7W+HZCD11Zfz2fAvzl1DjipC+TnYkswUFR6nV4KYGtuIiTfi0CKFdx27ktdZ5
         MJFNzITiQLkJY4MBhg5I4/I+Co9/MNRda+Nc4cSGEb3gWLx/ayDYNrNkMH4QF++LozfA
         PRUAqhD6EEnlg6X8Ysl5SMz1mSeAZvdJ2vgCnqC2Ana2s2WUuCDBNPAWo2EMGZdJshbH
         1g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881119; x=1740485919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcOf/+mAe7HjVKdjr7yO9VSKEbj6DVv1uV/KGTc/++g=;
        b=vnpegqC+J5y5ad/PNzu/7Ph+hser2Kz1Etvgzw+4zSk65CkBI9CZekjfo0F04Aszcp
         XkFRcrnHmTbnd26D7MifNtpVvZtuVLn9LT2fZikKFm+GsJAP9l/cASET43AQQCGmBeVi
         /b6XYfyQ3G2hSFqHCz2xnAVyE3rpIwp06ai69u0BzPtR+CU5XE6xbTp/gq3/PiY82F8P
         49OOyY/SDEvY4GsT7A7UMvN3IWImOC9s+eJtk+mYqDlWnw/96m75bm94bp76eQT8TDou
         ySh2A1430mj0W1kH1KhV6Yf81ehF21J+vTwaV8x0IxCTpHzBX7+Gecwpo9jI0ki79ywa
         L4iA==
X-Forwarded-Encrypted: i=1; AJvYcCV4f0/L8ZiCO9GaQsjZ87uZBqFFP1rM+tTL5F4DM5Q1FyJadMIXktewOMixpoCYGBfetNIjjUozBICA7gEN@vger.kernel.org, AJvYcCXcfzZapChY8XskY/UHrauEt5+2IjNyyGX4JUjmbFvNXx471WWHtjCX5ysXfl4uEI+CCDQlXOx1wsGm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nSsLkcmgNu8PKAOHUzJVq2lmvsV7yXOvRJDbrVjjtpTFcZyI
	lGUV048a+QWTkQ1ziKjaAaItEpuyRVA9hZ2XhwhHeXwLc5GR6FOE
X-Gm-Gg: ASbGncvbhFqAKMa3IWmYm8K4Ohj6pg+1txQurQF9oxzOAm8LTj+Fo2kD2jjibXxi9Au
	UejdEKKgS6Ery40uDmm9cjFVV51xeCcoArfd1ffCPTRlEcmZflyxwq4+wA9Vd0dycxkdtGaL/yP
	3j/Hugdtc9HFu+6bzjApszE7evLw0epooT5B5wwL7qH0C4Li1MK2TtgLreWR6+1B3d4IhJUIMAf
	wUmMbRQpK+G12XnsC1vij+iHBtnUb9D1FdQ+suuVfnSs5dtygpfi+saa3DK1Ga1hwN3A512WF+D
	YRw4CJdefINC2kwgh5MC
X-Google-Smtp-Source: AGHT+IHPsPfeZPNuDFA8wzs+mlVOqsQ83YHZnd3qlJa4+vQqXKKzygw1wD0+aOsxjfqbOZCURGWEyg==
X-Received: by 2002:a17:90b:2250:b0:2fc:1370:9c2f with SMTP id 98e67ed59e1d1-2fc4103cd0dmr8326098a91.4.1739881118858;
        Tue, 18 Feb 2025 04:18:38 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ac19aesm9896535a91.17.2025.02.18.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:18:38 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: heiko@sntech.de
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	hjc@rock-chips.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK3588
Date: Tue, 18 Feb 2025 20:17:46 +0800
Message-ID: <20250218121749.1382322-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1919367.CQOukoFCf9@diego>
References: <1919367.CQOukoFCf9@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

On Tue, 18 Feb 2025 11:00:57 +0100, Heiko Stübnerwrote:
>So I guess step1, check what error is actually returned.

I have checked that the return value is -517:

rockchip-drm display-subsystem: [drm] *ERROR* failed to get pll_hdmiphy1 with -517

>Step2 check if clk_get_optional need to be adapted or alternatively
>catch the error in the vop2 and set the clock to NULL ourself in that case.

I tried the following patch to set the clock to NULL when clk_get_optional
failed with value -517, and hdmi0 is working now. There are also some
boards like rock 5 itx which only use hdmi1, I think we should also add
this logic to vop2->pll_hdmiphy0.

@@ -3733,6 +3751,15 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(vop2->pll_hdmiphy0);
 	}
 
+	vop2->pll_hdmiphy1 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy1");
+	if (IS_ERR(vop2->pll_hdmiphy1)) {
+		drm_err(vop2->drm, "failed to get pll_hdmiphy1 with %d\n", vop2->pll_hdmiphy1);
+		if (vop2->pll_hdmiphy1 == -EPROBE_DEFER)
+			vop2->pll_hdmiphy1 = NULL;
+		else
+			return PTR_ERR(vop2->pll_hdmiphy1);
+	}
+
 	vop2->irq = platform_get_irq(pdev, 0);
 	if (vop2->irq < 0) {
 		drm_err(vop2->drm, "cannot find irq for vop2\n");

Best regards,
Jianfeng

