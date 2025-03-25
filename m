Return-Path: <linux-kernel+bounces-576162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20CBA70BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F31170720
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6A265CD4;
	Tue, 25 Mar 2025 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjxP+XDE"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5B22B8B2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936758; cv=none; b=UBjKE2cXjVwVvPke3GpYksp9s8vIiORoUIPynbDSrnKtWY8RqpWH5CNliptTILT730ANI4rpoY6l1iEwIrI3H5GrDjECkXRYgxIZi4tLGqJLE0ozNZHTRaTPsseC5X0FBG3CpFBlJIEzH4YDBvfJtNixTCYghfH1mAZHEq/6Sb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936758; c=relaxed/simple;
	bh=yKk7n8EsWZV63ibKp+piD2I20KUH3GoFh/b3CibhwP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atV9zdbQ/FewkCrv0zYpqjXBXbDnsATQInzbLGq456HkUEz0sY+3XsN+E8XmhxlOO9hRHa31vLJ+iGcM+XImha/9InGSvzkrNiRFN1XIQVAGZ4R/4hxkOy1lG7qdkMIz3DqDW4lHcwgD3gqDTsHOIkortRZuDKaH+rbInfnY+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjxP+XDE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47663aeff1bso59191451cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742936756; x=1743541556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsZUEX6wOy6oNbIIbrt2jTVI/9CJN/g654c1cd4p7VQ=;
        b=HjxP+XDEDw0Hd9DCHHP1Jyzvx9rYhGkk3fN8AN1t4sV0EnEUswMbKyQWvciyAJ1l7q
         p8tVNBpLwtQtBuZM74AA2yLqATpCVypFd/PUZEFHjYjBt352FLC5BVqwuVqUhNSOfLtf
         vP30wlXHVeBtM2R/zulDv2OjUiQJVUba0+k7oo+CdfrTo/odwF+QHpQXGbb32kTOoJSl
         fCQ3wn3o/fIgsWFOojZ694AYkaGANYUIDxI5oMuYkvA1hbDlG0A/rSh/PIiJCVLYDSvU
         EV8geby+GWzeni+ISkzhr14W6oGEJLTpbhNoicGUC4LCtQWRCS+gwT2Fiw2KFLAwp53k
         QOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742936756; x=1743541556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsZUEX6wOy6oNbIIbrt2jTVI/9CJN/g654c1cd4p7VQ=;
        b=YK28XbblVqiLhtL3HEFDC24bDrmLKSUABcfeozT4RQ4b7jiOSopjTxZ7hia0dFU+Zr
         vmlVD8d0CZn/lUbkAt7WjKJw/wPocpf/wsovUr2FPlYUB9B6YYmzxTrOR4W562PxT8Lw
         gjwRvgB1VxmaVnli/cWpONAr12/sIaVsxL2vEHbf/uULz6v7dFPP3o1p93EZKEfOx1OD
         epCKRHoJ9uszRx/7TXL5TOwP6nzof13OOdkvMeGWUsitSjP492WO8vWhteqGmpMLuScw
         bijXyAAOsiae17UFjqw81qxgfYEhmkJYiNeqyRguUVO9b2DUSuz7EiuTLD+ApYOwZkYv
         7iZw==
X-Forwarded-Encrypted: i=1; AJvYcCV7n9AYLw81J+NxK8c7GmLlN5gQNqeKbotRwo0NV+YLLjrrH7B909oLiYJeojlcGVbQfIgY/8df+UuVYWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEzmj9df3TJFNRfmXt6isF8P5JHLGkJ7ANIJkUDeW//LsPlIL
	nXRKqja1dmybzqpf0idiPIA2kHIluk2vXewHSuH2G1U1AFQMbKVT
X-Gm-Gg: ASbGncuPVL0qLi4h8ZdhkZTazu+9AXcBepBJpRZhz6uZfJ64rCJ4o7se2wlnKOzFZwy
	8P0VQNumLmamesRoMMafCr9iw/C4y3nZirZibdsH0J78fbS0o8Sm5q3QX6Li2HJFr56dwonMhx9
	bvGCOcKN7Nq5xO8Q1BLD2WcXXryTdT3/1nGiUBWVaygdDzRKjbv+Yb1WYrWk8xcp0rQ/+ohCwrQ
	BX4tuROlyxTIkz0XboLKrcxzlULwiCLDF+ONFbGehPwgX+0EuAYF4wgQBQEn/LeBNaiscuviori
	XV6WQXdF1y45azILuYbDgMqNACG9O6oMZWWLypWACCUMhHgnZxrNR5XF9msumnDkc6t38SWWnJ2
	lXIYa/mz+B2pQAbhA9Y8=
