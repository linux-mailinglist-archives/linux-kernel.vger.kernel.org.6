Return-Path: <linux-kernel+bounces-193087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42248D26AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D591C269EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD317B434;
	Tue, 28 May 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvNjbDOt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784C17B439
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930092; cv=none; b=LV/92Z/sgmrNEPVnZJY1nVugoz61VgExX4MgwI5I+oTzeR6FrHld61sFGl3rd/a2OPB5gT7Cfljvui8DQuXjP5h5oyaXtr0QqSwdI1HidcXswS3kZ2cUcIUUAHdbwml96jwraomK/7UJFbJLocuvlnMGiGm56ceSR5heWNxkU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930092; c=relaxed/simple;
	bh=dFCLNQqSTWphiztgbAFo/vT68qy4FL37V83s9T6fnpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DIlGrutCFc7C89myx3g/1KqSsrQ9ljILUPX50bf1j/fFtNgcFRWhBjsOeJ/U51/r33P8dXnHXeknZUBEYRQdPZppS81BrZ3A5pmolcShBBPxRNPJMmlR/0g+hdoaPorvMkYhos+N0Gkpa93U7Lh7XOmK0hlaQs9w3Y11+hftAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gvNjbDOt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47728fa4cso9280185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716930090; x=1717534890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kldUlHGlYelMN62LBMJjgiLYRVJsAWF6QEo1XLUDCEo=;
        b=gvNjbDOtA1b8iE4cyW0X5MLD640jQku7xN9qyZQ5CEUQ8yY0lHxksXTEcMshLc8rOM
         pzuuwwmolthBWxFioBzmHvRYiNxfDX9pCL2iucQGoe6MZIkoai3Wu3jqM16wCzDM0NQm
         pjn140NokIAc87sXLpmFY4ZvwYUkFGVXuEzvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930090; x=1717534890;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kldUlHGlYelMN62LBMJjgiLYRVJsAWF6QEo1XLUDCEo=;
        b=cK9OA5hkBddWEHSPu3fV4sbPJsO/FWhy98Jl1acGYvZXSvEO2EYU/Hk5SplH+FQGMu
         MTOZBwEQG0ry7xXaaZzQIkewCKD29Sv1ihLvM1BJUZlu2JxLOf4gJNitJGlkHePKIJ6b
         cvoRtiRCdf4EQtpBV/BzWX+kwb2qvFP6AH5kOBHV31cOajuIX6hVMS8AYR5IUnIR2bwG
         7QoaMafOg3jalW2h7fW5BKIK6LFlTMDeGx33ZIsxqcn4gJ7KbIBswyFZGd7DvxUlcS3X
         4HMmmEhLXr3jmz8KU/XpDHPUCHX2JPvZq1tVp51Ue4Fnu8w3yi8gQzNYPcAKR4dJltFP
         jWqA==
X-Gm-Message-State: AOJu0YwzIrTm1oGgnwdRqEP7Dd6aoTvBpu6I6dEzkIcnymAARi31ysbX
	dtlKqwR/EXKMFptgdzFrVRyppyX287qCPCAyRBacIk5AF4VlSLV2YMkWvXvKig==
X-Google-Smtp-Source: AGHT+IG0kNYVDsSVx+Xsf6GkcBdGPX/DHNTyq9JYFaso+nYgLEMtrbd/KFyjo1fC5f0hK7H3VKK7mQ==
X-Received: by 2002:a17:903:22cd:b0:1f3:7ba:db1f with SMTP id d9443c01a7336-1f448704932mr141299485ad.16.1716930090171;
        Tue, 28 May 2024 14:01:30 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8d59:feec:9939:40d7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f481d5a77bsm53167725ad.298.2024.05.28.14.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:01:29 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20240527095511.719825-2-treapking@chromium.org>
References: <20240527095511.719825-1-treapking@chromium.org>
 <20240527095511.719825-2-treapking@chromium.org>
Subject: Re: (subset) [PATCH 1/2] drm/panel-edp: Add support for several
 panels
Message-Id: <171693008901.3691502.12900282593868774684.b4-ty@chromium.org>
Date: Tue, 28 May 2024 14:01:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 27 May 2024 17:54:49 +0800, Pin-yen Lin wrote:
> Add support for the following models:
> AUO B140HTN02.0
> BOE NT116WHM-N21 V4.1
> BOE NT116WHM-N21
> 
> 

Applied, thanks!

[1/2] drm/panel-edp: Add support for several panels
      commit: e4f9fd9edbc22faceb4c9c57242440bb9e17924b

Best regards,
-- 
Douglas Anderson <dianders@chromium.org>


