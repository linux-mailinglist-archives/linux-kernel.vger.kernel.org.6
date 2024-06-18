Return-Path: <linux-kernel+bounces-219108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8490C9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB61C234A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1818E77A;
	Tue, 18 Jun 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqc+dmZJ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46418E758;
	Tue, 18 Jun 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708788; cv=none; b=XgbyV1AO0AkPowbiZEPb0vLEXROX9y4DC9a4gr6W2428MVTdasK5mBEGOdemPK+k9xt4FrpPmQ3PASbJANrAkgKxXn0w7cL9JerQRwDBJKIpdLlH0L7SIymvBa4dLqwbztlhFNGY43kmzixeHJl9Nc+Z1Vx01vOSVOmJz+akk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708788; c=relaxed/simple;
	bh=fWqSplAoFa04GcT05kw5kN3zYDG+MX+9z+2UF9duoDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MlR6N/ddp8q87Atqb5gI2voeCAjMe154yc/fVac6rsrmNVaxpzeRBafXAAjz48Rol/xDJZcmmzUV5/sFpN9vc1mK42Wyq2UAUy4xiOatTxxJyMgEqJSiImWO2sPToQAFoYtYs1u9TuLMzUfp8bBnVgnk1vRLWIrdFNSPw6UQ6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqc+dmZJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f090093d8so4181149f8f.0;
        Tue, 18 Jun 2024 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718708784; x=1719313584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0UnVYkWBTkFsEPFcgOdyQEFi6q3Dg5tPMGBVAy98v4=;
        b=Oqc+dmZJlhn8qNJqGpZ4lpbp/hpHjiftlXvOxmKEiNlTD5VejUQmtH8TjmCwmGC8sJ
         hN3TIlt2suyGRfvr7ILDHELf9dgytKISUHjoNi1HfsOeBbEjQZrbtJ7AiE9opVEY3La6
         7gNVqO/QwYuFU21VqwNRLw/APv48A2p4QUuMQF3iucamh5HrMA5JjAQIoGTh5/kGVMLb
         9kkXOfFm78mtVgnwb/vc9mQQmB4JN1Pjp3w7eRDa6rbPRmLvgC3haV7MtHC70+QpGEPk
         EI+ottceTvCpbB4T+ixI49XgRubrdW2Vkrde6UpXLjcM3jwcH8N7ucotDbGzOrr2DUK+
         AxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708784; x=1719313584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0UnVYkWBTkFsEPFcgOdyQEFi6q3Dg5tPMGBVAy98v4=;
        b=o+7Dhy+SMozZUeW/hBgA5AX32VoGYwGgVbiqw5vwaEHnHjT44viRGn3H1Uq7A3UkNX
         /q3ZsIjxk8KEB+tYwUJM28/0qEwF+UArxZA/YHyVaMHvc4tEomI41WwLUpQ4KzI7nwPa
         iWOyTf0nzw67eVB6KkeMs2JvYNcmcJquucUBjKbFDLOSkpjwy9Hjn7A39iSaqMeW4Ldn
         NvsUPeS4nBb7dDiEu//UG4TwSQWWUU9GbTYBRFNn4cJNoyOyEJLPNYjol1p0YhJLdP+/
         ATvTaojLAc/jt7G65fcovg4G9rq4AgcL02rY1rNRteS9I+LPfSxUcshAK/lSdQymXNFL
         3CJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZO8kdeKaNMieXoU0oaCc+K/EGlviLCXDgu/HJQxkakKtj30EkT+nLj3kIuAuR39DmbUp1kJIgoQKOrEXO6FV0RCvJ5WiRGlJeL0bB
X-Gm-Message-State: AOJu0YzsV8rJnl1ts+GBH3JM8zDZyK846CWjreV/O80GwXiXiDsHToO/
	iRcbhSVVTn4/UtNPYBrqpCX46oI/FvtAshbutSeRUesvLHVDp6WnskMMKpoO5uU=
X-Google-Smtp-Source: AGHT+IEqjETPhT3RToeGvat7HY15Res7AG+JP0QHL3cLZWmoqQzDRKcpHLUl1JgxNDxqFPKQsUNPmg==
X-Received: by 2002:adf:fd0a:0:b0:362:8e0a:337a with SMTP id ffacd0b85a97d-3628e0a34c1mr470620f8f.53.1718708784110;
        Tue, 18 Jun 2024 04:06:24 -0700 (PDT)
Received: from localhost.localdomain ([93.51.30.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f23dasm13781939f8f.68.2024.06.18.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:06:23 -0700 (PDT)
From: Marco Cavenati <cavenati.marco@gmail.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	Marco Cavenati <cavenati.marco@gmail.com>
Subject: [PATCH] perf/x86/intel/pt: Update topa_entry base len to support 52-bit physical addresses
Date: Tue, 18 Jun 2024 13:06:17 +0200
Message-Id: <20240618110617.22626-1-cavenati.marco@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase topa_entry base to 40 bits to accommodate page addresses in
systems with 52-bit physical addresses.
The Base Physical Address field (base) has a length of MAXPHYADDR - 12 as
stated in Intel's SDM chapter 33.2.7.2.
The maximum MAXPHYADDR is 52 as stated in SDM 4.1.4.
Therefore, the maximum base bit length is 40.

Signed-off-by: Marco Cavenati <cavenati.marco@gmail.com>
---
 arch/x86/events/intel/pt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..f5e46c04c145 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -33,8 +33,8 @@ struct topa_entry {
 	u64	rsvd2	: 1;
 	u64	size	: 4;
 	u64	rsvd3	: 2;
-	u64	base	: 36;
-	u64	rsvd4	: 16;
+	u64	base	: 40;
+	u64	rsvd4	: 12;
 };
 
 /* TSC to Core Crystal Clock Ratio */
-- 
2.39.2


