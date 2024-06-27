Return-Path: <linux-kernel+bounces-232632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5391AC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8812A1F210E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20460199252;
	Thu, 27 Jun 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOzglmYV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16649197A96
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504016; cv=none; b=VI/cFpJQSnRvLTuFbkjjv6VICcJ58BU7NbuOUlC8ehvSvwsL4B7RKgihYM2fjDP2BqVDmmO11zuzAzUDUOS9Ghl98oxr2QbtodnYxlBIxsEd7xCcjYtF+CkmpPjIbAd3u+l1SZopeAIqyC+cjCEmHjv0kW36jWOilRA+KgJAl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504016; c=relaxed/simple;
	bh=dT8ulryxO9jNyqI/6P5VM7e1jUorP0EUT6+vrOZ/jk4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rZi6aY6W8JOfkK2x9iY/6iG63cZsaOVpL9FjmMbQc3vZBpHBCAd37lVLs+ktvfep1hTcFiAcDtl+u7dVBLmKuvvwgrcCPT5G8GJZaGJNcwdPJbJxhiJ0kc/K/a9gCqNpN9+bccUXZeflWbDRbXMdIr+UJPtaakqz7G+gEy8HkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOzglmYV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6499b840395so8542417b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719504014; x=1720108814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMctsYknpmhgclYbrXLe3svKJyyKorvOgU6J20+Tvko=;
        b=lOzglmYV7So4PWpoMm7StAMCA9/7/sIzAo19qR2dlLA1WIaFu5m8CFJkBnpgrIJetQ
         2We1Lwhq1T6nDf6rjCeayGjwkblNduv5YKAOfEHIDaK11miiCjGTJ1vMsgyG1I/dl+GN
         b0dt1M+t4V32oAp5crMx78VwcBCegcGOEHAtC/uJTP6fwdWwAdeFNjzwxRd0UOfbhjKE
         yyb8emH5hhVYiy86pSFcayW0S+j4PWHSuBUiwpiD2Ug/oY2tKrBmpq29iHWA4AkR4qpB
         lQFWLyaosGCWt4cR8DaXKmy4ISpQMTpi7/yrKhVE5DfEeIJc1W5LoRw7g8aPfas5wO9m
         TZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719504014; x=1720108814;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMctsYknpmhgclYbrXLe3svKJyyKorvOgU6J20+Tvko=;
        b=fzySMvdly8rSQRf8VTueVnC90iLYrc4XwiF95W4xAjJN7w58CE7pu+K0uFVa3wxWn4
         wIQni/dMFFN45Zkpn9a7xUgjVBb+Z5Z6Snz4ULWLoZJKTGgmNS8upQvg5E+wbbQ97Zeo
         HnEyuHEoFAtmybQA8xIlHzvzCgyJM7SWF7UYVSYYInnXZAuLw4hPtvCtmo8KwpZHcQKs
         dc+TS22qa//sKtrJFrVKHjgLm2CabGIq33hxVTvjWTDqi9ZX16lRsxswwMTaGEZMKzog
         AuHG05SxZ9iqqt90SxFgXkqzFUVCy45ucRUZkE2EzO9KSgQj+9gsWUJi8/Z8FTGXoQmy
         IpHA==
X-Forwarded-Encrypted: i=1; AJvYcCWtiyBR6e9+hLcNheNHV/nJ/kwwPY2e48n5n9jWMb7q59NOiu66V1GxtOvsdVUnvSqK3xri/O32ORlbWjxXzV64mu+r51vnCxLorVq3
X-Gm-Message-State: AOJu0Yx35GhD8Q2FqXsQWTK4L9PJDplOoXB+Eqz05dppQ9RsztK9tzOR
	MQhVr1f6lO0tt2WWu5pcClFw2LQ55NRSCn4uiVwPJdtf3DiNTLbCPz6trPgdLB8tTeXmK0fdPGj
	fle+8OiJIAQ==
X-Google-Smtp-Source: AGHT+IHd1pMBb9XC7H0CiweHnQb+sjFwr9VAirsBjXKpq57BPcKIcNkU7nkJt7JWP8XVC4vWSGqJpDRaWgHOoQ==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a25:ae9c:0:b0:e02:bd2f:97f5 with SMTP id
 3f1490d57ef6-e03451f86aamr13928276.6.1719504014050; Thu, 27 Jun 2024 09:00:14
 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:59:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240627155924.2361370-1-tadamsjr@google.com>
Subject: [PATCH v2 0/2] small pm80xx driver fixes
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

These are 2 small patches to prevent a kernel crash and change some
logs' levels. V1 consisted of 3 patches. One patch is being dropped so
it can be reworked and sent separately.

Igor Pylypiv (1):
  scsi: pm80xx: Set phy->enable_completion only when we wait for it

Terrence Adams (1):
  scsi: pm8001: Update log level when reading config table

 drivers/scsi/pm8001/pm8001_sas.c | 4 +++-
 drivers/scsi/pm8001/pm80xx_hwi.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


