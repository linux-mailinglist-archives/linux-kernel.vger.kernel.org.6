Return-Path: <linux-kernel+bounces-534670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91790A469C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12183AC174
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566622D787;
	Wed, 26 Feb 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="yP0Bckl/"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4922332B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594621; cv=none; b=FAzVcUs7TR8/JaSgIVX9hz/kvprp6fKEJCw9UtJfFyN9J+RfBXnSeomjbsmJZi28ZfoOT3G8htkw6HBheKQupUqKB6M2aKoz0QVXClmK66Vf/ADk8KFZAYCYgNO5VbLfq30HA9GbfXBy/4WLr1+W3ud35+PxkBSUtByXPm7HTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594621; c=relaxed/simple;
	bh=+jga4JO8dADdKRtvta8VebEu1Vb9jzqyHkqVw1d6tfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uyGIDyJCRkDIXwqXNwJva4XWa4XkCJgA/UuvRV1QR3zAgWvMJprrQnwgOs+x1+4uhxwwGI01DvKQAm60e4D44m/vAEG1Pf9PegR6FkSYCXANZ4f4NEBF6WEV9SDeU2EXzeVgOkzCjOBlGTqZ9bKVuNLaGJhr/bhNVRPPn+kshSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=yP0Bckl/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47200236004so852221cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740594618; x=1741199418; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G34dONYPhw2r4Q4f7nNimh2xr7YUguxLyO4lgwNsaz4=;
        b=yP0Bckl/4/aqmzBi1BMSEHHGh+WaIWBoNO6a7UTGTB33Sgtqv6QcMibkoLUBs6+Kuw
         cha+Zwc98AJmOg6BgsUHsinFyulzVI74YRxiHClPA8glHbFyJS/98i+i6cZPqix6G9Ku
         5bAZ/ljoVCRrnAFCIC2F7kd5Xn7LlKqSCHpjDAoDzqBwnEAETpfdn8UUi4dbBr5IFuGR
         Hux+YKHwnprEEZpXheNzc18YK9KhjboX+JkY3rJ+zZEtE7f980vBoOkwdBcxN4frxMVy
         eKQkwx9TxWZLFUDQ6L2JwvBi0GzlfjJk8Smb1E9LkbfOisW+qz+s4x3G1Jx8BanH5KQf
         nrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594618; x=1741199418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G34dONYPhw2r4Q4f7nNimh2xr7YUguxLyO4lgwNsaz4=;
        b=ujxl7epIn/SvmkQ+b1SeHbkotLGDytai38JCbzRKp55m6z06kieB7DANMwchyqP/nM
         /i96oag7SNV/vBVRovenl5SD9MQ+9sU8Naj8jrD4NU5YV7MnfMEN5uK5tYUlZMs0Lm2M
         K7oNCh+Yfy/mQ3bhCHEY2MUsES8GOYGzlSW2Jk6rv39eStFxvNhaWVM61eAWmYiTtE9k
         fpsW+Kro9tOTTcyDTpRnF1m9mrph+tZEgLkvzgbt57Kg6RL8r+BYFkmyW4hSo6q/HqSr
         2t3PmCZ/mk000XpvwRlkczwn5vyNjyPCCMo2mCXOjsuD3ovG7vbyD1m2r7hiWyCRaARX
         svAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTivJxaesp8++i1+KHBWmJ2tO8ggGZnOApP5Gv0/nEzzpjwHwNsIhauBs6POYk3SpIMBxjQL8MoBxdZsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAxrQa6SZvd7Uftqb4GYiNHnX0c9QbgQrd/HwO0MqAulnOAnm
	WBqZ0IlSbXywqWxFKBsLL41ycxy2s21wHt8fWXaCHiJUy3dvAZTQnwjh2rHfQVd4hx9dnTDC+h0
	n
X-Gm-Gg: ASbGncvQCEPTSUMHT/P0GqfMqrUfKi3DVW4Pm5cVnYCPnp+qpp9lNlJuaZ3zITiNjfc
	5pdmM/UdJkhAJahD45+uNFwzYTsvqGqV54DGQykS2qVVXRgRckVzihIORWeMMHnwtmO3IEw7zkF
	y22iOCOk16NOCasmslZkEOOyemlCe4IZWjmVqGy9DiWE5rjQU2t+xRaPbkY0iQslgTQ1kL2gCGm
	rDSoRXiOGa4cpE3RnNZnB5peqUNyno46n7f0W/7imw9IhgIBPULcHNlS+68qal/8u980lqc+hBp
	46bM6k54n1ul9OljarOf/Vex
X-Google-Smtp-Source: AGHT+IHEP6GOSANauCCiF6HIJY9CX8U8MzYneKogkmfz4bKxjEBVuecl7Uf2HGZQ6jZAxfPs7MX1wA==
X-Received: by 2002:ac8:7f01:0:b0:471:c03d:cd6c with SMTP id d75a77b69052e-4738132e9dbmr64736051cf.19.1740594617901;
        Wed, 26 Feb 2025 10:30:17 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4737806a5b8sm27450391cf.54.2025.02.26.10.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:30:17 -0800 (PST)
Date: Wed, 26 Feb 2025 13:30:13 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: CONFIG_PT_RECLAIM
Message-ID: <20250226183013.GB1042@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Does PT_RECLAIM need to be configurable by the user?

Why not always try to free the page tables if the arch supports it?

diff --git a/mm/Kconfig b/mm/Kconfig
index 2761098dbc1a..99383c93db33 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1309,16 +1309,9 @@ config ARCH_SUPPORTS_PT_RECLAIM
 	def_bool n
 
 config PT_RECLAIM
-	bool "reclaim empty user page table pages"
-	default y
+	def_bool y
 	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
 	select MMU_GATHER_RCU_TABLE_FREE
-	help
-	  Try to reclaim empty user page table pages in paths other than munmap
-	  and exit_mmap path.
-
-	  Note: now only empty user PTE page table pages will be reclaimed.
-
 
 source "mm/damon/Kconfig"
 

