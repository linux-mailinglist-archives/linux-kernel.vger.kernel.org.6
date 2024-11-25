Return-Path: <linux-kernel+bounces-421522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B00029D8C66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AEFB2B49F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23961BBBDD;
	Mon, 25 Nov 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFbQKNF/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67B1B87F7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560294; cv=none; b=s8wU2B6HFe81KsAeCDasAkINP9MjmtNxgFk3noj2BfpmFfEF7GSgkoeD2+1MDbwZatSo+BBoESt3xLytFV7jdtqUrYDLg5PDIwHx2wk3InxMcZKtHJXGkj4k9AG3i/Vu6RqEGNkqyXcowFLAjxv+Z9xXxP370bqxI+xos/Gj75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560294; c=relaxed/simple;
	bh=Q97WxV+deHkaj+EQZVZEyIuB9CBgjeEs11MlkDNh6d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POfxkhMdrQHD377jEGzr8ROLMy6g2Kvd4hcy2bTKmfaISpKLLjUOsu6yNmEpDe+JpCgqpgWUgwtI4FYSZVy6WAe8isEkzhr3T5Myw3EpFV9yojQ+tyBDbanVOIHR/BvTg8OZekF+VryEPoxhhOcvW3YK8K9ndgXviloDHGpDWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFbQKNF/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a467e970so1891855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732560291; x=1733165091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtpXYqsS0NdiYaBAh0AIOimkoXUPZvaUqei6YAtjyX8=;
        b=RFbQKNF/Ry1jNF8lzaT5UtqBU9akKhbW1/W+9UokaUopZFclQyaiGgJ+xL4WleUmP1
         TUYaWvIOz/xVvdXoKUhazmFuzqc7lJtGRgO/CG73Icflie//SNda6LOcJQtSFN0AFAXA
         Tk6YxHToDBpX85y0AylJhDnBLCasB/QBNnfjPYBFmOFJZY2isFNeM5kv2ExYlD/+7t+r
         az3eLyD+wUaPPwCp4LVXOF21GoXzkTRbz0sms1hVSVQX6GPEabNZEUMKouRI6/OygjQ0
         /0Np7MFT2R4yxEn1DFXmdfYd0OgQrHWS9m0xCLdbH9lpILKXUPPwoJHYeMtyQXoBf2iN
         gg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732560291; x=1733165091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtpXYqsS0NdiYaBAh0AIOimkoXUPZvaUqei6YAtjyX8=;
        b=qX1Svn/qQUghcY/9emtdWtAyz6olGlN2VwzsH0XrYiFuCad2lXwLfFdE/cFcnXNF+W
         p5lutD5M/7qNJMO52DqEoHMl3b8YnnC4CoZfA2+Ku1aJuhns+mlMfMlGJTSvJfsi63p7
         USkNJFUPE+VSum36xGg+nbb5u+ROOa8TwjgwWhH7yWGj64ZLVf7P86jeUHrYx51OW5WH
         x5K8d3ZLpc9Ul5fSnm+TYJIbzF/s1lp/w/gFCWOjmxoXMeKhEav5xejELkLiPi/CcyLI
         8npASttxkogcbPDwthoWIpyue8PfrMzdLKCH15BHz7pxdf28Lig1Ea5KqVqlsYbjm23w
         dpow==
X-Forwarded-Encrypted: i=1; AJvYcCXoj06yZIQLfx1rcE8Is5lywmAAMu4rqayBTNW/EGNN2/cOsypYvIiio+WVMo1Z4zBin+SV0kFawRQW07g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmG/bBjeC1GUcaqBGwbZ6fg3zxqr+ajCbSHqQANqGReECMIFR
	PxIUQDOJ5UOIQjf6lyrRe85DrVgEutpReollBS/2UDCpj9C0tPQtnOXm0Vt2QMAArR2Fdh+IBDg
	krA==
X-Google-Smtp-Source: AGHT+IFqAgWsc3cSfksqwNnmQF3h9k00tU70CrRLdR8LZRHhlAR0EBWKX5d2hqziGMkGIQsHG3qViO4UmD0=
X-Received: from wrbfx7.prod.google.com ([2002:a05:6000:2d07:b0:382:4faa:76a])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6487:0:b0:382:4725:7612
 with SMTP id ffacd0b85a97d-38260b4d4f1mr10781274f8f.4.1732560290920; Mon, 25
 Nov 2024 10:44:50 -0800 (PST)
Date: Mon, 25 Nov 2024 18:44:46 +0000
In-Reply-To: <20241125184446.1040187-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125184446.1040187-1-dawidn@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125184446.1040187-2-dawidn@google.com>
Subject: [PATCH 2/2] platform/chrome: cros_ec_proto: remove unnecessary retries
From: Dawid Niedzwiecki <dawidn@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, Dawid Niedzwiecki <dawidn@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the retry of the get protocol info command. It is not needed
anymore, because RWSIG continue command is send before start of the
probing. That assures the EC device is ready in RW and there is no
need to try again because FPMCU is not fully booted.

Signed-off-by: Dawid Niedzwiecki <dawidn@google.com>
---
 drivers/platform/chrome/cros_ec_proto.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 4bd17ddefbd6..c7bb9ac87da8 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -366,15 +366,6 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 	msg->insize = sizeof(*info);
 
 	ret = cros_ec_send_command(ec_dev, msg);
-	/*
-	 * Send command once again when timeout occurred.
-	 * Fingerprint MCU (FPMCU) is restarted during system boot which
-	 * introduces small window in which FPMCU won't respond for any
-	 * messages sent by kernel. There is no need to wait before next
-	 * attempt because we waited at least EC_MSG_DEADLINE_MS.
-	 */
-	if (ret == -ETIMEDOUT)
-		ret = cros_ec_send_command(ec_dev, msg);
 
 	if (ret < 0) {
 		dev_dbg(ec_dev->dev,
-- 
2.47.0.371.ga323438b13-goog