X-Google-Smtp-Source: AGHT+IFpyLimJwylrCJjqs6ZcD29FiNH3Oc74veEai7LzC7yBUf1JyPuGEmZ9XzojoxaLSq9jn8TIw==
X-Received: by 2002:a05:622a:4c8a:b0:476:838c:b0ce with SMTP id d75a77b69052e-4771dd779eemr396540701cf.13.1742936755874;
        Tue, 25 Mar 2025 14:05:55 -0700 (PDT)
Received: from localhost.localdomain (c-68-55-107-1.hsd1.mi.comcast.net. [68.55.107.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51ffb4sm63484481cf.53.2025.03.25.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:05:55 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH] drm/amdgpu: use static ids for ACP platform devs
Date: Tue, 25 Mar 2025 17:05:17 -0400
Message-ID: <20250325210517.2097188-1-bradynorander@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mfd_add_hotplug_devices() assigns child platform devices with
PLATFORM_DEVID_AUTO, but the ACP machine drivers expect the platform
device names to never change. Use mfd_add_devices() instead and give
each cell a unique id.

Signed-off-by: Brady Norander <bradynorander@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index deb0785350e8..9c657637d317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -302,17 +302,19 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->acp.acp_res[2].end = adev->acp.acp_res[2].start;
 
 		adev->acp.acp_cell[0].name = "acp_audio_dma";
+		adev->acp.acp_cell[0].id = 0;
 		adev->acp.acp_cell[0].num_resources = 3;
 		adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
 		adev->acp.acp_cell[0].platform_data = &adev->asic_type;
 		adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
 
 		adev->acp.acp_cell[1].name = "designware-i2s";
+		adev->acp.acp_cell[1].id = 1;
 		adev->acp.acp_cell[1].num_resources = 1;
 		adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
 		adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
 		adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
-		r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, 2);
+		r = mfd_add_devices(adev->acp.parent, 0, adev->acp.acp_cell, 2, NULL, 0, NULL);
 		if (r)
 			goto failure;
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
@@ -410,30 +412,34 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->acp.acp_res[4].end = adev->acp.acp_res[4].start;
 
 		adev->acp.acp_cell[0].name = "acp_audio_dma";
+		adev->acp.acp_cell[0].id = 0;
 		adev->acp.acp_cell[0].num_resources = 5;
 		adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
 		adev->acp.acp_cell[0].platform_data = &adev->asic_type;
 		adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
 
 		adev->acp.acp_cell[1].name = "designware-i2s";
+		adev->acp.acp_cell[1].id = 1;
 		adev->acp.acp_cell[1].num_resources = 1;
 		adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
 		adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
 		adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
 
 		adev->acp.acp_cell[2].name = "designware-i2s";
+		adev->acp.acp_cell[2].id = 2;
 		adev->acp.acp_cell[2].num_resources = 1;
 		adev->acp.acp_cell[2].resources = &adev->acp.acp_res[2];
 		adev->acp.acp_cell[2].platform_data = &i2s_pdata[1];
 		adev->acp.acp_cell[2].pdata_size = sizeof(struct i2s_platform_data);
 
 		adev->acp.acp_cell[3].name = "designware-i2s";
+		adev->acp.acp_cell[3].id = 3;
 		adev->acp.acp_cell[3].num_resources = 1;
 		adev->acp.acp_cell[3].resources = &adev->acp.acp_res[3];
 		adev->acp.acp_cell[3].platform_data = &i2s_pdata[2];
 		adev->acp.acp_cell[3].pdata_size = sizeof(struct i2s_platform_data);
 
-		r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, ACP_DEVS);
+		r = mfd_add_devices(adev->acp.parent, 0, adev->acp.acp_cell, ACP_DEVS, NULL, 0, NULL);
 		if (r)
 			goto failure;
 
-- 
2.48.1


