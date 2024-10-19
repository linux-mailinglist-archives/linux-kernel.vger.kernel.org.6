Return-Path: <linux-kernel+bounces-372896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE319A4EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D881C2155A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90318D622;
	Sat, 19 Oct 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbHDvMTl"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09018660F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349841; cv=none; b=WCs7h23FEIOy404A9CrcxjN2uF/pc/IO4gOcIfpSdpCtxed9jF+hdRNG1Xh0S2WPi0AgMu+y+4A08k8LG7geBWnT/9Hwb9k0vLe13UVtIlogMpkb9gPKh59NVupw6sEmoPar2kKCsfx5qpBYOmvq4WryxW4uTCELkrl5Ikj+8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349841; c=relaxed/simple;
	bh=DKNwqc8RtIqbIgbXvDSqWJ5GlC+yZMaZN0navXPigB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeIa7CaF9OKQsUgMuLj9tcEI8WiNqlDPq0GTEFO6ljjP5ZjyjHC0em/6yWN+GSqrfMhjUgKro3Xdf66sJ6rvYUXCd6fUUEj/YLU2CZvzbpHt77DkuWmNvLaoTdSOi5X9E3D76aCpXqnBn044ALJIf3cmps5NQW2IlRk0k7vIZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbHDvMTl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e59dadebso4168140e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729349838; x=1729954638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGEqRhJUmb4osaTCwQDMCDlViFMb/3sNR+ti6VhsDbc=;
        b=UbHDvMTlUWzw+5vY1zsoW4DNmiO4JYaClOOMh7DGGQXz0aMfCSI9LKttcjgBIUMTUT
         xVQhch1CK5bgP2qUOlKeWMTi+RzjZNoJswq9qPt/mOQIlh4U3T9fIxEft7CEhlY78Z0u
         InCrmgqkoY0HIEvh6H8n9pjl1TDnJFHGp/ijhfDbvFEhYrNb10U6g3egiuweGEO/l6v8
         VcSgR/pCziFXjyrRWXI11GterkuYUgCR7Hc8nDgOi2nPfN9u5w0R67eaw6bprWrlf35z
         2jav2HZw3j9lsHmRG9k7sC+QisKeouSo9SZcntQ7eDnZ64Gw++d/u3sYY0Z/jPe75xaK
         Cdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349838; x=1729954638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGEqRhJUmb4osaTCwQDMCDlViFMb/3sNR+ti6VhsDbc=;
        b=M9/WEUNVoe+9oqkCcvh3geAWMYfs9qY9i1DTGzQVmzmf2z4RnzDV1auncGwHmuV4WA
         jqUnxq5SJJfP+xdBjHinUQcEL8tv1+UolNlRKfR6UAkG2rD6YCSrwUAKsFvf+t2vDdGK
         ZuTe3I0SPQm02y88mtmN2p9YQkoEsaIX7v1twaHAmg310rYo77oH664ohuDnht+VN8hD
         u/Q4VoWq3arGSJJPwr+VQfYuAqM/u2UJa58l2KRCwlMfsCOMFiGVY0TUGMJxqW/4LNqd
         54krLxOWTMcIegwC46iH3+SjY35cxwPcLZIav9pysg67EIcGnsVGyUPre+1ZI2/4ZYbX
         R29w==
X-Forwarded-Encrypted: i=1; AJvYcCXKDkeHkhr0zJNXakI6pJJ9kG3cD9uV4UXyWRkU5CMQcVvuX2WVMliugMGEssRQljJG5asainIohG4q9iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDduYIpsblYHkBJtyt5h0cmNVWgTW3S+xkYTGfhDsQhX/JxCu
	uvqgKz/Jk8VPfcy855i+EY+2vg4pWHAX6vaNfeJ2UjpEG0n7zf5m32QPDpPTxuI=
X-Google-Smtp-Source: AGHT+IFvSKPhzsDNaKPyeWXPDE+0C/KzNCTy5GJ2Heds43Isr1H269ujLKKeg+t7AlBJAH2ez0R7HQ==
X-Received: by 2002:a05:6512:3a82:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53a1522a891mr3518017e87.26.1729349837675;
        Sat, 19 Oct 2024 07:57:17 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214f1dsm551788e87.288.2024.10.19.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:57:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: stefan@agner.ch,
	alison.wang@nxp.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	Chen Ni <nichen@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/fsl-dcu: Remove redundant dev_err()
Date: Sat, 19 Oct 2024 17:57:09 +0300
Message-ID: <172934981950.2755496.11253073268427198025.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240918074841.2221210-1-nichen@iscas.ac.cn>
References: <20240918074841.2221210-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 18 Sep 2024 15:48:41 +0800, Chen Ni wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message in case of a
> failure.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/fsl-dcu: Remove redundant dev_err()
      commit: 4b173d34e35726d7727d3e5edc43bcab12654ab0

Best regards,
-- 
With best wishes
Dmitry


