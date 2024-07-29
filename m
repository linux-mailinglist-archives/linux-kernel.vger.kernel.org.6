Return-Path: <linux-kernel+bounces-266441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0893FFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A455BB21AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25A18C33C;
	Mon, 29 Jul 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JtASG5qp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA371862B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286811; cv=none; b=gVZuSRw4yctCektWIfoN2j8NviwkaAHglVWYPeGo2PYZxNsW3OGwjcpzaUHP1ANbPJDCPcCM1Sxl+JUCsSVas0UUbf5ysdvUNsk9ZBrFG5gH7sLI5jwf12+dLN6SJKndt2bQ2CYEC+5ApcneP5ybXC5YxM9y1oJmPG7Hq949rJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286811; c=relaxed/simple;
	bh=Yi6V9x43F/1uwHOEhequ+8ZQdQJjW4IKBZXT5t/IVaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r+fSNPYLO6eTTITBDTmR+9KUijRVrCbjOu49qiT1kUWLo0tEco2ZuEZrv8ojnJXarOyVC9CoZwGl9ISs5GCVeLgt9EvXi5jurOwoAAvmwghqPdqz/PPBWzjpCfb2FN6XVzL3beGxIMLpSE7yTpvH8199BtzrwIMRZ/8IL4m/ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JtASG5qp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd6ed7688cso25079335ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722286809; x=1722891609; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBWajwmBux3IySKTOndFyzMvC8g+ycc5mQWgLJDN1Es=;
        b=JtASG5qp6/zKkA+/1JszXs5vyt9S6drvzPDPkH4SY+UYOVn5TCZEsrXGwJ2xnPLAxo
         2uN38l3Gd9Jn3gpFA3reEJdtiscoZ7wP0dB4SAqhqrFIUeG08JU76M7FEIjRVzUnCEnp
         s5X/dltmvJkoLXZYRdMJYmxy7DFDCuZnzNez4N3KtHBnx/GHuoBl6uQ32gOvUL97Lc9G
         72kpohiv4Qn9+SS0Agnwkp52fBzFCm6cuNGaMGwroTwq68MlkjnM+Cu3a3B5y5bCpzMg
         /Qsf4/9ZDuAqRrFnPbO+rITY9oRE8OULTUiwGFxYxTcRqnptaiXF/E1+aBgACFSEND1Q
         st3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286809; x=1722891609;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBWajwmBux3IySKTOndFyzMvC8g+ycc5mQWgLJDN1Es=;
        b=HX2re1MEm/4wPdXp6opr+WWU9rXqnTmJ3JjdSEkt8uv0QB9oN4yGSx7ZJ0EdYYhut2
         bbWA+oDLtkf+VIWsA0cPtIFP2ZlBJOeWpWzD+N2RztzCEwQCTcOGeCbD3kgja2M4REeh
         mR/TRvmZACQE0lKqS/5hBq4juObnosQ8PiiLS6c9zYtDfuRIW8KlaqgU2zaiMuL3CxBi
         8nyA2weoMiSBd6NjffolSVSw3rqojCbrehtli5WwrsVM1p3dKyYdgKMNfbyONb95/LkH
         4njBFREkHXqsUvWrfHYic08uOdbUSx7W8iNrex2W+RzuxMRjjDoSWE+PODx6+VwIm6vG
         EWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrfAVSC0qr/jB/voyoDelZNSo3H9D0yNvcU5Ru0WyBxniuMHcwruUP4zAiDaYUG6XbOtONvz0jdXg11aANrONmvh9bBt9NIxt3nOZq
X-Gm-Message-State: AOJu0Yxp16PblgWayipCTcg2LbYgrXlDD6rMNDrKwajGjSYbeUy8TaJ9
	yfuTZa5FekFS5/sPU2y17N+AP4wDxNoeRFDkkQ329qEuW0tS4odfZzBMR3J4g8E=
X-Google-Smtp-Source: AGHT+IFWN7XJGgnRNOKYhAQ6RvEV2hbm7GBZQq7We5j4dQZlZ7s5wxd28Sb/O6a6Dv+4C1RDj/nozA==
X-Received: by 2002:a17:902:e847:b0:1fd:82fa:dfc2 with SMTP id d9443c01a7336-1ff048e58b7mr73464585ad.50.1722286808802;
        Mon, 29 Jul 2024 14:00:08 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f71d61sm87341745ad.225.2024.07.29.14.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:00:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Add missing licenses
Date: Mon, 29 Jul 2024 14:00:01 -0700
Message-Id: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANECqGYC/x3MWwqAIBBG4a3EPCekdrOtRETYXw2EhQMRRHtPe
 vweznlIEBlCXfZQxMXCR0jQeUZ+m8IKxXMymcKURWOciiz+GhcEj3FnjyBQzmltrW3bsqoplWf
 Ewvd/7Yf3/QCUEoX7ZQAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722286807; l=547;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Yi6V9x43F/1uwHOEhequ+8ZQdQJjW4IKBZXT5t/IVaA=;
 b=iPYM7ZTwQPu/7qsVc2YKgUpqTXA5CKXRA7Mpj7X3IuVmrO/lZY/mb2jb5s4aswyC/c2c9V24P
 Qs0Ckwjy3CmDZ/Ig/qME1XhYeVxPTK4wlGtLNGejqBIMsHenESXLE1L
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

I was poking around some files and noticed that vmalloc.h and fence.h
were missing licenses. This series simply adds in those licenses.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      riscv: Add license to fence.h
      riscv: Add license to vmalloc.h

 arch/riscv/include/asm/fence.h   | 1 +
 arch/riscv/include/asm/vmalloc.h | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-riscv_fence_license-991133388456
-- 
- Charlie


