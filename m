Return-Path: <linux-kernel+bounces-552896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACEA5809B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C890D16AFE0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066313EFE3;
	Sun,  9 Mar 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebt6D/eF"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C94347B4;
	Sun,  9 Mar 2025 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741497234; cv=none; b=rAYlKpBQJnIsSqI676E8PiB6JtvbfgYdMMZ7A8ZdtW0usRJTXpeP2wbjzWaywyzNlkHqchoxIQXLvO2LbkFfDjp1AuLqfARuig/rTYHgNgWKU5N2nJ3mCAGvuQ3aaMvuzmQJiNdW3ouwhFxEIIeLN9eaug75RYooEOfWrAQ5ULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741497234; c=relaxed/simple;
	bh=P+vZtA3HhV5tsZzaez4Fwli02DW+nObRXpoeW+8tkBM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LCtOtfEPKwzEgQnMVadXWS05mBIeOUU4EZpqR+Nmc5XGVb/mS1690bplOJ3H4tTnLRBtidge1siYRPkGPNc49P4totpsxno3fzUsOm4jW4bnJfIS8+sUnZUOVwq1GITMnFkDizq7dkzhhh+GjCNc+H7XjEGsu1HLs0k5Ke4P6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebt6D/eF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f47ed1f40dso24222127b3.1;
        Sat, 08 Mar 2025 21:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741497231; x=1742102031; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CK1cxf14FFn9JPBzBDVf0xP/aDOa6U25KDBn97pLSso=;
        b=Ebt6D/eF2PhmAF+/jntqnEdPf81Qx0rwatDjnH/qGWHOnHy/fKHIoxv5kWw48ffCdu
         25u7o7ytiua/EDeTr7yqRLl0eu80059Ve7wK6z8galBnsLyR5M7EZhynHKa+/9u7kSU/
         3MbIOXNoARuhOjuThgbhmsyRSZuHceBtHaqkgmCtLlIjLi4kvUCt6bGUkYpgafb9YpfL
         6KkJm1UiX1c0p/B7yvl0xr484q9DNMG2ecSv23tP6mxQy1hGwUQXCo5Rpf+GONhotA1V
         pKMsLw+6lfXftc2Hu59QRie+hGFCA0SzLuTaNWZQu4akgs5Q5kHl4xro6m7bufO1O6UC
         YjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741497231; x=1742102031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CK1cxf14FFn9JPBzBDVf0xP/aDOa6U25KDBn97pLSso=;
        b=C3bYZSRnKQ/jkd6hQ1cO84k6tUQQr06Kw6y9N3HOyOrZdoqAndF9e1C21FRmwP7xEw
         OjXE+APxWyCIdK4vaL5ZbDL0c+q4zYaoO1UvWcsHwVWxIOWQtmCk5U2ZmIZ6VZ4VarQx
         BP67u5Wejm85VAbCcr5AkcuQUni4VabD4qunHbz0wdidum6Yo7Pntm+LtmE++5SQbH0f
         wR5DHaR9HVqewYQ95QZ/y29E9Dzh10Dp+Nk3MsPqyexUN+rOI4eILvDsBfb8ef33aVmO
         fN6uO5RythXIuo+ffDOBGvbyH+eTjWXY8f/UI7Hj81QdUpusmSpMBM6ipi3rpjNbrvSm
         Kkmg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQlh9djUxyiTVV4AoIWvbAgV6hwv+hhl3lemUKntippX94rh0xNCleTEvc25+RIPpD/xEjAf2YCTvyAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOB98NorTsBU4zXZnSpbHBX+TWbOyM3+SPhG87diLMNJFQRkNq
	doUKW/lXIZCa1Fha0PitPRaPVwGoQVsZ3QizajLOboqCPHYP+Rrs
X-Gm-Gg: ASbGncvvcCA2QR1wLxFtZEmQ6N+MFUWi8XvKtz2lKuHNubSEGlA0gP322fTffUGZc9J
	8OTjTMU11Wb9GIC0lLWOMLskBLM7nLpdnWyu0JMtAB0RInphTM3ANwawTzmf/0y7qYyrPul3Wcg
	EAQX+cRb2mOPKaYkhleHfL7oiyLV4zZwUvxeit5AB0Q8rQcazHpCKCyBJys1cFQFyli63zeqpzA
	mm4VyJt56mzLjQ6b4twe3PX7Au9cxnVl4vib4GR4jQxGRCHfqe5o/orUTF7VqLWW0+BaQVGb3h/
	NZs+mkZBw9kvnpJK99B4TBGWNKGHv1/JB3R4OH47RCtSGQ==
