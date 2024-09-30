Return-Path: <linux-kernel+bounces-344543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C513398AB16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846D92822EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC9198E89;
	Mon, 30 Sep 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LBa7Bquf"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8065194096
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717300; cv=none; b=Ct6LEl0cDwtzL83dNsBjt2m57plP74E1QkDkhC9gDyZ6tb8ru2hFbzL/2FglUJUvzKP2uZLft1O8Dg06IHPoaT/JGaUDIJoXEJtcoM/5Z7yAfrG42gBmVCcDgXsCsR2/K8nw1mf+XXfLmJp6DBYJkhhJ/3paJkYygUMweIhLMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717300; c=relaxed/simple;
	bh=Xcu5SbK2mFh5+QFvy6/1Jc7XOXXkRvEv3C2/1YDwyFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmyhQGstoWb31Sk74x9RfT6W1X48kBd3wK57f40iJbNvW6w1UeJHbzJXgYjd9SmbLfd+ktWW2DaPSD1/2vNLlpHNouHrVqvkqrSuuglEyBVrINxfZ6ugAMoVDO1QXixQ6i2K61bakvrKbvfFO4tix4aBbuReeOkObj519NLrMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LBa7Bquf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ba9f3824fso1069125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727717297; x=1728322097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9UIJwuJ4JymZswevV7vzxrHVOvMiT/9Gt6cseSVAWo=;
        b=LBa7BqufSnnRQyCzjZ+WIm+GoVQt7Ox3DFt45KoJEzOoqFivfWdJDiFtm+GPcv1G9y
         JgkVback5s31qdDeEEUNVode/7vfL9jmIcgcwA1rcdCamn9nVOOMo/fzCaPVJYWTZ1x+
         9t1Pb12rMA8AxtfHO+Ah2j2SEJUo9raDOYFn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717297; x=1728322097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9UIJwuJ4JymZswevV7vzxrHVOvMiT/9Gt6cseSVAWo=;
        b=vROQF7dT76apOykwLh+LkqZf8bUPeQj2O8tER7ePC4TTDBk8gePd7TvEyHr2hb3hWc
         9SXNS2y29e1diPvzf4kvHMhbsjvu8THUTG/F+RDEG8j/k84awDilN7LncyfC7v1lac7J
         q/4J+nFfOgBM5B0CCw3Uo47njvnTM3SkkJZTa7BSBO4T9SkUl8eEuKaqcfWM8EwkfxnC
         sNzGWt7rEtblBWjmUcWAli30+grsxGnr1SeGi0IIrgzr2Irs8AReCNNss50e/JzZn8X3
         4eEIkI8YOSYkOzdYptaI1zPOdMg2QePrDhwpAmrlF+Ym2LpOK1iwcQwh1sxdwrLrBHZP
         pV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWgfkTop5wubN8Sx5YieniEC6J4ASZl8dQsqBHY9eXmuFTbsJchJ8afwxKJ0r2A9atJKXLioIa3g/abrl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/dJsa89Wq0KsUtP+VdauFQ83WATS7WSOg+OkBSwK3EU6q4YR
	yPiUakAB4gGdTl8DNcyL248skYUJgOwWicwRW1EktxJeP7Nbg5UFJkVjbDKFMsU=
X-Google-Smtp-Source: AGHT+IGMzq2GGzQycI0pCRrGasVUSaGN2zda37eUWuEyszPM3R4Bkx6waEzvQCMsfv3/U8qKsXUCFg==
X-Received: by 2002:a17:902:c401:b0:20b:951f:6dff with SMTP id d9443c01a7336-20b951f70b2mr32419115ad.0.1727717297168;
        Mon, 30 Sep 2024 10:28:17 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60de3sm56939385ad.41.2024.09.30.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:28:16 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 0/1] hyperv: Link queues to NAPIs
Date: Mon, 30 Sep 2024 17:27:08 +0000
Message-Id: <20240930172709.57417-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

This was previously an RFC [1], see changelog below.

I've only compile tested this series; I don't have the software for testing
this so I am hoping some one from Microsoft can review and test this
following the instructions below :)

This change allows users to query the mapping of queues to NAPIs using
the netdev-genl interface.

Once this patch has been applied, this can be tested using the cli included
in the kernel tree like this:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

Substituting the ifindex above for the correct ifindex on your system
(which is, presumably, a hyper-V VM).

A sample of expected output would look like:

[{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Which shows a mapping of queue ID (0) to NAPI ID (145) for both RX and TX
queues. Having this mapping is extremely useful for user apps for a variety
of use cases, including epoll-based busy poll which relies on the NAPI ID.

It would be really great to add support for this API to hyper-V so that
applications (including CI and automated testing facilities) could make use
of this API in VMs.

Sorry, I don't know much at all about hyper-V, but please let me know if
there is anything I can do to help.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20240924234851.42348-1-jdamato@fastly.com/

v2:
  - Added Haiyang Zhang's Reviewed-by
  - Added Shradha Gupta's Tested-by
  - Commit message updated to include test output from Shradha
  - Wrapped lines to 80 characters, as suggested by Simon Horman (no
    functional changes introduced)

Joe Damato (1):
  hv_netvsc: Link queues to NAPIs

 drivers/net/hyperv/netvsc.c       | 13 ++++++++++++-
 drivers/net/hyperv/rndis_filter.c |  9 +++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.34.1


