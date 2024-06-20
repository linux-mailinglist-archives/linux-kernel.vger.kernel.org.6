Return-Path: <linux-kernel+bounces-222303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C790FF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A221C20F55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841A1AB356;
	Thu, 20 Jun 2024 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ce4Gp5nN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BE2139D7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873378; cv=none; b=qctvDcN4Kx4wcAOKm/lEElPD5xVYYPyBGlAkc8oVZTAki4VuF7jLxCfIB6uYG0vfaFpDxRgK6m+qfxMALLZIA1yljUbemzf2I85p5QHI+/D6EQueDY5saLynkFnITc8w6m+uFX49ivIzz2wuEm/16EAB8WaoQ0UTXLDyeGmkVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873378; c=relaxed/simple;
	bh=KosNXeh15nXHkmwNcQhO6+BAaPr7YVQjhfKuYz8HdH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=irABuvIC2beWLfZc+3VlVWq7bBMtgaJylMEoeRtkbxV+soX3a7uJG1we+6UbygUrENCFx2TAqRLGoZjRd9wN/SLdT152g1zdVlRWSeRD7eujazGpg2MO74wygxoCRqZgRObrJZugngrd8JBCpJztAx2Qka18V8n9GBvnuglejvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ce4Gp5nN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6fbe639a76so103019566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718873375; x=1719478175; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vplqWI8cKIJ52zF1aYYCsDVAV72MV1EuoajGM0seqQU=;
        b=ce4Gp5nNou42DDHE4vJgK9vsAaUWsKEamhNtSHFfmSkQxHmDXXM2fuIS0KrW04jMZJ
         2kFT0rS7Eh4H8DlttqHSIG+p3GzrN/t1AiBq0zCSC73ew6n8lJ9mmSSQflkqFIOXjbGw
         Mqw5mmFK82NydxnrzqvwoBpQadbHF9UNO0XvJvmbluVvkTcuFeGLsQnr+9I+/9xHT8OY
         ZaXBO+D6iDt8isUZCQHi3P7vY8t8fHemNIq8UC1H5Sr0s2usorrjC0IjK8p82W7Ai8Fd
         SHYz5kbhQsITYpwJkxQoBCGitUi2gMJQh7saZ+bybq5Gf8D2NbMM643/vTGoRFLUGevw
         rPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873375; x=1719478175;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vplqWI8cKIJ52zF1aYYCsDVAV72MV1EuoajGM0seqQU=;
        b=bz8opEBoYfjy0iK74xWGoQvTLphuiCwaPTkseVHcsee6F3G0bHV3yuMimzd5GHHIx1
         7FemOOSkijrw8cq+ne3mFl/cAk2QCYRNMcu45Wy+VDxRSMUNdcM4k7GFt1aT27219Nts
         WWY0qNS2JGM+p9XL5nu3OJsA9mF8tnr2KbDZAFE8LZ6Nnx/2Os3eUzqquHgWxShsKFIC
         UyzVJFVsYIxwR2s29s0Am84WExZE775J7zeqflt9Cb13CrU90dSBVwXAFkvx4rpEdSdX
         8lguFUpBO1lvD4/hxRhMDTU53Jeko+dtJRZCsrKkUM/OROPCaGNfWnV6oeYop2rKRd9V
         bdgA==
X-Forwarded-Encrypted: i=1; AJvYcCXy15XHC1yunesx+qBxFOAcnMbMi5T2lCaWFzL9ZsqDazLY6NQDfc2iWozPun4mvdRJSIKmP9NDGWO7qGF4czr2Pg+g08+GW2RNK6Kr
X-Gm-Message-State: AOJu0Yzw3ZwfNKyD4XMMAgh0fvwMdQs7bIvyoyD5a3638myzvrk53GYW
	epnGR8d0/t3wZXQMcpkgwPnVdP5f7KCdIvGpeDbY6DBqTFT53scgR7R0Cl5jJVQ=
X-Google-Smtp-Source: AGHT+IF0HJWu5+9qrzpdj+2IohqmI65R3iM9YQiZqQ/II9cNRx507OWzSUKesTfdkh9pqQPDzJtJrg==
X-Received: by 2002:a17:906:3643:b0:a6f:6bad:b5a9 with SMTP id a640c23a62f3a-a6f94c047c4mr519564166b.7.1718873374898;
        Thu, 20 Jun 2024 01:49:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed0ea4sm741387066b.116.2024.06.20.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:49:34 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:49:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu/kfd: Add unlock() on error path to add_queue_mes()
Message-ID: <10510733-a59a-4419-afb5-e75fdd802794@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently added locking to add_queue_mes() but this error path was
overlooked.  Add an unlock to the error path.

Fixes: 1802b042a343 ("drm/amdgpu/kfd: remove is_hws_hang and is_resetting")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d2fceb6f9802..4f48507418d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -230,6 +230,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (queue_type < 0) {
 		dev_err(adev->dev, "Queue type not supported with MES, queue:%d\n",
 			q->properties.type);
+		up_read(&adev->reset_domain->sem);
 		return -EINVAL;
 	}
 	queue_input.queue_type = (uint32_t)queue_type;
-- 
2.43.0


