Return-Path: <linux-kernel+bounces-574194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99220A6E1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A07F3B6FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970D157A46;
	Mon, 24 Mar 2025 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XgmHdlw/"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8B264A7C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838573; cv=none; b=kGwxYSJx5QX43+iCvQYbcd54gyG30J9vM9sYfd8Ip/V/kLOTn8WbsJEARZIeIO0cQ0DlSI9IyPrshsIOHYRioDMg2Hb+ktUvUiGqB7krCxzxxgLxYtXcptHM7IJTCI/jP8dP4N1DIXh6hEUvnuuoX/j21gVZzVgUWLbLqwTyPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838573; c=relaxed/simple;
	bh=cNhBkYdt4yOwGCsgxCyvV07ABa+Ur2dMqxDcSLE2GbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeMHSHwcWsZ6RBL7bnwveChjqreOtrbtkAl0/Mt975rMPmT3axi8WUl9UO5/I9H/xneJ/stBCb1RtLCv7VPKG84nDaFADtIU/4lSkLY8BxZ2OWaH734R0xc/i8ug1mFq7qizmOoGrGIyHsqjpKydZ4q6dcAdnqYxrpEFYhTZoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XgmHdlw/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30332dfc821so2823032a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838571; x=1743443371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctadz2xKQCpKUc3wGqIJ+O5JBzWadtIRZJlRi1iw3R0=;
        b=XgmHdlw/v/nty3zwCWzkdv4MHCR5V9+wAMepm0ZvHqZFhrxqUevrC3j60GhKPpB7bj
         fYwS0MDefBIGW1IVPb+Jtdvdm+eElpc9gR7Ds4oHHYuV8yWNJbYRYsEjtv1hDE2kUxpT
         YsoGhbm0I+zeUozM/JgNZQLbE9tHQOGruKGg4Og1iO/4NEz4ypcw2LLp4JZutGJ7UZKX
         41PlQnliQE4CENwZwYDmmKr192ugQ796M6D1ziqUVz7u7ZkloVoaZKfeEkKLSFHaoyxH
         f6mRcO1LLW7etZ1mYqihsNUwISyC7l+7GO2nPfJfJJZlFLoBHro/Wap7zx4Ub9uqpUQu
         oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838571; x=1743443371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctadz2xKQCpKUc3wGqIJ+O5JBzWadtIRZJlRi1iw3R0=;
        b=J0KMHosbeyvvAZPWE+UVfpAIIqznteB707MBi2iTJ3otZWG0mM9bhCjYrfpg4dXM+p
         nB+HPQeE8BDHDcFDOrv+ba2tRyEWT7EeTpgotNPo5GSneGyEuPrMhrRVeUF843IC/xvp
         8kH7TgHJctpbHum1NJg/ki+tlnH9sTIBHpb0EEwr+JptYyUc4Kme4Rt2hihdInQtAgA4
         CDtULfMvGv3tDcP8gU8FGqlnQEplnAEoSeTdu7ELPVsAgk4sct7rvQvD794lCunE0OHv
         2f7UxT98cuRpY4NYjyFGAtmMHUmyVza7YJPA77473jz4xTtINmV/5ZamVTG2IqhT6l9B
         rYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQmMPNLUHBEmnX7+ejTfs49Q2Tw6e5WSFAiRS2b+RzLIdQqmiUs5zJDawY/91mPeh97/VXSYIsNszaFm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpX1Ftfh0DCcZVsvGGfbAD9JXk9nT6CmsukDdJW7WHQ9Tlawt
	EiED5gJF5WxuwAvZWhlJHlNx4hHffW6WYY/dPvYfEVOzqBdjx8yierktgI0NIzA=
X-Gm-Gg: ASbGncuBuC8u9Sf55RsTo7u0C0Q/iyzdAuGgSKJR7ewC7ApgIOHXrfuMpraPuZ9KUm2
	/NxSZLLx7KOdupm40TwjYZxQE1kBdCulG2X0Xz9JUj0Q/77XyqcNNOiw+hI0hi3nv2DkdwFP/Te
	OsG80weUKqWE8s1cdu6t6DG/sRu1Dl55Ez9+0HTw/inPUjqziyFNrM5kHve6uUJ3dxTT2JuRsMH
	bU/W6jA+iApziMJGxQfhjAJ6flOMC9u4dQkiLCAKFlw4l4pEPNiq1ZmD6rhFzbdg9/WbA97pgO1
	3eRR9TWHBgQ9kqKV6ulJXB8/3akE0R5Fudz8+Bas95QHGRkVZOM=
X-Google-Smtp-Source: AGHT+IFsYJWHQ67P01kl6lLAwFTsDb+M9MXYDPIgyJtraJ+agvN8T8Lk8T9/5fBL+k8U7HiYay4VkA==
X-Received: by 2002:a17:90b:4a44:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-3031002c7b7mr21981226a91.35.1742838570730;
        Mon, 24 Mar 2025 10:49:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:30 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 0/7] nvme-tcp: Implement TP4129 (KATO Corrections and Clarifications)
Date: Mon, 24 Mar 2025 10:48:53 -0700
Message-ID: <20250324174909.3919131-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

RFC patchset implementing TP4129 (KATO Corrections and Clarifications)
for nvme-tcp. nvme-tcp was choosen as an example to demonstrate the
approach taken in the patchset. Other fabric transports, nvme-rdma and
nvme-fc, will be added including the feedback received in this RFC.

TP4129 requires nvme controller to not immediately cancel inflight
requests when connection is lost between initiator and target.
Instead, inflight requests need to be held for a duration that is long
enough to allow target to learn about connection loss and quiesce
pending commands. Only then pending requests on the initiator side can
be canceled and possibly retried safely on another path. The main issue
TP4129 tries to address is ABA corruption that could happen if inflight
requests are tried immediately on another path.

Requests hold timeout has two components:

- KATO timeout is the time sufficient for target to learn about the
  connection loss. It depends on whether command based or traffic based
  keepalive is used. As per TP4129 the timeout is supposed to be 3 x KATO
  for traffic based keepalive and 2 * KATO for command based keepalive.

- CQT is the time needed by target controller to quiesce in flight nvme
  commands after the controller learns about connection loss.

On controller reset or delete cancel inflight requests if controller was
disabled correctly. Otherwise, hold the requests until it is safe to be
released.

Jyoti Rani (1):
  nvme-core: Read CQT wait from identify controller response

Mohamed Khalfella (6):
  nvmef: Add nvmef_req_hold_timeout_ms() to calculate kato request hold
    time
  nvme-tcp: Move freeing tagset out of nvme_tcp_teardown_io_queues()
  nvme-tcp: Move freeing admin tagset out of
    nvme_tcp_teardown_admin_queue()
  nvme-tcp: Split nvme_tcp_teardown_io_queues() into two functions
  nvme-core: Add support for holding inflight requests
  nvme-tcp: Do not immediately cancel inflight requests during recovery

 drivers/nvme/host/core.c    | 62 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  7 +++++
 drivers/nvme/host/nvme.h    |  5 +++
 drivers/nvme/host/tcp.c     | 56 +++++++++++++++++++++------------
 include/linux/nvme.h        |  4 ++-
 5 files changed, 114 insertions(+), 20 deletions(-)

-- 
2.48.1


