Return-Path: <linux-kernel+bounces-257633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D5937CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551E528235F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD314830C;
	Fri, 19 Jul 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnYpKu9q"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699A8C06
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416124; cv=none; b=O3CwVimT+hFDcpp/xEhztL88V6JcxltgoVEoX0u0mTHfUAohKcLqoQ0FkGx5dCg02nJXaJlqihl0sW4L1AE+VCr9uKW7eksmzxkritrll8yAkvr6Vdd0rPLlaiCWKs8Bhzgr/NFiYOs7RUj2d64BRDtxaR5Ok0hpVm2KX7Efe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416124; c=relaxed/simple;
	bh=g5jlluqrq8Pg2nBqWmUhe0h/18TYU7MMTs3OlTwkk2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pa7k8KmQKTjAxAwhaKgireRzLWuuzKU5Kq1Mt10qarriVemc6bYUHqjWNTavUIKqD6IQupiA92sUit8yDzclHzfTJ5y2kxdWDbXepvoBImf+TN2T0FDhgzw03jrQs+jYVx4xOFhkxcw7CcYXBvRVafgvVHsG0CGfMtKZdUoKxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnYpKu9q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso1511496a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721416121; x=1722020921; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OH0sz0rx/j1UKeDUxIO1zBwZmXYfH8Sap8tz35VJoIg=;
        b=JnYpKu9qATsM2aKPZxWWos+qXsMoBDzpFn/ALxDcpGpama9Nac3XxoiRNsouw9wubp
         DZP0yTy5oMHvaEEDZdL562vL6XVSkvJc4OncIdruvdBJ9fFtfHXUIgNIyd9M1ASov4Pr
         8oqLZcfFLvABAxtXE4LQBBQqpuKMD5QlB2Eq1uT3QWKyMcICWhhIbOfXUZV7ZPqPhKNC
         GGIxolgxepPUoO5Df6XhqulwvSiHykabYj9x3jByJ+uyrICbtb5jf/FsyyF5u1QtMIZA
         KTaiDtTNmihQXuFGg87assb+CRsDDev0nueS93lQUQltwbdSQCcXj15rUGlpydBd9FXM
         cTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721416121; x=1722020921;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH0sz0rx/j1UKeDUxIO1zBwZmXYfH8Sap8tz35VJoIg=;
        b=QrY2W+/14WpvOs/2PXNZMndRZNyYm7z19HFTKlbXxz4kxvMLt74TqUMVRdUm4PH+cM
         kVKKm63qOstFKBNzmS72T4NHpaP8LuGGa6wkbEJvfEJZMJBH3JACEIp4gVyP2aKe/yvL
         iHGaBy2Dk9RydQtokpoOhjn+sV90RFeLI8169qAKCaDIkv0iojb/zDFuvCjgIZ0gc1Rm
         xuqkGn5Rm0f75WRCM+dmjAzUXMoIR7tueim+e2Y7VYcjpSaHNHyA6eA5HRuNM7MWzYYJ
         ezIEdCEZ33dFMeOoOI5ju96u/8J0RI2HfzlT4LVG9abpU7pDk+JOKiZDaNQhZ4eFC+AQ
         RmiQ==
X-Gm-Message-State: AOJu0YxrZbuj2g2gzHCCjA09r/OzmULWO9Jg8U0QsILPzqQ41PQoeKot
	tTfByo63UkpaXaIObPzZNmpS/hquNT4FSs3DS1GEIpSQAJbeISdjLkuM
X-Google-Smtp-Source: AGHT+IFtbOK/QQl6PnB27cc2yVgo14HojvMJXRXs6sM3reBl2xouHEwDS0D/L73rVL3nHVBWtzfeZA==
X-Received: by 2002:a05:6402:2753:b0:5a0:c332:3959 with SMTP id 4fb4d7f45d1cf-5a0c3323aa3mr6142501a12.14.1721416120484;
        Fri, 19 Jul 2024 12:08:40 -0700 (PDT)
Received: from p183 ([46.53.253.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af82d2csm1592077a12.41.2024.07.19.12.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 12:08:39 -0700 (PDT)
Date: Fri, 19 Jul 2024 22:08:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH] simplify container_of()
Message-ID: <918ffad0-20d9-40cb-8dd5-ee082752d463@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

* delete unnecessary variable,
* delete unnecessary parenthesis.

This changes generated code for some reason :-\

	add/remove: 6/0 grow/shrink: 26/42 up/down: 1945/-1591 (354)
	Function                                     old     new   delta
	ip_route_output_ports                          -     724    +724
		...
	udp_lib_setsockopt                          2785    2291    -494
	Total: Before=83970531, After=83970885, chg +0.00%

But it shouldn't: cast is unnecessary and static_assert() doesn't
generate code. Variable "__mptr" is ised only in one place.
offsetof() is evaluated at compile time.

It is not clear what's going on.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/container_of.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -16,11 +16,11 @@
  * WARNING: any const qualifier of @ptr is lost.
  */
 #define container_of(ptr, type, member) ({				\
-	void *__mptr = (void *)(ptr);					\
 	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
-	((type *)(__mptr - offsetof(type, member))); })
+	(type *)((void *)(ptr) - offsetof(type, member));		\
+})
 
 /**
  * container_of_const - cast a member of a structure out to the containing

