Return-Path: <linux-kernel+bounces-344843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9198AED8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6B8283B92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAEA1A2555;
	Mon, 30 Sep 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F2a90XNZ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B57194082
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730468; cv=none; b=JGF6/+eWwK/7obYz883YgkzgVnk3Czzj/vX8csu7HqDDGh6H9QV2N3TX9R1GyhqlOcTzH3znzgnLXehuWioWLtqGXRrTVxyoQun+AcOs563qYADiWkMxs+hEW8lvEYafJciNT27AFMHqtZEzijjM+YF1XUNr/SFpcLigogGGgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730468; c=relaxed/simple;
	bh=wrH3ejNJ740G76Ulnf0Pc2dPkl8LUwTvYP/7w/p8f98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DduDBSqyC6z45TUjgEPZS5fRyYMPRnfbXbuyxsVMiqrI0pSPrv8ESmid9L5w0lFdyDQjWaPzUP79nKtBPzieuFqBcOs/+xMS60EJM9VXggFR6byb7AJTrI5+JClJITN7W5vdOuH5aI9P7maMmiRPqaNNJM+R21btqPSX461jNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F2a90XNZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so4033564a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727730467; x=1728335267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8aiIusvfCJ8Y/Mbuyg89MbzSUpUMVKwRqs8fSlQSzo=;
        b=F2a90XNZD0+D3T2VfHB35jUY5kpABh12qREPxPp+82duEBP1t/rcr6g+dSgtVNQzSJ
         I3EO/cyUyEJJPkSqXVbxyhj5HAgZCwomv9c37ScID7w+Vy5gJaZS06lyoU0cFXrO99tv
         tIapdzviu5ecR2P2CHGqZROc8UPbBY2ENpO0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730467; x=1728335267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8aiIusvfCJ8Y/Mbuyg89MbzSUpUMVKwRqs8fSlQSzo=;
        b=nyMYgjMm0ZaBpkt6z61fGLNF6ebejgSkh3AOQELTt/XjdU+4iu7DhmeyjEsOBsuOxn
         0C8KDlzUldhgRrBMTrug4YD7bu8Br3RA4RulXmwYPhphHo2v8cOjYOYzPUlJ3CYkDaZb
         peCr9bZvBh3p0QDVgTe00waQtzB95v8fJHj09/svny2DCJfGG0DJtwb/xR2fskoZuxsS
         TFopUr3oPsLcV3bZrjMOnWzma1/HkJlvucbK3mlL9q6nnDWPUBPnPE4bMUqEoQi1x6Mx
         NZ3iE5oKJCGuVHDX/fj9U0woZYUx1n1XLKHpesMbkvZ9wrrLyguXCzU1+z6R18koboEJ
         7Lpw==
X-Forwarded-Encrypted: i=1; AJvYcCVS8fouo78f6ggs8q7LKV+J32agA+beJwb/qGroyxmx1RMNqX8EAACL4OVmcZ9vF97Y/mF5UrwGfZ15OGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKyI3UpTyo5PooqXV+zeVs8ZdMGmz9Qr1aA0WvpcumHV5AkQu
	2Kuq3233XwUNY0BccPmNvXxGZZl2X2rtdtOPFlq/bjKH23wUgNdcugI9B/xlDmE=
X-Google-Smtp-Source: AGHT+IFJATfp6tM4lpzO4EBUwrl7NJ7Unq0DqBkTMLiaXx3ye4SDY9+pujgIFWcxlIILHR0RgqlAMg==
X-Received: by 2002:a17:90b:4005:b0:2d8:baf1:e319 with SMTP id 98e67ed59e1d1-2e0b8ebf632mr15837481a91.25.1727730466928;
        Mon, 30 Sep 2024 14:07:46 -0700 (PDT)
Received: from jdamato-dev.c.c-development.internal (74.96.235.35.bc.googleusercontent.com. [35.235.96.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bcddsm8427642a91.4.2024.09.30.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pkaligineedi@google.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shailend Chand <shailend@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 0/2] gve: Link IRQs, queues, and NAPI instances
Date: Mon, 30 Sep 2024 21:07:06 +0000
Message-ID: <20240930210731.1629-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. The previous revision was an RFC [1].

This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
so that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on a GCP instance with a GVE NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20240926030025.226221-1-jdamato@fastly.com/

v2:
  - Fixed spelling error in commit message of patch 1 suggested by Simon
    Horman
  - Fixed patch 2 to skip XDP TX queues, as suggested by Praveen
    Kaligineedi

Joe Damato (2):
  gve: Map IRQs to NAPI instances
  gve: Map NAPI instances to queues

 drivers/net/ethernet/google/gve/gve_main.c  | 17 +++++++++++++++++
 drivers/net/ethernet/google/gve/gve_utils.c |  1 +
 2 files changed, 18 insertions(+)

-- 
2.43.0


