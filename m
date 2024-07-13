Return-Path: <linux-kernel+bounces-251255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B6A9302B7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9018728366E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD379F5;
	Sat, 13 Jul 2024 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E26ExgJb"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2239746E;
	Sat, 13 Jul 2024 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720830738; cv=none; b=Z5dVSz7HRqOwxSlloI1qaMLSg+VKckTtx7wguhClr0kQaNevj/vWFWSrtb4qDy2Wtn8WoGhUWb8zcoFvHx6ka1sxPh/czfFh8xQSHGBcaTLfl/ctNgCNrhpT+DJdEVSnfSPFXFYwa1qennwhKGvZg5g+CNh0wHrn8mBje3zXEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720830738; c=relaxed/simple;
	bh=d3mtS8Zq1pnyZqlhIydhbreLOT6EbIGTzwBzZYoAJUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjdztEmBTNEkGLl8phBVs377lzwvysk87VGNKQ/vq1NHfmTELhCpi0Yv3AC4MYj1Xp4Bb8aP9WRyQItObjES7qHxWF8PR4n/RG3mB1rTpWsKAwlocHKyq0ie+Jiiz944ThfI1KCdIqPVd9FD03aVaVqz/nyzno4PuK1m22NmhzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E26ExgJb; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c669a0b5d1so1342116eaf.3;
        Fri, 12 Jul 2024 17:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720830736; x=1721435536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3+iIt+iB5ajjxkFjvCjSBa/DXxUn6LEHuoyEw/QZGs=;
        b=E26ExgJb2U11rlb8F7MntaUT1KXQaC9JPtjZrzEkkJBmLLXsP8tpQYQKB8PmSjMi91
         vNxKo+u7M/UwelHvzf0w6wkPq5vWinQN3aXpcas1nSenN4rcwr5764eSzpS6JIhBp17Z
         YtvBbUizQszJAM0jfpu/p8AyeAYbLPXc+NkuUmvo8E/VtCATcdrS1j0OPB23OTsjhECF
         tFO15WBfYvHylXfHhlgDgm6icB8vw6pDdQWXMJt+UgZxKbYdhaU3p0UBPuVr8ITUJ23/
         zmt4n9yrA5OMxfNnlWg/digo0xWEgykS0BO6kdz90gWR5JomLjr5oIX89iVRk+7KRWLq
         9Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720830736; x=1721435536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3+iIt+iB5ajjxkFjvCjSBa/DXxUn6LEHuoyEw/QZGs=;
        b=RM5U1u2GOmtiKsd1hZj05SKB2c7qU/CtpAVafP2n7l6KanXIlVRLN75dq4bNaDSt7u
         O7nedwwZROP+5+CZ8CPlGQepZT1KNMRVHzcBy0IOLBzfmnp0WiYmmWgyYuUSe3rQdk6E
         4K+ma/y0ZtPX92uzXigzsdAzjgQwR7x79LnUmllNE69u59I0GTyv9Z5ZetfDEkeJKp1D
         LtwO4TuTbGqJYkHTAWuABySMxpHtJKYJxTlbjYzrOHR2NS+5762QNZWwMVIRPGL84j4L
         NG51uWmhpB+WGxCa3H8809glYsYfeYNel7Y3jfdH2AiA3aqNxw1APRdyk3joUeisN6s4
         aePQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRu6/+bBjJF0KGdMJvimUOGKfR4EKFr4JEfdYZw/8jlZ2iUGC8/YwFzRnpTkC5EsGqvC2unlhsN+Vg6k0h0OO2niAX+uuutsZV/w7AvFx4qn8ghznYijsPjUo/Wzq+ZZ+8z9QagpKW
X-Gm-Message-State: AOJu0YzJ2SUqcTHqu6q+DIexONURqTbiki9hjF8NnmDyugJgpHpOo1Cj
	EnCSOF06pVmR+CQTcEqg5ETH6buhDP7Zd1HPoo2mDhOHmEFR9dS6BuCyuw==
X-Google-Smtp-Source: AGHT+IH/cEWrX6kE84kdatGw1rNHDlmGYn66XQAZj9kExyy3V7hBJ+ulUID6yOvQVefycBd9dASD9Q==
X-Received: by 2002:a05:6820:200b:b0:5b9:e7db:1cf8 with SMTP id 006d021491bc7-5cce44e2a66mr4835330eaf.4.1720830735772;
        Fri, 12 Jul 2024 17:32:15 -0700 (PDT)
Received: from pipaware.localdomain ([69.219.169.121])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce776c4c31sm25978eaf.45.2024.07.12.17.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:32:15 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	sergio.collado@gmail.com,
	peterz@infradead.org
Cc: bilbao@vt.edu,
	jembid@ucm.es,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 0/1] docs: scheduler: Start documenting the EEVDF scheduler
Date: Fri, 12 Jul 2024 19:32:11 -0500
Message-ID: <20240713003213.4008440-1-carlos.bilbao.osdev@gmail.com>
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
 Documentation/scheduler/index.rst            |  1 +
 Documentation/scheduler/sched-design-CFS.rst | 10 +++--
 Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/scheduler/sched-eevdf.rst


