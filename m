Return-Path: <linux-kernel+bounces-446416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118879F241E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D1B1651D5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA61917CE;
	Sun, 15 Dec 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKFL2YzE"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112318FDA3
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268253; cv=none; b=HKsj1tgVwmOeKk+3ntN0SYQzsz/N0eJ1tg+2ZbWyBHijtDLvofe9pejY2bynczAcyi6Q+flTCY7OCLuL6EZcun2Angu9LJ9Ne9AVs092GtcBlU6CLzKQnrbTmuN/YDz6xf14vpMsRa+xTtWPRJu1UhmjKrvKYUMaIkg5jG5miGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268253; c=relaxed/simple;
	bh=X8hZt4x1ZyhrL7OcBkzerILtj+v8BNdS+X1YF0sAOd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5EiSm/WLeGWd9nUCIQFS2hnVhb6AUlFYCWFozPn5bKiCWFuC6eDljWKuoD6xMD2OAlrK1H9R08i+FlDrBTslve2wTytF1LWdUcqsQ1KkknPUiYR+GdpTGZe2pivQ77aBGlbKfqhwzE9QEfQfR+3pvs1EWhn8wlG+heHSI5ciag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sKFL2YzE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e384e3481so2991238e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734268250; x=1734873050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awxvmFGu6W8HI08GuYqSLCup3VkCru3mT3zlTswkMMk=;
        b=sKFL2YzEjQ6gK7QZXX2WuyAzPXSBY5+n++ECZGBMTfL3olav3SfKmyMyHs/x7GrCt1
         kavfArXlIg0LB6qAQtkFOxZZ+8n3nSuqkYpBIVFTSBcdj8zb+t7Stcqt8K7ir0w8XAoa
         db6hFQJDgewKdKkDPG0QwdT0BdyATdDr9aHCamx9bkNgcsjWSgxC8dv06qnyGghzLdT6
         5mPcEwDa3cdOOAvXoiGMJphIXVrS5WMXK6wYXD5+otH7ZxAKzNMCd0AEIAw03EOT+DmC
         zNM3t1lYofvUOP26y+I6jlYvpBCGsGatPsju8bPws3BmAwy9CoZzXgmYHb2h3s7owJKq
         ny3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734268250; x=1734873050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awxvmFGu6W8HI08GuYqSLCup3VkCru3mT3zlTswkMMk=;
        b=tenhhRshoDiPbOUcnVk33zdmbsyVZY0WTKp/DY0u+1cIhVyAeSDlUO/AnhPTnFZuFL
         UeQPMryt0qMJTi5AQFBhlx9cehEPbaSd/h00AE3C3HwnBGMZ6ge/35+CzhtZoJ7om+/i
         iQFKKZ7L9q9SPt6MJgeTR16E39rWLZThj5DnsrEKbM3tnu/lt6OybQdstRjs/pneFU60
         cyD55VKv/e1hpm7q5mQv/RhpGWq1qlXFYDVmr7nB6rXEuNacmkV5zdkCVnvLenPD+QyG
         DyqSoVRA+N+p4wKji1R63+WSv8qnahAYNP4sh92BQOzCFmJJBMLyjjagehcTYiLsjcZw
         y9bA==
X-Forwarded-Encrypted: i=1; AJvYcCUgMFpYKjMAvY6SROFe+OvLr605tjmNVlSejaw0OHrjWwpq3FeakhOlDK/d+ju+c9uFZNtIY3xO8KM69Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKScvyZ916TO3pYMaV2K59LTCTHAW0JIgWHEEth3AAtbekXsD
	bd7fxFQ6HAZicSFVMWGSC2Lt++xjK2QDAgfy8ylBaHtgcTPigYYj2m734Km8MLs=
X-Gm-Gg: ASbGncu71X5I4Myq0KIzpJU/W8inF/Mpi5mzxjvI0mvRUMMcLiJWYrcYvGxD4C4EeKX
	Sd7CuAkqN4fhQGCqfa+BKXtq2vfT04n/Qnk6UmW1tpzC/uXeaw0TvzX1O1WEMkJ2BWLLvWFSuie
	Xy8f1LbMTmpAm3DK44+E4H7nlFnHDr/XB4aehjzgKIIRCj3K9VP4hpu4OUMCvjFcAa6omFvEsUA
	lDoiojLSCQWigntZmgvMAcfzbLTBZu7FTzMbjeBDrHPBMTWnnGm4GJBDyE5uA5TXEZ2mgSk
X-Google-Smtp-Source: AGHT+IGrNf/u7LsRewYNxdnxXQOGY+8iY4gXe3eVKZbdSNgIMmlapF4Yec2PrHTH1Kv3kmEvwc4VkQ==
X-Received: by 2002:a05:6512:3a87:b0:540:1d6c:f1bf with SMTP id 2adb3069b0e04-5408ef55f89mr2518182e87.11.1734268250087;
        Sun, 15 Dec 2024 05:10:50 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c00262sm496316e87.138.2024.12.15.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 05:10:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dpu: filter out too wide modes if no 3dmux is present
Date: Sun, 15 Dec 2024 15:10:41 +0200
Message-Id: <173426667308.2196979.9157253558561897505.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209-no_3dmux-v3-1-48aaa555b0d3@quicinc.com>
References: <20241209-no_3dmux-v3-1-48aaa555b0d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 09 Dec 2024 13:18:36 -0800, Abhinav Kumar wrote:
> On chipsets such as QCS615, there is no 3dmux present. In such
> a case, a layer exceeding the max_mixer_width cannot be split,
> hence cannot be supported.
> 
> Filter out the modes which exceed the max_mixer_width when there
> is no 3dmux present. Also, add a check in the dpu_crtc_atomic_check()
> to return failure for such modes.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: filter out too wide modes if no 3dmux is present
      https://gitlab.freedesktop.org/lumag/msm/-/commit/dbc7bb1a93f4

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

