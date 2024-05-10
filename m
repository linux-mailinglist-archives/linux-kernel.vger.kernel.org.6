Return-Path: <linux-kernel+bounces-176158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D38C2AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092E9B244D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7B50286;
	Fri, 10 May 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2kW1kZAR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FC4E1D9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371971; cv=none; b=Mhfa6DQe+gyaTsoGPbrj3R89Mem8bxMYbFeuoqmRbkLyQwvPywnd6AKx28KX2Xu/NudnLWyXGbDZgTxYHBQhDgToO5Cnh55dmDYtWxh0PPjEC52Vcf4iF8PNK7JuucZTbFDVIEia187emjp6cPHGHIoEmxY+LmxfSl6OUhIvY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371971; c=relaxed/simple;
	bh=E2yyzJi7pvQ7IjCAnfV4/Fd8YyDvl4Ls7jX/rVuTpBs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pb9zzL+TTOG+O3WZlUbDzI1jUenJuhDy/JLtB1l+P5I32xjN63RwSKtkkwfanmnzaJ3pKHN+MGN1Ga0MWNEU18O/kHbXPGPTsqTocSEPkJyFhFee/Jq9Pj84waiWIPMcL2nXpskj3D2lvNH9ODv7OL+hajJyDlbZ8+zfkVUuVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2kW1kZAR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f44dcb8eb0so1477064b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715371969; x=1715976769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+QoEhuET8KXsAWSA3L6WJ3MCLFr9ZSP16+d5LyOa1E=;
        b=2kW1kZARYRGW1jfR9AejpUOSrHQF2IEsL82a9Gp7JAI+edriJzxkV4M+b6Mel17IWa
         3Bcv/nb9A8MfII+c+mFGFLIql8jbQyllw0+ERvFHhrm/YDhS3nsu2g15tDiWhyS56jR2
         e+aixgv646oPeY42mxpEVJEq9LKM4RV80FFjKhW8vigWNoIi+Og1e7Tc7xLz/LZybF7G
         pKGx57HHDaJ4OVrwX7ssfbef+3DtYxfA0JebwzBbwRqrtV8sIT/IoF7HqeUdaGihaf4i
         cujLjyRYKfmOL65BrwFYlILO15Ifoyu9zCrCplJVWqopIu5cXy32UCmsBLKHKjcrW+r9
         AwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715371969; x=1715976769;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+QoEhuET8KXsAWSA3L6WJ3MCLFr9ZSP16+d5LyOa1E=;
        b=n0cEnhkoXw5oNhWc5bW41D9xKEP/mvJ1WLgmeOPWpvanL32JlcWXHFf3dQRP+MuGC8
         G1pO8xhuZs3habpgppSwhuCJLxc5MNqGXIwC1Yi/1k7fHzdfCtKPSbbDqBN1VFEoOzOB
         pvf2szyX0ZmytkqJApvpzhFuFwXwB9NVlDhulw5hqhh1TFDjW1hkuNqVE7SeQY3L5qFp
         4p8+L5cWsAbDwLpq8voiqatSac73fLUF3etUuVchh6gU9ZGLk4/MDrypAAtCizgU0q8I
         u2EJG4KGa9yDkEUisIzZaYnTM+RulPKBST07P9IlHHgIU4BSHIB+EZ7m91HJ76cEtZRS
         WKmw==
X-Forwarded-Encrypted: i=1; AJvYcCV4udHp+iltCPBG25E1nRKlYmAxjpNOSFiYPE59Gy50pQBcw3khJjr3awHORrc3cmdnVlbv8Po41XZDgd+eZ8LFogXUuhVKLpDfs10b
X-Gm-Message-State: AOJu0YwGj6qHd1K1TV7bDm3qTBdpvf2Fnnx2KTsXVCxJ3r2JuAyrYaDS
	HV6pHMz4G1lNZdoZyc5EUuuQQqoXd3fmrZ8WSO/veBpgcZGa3NdzwGcVIoRLXyTBc39oo/pZbxS
	0Xw==
X-Google-Smtp-Source: AGHT+IFs1e87h8KOhbNcGMSDSwIiTKrsKb+IUnsrUsf6sb54ZanLcLBN5mfD9Cu83qm0ycTKpkjBerKRFEQ=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6a00:1384:b0:6ec:f5b8:58cc with SMTP id
 d2e1a72fcca58-6f4e0395b9dmr128675b3a.6.1715371968689; Fri, 10 May 2024
 13:12:48 -0700 (PDT)
Date: Fri, 10 May 2024 20:12:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510201244.2968152-1-jthies@google.com>
Subject: [PATCH v5 0/4] usb: typec: ucsi: Update UCSI alternate mode
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

This series appliess some changes to the UCSI driver to help support AP
driven alternate mode entry. This includes...

1. An update to the altmode sysfs group after registration to make
"active" writable.
2. A change to the ucsi_partner_task delay when queuing
ucsi_check_altmodes to prevent it from running before other discovery
functions.
3. An update to always define a number of alternate modes for partners
and plugs.

Not related to AP driven altmode entry, there is an additional fix for a
null derefrence in this series.

I tested the series on a ChromeOS v6.8 kernel merged with usb-testing.
That build had some additinal patches to enable a PPM in ChromeOS. Let
me know if you have any questions.

Thanks,
Jameson

Changes in V5:
- Fixed signed off by line order.

Changes in V4:
- Updates to the commit messages.

Changes in V3:
- Returns typec_port_register_altmode call from
ucsi_register_displayport when CONFIG_TYPEC_DP_ALTMODE is not enabled.

Changes in V2:
- Checks for error response from ucsi_register_displayport when
registering DisplayPort alternate mode.

Abhishek Pandit-Subedi (2):
  usb: typec: ucsi: Fix null pointer dereference in trace
  usb: typec: Update sysfs when setting ops

Jameson Thies (2):
  usb: typec: ucsi: Delay alternate mode discovery
  usb: typec: ucsi: Always set number of alternate modes

 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/class.c                | 18 +++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi.c            | 18 +++++++++++++-----
 drivers/usb/typec/ucsi/ucsi.h            |  2 +-
 include/linux/usb/typec.h                |  3 +++
 6 files changed, 36 insertions(+), 9 deletions(-)


base-commit: e4306116b5e93748b3eaa7666aa55c390b48a8f4
-- 
2.45.0.118.g7fe29c98d7-goog


