Return-Path: <linux-kernel+bounces-526213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D693A3FB9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1577A499A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78CF200127;
	Fri, 21 Feb 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNlFCqKS"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9C1FF7D3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155700; cv=none; b=vBFK1/vGrDmPUD2g2W0t5XIgvlRT1gwTYJJCPjqrSuBKs92XoF2o2PF6MrjQTTtSTzN3ok+4RIgIx3nAE40CkCEFWccwW5b72dx4nxJp1IpB0fxGZPKIvSiYW6eyrF99lRS31iErpVDDOQX2jBTCt4NYzoRsi2ao5Fga7aPc9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155700; c=relaxed/simple;
	bh=QfyKjw4MDCgZaOxGfN2uwVxtfrJyJLTRioCkL2n1c34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBeT9aumpAGehGjSyFwy2HvWCwNsKUbKiwGt6kvJmrnwTteRLa1DoyMJyxGYtwWjmTGsBsW30Kj9tTQOMrHMYqUPGM/fIne7HXOprrMHIiitZSR9B+sv+pLp5sNS2pWhJZacn3FuDGcPSdcM5DUBcOHvxfgN6f/QSO/pPt4v0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNlFCqKS; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-220dc3831e3so54120475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740155698; x=1740760498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55B5QwxESijKOi7V8xRhvFTRJ/sEBfufvBcf3pQsyzE=;
        b=CNlFCqKSNkjB8FAUbo5CeEgPkoY2nZC0KEak8DaSi97Fkdpl6gRg54Y6oo4RlT2v0E
         oaiZB8NfkDWtnmlqA7SxlFycrWUp+spxGFJdd4IX55xq6jCv5WH15GWpFr499+FxexAB
         XKX3bfvb6CkLBvULKdVZpmHu/Kxot5HQHlvjExgldtakG/1mhzD/wRSQGMruEVvvn25N
         CLw386InI+TrdsjUI5S6tuXMXjy9u65uvRpEQs/6SZv01gHGKMMqdjfwHNxIzpYSyd8a
         cVM2qmtCD8uME7UPddCwNUyITZFbSKpocs7qitzEVh59Ei5YpAEgLCsuoUKYMmx+vEkG
         n5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155698; x=1740760498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55B5QwxESijKOi7V8xRhvFTRJ/sEBfufvBcf3pQsyzE=;
        b=TBp2NtS4A4tY/4kThkBWuo0jpdw4AjY8qYv2YjzYWjqysCKBl+n9cgoF+BJFXYMY2Z
         4Djn1hAJiIMwE+6WiQlK3xiccaycUq2Xaw6GQS+FeWGL96mmFe9KBqpXz4U7nDpvJLKn
         8E4A94uuK4h94GKjCflFHTWXe+s84qUIdKxLb8B2S1XkkQHzyYHWUwKh15lIdKbQGv9e
         s1OHxdLZMurFlgTQAFnVmkjt5A226cH+VRnzBfubuxQAFAd3NiyNGGn2aFAxEizjWZ8s
         IbttSd42qO/dzccUBC/pukpLPapwfXCHfOcSf+NAjV+aKE9V5wJYbAD5dx4U1AQ/2I46
         t7qg==
X-Forwarded-Encrypted: i=1; AJvYcCUiwDkh8wx1++kg0UOl3LA/Y9EKNfkz0ZHGhGmh9hYNQcXuuBLgnGRoxixlV4F7fgck5qJtpRMpDh+sjlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYkFe5DE6kknhPMbDYo5oDssIMNoKpY0Xq0hF5xQBcLgWelW/
	grnhVc1WuXXbN/If5UGVQT9Vnu6v64nzTAFxZ1asg6Styw8grLjm
X-Gm-Gg: ASbGncvSjP8TpDpBYFybxWnAQgwr4hZ+izeKxtk4L4z6Z7jZ8HnIn3KMDm3gaD6wJNu
	ZAjteESxDk2p2sNj2cIYGBvF76ZHoAc/nHQKHkyVTOpvpXi7A6tUFNr3iXrrKszLo6DUVJTLb28
	y6gYKGN4lyeBtiUIlNkrBbVjYRYGrfDBcshGZJbtuFzi479Xmac3/3O1LEOcDg+5Ke082DqTLDl
	6ckNekp5MLfYYgH4xewzJaLDsG0GIKzuSFt3XRMgiSzIFP0lktwfBoSe7tke+XNxefVgla3lHMV
	FDU0dKtK3JbTPZw77g7X9sAySh/asF1kavKW
X-Google-Smtp-Source: AGHT+IEZeNu92QMCNh9gLmafr7bxvZD2AJeWhv8BdshyKgPltTrzaPvmvoUSi8ZlWUY12jQ5Fff8vg==
X-Received: by 2002:a17:903:2f44:b0:221:1356:10c5 with SMTP id d9443c01a7336-2218c3e37eemr128835685ad.9.1740155698055;
        Fri, 21 Feb 2025 08:34:58 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d448sm139343505ad.150.2025.02.21.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:34:57 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH] staging: most: Remove unused mutex from most_video_dev
Date: Fri, 21 Feb 2025 22:04:25 +0530
Message-ID: <20250221163444.57492-2-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221163444.57492-1-kumarkairiravi@gmail.com>
References: <20250221163444.57492-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

The `lock` field in struct most_video_dev is never used anywhere in
the codebase. Since it serves no purpose, remove it to clean up the
structure.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/most/video/video.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 2b3cdb1ce1..bd51125698 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -40,8 +40,6 @@ struct most_video_dev {
 	struct video_device *vdev;
 	unsigned int ctrl_input;
 
-	struct mutex lock;
-
 	wait_queue_head_t wait_data;
 };
 
-- 
2.48.1


