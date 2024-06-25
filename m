Return-Path: <linux-kernel+bounces-228750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4B916663
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529A91F2447E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6F14D6FB;
	Tue, 25 Jun 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRcLDhcs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786C14D2A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315785; cv=none; b=M8CwVt9vdaZ/2CBnKsaCRRg/2T8eBlDWM4+T4EsXhscgxVz/8Kgz65Zh/PzEEftA9Uk5bZJOcnZhElOukEhSmnRIepkPcM8I4KmZDiFl3NBi8fCk0TWlqUoW5dIBfEWKKwegLSu8Go4NHW2KNHH0CE/T+AUV7siGGXXz2ydkOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315785; c=relaxed/simple;
	bh=TH9YzaELe6IxjoA2Gh0dTe5ifnOKZGmbvqwkfIfVmm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOBgwHUY/e0qHOJZTUw9NcLFpeAj8JRoBBUNMDafO7BUtnZMMyla3W8xwwWNqBtLeWes/qDnhjfrGI+5raI8aLEkGXhsxw21p3diCi8egg9nAnVKxDdxDT3MffaxUL3WNiDIsmPQZsqlbCGYmDYMOdUQ9E7QQWS15FhDYOMJq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRcLDhcs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4c7b022f8so46832785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719315783; x=1719920583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMuRqbTG26uadPUsVqc61Ox5O3jYym2meXNjMFc0pVg=;
        b=bRcLDhcsWdNPUDkuBjLeD9D/in592a1iN72R/HSlMKpwfx1a7JhmzvyLMXPr7dAHzX
         7B4gqraOY9qk+3D65qsCzoFfl6DLHsyTUZFR63Dy238Lk87pV8JzT8snom6Il49CHWLS
         2f9Z5mymw08uN/3yhyD3oJ0nrCftIFnnRN1I6kf43kCHeEoiLdAlyLU6zU/XpOvNdsjE
         b9PZOW9Nj1dmyb81+Z/jpHGQKJm5NOPq8NS6QvshFXqoBw/C3n6r5eTjNhT6JoVQW4UR
         yXq5j2ZXYEt3ylSf4ckLO3mH7t6itpOR1kDFv+ll85Tetpiizgns8O3yLYWlhYVwj1wI
         /UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315783; x=1719920583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMuRqbTG26uadPUsVqc61Ox5O3jYym2meXNjMFc0pVg=;
        b=N6VP0wGSxo7pW+sY/Hapl4Z/sTQfuTp/AV5pfrIk4YwqZVtcURV7UHsRS2vEFoPLsp
         wF5EsTZWulIeMqGNOEyQq+v9wjUnNgQk13qov+h9bkZSkNp5Nrxv4YKjslYmoRLs8LtM
         Nvxsw00XNCYZ38wFoel6g1Fgs+69tj0fUr8/3chnL5HrPHUHq5AlCBjccyT3II1Xarqn
         thKJ0GEDd4FmiD3aAZpRL/+lHTiDUsjQJT2tqk0WuJLg1RtEqYsyE4wspsNnjIGyxHJc
         RExytPTClg/vTFTjBBH1S4+VEV8amz2Ejk1vo3EczuH4yt2dyRRxxUhUSIl7lHneUDyr
         Sm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW7kIFCuUFtl3ihnNqOX4fFdyMIDjuA1iDjjTXeT3ALMqKnm75dg59zkYfHEmzQKeSRVA2zHzfvUzRfxpYyDbDnHa01rnPMsjU2/ru
X-Gm-Message-State: AOJu0YyCGEWzLjF8vn5LOj8v8vWFzk4UwU0K54KGxAZszmd8bVmBRa7l
	DlMSSy++K4KQ5HghLOAjUccNuPQ5xbZl4exGcNa8ynTpC1dCb/wi
X-Google-Smtp-Source: AGHT+IEP16XnPsYWRnZSo+1Pk716wGzvHi1zkYqGFeDpM3jrCTFBRKNx0aJaeIxt7Z23OiJgXSOW5g==
X-Received: by 2002:a17:902:d481:b0:1fa:d3d:a68d with SMTP id d9443c01a7336-1fa23bdded8mr79110545ad.22.1719315783050;
        Tue, 25 Jun 2024 04:43:03 -0700 (PDT)
Received: from wheely.local0.net (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f028asm79638525ad.3.2024.06.25.04.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:43:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] workqueue: wq_watchdog_touch is always called with valid CPU
Date: Tue, 25 Jun 2024 21:42:44 +1000
Message-ID: <20240625114249.289014-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625114249.289014-1-npiggin@gmail.com>
References: <20240625114249.289014-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warn in the case it is called with cpu == -1. This does not appear
to happen anywhere.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d..0954b778b315 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7562,6 +7562,8 @@ notrace void wq_watchdog_touch(int cpu)
 {
 	if (cpu >= 0)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
+	else
+		WARN_ONCE(1, "%s should be called with valid CPU", __func__);
 
 	wq_watchdog_touched = jiffies;
 }
-- 
2.45.1


