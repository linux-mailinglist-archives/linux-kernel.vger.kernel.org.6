Return-Path: <linux-kernel+bounces-251374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F867930428
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765801C212EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB609282FE;
	Sat, 13 Jul 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="z6mTROYj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93751AAD7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720853995; cv=none; b=FhJUQblPK/ZP52q/AK9xwDWeRmz5ULWDsbDfRH/38VNy95rZoGh+sGZtmyTUntr75CS8DXro+WA3gWa1h8VtE/MWIc6k0Ug4WO966njihYRNh7zFPXDc67GMkLKOZUnGm4LqFFg5zwGqMvPjTRA/0wrfCW81+PI53+e2a7tQ4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720853995; c=relaxed/simple;
	bh=7HItEmYBf14Zjd7sslpONJSLfexagtTtV5pcePSw5wg=;
	h=From:To:cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=u5k6IzcXtEBtk6UIRxVNWIuvnwd2QX3LTo8m2PQ/f0MfH9Q4hA5ss+NJNhSw0xWGKb0PBiGQ70/aisk8PBQxVSQFHStV48ucUVq0EGHwYMZZaVJmwIPlMoAmOqFCRLYQDUsis2QHHdxwWew8meFy1PXjHB4F6GwDyiZu7CzUXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=z6mTROYj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65f8626780aso3481857b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1720853992; x=1721458792; darn=vger.kernel.org;
        h=message-id:date:mime-version:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydwtC4/lIE+lT5DSbjYf9dpfd4210bk+luqvaEg9OAo=;
        b=z6mTROYjzYOFv0KVZJMYjDVTO3o8yAkKyusTnNf+NZ2pcQlxFBOFlOw2yrwr+Q8l8v
         D0R8zy7bmgwadM9tnaGDy82nf93ObotAWVgBIFuttlbMEGgj6wHKeF5XdTyLqKyBet+M
         UQpTG4alL1LMv2uNy4x701Y/FwX61Gz6qlm93hWTpbLkomBk102Omf9aKVULt8KDDvxT
         0Nr06dJ4AJP+2ZtmQNbeyYIEb5WuDmeKN1tlLg60X0zpCsWTpRA9WDwNEX33Wtux5jRu
         INfCFRVZWmlQn8V9jGZ77XRDwG9E4QD3woob3e+NMSCD275Sggk4TwDGbB4cHf+r/1vI
         YKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720853992; x=1721458792;
        h=message-id:date:mime-version:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydwtC4/lIE+lT5DSbjYf9dpfd4210bk+luqvaEg9OAo=;
        b=LQbUouH6GLU4z55jVX6VhxXw9O9nKd5LIR/ZS8M41XJ7Ug7Vf6WNoWlkJVrBj3dyhL
         ZwOPOaid5/SED6C01cbv5z1fB8mXku0gTGQ8UaKX0fbu2ybHUT7VKtUuOzSt8p+iFXHW
         /a7+yPnDfMSQnyPSzPbuOeeSEeHH8+ybKMeLcXpm7QSYa2q8th2iBOOJmY8mVeUpT4ca
         sjbgcllFktcYHRbNcYCPlSW9CGpwF7JEqj8TlzptCqN2apX8UQWcswxxRvmz46HBs8Qk
         98tUxLQYguJ21ZFnGBrH64pu+NpkQ7XbWGexVK5kXC+ErVdxOYse3eeDWILMQzf66IST
         bIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMOKCsYfEfECPZfIBiQVNegzhTV+WuVILZ8qkQ3b7M8euM3AiiSrfSKCTIneUzk/UWMt+lyvbEUMYe6FIH5Xtev3Wec/hpSnadiSk
X-Gm-Message-State: AOJu0YxsYBbHa8zpdt0NCUILIiyowYVaQyNuXJkGtrPjiXEeiaGSKVSH
	mSc4oyyl8KnbfOo2V89C6ZTdkoqVkNFeahyCJFLvUIpK4OnEIAIkMW2f97o3FPo=
X-Google-Smtp-Source: AGHT+IHs+EiLAbdnuqJKtCk9/675T+jHZ8SqxZe6dAz5jiepIgQqgaOOIWqQWTLomFaE8j8wY7auoQ==
X-Received: by 2002:a0d:eec6:0:b0:620:2cfb:7a0e with SMTP id 00721157ae682-658f02f372bmr150576337b3.40.1720853991583;
        Fri, 12 Jul 2024 23:59:51 -0700 (PDT)
Received: from turing-police (c-73-31-28-59.hsd1.va.comcast.net. [73.31.28.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c6f54asm24325085a.121.2024.07.12.23.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 23:59:51 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.8+dev
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Johannes Weiner <hannes@cmpxchg.org>,
    Matthew Wilcox (Oracle) <willy@infradead.org>,
    Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix typo in Kconfig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jul 2024 02:59:50 -0400
Message-ID: <78656.1720853990@turing-police>

Fix typo in Kconfig help

Fixes: e93d4166b40a8 ("mm: memcg: put cgroup v1-specific code under a config option")
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/init/Kconfig b/init/Kconfig
index 1c701db1033e..bd378757d0ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -984,7 +984,7 @@ config MEMCG_V1
 	  going to shrink due to deprecation process. New deployments with v1
 	  controller are highly discouraged.
 
-	  San N is unsure.
+	  Say N if unsure.
 
 config BLK_CGROUP
 	bool "IO controller"


