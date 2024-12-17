Return-Path: <linux-kernel+bounces-449938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EA9F5860
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787061625F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71E1F9EB4;
	Tue, 17 Dec 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="euq0mdZi"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3D1F9409
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469624; cv=none; b=hK+B60QenjuORzVfAvL0aTCi8n+KcBQGuELxh/VAXlcNiSGbyILWgLEZxoRbiXJtjCOSHuTu2MVo4HecYmgty05mAK4wjv8zX0hBHs6Mzy0u2ejogOP9jTONVy9NP4dBVr+/z/KWiVjcrRalqYa1Fu5+4hrnh44qGzOIcysUUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469624; c=relaxed/simple;
	bh=z71/4LhvavwXxWLiyBowbyul6ffxcN7deE9XCUuemM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ne6yd6kdV3Feds+2yodcl8/G+oy+It4rdoO6z/fhGYTNRpuGAX/cJi7tNYaudDJ1n4v7u9kBwQKrDglSuDqF+AARwol3hKzEXtq2As6A40OHYl6xah2fN1FnyC82ZK3UocBRYF5s+kGSgmrRwyWPz8Fo60AIHh1ZPdwBqtdetgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=euq0mdZi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46783d44db0so60940271cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734469621; x=1735074421; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2z+gGRH3Hg4TH3ErTWbJ3p44r0TEnT6v/hKO6OREek=;
        b=euq0mdZilSrcEPUApIrzLj4iOw+WvlxR72Y/ln8sORlaq7tqRbW1bzLYJHUky3H50f
         xMt5JbPzArFi9wOSUpPCvaF9IH6IXC0YiSheps8GZ7K67eKKoHBnvNJz0zHVF7/i9QbQ
         nBhLyBbL28WUzGm/k/4SsyHO/u8nUUmpJ9bqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469621; x=1735074421;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2z+gGRH3Hg4TH3ErTWbJ3p44r0TEnT6v/hKO6OREek=;
        b=tum/UoPKjsA7ric4H1yWOA9/LEI1sDwlrGAbSb5hEOUTGvpgrKpZjwAK3OTc2Qe+jQ
         zgM1/bP0evL5d+bUT/mRlcyulp0e0EEiUoNp4131N/hx0jHzGTj65APLT6c9WF6JsuMT
         EJWNiMVjN6FlXqElCGTKWAfz/t/Pk0Rd2MDjMcgFiAJjOv3VilAz5LDaIv6s2pU0kdRd
         8cgBv6Ntp6w5IJqbKxbHgvnRh7EPaIkIhjryICaPEn38mLpM+WyGYeruV13ZtBD7eU07
         atPJUsi1URPwLJDccluMijS5jlL1pC43AZT1C+Y+NqqEgDhLOafLWSAqlTF8o4UZ92ss
         yzXg==
X-Forwarded-Encrypted: i=1; AJvYcCV98ff1HdBvgvC/oe8vRpcOAGEXd86KYniakAo1rImq6wiYsvl1mP0yQMAb1zrKQIooZIawjFsGtXX9UjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7e3l5Z5K3flfChPJ5pvBLu13pjvrS6Jh9do4GpVyUhhnb6C1B
	MLUDJJsOczq059cbAqo2LZXLm8AzfvlOM2QCR1gPhhFlIfNsubQ6tZvRjisBzKxwTtBtJF2KsBg
	=
X-Gm-Gg: ASbGncssCduY6HVCRlkLjGObKUOuIG8ZSU2WHW8W6irybLHxDyDDGc4p8ljZCFBpy2W
	CQwNrjoaimBFI1Oz7Wthi7o41Oqf/3LPXlkw9uR59UlTuMvPsoH6pPUsoSOlwrj9BbBuy0N6VYx
	y0/iA5U9yVPingYuTsCifOpo1PinD77j4cDbtx1ja9ryWsezH96jJnemoO0/Y/puzlMeRemn4GJ
	xCkdvvG2sDYtKvC6RmigtQeXfW1Ll3HkC/wKzXo8zr53D24GZzRwUdlnPS472my5EmPaLqvtPiG
	8GUpwXqL9NIy0nn69pUStx8OkFWTX1g=
X-Google-Smtp-Source: AGHT+IHiXAEmTYDeAuIe5fitEw8m4zt/Upe4SJ7Tdc9yvYm2t0ddYn4mLUyAzjkWjLDDLphiIrxuxg==
X-Received: by 2002:a05:6214:1313:b0:6d8:a7e1:e270 with SMTP id 6a1803df08f44-6dd09259c8cmr9575086d6.40.1734469621208;
        Tue, 17 Dec 2024 13:07:01 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f2a7sm42825276d6.27.2024.12.17.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:07:00 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: uvcvideo: Prepare deprecation of nodrop
Date: Tue, 17 Dec 2024 21:06:56 +0000
Message-Id: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDnYWcC/x2MQQqAIBAAvyJ7biGXqOgr0cF0rb1YaEkg/T3pO
 AMzBRJH4QSTKhA5S5IjVNCNArubsDGKqwzUUqdJD3hni47PyNZcjH51PdHojWaC2lTv5fl/8/K
 +H5PsaExfAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

We intend to deprecate the nodrop parameter in the future and adopt the
default behaviour of the other media drivers: drop invalid packages.

Make the first step in the deprecation by changing the default value of
the parameter and printing an error message when the value is changed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: uvcvideo: Swap default value for nodrop module param
      media: uvcvideo: Allow changing noparam on the fly
      media: uvcvideo: Announce the user our deprecation intentions

 drivers/media/usb/uvc/uvc_driver.c | 23 ++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_queue.c  |  6 ++----
 drivers/media/usb/uvc/uvcvideo.h   |  4 +---
 3 files changed, 23 insertions(+), 10 deletions(-)
---
base-commit: d216d9cb4dd854ef0a2ec1701f403facb298af51
change-id: 20241217-uvc-deprecate-fbd6228fa1e2

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


