Return-Path: <linux-kernel+bounces-337943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E00985149
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2791F25099
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824714B077;
	Wed, 25 Sep 2024 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTw7Dm4E"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130DC149C4B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233910; cv=none; b=I/3zZHlpqNRDdOv7NjJVX/KxR1hZIJLfiS2tVSUNdiwiPsKirhRQR0MC6Ev4/ubLizSgQOJgHMfTahut3OjfN2bHzkFixIzVjF3v3hP9A4uKg22ZTsUtY+8H9HvjgXV3urlvI7+ZGPTJKXRRnwfyAKBKy/nc3yPk96haj+ayzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233910; c=relaxed/simple;
	bh=6SXjbPDMBLQ17ZCQedCMJcAnEDtHfWhO7mlHfWa3HHk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jfScQk0ddkjqI7jGYmA/DkbGtsjlNwNJPcxHgj/PujQRTf72c36ATK6juM4Vfz0KtWEoctHo7AyVcXZ+X/EtgCsotA6XtHyyCndgR12+MgLi3sAW3F0NJFSxaUTiyvUfaTBS38k3xezmuQLv19B5YXEprMGAj1A0900Mzgi6Bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTw7Dm4E; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d683cfa528so81218247b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727233908; x=1727838708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CIaqBU+1cIYAdl+HeMBYFH6c8IExKzNkfoZSlBkERsY=;
        b=vTw7Dm4EpPMoWMIqAGVNfiTBCtTKvUrk/oex/+vxJJ+YH7sT3W04OwRrv+1UR1kNQe
         4F9fOuV1T221rNfun8G1NFzz6P6kDn451UMk4/KwvaHodxnc7VDcWQ4VIozCkBBrPTv6
         eq9rMEL09kRxAS/nIqBh1G/8liZL5kc5cygF1p0Fwuy3Pl2sGlBt3lEMdkYD5nCII6vN
         TYVvbwOq6KMyxpRiHm65Y4ysPue+bef73jl0MZsF1ruRdole/d6kYclv6k8DdadoeRXi
         DuI1uDXNn/rfaN0U/hI6++axQRarUfEq3465pHKsO8ZaO0Y8p8czff/TwX8DsgaCH89E
         IzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727233908; x=1727838708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIaqBU+1cIYAdl+HeMBYFH6c8IExKzNkfoZSlBkERsY=;
        b=X1sAViECyg67VVgOwtwlo+xti0TB7oRMLMs8+gsv9g24sHsI1wQc6bScqbeKZ6w1QH
         76hMmkul+fstu/ZPGoMK+Gmqn9s3TLXasn1yGMX9ZMrmhx6WWS92BPXdjy0PoJjMo5ZH
         XQ0Yxty8mW54/8uB0riNtFSq2J1I2cZpr9Ar0hnIv/ISQWu/3WbSFhhri+yr4fN46IAf
         YNTO1jFP/yJGiveykiITVZgCayORzsDTr3U0m+FSE+5TD2aPby7W7b2qGMjR9KDQsKLJ
         9hbNTC9cNElnsH7xSrc5ERQKLKeROwiAHiLi0i0AxvGB7f81PX/DhRK/8blLDX4n9X4e
         sedA==
X-Forwarded-Encrypted: i=1; AJvYcCWXE3MiaZVW2UkG2X6BcU0U7wOI5hbbZY/O6N5GcyBUZVExFhsAPbumeHzUVFcongwnB/JvDtmrNtUOcW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+RPsiDSTkToPJp6UzSEQHoXuPM4ijJQaepIzItxF9cta0YSU
	8D+NG0/QsnRmXncQBBOXMw8rUZCOhb8RDYWjHIbeLZ6Fufhmg5EAq5AHmcKQephfcqb4IMyBV4g
	PSA==
X-Google-Smtp-Source: AGHT+IHl/uVndGMvWDuN0UxdXNtntla8OyBDRyA3z77BNJF9H//leo71EAwHv0ZZX+CgaxioWuNDifvd+uY=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:4342:b0:6e2:1713:bdb5 with SMTP id
 00721157ae682-6e21da7974amr39657b3.5.1727233907980; Tue, 24 Sep 2024 20:11:47
 -0700 (PDT)
Date: Tue, 24 Sep 2024 20:11:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925031135.1101048-1-amitsd@google.com>
Subject: [RFC v4 0/2]  Add support for time DT property in TCPM
From: Amit Sunil Dhamne <amitsd@google.com>
To: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org, 
	heikki.krogerus@linux.intel.com
Cc: badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

USB PD specification defines a bunch of timers that can have a range of
acceptable values instead of specific values. These values have to be
tuned based on the platform. However, TCPM currently sets them to a
default value without providing a mechanism to set platform specific
values.

This patchset adds new DT properties per timer to allow users to define
platform specific values.

Changes compared to v3:
  - nit: removed an extra newline that got added in tcpm_register_port()

Changes compared to v2:
  - Added min, max & default values to DT property in Documentation.
  - Changed return type of tcpm_fw_get_timings to void instead of int.

Changes compared to v1:
  - Defined new properties per timer that we are interested in rather
    than defining a single pd-timers u32 array property.
  - Better description of the timer properties.
  - Since subject has changed, adding link for previous patchset for
    posterity:
    https://lore.kernel.org/all/20240911000715.554184-1-amitsd@google.com/

Amit Sunil Dhamne (2):
  dt-bindings: connector: Add properties to define time values
  usb: typec: tcpm: Add support for parsing time dt properties

 .../bindings/connector/usb-connector.yaml     | 35 ++++++++-
 drivers/usb/typec/tcpm/tcpm.c                 | 73 +++++++++++++++----
 2 files changed, 91 insertions(+), 17 deletions(-)


base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
-- 
2.46.0.792.g87dc391469-goog


