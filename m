Return-Path: <linux-kernel+bounces-221121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C890EF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FF11C23E88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EB15098B;
	Wed, 19 Jun 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjbHmzYV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75014F131
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804403; cv=none; b=VP66wdWnPRhuXVKaf8qws7WRRN9s7qTrlP/VD+eBpC6T5ynCLxYLkSULIQrPT8ocq2XSF6VzoPBGZ0o+3I7u71TKdda2XuRXFpt1inDjflCttOhTXjOZehCWoAcr4sq1lLhRHaipcevZ062qt6IsmLCueDnAo6p/nz2rK63MPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804403; c=relaxed/simple;
	bh=6MzhpI9fJCcEpgQhs7kB5z05QS7LHzxzTbVhNvTC/wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiibIHf+Jug/7uuwQPw32SQpDq2MjSc8bNLfFq6NSMbzkeTDGMYVGTgJ7c9AnlmYVDqeofg2bhR4i5cT80a01YJwsesy8VFavwiyZsYJZjZ3IGpxg2SqYmgZKbQWOGNxkMUoNvmHRunp3CRCO6oAjm11z2oIR+ZeLEYn+3trGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjbHmzYV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718804400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuMMLNSwR36fe8ZSML4xmcTbA5i566bPVz1jYRmdpSE=;
	b=UjbHmzYVN09zpZsq8GXLG7G/a5sD1wtRTgus3wHXbXQPixFIelgD1N6SeSE/giP/mhxFg8
	fmPzl//AjITofMIqumlQOWul19oBj/YVSbo0EzzjVyLey2jRKgkU5/jvXVRe2Uq3ZjtQ4j
	AkZGk08rum89S3NwU8DdAZ0TzXPXcWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-1jCyufwIP7u9pL1YHmW79A-1; Wed, 19 Jun 2024 09:39:59 -0400
X-MC-Unique: 1jCyufwIP7u9pL1YHmW79A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42183fdd668so41116855e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718804398; x=1719409198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuMMLNSwR36fe8ZSML4xmcTbA5i566bPVz1jYRmdpSE=;
        b=dXTT9Lg3jtyBQCUJSPFj/hJNlJQGctmKHxxJiqhnbou9zDXhcKtUdT1+GyjFqOItF1
         QgpGrOpam/aDiLrZWFm2QQZxK+GXBPhwfh5jZNSbdLxhysAPe8sgSZrIfxEqb4Vs/HBG
         a7mP+AKTT6/XnBzUeSo9/EmEi+AxpUJHf3naT99gvlU5/pCGRDMKLO26G2fklzMNbqEj
         LCl/1iWiKepw++yAcRpU0RdemrP4rnXkNjHs01vc4EPoqj+MmYCdAzZ46+mQJSOR7EId
         JaekhvD+1/p1ltoglQyl1G2qbhE5Fi6DpOgVtvKv9Mo/MQwWuemA99LEjY4HzJC3IR5s
         uStw==
X-Gm-Message-State: AOJu0YziJJPN05baWRZWoeYpmx1Zuts+wx5DHjtFMBpkmn65DxoamnKt
	E6ZGTzeip/mCHZUBNDWa7nOF/MLu7krkzAqB/YG29TpvAFDTv3matKKVEFsZs7M3eYReNqr8Zn7
	7Ac4y9XKCnNoSDLukyfn3SHq0pDQaTnvIfl2ZbgJYaTFRnYLvcLka99cnBeYLFRf8Co1QWA==
X-Received: by 2002:a05:600c:1c94:b0:424:798c:120a with SMTP id 5b1f17b1804b1-424798c1341mr9623915e9.24.1718804397899;
        Wed, 19 Jun 2024 06:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8xLEHLAiIZGvEWrnYIWMvrdXuriX36HI3VGWbzjKEdB3y6vH9kHZRBFc0eqLASc3sxSsRIQ==
X-Received: by 2002:a05:600c:1c94:b0:424:798c:120a with SMTP id 5b1f17b1804b1-424798c1341mr9623745e9.24.1718804397530;
        Wed, 19 Jun 2024 06:39:57 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c16sm230512565e9.38.2024.06.19.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:39:56 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 2/2] MAINTAINERS: add Rust device abstractions to DRIVER CORE
Date: Wed, 19 Jun 2024 15:39:18 +0200
Message-ID: <20240619133949.64638-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619133949.64638-1-dakr@redhat.com>
References: <20240619133949.64638-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing file path of the Rust abstractions to the maintainers entry,
until we can move it to 'drivers/base/'.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf9c9221c388..6dc6f264f800 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6714,6 +6714,7 @@ F:	include/linux/fwnode.h
 F:	include/linux/kobj*
 F:	include/linux/property.h
 F:	lib/kobj*
+F:	rust/kernel/device.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
-- 
2.45.1


