Return-Path: <linux-kernel+bounces-430983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE679E37CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4161C2830D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B81B0F18;
	Wed,  4 Dec 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZZB601/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7C18C92F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309122; cv=none; b=WEzMc1TKYf9I+P/YgPtUoG7nuBTu8hkThU1sL/NkmfHwBFQYZg2PB+JNfg+5y6ExXgyvSQq6aW4wRq7HscCUedSNVAXf4wxHMM/sIzUOl4N4ZWOBuupECw/sK1UrqnIHLz9pdTJ6Bidztl2Zwx6RpOhdFN9tvKFrdzdG360xFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309122; c=relaxed/simple;
	bh=6ABzvr6unTAz8/XLgLI/eNk5SIQaJ8uqIkH12ItsGbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b8nPA4kodN0s4/RBWWYQv+QnFNgL6EZfyvws7fQsuoeqO1q9cFBRB077fNyYMruXBmBQX8i82+1EhvDcl+iLPTZ7lbHVFSxbXTJjhdL3subVMeSMZv+jygHcLmp3jsvDl3+XyCpoYTdJydJzKbfiblMK5B/ArhKV9AHvuRM3wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZZB601/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a0bf9914so47210315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733309119; x=1733913919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3syshFz8xNToh+qn8VphOqjnxGVpP91fDVz4fAB19M=;
        b=2ZZB601/umvVTJbB/kFTZZTR5cn8AxB+G46nCnzYPVx9GN9mBDjA4Co5NyZKU+dQ/a
         DsKl24TvvGAtCngHF/skjKNBPVuQucT41tcz8Rj/Z66rGodont2UKVBE4oK+cFXep0Uc
         NiugNqjZkMdpXB8XQeh/hZHauxH10w+tSApLm3TD0LBdLPkFohSU8HLlvYVTYRbv2Ukp
         e509h/74naOh7CX0eHyQ03nxvlIx7VgqBpSPQUrD/4+78JTTi/Xo9wLVRTpP3T7rpUQ2
         sYAdMTClcvvVhxvqwauCqytLuehv++oU6yJivSVEkDl0JrmZNV56vQc4ztyomumYHzOf
         KNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309119; x=1733913919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3syshFz8xNToh+qn8VphOqjnxGVpP91fDVz4fAB19M=;
        b=I0v21bKqm7YoAG/hgdzy7+X6oKsLPA8jkIbeEAX9qGBm1xbaGAvNOBuc+mmDEAp9w7
         6x4UQd35uJdM8NjJoCRmWP1hxygOjysFHl4fLnIGfmRQAYT8VgqfXYFNZyrMX6bebW1C
         o79xDAnRFquvNR0v+HB+mETlhazH2+J2uJqdNcQj2yTRsOHOkbIuCEJtjluR37rT4/y2
         MmI/If++KYxfE4vQmLJe1utl/VkCDonIC7FoMU1c4cp/bTcYvJKOBw4rCCs6DpxcwmaC
         v1SUuVYARNJSjXmm5yms+EAKXgehjZmhVcUXpMHve6KSwiUjoW35usMNg93zI1Zio3L5
         YWrg==
X-Forwarded-Encrypted: i=1; AJvYcCWJGNoJ2OGCSkdXxHMBNiNuNBRhAHGDESGkabCYHqtF5gkqPyrv/6qnESrsHOCJcW1LAxKKZ52iaW0zqso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzna+Ig9Cq1VUDzKIIV69cI8YpswmRrR6iqgWUXojF/9NzRk+Dd
	hij8a9olAz3py2+APh8SD52d6MUESbrOoRpI09JPzbdsm40rZJzjh2Hj8X9g6T5qwnmOrlc4hkC
	7YA==
X-Google-Smtp-Source: AGHT+IHunP8FhVAqcbAxizHfk/ZUvf9lDejn99ybNwBIyZAYS1noMkvMq/IFx/7VnRvYK1UwBw4/MParSvQ=
X-Received: from wmba12.prod.google.com ([2002:a05:600c:6dcc:b0:434:9ed7:8b97])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b8c:b0:434:a4bc:535b
 with SMTP id 5b1f17b1804b1-434d09bf66dmr50011475e9.11.1733309119162; Wed, 04
 Dec 2024 02:45:19 -0800 (PST)
Date: Wed,  4 Dec 2024 10:45:14 +0000
In-Reply-To: <20241204104514.1541964-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204104514.1541964-1-dawidn@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204104514.1541964-2-dawidn@google.com>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_proto: remove unnecessary retries
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
index 9b451fac275d..2b90eed3a439 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -368,15 +368,6 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
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
2.47.0.338.g60cca15819-goog


