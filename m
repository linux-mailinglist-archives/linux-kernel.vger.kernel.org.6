Return-Path: <linux-kernel+bounces-322453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781CD972923
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A8A2839FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B8178CEC;
	Tue, 10 Sep 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhhp4EHP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C8171088
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947869; cv=none; b=UONGf1A+DNkrErvj1jMhtFE04TTRCiAVj00P6h4rWdiqAGtatJZmgFvmuSxuv7mVCCs67rDaMGD6kYtoGvcaSUuzZAe4JKEi+RYS2ILdG/DJUA/a3Nxufdz3u+ibTy0G0rRD4vtvcjhGRbEdxS4jXEiA3TZCLsMV7AmuRkaC9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947869; c=relaxed/simple;
	bh=mDWCdtQECaft6UyFnxKuWLNVPoT/Ykv8dg63XdEYIJE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUwcoqP6DefThwgtbP6sS2UwS37vEYT+dQqjAgFm/GOgJ1C6bBEt/t3c1bdNGRvjyAlAOAF7CghQZExpKSgEdTrFvtNIv8KbGpasYFJq8qQU0Zt3xqasql1OGFLJjj4Vf7kzoxyXCz1JPvSXPWy8x/bblPzYi9fNGdXiATPGBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhhp4EHP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso11733352a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947866; x=1726552666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXNNB2F38kuYNsFyFx8FeC4ii8KpvQhpKnyoK0gzIHI=;
        b=mhhp4EHPF6LZBlARBtxC25Ms0vLLFTHJhxCgqBW0PwDEB+IIrHODT1PKmnXjDMDLer
         i7jrznpZQd+oxm2oAe3kXo9nbatWpVyGpFcSB7tPRm2u7O6U9rHhDxEXihFHgClWBmhu
         P2JZEwxqvlc82qAo1vdZN+9QPo6QBzcQh9Z5iEsnviqZQ7e0tJIGpdt8Tr/gPPL0e7wc
         rQIrIT0TdRySGwB4FAzQ5xiIpo8v0XUVCIRFUsGDY526Z3DEs+YRsnw42rkXs309iTex
         9UGlLEY81VMHH3ODSBwfEv/OaW3il7riRqhj2LiYxLP1nV8tRQXtDqYkJz5uIWQsy7LF
         SwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947866; x=1726552666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXNNB2F38kuYNsFyFx8FeC4ii8KpvQhpKnyoK0gzIHI=;
        b=aQ+QdDqrlj6UGJp+5c/ZPNnNrf6Et3SlZEr6dxQylh9ItAs2dw1Jb7NZVX8dgd7/rn
         59m0AB7tAsz8CPyUWrumKUMw5PWWdotkhSvgHaQO2jpaVJKTS6wPQdYEFVkdHS9fd6SZ
         9AtYunUbak1h4Vt6kYeN8QNU3M+FLi56WhLeaEz6wSHRPqRHQowzbL204quIuXmq59bZ
         S2qFGBz0aqQ3q6mTw+rdNWHkGS8utwzpNGXJE4bhRIDkvUP8UvFmRrMhVuUmg0JLuINA
         lcmq6mrajwHYYGU+QpADt+yDtX8MbgjEPV3nQPrzxTqmMqCQfbsSXC28oHHIrPEJvifh
         sifA==
X-Forwarded-Encrypted: i=1; AJvYcCVm5yvAYIeJIe/tEdpqoYIDTtlXKPKDlfz/2UCLwhV1yVfdTv3yj6oenQU86sJLfrS9Awb8L5NmJ10UlXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvgmVXvucF40Fia+hdWzKcdDKfQl472T1qdchHlJ8ZJTdUecuC
	6RYb3+2Lnei7rfXorulyFRLl0rGnjuldvn6g2x4BUqh01DVl1A5qTqrHEC9H
X-Google-Smtp-Source: AGHT+IFjODiZQZPml95Fz/+7rGWL/M0myDq5g3Q/4aNYVNWclwKIcU5MTnt6zT482xFtV267nvCdVA==
X-Received: by 2002:a05:6402:448e:b0:5c2:4cbe:ac21 with SMTP id 4fb4d7f45d1cf-5c4015dd1f5mr2226407a12.5.1725947865658;
        Mon, 09 Sep 2024 22:57:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd46909sm3979316a12.25.2024.09.09.22.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:57:45 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:57:44 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8723bs: Remove unused function dump_4_regs
Message-ID: <583ba389a269a11f4c2497ae5152ad8299d88455.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused function dump_4_regs.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index bfce632e037e..fb6cc1d18bba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -10,15 +10,3 @@
 #include <hal_btcoex.h>
 
 #include <rtw_version.h>
-
-static void dump_4_regs(struct adapter *adapter, int offset)
-{
-	u32 reg[4];
-	int i;
-
-	for (i = 0; i < 4; i++)
-		reg[i] = rtw_read32(adapter, offset + i);
-
-	netdev_dbg(adapter->pnetdev, "0x%03x 0x%08x 0x%08x 0x%08x 0x%08x\n",
-		   i, reg[0], reg[1], reg[2], reg[3]);
-}
-- 
2.46.0