X-Google-Smtp-Source: AGHT+IFchlBvxUpvbNSRW7QGcdcS/9kltouLO1RXp76mD1YDjdyaSWUTZtC+t7/W80lWexuKkq9lTg==
X-Received: by 2002:a05:690c:7207:b0:6f6:d405:7010 with SMTP id 00721157ae682-6febf39bb73mr126654507b3.29.1741497231247;
        Sat, 08 Mar 2025 21:13:51 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a1bfc5sm15232747b3.24.2025.03.08.21.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:13:50 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH RFC v2 0/2] platform/x86: alienware-wmi-wmax: Extend
 support to many devices
Date: Sun, 09 Mar 2025 00:13:39 -0500
Message-Id: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMjzWcC/2WPy07DMBBFfyXyGqOJE7+yQkLiA9iiLvwYNyM1D
 dhpCqry75gUsWF5Z0bnzL2xgpmwsKG5sYwrFZrPNYiHhoXRnY/IKdbMBAgJHRjuriHwC0WuMID
 yXkgtIqvn7xkTfe6oN/b68swO92HGj0vFLr+bP2qV3JmSj9eJJ+2jbS0IL/Ww9j9E7wryME8TL
 UODUqPzKJKHvrcSUKUUE0JroDM1912sD3m9a0cqy5y/9lZru3v/F1hbDlx1CowV0Xgrn46To9N
 jNbLDtm3fbRky7BwBAAA=
X-Change-ID: 20250308-awcc-uid-6ec06bb2572d
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Hi all,

After a few months of searching for acpidumps of elegible laptops, I
came to the conclusion that if I continue this way, many devices will
never get support for this interface. This is due to very few users
uploading acpidumps of their machines or contacting me of that matter.

With this patchset, hopefully all (or almost all) elegible devices will
get support.

I'm submitting this as an RFC because I'm extending the WMI API and also
extending support to many unknown laptops models.

This depends on

	platform/x86: alienware-wmi-wmax: HWMON support + DebugFS + Improvements 

series, because I made a few generalizations there that work even for
Alienware desktops.

I sent a v2 right away because I made some silly mistakes. Sorry for the
noise.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v2:

[1/2]
  - Add kernel-doc to wmidev_get_acpi_device_uid()

[2/2]
  - Reworked logic a bit to include a check for !uid before calling
    strncmp()

Link to v1: https://lore.kernel.org/r/20250308-awcc-uid-v1-0-6360892d8b95@gmail.com

---
Kurt Borja (2):
      platform/x86: wmi: Add wmidev_get_acpi_device_uid()
      platform/x86: alienware-wmi-wmax: Check for AWCC support using _UID

 drivers/platform/x86/dell/alienware-wmi-wmax.c | 15 +++++++++------
 drivers/platform/x86/wmi.c                     | 20 +++++++++++++++++---
 include/linux/wmi.h                            |  2 ++
 3 files changed, 28 insertions(+), 9 deletions(-)
---
base-commit: e57eabe2fb044950e6ffdfe01803895043dec0b7
change-id: 20250308-awcc-uid-6ec06bb2572d
prerequisite-change-id: 20250305-hwm-f7bd91902b57:v4
prerequisite-patch-id: 06ff44ce0c6f9bce77eb61a08f358240f1485914
prerequisite-patch-id: d270ae9f1f681a6b6b9685cc13802e8baba0105f
prerequisite-patch-id: 5f744ce03af74a23560118b761ac6529a7c9b172
prerequisite-patch-id: 22c6c5256aee2c17bcd710ec1493b1abccd414cf
prerequisite-patch-id: 75191e2094746de3c12fdd885885d18b2239af89
prerequisite-patch-id: 9f26a3b64824b4f175bbea47c8c9a59fd67f3316
prerequisite-patch-id: 4ff2263e236230e1f96703265d135f0b90390ebd
prerequisite-patch-id: b8844283f8bb46c05ba2e9d7b901bdedfd941731
prerequisite-patch-id: c5122bcce8e7330cdbb18c5d43e321ce69116272
prerequisite-patch-id: ed78dcf947e19652f175d124ade13c08eb3950cc
prerequisite-patch-id: d46a626481e1c49bdd91f6add36f4d6b89edde3e
prerequisite-patch-id: e68a77ec73be34006d5dd754592285e44ffc7f68

Best regards,
-- 
 ~ Kurt


