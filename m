Return-Path: <linux-kernel+bounces-245625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD492B520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D1B1C22F90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9DF156863;
	Tue,  9 Jul 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fiCVGxzJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714815624B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520580; cv=none; b=gq4eOAf84nFLuPdByqE4cHt+4V+78NlcLLuBUgS8eBvkGo002QByROJvwVgRKp10np+XvSyQzK0aS4Ly+V08PAsrSKZkwjvdcIEuLIbVYNXP2zLTBMsUyGAzX+VoFwO52PFj0PkOUU4FvAGMvWVd8vqoLIw+Hsdg/zbHIiLQSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520580; c=relaxed/simple;
	bh=/Popa0pu2ve+BT+70iPGnXxHfASirswI1GoEfm2LmEI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MHzIvbP7IGQB1poxuolEhsNAF1SKi2BVQ6KXm+71XfZ0FfuHDx3jtqxtiLjCQOMaLySKFAyHWK3ar4m7f9wWgHuLTC8UghxylV5kqrDK61II1r5UQwIRBvuOrqzhGAcHaTMt/1usOG5rRp2M4V/I0+rZS5eIvwBe7vFfNa/8FiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fiCVGxzJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70af8062039so3003085b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520578; x=1721125378; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=fiCVGxzJHc+khc8ysRoN/L1zd+q0CWhIlnsTQHRBhfqgmt8Q/S8C4D+m9edIQQljX+
         PjO8hjiOhcudRhBLRTUlLzdXiWAp9MaIJjNCojOABe0xS6JQTKXwt9SvnMTcivBqyxOk
         jVm++HadCeavB5xgU0cqyiiSz5Q69MXhqjSJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520578; x=1721125378;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=m/7FqXLp3T2R8PE5ra/q7zUHfQJLnnHmLc8pMr6GMoX4sYc5s0R3pX9zPUZBHtdhM4
         xlRfyPG/YAr7cQtuOf5p1bh3QfIgegMZjQUx/ecdoaHAc3fbOEvqXR1g4rznlIvqCA9L
         zuTRmGfRV6NftUQ0MNc3VedEljU6ivnRlWcYlLDPk33EsKWgpYYT35SSprpZzCG7DUH2
         LHi8wl/eDpdgw1tex/hd4DLIu+jzGIoY4lvVtjTMF4XrCO3NdpZkcEM+xif8wNgqgMKC
         jBmKZBcxHIDlT3yzIPJb93bvZWEakLB03Tl2v6np9ecneAbDbb89JkPcmhYYU0b6XhH5
         gtyw==
X-Gm-Message-State: AOJu0YxuPhezS6P7nJfHZFPv9WUGfO3l+qRxUWscXwa3dGRzusB2ADaN
	qRAQnOxtQ+pwP/5O6VZwJY9+6Zt0fVFRDIji0sb/8/LCCQl04gMDhi34KIO4L+z7qcLA8HqIKqi
	U4PwIy+z1e2dkvKTzrgW14ks9PccOXY5fyAcI6MtEf8/Wdv+5JX1dhKP1S/zyXAU5JcvpAor2pA
	cH2jFkA8aM3JF8jSaqNUQTxNnXoroD5NH+8wxnOIZBvNgujMYelIElRw==
X-Google-Smtp-Source: AGHT+IEImvkD6z0gexkfENnSZaUDX8nym2t3SgyFN4Ccwymmm1btyXlvMii3wyggYiErqQf98g/ruw==
X-Received: by 2002:a05:6a21:a342:b0:1c2:8a69:3391 with SMTP id adf61e73a8af0-1c298242021mr2265566637.30.1720520578368;
        Tue, 09 Jul 2024 03:22:58 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11757sm12832525ad.35.2024.07.09.03.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:22:58 -0700 (PDT)
From: Ashwin Kamat <ashwin.kamat@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	florian.fainelli@broadcom.com,
	ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com,
	ashwin.kamat@broadcom.com
Subject: [PATCH v5.10 0/2] Fix for CVE-2024-36901
Date: Tue,  9 Jul 2024 15:52:48 +0530
Message-Id: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>

net/ipv6: annotate data-races around cnf.disable_ipv6
       disable_ipv6 is read locklessly, add appropriate READ_ONCE() and WRITE_ONCE() annotations.

net/ipv6: prevent NULL dereference in ip6_output()
       Fix for CVE-2024-36901

Ashwin Dayanand Kamat (2):
       net/ipv6: annotate data-races around cnf.disable_ipv6
       net/ipv6: prevent NULL dereference in ip6_output()

 net/ipv6/addrconf.c   | 9 +++++----
 net/ipv6/ip6_input.c  | 2 +-
 net/ipv6/ip6_output.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

--
2.7.4


