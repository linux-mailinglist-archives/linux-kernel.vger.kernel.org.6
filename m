Return-Path: <linux-kernel+bounces-413573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC79D1B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D721F21DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEBF1E8846;
	Mon, 18 Nov 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDtJ3sKh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D587158DAC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969650; cv=none; b=ru9LgtF/jGwee9xUVPdHZ7Fi+czzoqmc+XU1UYDKxkKVichfPrhHV86BBUFtDEv8l34IMHWL6e6OltlRdZ82Zm9ElnPDVqv+1iefrqhYYUAmZtd0xAHZFp2EDwzr4YAJvsGbuRc/tSOOu9qGKUix7neZNH6a8nzvTOsyYI13zYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969650; c=relaxed/simple;
	bh=IwvWeYwJTMOuB9zMw8pWHnpFQi44jYl76g5qw5BujXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLnVFpwytqsdwd1sA4MKTY4QTUEFp5TmT3yx56G3nzNondRQpQakiVNvXkPlCIsr5NbAgxDr+k6WJ0zMNug5rP+AQiPVBF4D4Su88lIoGBaQiFL1phyK5kcMM3oKOzP8RHyGbMiqFEJVYCdsyNE2pFthTcL+rK+Vc5mMii3VCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDtJ3sKh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731969646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1O230Jlxlah/OjRxFvR7zagjddCyf3ntg587u1hFFis=;
	b=bDtJ3sKhV4Clzv88yTLSeLz7mYzP0tCrqygsPwgx/hKfyuJgl7L+m/Jjf+19+p7c6zr3lD
	SJAViYcEUnuLj4n+dTDwN6qLc2GIGMuU0AVJbe3NsS1MTqRomy1j/WROOXywTr+2lxrp1+
	DdsIZISjg4B/Ka2vGGr/o1u+suRUTWE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-7gXCOA-SMRCEMaK5SVFpSg-1; Mon,
 18 Nov 2024 17:40:45 -0500
X-MC-Unique: 7gXCOA-SMRCEMaK5SVFpSg-1
X-Mimecast-MFC-AGG-ID: 7gXCOA-SMRCEMaK5SVFpSg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDD9A1978F59;
	Mon, 18 Nov 2024 22:40:43 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3FB71955F43;
	Mon, 18 Nov 2024 22:40:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] two fixes for pNFS SCSI device handling
Date: Mon, 18 Nov 2024 17:40:39 -0500
Message-ID: <cover.1731969260.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A bit late for v6.13 perhaps, but here are two fresh corrections for pNFS
SCSI device handling, and some comments as requeted by Christoph.

Benjamin Coddington (2):
  nfs/blocklayout: Don't attempt unregister for invalid block device
  nfs/blocklayout: Limit repeat device registration on failure

 fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
 fs/nfs/blocklayout/dev.c         |  7 +++++--
 2 files changed, 16 insertions(+), 3 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


