Return-Path: <linux-kernel+bounces-305738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1009633A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4671C23811
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53001ACE10;
	Wed, 28 Aug 2024 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3n1EKM8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF745C1C;
	Wed, 28 Aug 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879496; cv=none; b=nVaaCprxM+uZP1mqmrwW49oXzZAEv8ffNG4PV7wZLWQ3Iqk0gz/PkwsuSy9U36VfAonqIwGHeohRQdoRFrhiGNiQWKkKo8f3EtMEoCL1mb+aEh6E7D+QJ39nCA8pwRkLFT15f1+bXFeXzfpwQM1tOZY0EHU5kRrNVDnv6KcaXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879496; c=relaxed/simple;
	bh=xKxsz7+MJHQSH76lifXHFQWDTfeq6FPb+YO5vpGgrwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJVOsTRix2HfLSzKwA3MBqKLIdAuoOC0FWXBB8bNnqJ5qcsuTSQnm3Wq4arfly0oHD4WYYF27IyANPQhsPECAPY5mZKkbdpsyXREMgMSEwQhIVcpEjgdpxCpFwKDl/v/4LJD/0cxwPGyWPMpfHfonEclwE3udqWfFDce7UYPp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3n1EKM8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714287e4083so6409396b3a.2;
        Wed, 28 Aug 2024 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724879494; x=1725484294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ltO33GzNl5SpZ2ZrGQmvHFm6+FaRHQLpXSbuEPfZ00=;
        b=L3n1EKM8eKr5RDRHiDUhusd/3QCq6CdruhSirykjzqUpO6z52OoIk189Mh3dknZhn5
         6pzBz4uwqIpPo4RbeQc654r1akFhtd/4vbiYIEkK79vFtl6/JqpUkj1MDF3MJ3FxprWU
         TgnwmnZ/oMJZhHgYeqYZBsDe6pa9jo85VW8smbLW0oJcJkyUfxbzM2ENXZ9+6LDcfvU5
         YbRiaRpnKpjrTnW6t3ek4m2u8KV7RZOSuLl88Lx4OdzzGp4fSNZUZdaC3pzFTBxnyUSb
         6Llp+czw1PFmZ84jZbELdX19rRfXYQQQbEAXH+LZt4oqINuRSXiUhDDB5Z5OHtZLGlYC
         5Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879494; x=1725484294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ltO33GzNl5SpZ2ZrGQmvHFm6+FaRHQLpXSbuEPfZ00=;
        b=wVdd/BBDR6VBZuQq2JmJfp5lUQ1opmJLe9SzwEFeYF7HEBaTkDZ1I2jmPD0M/vuY35
         w2LtZH02LHhrWLSspNK7HHDQ0ZkNk2JO2nxi18RA+TNa6Iv27wvbYNtJPLQYlQ3vUMMD
         E3lVmU7oGba8sXU0zomjkRw6865DMhuhclR/kZea80tGDbyRn/vVHaqj56mHLKjx2Z+3
         X7i/3w3YrIYQ+t113tBsHStyF+7zMHHj6iWTKtWpE4Lgly2fy/wAWgu81bPo/Kow82WY
         2qQK4fN6lFuiWMyFQqotzu6Er8yCLyxLUt13vpCCbhgfORqkGq88P2FLayOJjjq3Bd9t
         rbEg==
X-Forwarded-Encrypted: i=1; AJvYcCUwQII18mkMZxQS1d2m5HPNsddk3ACkmO7o4lqq+RwuH5wdwkK9OSvi68TTrqlOLecG3TgUDspHBwHuHfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjX+UsG3Yd3UQGHsFUsQe+G7ubOn1pumedX+tH6K8Kl+PBaby
	vNkLxo2Oe2Ni/ytUEVq7lDDW6uMglXx4UGAsbVauapPsGFWx1kNgph5dqg==
X-Google-Smtp-Source: AGHT+IFtwPY+BJsmdft14lL8fPwiHtYDUxKbKvRw+s8KtPbJSSwyyUrsH6ROmjgOA3G9Yz2tUMgYNA==
X-Received: by 2002:a05:6a00:855:b0:714:25aa:e56b with SMTP id d2e1a72fcca58-715dfb2d890mr1067999b3a.8.1724879493932;
        Wed, 28 Aug 2024 14:11:33 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71434250f5asm10513557b3a.69.2024.08.28.14.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:11:33 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 0/1] Retiring from the Rust for Linux project
Date: Wed, 28 Aug 2024 18:11:16 -0300
Message-Id: <20240828211117.9422-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This is as short a series as one can be: just removing myself as maintainer of
the Rust for Linux project.

I am retiring from the project. After almost 4 years, I find myself lacking the
energy and enthusiasm I once had to respond to some of the nontechnical
nonsense, so it's best to leave it up to those who still have it in them.

To the Rust for Linux team: thank you, you are great. It was a pleasure working
with you all; the times we spent discussing technical issues, finding ways to
address soundness holes, etc. were something I always enjoyed and looked
forward to. I count myself lucky to have collaborated with such a talended and
friendly group.

I wish all the success to the project.

I truly believe the future of kernels is with memory-safe languages. I am no
visionary but if Linux doesn't internalize this, I'm afraid some other kernel
will do to it what it did to Unix.

Lastly, I'll leave a small, 3min 30s, sample for context here:
https://youtu.be/WiPp9YEBV0Q?t=1529 -- and to reiterate, no one is trying force
anyone else to learn Rust nor prevent refactorings of C code.

Thanks,
-Wedson


Wedson Almeida Filho (1):
  MAINTAINERS: Remove Wedson as Rust maintainer

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)


base-commit: 6e6efc5fef4a1cdcccca3cffd5b73fd25d093352
-- 
2.34.1


