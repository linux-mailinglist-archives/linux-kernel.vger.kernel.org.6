Return-Path: <linux-kernel+bounces-363758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB099C6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B94FB20B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5E158D6A;
	Mon, 14 Oct 2024 10:02:24 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA43A48
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900144; cv=none; b=OJOv5F+wb1kWt0TZFoqpjtYPwlCY58O+HiespvCinddht9Y0hlOovtv/JBpYrm9Zn0HcTVGpKaDUywAAvu4uyp3F/Hnzia47pPH9L1W2LPmYwP3WfpMRJh1Htgc1m3OWR6XdZh6xQlPT4hWSxJYmmenocL5Bz86fSdRDnvE1GJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900144; c=relaxed/simple;
	bh=jlsQtarNpe34EsDgNKRoj4X9vNQH1uOi0WK+67cJu3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6+ebLqmPeE+l1yHRL+fnBDWr1TR0N21DWs8NN/Pr3ngUJZT6bu8gjurrwwIWnCJdhmKGnGitD2qyahtFA8heBLFDIvu/PTgwW55zHxs8iGQ4N5qE45mJ5ID7VNqZFx0VT68KcucBHWdz/a9mRsY9vI7o1u16XSiy7m3JszPkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d462c91a9so2615141f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900141; x=1729504941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/udzLybNFaG6mOUJeBh4+tOxHs5e8HdKHPtDl9SIds=;
        b=kYfchSCy12Bt/PY2NV9IGybDJLvbv5Mo5EnxzFXyfEczo1b73AIscXYXzKpGwS/1eY
         NhH641ic/BGAF8+lSekdAbd0jlZCk6ZUvFd5hMsaC7ursB1bKzZj8fv9bWEDUng9i0x5
         kD9soydz7iblLr4yL4jGgy0w4p7zLYtuuM6UPnSP2CtGuAd6FEYTTAxIQEAbIuInXdzY
         SYI55fiDqlr7mV/dys6R2derrNDq3xNj8y3wHAWexcVaypoif1L4WfeKVWtxsagK700H
         vQrfmLq5EsSR+aCP9CEkmDWVOmOfSXFydvZPEvCzh0mumWjd6fxLfZdbzbQAGGZfFrPL
         znFg==
X-Forwarded-Encrypted: i=1; AJvYcCXLmC9C1zdpUd/B8WM1aAZ2vZcyZffSmHmUUGREBsN9v5OtZ8vlnaSNZUpkTu02ueeDoME84nQFP03z8L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/pLZofVwQhOxE2BeYcTJvExY289AXgNmi5aK29Nx4VfjzUoM
	naHPbeyrwsM+tITEmpwS5viJ+u9hoJKRCbORsRHQflRdRUemxRan
X-Google-Smtp-Source: AGHT+IEJ+poe8SBBvLHLgKlwbsh3OSXonsWxgCXSH+9A9PLOxsESA5YYGlttx6i2HKcCWjjI6T7MLA==
X-Received: by 2002:adf:ee4d:0:b0:37d:3964:e0f1 with SMTP id ffacd0b85a97d-37d55184dd3mr7540527f8f.4.1728900140882;
        Mon, 14 Oct 2024 03:02:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffca7sm115134315e9.20.2024.10.14.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:02:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: akpm@linux-foundation.org
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	Carlos Llamas <cmllamas@google.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Xiong Nandi <xndchn@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] scripts/decode_stacktrace.sh: remove trailing space
Date: Mon, 14 Oct 2024 03:02:10 -0700
Message-ID: <20241014100213.1873611-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decode_stacktrace.sh adds a trailing space at the end of the decoded
stack if the module is not set (in most of the lines), which makes the
some lines of the stack having trailing space and some others not.

Do not add an extra space at the end of the line if module is not set,
adding consistency in output formatting.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changelog:
v2:
 * Add double squared brackets instead of a single one (Carlos)

 scripts/decode_stacktrace.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 826836d264c6..46fa18b80fc1 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -311,7 +311,12 @@ handle_line() {
 	parse_symbol # modifies $symbol
 
 	# Add up the line number to the symbol
-	echo "${words[@]}" "$symbol $module"
+	if [[ -z ${module} ]]
+	then
+		echo "${words[@]}" "$symbol"
+	else
+		echo "${words[@]}" "$symbol $module"
+	fi
 }
 
 while read line; do
-- 
2.43.5


