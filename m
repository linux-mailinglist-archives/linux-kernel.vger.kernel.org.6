Return-Path: <linux-kernel+bounces-434060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0929E610E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23B9169945
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72001CF7A1;
	Thu,  5 Dec 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cZEf0Ahq"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E261C3C0A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439967; cv=none; b=SWw6gfYajgOkV1S19ujxtk+Pp8fOMoJYxAcQ6e1t1kBt82NdN/ZYXasb4F4QEJbN93EsbVx0p3X/Crhm4zN5S7Niu6XNgvP17wrI0dUmKGT2h6CVH3zHf2J3nflsNT3mj4R9U+eunczrXezurRMY5MzeLPr4IKW/Q/eLJPxkReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439967; c=relaxed/simple;
	bh=RSRtkP+Fl4Fu1wv2TYijQ4+N4uCrLGYJmNgMQkiMtOo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=tPLtp1pH+GvvdC2dnHJmth/wq3zAa4HNUdCO7lEl/ZJqcsWMppilbJw6RJaVBmK53RO6Jnrx8A4uJgVDuQQ4NGlHVRyGrtUQZ+OkBdZvVBZ704Qq+odKpHHK+szK/g4N/gJAbdv1gHh2/cCK1B0YIA4QP2QQgTJuSNDx64FuU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cZEf0Ahq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46679337c24so11134001cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733439964; x=1734044764; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB2wprHKOPR1C3FlWr0JxgyEJMDu3YBCaXKrSKkj2to=;
        b=cZEf0AhqaHnk1Bs5gZ4/uADCelK11qH12xO+5Eco7i+9xeNmjmY58s3OC7ujlqAjPZ
         wnifc1OYOM2uv2MyHx0VQmbcas/hdu1AQBa1Rndceqn45F/uIcOvkDOg2QnKEnWZHZff
         /wAyzlJS84dVFoWcBtrRBRCYLw2FEzwkLM9MwNJtqJhG8XpgUZw3zpoKjQJFmok2z7CH
         yUYokBliUjnGwM/4JUXVZrXO63/TabhUlNfYIz4lYFmOiv3Fvt3RMIMMl/mbE8Moybu3
         mGtFVKQWrHkqBL5wKFsW7Gz2zqk9VVoeOZ4BHlvoMLYCHoT6ivEUlAoyQya6I/cQgFBU
         mw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733439964; x=1734044764;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB2wprHKOPR1C3FlWr0JxgyEJMDu3YBCaXKrSKkj2to=;
        b=jyR8QIFkAnBseZPjbGfVQErm3M4qA8NwKSfHq1jrL4jBwsaDIlkuV4FAM/NxDaxelG
         JegrqBLqwGKLIKsHu/LC0Pc9SZoMkKpIiboJh80TkyvqMDan6pvsbspgeJ04kgNzxdLZ
         eNrpHuukGeEXzYWREPyH62u4+kNJZB9DDgDM5cGrlDFeOeWSSatYeDegJx/JHsz56Bgi
         zUPFwgUELURClUuU1vo7+7naFyBPGUWrDGoXSCvO+a0SjAyUk/6FX3j6G2RGnP3j7F/W
         LrOKNHNuB7+Jp3gEupcX7xQCaNIi7h0nAjsR+IQLdsWs3ERNOFObKJ+X8sVtFiaQAgTa
         LgOA==
X-Forwarded-Encrypted: i=1; AJvYcCV6mwG0r6OXF8lDvJEGO6msIPQ4lMOgOnCbNInEADOFwV9rQrGpMhOqg3cp4FYQGBJW49yU3sy2i9Pzr8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvyafxtFSkdMDpeWlZo/+Py46d2ZWD+ohkjllzeBpBKqW7Km/
	2k9Wj64ejWjdJo992reTdjAHeG53XmFUDNj9esUHKdwY8tR89Y9EnCRV2V4t7w==
X-Gm-Gg: ASbGncv99d7xycg1mdEyvTK6FKHnddL1X1U4VDi/n54+JdQ1S5YNRsgPFQwIW/5eDx8
	/lu/sO6FdiDrSOzIRYGAuKt9jIyJHfs03q29cCBNFi0R7macka8rpxJS0yLFPHF73Kcjtu+y7jp
	3zpZLotMhlrKfyo3FTV/TeTvNMDXa5KzbWy/c8h0BMCfI8TjI0wNjuF4xMxWYqHLZLPSosdvFl5
	CIGJxWcRGdSriwfdLGcb6JKF0/2GJUqwN106NSVpTqf
X-Google-Smtp-Source: AGHT+IH//YJCxBh1r9M6L58qveosoEAxtWbi0tzDXcNc0u1qOZiSVBYlKljByQTou9Gs7CfnatzY8w==
X-Received: by 2002:ac8:5955:0:b0:460:996b:2896 with SMTP id d75a77b69052e-46734f48cf2mr12049091cf.45.1733439963780;
        Thu, 05 Dec 2024 15:06:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672978dd14sm13184221cf.54.2024.12.05.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:06:03 -0800 (PST)
Date: Thu, 05 Dec 2024 18:06:02 -0500
Message-ID: <70abed262882f79e63e747ef56a0379c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20241205
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

A minor audit patch that shuffles some code slightly to workaround a GCC
bug affecting a number of people.  The GCC folks have been able to
reproduce the problem and are discussing solutions (see the bug report
link in the commit), but since the workaround is trivial let's do that
in the kernel so we can unblock people who are hitting this.

Paul

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20241205

for you to fetch changes up to d9381508ea2b590aff46d28d432d20bfef1ba64c:

  audit: workaround a GCC bug triggered by task comm changes
    (2024-12-04 22:57:46 -0500)

----------------------------------------------------------------
audit/stable-6.13 PR 20241205
----------------------------------------------------------------

Yafang shao (1):
      audit: workaround a GCC bug triggered by task comm changes

 kernel/auditsc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
paul-moore.com

