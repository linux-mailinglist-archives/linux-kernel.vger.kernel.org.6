Return-Path: <linux-kernel+bounces-262203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4028F93C264
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF392B22CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABE19AA6E;
	Thu, 25 Jul 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd5z6w/2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AB19AA4F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911842; cv=none; b=Mnjyb+31dMg1zUDa/tUavz0Azb+H5TxmCzhO5//qRYi8hIssZX8K6jxlBwxmFJ7/eQROO/3n5PAIdTndu+dvhG90kvrOiLk3w1hj5izYd+QZeg5z3eq0GPxBMYCisZ7NUR+8QpNZc1CZW62K9mYxnqxqhi4+oINcyFs6Jyf0Xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911842; c=relaxed/simple;
	bh=u/n8FIBqeUNFl3zfbTvcsodu4bW5c400cD9afKq/9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnjrH1SyZIGdUYSXS3nWZya11Y4tzUhSh2DW2qqYriphNe0F9a4YBJI3+SrsKWZLKFcusxn9GmI4+wfb9HYaUM6mtSYkQQ8TwsP3I6QzIEx+vAV8w5kEijGFDSE/1CP/5sXsQkyOImnEcrCiufEdiyZPwueoRx4Pe3raTEjAvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd5z6w/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721911839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aiC+tGdGBJ14JK0EM+dRzM1914+RfFNFtqMWibxNajs=;
	b=Cd5z6w/2aesYuR4WUSk5d7F5Aan1QEjh59wEYBtLc7HyFj/zkjOW8oxbGdUtbYgH6Tkpgs
	WFgq84EbamY2Vo/XxBTbwfSrW4FFa5pkE6LsqCky9cbBd1kiq5kgaMnsy0bjKrPMj0rga8
	ErUzmtXy6MX0wxFhAekWIFT7siAg4bo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Vq2WhVMOOfOwprPWSW2E0g-1; Thu, 25 Jul 2024 08:50:38 -0400
X-MC-Unique: Vq2WhVMOOfOwprPWSW2E0g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36873a449dfso1017148f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911837; x=1722516637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiC+tGdGBJ14JK0EM+dRzM1914+RfFNFtqMWibxNajs=;
        b=ebypHshyG2512gxxNmg6P0pYf9O+t6OzIJC1OPYh6TryqC0fT0Y8Amom1+eeD92QTN
         pdIq77MeRUQHHuS8e2fblfay/RofdLsYz5YIwwfS0VRIubeLFZznxwgi1jyAFk4/Nc7d
         O0TvlUPoLP8uHdbFEsiF3pTPwUAQRMQKRCX6kF38INPKmL8+WBKqp5Ty2busrMzP4KmO
         a8qxCdvXFsh2H7nZs/uspYDoMPb9UKlKAIcAyCNv2TquiSN0Voq9ESZofaz4Ipv4YxKR
         sjLJ1hDZStU8Md1lvAhRVBASl1OwLkVZM6527MVmBV4MEN80u3vEa2kXBJ6RugL4skDh
         cQNg==
X-Forwarded-Encrypted: i=1; AJvYcCU8uAlmV4kt9kxeqDAZ0EwDKgj8deuGkgJ5AjR23ZXvxbma2gic74uVkzTcKyCJL5Z7c5Ebfw8R1P06hyoDyF9EpX8CTrmrd62x1pTf
X-Gm-Message-State: AOJu0YxHYXjEWyMRu/UIfPKKjs/rRvB4F8eTOWbrglpDSzw0cH0kFr0T
	TTbXFUx1tr/XE0GGzTNggGN+AgyPlZIl2uqN7oaQqp0+LPKnzDb0W9CHT9oaw9NQOzGiDZbLH4r
	/OwIqyjpU0kBADo/A76a0EIO9rzc+g452sHRrSJLqnPDlpnCW1nYmdr4Jdzw6qmXkLUs1
X-Received: by 2002:a5d:6847:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36b31baa861mr1863124f8f.32.1721911837190;
        Thu, 25 Jul 2024 05:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvNOfiyZLdndMxewqoDL+v5f5t2gA5QKku5uTpws/6FD57ncMwj1yC6F4sK8Meatae3pXBHQ==
X-Received: by 2002:a5d:6847:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36b31baa861mr1863099f8f.32.1721911836736;
        Thu, 25 Jul 2024 05:50:36 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9393sm2092301f8f.26.2024.07.25.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:50:36 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH 0/3] Simplify and improve fpga test suites using deferred actions
Date: Thu, 25 Jul 2024 14:50:28 +0200
Message-ID: <20240725125031.308195-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use deferred actions to simplify fpga test suites and avoid potential
memory leaks when test cases fail. Deferred actions are executed when a
test is completed either successfully or unsuccessfully (e.g., due to a
failed assertion).

Marco Pagani (3):
  Simplify and improve the fpga manager test suite using deferred
    actions
  Simplify and improve the fpga bridge test suite using deferred actions
  Simplify and improve the fpga region test suite using deferred actions

 drivers/fpga/tests/fpga-bridge-test.c | 25 +++++++---------
 drivers/fpga/tests/fpga-mgr-test.c    | 28 +++++++++++-------
 drivers/fpga/tests/fpga-region-test.c | 41 ++++++++++++++++-----------
 3 files changed, 52 insertions(+), 42 deletions(-)


base-commit: 3a0fa8e97d3024de199634667900b6a90bbe43d0
-- 
2.45.2


