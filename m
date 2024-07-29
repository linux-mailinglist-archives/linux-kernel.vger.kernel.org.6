Return-Path: <linux-kernel+bounces-264989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D279393EAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F273C1C20A09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1474420;
	Mon, 29 Jul 2024 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="kQZ0Bm//"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DD2A1D1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218782; cv=none; b=ONAa97I2hxYdrUfeXac/CUcjOxVOzvTBlH3loc8IhGkn3AtzcdZm0QaUyIFzb9PMPwoa+nHmB/PLGN6PHNLdYt7lDfFSUbAPygtn2lrIpVqZpflEJk8ilBP0jBoQGtZes3HFzUAH6IxcuxHItrV70kmfe87uCPjPnk4TArQ+Gmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218782; c=relaxed/simple;
	bh=WYM2xGU0PmC38l3hOL0oXi7y0atC1lYkK8tQiSF3Q/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hr2mYS6KMgM3FEXnDXsMk7824F/MkpDXzw1d3nljtgosQthd0UAfOcEuwbMoCvtXrGwxrlzT2LRYza0CjQq0/9TsXaiKAM7FaTDseLAwBKrJUt8Qzt26ESzv6IJORluHDi6kKzRsVRxkq4Q16LyZjPSQdDAOvI2jN3lJsVcperM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=kQZ0Bm//; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-261e543ef35so1799617fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1722218780; x=1722823580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zC9bvX7BVD+EsCA5T4La2WmcEcSceCtHoiygPes69s=;
        b=kQZ0Bm//Om6fZhevHFfC05ImvfBhW8Uhwlhf/M2RXIxD30Bm7xFZkI1zraMd2HQsk0
         MiIQUTarFfsdjwv/v0dP4lA+J6BOAwgy5boo6colKteyC9bsRG8m+iJ9XHaiji2smXIu
         iD+XTCh2KtxmJsFyChqKTpMS+gXVf4hBMy/mXNA21NEpOkoGWcThBIVQ8Q13oBhryWfh
         hG2bX7AzOoQxTiEibiReeffO+xvOPX9iZH1wXv/HQiC0OSjYb645zTbzS8cQDcaXhOzE
         VY+cRRA6e5C5C+qvh84YpntjhFDMvdoLKNjkGjuDcYJb76aD1YXjlmL+myXiBpsJCh9k
         K1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218780; x=1722823580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zC9bvX7BVD+EsCA5T4La2WmcEcSceCtHoiygPes69s=;
        b=YMViZEz5jeed1ppi2GpohMuIc31QusxF+3dfkX593MbIsbA4Or0MJdjksltZfXTibl
         QDJBVIAvKIUhtfyBlhQzsEG60A9+8xtmvYv7vF+sp4Vn7O/vHs+w08dsKQFNMRvDg7D0
         kQWqdknTBXQbmf6uHPquy9ckEgM893oSWrRfmvqJdz/QMe/q553w04IKv9+L2VX6/reA
         QIm/j0plQfHrPosh9WAkjp1Q/YEw5CXFNNfmiEUGpmltUqgrRgn7iYkugFh2X3cBKKEO
         b2XkBh3hw+a+bo1uK5+N9WrvlBrpeH4DGvkGkJZGhr6IaMZlQswgGBSwuIaFVRxzImkg
         9a6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSXRZsjV0n4aHiDJ59xliKL1XeRBlRvkNKnR00+QdRxf6vobMX/xvE3gzyoAZusSUSXjGzwcuLJeNyghsj7FcIJ4aJ1FnPl8NxdSNS
X-Gm-Message-State: AOJu0YwSZKmCLb8UhLQdtZQOb3AKpU+aFnXa8NuLagIcBxftwO5c0ieP
	+ISH1K8EP/uk6lYg45SEqDDdp0QLFE7vNloDX35vuirwLNu+fqKXjIxb9Mkw9fA=
X-Google-Smtp-Source: AGHT+IEW6Xosig0TLioIL/M/omR4eYkjl0taGC54ge002DpLWqehM7YTSsgSdqALr/1yVUNNNI3UiA==
X-Received: by 2002:a05:6871:3421:b0:260:f9ee:9700 with SMTP id 586e51a60fabf-267d4d8ed36mr8183041fac.30.1722218779775;
        Sun, 28 Jul 2024 19:06:19 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7120dfsm5873316b3a.71.2024.07.28.19.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 19:06:19 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: brauner@kernel.org
Cc: jack@suse.cz,
	axboe@kernel.dk,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fs/writeback: fix kernel-doc warnings
Date: Mon, 29 Jul 2024 10:06:06 +0800
Message-Id: <20240729020606.332894-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel test robot reported kernel-doc warnings here:

    fs/fs-writeback.c:1144: warning: Function parameter or struct member 'sb' not described in 'cgroup_writeback_umount'

cgroup_writeback_umount() is missing an argument description, fix it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407261749.LkRbgZxK-lkp@intel.com/
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 fs/fs-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 09facd4356d9..cf08f622d720 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1132,6 +1132,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 
 /**
  * cgroup_writeback_umount - flush inode wb switches for umount
+ * @sb: superblock to kill
  *
  * This function is called when a super_block is about to be destroyed and
  * flushes in-flight inode wb switches.  An inode wb switch goes through
-- 
2.25.1


