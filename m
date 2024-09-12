Return-Path: <linux-kernel+bounces-325779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C99975E21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34791F23B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0C8F62;
	Thu, 12 Sep 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaCoiPZM"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9242AE8E;
	Thu, 12 Sep 2024 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102089; cv=none; b=K9h7l8rp435YyHDNtDebqe9DUPFvJPoLua8S7vgDEBFriy2rdmW1l8Qu/edpbqrt8JmZjoJUjoNQMC8bgZNg1DWNnfp9thvOsJ8VXWlqCStUleT5DHQ1DIU2ffBqeWoIDr4iyT91FhqpvI6yWEjWa+o142CPiHpWR/kmOOINglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102089; c=relaxed/simple;
	bh=CPj65I50f7r187WjwZCPvAoi2+RdaRp3REjHDGBgUx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTXzrZjrwUxY0i3BFASAIOT6GgGOt/ipchMGwX9CmPWDCGcPC/O6uGZvrVO4mx8q9RrUvrMRYDQspKCXqGZkaEEzSjPXHsxRFJM3cYEgoZsjGExsbEA78PDzJdXo+jiNALgzeM1aGPAggKjzDJpYwQY4bSbcrKfSnVUaGkG+N1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaCoiPZM; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a99eee4a5bso33906685a.0;
        Wed, 11 Sep 2024 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726102086; x=1726706886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVT8uk1DgbJLuVC+5Vm/8vjlUaE3zX+zUTZNYXP+jWM=;
        b=CaCoiPZM23yUVnYuS/WehXV+TKmuaVD5ULPWj3VFTHB34SK7OX8Itqnrrm6BaiZufh
         zac8CzY2fOjf4K2YIFIVwmxlD77Ke9KFAYKeQqO86pURGAV5FYCEAM2m28o58W4ZPgpO
         +jKEpwg7BlJVgQi4UdlC+r3gvg4fDOlykL9P9xJXMJxqmARbyUz5Lxsztl+XGaAH3XZM
         obeXxWtQ4JFKXYY1ENjWaZ9ZpRRIq6LdVQ3wwzGB0pUQRZQt6mQZ1Bjzm16naeHEva5t
         r2rOd4QPMDWK0eHImURhBUeWk1jJsdzS9/W++yAr3emvtQJf1iYaeciObpBNZBAlDQDq
         dWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102086; x=1726706886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVT8uk1DgbJLuVC+5Vm/8vjlUaE3zX+zUTZNYXP+jWM=;
        b=u0ztasxur/G36WqLYp3JmNlIiGxehpcAiABvmWPQiSWOVNeLHrVKcCpQ9AHoLrZmsz
         t0ywVOeE78a/0hjbPO5pnQmv3gEeL590fIfZG5toJp5yCiHoL4M+rloOMiJGc1ISN6cK
         fZud2icjgoZuU/zSdJrHC5eTz848Fzfy4wC7prNXt8oFpZM/Z74jeeKDP+ZHh2nbP1Wd
         1eZSsiliwGkixI/BPK+y/IxvydLQt7L9Sv0PSgj2jdzRONX3CxObNkSP4X4tTIR3/pNT
         ur/OcTpElBSuoeQkiYVo9Jx5lc79uvm2x8fozdkY1wJXWOLwNEY0cwnZ7/2PptAyQhIu
         1TEw==
X-Forwarded-Encrypted: i=1; AJvYcCWIQ6JaTDPGGp0xaCAnDF0Frz5wnI70acATlvjjG2+4WM1zXYrjllp71Uj1wjVLkvUxvsdDMVJDnIGHEIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJahddBF+uBm2frMLwy9IGWhwT8gSUiFjAtPEAMoKs/zS6Yo0p
	UrGZdzp5f3jwz+rPcNoYKumXwJrZtF+2t1a098eeNDptd8cWYe786s6Nbw==
X-Google-Smtp-Source: AGHT+IG5EFaEKa8H4y33hmLWo8+u7ZHzmsNqvQpkSC/W2aHf5nnn6B0x65rPH2wMOpPfOi31Iffmqw==
X-Received: by 2002:a05:620a:458f:b0:79e:fcb8:815c with SMTP id af79cd13be357-7a9e5f90c03mr136234185a.54.1726102086381;
        Wed, 11 Sep 2024 17:48:06 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a9a7948814sm481689385a.14.2024.09.11.17.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:48:06 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: dennis.lamerice@gmail.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] 
Date: Wed, 11 Sep 2024 20:47:47 -0400
Message-ID: <20240912004747.5417-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed the :c:func usage in the journaling filesystems page.

Dennis Lam (1):
  docs: filesystems: removed the :c:func usage in the journaling page

 Documentation/filesystems/journalling.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.46.0


