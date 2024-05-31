Return-Path: <linux-kernel+bounces-197285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB28D68BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE38B222C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1917C9EB;
	Fri, 31 May 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNDMffZo"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33C4C62B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179184; cv=none; b=SlEB+nhj+KmKFetaGMB1yfDrZCkN09ZHnawof8xh7VbRaYsZ/oCyBsfNRgox1f4p5uBJrRikayzWpDlje7Ek16K9BDBaOz3+mmL8/XOZ++bYCSjoUtwk4kLMRUYfTE6yac4ouHQlSmVStSRACrhRnITuuDqsDe/AhzvxkLWSkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179184; c=relaxed/simple;
	bh=bq+eyCXXykU+NbxSrt+C4Z75zBu0rCGH1oj+IdJ0WEU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gjbKOU/f8eDhrKx+Gbznv08UAS+K8CZLp9KRpwt0LRqBJsTA/HDLNNGXVyZRV6lUenJ4K/4GXSZp+SDovXDWQkvNQd3mBelfVzAD+ogUzbr5rKJf4ZVvRUXgxeRQnLYI1oRY18nPEiTo1xDv2lXEkt8MJ0Olab81uoRKu68RFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNDMffZo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6762109c06so258343266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717179182; x=1717783982; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19QCGzcPpAT3bxMIkfNItIuj6baVRDP/LAogeAqj7rc=;
        b=kNDMffZoVUsoh9yRHx8+yBcSwbXfkAPno4+9BsSibsXWEskKdgQu82UfMAtOsOv0WJ
         2LqgGU/xBuBHcfIZe5+28XWJNvZ9joZJXYXyInLbEtiI1G/73LhR+cAzKbxqfr/SB2Zn
         B4AMLGcBtRYw2gohR/rJ48JVJO0zzW5uR2dZKrp8BJSODcf5+Ox2CoKhHdFcodH4ULEd
         xm3RucTfu9ZG2sEmRyJMGVjy36Ch29XPk4N6herejjJE8pmVJyC3eNu/GwkrnaNp4E1e
         eN75tD1swRlDL0zx/QZKXieNpkmnDEQ1/zKPMV5xPkBQYdFkzLCox+hDFPfm0jAg1U7Y
         AZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717179182; x=1717783982;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19QCGzcPpAT3bxMIkfNItIuj6baVRDP/LAogeAqj7rc=;
        b=hM3DP1js8ZoojIqidR/jZ2urQo6Qqr97nZjmCffACedsV8Sdup3MHvCnSE9FK4/y3C
         mCK7ZPABxPxLckzQMibQM+rA1AfT2S8qSXvJgijthXTXw6IBGAfPITdDQxf9pOltRvk4
         be9WLmXm9usvXBXSM3uU5IBfPu9iwKpIs5wtoQZuFp4QXCkkSWQZPH3GKwmBnSGIu8ye
         DVnQ6QGfH3UF2kPlFQs6hrDOPZUn2jrHGAR9Xp/sCcSVcJj/u5mD4xyVhhJU8IyPNlqQ
         kkxmBHEN4dgaysm/IcKyuka7tOqZKbc8TnWu22Vmjx8hvYetJSyaP633V2+pBxTMeFeN
         filw==
X-Forwarded-Encrypted: i=1; AJvYcCW8PJJlQathHA5VYCGFfFs0bxPVpmDeSQfCufaAnhVyoqSa1ylg8sThoa37IbSECtXYYWK9V21r9vpU0PAfAoTTE4G8Xlc3bcTJSbuI
X-Gm-Message-State: AOJu0YzkBU+aYaK+iWF149RLycvvzBJjbFqxOjI/fzBLFD3ncD+7wMEV
	mYVK34pbN+kgefx7I+YPbRdoEi9zESMHhSoaTyOB7i9qAoqmC+7dKPvkhQTk5Npj1m6ZMwg9dOl
	AIzbKjMV5ihrKAaq/+/t/84aKhTWqAo//Eng=
X-Google-Smtp-Source: AGHT+IEu6jwDTf4ndHtHNlCFQgKI1tl3XNk6Kw80GEZPtX2xziqQZbypiBabI7p0V/sK7aoGNnniBzkqGK5V1NycuaY=
X-Received: by 2002:a17:906:d8c3:b0:a59:a979:2b03 with SMTP id
 a640c23a62f3a-a681a87753amr224122666b.23.1717179181370; Fri, 31 May 2024
 11:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 31 May 2024 13:12:50 -0500
Message-ID: <CABb+yY3AyxdWHaQpN0zgbwBeQ0cmXs+XrMaRvYF=h0a3tnO0Ug@mail.gmail.com>
Subject: [GIT PULL] Mailbox fixes for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-fixes-v6.10-rc1

for you to fetch changes up to d551ce15d08114514d489fad63bd275de2aca862:

  mailbox: zynqmp-ipi: drop irq_to_desc() call (2024-05-31 12:39:15 -0500)

----------------------------------------------------------------
zynqmp-ipi: fix linker error on some configurations

----------------------------------------------------------------
Arnd Bergmann (1):
      mailbox: zynqmp-ipi: drop irq_to_desc() call

 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

