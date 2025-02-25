Return-Path: <linux-kernel+bounces-531056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4CA43BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E1419C3126
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614F1DE2DB;
	Tue, 25 Feb 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvzLLHQn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E128F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479140; cv=none; b=MK4UwkkWL5Or5hjASUQWwKKmjMmyJ4YNiuO0WMkf+7bhpikXTZ0Pt/s8+QLXpCHqj1QUNwY8XPJdKLOv33NibKYXZjrHIHNYw5HJgqe9h4YZAGgBfbbasOl11RsXyGZ54n3CJKkAvD8hlyGJDeMUEW2Omz2f3XNnUjphZbV83mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479140; c=relaxed/simple;
	bh=kNBBvWDeoRWGqZSfXy+GsUwdXrTQ31SUtMih+o/gPMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PSVCTH/SpXWlcBOqFsK0nyjXmfpmMb36cg6PBPiIEs7uE2NSJDWJwJIW5VUonsBpAeNjNaKQg2V+qwkPLofTaydhiU2FHTk0RpvGsxRd1s5PWS0L24uaEPZ9en5n7IhwEU/LUoQu4fw+6t86OoLK+qWWTLPimLL1Mog1jb6eS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KvzLLHQn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so51355545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740479137; x=1741083937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO8Oylg6YjBoTtqrf0241KPt/pqvJPTWmEtRbVr3k2w=;
        b=KvzLLHQnqTtyxZCvPdpL4QGmFkpKc190YXmJOzIQGRQ//r1LR2sUYjZ4sec7Jl4jyE
         jyNPgwl0uEqvwPq18ripfRGABKuSjHzLepcVMplq2m543evLAmsHV91JPn+oQcw2khMY
         lLhBEyvH5EsqUtQ1XKO/8Uk1PBGqog3wyZVFBm+7YPjk0MxTRoWZGWqxHi2wXCMFJsfK
         KeBXhi00oEAmSzzSQ59Sq3t6W2CTfLhHyIOThucIsI7/AzVspucQMEVB+YieKsAnBQPO
         o+CEoqmSgTEcIilWeFGi6FVgx43ulxCkjgSfbR1unOUk1VMQp0DeXhd4pMT+Bbb5fdtx
         Anzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479137; x=1741083937;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO8Oylg6YjBoTtqrf0241KPt/pqvJPTWmEtRbVr3k2w=;
        b=l88Ow/6uG/yj4mWqGg/Q+2VuipG7wefkTMSaoBAhIfkHQCCJsHT3zJAQ2a5SY2U6Yx
         e3XlqyVseCELqTh3df/v7va/3FQo0cv/RT22QcJFNXn2lzMSeWgBBRKlVcI4b49YJqAW
         YfXhfe2Dn/9HvgcnAbHFSAurCkIetvZpU1qI22ebQbwExYYFWbf1liSc7FCKdIvR1HDd
         WDAWOZ2zOC7Wx/r4LnTZ6+OhpAkwuksujXPQqGExDj+w3sopf9lM9j5ALlJDZBOWp4bO
         vGQ3vK7i2VqBhtr12Vy6EFKIYiKGM/u7ItqBat0Bq42nSa5oi0dEQewgVo5lWhShN59E
         9B2A==
X-Forwarded-Encrypted: i=1; AJvYcCXPiQmHdftYNEMCZuuSyq/mp6Meb2yRcBYbYOfVVXyfqe2370LpHiSr6qWztQaZrG0PnPIITLSyuc8nZaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SNW7/F41UvEUIlPYp2gA4+XXWQVQ+AqtbtS30X4aECttV+g9
	cGgkSXXbhiR69/RdATqrh3I/+0KMczZtBUg7q8BDFPjYLbv/NuRPY+Sv+OTOAeY=
X-Gm-Gg: ASbGncuf/5q5E2NvBoplEXkpm/6vtjdzhrAJAE2HNWUW6/69fkZgVh8FPVkh7mUCWEH
	guSQDZlmHwoABTqvqeeAgcKDmopdVC3txhjmV4v36zUp0TGKYqwd8xLdZpl/MJZsAKhq9B8PKUW
	FZBkZdt5pcJkVrlvxvpUEJmTDw5DzjP7DOJAb17fSYDx+B6vA28S0t2fxbFsspFqhTQwzho1f7H
	Fl5jmye6KVBFC0D+gaHFoiWZ3eEf6oyJwaTj/0k0JS7qmR6uyS1mPTsGAjeeTW7S4weu+h1Euor
	UbjpsChzaMtlwGMKthrSfaQlt1/RJXnTnXflEk9vfwpNXDU=
X-Google-Smtp-Source: AGHT+IFBoBkLT3A0xWLdkZ30bRcxu5mltnumWdHZho2ezloRlAbVC4RMnE9SJiNp+9to2P/dJV/T1w==
X-Received: by 2002:a05:600c:1910:b0:439:98f6:8bc8 with SMTP id 5b1f17b1804b1-439aebcf61dmr127211825e9.26.1740479137175;
        Tue, 25 Feb 2025 02:25:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86707asm1764378f8f.5.2025.02.25.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:25:36 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: quic_jesszhan@quicinc.com, dianders@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250220045721.145905-1-tejasvipin76@gmail.com>
References: <20250220045721.145905-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH v2] drm/mipi-dsi: extend "multi" functions and use them
 in sony-td4353-jdi
Message-Id: <174047913628.2131221.5126510455783898165.b4-ty@linaro.org>
Date: Tue, 25 Feb 2025 11:25:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 20 Feb 2025 10:27:21 +0530, Tejas Vipin wrote:
> Removes mipi_dsi_dcs_set_tear_off and replaces it with a
> multi version as after replacing it in sony-td4353-jdi, it doesn't
> appear anywhere else. sony-td4353-jdi is converted to use multi style
> functions, including mipi_dsi_dcs_set_tear_off_multi.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/mipi-dsi: extend "multi" functions and use them in sony-td4353-jdi
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fb13d3497bdcf4f544be25f716b6bdf1a4f8e63a

-- 
Neil


