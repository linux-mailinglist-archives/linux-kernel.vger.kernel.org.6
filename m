Return-Path: <linux-kernel+bounces-311146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F5968579
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD7B216BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAD184542;
	Mon,  2 Sep 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eww5u51a"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F4183CBD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274629; cv=none; b=IcH3t9XDreD69MLa8tA4UW8gyCk3OGYg9A9Pafdp3HceyCtOyAzX2bXvHQZYbaqPl9QgU3Km3Cg2cbPGnm/RCd2zR63U9M8ksa1DpQMjP853NG0YoIsyZNlZiXNzF4FB369kHc2wdZo77b2HvxXNQaEVzEO4rt9oF1+B5rI2trE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274629; c=relaxed/simple;
	bh=JxepjFnMtRuygEBDtjQvbjzq746vSN4HFi0W3wrSFXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FijHEhpPMwmZZumtm1wyMVU0SCcO6ARwXQS5PAUEOXBfkRNtb29rZYul7SnD+jM6r0ZudgLYVPRC37+J1UeDZNkDfBdLgvxUr1CKrrBh5mrlcxl9zx0xnrZsctQZDZgpIqrAjLzJ30XIoxvLipfXIVpzQKNNZXH8xyTweV+DlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eww5u51a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7176645e440so108173b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274627; x=1725879427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeSoou3zgF2h9jQS3JrWUn4yreFPlJkSQIhQBpDBwWc=;
        b=Eww5u51apokEpoSIg2T8YcQXvntXOE/zBEjeIsB0IaoeBIJD0xNWOmrqeFwx7233Eu
         bdJzSZnxXULw+rHi5MhwqmyEeuBOit8yAYcTPaMPsA5kUB+LjTahZhiZgx0of8/VT0AL
         Xiuylnea1lqfs6w4rNSXppY+JxAPLAcJZTcvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274627; x=1725879427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeSoou3zgF2h9jQS3JrWUn4yreFPlJkSQIhQBpDBwWc=;
        b=XBLsBmTxDSFCtW++H5yYo4UwVsbbeG7dY/1iyZMxO16ljTQiL5ZlUjEepCIdh3vIps
         9c3gmbbq/W1JcNp++ooUL8Dmp7oikJ/Ff/VyFKhTXiGmsLL5kjH2qDCzQ9M4InmOQIS4
         HOcXVlmF9EbsopXb9rtcpI6uXAMlgJDa9mjanLR0j6uQ4iyHhblxDQMKqkA5Ap5secmk
         17a6jfksmWfZQdtBEVPu32hC5WyacHqcCIkB6q8+bTPwqiP+Q/4syMdd/4w8sdznAAjk
         emGRiOfx7vzbzN7LgAP2oxG5qX0iPnjHKF8y1R4qPLBG17oR1Y/odpQeZM53q9Vx8fNW
         vhFw==
X-Forwarded-Encrypted: i=1; AJvYcCV+h4m4bcQyPP/Xf3yWYJkHF4RrCPlWaBstDMN5sGuJZY7Ref0BLV74pk8Nvrn4VmqwypqhkyQl1CjnUUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyilvEgRsBYS2rMchol8BNaqKw0PuZ+MkMQzdJ7n5cww1E4pyBb
	+MeMw8PJbz5/YF1E8dpMT2VL7bcbdw2NRI1Jf3oEy80UMFNe47Um79DmJnoPug==
X-Google-Smtp-Source: AGHT+IGj2j+PSGRCvDj8hb6UWgPVIXwbq44Io6Y9oDly4UdDJNLFucLbnheZ8LDbLRAJnwkUhm36lQ==
X-Received: by 2002:a05:6a00:181a:b0:714:2922:7c6d with SMTP id d2e1a72fcca58-715e101f8d7mr25849320b3a.12.1725274627388;
        Mon, 02 Sep 2024 03:57:07 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:07 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv7 02/24] lib: lz4hc: export LZ4_resetStreamHC symbol
Date: Mon,  2 Sep 2024 19:55:50 +0900
Message-ID: <20240902105656.1383858-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This symbol is needed to enable lz4hc dictionary support.

Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 lib/lz4/lz4hc_compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index e7ac8694b797..bc45594ad2a8 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -621,6 +621,7 @@ void LZ4_resetStreamHC(LZ4_streamHC_t *LZ4_streamHCPtr, int compressionLevel)
 	LZ4_streamHCPtr->internal_donotuse.base = NULL;
 	LZ4_streamHCPtr->internal_donotuse.compressionLevel = (unsigned int)compressionLevel;
 }
+EXPORT_SYMBOL(LZ4_resetStreamHC);
 
 int LZ4_loadDictHC(LZ4_streamHC_t *LZ4_streamHCPtr,
 	const char *dictionary,
-- 
2.46.0.469.g59c65b2a67-goog


