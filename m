Return-Path: <linux-kernel+bounces-257753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C7937E78
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F131F21770
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EA2119;
	Sat, 20 Jul 2024 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcXwX2Fu"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC93C38;
	Sat, 20 Jul 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434932; cv=none; b=r1sfFtGhIuHIrCKuVuXWghzZPuOrKFg1NrotWLSS/eil+3vCgmvkKQQA5qO2XKI15uMHNn73oxe2XzlpstPenozqiUqf9w2gopGwx6yXDi0OSnoWD8HEZnZlNbkpFxRBZrbOPQWWfZ+V8lRZR/MQZbSlibaAwwnrCcabvuwvfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434932; c=relaxed/simple;
	bh=zUBoNm9L2P4BvJzYef7TGM7Ywv7sEDHUhFsMSJtHLwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BON3UoWpC1kkwiGiO86p1LssyggTs6Uf1EB1V7IrG14phAXDcn1b83q+41IW/bwdgr5xesCjT7nMLjNiY7rgonbFqkj17aT/+3Qq5XTGNT9bIZXEamKRzFvNxGvm0MWp5Wq3uP1nlTyAtaOd/bwlP2Tx0r4yY7F+2z46dLnH3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcXwX2Fu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-703631c4930so1287715a34.1;
        Fri, 19 Jul 2024 17:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721434929; x=1722039729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yz6ITHoYpXMaOJQ35n8YuM9L6Fu6ZwJjDXvHlnNVuXQ=;
        b=KcXwX2FuKFE2NNZEkGCFptsoW9pbETjr140TrAMDD4OY3WTvmXlzlYVWPx/LjVAlZK
         LpUoOSdRdYNdqlTgbSxJU2n642yd8bSS9M82pKnFNKeOW4SfTMLzuBZQIYzbGLP9IG8a
         oKYsAigdiVFDBDNBzmoBvkkq5Gy9THcBwMFb0jJ8fH4bCmyzoD7glTo005OgNd/T7cic
         B4lPfQRzttkdtWannnB8gq47oiH6h56JGQTedacAXylXoighNhcA+KpZZeJTPfqcvvlW
         cn6AaxVDZEn0Cc0gQh/kk6caszTeFEv+kQxw86sO/r4SbUxWvAVmEnQnZ3fZO39St0ZD
         qAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721434929; x=1722039729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz6ITHoYpXMaOJQ35n8YuM9L6Fu6ZwJjDXvHlnNVuXQ=;
        b=fOmHjkaqEqC7vQSUL0FJmACVnwQNRfUBBpsyRHfvHPH1lMbhVSoCF3mLDQT3xu77Wf
         fYDFQ1L+CNIuEk1OZL8o+MH5hQzcELC5xEDzi3Nat35lGtRPcocoebf2OPChCRjvVbQJ
         SwpBQb7FOdjreBaoHM8x9ppU8A+0Yqlv9HDjH3YhAWZlxXqldLUt6cQsXUFv4tJNDn9P
         89gwtFGfE4K8F38oLp+S+fnEniyQrw6FxsFrDQ8RvXbge6Lb+WWZwZazAu1jZGOQkZSF
         33wmTIJEl2ghS4/NLtafoXyNYVaCf5zPWFAK/iG/sZsYVnQQLLCTLzySqqhpVpHJxSez
         pcew==
X-Forwarded-Encrypted: i=1; AJvYcCV4OjaIJtd7gQwem/E9WDdBI97iAEywNvHo9Wjf4a4ACNihd80uqhTK0rz88Ifz/O0iom1AVwZA0pw25kX4dp8Od9XK1VUKF+C+ng6Pg+g0UFrg2LnxPRSfNZlkH3QKdf7RGztfx4ao
X-Gm-Message-State: AOJu0Yx/WfZkCmWuyAMUJ5RY+yQcEKlJQIaVdWlPv2nM1foROHvdAqyT
	SJDNAWG71kDEDT367PfHTwGR2kvorZyqJZ/sjlsGX5t/nSuJRnTo
X-Google-Smtp-Source: AGHT+IHn3A1VKak6m7x8LOKpMncwCKH6km0VzLzhUhWEGqJ6XworJesHKzARz6Iv4UZfKRG75yw5rA==
X-Received: by 2002:a05:6830:65cc:b0:704:fd0:9524 with SMTP id 46e09a7af769-708fdaa265emr1580054a34.8.1721434929085;
        Fri, 19 Jul 2024 17:22:09 -0700 (PDT)
Received: from pipaware.austin.rr.com ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a582fsm532142a34.12.2024.07.19.17.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 17:22:08 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	sergio.collado@gmail.com,
	peterz@infradead.org,
	rdunlap@infradead.org
Cc: bilbao@vt.edu,
	jembid@ucm.es,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH v3 0/1] docs: scheduler: Start documenting the EEVDF scheduler
Date: Fri, 19 Jul 2024 19:22:05 -0500
Message-ID: <20240720002207.444286-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I was in the process of updating the CFS documentation, as Sergio proposed,
when I realized we don't have any EEVDF documentation to point to. I have
started it. I know it isn't a lot of info about EEVDF in the doc, but (1) I
wanted to get the ball rolling, and (2) I prefer to keep it light until we
have a solid idea of how EEVDF will actually end up. This could take a
while. When or if it stops being an option, we can revisit it.

Sergio, if you’d like to update the Spanish translations of CFS and add one
for this new EEVDF doc, please go for it! ;)

Thanks,
Carlos

P.S.: Jon, I have triple-checked for compilation warnings, but if you
      encounter any, please LMK the versions of your tools so I can match
      them moving forward.

Carlos:
  docs: scheduler: Start documenting the EEVDF scheduler

---
Changelog:
  v3: Removed labels and used instead paths to documents.
  v2: Move file within scheduler index. Remove incorrect subsection
      numbering.

---
 Documentation/scheduler/index.rst            |  1 +
 Documentation/scheduler/sched-design-CFS.rst | 10 +++--
 Documentation/scheduler/sched-eevdf.rst      | 43 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/scheduler/sched-eevdf.rst

