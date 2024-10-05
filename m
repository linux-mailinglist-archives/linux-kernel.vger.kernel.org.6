Return-Path: <linux-kernel+bounces-351870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243F991716
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB41F22F42
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086615530C;
	Sat,  5 Oct 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QML3LKYz"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65F13C8F6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728136387; cv=none; b=imOIAk+Oz7YopF8xgId1WUCFJlZrFGOWzzW9f6VE9Dl9aKWo2LcaPypo/xZRT2XYHoZPiwGdmb+c5YPdbJ8LbtB46mqFVtuv/M02rfqKDdfR50zayv2+MWytO+m/f4D6UILoPnnucvN9jm583Uy4oYScKSlVv3KbgZ+jX6qtYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728136387; c=relaxed/simple;
	bh=rVTfpkUt2C6ikOnYg6ariyltWsIP1HzH79tfa+TwsXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ0i5HIDBm+0BmjZ7CcxLFraKDz2ooPQzr1exa/ar9Z1huOXf/AsFXudJmS9NyB19onRI/abVIhtNkSJ+RpTaR/ONIOZ1lMGQVb8njNeU7aZ9nD9SUuzUaf4hJKExQUMpfoTXyPMV1VIkvRqX2Zdv2tJxoJHMYUOeqCEBVYiTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QML3LKYz; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e0c7eaf159so2432166a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728136385; x=1728741185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juguD7Z4L8Oxo1MbfxKEFZl+Z9cwMrDoIprZ8VE739E=;
        b=QML3LKYz44lbdrkp87uJYCXKhl4R3RTACRJ+Vc9YnzBE64zhY4pZ9ujSu1iL/uoheJ
         Wk6iq5e63aDi+qKC2p1DjxCW7Ksc7638c/vqEX0eRkGCv0pX1jzX7LZ2FnKbBtoybQaE
         02Xn0Q+tqGm/rjbgg9hsFs1jj8Xv3w9+50nR3JlyFTQAvsaF1CwB8bxLU0mSKa4xkrjD
         CGMD0YfsPLK+HE4aXdf8h+mproGkqTNCqyQAhkttHB1Z+vlmjzUUJcrb5CqSE7xRmI52
         9SpWCGQuybEUWj0yLA2Nt2S7SlQvYO8rhpQLUb9VWnadOQkcBpycRtmjuM2sXccyDFoo
         1PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728136385; x=1728741185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juguD7Z4L8Oxo1MbfxKEFZl+Z9cwMrDoIprZ8VE739E=;
        b=vmh6iuJxVAkqMXVXaZABnFMBCZaaCa6ueDWkaqiu9ivetJ9zsrMJnbkyxd/hgpNFQK
         JElsKt5NqjmY2ZjJS0SLPchNOaBfpTFrfwK4a9+ETetcx/oGLgWs5VdYyeNprZnySKRy
         SDc7HG5ttpaiOLzqEfPB/PDuGuz8OR5QOTofsajMIAAtMXh3OZECVrqqkLocqTAqKWdq
         jepdfP1kedwkMNDKWbTv4bHf08/aTr9C0XZFOg0TwotSoxmVTByJtyPf0h7C2HPNBi2Y
         hQMkyp3TFI7mJB4ByyHsVT8gSqfGKiDeyJRvRHd8n3H2fqVXDAiAVye/QTJJQZPipaea
         E8qQ==
X-Gm-Message-State: AOJu0YyXZSV67gahe4Q9JKUsq3V9JtENklf7p2wnPjnqNPle3PUL8ofh
	Ukh9+0ZfWA5yAKA+SWQ02M6rE5CEPria6upH62cvO4jehyi7/Lp9
X-Google-Smtp-Source: AGHT+IGKP3FaVPKvS7b/LTqBGjTMHfY676RNAFxhZynxmhsXo6blpWwOYS7eHXelFyjCiQZ5conXMA==
X-Received: by 2002:a17:90a:fd87:b0:2da:6812:c1bd with SMTP id 98e67ed59e1d1-2e1e621f1e7mr6674143a91.15.1728136384824;
        Sat, 05 Oct 2024 06:53:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a74:2681:86c0:b921:7e4f:199e:c149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d959dsm3576169a91.26.2024.10.05.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:53:04 -0700 (PDT)
From: Xiaofeng Lian <1198715581lxf@gmail.com>
To: lkp@intel.com
Cc: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	stefani@seibold.net,
	Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: [PATCH v3 2/2] include/linux/kfifo.h:fix errors
Date: Sat,  5 Oct 2024 21:52:50 +0800
Message-ID: <20241005135250.121964-2-1198715581lxf@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241005135250.121964-1-1198715581lxf@gmail.com>
References: <202410051712.VDmFpiVZ-lkp@intel.com>
 <20241005135250.121964-1-1198715581lxf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410051712.VDmFpiVZ-lkp@intel.com/

    - Fixed an error detected by the kernel test robot caused by an
      incorrectly passed parameter in the INIT_KFIFO macro.

Signed-off-by: Xiaofeng Lian <1198715581lxf@gmail.com>
---
 include/linux/kfifo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 66eb1b8971f7..316b6c019550 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -148,7 +148,7 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	__kfifo->in = 0; \
 	__kfifo->out = 0; \
-	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
+	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp) - 1;\
 	__kfifo->esize = sizeof(*__tmp->buf); \
 	__kfifo->data = __is_kfifo_ptr(__tmp) ?  NULL : __tmp->buf; \
 })
-- 
2.45.2


