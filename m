Return-Path: <linux-kernel+bounces-281326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE494D58F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F781F22213
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B007E59A;
	Fri,  9 Aug 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOk3wxoG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F88288F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225117; cv=none; b=r7cg4ZbDDuUGBwkPpzDZFMGtzyUvnjj6iPq5vkhzHMEgJAuxItR2nmAVYijKXYArOUUae79LBKXe0drBo1gOXkawzAWGlpLc7eez/EbOMdAHn6oP36n9/rt8Y+rhSXjfurSDp/BnOlwnLuTavamGjpflMasPexWzf5Fj6ROTn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225117; c=relaxed/simple;
	bh=cXxYEXZARGsajeKNP9d0RS9azqEcBNcFd0GgIoMO+s4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ejjenQQX7aQiAQHl24UoTCYMeHOn/oo0FmrxyXN7Cb8AmmBN/H9BXjE8SitM8SMn44I/3EiC9osLG9SGSDzMDpRxFRUeeae4WWgddONVq2rDgO9Q3qZVq3GQlr8ol2I9E8HXT/dzg4IWf9n2Wvxh6kNFAVAy+LDb+MPY1bfpNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOk3wxoG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42803bbf842so22310195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723225114; x=1723829914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK/eXbtSXt7i7qGRvp4JY5MYm4mTg33gbZoavV57C+w=;
        b=vOk3wxoG5dxVz2yYdtRQByI9uhxIBAoQXyjJBT73BETSm1yQlAo6+AisyYu1zsedgr
         tKr8+4XknMzR8xz2r2BJDMwj5ahbZY07WuB2VljglD/byP3eogB39XJMa8TXlUl1zvcG
         4+6FEA9tMpkoODxqaJzALjHMAOayy3pxfHHohyTcjJdGssPhtlZsSGImPkFK/xHOXiNJ
         kGZHl6gQ068xIpKbH7x7qCZQYRmZdeqONKdf+ja9dwzs7ZIMqWHwawkIS9GmM+BGny0f
         0mN050LUyOUkt/Aqxs8kCi21KvY/XM/v4DunsG0Y1HoEFDXcA9tNEmuJmB3GheR95bUz
         7cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723225114; x=1723829914;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK/eXbtSXt7i7qGRvp4JY5MYm4mTg33gbZoavV57C+w=;
        b=gPnu0XgS04EUufI15lzNJEFyUc0bT/ZRMGWr+gubITPHYNG0mvbYElKju3nt21FUYm
         t+orhAFBaK5/AV9V+BamG1cmerme7QITIrqtq4g+uRdRTjYWO0tF6VvNzD9eGvSbAvkk
         R375tFvJ2zDnzIaa3LtJGqx6ci0ZHG4UubPImkXYSUEpi2k0rLPtIxOxdqNLRRPpxEye
         FY0Obx3RBsR04gZe2hF7Yq8aGvHNLHe5zqdM7Svx94sQTbRgTxaKd4BzTUtOBxGO9uwr
         wz+QazOq6uduFdvmgJ/2rYWyDmLRYNx+5sFZZB1HOEMPznYhAT9Ke+Krn5mxOIW5F6dx
         1PIQ==
X-Gm-Message-State: AOJu0YyfuLr4Lm8XnbPFugD/TSDR8/hHj1lOsujZbUUTCICRo807wgVt
	iaJyLITbO38ag6XFtDsHKhJuvnEQwfsRb3RS10BKpIREmbH33iHlxw2BLF+GQg7UjJwMeE24K42
	s
X-Google-Smtp-Source: AGHT+IHlKsFJK5FyeGImDhFZElsrrYy4iv5r7ySzQHymljAVd0WoJ9rnFzjR1TGdbNLOS209wzEC4w==
X-Received: by 2002:a05:600c:1f81:b0:426:5269:982c with SMTP id 5b1f17b1804b1-429c3a52e1cmr22944565e9.28.1723225114348;
        Fri, 09 Aug 2024 10:38:34 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4efae579sm40543f8f.111.2024.08.09.10.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:38:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, 
 robh@kernel.org, Michal Simek <michal.simek@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kalyani Akula <kalyani.akula@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
References: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
Subject: Re: [PATCH v2] dt-bindings: nvmem: Use soc-nvmem node name instead
 of nvmem
Message-Id: <172322511112.401904.15547829402297792628.b4-ty@linaro.org>
Date: Fri, 09 Aug 2024 18:38:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 08 Aug 2024 13:02:59 +0200, Michal Simek wrote:
> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
> why also update example to have it described correctly everywhere.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem
      commit: 972bbba114bd45c7526f88512c277b1a1c4fc3c8

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


