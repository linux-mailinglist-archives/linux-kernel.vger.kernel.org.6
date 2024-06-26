Return-Path: <linux-kernel+bounces-230882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905C918349
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38103289314
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C7186292;
	Wed, 26 Jun 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dBiV9eWC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDA185E70
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409650; cv=none; b=HTnADng9WrrVRIzqz/D4/GpI4+2yvbArIn1uI6UGcOH9v13heqTTmN0Cr1fVetKLvrsLf5bRtHjzkRuQNVMyAsk8v14AGyh7sdoXAUckaxjNU3ohlAaWSmYMMA0nBH7Bup46DBgPEZ+pF3biVyiwW2Chtg1l0SD0mp9cHZw0WmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409650; c=relaxed/simple;
	bh=/jEClEHDxEl+djPgKLOGRJWMVDG+RYF17xauYwyh5qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vb8Wp2tRHD9NWi0zqqxhaPRWKxk0hRtoeagJ3JL4Atz+fn4PH2KReuorvmjRzAr5eXPsIjWisslPyccoOH5FclC3a8JNNjtJfOtqY0dPsROmlL1U/ldLL3ChII8/x1IHKoMga2SKYjK6bp6Gy4rzN+3+0G8RHVvixbSjOCBSbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dBiV9eWC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso3188615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1719409647; x=1720014447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHiBgnfP/0rnnPCnPMDBOWshAUvOWKD1FEoaKWD/1kE=;
        b=dBiV9eWCrfWN0NfagsXskNqpQO1bN72mc/aYMIsNuWgCM7smDauPkOv9mc/aJEMLiS
         60PRKToVI+B6PBYuk/wjbSQ0DmvWcGAyhtOFFiqLjkpBRcxDnj6jTECqyAA355Ox7AaN
         dGbVgNcd577qoSkz7uMK4ScAcmM5KOkVlMNii/2OVqVgJ7idoAiMLX+7yE/oUA6d2jeR
         SLRALhL5UnYSsU/UcaC1vH45/avc3Njnorpz/7tIeCCr1PolRYDQqzUYOOOe66xYVXYF
         jcJI9isTTKtn3zv3RBv0rvrH4OY8FvSLcz9VL9gCzNNJlvYKJeD8W5tXljXzZDDrHbPc
         9bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409647; x=1720014447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHiBgnfP/0rnnPCnPMDBOWshAUvOWKD1FEoaKWD/1kE=;
        b=XGclD/S1aiyQdCBEg3aVbMt0L0IRRH2Fv8LYwPAuw/hJ7pDJPtTOKgDeJF6ishxlJ2
         D6me2JGIXQ/q9xMn+/ZAx7oPteKqhJnkQTdGA6t3ObGBDGhxU0ajQO+jczNs3OEJoWYa
         uiTwGT3914Jsqd84XXm0RbVonn80gdSDS8iY0VO+/Z1eZ88O66XYGGHLojiLlHZj6B47
         cpTTDqdOEor4WY3AfAsbw4TwWEeHE++0+t14RRtcB+QWX1ilwDmT7+76MsJs33tu5KVT
         yUaIWCtwY6YiPtXQ7UgtKkR2uuXfzGxltiWCu3uE40LJwSDuagMtXwQgGg3oMSQl6xf4
         XyqA==
X-Gm-Message-State: AOJu0Yz7As3qHxFXE4u5kEtb27m0A7dJDTIch/oP/TSJchGJzr/kBz45
	wBDmypiKrMVY4xscNSlfAYzFs3d+XXbmgXVC8UYnDsWk4ovsjYTBzNYakuvinJUroy8tj+2iwol
	O
X-Google-Smtp-Source: AGHT+IEmS2OWbS79dMTwL4fhRrin/KFAoeZqHlZtaieH7je5p3m5/smsvb2C9xkGG3a3QPu3VxqGvA==
X-Received: by 2002:a05:600c:3503:b0:422:218e:b8d7 with SMTP id 5b1f17b1804b1-4248cc66a78mr89547365e9.38.1719409646730;
        Wed, 26 Jun 2024 06:47:26 -0700 (PDT)
Received: from T14s.n1ce.space ([185.254.75.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8475aacsm26611625e9.47.2024.06.26.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:47:26 -0700 (PDT)
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>,
	Matthias Stoeckl <matthias.stoeckl@secunet.com>,
	Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Subject: [PATCH v1 0/1] usb: gadget: dummy_hcd: Fix regression due to hrtimer migration
Date: Wed, 26 Jun 2024 15:47:19 +0200
Message-ID: <cover.1719405791.git.marcello.bauer@9elements.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel CI bots such as syzbot and intel kernel bot reported a
regression due to the migration of the transfare scheduler from timer
list to hrtimer. The current assumption is that this is because timer
list uses soft interrupt context. I have not been able to reproduce the
regression consistently. So I'm submitting this patch in the hope that
it solves the issue.

Do not apply the patch if any bot still reports the problem.

Marcello Sylvester Bauer (1):
  usb: gadget: dummy_hcd: make hrtimer expire in soft irq context

 drivers/usb/gadget/udc/dummy_hcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.45.2


