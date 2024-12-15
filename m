Return-Path: <linux-kernel+bounces-446418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E509F2423
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A197A1080
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4B192B66;
	Sun, 15 Dec 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dssUxXKB"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E241925BF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268259; cv=none; b=IaJF9gAoYL4brtef5WuZZI0Ux1mw+PUszmPoCJgT4YSCXFBc+wS/vnsNkqvyphBK0DcFfaXwwoR4ibyXkN3QxSANnXl+FyzdaMQj7nu/nggV6/FwHvSuzZsufDy0f49D8cmGrU7v+R6RwfFoNiNJGSZpf5cOmc0S9yj8K4ZyObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268259; c=relaxed/simple;
	bh=K5/nf71iDVNxc+GUSfyZS6XpkzB+A2xx6OftMChIeeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz+HC7CcV6hLgXiRn3D0Al8+mOacVKmfJ8c1f44BA3z6r0H4I15fbAdX1FXdyu+yXh9A42cQsg1UrkY+mUcefEnSq2di/i2Ity6WgdSwmwOxt2Gr6aFcfYfrh009N0pkBEt7aDuJnXL725Z89PzLHcrHu+Zm6SpepLQI7wa5TKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dssUxXKB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3022484d4e4so37317681fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734268255; x=1734873055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cnbx6Y9yMJBvsPZY055b2Z+E7Q3d8VBnIiflj19jBI=;
        b=dssUxXKBSaO/yaNX1wagGVs4BkBRAAkD4Pc7QqfB9XlZSjZLb8SEOR75RRfCtoKLp+
         j2zvRteFc9LOCXVbBKtrVGwQQZfGf2yExU7OoQNQvwOIeLIbY7ICiReTRxakuh+ywWdz
         td/AqYY57ZI31apd+GIC0kNKhjBzfFhD4ja6AkZaVUXUUS6WYcWigcDuN7qGQrNSISSr
         1un6JsaQyNI9CDU0DwiZFGKsW/pWQ4YrqrTjFPckg/86Jvz+iIPlon90JYh48wepm9Wu
         aC+R6C6KvopQkyL92zTQH6+cPrvmxgHZgIp24QFhlCQk+UDGCKHv7nEaBJPs8R69EtT3
         ippg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734268255; x=1734873055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cnbx6Y9yMJBvsPZY055b2Z+E7Q3d8VBnIiflj19jBI=;
        b=wV/AgaeWjYXCN6i6yVPF0RlTYV2HosPdxT2Na2mBLNq4fncvQ7NYYZy0KJnhAB9peo
         MqmInwSg3MvZ04hq8vReipXWU4ip2Ixlj2BRTgAOhuYOR75+HfRLeOjWfSF70n3/24gA
         YE58N3ncjgRZUxi7tgVXlGFwIK2Kf/aKXfJ1Bdhwi8QSdRPadRETzqM8FHbWEUM5AKGh
         BK6tEtq5vunxuiCxrc699BUmFLOjV+vokQICFobktx4ylbw/5tf7YaUJFQUHODLGX8gS
         FuNaxNj3ZaRgcXhDydFBc+XET8u8N53ECMQUGKDJ08hKL2p7272RHmqqJwxAkdI0dFF/
         K7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCX20QkXu7B7WWhHnUwkZip0AXqWz/QRJFNNVO0vQ0TuD+5fROF7oa1RNW/quiGO+1f4cWTScuaNPa5GhyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZkkbllVxyLstQkpiWMGgk9AWzy1lwTEcXbNvI6T2RCmxbTbK
	9JeNVkqSz8oREW8bfeOJbCQxnAiFMXQOQ76j/eMPCoekWNWkD7OD4T1GRiJLaiE=
X-Gm-Gg: ASbGnct/F7DJ2mM/ybUhV0yKZrICsZmi9VU/eQSxUpQB4veYFloxmGmD4Mfr+7m9KhV
	jm9wJj7EHS3TAOKphue3yAuuT4J5Op4DiXVGr+boKa2qPADWy/PqRrXLaIgGKVPiS5rxZu0YRYT
	7Ujwz0OkSlBHMz0JlmfOL0BG8OYbt4MWhnNVs8VjPOFUdtSs1QDOQ05v3ZNleDpdOj0ZYX2FirA
	7bD5V31n/9+gZ/5jnWuCmtQZbcu8x9uMWAZ/hTDtg5ZozG21cmOo56sjmfFOB3gk6ZoZvdy
X-Google-Smtp-Source: AGHT+IHTw20hSoY1t2S8hQDm6sAR/6CNjVdyRnyImaVn8xVxpAXP6KiR+1x/jnjFYeOmyB9D3YqAAg==
X-Received: by 2002:a05:6512:3195:b0:53e:395c:688e with SMTP id 2adb3069b0e04-5408badcf28mr2596428e87.10.1734268255530;
        Sun, 15 Dec 2024 05:10:55 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c00262sm496316e87.138.2024.12.15.05.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 05:10:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: quic_abhinavk@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add VBIF to DPU snapshot
Date: Sun, 15 Dec 2024 15:10:43 +0200
Message-Id: <173426667309.2196979.11608285674325095814.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122-vbif-snapshot-v1-1-6e8fedd16fdf@quicinc.com>
References: <20241122-vbif-snapshot-v1-1-6e8fedd16fdf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Nov 2024 15:09:10 -0800, Jessica Zhang wrote:
> Add VBIF registers to the DPU snapshot to help with debugging.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Add VBIF to DPU snapshot
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1a40bb31fcf1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

