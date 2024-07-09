Return-Path: <linux-kernel+bounces-245618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805FD92B504
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C41F222DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4B156257;
	Tue,  9 Jul 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NHR8jP9k"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045214EC61
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520397; cv=none; b=ncGXm4H/3kw6vbnXicXhYWe6sLary/PabIhTmIrRTIJ0+7Brz77N5fNsgAVuicM+LfCvR6o3sG7G+rrRaA2Hc684E1ECu1l0tYisp9WGu19SCARiMw2tDso4c9m0IjJGtklrziZpzzbHxDytE7ra9qykCdJ/dOjXqd87kzvZZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520397; c=relaxed/simple;
	bh=7l7Gnx36n7yyUlfPBXRvLQSU/1+kcr0OdNm2VCuznG8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kR5JyILqmtzXkev59fdTu3vU7Zm0L/95SMUKCx/S8zbwpyrECgARdEuXPL8hrimEeTGv2mzKo6Clf9NRSjGoowfkNyAYQC+bKDAY9JADPO+mqdtNLzXhAG62f0zTWERuSKVfb8vLPOJYWXrWQl61d3WZ0JKiOp7DxVmhyReL4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NHR8jP9k; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b04cb28acso3320664b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520395; x=1721125195; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=NHR8jP9klbFKVbHfTCILManHrRVxQ9VKS6YbARdF743JVNLbGP85UF4njgVQN5QyoT
         +RfAt4YD0G4QlDA1cKaOaEohPAZhCRXF8BAuLfGoU8/tUAAAy9/PTLhgR9NoKu0zsHMZ
         nk1uKh4a21rZHUfatUb0Fjdu6nvfGIBlD4VQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520395; x=1721125195;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=DrDWBrS4Ejuqj5LgfxTyEDLDrN1LN7/K9CvSUuYl0NhE4deLxZlCHm93tpEeQx9wo0
         Q5ggE28hZC5Rvzi3JezlWQTbNf6sLnl1ofywpYBIbs4z/mg8p/Ws9GRyi8CZcsIZmahr
         ot4W+FAe5cnLYP83p7l0TBStbr+T4tZvqcZzRGRcZUrxVuxdb61SkBMVfcAILpZaRn5y
         Zks/v1EHqXaqXwIrdV165oYSTxf+PwV0XHYAZcVAtOCbU8SJUNf3NCqcqmDzJ5GHN/ZZ
         CT/5aM4sFYm3nDdia66mI9F2n5rKTjOpWZFbwFZYiBTeAfV6i8sGpvzyq4zj77f5ok+Z
         I9zA==
X-Gm-Message-State: AOJu0YxNAnhkF8tRwKiFHFn0c5xhZEMpYCwOwlKNo/62GYkAweGpbbyU
	U4+A8aQ1e/VWKMRVfMQkfLNLO8jf0GzDGeAKWmZldqQKHjl49SulY4tEE0t8aNe4FzNX9omxXGf
	ju1K0+o9zP3cfIcG23heMu2JaTCNFVFAcytGmoiZckMdcjgQOSngjEtHgdId8EVDGgnGiGqVDht
	Y6qs7I3u6TSZLUbg8x0+em5RuXsT8LD7dyd6ddYFY7jn1TMpS2islr3g5s
X-Google-Smtp-Source: AGHT+IGgmqH7UQ62MCOmx/bF5fNPuls7Idvh3gTEMJN+4xl6ri7+bXz1HtPde01qGp0e8dNnIi9M+Q==
X-Received: by 2002:a05:6a00:18a3:b0:70a:f001:d22c with SMTP id d2e1a72fcca58-70b44d4474dmr2944949b3a.4.1720520394971;
        Tue, 09 Jul 2024 03:19:54 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967345sm1426016b3a.112.2024.07.09.03.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:19:54 -0700 (PDT)
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
Subject: [PATCH v5.15 0/2] Fix for CVE-2024-36901
Date: Tue,  9 Jul 2024 15:49:42 +0530
Message-Id: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
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


