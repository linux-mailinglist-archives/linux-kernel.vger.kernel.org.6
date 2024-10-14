Return-Path: <linux-kernel+bounces-364394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B626C99D40F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0501F23D09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6B1C75E1;
	Mon, 14 Oct 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imnPdGY2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C271AE003;
	Mon, 14 Oct 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921407; cv=none; b=nng13ycmDroxwsZWPhYQPbx05AHukAe4q3DZidzNjg9Q8rNV3Gxg/Reu43Z1C+mL/vjYMpJ16/+P69BMS94AhEgChqwjKD9T0UUH2TcycP6kdbo6tXZ48fdYAY4Nwb62AI+JjpopVVGiMcEp90gvmCpF7X4izzOKSPTKFzsXK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921407; c=relaxed/simple;
	bh=rqXc6fyOltvPCgLCFD6B5dtBrlvYiHlGPOFu9tW9ZZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj9AbhKGwma6PRll0uoSI/cYf5f/66/fg6eembuAivp5W5bd2ngZfIIEnI+yrsVQNcuwaUiZqRZr+eQDvBc1O4UTMMLBj350PXIMwh7eoEzHmLqM/uozUrZISb7WoizdKdvHCLZNgYKuaXtPT8k7gtLqJT9USUENvg+9DaTzM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imnPdGY2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c83c2e967so3902395ad.1;
        Mon, 14 Oct 2024 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921405; x=1729526205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYoVIABn4CfMVzC05ot9VPzHnU0uWzbqn86J+fpUo00=;
        b=imnPdGY2xVE5mNLLtb/EGl6hUqpjBSuP8Ewl1Z4jOJ8Q6Zwo8AdNRLRpahVqEg7Ar9
         LfFUHW9E6ZSjTZTZESx9lD3mPS1r+vJ1jojDSKh/yWm1eMFKf9phTjJbWSK7ddn18Idj
         Hy01qSg2rttucjV1IELWFwV6pT1uDhYZUKwuekvEWkShJsU5tMRP+PbKRjtUaIz+mnE1
         uf2wykzweSDeMem+Z7eNWSJpFdOZnW980H6c54O96KC4pMfvbLK0xI/SAKicEpuJWGTX
         rxV3cwCSWxOoWcCeoibUb+0ac+joRjiaUgdOjUsJR0+dZj3c9gImMxru2MeBAVzCv1rv
         so0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921405; x=1729526205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYoVIABn4CfMVzC05ot9VPzHnU0uWzbqn86J+fpUo00=;
        b=VUiWkAZ6LHDz/bt0uiXnwcISWht1/Gd5eXZ2rvWc886FqCDBKAa43kgnUYd31mQLxJ
         2OQZvybHYzZRoHNOYDKNmWFdV0AY4DDkI0DQ5Qnkey/xrIOwYUaLj0AGYYnciXqh9V5Y
         +nshdLyykAjp5MJOCDIJ/RTOFnIk4NVeiqceXzPo8zwGHUnpH+bLCIHxcs35bmg+IdEx
         Pm1ULRWDEMgFO5dT3uKz8QUfwygH89+AmzLhsfQQ4ZKQ/u2Y9USExXLDrLYqygO3OTRR
         4knXNouWEbCcUfB7lw2iAVdWNV2JYuFprADhlH51SHGePfojLh+jK5tL0YmvrpIYAhEa
         +hcw==
X-Forwarded-Encrypted: i=1; AJvYcCVa6eTKP+jn2evb5UA2QnN6/rE/2kaMl3FzP5slvXM3Ar7qRt/5bLqGvnTgZbwLCpSLzuPveGYkm3g9+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcS/FRXUMXCsvsj1iWEXS2QA/Sb6WhNImqH5znIdhA0oS3dfz
	MJhzNcMTO8+4J0pN33tLyDf4eeladeVfp43gfv1X7Ip4O0W5otwE
X-Google-Smtp-Source: AGHT+IFskhEcFR/PxY+4n2w18ADFWgBXv18TFgk4jdEKLKDlaTmrZfTpcmWqJ7BmvI+ZPYVSUqHlAw==
X-Received: by 2002:a17:902:d4c8:b0:20c:d8d8:226f with SMTP id d9443c01a7336-20cd8d823ffmr33061835ad.12.1728921405329;
        Mon, 14 Oct 2024 08:56:45 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d00363205sm11168485ad.53.2024.10.14.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:56:44 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zpenya1314@gmail.com,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev
Subject: [PATCH v5 3/3] Docs/zh_CN: Fix the pfn calculation error in page_tables.rst
Date: Mon, 14 Oct 2024 23:55:26 +0800
Message-Id: <20241014155526.17065-4-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014155526.17065-1-zpenya1314@gmail.com>
References: <20241014155526.17065-1-zpenya1314@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Synchronize the changes of origin document to fix the pfn value.

Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
 Documentation/translations/zh_CN/mm/page_tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/mm/page_tables.rst b/Documentation/translations/zh_CN/mm/page_tables.rst
index 544381c348b1..b0700a5a8bf1 100644
--- a/Documentation/translations/zh_CN/mm/page_tables.rst
+++ b/Documentation/translations/zh_CN/mm/page_tables.rst
@@ -32,7 +32,7 @@ Linux 将页表定义为一个分级结构，目前有五级。对于支持的
 在页粒度为 4KB 且地址范围为32位的情况下，pfn 0 对应地址0x00000000，pfn 1 对应
 地址0x00001000，pfn 2 对应地址 0x00002000，以此类推，直到 pfn 0xfffff 对应
 0xfffff000。如果页粒度为 16KB，则 pfn 分别对应地址 0x00004000、0x00008000
-... 0xffffc000，pfn 的范围从 0 到 0x3fffff。
+... 0xffffc000，pfn 的范围从 0 到 0x3ffff。
 
 如你所见，对于 4KB 页面粒度，页基址使用地址的 12-31 位，这就是为什么在这种情况下
 `PAGE_SHIFT` 被定义为 12，并且 `PAGE_SIZE` 通常由页偏移定义，为 `(1 << PAGE_SHIFT)`。
-- 
2.25.1


