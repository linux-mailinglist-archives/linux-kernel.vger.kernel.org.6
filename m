Return-Path: <linux-kernel+bounces-225620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB69132FA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409EF284112
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118E14D45E;
	Sat, 22 Jun 2024 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRKchq1I"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56D14B078
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719051275; cv=none; b=sR0Rju/Wl2nV8lMhbNuvkrNpR5UXzhNMOlgd+HtlawLT9c3eAoP0BfMYu9wrXBrUm8M0/zRStVft8Id8KJr/C0/l0myA9GlIb6jSqKtCAugCxRwPffLJ5ErIZdVnFqrg72vACraEM3ATw+cLvdfptakhoTDKJK/DW9dKs5A/Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719051275; c=relaxed/simple;
	bh=TrpnPDWlENMgK+QM3Bpkpvqow1x66qbusPsLwsIgpdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n0tCU7yvj4pzgMfhQrvoC6iwXi892zIUkeUB1Bqh3yb7zEKHTqt2G633QcrZ3kPMtD8GAuND1UN48ZBZbobszTnLnOswDC4GuwUG+xPP60IlKCovseRq46KCaubuNwk3J7f0ktzX2E4ZRMgrRXP2rZQcdNQUDKheJsbbRizp8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TRKchq1I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42138eadf64so24439415e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719051272; x=1719656072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LOGZewqxDMGMbF7UZoIa28jx2OtGU7FNX/jJsQDTBA=;
        b=TRKchq1IyH5aS7n3QRGuQkadRN0sqjKmPIuh5pEkMjb5wBaF4rbVkXySAIbXe92+Ge
         Kiuvi4ALwaUOlm8IwFsfiCqC8UxeWQFscykqT2VVxTey5IpaDG5bqJM2Zktv6CqO5E65
         ZNinLRlt+23dZ5uvBWyPYbUE5iY+ch5U4tax6KJ31suKjJJ654KVCGFbsLUOslD3Q+aV
         SkQh1sLxN/1lX7KQyaezliNbOObdD9NxO6Rl+c9JMgZewg2WRypueRepRw0oD/piTMRz
         GjIm4JAL7EDJxE9nZt2kS6+yF0Hxfgv2tt5C1xMs/hF2nmf4KjRspzEx5JyE09Y2frYY
         cUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719051272; x=1719656072;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LOGZewqxDMGMbF7UZoIa28jx2OtGU7FNX/jJsQDTBA=;
        b=smIuus35uPMIHGQHZL1BaGIMHtQtakMVIUUc8mlNiL3Up/KRpolFj27STikwzKMKJl
         EjXZI6PS1tX02zzelSVpwrVlakKdlBq2EzIAOCP/bUD5m9+JCm062TjZiGU4df2+mlR+
         xZsAnWA/UaiL3xDDemIqXRTq4xK6P10b5jP1DP27aUaWgW8iTv28Of291jrgX9bbDCws
         2Q3jX6AdHBNDCnhWWpLbTtyL2DZMThfZCgWrE97rlgEizsPRebVzm1QPt53ZxrjpTWvf
         KGcRUJuMmWm3ZuO+0Fc1I9/lNNy+poxBPJzMdYMCoUwAeEN4jDsLNHVkMPcSE0pgHQjK
         XviQ==
X-Gm-Message-State: AOJu0YzU33wLMpNx7/+SXq8NyLdVcI6TwncAiyp4K5J3lDOzuIzIjWIB
	ELbeE2g4tv0dJPz5r5Dc5YVGsNLGOy8XRt7FmHilyhHGh/dfPTwtdXTpEN9VfPU=
X-Google-Smtp-Source: AGHT+IG0BPBJiTNWPcmSLfddECphdGj8leb6Xt9X9nc4MOdu/1ICSnVyniIgidXPWDCxYo7oIfCQyA==
X-Received: by 2002:a05:600c:2252:b0:424:798a:f7f6 with SMTP id 5b1f17b1804b1-424798afe74mr82525105e9.8.1719051271977;
        Sat, 22 Jun 2024 03:14:31 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248482f1c4sm44662305e9.10.2024.06.22.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:14:30 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
Subject: Re: (subset) [PATCH 0/5] nvmem: core: one fix and several cleanups
 for sysfs code
Message-Id: <171905126866.193679.14095365395671907555.b4-ty@linaro.org>
Date: Sat, 22 Jun 2024 11:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Thu, 20 Jun 2024 18:00:32 +0200, Thomas Weißschuh wrote:
> Patch 1 is a bugfix.
> All other patches are small cleanups.
> 
> Hint about another nvmem bugfix at [0].
> 
> [0] https://lore.kernel.org/lkml/20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net/
> 
> [...]

Applied, thanks!

[1/5] nvmem: core: only change name to fram for current attribute
      commit: 92e57866c8eeefd00ee0c05232b5134e11a66298

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


