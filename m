Return-Path: <linux-kernel+bounces-570796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C517AA6B49A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A403B933B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8EF1EBA0D;
	Fri, 21 Mar 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UfLd++u3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A91E7C28
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539740; cv=none; b=kJqlE8aUK0AQjLuD/1DqZ3VDZ2Z3xtvciZME/rFJRI0oyNATT0Pc0atYDVbgw2sKx6t+TkJj2LE/tI2uYXZEQxwJtXkNCE1OxVY1NR/m6tbgT09uXUp4vUc4VIkvRVo3UTmgkCkWr46v4ZsqoxmxJWE16uB/SUoomY1CWx/u6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539740; c=relaxed/simple;
	bh=6ooNQLxhxbt4lgKABXvAXiZ/H/pTs90ea2703VP/jEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RZxSr7iIGh6J8ssUk5IL9Cy7FkDJewk1SBD+ej7p4V7S0DliHrFWb2MfnzwaFmqkYl6Ru/YVOKCGs/VbOJHcT1ho4Ji0fWZvmYQwvcedEy5oRkh9hunb4AB/JIgFSECj+Ndaun8/OB79dELMbdCXDFMK7T3Ml+Jw+pvO4UdzEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UfLd++u3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22438c356c8so31067155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539735; x=1743144535; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvaePu+Lf34WSmuwJtyngfui9U5LFP1ldzJala5s8u4=;
        b=UfLd++u3KFCW1OG0LMVFa1+OocMHSHLcwT+RzjnhoYVhhpkYycmisFsJwTxZ3yfdbe
         sDxZqJAXlddyW/5LgoY3ByY4G+x01pdce0wfl3OCNR3lFOC0HzJMEPi4SsAQUV9EkKzR
         Sa5ERn8CVdE1IkbfgvaOWyoAQL00AozNbZ6gdlB3T8wNFb9NHKGDrogxw3Dn15Iswdeh
         ci2TIGAzZDjx0y5hMC89DE0s6eIYOfMPwxHTxpmr3UpH8gQ2m5A7CI89Q48bmoRb2kUF
         afaQ3nT80reOM5DTL6h+mZPCo0XxtGI14x8X1lnTbnTjGGgwMabWwq0H+fFAv7CiOE4X
         gxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539735; x=1743144535;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvaePu+Lf34WSmuwJtyngfui9U5LFP1ldzJala5s8u4=;
        b=QGQFKq2mfXqo2xD5AdayRe1I1vTxMeCYSq0dlbAiITgPzo+tOUXiG0m1cpS8Yf8rJC
         mTnPdSq1J/Zd5N9oQ7kmW5gM/jIEfC/mT4yCr71SHF/qeQZH2pdv7r64Tr4vRdbnoJeF
         jgOb3DWVVhiVEzZjXWCagKIKGWpq4PVWsvkRnUIcqCrprs87417FEGk11TFIW8P5RUFr
         RXPeLL/q8eQyriRyoIHO4E4etP8avA6kxZIumBXJYGx5zCkuYMvmouFqZnLoMKumzn4S
         oQPn3wTYhDsBtcci62of+8201eIfBYYzy0Y8VEBrJFij2rZK/y7+d0LGtpXoYOUGDUI+
         glQw==
X-Forwarded-Encrypted: i=1; AJvYcCUQiq9WUNWBO6oHk/fDTyEpzUWoHfcI7wPTqPj3NVuD+4tV0SUxxhhTDnsyZHOI8oGYZAIfP6z7l7NFApU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtwlAOK5I0yO/xbSuhDoi6ErJZYw2diZ3XXFDjohd2DD4a9dP
	gwOPQXgPKw+L8nQhhExOldIPhVtuA9NhVVdwzz/DWFR1pi/s6FA7aazWLoUlYq4=
X-Gm-Gg: ASbGncv1djA/hY/3WIjS/nI5d1pPkMrsgY+dKTDMQpC0V1vnKZbRgbdo2z3w1Zex9kc
	xlp4FtdgPPe+b+Y7zd3F7TEvTEghCSeKBGevTrnxJ1OHh5MqFNlDKCvY67Wt6GA89IvkxYCNiAZ
	15FISubED/aUVfLUfWGHXoVIzL6mFcktHm/A2sLtkHL9mBbeJrqlyZnnBU8KxEamCX33uG+h8av
	zs+Fj/EDiQ23FesbPlArRWf5OMpIo5J2NueJrBYfmxx+n9UtOmBl2teNgwkgPyyeqNgCAsz/WJI
	wjnlS053pOUZncFsxIcphJe3GiHpl5FwHoelrb5q2qLV6L3S
X-Google-Smtp-Source: AGHT+IEyVWiZuBU3HVprj4u07XVS4jJc8dBw9lWctyOdahYf8tAomFSkVNJplBNroBXKEAuEtsPI3A==
X-Received: by 2002:a05:6a00:2e90:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-7390599eb4emr3733783b3a.12.1742539735464;
        Thu, 20 Mar 2025 23:48:55 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905faa5d3sm1087092b3a.15.2025.03.20.23.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:48:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Date: Fri, 21 Mar 2025 15:48:31 +0900
Message-Id: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8L3WcC/12NOw6DMBAFr4K2jiN/wIFUuUdEQdglbBE7si0Lh
 Hz3WJQpR/M074BIgSnCvTkgUObI3lXQlwbmdXJvEoyVQUvdSaN6kTkk9sJ23YB2UP0NX1DH30A
 Lb2foCY6ScLQlGKtZOSYf9vMhq9P/x7ISUpi2nafFGIuID5x2x9t19h8YSyk/X5p7iacAAAA=
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

Jason Wang recently proposed an improvement to struct
virtio_net_rss_config:
https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com

This patch series implements it and also fixes a few minor bugs I found
when writing patches.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Replaced kmalloc() with kzalloc() to initialize the reserved fields.
- Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com

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


