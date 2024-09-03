Return-Path: <linux-kernel+bounces-312230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532B9693D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30382878F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A01D1F63;
	Tue,  3 Sep 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnZYeUR6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9E1CDFDB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345456; cv=none; b=eWG52EacT6cT/rzzyhExb+PZ8L2J04V9+NGPdznKoxZZyMTR4MUDHz1ZnvwpURNZfJW3h/VMmVjo3X81pI3ykwExJM1Tut8NvJbbHlaQInZf+8KQ11ieL8sQSzt59asziFaGkuvmPMFJHVPEn1a+JPBUgoYHYtFpN4LBUkWAK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345456; c=relaxed/simple;
	bh=E+RwKrTe4PjZCoMNGVs/K27VSdkCabDL006XACcqnjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RojqAY1xwQJecoqnQI8RKObl21cGNswkxYcDPsWQzPistzUt772qF6yssj8Q8S0cBpnGwnchIwMz7Tln5eXhAROb+Dgqp1VAOCL8BRn9Li1cpa1cL5isFdjC7l3wxSNubJtS2/k99j7mJdS+VjuGgpYfKrwGstHmPNCP06lKVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnZYeUR6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2068acc8a4fso7481605ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725345455; x=1725950255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbOZ+JVq93xaozZ2F/fRGqtyghYlQ1vNCbGXgo0uGko=;
        b=dnZYeUR6BDkQNJ//lSDUU1FdSAwLOgiQezn1LokVch18JeWbu/exdXPDSeIuVtq0K4
         OMxHb5Viq11C9GQkuaCzD+qFR7ZzBKBA+ep2AER5AZ0HRkZistoBdkZ1dWnmIQBTpzOc
         qEaIUI6Ulbsuo7lmFUUd+J808cmOxAhMCjb3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725345455; x=1725950255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbOZ+JVq93xaozZ2F/fRGqtyghYlQ1vNCbGXgo0uGko=;
        b=biOWLnAUXF1CpbSpzvk46ALxzKQKyJ3N2FQBfYSzZh3F8Gg3CiVEynxCV4PBVpEqs7
         79gAStpTAOmlhUL3URoVN9ktFofw4Tjn1HDzUxp0fh9dzu110iAie9Oyp32YuXvKi4r0
         v2vty8k2WiXmqS94Y2EsENMJ9/OTmibqP8CAkynARfF3hXXcX1GgCuOC8EckDVKPwdkJ
         WK/KzOScBDUk/zD0FkZArRADXHioWakdx5iBP0wbyaf70O2fUKjNnPiMS2yn33GLjCVJ
         AhGF5GwTdzXqIEXN3C7awI1DlVsVH8hKKaWMzEjY9yOOeWtP/eLmSlLsLVszupsKEP/N
         T0AA==
X-Forwarded-Encrypted: i=1; AJvYcCUvaqZnh+itufhf8lrV6PtuhXatUAyjsX349PgyvvHcswYAkxoY2xyuNuAOkcY6y/7vOazHhXIYTZG2thQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0Vy4wMPWw4KXAPFabdR82qMwhIWsHCZ491XufmmXZr4MthQG
	4c0eyqXkhVTqprxJGLKTqmOV1mvLr7pQ01gXjqOhaASSvYPp5WX9Z9DgdRjNQg==
X-Google-Smtp-Source: AGHT+IH4B3FchQ3yX4BK53t8Xm+bHdb7x39ti5e3zwoaLlNvJhQCSyfF9VV8Eot/TOGV8pX/mb/zXw==
X-Received: by 2002:a17:903:1c8:b0:206:9536:9778 with SMTP id d9443c01a7336-2069536a0f5mr13234785ad.19.1725345454827;
        Mon, 02 Sep 2024 23:37:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:51ae:4bbd:c856:6cf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2058274981dsm21045555ad.82.2024.09.02.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 23:37:34 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] Documentation/zram: trivial fixup
Date: Tue,  3 Sep 2024 15:37:06 +0900
Message-ID: <20240903063722.1603592-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-24-senozhatsky@chromium.org>
References: <20240902105656.1383858-24-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index bbb1b1b8f10e..678d70d6e1c3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -309,7 +309,7 @@ a single line of text and contains the following stats separated by whitespace:
  ============== =============================================================
 
 10) Deactivate
-=============
+==============
 
 ::
 
-- 
2.46.0.469.g59c65b2a67-goog


