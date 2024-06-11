Return-Path: <linux-kernel+bounces-209870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17606903C11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB3E1C23096
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7617C7B8;
	Tue, 11 Jun 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWyBT9AY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582817C7AD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109500; cv=none; b=PV5L4E2Ub1Ou1HwiE9do+Eh1UlLxB+HqIErCi0ag/MtjFtBvB1YCg5zf41jKI4BVkpAZ9lEnhiyB+W8PnwlZ+AMABrJJzMrKmHV2R+wUZAnOhgWz6ERlcvIGGxcmwxZ7W7kyqeqM+WIBv3bOxdGkgZh1q2cSDM8Kw6+jz7+03Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109500; c=relaxed/simple;
	bh=XN52i8CqC7+2+wbJGjsKJnNbV1EtOmX3DDcwmxkn62s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cOcKXQ7iaRz7ktfs9C/cY7NXUm2lLhZ8jbXYzjBGkc4rQN+iBqNsAsk6ameHjgukfUSM5LWa/JA6WmN8zNDnzj6MV58nQAdSHAGy5b8evy2DE7L8MvifO8yfXBCKecD5LeKZSyPsWaVZZKDbl3ZYCZ8VAm1R8LiDXN+uVt2djPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWyBT9AY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1c209893so3045474f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718109497; x=1718714297; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaW169oqeSKLpqcvU28Mohgp1aN0lils3oMJkBYfdCU=;
        b=tWyBT9AYdfW6tOo9Pjn7mnySMQyBd3BmnmPxQ4old4OX/LEi/4JGf0viwywT3iLVH9
         QariCGAl6hcACWtqPRHeiNZR2g9Qk/L/Ybj+mSXPwbTKoyR91sv1AtRu51zmFz9BpWfh
         9O1KozyZz+Xlb3tjgj47W4mesiLSVH0KiRZNDcaeYCRYjxoY8O1JSyetAEEMrOUcAyhZ
         WnYkDdeSlsk8NmcaSz4voIQOIZEcZNeSjb42TPVU8viK7Mlu7v0H3ChQw94mVwQZE9WM
         5XRlLhWTFukYLXCtZqrhnTb0F4gZi2AkO1t2SVVy+RKJdOGXllLk51I/p4kbD3/k9n2q
         G4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109497; x=1718714297;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaW169oqeSKLpqcvU28Mohgp1aN0lils3oMJkBYfdCU=;
        b=nJ6y3sHghTh11fM4QGd8h0Upfn5qoUmPPSrJLhVgWYGww0Ea0h4qI+4/X+Y4hge/6X
         WE5DD/kscVXDUhHZ672Vse45+Dpk8Hei8NW0lX8u9aQBStIebDVn3Q0aMxniwS+p/Sp1
         RK1/0/MMlZvdi/eFoabTB1RZtJbfwrnBqB2xPEFHRIFUIPFYVRsh6nzwubn3awcfiIuN
         26SQmZ6V/y08URIKmBCW+qbeuWjHtXZaJt8Cf1Yv0pRaudEpmYsU+syCvoMyZDtk48pX
         VB2K5BZXj0K5Bo0kmqKrdPZNRtdCXbplUhdUFAhRxKR0c0qgGFoCCEcgUsYX7V0BuhyX
         dwjw==
X-Forwarded-Encrypted: i=1; AJvYcCWMFzs/X3qU0LxLja7IzKKFI6mASf4//+PbItQfjUDnkP4AQiG4CTcQKYCH3NBVIGdGY/Ry9aHkXDKeNnl7uzXiNlpCss96c+Tai6WU
X-Gm-Message-State: AOJu0YxO3pZHoojtKW+oNC15CYRGddQ0V+ZSfbMh67+2Ms/CXwEmwcTl
	LKB0+DAXKnqhdBj1Qp3YSLGrDYGDBkhm+xubuYkLAqGPiETVdxDuv5xnAojV3/4=
X-Google-Smtp-Source: AGHT+IHg02WcIth64AxHydDfrCzP3dJZs3yHUm+FSxLXj+eO5NSt07iZMz7QK5MsVXvzym9ZqDqH+w==
X-Received: by 2002:a05:6000:144b:b0:35f:1846:72cc with SMTP id ffacd0b85a97d-35f1846737cmr7795462f8f.7.1718109496798;
        Tue, 11 Jun 2024 05:38:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1d3d7b11sm7512775f8f.28.2024.06.11.05.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:38:16 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:38:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] bitops: Add a comment explaining the double underscore macros
Message-ID: <5a970f32-25c0-4955-b480-a4738bf86153@kili.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Linus Walleij pointed out that a new comer might be confused about the
difference between set_bit() and __set_bit().  Add a comment explaining
the difference.

Link: https://lore.kernel.org/all/CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: re-word the comment, put it right next to the macros and add a blank
    line in front of the test_bit() macros so it's not mixed in with the
    non-atomic macros

 include/linux/bitops.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 46d4bdc634c0..ba35bbf07798 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -47,12 +47,17 @@ extern unsigned long __sw_hweight64(__u64 w);
 	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
 	 const##op(nr, addr) : op(nr, addr))
 
+/*
+ * The following macros are non-atomic versions of their non-underscored
+ * counterparts.
+ */
 #define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
 #define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
 #define __change_bit(nr, addr)		bitop(___change_bit, nr, addr)
 #define __test_and_set_bit(nr, addr)	bitop(___test_and_set_bit, nr, addr)
 #define __test_and_clear_bit(nr, addr)	bitop(___test_and_clear_bit, nr, addr)
 #define __test_and_change_bit(nr, addr)	bitop(___test_and_change_bit, nr, addr)
+
 #define test_bit(nr, addr)		bitop(_test_bit, nr, addr)
 #define test_bit_acquire(nr, addr)	bitop(_test_bit_acquire, nr, addr)
 
-- 
2.39.2


