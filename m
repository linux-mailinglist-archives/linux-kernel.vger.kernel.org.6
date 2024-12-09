Return-Path: <linux-kernel+bounces-437099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4F9E8F26
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A16D1884D75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A862163AB;
	Mon,  9 Dec 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JNhvSLH3"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737F215F60
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737770; cv=none; b=PrKggpGeNTwIcZ6YOyPrurLa/XiSBUJlOVzQnUt8eWmKSMOiQgdjjQTaP1Yr6y6v/vpuo+nUrgunzrBvghiDF56kdz0Moj1uW7du3LkEokgtEHDPp1gm+8XF/cGG+ZGKtxpIMlxr+ChYNMfXlebd9ClOAWsx1Gru5y3j4N8IPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737770; c=relaxed/simple;
	bh=vtzyGlW/khfK1HakE0DMVBSf8t7RHYNcSIPv2NOiti4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpM6mRxq642hPstOOA8cqEnR7BFaxS05wasHy8r3BLCM8cm7XSKM1nPMUeZvaWEcgpPXURgngex/CT2pI+YokAZuGD/nW5hYI24BAVsRSZKLV8gR9t1c7wtFJEZUNiZKd/AnSj+eEoX+4V+km0v+gWohppB2rC70otkFIZU7OHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JNhvSLH3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6d23b1449so84923185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733737768; x=1734342568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EDuUMhlmnYK+wM/JuvYjnlnvtaYqlg7DBKQ07VIjqs=;
        b=JNhvSLH3wBaa72a3cebfMZRcJx3c9IAQPEgy+rqTqsIHPrCHocMMLEntdOHfLvAJD6
         NjQOIdARLSblWw8H1ilhCYHd8oUiK5egilGsZOX3KyX22x3jKoj2OBEovKdSOI8YXZdm
         mTiLoIuJp1M+WBBh96RyismGVsCfJDqb4Vx+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737768; x=1734342568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EDuUMhlmnYK+wM/JuvYjnlnvtaYqlg7DBKQ07VIjqs=;
        b=j+34kyY+inAsCzQNyVkzWrGwcFAA+ZphAwAsfPkkApl5+kBtbvjJ91O4wPXWetU+AL
         wmoenu103LF1SlK16YpqWqQPvFHWK0HxJf4frx2PDT/NPVZ+zzsrPt5eyLWgLkqjGZIX
         7yl1piBThwcB6KzQjerAmtGKSotsO1Qpzi8nNBFojQRK1GN7l4ZGgoXgYUSrCSotLpes
         rscLg2t/zr0lMeEmSmsuZxbYipy4Hx+AWn1PTakPPqtGdOWU7xRC0wqhDCuR5CI6aoHH
         f5dPNRWirhc9uam2ng1n214NLlbXn1IS3jzagpoPqnyHGUVCzagsYZ+uGPMQBcSG32IY
         igQA==
X-Forwarded-Encrypted: i=1; AJvYcCXuIm1oy7zQn32lJFQIz2sCPaDnTuze8d8uRB/RCUKeBrj/1LRbuzh5qU8SyZGoao5BY7d6dnlqfvZhOTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXRO+0uat0EUXd59klfNs5RSbku0T20l7NxV8f1PG3yOvwRAg
	6heYHejkxDiGSX4B6dIpOVJGpPf6e+9sqSvSesU9jjkZ/YYy96BX9Fv3GMMV4A==
X-Gm-Gg: ASbGncsxiXCR5FkCMZe/rwQ0laUaesbwrrWldNrEY196vSD68laCtdOwcm7/Jg/M1LG
	WnL/p+9RpF1SF76KF2A8oe7oRvkDRl91V/dFwtXlM950722zMDp/jlhIjyx1OapYaE1bNsdgua0
	Kwx+IxECkYGLPJQP5P4VC8aDqWWYI9yDI0cOhEx9MPazuwUjP5s0OcP+n8VigQ2WA6nACVoFhoP
	ZQS3lusnwJBlLcM5bzjmeeQiPosZCPbI3F+8i+QqEXPTzsDr6cic3eRi/p+cgl8O9LIRpVDqTjh
	/ck=
X-Google-Smtp-Source: AGHT+IGDirteSvb5DALYHWHfiDyNjzV8hd+4Qsw6aBhUE7dWDiM8ElQadmrnt8I6rCPmsaGeC+aonQ==
X-Received: by 2002:a05:620a:454e:b0:7b6:6e7c:8efd with SMTP id af79cd13be357-7b6bcb982dcmr1967606585a.58.1733737767733;
        Mon, 09 Dec 2024 01:49:27 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d2147ff2sm128409085a.70.2024.12.09.01.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:49:26 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: zack.rusin@broadcom.com,
	thomas.hellstrom@linux.intel.com,
	christian.koenig@amd.com,
	ray.huang@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH v6.1.y 0/2] drm/ttm: fixes for vmwgfx when SEV enabled
Date: Mon,  9 Dec 2024 09:49:02 +0000
Message-Id: <20241209094904.2547579-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm/ttm patches for v6.1.y to fix vmwgfx when SEV enabled.

Zack Rusin (2):
  drm/ttm: Make sure the mapped tt pages are decrypted when needed
  drm/ttm: Print the memory decryption status just once

 drivers/gpu/drm/ttm/ttm_bo_util.c | 13 +++++++++++--
 drivers/gpu/drm/ttm/ttm_tt.c      | 12 ++++++++++++
 include/drm/ttm/ttm_tt.h          |  7 +++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.39.4


