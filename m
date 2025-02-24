Return-Path: <linux-kernel+bounces-528397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B42A41759
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C37D3A6842
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46974194AD5;
	Mon, 24 Feb 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jY/bzeQt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59811802AB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385642; cv=none; b=tX/RT5arXbDdjNskz5B6KR5dQnB8TlRrrt4iXBZdN/jnE4rH09CvLllaXsiFINYSRSMzrIfqVjpnZFYZWRVotnZFafGQvfeUblD5fi5+KiYAlbllWxcJ1N5p93qq7Ts/I5L6CeWtiyKKZlKbk6ES6iOzRpn0KdomecpqFYuePqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385642; c=relaxed/simple;
	bh=xvUrT34DHgavDlxpE+bt0d2h24qMxOIe02MZBYiW1GA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+nckYIwEXU80H7Hfuz+PtzRdVresJy778xy7APIbxu8APKGK0wT/ImgfK4ObXf/efEMR37skiXT295VLJVtBMiuFFu1ePv4XD/o5SN3Prdrp9svcLauZAv2jDde/Waj1c1k97jbieE6G+QMFjLrz4+U5F343pfDdA2hJOl/R2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jY/bzeQt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so25895025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385639; x=1740990439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Chp5vPq1nTfW11iVdpsrRvjO/EdFmTPF24qIJekslIE=;
        b=jY/bzeQtAcuKhTOXJJ90UnjWM4Epz57SwLhnUYTfQlUCg2jNSqrvmRlxy8xC20RCXS
         SlI1jWeHuTuJse6+qgfRk7kPiUhfPEIfCSWWnw9qDugWIwRwD/DPwfGQ8RZw5wzR5hLJ
         82cT6KBbBqBesGu9to/47XWWYSFsRLKrJZb0mzIFGVeihnD/dPv3WWvSScNRqVuoOsW7
         Z8uZwKY2iTBXMylrVrgFDyKMeGuApcHQTOwPbR76vK33GnXcqfB0/OxtL8MZxXk4rcJc
         HU4m/pPLQHDXpDKEu5zQFMfVy6y5LN9eh+FLSE9N9ADAi5BuYXTEj+cEiJaUTkuUfIHG
         UekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385639; x=1740990439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chp5vPq1nTfW11iVdpsrRvjO/EdFmTPF24qIJekslIE=;
        b=u8UHCCOTYPLlRVe4g97o3fslH6Bd0eHjnwCCilhvn7dI48qlfxSTAu0M+zstr/0CB9
         XHJ7CZgBgjfzHs7cwX4KMd0lFCjL6Ujyuuv5bOshENDaDCsESIN2RtEJTElMYpBGaXn/
         5ntH2TSaN1nijBav84D7WviSDklHxUYb62WGs1oHM19QxsSvG/MpMCsuK+Fr8zzTUEFF
         xitiahur3XFe1Q5pCxlrRkxTpNtnoVvXJIbCQdzJaOC/IzbLGzr1Atw/7imDKhKmdI7h
         0sVY+y6mdyVbDnb0s3IKCqr1SkdXutzKf5R8xwvoCffUZwCYHns9q+KLKWchnLd3eOL+
         6KuQ==
X-Gm-Message-State: AOJu0YwAe2gofD3tF5QfNqSXsG47ZcZht0ay3y9Ev/i0sYjr9x6a5Q/n
	73uPjkPigzA51QpUyYB/GCRXV2NLm6AfRF8qA+lERQS4WiKJ17lCDGTDc4jF51E=
X-Gm-Gg: ASbGnctGdYtn9yYTJW7F8W3wSGSYr9gSOYDjO8Aoezd0Urp4CSNr4xWmBh5pN4LPAO4
	Drws6rPZvYQhX2HHbMwFLDuNcrE6dTmdsGYog7TyvhfuyS1ar6IlW9flFwm8gI6CJbG5QRW5CW8
	XoCnA8bOuo/zDfUsp/GGEUObYvqrIm0HkhTK4kaRyTIh/TsgX8e7CTsX3pnW5Jn6Iozoui+QpwU
	R1ppO/0YRLBUEGCJ9y5L5pd0YAOIlozqMhbrwrFCH2H3Lvnse7tKamHaqnVMTB5c7R5yOmb/WRS
	byyOiZiOK8RsLJAXzWi0p8eXSypcTNamUxXTMq0ntn4xD4xGbdPT3RssaEFw7LCQAqf+BadxuIF
	nY9XHsA==
X-Google-Smtp-Source: AGHT+IG3EN7iHOR8WpEUQAJyeqea7sut3+ULdnp4GaccfhrNdXlAf6zE7rfiCj++pETCwtlmJt1W3Q==
X-Received: by 2002:a05:600c:4f47:b0:439:8bb3:cf8e with SMTP id 5b1f17b1804b1-439aebc369dmr83266885e9.20.1740385639174;
        Mon, 24 Feb 2025 00:27:19 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:18 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:27:14 +0000
Subject: [PATCH v2 2/6] mailbox: don't protect of_parse_phandle_with_args
 with con_mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mbox-mutex-v2-2-9d699148fe4e@linaro.org>
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=1087;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=xvUrT34DHgavDlxpE+bt0d2h24qMxOIe02MZBYiW1GA=;
 b=cU+DxsaQmMMrm7v47So5bWbpGyHdXQjZhTNG7oD2czNK60cAnsahWjjlFA4Fm+cYzvJhDXDeC
 4us+SYjP5bhAqP/ad9Se70OXjUjIK6TD5q0zjNtjkju6iVLwSS6dCem
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

There are no concurrency problems if multiple consumers parse the
phandle, don't gratuiously protect the parsing with the mutex used
for the controllers list.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mailbox/mailbox.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index cb174e788a96..784b56859a06 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -413,16 +413,15 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 		return ERR_PTR(-ENODEV);
 	}
 
-	mutex_lock(&con_mutex);
-
 	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
 					 index, &spec);
 	if (ret) {
 		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
-		mutex_unlock(&con_mutex);
 		return ERR_PTR(ret);
 	}
 
+	mutex_lock(&con_mutex);
+
 	chan = ERR_PTR(-EPROBE_DEFER);
 	list_for_each_entry(mbox, &mbox_cons, node)
 		if (mbox->dev->of_node == spec.np) {

-- 
2.48.1.601.g30ceb7b040-goog


