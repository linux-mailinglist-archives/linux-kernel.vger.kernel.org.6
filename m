Return-Path: <linux-kernel+bounces-268733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09815942870
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3331C21287
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7D1A76A3;
	Wed, 31 Jul 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfow2ZoI"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E98450E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412611; cv=none; b=fj6UnCBut1qBLcTHGQgIXG7QeN7j9ShA+HL/ebdzz7dFPEdnbzl8O45JBWzDaFxkDS1Xh22Pdn2G94FFEy77poYI2mt8XwRZsexFCNUZwwUBZqFS6xWAGyl4hcXGWegWRTltd98C2g2AXsFHzvQYdL4C3C0BG0xgNISwCbFmrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412611; c=relaxed/simple;
	bh=EAG2s+tDoP+5VApMN8g5j1TXsoJmYWYYkoNbIJGP+UI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ErjgTfHgPIFPC42B4o91hv09pwnl/AO2k+QOeDvMsLuRwmsOPa6EQpjB4W07TBgfgcCM29hBC+aurcgEJFpvThguxb596vKrzYlFaczRA5d4XNjYkvrPumoCAM7kwYtneDolADpozDdWy45rzkkb1o82dGPhHp5+0nBHXgZp2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfow2ZoI; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so1454160241.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722412608; x=1723017408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zP3g8kyFoXZbWagZeDHO/HbT8yWguh/RdGIalEY3Fg=;
        b=Wfow2ZoIRdl4KDZ2M+cGheXSgfznwfl+HQnZ+nGdKwFQ0BkwP4v3YF+hnnac6eAPdc
         /U1abaIp8yHduXkUR1Q9nKQlY7s0dHO343ZvwfmRfaY1X2Gi4ycTRfvuxfI2WXjcvCr2
         rr5GFZM/FHc0mGHOoORJKDJ6uvn8QyYU8cOUWhGUygUAsBG2u5pIsV1vERGOpVO6HZ39
         ITcz7TMhbDoaWvZOmPZSPnDprR1XJ51G/x1Q0xDhUsHPWS/WfhtEajqBwyVyqFGdMJmX
         UjSrEXHiAb8f4U/+/g8exLFDUmkF6Yvc8iAx2zxBEFQSUbF0QdrsiXJmsoRQjo/pmYR8
         ejNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722412608; x=1723017408;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zP3g8kyFoXZbWagZeDHO/HbT8yWguh/RdGIalEY3Fg=;
        b=HEshDT6yx/gRuvJNdD6OrpPCvuPMLOUWa1jx7poa1EcAVa+Z2UOAndxK0CZz4zZU84
         eR39ny2NkXyYQ8+8G3siXM3g0py2WiWjTVJtbhuqQyqXmLBOn3G0JU6050/0XHt80nTn
         J+OzBJD17XrNvAzQf7WevYeliVvz32sxdag1Ac2JsWcJLNzclfiGa+4KfAdWlzbuAix8
         dsxOMt8Rw5mXsBaUv0N960FpW2xJVQEWUBztFqXXxqKed05YZHmrMCYJFueUewuxKbhB
         bSowz34FUEyBq2GMz2pXRQggTToqlN1Q03N06M7QSrVQ6uYlTZrnptEs09JZJVV82j+k
         rBbA==
X-Gm-Message-State: AOJu0Ywt24L8u5cpMObHHVstCLxeL3ivcXJz5mRm8IoXbqL77siKiGMF
	eRWK98EhNuRGRh0W3pVpN8BNML3g0zPtECh2U2NtOh8qawkDyq1B
X-Google-Smtp-Source: AGHT+IFeEEG+238IPVh/7iccL8Vg5nGBBZgv/As/UAmH1xSOdFBGZHmusuUjAdGDHjgiF4AEbEd0xw==
X-Received: by 2002:a05:6102:3f0e:b0:493:e0cb:7263 with SMTP id ada2fe7eead31-493fa607a27mr18281235137.29.1722412608289;
        Wed, 31 Jul 2024 00:56:48 -0700 (PDT)
Received: from fedora ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-831afeb1137sm1574584241.6.2024.07.31.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:56:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 02:56:47 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: peterz@infradead.org, vincent.guittot@linaro.org, rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Replace <asm/processor.h> with <linux/processor.h> in
 sched.h
Message-ID: <ZqnuP-_AF3mVrN3E@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The sched.h header file currently includes the architecture-specific
<asm/processor.h> header. This commit replaces it with the more general
<linux/processor.h> header to ensure broader compatibility and to
streamline the code.

This change helps in reducing architecture-specific dependencies in
scheduler code, making it more portable and easier to maintain.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..0f48c96210a4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/sched.h>
 
 #include <asm/current.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 #include <linux/thread_info.h>
 #include <linux/preempt.h>
 #include <linux/cpumask_types.h>
-- 
2.45.2


