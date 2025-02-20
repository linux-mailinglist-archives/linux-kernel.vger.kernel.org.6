Return-Path: <linux-kernel+bounces-524713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103CA3E620
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03E54226CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19516213E7C;
	Thu, 20 Feb 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVJyqalt"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8E1E4AB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084815; cv=none; b=PF+bKfifbB9JVnb9O0rSyU1+Vt8DMztU36vLn/i5jfyW6XYHg7VBJHr+9i85ZV6V7LNu7WOxPtLzpzbOb89xmS7RXanA6kgTvxUfhZuB2S+nK6Ecn5IRTtmxvAXSndB35s1GhlWg0smCwVhvc5E/4gmlcODBJgllS6KwG2Oigt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084815; c=relaxed/simple;
	bh=F6Gz/kBZLmytmoJwQqYda4mAMUsdNXBQ4dAWhHiHVj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LDxpNL7+GNppB+2Xf88RhSJIjRzt1NotzeVe4FR6o+3wI1virG4ePs+v7CBd9fqFwuq8niQUNgCVRkF/LLUXMOZXTVi57i81o/dtrWeWqUg3YKrQMqNISs1jKkQNKQu88pvD5+rWpxh2PDWSKIM0+MRC1CFIcdQzdddcZho8xhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVJyqalt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a04so14781661fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740084810; x=1740689610; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfjCFL2hZG5MHqFaq9ZdLMFWkHD6C9ALeS2JSC7WLYY=;
        b=PVJyqaltCJA+tRuF3h1vJp1TNScd2hsAUfWipmzPkUhbJ+ifOL5N7SzwoS9EbVLqHc
         M0V0QyhlzZaoQbA4jqPUXzM9IoJn0ep8J4YXiYryucABy8QFCVJjfGBLtx1kyt5oSx7N
         1z/6U9LbzX1wqwAbGEJcNS3LZ7CGTo5Vze1jm1TOHu/+SYIYodsJ5GHLcOMP/ngGRyro
         rtK5Hfl/YD67gxKyQF3Bs5pzz09wdX4YRxuH5oJ+cRGhurPLOdZ8EOaG6LXm/BlRPwjo
         YuVPzws0e5OcjfGa4fkwZpyi+E5IXhx9ZzloGujxCfbSocZB2ga/dK99YKsxMB6Wc6ir
         tw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084810; x=1740689610;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfjCFL2hZG5MHqFaq9ZdLMFWkHD6C9ALeS2JSC7WLYY=;
        b=LBee5Vod1ydaLRkaS9A8LGkL6gFfETXv+qVvEvYzBbKP+FBkdyKR3dVwQ0k6svTUcL
         h46C9toQRnRqUnR6IGp71+OuEAvRhEmFom59LdRwBsViJUMmL2bmzd+WHAGrAzq298Dc
         MIU5gDeq/ibKeChFgH2HjPLH8VC0XpjmA9Ni1ANFSpDvBf4VH/sW9m/VHir5oKoXg5Rd
         9VFyXw8i+hH5PmwwpeC2+AsIqAqLaTwMMhO1UerDMvagbXNk6Wmf37W10fpckA4Ik3tz
         vNzQOCuWfjpmONjxDlyjNSgGsNspaSArs7+msTkNRdp2aHSdkuJ5LBR5a6EuK9uX7sQR
         Z89g==
X-Gm-Message-State: AOJu0Yzd3XSxr5FO6+MvdE+UgElenwcQGEDzDe2Byxxhvtp7gt4tmgo/
	YicwASV16qJghg8isuae6e/oaQQZaSZ3GmA3K0v9xwIb2xUK7v1XXkpu8GE7e5I=
X-Gm-Gg: ASbGncvTJKohK16+oSEW/S11Ome6TlP7DjENMgrLaUe4IGsC2cIWUiPYUEzCT/Ckxwm
	OensPm/6fSyfrBCEhDbMOmp+isam0C82IhAA+VPEb7HUAtS+yCItTTsdGd3Jt5QJ8kLoq/r+fDc
	mz9Lp36jp3sw6A2ptuCm1ye7MwBcoiHQ5rpiSEk7T3PlofVDAcztyN2AYODYFHjVg24lU8aLlhV
	Vw1CHbisYB3qgQAEZ8ywWLwqR0cp6JkpmXh9NLRe9qR2evUzZaFBt2wJ0jtmuqcUCxMqRGgEh1J
	NOXoBzjFSgI/5ElH
X-Google-Smtp-Source: AGHT+IH+laBghSOr3N9TleehDO6hUVwJSpDeK2KCNyD3iGIDvHRY3u30ZUHg2dA0puDdUrFYSeHJ1A==
X-Received: by 2002:a05:6512:110d:b0:540:2da2:f282 with SMTP id 2adb3069b0e04-54839259822mr144479e87.42.1740084809481;
        Thu, 20 Feb 2025 12:53:29 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461e202368sm1523113e87.61.2025.02.20.12.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:53:29 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 7A76C5A011D; Thu, 20 Feb 2025 23:53:28 +0300 (MSK)
Date: Thu, 20 Feb 2025 23:53:28 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>
Subject: [PATCH] firmware: dmi: Respect buffer size in get_modalias
Message-ID: <Z7eWSCCqp_HP3iSh@grain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)

When we collect data from DMI data the result is accumulated either
in a page buffer from sysfs entry or from uevent environment buffer.
Both are big enough (4K and 2K) and it is hard to imagine that we
overflow 4K page with the data, still the situation is different for
uevent buffer where buffer may be already filled with data and we
possibly may overflow it.

Thus lets respect buffer size given by a caller and never write
data unconditionally.

CC: Jean Delvare <jdelvare@suse.com>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 drivers/firmware/dmi-id.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-tip.git/drivers/firmware/dmi-id.c
===================================================================
--- linux-tip.git.orig/drivers/firmware/dmi-id.c
+++ linux-tip.git/drivers/firmware/dmi-id.c
@@ -103,8 +103,12 @@ static ssize_t get_modalias(char *buffer
 	char *p;
 	const struct mafield *f;
 
-	strcpy(buffer, "dmi");
-	p = buffer + 3; left = buffer_size - 4;
+	l = strscpy(buffer, "dmi", buffer_size);
+	if (l < 0)
+		return 0;
+	p = buffer + l; left = buffer_size - l - 1;
+	if (left < 0)
+		return 0;
 
 	for (f = fields; f->prefix && left > 0; f++) {
 		const char *c;
@@ -135,7 +139,7 @@ static ssize_t sys_dmi_modalias_show(str
 				     struct device_attribute *attr, char *page)
 {
 	ssize_t r;
-	r = get_modalias(page, PAGE_SIZE-1);
+	r = get_modalias(page, PAGE_SIZE-2);
 	page[r] = '\n';
 	page[r+1] = 0;
 	return r+1;
@@ -163,7 +167,7 @@ static int dmi_dev_uevent(const struct d
 		return -ENOMEM;
 	len = get_modalias(&env->buf[env->buflen - 1],
 			   sizeof(env->buf) - env->buflen);
-	if (len >= (sizeof(env->buf) - env->buflen))
+	if (!len || len >= (sizeof(env->buf) - env->buflen))
 		return -ENOMEM;
 	env->buflen += len;
 	return 0;

