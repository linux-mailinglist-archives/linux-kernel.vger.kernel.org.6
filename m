Return-Path: <linux-kernel+bounces-323229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FDE9739CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DADB23093
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3400142659;
	Tue, 10 Sep 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXpV8isa"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED81940B3;
	Tue, 10 Sep 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978298; cv=none; b=cf0HF4mXqp0S3Jhk9430L1UGCEqRVl7tmWOkAySv+uwO1uLmfBOPpgPQpvQLjTSQ7djgOL+kHCzdnXKCPEjM6gN9yhVOHjmYxGWuWi67aIlNaaC5jNG2c725FwlmFc7HTRQgnAfQ7F2jc4LYsWegzg0bg2gMGWsWS1rdojq2bCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978298; c=relaxed/simple;
	bh=iblGsesf+qatfMugpTsnZooHEzQube0q6SuU9idT9dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LStdODB06CXwcVj9z72Pfe8h0C7Jh4XXZsFJGlDT+aPthX66esnKJAhqavbckuEoL/HseJhQ80G3I4zGvf047ldTkFQdXTskr02sI0GxVNA+Hy9Z4iP+ChitSzxqU44qfrVsgykUShhd0HCqyPa8dL1MtTQCCRg5O11Ap6VTnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXpV8isa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so10156021a12.1;
        Tue, 10 Sep 2024 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725978295; x=1726583095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4vmBAKC5QXfQz0rRIf9Z2p4jESxpl6Ko8ovtsj9BxU4=;
        b=mXpV8isaRb4K3b7uyDEoBlS/7ODxGPQjH2vMbwjS9yVXyQ1PxxJMTtos3evcOz15H3
         9AKXmTk9rIMOWYQNmsSTa58ORCGM9a/5jhkJf/P+hvKNwOQAonUHl98H4DNj9D4ArFsi
         GhY9Z9LYYH46uzVCbeujlYQM5KiaVoWFUFBa9iZPmD/C7YxeUj7db9cWYF7JV1e3teBj
         WcDSSFFRtxy3wIxw+S+Fqs6EZq2fz3tijL0qi4vP+8XyBs1zYOf3iyA0sf0A8G2+WHy8
         2SvLuPvS105Cz52BhlmAaYfRuWWhgRmk33wey40xuXkOGyo2JmNp2eoLqHKXGckiWqRL
         ngOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978295; x=1726583095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vmBAKC5QXfQz0rRIf9Z2p4jESxpl6Ko8ovtsj9BxU4=;
        b=sWDwumrOrTfkY60tQ9YV43r+upGlr19eH37Q9R9R0Yvu9ayCfuKllzp5B1boGuxWND
         a2sUwf3LKI1jqghw9zmyL2VI9GX0k9DCnsAG+G6oidUzYx9m+YcR4KbWzqrdXTXLLD2J
         uBMGFsSidY19irTw7QcnpMNkdgmedgeZv/oabzJvlqALrm+q+S5QcvgxSzUACBYOxVkp
         6clUKzzA0Z8qfi8Z9wh0RYYf/5ZFvHV1Rp5pCjYgkaRU70/VKti75ATPXWBJxLBKy8s0
         cCcGnA13yRi6horkSgFi0BU87b4JGfFmksHypHtRDZRawm82ExlEQVp8SYHo6jVKxJuY
         iRlA==
X-Forwarded-Encrypted: i=1; AJvYcCVnWOUnq/NObr9kzCQlVmraASTBpki1DcBhRJ8bUhXlgNEutyfaOJn22TZT+fLSStVNifW2f8xMyrxC@vger.kernel.org, AJvYcCWcl8PBo9LZG+/V8TNS4PyniBYwFBHrAzP1iS5Do1YJu+jADWmpj7rVrmuEdOS8btNpuNSDMCxkSfsHxHuL@vger.kernel.org
X-Gm-Message-State: AOJu0YyKahrpgT+LOj9lzAGX2LWHFe4CJyKzTLcYQGrJflczXUyxsMPw
	wDhrPekB4yj94F0eFtcmECWNOtp8xnH4K15cLGd6ShHzSstQsSKz
X-Google-Smtp-Source: AGHT+IE324M2oz7wNOu0HvJ0/xO0r1nHr257GxZAcmeyxJSKjssmUPoRJvcXfRI024UG/6LuqMFwuQ==
X-Received: by 2002:a05:6402:51d3:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c4015cc7b8mr3899021a12.2.1725978294468;
        Tue, 10 Sep 2024 07:24:54 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd466dcsm4332012a12.24.2024.09.10.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:24:54 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: robh@kernel.org
Cc: saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH] drivers/of: Improve documentation on match string
Date: Tue, 10 Sep 2024 16:24:22 +0200
Message-ID: <20240910142422.341672-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The description of the function now explicitly states that it's
an *exact* match for the given string (i.e. not a submatch). It also
better states all the possible return values.

Moreover, this commit also makes sure that -ENODATA is returned if
prop->length is zero, just like it's done in other functions such as
'of_property_read_string'.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 drivers/of/property.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 164d77cb9445..1ff51d93178f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -452,12 +452,17 @@ EXPORT_SYMBOL_GPL(of_property_read_string);

 /**
  * of_property_match_string() - Find string in a list and return index
- * @np: pointer to node containing string list property
+ * @np: pointer to the node containing the string list property
  * @propname: string list property name
- * @string: pointer to string to search for in string list
+ * @string: pointer to the string to search for in the string list
  *
- * This function searches a string list property and returns the index
- * of a specific string value.
+ * Search for an exact match of string in a device node property which is a
+ * list of strings.
+ *
+ * Return: the index of the first occurrence of the string on success, -EINVAL
+ * if the property does not exist, -ENODATA if the property does not have a
+ * value, and -EILSEQ if the string is not null-terminated within the length of
+ * the property data.
  */
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
@@ -469,7 +474,7 @@ int of_property_match_string(const struct device_node *np, const char *propname,

 	if (!prop)
 		return -EINVAL;
-	if (!prop->value)
+	if (!prop->value || !prop->length)
 		return -ENODATA;

 	p = prop->value;
--
2.46.0


