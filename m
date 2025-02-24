Return-Path: <linux-kernel+bounces-528288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD7A415D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ED7188A7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF223F438;
	Mon, 24 Feb 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyEIklq2"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76921A5B81
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380640; cv=none; b=CmprbJRxsuO9VTQ4QPltuagQSdBOJ7GMpCTVNviBh7UnLLTCH4IKMXpFWBYkRhFZs9ulluCqXgowrlplgVFlEbC5EovWk2w9Q1KhnclmPDnE78i4STOi7jTT+0bdiyOXnXGyW2aVgKePy+9L1+yxo4MwrmWIp1yk3sR/Q7ZO/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380640; c=relaxed/simple;
	bh=RPkr2Yle/AQxgRyUW8B77AJqlobQFEDPL71xwQL/gG4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NFqHxTbqKud/Gj5M3Y07JrxBpvMLlhjnnmf1u6edWHavRDubmqc6XMoHOciveGoCca70FQlUX5xe8c0AuQccwa0tmu2OdhfYtE8h/viRWoToeO2XsLlHhH4zR46YHg3WO4iNvyNRf3tDjcbp6T2J8VwuUZqvi3/7teOn/pJA6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SyEIklq2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so404718385a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740380638; x=1740985438; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHRUOB722SP2pT9GOeb3cvEiqmLTG17HzDuBznymqOc=;
        b=SyEIklq2FmUI7LQzbzRtYZcbCHQO0ZXYX1kPQbZxOoejwxVIBSWwRT8UtJjDqsDSRd
         U4pTzLyIILWahG7P2cZa1RlQ/9Y5tx4klo8opq89SU/1Aw+VZwKdf2DI4vYzlhqpwmgY
         7w+B2ujxMhEIXu6ByiraLTS62V6eYuP9SyV9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380638; x=1740985438;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHRUOB722SP2pT9GOeb3cvEiqmLTG17HzDuBznymqOc=;
        b=ayxk94U8zazl6Eb1PiUdIrAsHddhUnKhkfF6Lao4GUQhcU8QJ+aHzQrUbEa+8sbvBe
         iIKyU+UG/xfTyBgoIFYg2HLTQ/jEd3qgEwp2H1x2silXNJmKXdDWGtLDtxuZAB1RPHkc
         uHJ3bjsKgVCEy7bt8RZoPulMqwVm3qGXxCxioXhyAme/zC8bochMs/cczKE/O6d3gGN3
         ITqeP+K7mx46AC1DHNjjIYm+edlv6Fv5t7YjZTSgiS5NrAp/iKwMfhyOqGO7n6WDVP9M
         owIAjXaK52K5mtiCCQnyTo28dh57Hn1v4yARQ9pZwYtr9bvM1tC9lLZqbPU+W3w9wHBk
         Fi9w==
X-Forwarded-Encrypted: i=1; AJvYcCXwAfkQLOa/0r8p3gjxURLMawRO6X/FZOG7O1tTZ/3fUCqecTmZ4H8A66SFgX4RiLYC+BBUUUjpNlWmCmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTnwBf8y9JQ5gznVWq2U9Rj4l7VJdmre4ckUY4ydhKnstH9uM
	d0NxT7dyyhL36m/lSXiUiiHVBtoxySHhoBkKsxLfy1p0POhDewX6X3NQqVevbQ==
X-Gm-Gg: ASbGncugeJNy6Gs06lWs8tvoHMpbVqcnf7OGE5kA5PhV3E+1679oA2KuMl+z4Pc4tPO
	gb3wfpGae06dKh6d+PsdslhGWr0JJmp3Ul1fxI+CsKP9rAWT7+zci+31Db71cKamaTgULZlo54x
	OJNLCq4iyLW0Qx4KwLWwviR/zKJoPCv5MZqorFFDbFIHalTpYXuxK0EmPZ8GuD7VCipWzGvWhaG
	eMPHvBKpkEIT15Hqyl12jGWzEn3zodBo5eoyjCCmyR6f4jGvhmL3hLg7gWT5MYcTA4Wjud9kS/B
	qTAXiX67a/BVc368ttXKLcGm2urQ3X00hnCalI3ULY8NGQ19LUKxjxsgXSP0CXzys7oRVspoSR4
	f/ek=
X-Google-Smtp-Source: AGHT+IFkIZyKy46tv3pPOrC7t02hlkGCHtN8wPMQx/td4toBFnJF7+sLcSy9HQrjuNm68CaBgRk5CA==
X-Received: by 2002:a05:620a:450c:b0:7c0:abe0:ce64 with SMTP id af79cd13be357-7c0cf8aec7emr1654304985a.9.1740380637686;
        Sun, 23 Feb 2025 23:03:57 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm977920485a.47.2025.02.23.23.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:03:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: nuvoton: Fix some reference handling issues
Date: Mon, 24 Feb 2025 07:03:53 +0000
Message-Id: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkZvGcC/2XMyw7CIBCF4VdpZi0GiLe48j1MF1yGMosyBlqia
 Xh3sVuX/8nJt0HBTFjgPmyQsVIhTj30YQAXTZpQkO8NWuqzVFqJtFZeOImAt6t0FkOwF+jvV8Z
 A7116jr0jlYXzZ4er+q3/RlVCCoXmFKTz1hv9cDHzTOt85DzB2Fr7AoP7C4ehAAAA
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

When trying out 6.13 cocci, some bugs were found.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Squash fixes and port to cleanup.h.
- Link to v1: https://lore.kernel.org/r/20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org

---
Ricardo Ribalda (2):
      media: nuvoton: Fix reference handling of ece_node
      media: nuvoton: Fix reference handling of ece_pdev

 drivers/media/platform/nuvoton/npcm-video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: c2b96a6818159fba8a3bcc38262da9e77f9b3ec7
change-id: 20250121-nuvoton-fe870cbeffb6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


