Return-Path: <linux-kernel+bounces-424640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA79DB75E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF7161D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43A1AA1EF;
	Thu, 28 Nov 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dzX7lUaH"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A819DF75;
	Thu, 28 Nov 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796099; cv=none; b=qRw7PK4dflqHXP8O+5oS8J7OVVCU3TftqKmTb6CALWUXMksqWRwbKZhK1DOTGFK+L6AzEGq8L8D6I76mQhloWIAtU7ZdOgpW5KGAvU8BL+FGML0VkrZkf8fuPtGpAskOb6l7rjWu7yefwqxBPPA2CamiAOCavcAXwhiiAGlBn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796099; c=relaxed/simple;
	bh=EuRvb4iurPU+KPtiuVrtEypopWq+IaHF+mBIaZXDbuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxxbMlGxUaeWGCSW3g+qrHW8OLhoKYuAwx/CjqTtsLdLC+JUnM8bDSPVpFdW9EXcVOS4CrSZFruJjlKVadLtof4j/js49buxHAVRMjuqRPqK6fHr1xbLyB4ttKl8j61uFlGohkptb9LHVGPnZWfcWpWetEACRTxPUMd4mEFXF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dzX7lUaH; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732796086; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zQlL9IO6yoSzpdu3HAcFjqyOn28miNFmPXLUNzfghKM=;
	b=dzX7lUaHciW4tIYKvfin67E95BaeRR3Ka1DocMtL4yhxFqjfJKz03ScFIJFbYfbLZlSaiTpbtosgL5tlNpcKLIK69h2W+eX+l4n6E7P9fr5WeQOZDC4aVuEI/0vb+goboTPnBHVYOyqUkZl/2G02xqz8dux0w93RC+cgzvpRjVo=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKQ-9T-_1732796084 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 20:14:46 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/6] several fixes for smc
Date: Thu, 28 Nov 2024 20:14:29 +0800
Message-Id: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

several fixes for smc

Guangguan Wang (6):
  net/smc: protect link down work from execute after lgr freed
  net/smc: set SOCK_NOSPACE when send_remaining but no sndbuf_space left
  net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving
    proposal msg
  net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving
    proposal msg
  net/smc: check smcd_v2_ext_offset when receiving proposal msg
  net/smc: check return value of sock_recvmsg when draining clc data

 net/smc/af_smc.c   | 11 +++++++++--
 net/smc/smc_clc.c  | 17 ++++++++++++++++-
 net/smc/smc_clc.h  | 22 +++++++++++++++++++---
 net/smc/smc_core.c |  9 +++++++--
 net/smc/smc_tx.c   |  5 ++++-
 5 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.24.3 (Apple Git-128)


