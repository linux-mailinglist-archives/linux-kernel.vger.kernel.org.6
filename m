Return-Path: <linux-kernel+bounces-230068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76E917805
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A91C222B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D014A4C1;
	Wed, 26 Jun 2024 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yTyQTI4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AC1339A2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379367; cv=none; b=b9H21bojK+65SZjR+E+HfiueTgXbrgjC0vFnuVDkpQ80F6Q0LYZML5qtlXB0rYqdYMlf6FwpKQgRFRuVbR20n8PwPtqYs3+T8CmvLbQto63sgQ4cyBkxAQzs1OFFYscbXLq0WkbyQlrg2F7Gm4plZAZWuhrSbRa2r6tApbCyhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379367; c=relaxed/simple;
	bh=lT52MzFD7qpYUTWTDFDG3pIyxKvlTWAutLR1BrNxUA4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=psHbae3csdaUzNQpUmf/RY10avfn3yGPVK/h3MrV9cA9i7JIpKTCrPHeQwTHS/P07dCmCmCxeVaLz8Cs8awBFeubQYeEknzzYClOYX0y/RHSCklTjC4vILHygkPPg8UyyM7B4VvWDmqtoM5HFvyxy4+cSspE0YaowwVyZ8NowCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yTyQTI4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e032e254319so1861684276.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719379365; x=1719984165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PvKOlYXT6DEYuH52e2UV3CHMNpzpAZjsjgVTw3pHU3M=;
        b=2yTyQTI40SY/n2CWTwiasEN3EWe+j7ikYwNcdfe3GWca5tMUOQUJOJVfipytXYAW7Z
         H5qq9xAHor7BtDkkeKmb3FOtxVuXkQDk39ZOU3ZU+LFoHZxdv9O/YMp3a5OqxEJ6V7ni
         3OKyiGSV5NIUEVQ0dfeA26V+9f/KUgIXouMn0OoustFmdEd7KEy37K1UqZ6qOtaY3byJ
         5D1rblHOTFERjiG7dspb74zjyzU2dr0QgOtnaoRlPdyDBVRubIEsjQro7vczKhNS9iuT
         ux0qdaMyM2B9Yo+2Rn8SlC6r8aAQtqpMFLrcF4XVPJuYnSgoDAdTNzp3H972YVqoRK2f
         Ijtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379365; x=1719984165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvKOlYXT6DEYuH52e2UV3CHMNpzpAZjsjgVTw3pHU3M=;
        b=MPCO2NYBAOOmhkiy1sVP/EMmaevsGkHPesPTMoaddaWGVls4p9IaL5mjF0HVHHIHvz
         O60G5txT8sArFRiY1IDYuPRU/rXKF2RUAi+dLZ4kS5oLuZGeAjFs/uBL/l/VoWGxep1R
         +qmrKFL1R8qjPZIot+FTokqqmKUWqwdU/R1I7xAWVa0+Vw8KCLpSOf1QTZWrKI3bVqkm
         marGHeLQKOYgsl3TQsKnj4GF67oUXMSlnfT45L2iwJvxqXna8aLabpc5MV+ZnbNJyVXb
         /uuQtCchtzf2hc9IA2ri/cri/Ugi+dHCZEEAARuPSNJdyxlvrypFYTkfnB4nGSRim2VH
         8MgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcQC+k7g2oukNvYjF9v3r+V+JsI2QDym+VB/70QHAOpUbO1nURvlQ1bmGo62VQBP6/1kR4q/SKxcaypEAfU/C7tdsB71TOdANjeL6K
X-Gm-Message-State: AOJu0YzecUvOldH9OnGz0S88h9kTeEvHWiYBBzaf2S7M/434CuUEvCHQ
	ajlJJ+CYXpleFgK6FGVv1Xuk09MYREiAksNvY4ZDg3vz2EGc9u6KUjFjpLG9AzLqtYCWmDRsvid
	eqxpd/UTYxA19nLZQ/deC80juNw==
X-Google-Smtp-Source: AGHT+IGzl8x7DxVv6F3p8R1sVwIyMgFIzmWoKOItdjSMIzZLcv+zWyJvzolxM68jTcTziqMHoGm4QEXPpeTlvxEJdYY=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a25:e056:0:b0:e02:bdcd:3bd4 with SMTP
 id 3f1490d57ef6-e03040e5ea3mr320815276.12.1719379364918; Tue, 25 Jun 2024
 22:22:44 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:22:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626052238.1577580-1-aniketmaurya@google.com>
Subject: [PATCH 0/2] Select IBI ops for base platform
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds the option to select ibi ops for base platform driver

Aniket (2):
  dt-bindings: i3c: dw: Add property to select IBI ops
  i3c: dw: Select ibi ops for base platform driver

 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 4 ++++
 drivers/i3c/master/dw-i3c-master.c                            | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.45.2.741.gdbec12cfda-goog


