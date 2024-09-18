Return-Path: <linux-kernel+bounces-332961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A82697C184
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F8EB21DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDE1C9EC9;
	Wed, 18 Sep 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="PBJVqEWd"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB33158A36
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695626; cv=none; b=MZKlwxFqswFOchGgjQ2vd5n1nbgnfccqW3GNrFcfyr8tKTX6ffPrkoNNkYxVkvnK/Q3vQ4/8BKgszffQ+R2tywwTkrEhmmPOQk4rL9WL7L/MZHLtmNJySuJGuvSLTQsXc3GZZ1indSoaW7EL764eBFSKi/StJwLVcG4Yzo8fFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695626; c=relaxed/simple;
	bh=zV7oOnh1v9Qm4ExcVQX9jxi1Kinggu8gO2DZNDihC8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rXnAZ2TFqJBscFbqrWPkyI/6A1aa5D/AXwwGuNSr3d55EAR6s0GEs8r/8fhODDHwYHAOBh8r/gXIhAF+73m+Xp02TYGFi1Ovn6k8cOglSzr1BMX4E34doKy3DZc0JXOMS5Ab3CUl7sps+/XiPOHLX2QCt+pbDieyoBZZDopBvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=PBJVqEWd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7124352ecc3so105709a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1726695624; x=1727300424; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4UPWIaNZzgTZMfVrVLiRFIyFO4YHjG8B3oenUoNP4A=;
        b=PBJVqEWd3NAZqwPHl+IXUgG14OtsYM2FSBgR45+Fea1e0iwwzIw+c4yp5tjd+3ca8L
         s06/C7XA+OUgsdevphpcFNBCiX1BgNiL44kmiLsP8OFcsGgcdTtZdz1IPrmdnISYp+eA
         JnnYZ2Mn+X2NxHiXmm7SeP94YdXYs3DBgSQmvYEqN/QCT9lKX9KUq7qpc1PTf85Q2nm3
         QEfCoIJJvOK55UqblQ8q7EuMqakYFtXx86Ct6ZJzsSNyxZQKBqycLYCJMiHPFVQNdbfJ
         5J9kATJmgieLud6dkxldDNngWa/QRjqdAnVrKmi5F2wn1Qvat6oaUhgCP2s5wCaFLchg
         hBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726695624; x=1727300424;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4UPWIaNZzgTZMfVrVLiRFIyFO4YHjG8B3oenUoNP4A=;
        b=cT7cYW6aaI+22yf9WgXdLj26URTVujT6lSqmUGWr/kApV3A1x+kqLBkGGUNGmW/XLg
         G97nfusGb+gwWPfRi/fDM5bUQpAmaoDjid7wLpcN19photvv2BoVWWrsDkhc8lPdhgfj
         +FqAbjdK0mht3g45F96yVgM0ifJGADa02e3JwoEigA9FhniqmeB6hiElzsygRTsmHuc1
         b0wTfFgiu9cFD2x5FMqfflFxl1tcXIMBUgv/ubzO67tl3iigkGOZhlenr1eG29RdC4Pg
         GizzDIonlm/nblcifLh365w9wwL/jVYkLmapcrU2mu2HiE7bt8zIjV8MHI9fh97t2ZSD
         OHXw==
X-Gm-Message-State: AOJu0Yzt2o+gjHBppCxryF9vICtmIioQ/aAWBM7qsSN8mxcI1TfVXSaq
	3wsWCyNEAbyj0KuuPkoIhf1OT2jvSHhYwtW6Shgs5TpWDdZSuyPwdxb4Bk8FDNs=
X-Google-Smtp-Source: AGHT+IERbSea5tOwE/ugCqHO0mF0yeviIYZi+LTmfvLAf1RlVZRHT0oESD3F/6RCeWA/Tl2XKGvYwQ==
X-Received: by 2002:a05:6830:25c3:b0:70f:6ec2:5e1e with SMTP id 46e09a7af769-711094c8dc9mr14391227a34.29.1726695623842;
        Wed, 18 Sep 2024 14:40:23 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:bfe4:2aee:929f:be5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71389b59088sm55108a34.24.2024.09.18.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:40:22 -0700 (PDT)
Date: Wed, 18 Sep 2024 16:40:17 -0500
From: Corey Minyard <corey@minyard.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.12
Message-ID: <ZutIwdh3ij-tx5kg@mail.minyard.net>
Reply-To: corey@minyard.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0108b7be2a18d85face1e10c68ecc0138f1bed58:

  Merge tag 'for-linus-iommufd' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd (2024-08-20 16:06:39 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.12-1

for you to fetch changes up to 64dce81f8c373c681e62d5ffe0397c45a35d48a2:

  ipmi: docs: don't advertise deprecated sysfs entries (2024-09-01 14:35:35 -0500)

----------------------------------------------------------------
Some minor fixes and cleanups for IPMI.  Nothing big.

Handle a bogus BMC a little better, fix autoload on some systems,
remove some deprecated interfaces from the docs.

----------------------------------------------------------------
Corey Minyard (1):
      ipmi:ssif: Improve detecting during probing

Wolfram Sang (1):
      ipmi: docs: don't advertise deprecated sysfs entries

Yuntao Liu (1):
      ipmi: ipmi_ssif: fix module autoloading

 Documentation/driver-api/ipmi.rst |  2 +-
 drivers/char/ipmi/ipmi_ssif.c     | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)


