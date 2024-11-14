Return-Path: <linux-kernel+bounces-408947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7009C8570
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A002228489B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F361DE4EF;
	Thu, 14 Nov 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLmEILEo"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F91DD539
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574820; cv=none; b=nb6bRvqb1+l1+OJqvi+yYoLyKnbzCTsHyLyucwuf/XkHfVVmPh9Xy8UPGi956SfYdYr6EVJisMfxGzNaQaI1Ilth2xcBeHpO0mmXGcamfVqeUYbFNkY+PGIhi8KiBxNDQyu6EUoN/fBHxuqQ3o0XT3YgO/9l8ltSn0HK/ZpDDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574820; c=relaxed/simple;
	bh=swRcq/Roh9GeiOpwIsEok82/Gqfb1Afxwr3Jhujn/UM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mqVYOv82an9K/EFO5nVmnhTdxqgc3gG7tXRkauM07gUUwuXo6VfaY9iJ99V+Y9yX0GpaiaYGvmFST2RzrnqU0Q82CXf5rrhWCwQrlns7Uvxs2OT3dQg5dnyCdKdzvvT6AnytAjjS6cpeUMJybcvA/7Ap40Qbgbc0R2qRn66Ik5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLmEILEo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso429728a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731574816; x=1732179616; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUuh5zltxKYzzRCuxc7b4hEMDJgmD0NkHW3duX4gjt0=;
        b=jLmEILEo8HaSEUaWPanTzQAMedoxiFrgiHgn8QTuixQdmbknOj+ZNBnySV0JZW1XMF
         Hy2vwQolAep9K2IO2GVnfMuw9ZeIz97bwVl2zddyg4j9Bvk/0IBlFWDGl5NNfHNXRQiN
         dyzeJOyqTpCyVUSNdtogd0PHgSohRNFFCBtZcBcF/DvJeIYnQ0rM3F7HdLW0mPdggGf9
         E+AF7SRRn1OE4qo2GIKBT8pOf2RFwZbJ0k3bC8BEEdNfw5sqdOM20G+X2oZqTVBvFv2x
         FQBPufjhTNjmqmSHnUzLg6giqIGPnE+iYv0YZGJSEBLiXm1KJUAfQIBsNTzoky6jy873
         INKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574816; x=1732179616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUuh5zltxKYzzRCuxc7b4hEMDJgmD0NkHW3duX4gjt0=;
        b=TDxPgHjOtC6BqwXMRKac1daNtD9BsALrbJJIRMbZMX/PPAQcMbnSPCXDhcexjbZXB4
         baf+N19VPigdb82V7TptjJVCWdeUYn2nC1JtpGh6Vf/8IT/ufAcU7v8rSW04M+dArYIQ
         1ymzY/TrrXdBkqFlgJU6qihu/fPMKuM4IhbOVhV9PpbX/mcj/bUExSaV5vvrAlT0Oy2N
         Ohzh+3szB1q30b+sgfmmYBZzcSSb9PH73BsNvorb1EClFeicM5BOZKpMVH8uFuRQvX0k
         YRwq6aowfxpjaThGslVYOzxMe9cI5urremK0erUz9TAr9V/45UNIYPuRbK/cR7FE5OSc
         tpKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ha+Y+cxYvPJCm3B/UjCdhMtHs5M0Ivqjr0w5QGq6ZXbW2KqAaDZ8RgEKiCCTRaxGaa3daHjYKw5YziU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDikO73xEkVWqJnkgOSdL/81qnNV/CY0GsEFebZsahl5b46O4
	DCux0EpNBV/5V6OhFzro5/9rhkCqqrDThppQ2nmEKNx9+9P6JnqRVA3YefGSEJY=
X-Google-Smtp-Source: AGHT+IG+X7ovgKI22xZbmdO14U6d1DrAnfqcaY8poLnL8MfOyjsxpg0k9//QEFZXnanxkS4IaXNZgw==
X-Received: by 2002:a05:6402:35c9:b0:5cf:7b7d:a9a4 with SMTP id 4fb4d7f45d1cf-5cf7b7dab4emr314037a12.31.1731574816326;
        Thu, 14 Nov 2024 01:00:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9fcadsm349415a12.27.2024.11.14.01.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:00:15 -0800 (PST)
Date: Thu, 14 Nov 2024 12:00:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mailbox: arm_mhuv2: clean up loop in get_irq_chan_comb()
Message-ID: <40fd7f80-26d6-4cfc-8bc5-f8572eae94d4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Both the inner and outer loops in this code use the "i" iterator.
The inner loop should really use a different iterator.

It doesn't affect things in practice because the data comes from the
device tree.  The "protocol" and "windows" variables are going to be
zero.  That means we're always going to hit the "return &chans[channel];"
statement and we're not going to want to iterate through the outer
loop again.

Still it's worth fixing this for future use cases.

Fixes: 5a6338cce9f4 ("mailbox: arm_mhuv2: Add driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mailbox/arm_mhuv2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index 0ec21dcdbde7..cff7c343ee08 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -500,7 +500,7 @@ static const struct mhuv2_protocol_ops mhuv2_data_transfer_ops = {
 static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 __iomem *reg)
 {
 	struct mbox_chan *chans = mhu->mbox.chans;
-	int channel = 0, i, offset = 0, windows, protocol, ch_wn;
+	int channel = 0, i, j, offset = 0, windows, protocol, ch_wn;
 	u32 stat;
 
 	for (i = 0; i < MHUV2_CMB_INT_ST_REG_CNT; i++) {
@@ -510,9 +510,9 @@ static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 __iomem *reg)
 
 		ch_wn = i * MHUV2_STAT_BITS + __builtin_ctz(stat);
 
-		for (i = 0; i < mhu->length; i += 2) {
-			protocol = mhu->protocols[i];
-			windows = mhu->protocols[i + 1];
+		for (j = 0; j < mhu->length; j += 2) {
+			protocol = mhu->protocols[j];
+			windows = mhu->protocols[j + 1];
 
 			if (ch_wn >= offset + windows) {
 				if (protocol == DOORBELL)
-- 
2.45.2


