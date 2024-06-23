Return-Path: <linux-kernel+bounces-225976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F19138A0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F7D281DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7A12EBE9;
	Sun, 23 Jun 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmXKlxnI"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D17E0F1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126861; cv=none; b=BMwjF5b5DiMzyCm4+gjGSbXHh2B+Mce2RyC7ydV5MhmMiZsoN30Ov1cU1chp9hrGdLog0NSn4sfMO+KnTTDgRKNABFAk/+e4ge65+HDpS4DmKSS9Ay8CKipbRsxFIROVDq0RI3C6blJwMVPgMlWMx3xuQssuEA4RL5EVtehmYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126861; c=relaxed/simple;
	bh=r1GyaNDuH0dnQOBTRqLdjX/f+vi1DRab71LLw2YZwc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9CfRxm15XQAgIdmogEDrTfaWOXSKKkvcvuOKEg7GuJD7ZaLokZBzOj4/eCeLzCrmoqN9ZqY0fqeZcKY8TfaFGuvolwvYu7tncSjGu5TyIU+D9uWwTy/boYlr3tqK2L20Pg5UpMkU2ihPPhbn4eho3BJ+tW1fEjhYmzRox7KQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmXKlxnI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so36386541fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719126858; x=1719731658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ao5ztXjHb4LHR9szDgOZeLEhmApDaFHqwxcIBuJSShc=;
        b=mmXKlxnIWBqpSTQ9wlBnkt+DjE8ztMPduPRSwjl/WAoZB+6m7sfUIJd3IyT3Iv470X
         b1VR6UiD19AkCru7JYmiynquRk8N7VB8ezsynFexkYu1l2jZGm0xblVIKAcF1imx6eDR
         B7Z2KJB8FsApgrOaHqKO0Zwa051S7xN9JwO8ZRKlK/+BYvZ/CpALOSp2gwzj0h5ziZOW
         MTDJbeUuJwevasfaUctoy0fhrG3NGkl0sXyzKVcYO4ljviMhxz6YPh5fqaiFYawLthcg
         2NNBZ1r0PihDP66FkGqj6iOfslMlriPCewl2PPApHlNDhhKMgr+6UfIj6BH3ONDxv7oS
         4UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126858; x=1719731658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ao5ztXjHb4LHR9szDgOZeLEhmApDaFHqwxcIBuJSShc=;
        b=aDJ15dWoYhzDn7jvRrYZJSUoWESQyt38ZH0+1Lb7z7vXUE8JVsvjdI8n/RLjyH0iHj
         U7aT75ouYsZ7ETgZLeo33dYuUKgzWQ4O6JeC+pwjG5i58sSk74PKHAKcZQHo6yoS1t9w
         M9Kuq6lqnKQ7rnC+Nq+VkIEWfL5ejbs8qNpGzhpoQcmuLSS8tHcqh+UL46NL52tx7WmP
         iNLflgx8loyL0Kfo6jYmgiz/reXZQ0vERKAPe7kaWPRy8EOt8Jin5umekYn/KAK0VD8e
         zuxK0RvfkfpqYRecRyGh31NCDhdk/wJ+0JJD9eNuYNsfhNcpO6NrZbJci1+m+/1BahRw
         vNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnFJ7dMRoxq8Sjy4LC5mPlYpqvdPqII9cMsr19znzVKxyUkrJrVAg1vmqtku2se7QbpljzZveTYOmUjdmYHU76RfvEIrbQsGRcBroU
X-Gm-Message-State: AOJu0YzMfX1VA2/aesmDRWQB7WKf9l7Th3vvHBtsk80L2tQBYjf8PY/G
	flvWzm/+tBF986x1fCdtv0K2X9ENCWa7Yz4pn3jCff0rxZE3UpwR/XheTPB8jDo=
X-Google-Smtp-Source: AGHT+IGMrZ7Ab2hTrpfNCjoKkdN8iqLOosYDf5URywhJ9jd+sUequOrm6k6sz1yM2oRGbSPu4UNvIQ==
X-Received: by 2002:a2e:9dd8:0:b0:2ec:4aac:8fd4 with SMTP id 38308e7fff4ca-2ec5930fde5mr14912791fa.1.1719126858199;
        Sun, 23 Jun 2024 00:14:18 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5b031208sm1886861fa.26.2024.06.23.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:14:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: guard ctl irq callback register/unregister
Date: Sun, 23 Jun 2024 10:14:11 +0300
Message-Id: <171912674292.840248.16492908228445159189.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509-ctl_irq-v1-1-9433f2da9dc7@gmail.com>
References: <20240509-ctl_irq-v1-1-9433f2da9dc7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 09 May 2024 19:52:04 +0200, Barnabás Czémán wrote:
> CTLs on older qualcomm SOCs like msm8953 and msm8996 has not got interrupts,
> so better to skip CTL irq callback register/unregister
> make dpu_ctl_cfg be able to define without intr_start.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: guard ctl irq callback register/unregister
      https://gitlab.freedesktop.org/lumag/msm/-/commit/29cd76c6f897

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

