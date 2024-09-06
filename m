Return-Path: <linux-kernel+bounces-318512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B987496EEFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52ADEB2373A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD61C7B82;
	Fri,  6 Sep 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USASC9WO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE148CFC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614276; cv=none; b=PSPdf4Mm+jX7qZy5RYlFw3uJIjYUMxUb9f8drjstfaD9ot4y2a6Bf7tyVRPFcGQxN3rtctpQUWQtgFacFjraw+YOuaReS+qumcnlZ2WhxsLw9VSr8GKnYZrEIUFBa1cGTBlOayyp/LqG0UrnL62cDeDIqR+rlOj49FY9M0Ygpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614276; c=relaxed/simple;
	bh=W+O7kSEnBCJyyqhcPyOPYDrrGq/7rXqyLFoDWfJI+sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyhH1aNC9tt6yN0s1NSsVap3Po7YpbXXETrE+IvOvUgaf3iytvkvy5hWVFTmLwByIGCCAd2fb+6TEWLiT0TnVwPdJfTmKJWv+4ypVcbQhNmN9mgGXWkjyYoid26my5FRjJn6nY6TTbbQUEKENbibJgOesa/W9cyKF/kMIam3eak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USASC9WO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so909377a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725614274; x=1726219074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdSscxu4iwCci+/8FixpdemFIaPGSwznJT41/j2DIjA=;
        b=USASC9WO/2r4gCZbfTe5L2aTBXU5BAAMEnJ/2bOXiUuVurFSF3SXCzXq2vDWckjtNw
         HtRKySPiXItn8zzXQiJEtzkySKbKTasRLGjc+pfeazw2E8vIz41KIx6T9n7nJMlmimvT
         Jk4o48XPqpUf8KQtMaUCAA3P+uqHEzL03Eedk7SZUMAMQTpbjrnneSRgC+VXYXKk016p
         XmkPDEyVIRQu8bDS3OHmpeztoSby5unfMeWBLIyxN+1YLJNHlepCPJFDWhfQzME5W4RR
         2F1Fifyc/ySoXPGFWj63dhqVDvPUHfaWWxbao1yX5x+d3h/YPQ0G4bOfCj+OOi9xBdfB
         zIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725614274; x=1726219074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdSscxu4iwCci+/8FixpdemFIaPGSwznJT41/j2DIjA=;
        b=I+vbkNfiHVDhHSb4ffd56wiJrtFO0+CXjjMOHK4mqiE2qn9oqq4jiA8yOa8z+fUAZA
         VnLILLFL1HGEGtHxaphOt5/GvvrUmnnMylIDS4WYyJcsfK/kFL7TY3lpIy8KU2wWWxQf
         EDZgmrAvHGiDUXD6yL/LTE5qZUyNwHGtf6N9hfU8CurNAtL41O73NWkKZtEITD4GHWfz
         unlCGhY/Gs6iaQo/Nb6nyJEVa35Sq02vLcL7np29NDY/FsoatUX+LTLMDQdaJESDDxE/
         O8Bf0eTEftasIjWRRTdZw2YrZBIGSQ9YZZftN4WAawQZKsN72wJjT1/DHe/RxS8ba5aM
         LVGw==
X-Forwarded-Encrypted: i=1; AJvYcCVP16cFaocY2CxqELLgitT+Uwup2oXS4p5POeF/5GaEy7c1IH/r8RLttg8lxu/+0dMRSfAfb5khwc+clM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWD5boepvt+uzWgdXxGfEbwXW116XG8RByou+Wo0kF5GjL0jw
	rEvq2Zel9PCGe5riYpo3AYe2MmmrcgTqwlT8AFCoD5bG8zSnFUrk
X-Google-Smtp-Source: AGHT+IE3cJ9IjbyOplSMh7Z19jI3h9PoXhxcIAtQiEBq9hO7fnTUR7JHLZEdW53tyndSQR8iUyPnBw==
X-Received: by 2002:a17:902:cecd:b0:203:a0ea:63c5 with SMTP id d9443c01a7336-206f0367aa2mr16748195ad.0.1725614273729;
        Fri, 06 Sep 2024 02:17:53 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90d174sm39692105ad.48.2024.09.06.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:17:53 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: andyshrk@163.com
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	minhuadotchen@gmail.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re:[PATCH] drm/rockchip: include rockchip_drm_drv.h
Date: Fri,  6 Sep 2024 17:17:25 +0800
Message-ID: <20240906091728.109570-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
References: <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

>Hi  Min Hua，
>   Thanks for your work
>
>At 2024-09-06 06:38:50, "Min-Hua Chen" <minhuadotchen@gmail.com> wrote:
>>Include rockchip_drm_drv.h to fix the follow sparse warning:
>>
>>drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
>>warning: symbol 'vop2_platform_driver' was not declared.
>>Should it be static?
>>
>>No functional change intended.
>>
>>Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>>---
>> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>>diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
>>index 18efb3fe1c00..c678d1b0fd7c 100644
>>--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
>>+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
>>@@ -14,6 +14,7 @@
>> #include <drm/drm_print.h>
>> 
>> #include "rockchip_drm_vop2.h"
>>+#include "rockchip_drm_drv.h"
>> 
>
>We already have a patch[0] include rockchip_drm_drv.h in rockchip_drm_vop2.h
>
>[0]https://patchwork.kernel.org/project/linux-rockchip/patch/20240904120238.3856782-3-andyshrk@163.com/ 

that's great, thanks for letting me know.

Min-Hua

