Return-Path: <linux-kernel+bounces-418288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5E9D5FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB131F22C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208846434;
	Fri, 22 Nov 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEL4n2zv"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E718E3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282938; cv=none; b=RSIn7q6TZHgvvnL9hCWepK7dwBqJaQ1vraLYJjrIomyUAan4JBBCjv3X5XF9nIwOSeEPcNkayjntNE93U196xC/j5sEV0Ev9us1/dpAo6/zz7SB3/2Wwt2MG5RvvPe4XNf6VIRsjIbwBtL0gPtD4d9Xy6TSGho7WtkIHdj8z5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282938; c=relaxed/simple;
	bh=7rpxTCbAovNOOaSE5QqV66Aj2XvYh1HPcKPEvedvnPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TulbocQ04Z7xlwgSKAVN2QOtInF5SrOGBBaG14MeMJbhSYfN/iZo6GU8JHAuf6A8VOySTNciR9YkP4nrO0QdaLEo1XYOxIR9uylxq6SlG5xDY3rnhJV7Cy9b6Rkdph7+4091ABjBOyy5K7jcXkQeUxTH7fC8J4EBB7YB5bTL1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEL4n2zv; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso24518821fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732282933; x=1732887733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR6Bt9wGJi7TnVA8wmi9rRKI8kqmYyf5TPLbM4hQqZU=;
        b=sEL4n2zvxEzzGCp/hRVpZ7udi7krOdjTeN96A96SYVR7j0zgpdrRjPxJH44Jj41hYk
         /S6CMByFPaf6M15/0fDC2ECv4jZGpEODQ4bnyALeLP+eNng5eVm6K7wGAVVOqMA497+u
         rtop/DjDkb9Nn9Pf3NkrHLEi+nQxBhBfRn4MlIndhGmjvLUD1t6h+Y20jvN7j6N1NdeK
         qdwj2G/vDjQZVGTwsykzT2EKUZtvSsKM4sPng4zgczZd6qtwsfOFWbwcW5EuCpEjS0+l
         aKmV1smSPRsYroSH63aKdSgujnvn9Ad+RQH0bdU/74bfJgGPWc5cnym4O1XtKaPJduP0
         sqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732282933; x=1732887733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR6Bt9wGJi7TnVA8wmi9rRKI8kqmYyf5TPLbM4hQqZU=;
        b=aZfKi+qfk5E30DejQcbcKOca3ejZ1Uic7EWrkTgujc07vV8++Jl1mcubwZ3+z3uwvq
         zEFLnRuO5vmWlCffu42JJa0T822b6dtQdSZQ47GwKqKOlUhvkV550yUiQIhkEufDJwmw
         FmCXupfCLGp+cSLVVQHBBJUT68hepZg0tXg6vc/gl/omIiSJuEExpVy/P8vOy/4b4hHx
         t5ConN7OcbcWviDN33hb2KdCtXxkCgv3rJhSR+LPSO/hSXmrm3ODLx88SATzIg7/5cZz
         e/eCyZRz0h4ORJETHo38EjlQVekbN/FzGSFcvSQuX7mP8Ztqz1DTKlKOorRNjGSppdKY
         bA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+4M+sEJq50eO+KU0Paz5DlWb0XIgWkrG0OxuxxpjprPtsq15OxRBR0gz/+xhN6W03WU10h2BDw1714zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAheRoLih3gH98dC9w1Auq0A8tSTCuyn6C1XiTFz0hOJ08ZPIl
	e/lWKJO9SxEfXA5IeqF3w6GSDzJe+xcvq3TwOno2ob5EsU2cHiigKdPP1wXgCso=
X-Gm-Gg: ASbGncvkCowf1XBX+VRv3nJUxviHMGQmFWOARo6erdrgHCutOtwszV9zFKsELKQJOLl
	ZyRZdZGnMsW3YglhZiUnZxBSwEwNDfr+7RMyCV/uWzFXB3z3yCp//bq+G/gU1ZsZNn9i3hcGmJe
	1YZvaDCGMC48qveK46eK1uwAF29zzZcIi33eAJ8vEnsgCDCGbfwmPrpjR84UwbScn0H0YhQR7NF
	z5ESt/lqhJmTXrP/JGik/hXt8RLPYAsRlMN35E3J8RLNDjDGuC6DDq3xmnoLTQc6gxKV/XfAOk9
	9El0+nuA0sA7UmkYztDKoTrZ
X-Google-Smtp-Source: AGHT+IHyw3GH8RrHFNfGtL+1PQD/slLLct9YZQoWaph6bHJlpew+jBHD6XIcc07hIt3G/uvpFcVtsw==
X-Received: by 2002:ac2:4f11:0:b0:539:e1c6:9d7f with SMTP id 2adb3069b0e04-53dd389d698mr1582840e87.25.1732282932796;
        Fri, 22 Nov 2024 05:42:12 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e73sm376432e87.120.2024.11.22.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:42:12 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pmdomain: core: Add missing put_device()
Date: Fri, 22 Nov 2024 14:42:02 +0100
Message-ID: <20241122134207.157283-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122134207.157283-1-ulf.hansson@linaro.org>
References: <20241122134207.157283-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When removing a genpd we don't clean up the genpd->dev correctly. Let's add
the missing put_device() in genpd_free_data() to fix this.

Fixes: 401ea1572de9 ("PM / Domain: Add struct device to genpd")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85dd024..4d8b0d18bb4a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2183,6 +2183,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	put_device(&genpd->dev);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
-- 
2.43.0


