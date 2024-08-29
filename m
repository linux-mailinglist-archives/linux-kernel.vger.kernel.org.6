Return-Path: <linux-kernel+bounces-306747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B879642E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA152865CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A11917F6;
	Thu, 29 Aug 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkDUYOGD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EB7E59A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930549; cv=none; b=B1IB5rRc+gbtNOQeJJoai+RDzOJdNS++QWGI3uIIsSK+ukqcvC8ewgJ8TG7Yhjt9fWn+5u9z4Kw4nnRrT+Mbmj5rOB4Y5q/4ljOVkolRfpKdtS4EDv59zwpde5V/19u10SV3fFEbT9sXj+5eKpBHjT8ywXM8bmeNMQlaZF5OqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930549; c=relaxed/simple;
	bh=UKAFLic5sUvG0MAi4w1J71bSw6RYZMUlgvvspx9oocY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d6pCtgqVnR2W72q8esVhbRqsFoIa/QAizX5lD/mP0uIC+2s+KJ/ecgksLVeJNIwYW9ify0hfcqAm4XRZh8pdkGxGaUe1R1VbB2lLtoS8w4+7RlWhl6Z2z9VmI9nzU1r/6khmh3Qlrwuk+2O0Gin0BLREv3T9uOz2ASiULnl/tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OkDUYOGD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280c55e488so3065775e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724930546; x=1725535346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgb6iZKhbzGIQfuNXvt3MSxhnROPCHe+fvwJkwB4S6U=;
        b=OkDUYOGDMg1V8Oc6aY13J8p+AHxunghgdtKkdP4jgrsUv9mkSVgQw2110Mt0mTZGoV
         OrQIwH+IBh3MrIPFRJAlsRj+UkvPB9dbHHiy+xOCmdLBbTJV9Hppec3bjGFYtRcHvxkz
         B5evfp8RTlEZkiGRN9C70noC0RbOOCEXXbOAimmmydh0nnfTVqm6UC2pKoFNZ2UVE5QL
         jCS4ume+h67BmwBBpLsTLRoM8WrrHWddMlvXTM6yzcPaZThvOmkbs9nUSgYGdevdua9h
         g2t69epfRKubLHqSly98gLLnlpcAk8KorNWf0PIkD7/QBK3t7HbXAZ5IQfi7zxs89IrW
         Ewcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930546; x=1725535346;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgb6iZKhbzGIQfuNXvt3MSxhnROPCHe+fvwJkwB4S6U=;
        b=G/TLB1Yfm1h8n3LFP7LGmIfnFMsoOvWLQCuaGKcl9SmizxhaNU4dXWyCPxuuSUJi+L
         NSBaKfhBTsJUTckE2cw+kVYCRvWo2dfNi8tTMoN5USyxZXvD21pYyz4CSPQZM21IZytm
         oPRertpLSeVsncjnmZKQbpIMjJDvSSE5wpvp4mzk47t7qNVrZCEHa2iILirLz0HUeqZq
         toOGA278qlNI015+8b31wbTp9M0rHrCYaoCucoSUURat8NTr+56IFwqI/1x5luX02yuX
         YAqe0lREX6dMg+IHkQ4ytUEHv9KZPVOBC1pB1+uo7hmYmBjrZrzVLrj6KSzcpTLJbH6g
         r0cA==
X-Forwarded-Encrypted: i=1; AJvYcCVNs3zOgZYgqQTsCejAcy69ifeYby8ccJHVR7nAISZf714mF0Vk9tSPbqwom9o4f9r2ewzGr82BgOh6TMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQqLohgRkkWPtRSS1DMebFsz93Cl0FQxH4T8bwapo66gcIqOD
	C5MkWgsZ7pUyQBUllggH2XdGDSLJA6th4oh74+6bi0sG53ZC86u3E5ZEuRSUwJ4=
X-Google-Smtp-Source: AGHT+IE0nbH7IwCpgklDgufzyh8MSswgnymev7gytjl81YNMXkfTbZLWTfVxhkwJh4TfKrf86Wv83Q==
X-Received: by 2002:a05:600c:1d08:b0:424:a401:f012 with SMTP id 5b1f17b1804b1-42bb74111e3mr10034135e9.3.1724930545955;
        Thu, 29 Aug 2024 04:22:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d60sm14122015e9.43.2024.08.29.04.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:22:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: quic_jesszhan@quicinc.com, dianders@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240828182210.565861-1-tejasvipin76@gmail.com>
References: <20240828182210.565861-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH v2] drm/panel: novatek-nt35950: transition to mipi_dsi
 wrapped functions
Message-Id: <172493054517.1145269.7126299597772633159.b4-ty@linaro.org>
Date: Thu, 29 Aug 2024 13:22:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Wed, 28 Aug 2024 23:52:10 +0530, Tejas Vipin wrote:
> Changes the novatek-nt35950 panel to use multi style functions for
> improved error handling.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: novatek-nt35950: transition to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/076403a69837c1f8454ceced3ed6f0465835f4d1

-- 
Neil


