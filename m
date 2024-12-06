Return-Path: <linux-kernel+bounces-434699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9629E69E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A010188423B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5F1F12FE;
	Fri,  6 Dec 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbbB6b50"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D81EE014
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476523; cv=none; b=nzfW6oNWj3GTyrtlioaGbkBEV0xtA0Dd2xyodvSdLZYQ9qNaVQoKQc7oxh7I4bj3YCexVnLFR0Nd4AbBqI8O7HCmd9fnqH9oU7IDSI3aptTwUXmnLbHzBPI0SvhynX3uv5v6CZAkUsoN2ZmWG8dj71mlq6LQx5i7RMMKN5GozB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476523; c=relaxed/simple;
	bh=MYzwUtFpbWL9r6VYxqXwzVKHwi1Bcmepx+5EUyvVXBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FkqvJipvv6+ugleHNWgfvAhFNHKaOPxDaShYtfvtbg3THjoIEZCaATBgAIcJpXgx2S7HDW0rOAHPrmakK/fX+RGofnOjx2SShFamiLqw92o0v3JTsFgP+EmZR9zpLgxoqIXoohU5OgDIKHH50KLwREg57KUpm67epxMXXnQkFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbbB6b50; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so11069805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733476520; x=1734081320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+JZ3feBgmuGJFJUNDda/aWNqtr6PNOEfgO0nNPTEuQ=;
        b=dbbB6b509wTRJABZQrt/SUghi5oQ8JJvH7jOcXc+SmHWsR7WFctnkszAz3lq6R2i0h
         5c7BBX4vCqTR91+pX4RDA67n9RGViczz8xbmLpzCktFJZ/fUC6xqmeTexy2mjo3L16eE
         2ZbvPdHWWcjxazL7teH6Y0lxbfICIPE3Irv9SuG9xsA41VPaqbLOmqGhLseyiRKLeQAM
         cBoTQ/RSKNQQ1FMfpmUyzricocGEv6gX+YoaJwLrcLb0uwPHCqm/+1OtJwTec+evXyXp
         iBt3xxstH0D7T2+Yay92ozfS3V77+1UlxbTBzmQJTALxYvPj3BWAAr+HepvYIc3eDhtq
         dxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476520; x=1734081320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+JZ3feBgmuGJFJUNDda/aWNqtr6PNOEfgO0nNPTEuQ=;
        b=OPZlksDPSwcztV5TlvNP9jm5Twdg8cGznfVJXdRLwc97jSqHvs9jFp9gdw8WkaAs1L
         tA9V7eXOO+EBWX5y8CM2b+EWeMoywjpmuoJ9PpVlKrP1cD6hOPdsXs7quGTLwSbkPs1U
         /bmzI5Y0FfUof3nckjPXLXoX4OB+FAYSG7K30aIbBp1X8pJCrhKw+g1naQS9VtkHJkui
         F/LSJaWRmn+jjmfsMj++y+Y0R4J0Zmm0hcp/KXmzUsQ4c3qVpyzQI5Dk0z6Qb8HfGq27
         Vu2WMXYQnNtdyvSUsrygzcdlBTeZy2wtz9T6fah9o+Dwiv0v84cIVMBiesa3q/R466T2
         lkgg==
X-Forwarded-Encrypted: i=1; AJvYcCXhdJMnnrSH4g/MsnMIyPZxmiBcl8m+AB0E2Wq3joW3kxO553lYaYsddDVnQo+aDbjk4c0hPKEjWIx5IiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52CEDXVaybYAyzjvH9L9eX4DU1po64V9GGhUm4Ga8W5hihiwO
	THuOvQmwrdBEfgGBli1Wxs6PVE2pDmIkhoje55yhEO+7uzdUCC4JYca+FnLsAIGl6jlXRTcNast
	wtA==
X-Google-Smtp-Source: AGHT+IGvlgmSL41HUWBgAW5WsyYxVW4mjk2MZubNbT5HwXXppbgMYzun6U3vqW3i+ksER3v8bc0vGgNRHIk=
X-Received: from wmil25.prod.google.com ([2002:a7b:c459:0:b0:434:a152:3ce1])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3488:b0:431:5187:28dd
 with SMTP id 5b1f17b1804b1-434ddedd684mr14502025e9.28.1733476520171; Fri, 06
 Dec 2024 01:15:20 -0800 (PST)
Date: Fri,  6 Dec 2024 09:15:14 +0000
In-Reply-To: <20241206091514.2538350-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206091514.2538350-1-dawidn@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206091514.2538350-3-dawidn@google.com>
Subject: [PATCH v3 2/2] platform/chrome: cros_ec_proto: remove unnecessary retries
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
index ed3623b54bc3..877b107fee4b 100644
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
2.47.0.338.g60cca15819-goog


