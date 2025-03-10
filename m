Return-Path: <linux-kernel+bounces-553995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AEA591A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE253AA179
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26672228CB8;
	Mon, 10 Mar 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfpf2Ycf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686B226D03
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603630; cv=none; b=hmSp+EH7P53WY7QkYmMNz/vjtbhj3nkFfHF9ryf6Fuv+nS/p22kaG/T+ia6/adSDs1vT4fNnVpcurg3StKGaXhzK4aTGi+fo9IxjdOYISagJCdq8KT4cNoJ5YJkSg47BpPzISgN+ykEm40v3YR9SnIaZnHlM2TnSzEb4Wu+5O/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603630; c=relaxed/simple;
	bh=/XxoIMfAipEC21vhmED/mbxFc1B/+YiyisaMqIYoFhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QTJTvqRgDxx6wdaFRgiHjMiI4a3YDyGNGcCt8h5rhM68CEx0XivFGNT9WX9lhxlhw+xndZWOpQMQrDkN2ZULtkbBDk6mUJb3BpoOJGE9U1qaRkVKv7iGw1/X5s2BZhP1zumYEezJbs9pzBSYk+T8VlKJyotErH+4ES9FBoiPrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mfpf2Ycf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso7535405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603627; x=1742208427; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxe2UdMnuICWXIR/40yTHRWRgSj119FGmCYLgFhERXk=;
        b=mfpf2Ycf50Q86FMyR//PXr8vgQzPaysv5Fl1Uvbn6nKTzT0chNwJckKN5AS3Gz6UX4
         F4k3lwLMvHzvZeudG83vwYgEdi0C9piiN1Y5kUSuK9mzqq8cdkwT5+u+UoRxFB4cN9qg
         9mOvAaK4VnYA/ogwXZetucF9Bos9vKWwUrPYnKwsYVIqJ8OAggnIndpuKgZBUcIzrqqx
         FDMui0aWAgtCvDH65d1ZC6WpObbIfCU1duafRT5xBX5UPcKXnrrTPJ32ElDs5bpDPPUh
         gdEA07lIj0c3eWYjNAoxmEgRMk4I2atetK0Vch/oh1/89foZMFBb49iijT1wTatHNPmo
         eF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603627; x=1742208427;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxe2UdMnuICWXIR/40yTHRWRgSj119FGmCYLgFhERXk=;
        b=v4x0ropnrx+8iMSs6iXT2vIWH4r0YH9CkhlI70wWjIQuydP6j0p0ObwwiKwNu1RXmG
         tPk5+GTNr9i3sJHev+3gQ0yeLaQEKTIRC5y7CwKBOZrB7+hpm0enly38k2Ix6q1QOPiB
         rFqv1W1e/qAXpU/PPvKwo5B5+ROkt9dW8fEBvLaMTEprIbTw+VuHnc9i7xnqEExRVUmb
         RZsb4rU2/myFpDOsq/Jy1iHsxVU1CLO/Da3GkbLnhWpAKTExD8ARaLpOtBeWE5+WCgxY
         9Lo9sP1AILfVWs6Qqrgenq94koAT34eur0o24+tLhkhIrkmNP4F8/JCxz6L/XfoON1t5
         pXxw==
X-Forwarded-Encrypted: i=1; AJvYcCXLEbgSbTUBDLMhdX5WVqYZMaUtOEN6jHO6zCswB9Zh2ObmpVxRQXwwSWXdlO3NxChmf9Y5gX56tVryICs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp338KXfOJgVwAsFiqb6lgEVI+N9G3/NJyTzGtAj83R8wAzXyv
	CS8XX8CdELSX+M7m3vxvF48bCVzPCEwY0mF4RXkNSoaR62cly13qxcLiHOErUG4=
X-Gm-Gg: ASbGncuOMxR6pKDrtqgLB5L8DI8lhVqChTIga3Qs/g5awRMmt3gVGCC7C0INuwxjkQF
	pWPSwyAYl/HnOrFXCikCkJdBam75NeELq8Bay6kSENU/4S2fR35uUd8n8toon9BqybSbwsdOtP9
	l+V1h/V/OEEDKqEnmhN7bidMGhK1YuwfadbpS6ONoxCYXovRTVvZReJ2Wt7rGAF7/L9fpRl/VXw
	41Cp56nU5y6MoPWIsDoBE69C/TP3d++hgOnp7OEgiS8u46nPZSCCjamazQYjgj7wL+nht9scdla
	5VR18W7jSWzURwSAmNf2hvZRxqnmpQonq+BAVKD+tUPVSv0IJg==
X-Google-Smtp-Source: AGHT+IHZYEMjLRapPZhjVBke2kOIMDf3xY9p9R2H2E6KyfQ0Ja2SOjNPA2cXqXY6FK9cu+NqkjeCfw==
X-Received: by 2002:a05:600c:474c:b0:439:9b19:9e2d with SMTP id 5b1f17b1804b1-43c601e1393mr91960565e9.16.1741603626942;
        Mon, 10 Mar 2025 03:47:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8dad73sm142867745e9.19.2025.03.10.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:47:06 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:47:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
	"Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu/gfx: delete stray tabs
Message-ID: <92b9d527-fa20-4e4d-a4ce-7c442df9df0e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These lines are indented one tab too far.  Delete the extra tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cb..984e6ff6e463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2002,8 +2002,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		if (adev->kfd.init_complete) {
 			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
 			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
-				amdgpu_amdkfd_start_sched(adev, idx);
-				adev->gfx.kfd_sch_inactive[idx] = false;
+			amdgpu_amdkfd_start_sched(adev, idx);
+			adev->gfx.kfd_sch_inactive[idx] = false;
 		}
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
-- 
2.47.2


