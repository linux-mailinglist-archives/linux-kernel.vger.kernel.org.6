Return-Path: <linux-kernel+bounces-565880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D620DA67079
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E673A56D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298619F424;
	Tue, 18 Mar 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GRvTAn8K"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0191581EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291821; cv=none; b=K4lqwRybzJmAXH6QvNOxk/+Vd1OycCcy6JOSauZwajUqpIZueDoy+qz96c0YSlsDDd/maTpvKvalyEGWN4EUdbdu3O+8oQ3yNGdM3J26xixKPq9qhGKu5+dC6VksMQ6nLbClDIgv9l+mEb++xRMag7OJPjaGEbuVtcUJI0w4rxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291821; c=relaxed/simple;
	bh=V0LTKhHSeqp8axFnG3MXcESZ5lvqeqj7WVpujBwX9cU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rXJ2xg4AOwTzEifsylZLAcLHYxG/O0BYY8z4GtdW9yPSwoxdEA1GrFP9aE2xribHejA3r2bJuHjJJ2g9dWhVZ55seh0VBcbAPpi9Xev1nvC4OiJc8qLOJA65h/kK3XCXytNdpZSZoYzeHFlJd59bBJcqlZjCX0JGlybuwvZueAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=GRvTAn8K; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso4060732a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291819; x=1742896619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYxrtds9WuAyx/VMy5k9Yihosia715CLjXw9v61XzK8=;
        b=GRvTAn8KeOc7q4OdTGKRW27WZniukgyCMeKESsBha5XUbEplLEoNGSYfdrNe24S29B
         VxRwdVOsnn5peiNoMLmNvEASvy/MqQ7HWIvDQgviKH0ErylQQWDPBLiFJeeKZ/uJWZUo
         iHiEcIv1sLLBy6TaCJAb9YaSvcjC432Oop3VTnWtbv2nQO2bd2xAXoP/eez+YswiV0hD
         gqiYPAYUpWaSHUfiqPoVKxgpyQkIRvm9YgI0V6E5lTgWF4uxE9Zb19Kx/1FRVQ9WXDTn
         hZEJNDofX80LJV9epQstPyhCbZZsDAAhceEskaXupZx+WJYyjD6xAt4UemabSvpRg27o
         TJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291819; x=1742896619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYxrtds9WuAyx/VMy5k9Yihosia715CLjXw9v61XzK8=;
        b=Sv+HirIPNSOCplmOSmt2QJMstQTi/qUz5kA3BVgyypeeJhWL5nAvsY0VYLONFAw0GP
         2SR22YSlSbkB8Wx68H9lZ0vq9SBbTTvgvdbj5uHMqfLLv2PhsuMEzzQ8TjVE5gXre9BS
         RaCAdj5CUglIjVa6dratR7LkadXDBepiisIbhm6wFx1hrJwCa08Y68unv8z789BXhxdB
         9AIDUuAr9hwKreXTSQ2hbz9UFn5nf15phI0JLVKsfecjO3mMyq1JrgtX6k5rWAS4JfGI
         5fD+3r87ST9AzFGSJWimekGsB+njFWAQZK2X00/Ie8cnQeVk/5Kg9zDChYiUi1Xzs9Pj
         8VFA==
X-Forwarded-Encrypted: i=1; AJvYcCXhgBl4Yv9kC6jZS54nCjxlWw/IIgQHXWimLtQ//7FAnyCb4fFehOBqBlctr3AwyMfwKI+t2SV0HwfM//c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8h+v3ZrtN7DqXV8wpLjMcYkzBWHHwHxIOh3yBNF9nju8TvqNx
	25ROxZ9Dz2vjV6fzcuFVPnAZcLtKmDGso81yfth/+zpZzXQ9hbYfNIq9ZBQmFqw=
X-Gm-Gg: ASbGncs0I7ijCaHxvEYByHUyoPcTs8Ph29W9lh5f3uRRoR8YHQYDxoTh4uCKp3thcgU
	YfaQieC7eLeyNUXmD+QpfRtwudcj5Uyc5mAqHgZ73cVzEtClCzOkGP5av5lUVJ3q+pZfrgkflET
	YGrLtrdkVdffD9j3zvuH7b+ZITvWZWFF9PYY/KycxLUj/DeoE98w+y0Sn4+mj5XlKyMoR9PwfQR
	qk0udnbZxU0KDRl+FxLNUr0s5tv/xbExE13Xp85JWHk+a7JJrvos07NDh0t+LQJ/wn4Y9Z8b13n
	OBUX5MppXILEYVXcgJZ8ej/6JOUuodn9mi9srvme4eLeGLwCz/XW2+hlkHA=
X-Google-Smtp-Source: AGHT+IHrk0Ye2VW3IkLXWNA3Y7JUi4Z0k3Yg5or8rzVPS9hPOf7HJ1+PfOM0m9d8tJMNA1KQW6fotA==
X-Received: by 2002:a05:6a21:9185:b0:1f5:70af:a32a with SMTP id adf61e73a8af0-1f5c1386049mr24959333637.32.1742291819121;
        Tue, 18 Mar 2025 02:56:59 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56e9ccb0csm8634097a12.2.2025.03.18.02.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:56:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next 0/4] virtio_net: Fixes and improvements
Date: Tue, 18 Mar 2025 18:56:50 +0900
Message-Id: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJD2WcC/x3MQQqAIBBA0avErBvIQrOuEi0qp5qNhooI0t2Tl
 g8+v0AgzxRgbgp4ShzY2QrRNnDcm70I2VRD3/WyG4TGxD6yQyXlZNQk9Gh2qPHj6eT8jxawFNF
 SjrC+7wfuSPvWYgAAAA==
X-Change-ID: 20250318-virtio-6559d69187db
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Jason Wang recently proposed an improvement to struct
virtio_net_rss_config:
https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com

This patch series implements it and also fixes a few minor bugs I found
when writing patches.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      virtio_net: Split struct virtio_net_rss_config
      virtio_net: Fix endian with virtio_net_ctrl_rss
      virtio_net: Use new RSS config structs
      virtio_net: Allocate rss_hdr with devres

 drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
 include/uapi/linux/virtio_net.h |  13 +++++
 2 files changed, 56 insertions(+), 76 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250318-virtio-6559d69187db

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


