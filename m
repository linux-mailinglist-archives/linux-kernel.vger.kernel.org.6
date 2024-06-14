Return-Path: <linux-kernel+bounces-215358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EA909189
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B01A1C25DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A6119FA89;
	Fri, 14 Jun 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMtBnXml"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B620E6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386307; cv=none; b=sgbd7LDgvNUxPwfMCJawMwkbo8BttX+Mt0edS0ZkVdIW4sDl1Cpjf7S5sKaB1KOJcLORRyUZpE5+WE4qGrpd7/kmaE0o8q2cBdyfUF7wF5XHqIySPLuNt0tkVXv7C56/QnU7h1wcrxHpDpExbE3y7vnUiNUlBiJZECXZ70dK+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386307; c=relaxed/simple;
	bh=BSipHlIgDvAU9jtI+0UzoGnMftxvZb9NU2THa75rZr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ht4kojvhi4FI+ndV7IBLtLNWwqin0iXbs+BnCbmhDsEDOKdqrcGx51QLKWaQa7UbBq3IAAQ7ZD2/MyG+1od+cQ6sfRTkisHY8i5xNKquhTukmzwELbbh9Goq6GaD25GU7hRi3BQhrE4kJTroxenjdDdLck4B2JWDtvWFam3JT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMtBnXml; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421820fc26dso20230575e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718386303; x=1718991103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aAn+dyPFDj13W9kA9p8UoX5UEoPcAwL160WAxAoG68=;
        b=JMtBnXmlPkwAZGeP120iN5JmDE7dBxPvv/O/r4PZ2EtSpsOvoafQjb4HqXugYmIohg
         7+oTb+Ca7kqtML11aUm0WEpcHAaLSjAOMqb4prFAJIkZhACXOM+53Ddd3Ts4TyaXaTkC
         J6482p/iPzmWQNq2Kg92AT7omsUN7jj9CMnZ/Fw5XTOk6lNh9cfXhmBgg1VmFRgv6a/I
         pldcPbi/usSIM5+5oWduSQ4SvKD3kS1/MVzno12JCJs/jYFedMRZPoigT8V9cIRA9OVv
         lZpezaREi8rlC4/sSo4dox5JVNE0/9KIz1YXUSoR3uVTeK5Di8xLHbFXUSPtcrzIAc/P
         x4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386303; x=1718991103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aAn+dyPFDj13W9kA9p8UoX5UEoPcAwL160WAxAoG68=;
        b=e4CT9+Uf4dv0Tr3D3Q0bJrtpMf/j9v9s1pWnuCawhVIKecUdQk1E/jNwz0hBDppkXW
         RwLdJIeHLHGv2YnQ///yqMWNVaRM+VpkRcnGtctQ7RUiqIxe8xCqyXxIQ8dAr3vCqPBE
         QHkE/xFHqSKAHjtvXkjt77lK5DZXc0N7XrNY3Y6nmQ8nWJvgUnRNnFy/PWA2xOztw+9I
         6xfDr+mfdNRFpnmrhHhNjpRSY6FeMeUlVY+KYqFOuOFYAoyeQR0XmLKjQVF9XQXfGCmV
         ISaD5E6mVwYfMMyB/XEFEl5j+lqDqnXaG63LvHe4AxvhNe2H31CDZyTiacBTfy7InULv
         nsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwGIXUiuLtf7rvxhstYS/Iv6MYrqJxqlvsSclQhE2RC/s96l4zBP/pKJSamZMXFcIPxAV6tP+IuTL4WqvEzJChV/3NKUvEWF+DDleV
X-Gm-Message-State: AOJu0Yyb9ogdUwDmp4TxfCSKk86Y0T8q13ZMxZyaIPWe0yJ6W+l8R3MI
	eXD5TBojCNobymMd2du83+qJaqN0Yn/NCARcR1n0OHxys4sbA2eMy1EoorYdRVE=
X-Google-Smtp-Source: AGHT+IHG7stbgSaExY65n+9KApXBI+yAhKzMZixuvshFIifsWmYEYNx+9bdoDb5iW6MQiJc8Gmrfkg==
X-Received: by 2002:a05:6000:4014:b0:360:7558:49dd with SMTP id ffacd0b85a97d-3607a75c379mr3218191f8f.36.1718386302611;
        Fri, 14 Jun 2024 10:31:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm4909069f8f.59.2024.06.14.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:31:42 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:31:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] ptp: fix integer overflow in max_vclocks_store
Message-ID: <d094ecbe-8b14-45cc-8cd8-f70fdeca55d8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On 32bit systems, the "4 * max" multiply can overflow.  Use size_mul()
to fix this.

Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ptp/ptp_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index a15460aaa03b..bc1562fcd6c9 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -296,7 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
 	if (max < ptp->n_vclocks)
 		goto out;
 
-	size = sizeof(int) * max;
+	size = size_mul(sizeof(int), max);
 	vclock_index = kzalloc(size, GFP_KERNEL);
 	if (!vclock_index) {
 		err = -ENOMEM;
-- 
2.43.0


