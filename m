Return-Path: <linux-kernel+bounces-545448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5898A4ED49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D151016B567
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B61D7E35;
	Tue,  4 Mar 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV0Io9mz"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DD25523D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116395; cv=none; b=PD39LolwUb4namQuzs/wEywq0zRcqXtnksZEd70BP8phApl3VIwtk6VSx6XtH4S1Nf7F7bpus5PuGkhlSPAETgg+QOM+Ixu6QGbfs9qnVVp7g00aaIrA7XYywMTEOSra/+rSRd9e09QyFMEIlIV7MHveM/FNPTlWCHBoaTODN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116395; c=relaxed/simple;
	bh=NEykYa6nBJlJKdA+LxhOzDhIzGTSaWYAg1h4SZwvuT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4ezf0PGHQxrbUrjKPiYHh3fmQTJBdcXNCJAaQ+5UYNr+AioGha0qY5c+Mr7ZKoAByvPb3hp9WEAAAG4rJzdWAhGU+/SApQhV+vA7ao8PLjIBS0NNLhBgwMpAgDDeHj5q5n3NA85Ng61txORTldjN4NlLMtEdKCINR40LxMEgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV0Io9mz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223600d7968so15824785ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116393; x=1741721193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umdvFfee2QDZToWwgiz0AxJQsONRmaXngrebXX30i3U=;
        b=HV0Io9mzz1GVUXcPhlfewLY7/jyL/vkWQh9qvX1k/uOJduCUTALGJjwlVBctS6ZleN
         Mt/mOVC4G+iOWFq42zwBdPSrxv/i3/ngXar3kInwX5e7wduGzcAMlIpUStTMaAXqtCA+
         7A1QIg5tly6t8FWsmYgwxrjb3+GcywhDpb1pyt3I8InVkRvW/AM3pNeLfBGAQQTFYAm0
         7nePt33AuexrbU+faqFGSlRDi7aM2S4rXFh6U2fKi1Nz+7fzmK/FUaYWoMnbrGpi8U1T
         vmDNM7UWdffQdF21S5mZwyz470kH0SKnwN6VwVunabe9rPj90xwDcImYv6oVNlNs8CvK
         0f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116393; x=1741721193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umdvFfee2QDZToWwgiz0AxJQsONRmaXngrebXX30i3U=;
        b=O6DTKWs02i16gJdaM5qxY+pniTmqYNuB8M+tJCi2GIzKWVF4FCANbRtQI6Ter9HMeN
         4ukilhJ459NqpdP9vjUBOWaw5jBvolckvW2yL3dH31bs6/rw6cw0BwpsNYVuLzhpUXha
         S6E9pe1wbnd5U8v6LqR/oxaOXiMrAPQ5BVyvn1nw84M4WNXsOugDDf8DZvxffzh+qFTj
         XOMitgcqBdQLPhE5bGfd/Y4iIeumsg/OpwaidizDJXLkJT4UDM8HgtyD6KP2GkIa5B1i
         WqQ9C4OZDKUM2Z3Unx6JwW2wEM9db8CM5kA76686ADMCT+tCK0DlSQas9suIMhIp0IY2
         e9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUp8XYVjEjQqDHC9PYAFjIkEmk0p6gL+0TrdBmF+CvKJROtBXL3cJmMaKWKDbzQ0+xhYaycbwWzrl1YI5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54ksnzgPURSWCC///vJmLccIFWZFAbBYCEAbT6kS6eMIK+TWr
	K27CxQxLp9gxQrYieAo6XqiJFXUw9ApSzbkwnmIZQMupvlWeqz/Lx0r9IA==
X-Gm-Gg: ASbGncvGqwWiJoOojM6CzOmN+JJ1Y6Xyn1u5aPxPBFmxdR100hn3DT+dQObEguRJgtj
	UvOZEa22xA7m2pKjYPNwkeKG4UjW89WNjFNOI+6dFTxn+OaTAbGMDB4++coFCKgnmGmKSFRb8Bo
	YdQjfuzPRyxG09IRa2IOx2VpyLqXFgnPSTIMpy3N/SZT0eHdo7gDPS9rMlv1v1NZxbv6k9bX0s/
	6RVVwyjzlB2Ibwdc8/hSKLhKB4bcYG6DdMztM4Ew8O47IRz5zNgHIMwMiqt6GlrScAkAAW2JeZS
	jW0QII7t+QGB2ZqSKIBEpSR/QNI/KsOMu97I3L8duVGy+RMsP9CHgZJr8A==
X-Google-Smtp-Source: AGHT+IEqlNsMhgysH3ZLbRHN5sn24UmXlsfGwKRCgpcjb42zOsTM+0OVba8x8VgswqlxUdO5C6PZJg==
X-Received: by 2002:a05:6a00:21cc:b0:730:915c:b77 with SMTP id d2e1a72fcca58-73682b5b913mr54352b3a.1.1741116392829;
        Tue, 04 Mar 2025 11:26:32 -0800 (PST)
Received: from localhost.localdomain ([2802:8012:1f:3200:f1d1:c186:ba5b:8f06])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm9341920b3a.60.2025.03.04.11.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:26:32 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH 1/4] staging: gpib: fix kernel-doc section for write_loop() function
Date: Tue,  4 Mar 2025 16:25:37 -0300
Message-ID: <20250304192603.40565-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250304192603.40565-1-gascoar@gmail.com>
References: <20250304192603.40565-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a colon character in the kernel-doc section of write_loop() in order
'leng' to be picked as argument by the kernel-doc compiler.

This change fix the following warning:

warning: Function parameter or struct member 'leng' not described in
'send_command'

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 50faa0c17617..eeabbdb39057 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -232,7 +232,7 @@ static int write_loop(void *dev, char *msg, int leng)
  *
  * @board:    the gpib_board_struct data area for this gpib interface
  * @msg:      the byte sequence.
- * @leng      the byte sequence length; can be given as zero and is
+ * @leng:     the byte sequence length; can be given as zero and is
  *	      computed automatically, but if 'msg' contains a zero byte,
  *	      it has to be given explicitly.
  */
-- 
2.49.0.rc0


