Return-Path: <linux-kernel+bounces-188320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF688CE07A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFED1F227E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30839FD4;
	Fri, 24 May 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1ITdvpa"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32037708
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526424; cv=none; b=k5+FQZcVckaUCF59SL+xy2/yXIjqR5i0dx45xQb6isHACMn0iziQBKEGNiDtKTxbBF6a+fMIjUMncRh9JzdJb9wDSZ56LHkb+nBuA3Vv7XKnrbk+X7/RDrwSL+v36vpzkhP59krD0UTAxa7xI6KgZzI0J4qnmzk5bLttJUbwp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526424; c=relaxed/simple;
	bh=voLF+ZXHqCj1QIFeconlKZ65jI2E/0kvN+jDQHP0EQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eoebDzJyLoVxDcS+n0VxQ6mHkCcywIOC1jwyeINl2rXG0BVud+NK3Ba0VMX1bI9bIsPXyB0ihB2adrk23T5VlnCB4VwtnEnRnM+2k0h3zXIw+HrDXtgq0/o+Jqe0gDzlgP5yQ+/Oxu4fgawPPx/TaO7AOPWb4n89fn1wOdY91lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1ITdvpa; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b31f2c6e52so2962269eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716526422; x=1717131222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuSgxuqm7a09+65zoh059DBu0U354ci0mLOJDafuJUI=;
        b=O1ITdvpaGDwEMBgTJ4iBkkvTDiTPjv83fPkhCE2ChLWryo5e1dLcvJo4IYwDEf5OCO
         C+Wta/SSieTepFt1JUOCgeEU2Xea9yVDVS7cRgImhGJ3G6XL+xM4k38oxtGVrZEHqV7a
         rMS27SjdvOatI7t5UBw0Gm6wgcQLxn0vk9aA6vp22UjPvHS6la/Ame48sxRjzp2x60AB
         1SDNldcAC0bdGVp4OFOntkPWVbZZQjJ4ZqZNurmfFdUrVMRxl9NtunktfyfR3dqTbThE
         mSi1kRodlMInj7o7BYKPHSbv+FjVszwzFZPa6IH7nIaJ7FwFAzkHV1ivg1ieW08d45bF
         bhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526422; x=1717131222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuSgxuqm7a09+65zoh059DBu0U354ci0mLOJDafuJUI=;
        b=SVzAnTPMpq5B0LLxk65XyRhBtsw70z+2H+oAkdowYJ506ffDQBg1bwjSFeWRMeXagc
         k4Sp/4x47jnNF2uKz8EtabltPGIesea2NxZL/fBikF/nYDzwi4Zwv+VuqdxEQYsu4qQb
         tjGEeVfFa+5YxZooCQoecberYG1+HOXzYE0ZDh/cs/9JXsGt5x1Unz7icr2dyKO4ONdp
         zAH0mjid0cAqz2qjbqa8QseegLoy++15iVT8Q06B8eMqks42M/Xw094vsc7HRXyA313N
         NpJdMu8leoK2nJlhFtgrAUntNDg/6qP6LrhwBT5TrDnC6WoG2OE+42b/CqA4m9P6/Y5A
         gvdA==
X-Gm-Message-State: AOJu0YyFj0z1eeDiFyJyihg4NQjmLdvF8cfFqAW6ci0T0qbmcis46WTe
	NsKLy8Wlbkft3RBCcw67B1akqzwnsU0FA5kPOwv1cP+I0QLqwG2LXOSqayb93NRzrQ==
X-Google-Smtp-Source: AGHT+IEdJdoSp9sHJ/o4feaVr2xodPeZhTUgDk3Fvn5vAUljkZBSKZ1E9dOTzatQ9n+VT/ltu4EOpw==
X-Received: by 2002:a05:6358:281a:b0:186:3c3:b40f with SMTP id e5c5f4694b2df-197e545bb55mr181246255d.20.1716526421704;
        Thu, 23 May 2024 21:53:41 -0700 (PDT)
Received: from localhost.localdomain ([223.104.43.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274ba9edsm362179a12.90.2024.05.23.21.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:53:41 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: [PATCH v3 0/2] scripts/decode_stacktrace.sh: better support to ARM32
Date: Fri, 24 May 2024 12:25:58 +0800
Message-Id: <20240524042600.14738-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 -> v3:
 - Change to only strip the right parenthesis

v1 -> v2:
 - Split the patch into two.

Xiong Nandi (2):
  scripts/decode_stacktrace.sh: wrap nm with UTIL_PREFIX and UTIL_SUFFIX
  scripts/decode_stacktrace.sh: better support to ARM32 module stack
    trace

 scripts/decode_stacktrace.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1


