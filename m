Return-Path: <linux-kernel+bounces-352503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F71992017
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A1A2825FB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56C18991B;
	Sun,  6 Oct 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="cai/yuOp"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C41189F59
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236607; cv=none; b=u/WTEeZ9MO8k0jTxOZ5oIfx06wWB3fdTldyPNp4lnwbaBjKi9Qd204rhwFCOrSUxRC00fGxEXiWrxlQXzfAZYz5+Y+cXmggqiGYeF0384rt8RDmXfCZjWfh4XMfXIUrr9znZ7DZuIfUuFO0MzQNZHrl5OEhf+q+n1RXboD7g1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236607; c=relaxed/simple;
	bh=SgkdYgUrVfbNVcDnV2gz2dPiBb4fP51a6SnhD3AvN14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEXdXXBDWvq9ip4Ou8BrR/qr8Uwu73CUHmCfkwNXf78Dds2cCDIByarn0gL6ugM4bQVug8lYIUhR6zUwvr7Crt1lWQ0AUuZlutzp7WuGNXwO3hcXCowopZ/KyXmu6v2FRgpzvmKg6wg6ZgVRZHcWwDsEkwYzz+iLjFfPQrgZF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=cai/yuOp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so697683b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728236605; x=1728841405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djOgLMSN51sHizQfwcHscupKpoOvQDcxpJ2VLwRGCXg=;
        b=cai/yuOpXy2BWZp4hwKeqMb2dCO1oYQJcCfKc1vg3q5DtXezoYNxufhunYsBTjo9j7
         SvsxfmakdomJBZ4MZRBp9flnw+NAKi/UG4oOGxfxSPDWjBAJr1tXlHvpCmQLTpkz2Y9X
         H89GyzZGT4MY4Jw6SJ1AONDzgQkWdhUq7rxETnKxYiRNWdPN38deU5LnJJtFJBhxjk9y
         A5K7fC2NzzoAFVRmf3g9YpuFkeQ8bOIQX49yd0QjAbqC3wAQvHvLRluQ5Joou/Dfmltc
         uWNHNYd/9YGyXqLKPNj/EaoqdlQxk2aJpj01E2IyDpvHSQWgYuCW2yLZXCb2p1bPYPtS
         eWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236605; x=1728841405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djOgLMSN51sHizQfwcHscupKpoOvQDcxpJ2VLwRGCXg=;
        b=LUiyGYYdgxbX3SXtNc6U4OoTIZXKvYNZWfFZuVru81hxOiLWr9VGg+1A8dHLh484sq
         D8CejZYIDBnyYHbTfaGqZQXLTfjDsuuC+HicFMYlrDNla6K7AbiYmHtSthanhfegkYk1
         aozH4dD4wf8ARHrtoiFncLZ1Nc0nt5s9jQfmhSG1WmnNKW58BLEveor+V8Hgt1PMK0dW
         P5Jm8w5RoLZX1xCcu+DgY+2AY59m3iZZq74uZsTSElYMnjvygmvzGpmZgMYWmNXtE91Y
         vyEOF9m/gxB8YGVQc3+Wfh2JaSqTsXPkFQMD67X/oilEry3hb6sItO263Z1df09+7Wk9
         mtqg==
X-Forwarded-Encrypted: i=1; AJvYcCXMculHM6e9m9fBMuNQdVQK2EyRCzYqFBYnbo7Knpe8LB9AjwSOamVpd6i9kMhlDaun9WnEXfcgkq/TQbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7WvA6pGvubALM4xVWF0/m7UAE9wgeRGzwIOc+raENifF2M0z
	dn/CSdvUF38xRJIAy9P4KczoDqX0Hpejzh3Vn9e1TsWiTbprn+6ifT5OXZYhNXg=
X-Google-Smtp-Source: AGHT+IEfzDi9RgOylFPwN1JvO7nrxNbSXiuV8IIZXmhL/38SyLJYVdOoGtu60uzg4Rm52ToOrod0oA==
X-Received: by 2002:a05:6a00:b84:b0:71e:190:c131 with SMTP id d2e1a72fcca58-71e0190c1b5mr3066456b3a.13.1728236605481;
        Sun, 06 Oct 2024 10:43:25 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6526bsm2999591b3a.159.2024.10.06.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:43:25 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 06 Oct 2024 10:43:23 -0700
Subject: [PATCH v2 3/3] pinctrl: th1520: Convert dt child node loop to
 scoped iterator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-th1520-pinctrl-fixes-v2-3-b1822ae3a6d7@tenstorrent.com>
References: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
In-Reply-To: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

Convert th1520_pinctrl_dt_node_to_map() to use a scoped iterator with
for_each_available_child_of_node_scoped(). As a result, there is no need
to call of_node_put() anymore. The put_child label has been renamed to
free_map which is now a more accurate description.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 drivers/pinctrl/pinctrl-th1520.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 7ed3f82b9339..286c6b2b0b13 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -425,11 +425,10 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	int ret;
 
 	nmaps = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npins = of_property_count_strings(child, "pins");
 
 		if (npins <= 0) {
-			of_node_put(child);
 			dev_err(thp->pctl->dev, "no pins selected for %pOFn.%pOFn\n",
 				np, child);
 			return -EINVAL;
@@ -445,7 +444,7 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	nmaps = 0;
 	guard(mutex)(&thp->mutex);
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		unsigned int rollback = nmaps;
 		enum th1520_muxtype muxtype;
 		struct property *prop;
@@ -458,7 +457,7 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		if (ret) {
 			dev_err(thp->pctl->dev, "%pOFn.%pOFn: error parsing pin config\n",
 				np, child);
-			goto put_child;
+			goto free_map;
 		}
 
 		if (!of_property_read_string(child, "function", &funcname)) {
@@ -524,7 +523,7 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 							  npins, (void *)muxtype);
 			if (ret < 0) {
 				dev_err(thp->pctl->dev, "error adding function %s\n", funcname);
-				goto put_child;
+				goto free_map;
 			}
 		}
 	}
@@ -535,8 +534,7 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 free_configs:
 	kfree(configs);
-put_child:
-	of_node_put(child);
+free_map:
 	th1520_pinctrl_dt_free_map(pctldev, map, nmaps);
 	return ret;
 }

-- 
2.34.1


