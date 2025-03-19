Return-Path: <linux-kernel+bounces-568816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8378A69AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4AA3BB850
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E100211A1E;
	Wed, 19 Mar 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="Eow5AJOP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1744A1D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419113; cv=none; b=mru4di0hWiTSt/m6QS6WTN5b0vMys56pxHrcF4lYC8P6LAReKf/T5fjwjDLqoW1eV8ym3W8M6/BechwS4vMioEL/JVowV6G56RiAySBLifosi+UTHBffmfk7KbAd4yAaC1QQVTw9MQO1ZOYkKfYcC/7tUi5Zz7PyRqQNfqY6tXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419113; c=relaxed/simple;
	bh=rEGsX1ZL7wxRIM5cdnEr5L4KQRNNecaXri8d4lShATk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZH5jOzMZg9++6GhvNFhJ6NAQbpBuxlqmgigl/XNXYkJ+Hd9ASY89Gdw40NKaDPvKlJT+FFV/rNVW2CnPKkAb8zuVceWi3L6JSby3O5ksePpHevYGlp26SmXs21qQNK88GRoA35uOptOiATTFHUXXvitQ5iCyoDPLRKa4r6isYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=Eow5AJOP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2241053582dso551815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742419110; x=1743023910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cD3gOFG7Y44R7WPaqCPkYl7FsfAV4wAGj9YVcra0uh0=;
        b=Eow5AJOP8hnN3h4WkJglMPCH7WudoLzUH8W2kB1Eqzrz7gHXAVDprC+GkWIAApFV5X
         hd9QVhueZ9whgvPOZM1ykZAAcSvef21LIMRsKoBxGDKI4MmpguYeaam9oMFeS/t7qBS5
         PIqCSoeYfu7xuddQW06K1CMyz82e24Uezlmix4V0ZfIcZfSZZqRBjtReqh7dyZERZ4bS
         TlhS4cavvUZJ23LnNNWMxacdOPhjMoOTRHxS8pC6tWpZ1vOQxQpekIRKUkJK6nvH86nv
         FVaDembVE/WUAS+EYd7hcpmWLoaikR2xy4ZZYsmC1HUaC4knSmJtQGepf2XxUs55i1O3
         xktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419110; x=1743023910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD3gOFG7Y44R7WPaqCPkYl7FsfAV4wAGj9YVcra0uh0=;
        b=ZtM89ordMWV+9cIvYNghuA/P1M2z57cw+zyzSRuElXpCRbOFLgZORUJWdxN6BZVkmC
         FjV2V6v6sTGEvtRjugrw4K9mQtE0pmfIYwdDS+NjCR83bY41JLPm57sLIhgeBOKsKgql
         EymgPQmVxUDph8M50hpB8EA6tzlpRUfbHnCqri/7mlxowvbLgsmLO4YuNtfbyxan+7cv
         DrlgpGEDa12WyV96kaP8F+lFF1BRsWDEP/cr+FFLiQweBLnExG7s+H92xfn3TBKZY7M1
         DBVbDfSNcxK9x0Pdg28nWPeJsCfwNiYvZ7+SuPijQgenjGNOJt67An5qLh6GwXyfjpI/
         oSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpdnYBq7k3PM5WGOw/goSBdFfHzFFw+BYNjCcpCj4oN/7pz+x5qV+JRt3Ie9RQh4Bfy/Q7hJDm79hIewI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/r+835aKT+gpcTlG1NflXsP2bLoMQ6MNjR8VdWlqmwZDb+LtP
	0xzecDWR2m6p9IW5TePWkd/SsjskCJRBXdtt1lMx7vWYkPe2x4y+e66hNTekb72ripmIRkkqGjQ
	=
X-Gm-Gg: ASbGncs+ePhAP04KYkqO78ImgctqzOQ57PCLG1YejuGn5cRT/vxg380iT8HU3xc+36M
	NcJHFrEirbv5Q6W+caziXNta/nHxppe6M4MQ/mPZIpuR+o5evrjYvPJdkeWCdzX4Q+EYHHzVcvk
	jI6pU4yisqm6G1mdkjnNxU1EwoVl+U311KpxSnUXY2w5O0zO7F54nSVtCgGia/DvGjHq/FMqG6R
	6w7ZdpP+YpR1kb36SoR0XQRiYPbtPSxxP/Wt3OoeCLnJ9aj1q5tqprOatcEyZU6APtrybkDrwMr
	+Or8nyjJ8x2HL7KLPXFtp8Kt0suzK+P/q0ssupVlAoyJkKms52F3nFaZ3Zd5Wn7V5HbxCuIfjPw
	3UuclY4DDMQ==
X-Google-Smtp-Source: AGHT+IFkg4hzypHJQaU7F3QeKg9ZJvAq0sy5ZjBTlPcQfXuwvWG4p+9v0kVC6v4mQJM5FPCf1KuMRg==
X-Received: by 2002:a05:6a20:9c89:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-1fbecd48b02mr8691848637.34.1742419110314;
        Wed, 19 Mar 2025 14:18:30 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm11460782a12.29.2025.03.19.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:18:30 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 0/2] Correct CamelCase drivers/staging/gpib
Date: Wed, 19 Mar 2025 21:18:25 +0000
Message-ID: <20250319211827.9854-1-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

staging: gpib: Correct CamelCase and remove duplicate entries for bus control
lines.

Adhere to Linux kernel coding style.

Reported by checkpatch

CHECK: Avoid CamelCase

* Patch 1: "staging: gpib: Correct CamelCase for BUS constants"
  * Removes duplicate entries and corrcts Bus with BUS

* Patch 2: "staging: gpib: Correct CamelCase for VALID enums"
  * Replaces Valid with VALID

[PATCH v1 01/02] staging: gpib: Correct CamelCase for BUS constants
[PATCH v1 02/02] staging: gpib: Correct CamelCase for VALID enums

Michael Rubin (2):
 .../gpib/agilent_82357a/agilent_82357a.c      | 18 ++++++------
 drivers/staging/gpib/cb7210/cb7210.c          | 18 ++++++------
 drivers/staging/gpib/common/iblib.c           |  8 ++---
 drivers/staging/gpib/eastwood/fluke_gpib.c    | 18 ++++++------
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 18 ++++++------
 drivers/staging/gpib/gpio/gpib_bitbang.c      | 18 ++++++------
 drivers/staging/gpib/hp_82341/hp_82341.c      |  2 +-
 drivers/staging/gpib/ines/ines_gpib.c         | 18 ++++++------
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 18 ++++++------
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     | 18 ++++++------
 drivers/staging/gpib/tms9914/tms9914.c        | 18 ++++++------
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 18 ++++++------
 drivers/staging/gpib/uapi/gpib_user.h         | 29 ++++++-------------
 13 files changed, 104 insertions(+), 115 deletions(-)

-- 
2.43.0


