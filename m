Return-Path: <linux-kernel+bounces-413755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FA9D1E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892C7B243D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1213C83D;
	Tue, 19 Nov 2024 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="aND0gznr"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3C77111
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983288; cv=none; b=M89lnU+jBsSCMeLrkfArEyixgZJj2MTZ6vPNcGVd1uB/T+x5mTC/psbOucta4iL+oRVnPl25cNOzeWTUlrIHldwXWXZtFjKPkCy1ZHkc7qDhUQ9mIGKrLxwy6pZWsXtfNV/RnWhxUTYVniuHizIFo0+MdR/uRRq6fIT6eDVvICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983288; c=relaxed/simple;
	bh=KcRvi2yVNqSpAiSseRhYHxCQ/0+wMvC8RvSVpSLK2/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxL0eAW9Eflt2BvWa4yz593CR28qLmI3GZ0b630iozM+xRTkd4Wyw+mq5Pv+Jfgf0z1HGnexUbJjjt/qeEpxn4iVbN9fo+HDm6O+iqsMIjjXN1CzJoIQnuS3vUuonVsb2jXhoirQs6wg3mJS1Zq68Rvz7odIyg6z9lCRQ2iyNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=aND0gznr; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-856ec390e30so1441110241.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1731983285; x=1732588085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcAlilVvCqmcxVYfBzypm0OcUF8kidVLMM3xa7PfgoY=;
        b=aND0gznrOr8b9vQMxE/psHwyvHs69dPPAobIl/070JxxqOZOmarDiWl01ugOv8X/eL
         cEeqNGf9DDE1V7nB7qtxe+JcNO9yGDzsH7IGDdr7/aVRq/g22KWcCyZVd7GWvHpOTCxg
         VfuYK31va7z5mM8xMcHLz4Yy3EIXjSrBrUA0gSRmKEmK1Fx75cWD5tCMQ/zS5tNO0BeT
         R8gQNnlk/1I3n2OiqK8RP5YayMnoR+ZTqCejNcAydz5pAffoDC+6WcrFJFbXTZK0KPN+
         YacJMYu0cfjJC/D6A0i8k7XWQRsaL9+CqcROji+KLXgRoMCYZ02kMTYv6u2K9IPPTNjG
         DKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731983285; x=1732588085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcAlilVvCqmcxVYfBzypm0OcUF8kidVLMM3xa7PfgoY=;
        b=WooRdpp9FTddC0wzaZrFE+AZtdekcAGV4bUX4HyVnvtDUO2fgVoiBkTXgt5rDEeyl3
         fBTFbRuT7EtTjO6LUIeGgXtDydj6joxVjzwe1IahTQzJvmzONpt3SvHGCkSqAHO97P+I
         v0p5+AwNLnZw6IUcYSa+yvix7+v251/ZsAMvHMfoR9gQ3miVClbC9ybJ8BM30nQHsG7s
         fSENeMTiZDlFxYaUNHoCIsOmE4JqDqvrJhdqLSRyIVuJ/P1jQpZ2sErMdijYgQDNI0X9
         D0jGU6BXt03WCOwlvEV9UtXOku2Dz2Cs6wPPpnmn6iI6/QGoYZvp3rWBtNK+m3d5WxVZ
         bf5A==
X-Forwarded-Encrypted: i=1; AJvYcCXgztBtNfDHer4jC5hlQ6CaivGyIBJ10DPdzOqrJCixrbrtx4qZD6CP3YRh/ST1QcMF/ZHzrn20jZAiFSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHE/75lXWK4Y2TWcFc1izsCjZqy8rUz/ZtzY52gBquhw0PfMa
	L7NNRLZ4pA+HNFVPBjX7R5EkasPP9k5hqRlaY/iTPB+hUsz0AqIuibbimOXmVw==
X-Google-Smtp-Source: AGHT+IHqSM7w5Qh0KSC2SIlQjD0xZ3fL5XR3Jm/pb8CPdX8iBoUwupiyIwuqYFV4nQCidxFE9LFnrw==
X-Received: by 2002:a05:6102:4188:b0:4a4:6a8a:d2dd with SMTP id ada2fe7eead31-4ad62d1dbd6mr11173081137.21.1731983285518;
        Mon, 18 Nov 2024 18:28:05 -0800 (PST)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a8a9fdesm48293485a.124.2024.11.18.18.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 18:28:04 -0800 (PST)
From: Patrick Donnelly <batrick@batbytes.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org (open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/3] ceph: rename some seq fields to issue_seq
Date: Mon, 18 Nov 2024 21:27:47 -0500
Message-ID: <20241119022752.1256662-1-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

This fixes an accidental non-rename change to the caps. Caught by Ilya, thanks!

Patrick Donnelly (3):
  ceph: correct ceph_mds_cap_item field name
  ceph: correct ceph_mds_cap_peer field name
  ceph: improve caps debugging output

 fs/ceph/caps.c               | 47 ++++++++++++++++++------------------
 fs/ceph/mds_client.c         |  2 +-
 include/linux/ceph/ceph_fs.h |  4 +--
 3 files changed, 26 insertions(+), 27 deletions(-)


base-commit: 8350142a4b4cedebfa76cd4cc6e5a7ba6a330629
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


