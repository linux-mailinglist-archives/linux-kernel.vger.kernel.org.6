Return-Path: <linux-kernel+bounces-510397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F8A31C32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDF3165FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82A1D5173;
	Wed, 12 Feb 2025 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwHhDgGE"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65E78F5D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328182; cv=none; b=GwC6JqwlzIdQ8U1q0ddm3Wl9hXME3tB9Khq5WArIincclQDCMExfDhv4gpsYjf3zs6tpJnS//5a2jpZk3u1CInd0jQiu2xZU1bIWb7FD7wnGjJBTC/qzCra+iNyR/MuzhXjyWImcKjd1QQVi9iZg6sjvTXiYVB307pF3VugHxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328182; c=relaxed/simple;
	bh=55rHbZg6TNlgCEr5uMpGiZRMKNWT/zv5XI+4Tb9Vv0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZAdnkbzobR7oP8ZN69j/+6pIQnI4b3zAEmyLeXLr8Q1amXB0JQUVI8U9t4QbzDSnLEAfwKEi2JTVbEGyB+cUt8V/4dHTZuA6ZkTWmxm/sggsWqRmzpqX8/3B8jLMFuAAi6FZUAI/W+rIVypYM38WPhdf/Yg7OMgsgDXKj6+bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwHhDgGE; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ee29277d44so3716006b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739328180; x=1739932980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjpiqZwwlsiNfkr1x+iRLMWGCVXZjDSBuvkj25teNyM=;
        b=DwHhDgGERDooM+/uFm1MiHoKyd24V+DWFE7nKUDur7DqFA6TMke5o7DWb5Vjf/X31R
         c6xKDtHJRqtSlJcdhkav4sSmAYtv5VHkBl9gnmyS7mBYVJ1aBQ1khh3ELy3Up3sJFQKq
         yMsovoKscptBToJ6Im+p+nyeqR9RJiW6Rcjc1IJ9EZ8Flpz76zpFbaV/6cAC0M5fqb3L
         Xgd5ZeKtExJ7chdkkoYk9yaNk+skvi6n0WKeC/HAi1ub8ShR8RrKswGA+mVoITKX+2Mw
         4/8iSgWakoq/qKbnKyrswIEQSRWJFh3roRxrG1DWjm7pX6yerh0cLE43OsnnwdI+tMRt
         3h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328180; x=1739932980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjpiqZwwlsiNfkr1x+iRLMWGCVXZjDSBuvkj25teNyM=;
        b=AF9BJlGxpq2mubDqJWjrnYfTft+jlCgMtol9entvP23RsIZWZIGOnA3sTVsvFm73WC
         arcHHllYk7ov0oW/l3Z3VA9cpRzcoZ9BRs0NWQXwkRbMQaH2aO1CasqdxyxKc0TaTRbd
         nDlNJImth8/qeYfKkaY+jnaqpuPXlm3wozRkfjmgHeK3hfYRx0c6FsHBy/BoGRFTNuEi
         Lb8+jLswjcKUmplb1cQonJuVihXpSg/sA7Jml/strFYxRQG7blzwonoTmD3LOkfA9wAR
         fzEfrBDDogC8WCPOeLNWPYGin7nLXDcfBDKyaojNcH4TW79uAtclPnwQavClupGj66XI
         MVww==
X-Forwarded-Encrypted: i=1; AJvYcCV4Kbkva7Fl4WbltWwMjmvR2BIe6iGtdKeHeUSWXrFlR28UwyKT0BzFDufBFeP+27izZtiUMZzlMO6IgLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyu+A/4Rrd9cToxfIybFnQB+N3poAFnmw+yGOhqgYPK1LHwKXJ
	SftwqPYvVXaZKdDep4TBb4H56yFToyJNMJ6h+NQMuYi6ucrv5OKn
X-Gm-Gg: ASbGncuocVqc5/0NYT6aGZTi/qNOXuHiYYptTeyO+9zH0pYV3dW63Y2052GGUy7UqR/
	P8VbpHHeeGm0iCFJJNTGb6fkUiDUUZkkHfECoR2sc4ksL9w88uWOgNIseCm73yjxNhw2opEtqsK
	hng+Gpba44JFNZOZyr+nM4/IaeGgETVq0eU37jSCLikSmM+EP7jjezSN+l3cqUGlReiuEnSJCW5
	TmtS4cAH7abLDpCNZuVfBtbvQfOU1y8QsmIhBRGUJKoZel4d/IIS3oGTg8EG3E8CiwsG7WpmxW2
	lOtCAqG/VPqGXkJBeRRDyvWKh/Qa/Vx6OGIW1yg=
X-Google-Smtp-Source: AGHT+IGel5eaV3DwS7l4aGWgv3bGi7TDkD3DXbXBBsUt8VFU3wp+kXtES5MXkv7rCXgvkpRxhfFdIg==
X-Received: by 2002:a05:6808:114:b0:3f3:cad0:5c6a with SMTP id 5614622812f47-3f3cda178f3mr1200522b6e.26.1739328179628;
        Tue, 11 Feb 2025 18:42:59 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726afa4efb8sm4059667a34.66.2025.02.11.18.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:42:59 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	dpenkler@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: gpib: change return type of t1_delay function to report errors
Date: Tue, 11 Feb 2025 23:35:35 -0300
Message-ID: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate t1 delay configuration error to userspace
---
Noticed that at [1] there is a FIXME tag to propagate ni_usb_write_registers() 
errors but the t1_delay pointer definition is defined as unsigned int. Checking at
userspace libs, it is possible to notice that the error could be returned/treated in the
following sequence [1], [2] and [3] (I'm simplyfing the codepath here).

The patch is big due the pointer signature change affecting all gpib drivers.
I'm suggesting to return a int value.
I've tested the compilation of every driver after that change.
Tks and regards.

[1] https://github.com/torvalds/linux/blob/master/drivers/staging/gpib/ni_usb/ni_usb_gpib.c#L1608
[2] https://sourceforge.net/p/linux-gpib/git/ci/master/tree/linux-gpib-user/lib/ibconfig.c#l70
[3] https://sourceforge.net/p/linux-gpib/git/ci/master/tree/linux-gpib-user/lib/ibutil.c#l469
[4] https://sourceforge.net/p/linux-gpib/git/ci/master/tree/linux-gpib-user/lib/ibutil.c#l433
---
Rodrigo Gobbi (2):
  staging: gpib: change return type of t1_delay function to report errors
  staging: gpib: fix style at nec7210_t1_delay definition

 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 drivers/staging/gpib/cb7210/cb7210.c                 | 2 +-
 drivers/staging/gpib/cec/cec_gpib.c                  | 2 +-
 drivers/staging/gpib/common/gpib_os.c                | 5 ++++-
 drivers/staging/gpib/eastwood/fluke_gpib.c           | 2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c             | 2 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c             | 2 +-
 drivers/staging/gpib/hp_82335/hp82335.c              | 2 +-
 drivers/staging/gpib/hp_82341/hp_82341.c             | 2 +-
 drivers/staging/gpib/include/gpib_types.h            | 2 +-
 drivers/staging/gpib/include/nec7210.h               | 4 ++--
 drivers/staging/gpib/ines/ines.h                     | 2 +-
 drivers/staging/gpib/ines/ines_gpib.c                | 2 +-
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c   | 3 +--
 drivers/staging/gpib/nec7210/nec7210.c               | 2 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c            | 4 ++--
 drivers/staging/gpib/pc2/pc2_gpib.c                  | 2 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 2 +-
 19 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.47.0


