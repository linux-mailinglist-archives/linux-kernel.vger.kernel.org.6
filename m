Return-Path: <linux-kernel+bounces-413827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2C9D1F42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D46281212
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841214A0BC;
	Tue, 19 Nov 2024 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiGvh7/B"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542C1FAA;
	Tue, 19 Nov 2024 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990852; cv=none; b=roOKhArK2x8d9gfCb/fVy7zDWba+ZROejKg6U07Xdkl4nQyWrH1KjmpQR2qrpY3jmxEmyJKVciXXW6cJQACRepCaPACUXBqMOsvTO1LF97vp81BBirEqj5N7Ui5ZUfVY85QGdb7zWRcLvzC+FilItZgTTNfWUvWyYPPs+e03Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990852; c=relaxed/simple;
	bh=uyGyicuPm+670NCpipk67UBzodb3PT9wXzbFghXAhIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMHcRFhEudi51GeD/jbcfGQ72VGSvM4k/zZKZoNJYlY2oRC6x1zUlXyU0FmTEMvzWcbbRGe1Cg4Q9MhUN4hzb4JIQ8WyS6s0c+IHbvHW8iBwj+WOfqYD+4mhqamW6mXj9Oy/2D50pGggli6djDwdJbsr1wgVdRAGjPxTQw9Mm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiGvh7/B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cf3e36a76so39628055ad.0;
        Mon, 18 Nov 2024 20:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990850; x=1732595650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSSEvoS3pLNX1qJT/yy/0suCP7hyZxakuWk/8ci2Ajc=;
        b=FiGvh7/BJZvNXr5jtm+HXVCz1KAZsADbVUQdO7NyxYx36TULGM62lusE4mgkG4AGlt
         +DAqlLRps/aB0yweaF4r4SLMGZGgiM4LbDYgNKXAQva6+EeUyYS9frEajZMPuDJ+JmbF
         hQvUgT/63zj43p5UeduUd7ds3kAZiR65tcLs+IKWyxIIzChCkrWObo+8FtM9Rq4whmZU
         ndXRdVGHPSVSeQDEpojCPFTTHcKQNw5ZsCNdx3C0Iau6qtTOrRSTO3QvwNatZiQIO1Sc
         oy9BMRE0CPe3xMTZb5YuAjTOSjXypcVMy2olv4OEvO36Nxqqqd+dMshw79hYEzpnaZkL
         ZJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990850; x=1732595650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSSEvoS3pLNX1qJT/yy/0suCP7hyZxakuWk/8ci2Ajc=;
        b=RQG0VqjZb00QBVN2+4eve19QuIqh/xJRbOd5BASiKCzcBvrKPRuA/fzNDTsIQ4b37s
         E+lRmNFVDv3ojbJw+cS58UK2pAHig/8NYZlFYVlMjjJ2wQAd+APMUorUwVGTc/71YLFH
         4NPdpRgRqC5hLqwD6bMIUVQMad9aJ+MpX/0FtMqdYwsM94wFg0Ywcq4TOvaOm3F9KV+k
         JOcfKiJoZvc5DIel3UW92n9QxEC/HN5lN+z5nhhP0Ws7FbUeWs6ayEGOeyGKYokRlNTi
         wCC7JQF2PlYc2F4abbSLzLgfBLBs/f5vWR+bZv44sDvtJmK+m1Tw+eZRx6/ZTNCiPyg2
         aijg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxXaMulJVjkIkUg9BrCTTTsBjmUtHkD67Eb0CYDFuSRyo0OTsLNYU+vux+SIHUZ4xBLkUSvToLkZI8DM=@vger.kernel.org, AJvYcCVqQHHjxYeID1WXZYqoTjbydQvaUbzS2A6AAufGalFOVTk5cjBB1DyEvSgJxGlowMC2p/TqSvSc8/UR9wEAjbdnzqHKkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43soTnTEvRFgNuV19SfMB/gu6OsINzkTRSwH0f8uRaNi6NY+1
	auC492PN0VROYLx3OSuhZhmPqgmpzsZXUFNOQspBiBupDTTnVCEd
X-Google-Smtp-Source: AGHT+IGEX5iPH8bEFJakqfNTlyhGSsuMOCES9IuKd98O/v/Mu5lu4QpyGiYquGQz75qCPihgXQ26DA==
X-Received: by 2002:a17:902:d4c7:b0:212:581a:8dc with SMTP id d9443c01a7336-212581a1f14mr3733135ad.2.1731990850454;
        Mon, 18 Nov 2024 20:34:10 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2124b29c481sm6664395ad.62.2024.11.18.20.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:34:10 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 0/5] alienware-wmi: Fixes and improvements
Date: Tue, 19 Nov 2024 01:34:02 -0300
Message-ID: <20241119043402.25492-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I want to migrate this driver to the new WMI interface. These are some
fixes/improvements I figured I should send beforehand.

Regards,
Kurt

Kurt Borja (5):
  alienware-wmi: Simplify platform device creation
  alienware-wmi: Remove unnecessary check at module exit
  alienware-wmi: Migrate to device managed allocations
  alienware-wmi: Fix module init error handling
  alienware-wmi: Improves sysfs groups creation

 drivers/platform/x86/dell/alienware-wmi.c | 182 +++++++++-------------
 1 file changed, 71 insertions(+), 111 deletions(-)

-- 
2.47.0


