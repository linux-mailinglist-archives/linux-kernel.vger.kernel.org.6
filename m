Return-Path: <linux-kernel+bounces-242071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FB92833B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4026B28760F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83A144D2B;
	Fri,  5 Jul 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="hed19GzU";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="aHya3fCO"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688B144D01
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166097; cv=none; b=t54sI3Kic7eOHWWuD1ZFKkJQk8u1RVnhx/YGnD3qF32Ap9PjPFEDhszLKu5imyul8PJ1UFZL6WEsk/umNt09dINn2zEZ5FLrgTIpot7IHUh8cp7Ht+C7vPAe71B3UBB3BC6iBrWbtr+QRYvLwOfa1YP3a6go0oVY1SQHMcEOuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166097; c=relaxed/simple;
	bh=Zcn/Nzvief9hDSm9R3roNLbz8nhgsBIFBjts3uENqUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGUph+RL9qdv3ojBu/TrvNAqs7+W1ijxQtsDvYE5ckZ88XKZDKGiKZnjsf7FZEvH8hrdzxzLAnmaB7YIEoq9xNVX9nnR2xHbvG2ZRxLcjDDBdBD0JFE3W7MXlH8b4uIbseWg/uSV5s/sU3No4ZDRIdRqlAmIXkVfhFA/8x7eqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=hed19GzU; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=aHya3fCO; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1720165738;
	bh=Zcn/Nzvief9hDSm9R3roNLbz8nhgsBIFBjts3uENqUA=;
	h=From:To:Cc:Subject:Date:From;
	b=hed19GzUhUKmqfZsEZylBqRhJ61R0T8VA/vZaEAn39+PgKmzPpTt/Q8ppNVSwf3zC
	 yuvya6qAoZ5bhHyzVqV/RPkNCqEpkwfreUZ26SZAoBzhH+UJYtRTgxXG7s/yar9nNC
	 S6exc8Urhle9yL1cCd8JA+SOwhh/IED/xwNhYc+pyCcOYO9vBEm/xm5Iv6n7muX4NX
	 3vWNpi6XhauFuCqFVvy7diFcuFFeswWNnOMgCw0Cys6rYuNuNkM5pcR2WXgWT5E/US
	 LJqD/9CpN3Fo5q/AcEZvbavN9W/1StMnAw58nJJX9Gxk8CjOACVl1gx5qWAtfGU9y6
	 rneHXoaeiGuKg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 306AC837
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:48:58 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=aHya3fCO;
	dkim-atps=neutral
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id AC1487CD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:48:57 +0900 (JST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5c228d9f0dcso1453185eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1720165736; x=1720770536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxuoJkWGHRJwetZg4ul9+B1wriVthDVUa7T5nkwMGhI=;
        b=aHya3fCOHJI770GjykCWs3NGOQhbV6OVCG+XD+ltz//zbtAqenNHqU21GkTzSuHoNc
         E7auSQeXZ5FQ5ENb6asThYNJKWjDE2a5fusO228w5HaK+YRt2NHTqRECuFktUhIr3+ew
         sV6bzCxwU1Sxye47uzyAlpt3BgDYs0pLr7BhbgG6iZOxrdnXFYAj28ncYitUyODxwjbS
         mpeiEmpTditD9fe8tqkNeW4zNpYNgGUIOkP9jOmlm9isA4CX2VZeqSi5hKXYODYkTh1Y
         358TJm7ZAoWMCTYnpnXB9IN9Zyv7vyR8o9IO3CjR2oQREj0/RydbcRDlj2NKJVhh9u0B
         JJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165736; x=1720770536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxuoJkWGHRJwetZg4ul9+B1wriVthDVUa7T5nkwMGhI=;
        b=mcdz3PwyLvvWF2VnHEnJIUC/gmP53XVVaTKq1/DN5/cFe0MyNVUNWGwDH0wPZilUR/
         4zoB8RfcL+zkC+o+B/V/t12u+PJqT4nrnIL9dL/5F/JB54w+pZ1qbM1PoDNdfTW//XPe
         ADtNi7LGD70huu5iWup2Okl03wbci+06mIpM4CUnVfFC0E72ti/CZrpnIMnnYDNOF8+1
         OFO/zXMlVSGwKwAHtdHbIzHgPoh6zGnHGzNgZLUN1ZcruoobA8eTyInyGKAZ0tu3TyR3
         TKlkrqE8D2BFW+ktUgPdzz2hXcScHN/LmbarjA6gVMNjoyYhckP1yn3dNPJjX9B/x235
         KR3g==
X-Forwarded-Encrypted: i=1; AJvYcCXXMJE3zXzGPZL6j4fLNcRK7u5hheMqVRz3GdBjBfNRbr0CQEBmTga5pGzMx5b3eq7PXqHcxBl/nSDVTPyplvFpPHyy2MRFO5Cjl1ZM
X-Gm-Message-State: AOJu0YySIpNcvWGZK4UvqrSWP06NAtiNeuOLDfbgCjtLSh4kADpVpmIt
	vrmA7eBdKWxjMskyYfvHcBFuvG9ZOZKxJgHQ7bPOzAqWhs6ggHk9h5+jkSMw4n9DV5aZe2N3ShK
	A6ySlLfWk5W/tgAKWK4bIJb4sFe82c2uQ6NngTkU22I8SYvsXCGGF9AcBGEKChgA=
X-Received: by 2002:a05:6358:88b:b0:1a6:3016:1ed1 with SMTP id e5c5f4694b2df-1aa98c91efbmr363979855d.27.1720165736373;
        Fri, 05 Jul 2024 00:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE5s3uc9pyQVZG0Iv0PjBELyaYmcSwHMDmZ7dZ7QPbAPFWUW3qf344zw9phzABBwv0qcny/w==
X-Received: by 2002:a05:6358:88b:b0:1a6:3016:1ed1 with SMTP id e5c5f4694b2df-1aa98c91efbmr363978955d.27.1720165736013;
        Fri, 05 Jul 2024 00:48:56 -0700 (PDT)
Received: from pc-0182.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d400fadsm10578206a12.91.2024.07.05.00.48.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2024 00:48:55 -0700 (PDT)
Received: from [::1] (helo=pc-0182.atmark.tech)
	by pc-0182.atmarktech with esmtp (Exim 4.96)
	(envelope-from <dominique.martinet@atmark-techno.com>)
	id 1sPdgc-00FBmu-02;
	Fri, 05 Jul 2024 16:48:54 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Songyang Li <leesongyang@outlook.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeron: remove source file executable bit
Date: Fri,  5 Jul 2024 16:48:30 +0900
Message-Id: <20240705074831.3620158-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This does not matter the least, but there is no other .[ch] file in the
repo that is executable, so clean this up.

Fixes: 29b83a64df3b ("MIPS: Octeon: Add PCIe link status check")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
(Noticed this when reviewing the latest stable release, as the mode
change line stood out in my viewer)

 arch/mips/pci/pcie-octeon.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/mips/pci/pcie-octeon.c

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100755
new mode 100644
-- 
2.39.2



