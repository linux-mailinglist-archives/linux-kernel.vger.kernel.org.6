Return-Path: <linux-kernel+bounces-266866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F939408DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DFDB23FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2016B3A6;
	Tue, 30 Jul 2024 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj4LdKpj"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E35241E7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322123; cv=none; b=gpSL28hd7XePYqtcXAMJFoh+ajkXJm5OxkZmXX4+R+qCsWgo4U/tzytXSKz+p8PXT8/1E5B3CnMcjUwhiOsxTqXwe3wj71HsRa229tUzmMMgL1dfOvkrz+q+6FxSGqoXpaZYmdcx3mWew3zn+V6jyFbQW81AHu5y7kafxjPed1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322123; c=relaxed/simple;
	bh=U43chPMgp9SPOW5AMAOve+T6qqvBSKJGkcenemPpM2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiyIfguN7tweQVDCqR1fsFuSxxoTf/oQdcRbMAFHI3tNrOaOkf2UyAhd9QIPnnAD2btAtNVfwwmnp8yETselusiKXiKO7DuE8l6i8/VpGdzS1/tlK7OXirGq2tdzP0P6gR4sMft8TIg5wAQAviNv2HW8laCEUn2nV8ekt/ykh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj4LdKpj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso24244325ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722322122; x=1722926922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVHat7cOV4uaQtdGpP2gIwZz5RzJ9bcH8BvyKEYBFNs=;
        b=Mj4LdKpjpPXBs1UzCCejROOm66iUNnfIVZoN/0CIlB20crKl9gappKvaSe22+UELvc
         GfNHzA9Hjpo0GDIzs17EAhHRZ+V7kHaDWXjr+DC59EN+ZiE9MmCV3nwQlShK1OcUXBRu
         Xl12bIMQuSPvEr6Et3nXOhM/dI1B/+1aCB7dOx77yhAfuSvBae8INBhgQkIiHSVan3k1
         72ywvrh8kDmSyoeUVdiZz+qSGGTZKQEFHl10qzMqF0WIBoQOhZf/EYGg+nN2LQOZy8+p
         LhUny9t3kz/mSd0hZ2QwJvocA3E/zh4bTNhi6YscicPHkcCj+KNOW8hSM2cpH8rCcnU7
         qE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322122; x=1722926922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVHat7cOV4uaQtdGpP2gIwZz5RzJ9bcH8BvyKEYBFNs=;
        b=eOHrZ/TXtx4JqlkfjaNalpgGEb2PvSPzTL4Ibo75M+3ojmMkp6uNjM9GtfT9xLxdE+
         ROGw0Shq0vzIBQr5orFdDSXjo4YIE5R0oAXpy2v/GvgJHslTHUEWshDlUCeiAYw1kP3w
         OOJ4l88P+eJ2rtr5tBRPMrrPx5mOI0L9ZeKim2k2d5dnhVY/vpmvMv/YZ2WTluoWB8lb
         5WJlt7AweYN7SAqaiTdpa3OnrNEXn6Dhk35rfXZ3M0pEi4Qi/bVMKcL+RSpDe1l4Ij++
         8RKcFJuqlRjapSXBvnqFPpcK7g3iLMx93Do6kiNPo1iTcEVWXmryOLwpvS90Y1EHbu10
         0Sdg==
X-Forwarded-Encrypted: i=1; AJvYcCUUi/Xf4n1jVJlM3doSi9bQpuhfu8fH+l7gFTbxaJAPVHfQ4sFUVOu0BaBAGOwRh+isJarOhjwggQPnSZR0dJKUP5yWHbxjSk4u61KM
X-Gm-Message-State: AOJu0Ywhu6Swuxf9cXc/JpZM2TjojR4sczxu4ca6GrDZ1MlaroOUku2W
	2+Fc9TRTLJKKAqtheqIl2PKrQ0KPvnmXF3Kt2c4DexXNQ2Lvt2VG
X-Google-Smtp-Source: AGHT+IEbj8ZgOJdNufAEPBPKNp+D6yGHdBJWGuaoRj/JUAHVx38iWWJcMjVaBVAsDEA4d6n1dCPF3w==
X-Received: by 2002:a17:902:d4c9:b0:1fd:a264:9433 with SMTP id d9443c01a7336-1ff04842238mr84949035ad.29.1722322121534;
        Mon, 29 Jul 2024 23:48:41 -0700 (PDT)
Received: from 3a25d514abef.debconf24.debconf.org ([116.89.172.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c88a67sm94162715ad.11.2024.07.29.23.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:48:41 -0700 (PDT)
From: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH v2] staging: rtl8723bs: style fix open brace on new line
Date: Tue, 30 Jul 2024 06:48:28 +0000
Message-Id: <20240730064828.35207-1-sskartheekadivi@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It fixes the following checkpatch.pl error
"ERROR: that open brace { should be on the previous line" and avoids the
warning "WARNING: braces {} are not necessary for single statement blocks".

Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
---
This is my first contribution. Hope I did everything right!

 drivers/staging/rtl8723bs/include/osdep_service.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index cf96b5f7a..5629123cd 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -81,9 +81,7 @@ static inline void thread_enter(char *name)
 static inline void flush_signals_thread(void)
 {
 	if (signal_pending(current))
-	{
 		flush_signals(current);
-	}
 }
 
 #define rtw_warn_on(condition) WARN_ON(condition)
-- 
2.20.1


