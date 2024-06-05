Return-Path: <linux-kernel+bounces-202619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAFC8FCEB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B011F2AA0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67211194AF8;
	Wed,  5 Jun 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ut5Si44E"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3145194AE5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591137; cv=none; b=VQaKkWoqj9y9TSkbF4+lBPKwb7aZbCHENH+B7xzWYKDpPj/DSvZRBmXSaI08jEMu8h+7Ygm6tK7QHw3dP5qrnqgnwVz89G1OYcJX0hvFUBl8fL//jqcpJIQCeih6rStnBzr/L2Z/9Kg6Jb7vNaI25uFlyQtQ7Co4suWiUwXUqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591137; c=relaxed/simple;
	bh=vHjBhRRk1bqVDeUvgIQaTV89PPxX09YJ2R4djCJ48Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ac2GMfcAdn5UYEK5F8rqxsYf7vac3ck5fj3Iv7DWzLKoCl9zymw/WRQZJ5WTIYrY01T9egGnTo4f2Bt3L8rKtJPC/SC9wntRt0TIpDV7v/LC3A3tTsCHNS6SwaFrfTNf+PCvJvUepS+0y9wj6p+4vNS3LO4FVCkvizX/vIZeGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ut5Si44E; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MmUnh
	78ZTKHdDDoSHHc6liH2wj8Hy67v/H1SpsAxo9c=; b=Ut5Si44EP7p0Xjdvvv9RB
	OivJkbuHZQuBGpDvSFbZxbPV54ogScUxTZ9FQq0RBsiNumZV6ShxrfPAne5ijei8
	0x6a8SgCFwlhead5wEOrN38JDjc+D5bYVE/BrmL6/QgMGeqdNe3OZjIupM6n3lVn
	KENCcK4H/U8qTIC+2ciRQ8=
Received: from localhost.localdomain (unknown [111.35.186.64])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDnN_b2W2BmBlI9Bg--.32380S4;
	Wed, 05 Jun 2024 20:37:14 +0800 (CST)
From: David Wang <00107082@163.com>
To: kent.overstreet@linux.dev,
	surenb@google.com,
	keescook@chromium.org
Cc: linux-kernel@vger.kernel.org
Subject: [BUG?] memory allocation profiling: the counters are not non-decreasing.
Date: Wed,  5 Jun 2024 20:37:10 +0800
Message-Id: <20240605123710.7396-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN_b2W2BmBlI9Bg--.32380S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcBT5UUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hz0qmWXyLVwnwAAsw

Hi,
I was playing with this new feature of memory allocation profiling, when I plot the data, grouped by caller's source dir, 
I noticed that the counters are not non-decreasing.
If I understand this feature correctly, all counters should be non-decreasing, right?
Or is there some TTL for stale items?

Following is a simpler script demonstrating my sayings

	$ for i in {1..100}; do sudo cat /proc/allocinfo | grep " mm\/" | awk '{s+=$2}END{print s}'; sleep 10; done
	1194453
	1196935
	1198957
	1199716
	1200770
	1190795  <--- decrease here
	1192702
	1193070
	1193812
	1195069
	1196491
	...

FYI
David


