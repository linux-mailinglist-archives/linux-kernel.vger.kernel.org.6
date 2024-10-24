Return-Path: <linux-kernel+bounces-379234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BC79ADBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95281F22450
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80617623C;
	Thu, 24 Oct 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7TnAZac"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE20175D53
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750434; cv=none; b=spX6fmXIUkRgv1Xs/l+JhDxzuZhvBG3IBtERb4HRogBeYQYl4htB8VX92FP8qSqxK0lE40Pv/87nSfQEYtQgpQ0ZNbHXOap5NpzuSn0qX+Q5CvTjjL3UtVgYIop0yvUVOrn5wNNDqY+uLmEpLAdhFZZcoPRrqtoUznn+YD7UqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750434; c=relaxed/simple;
	bh=bx6oz5UN0v60eFR0Ae6VB5459qU8Yv/1xhOqtqjDU/w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=ngTq2zZQowZ2UKP9LatJNbZamU3cLtEiyh7n6azIVsnrwAYX1PlkvoJyBRycC/1+SMy6PFKF8kUMVbozHNWdFFfljif18DifWPmM32cRUXb5pORMyM5MiXOWRHh5UlCVg8qsZ3zgde5txinQtyluK1NTfb/qV3SFZc+lejCn0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7TnAZac; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so11561387b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729750431; x=1730355231; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55/hvgYNWdvBpZX8vS6a0ZNEj9vu+ZIZIEdADHyK4mM=;
        b=v7TnAZac8G5rPsf1wpI6ch3JtkuWyEDFEudT09tUlL0icZ2WUign1gwnW3zxZpqqew
         PR/gqI9WRp/Z2korFEv3zSeV4w1apQHuF1pKyFA81IADHm6i3FFumjYQwn2u9LwXYunz
         ph6fIVJjkrkLjbp9n2MbZcxgfe9Lr0sUjNq4QnAVPMaglGiLhdz3s95P0TvfaMtIYWHB
         p7lytQVoESBoc2FBfYWCGPfI5JkvhP7iNsTSOzUWiNRh9O0x8uY5PtJ+MWKoCkMLr8N0
         /MhbJUHCvQMCJUuXl372wgwJukYufD8NFE17371wjPHkUSihOlfhYHR5yNHWPwViCmM+
         BCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750431; x=1730355231;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55/hvgYNWdvBpZX8vS6a0ZNEj9vu+ZIZIEdADHyK4mM=;
        b=p3gQ/RxL1zoGmjWgR9+jHmJJ7iH6VppOuk3OJ8709eRCz+euRgk435TosBl2LGBEDh
         uE/uDH+9qkysZ3FyeloipfX+o5ZMbq66yHu2KVgD6q5n4PRu6gDocgMaMT+SbE8iNTTQ
         MrO899oGdXqhM+ZlH3n7jsJN97fLN4stK8Q5pShWRwlNNJdj4OGrrPYYBb6ukdS3WVzP
         a0sYKTz5UuQWGQ9maTDSS5XYXzu+HYAl8Nczbhdx9j97pL7NFrKdCYD8JfaWwCVfnLPq
         Edvf9C1PsYjRViIwnNxEGgzni2vb9x37DymB3XlZiyCkjqPPAKPSfZhWuI64wugJCidW
         8P4w==
X-Forwarded-Encrypted: i=1; AJvYcCVnHvCO5O7P0xls5Zg0mKH1CZTGAee4dSPv72xYcBb2IJW6LySiE6NVNpVjGYATb6/ixgyBZChmvzMAwTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4OA1FHSO2tRjclhqF9TwVToxc2bL5eQ8b5jkvAFI2K/gHmGZc
	Ap3+NoFkKeuDxT8AmApxAtwymWTkKBtD+8R7FFyYUJfyt9vBzt3LyBhvnxlGC8zbT61AN12tQ/n
	0wPOTBFXXWbOCuA==
X-Google-Smtp-Source: AGHT+IEjm5xZ8oWEf7u6//TA4Kt5HjH6iFnxvFJipXmVy8asdr1VaVjmTPVebbvVpJLKuPZgRMsL7ilkx4vd+j0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:965e:f81d:c9fb:b352])
 (user=saravanak job=sendgmr) by 2002:a05:690c:7082:b0:6e7:e493:2db6 with SMTP
 id 00721157ae682-6e86632ee4bmr196737b3.3.1729750431239; Wed, 23 Oct 2024
 23:13:51 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:13:41 -0700
Message-Id: <20241024061347.1771063-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH 0/3] A few minor fw_devlink fixes
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Saravana Kannan <saravanak@google.com>, 
	"=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=" <nfraprado@collabora.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Probably easiest for Greg to pull in these changes?

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Thanks,
Saravana

Saravana Kannan (3):
  drm: display: Set fwnode for aux bus devices
  phy: tegra: xusb: Set fwnode for xusb port devices
  drivers: core: fw_devlink: Make the error message a bit more useful

 drivers/base/core.c                      | 4 ++--
 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 drivers/phy/tegra/xusb.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.47.0.105.g07ac214952-goog


