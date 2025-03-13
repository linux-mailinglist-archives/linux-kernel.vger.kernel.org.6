Return-Path: <linux-kernel+bounces-559591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6412A5F5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80BC19C1915
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6226773F;
	Thu, 13 Mar 2025 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IZ5A4q+B"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B9267707;
	Thu, 13 Mar 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872146; cv=none; b=h6k8YQ56LdxOeFOhNZ09XY1ht8QrbyNhtK9udEtFb3yrelLLTLgWQ+4GGrh3kW/K2eZd17ItffGYdPnnDbB60/iyQR5QC4rutRSZM7tDJybwNqCCNQcw+EQ+vT43G0XWi1xFHjqrfFmMG9AnOEvcUNYNHrjMTZV1EKg5zsASVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872146; c=relaxed/simple;
	bh=77stlr0ita52NJ7FlFXX9D7zVllqObtJQhnOhNvobkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCjNvlyWUfEeiy0obZlzVeQCbuNY9N4npiFqKGEZmTDkYW/y5gmL4/1wVnnj1/xxcvzhNufd6NTY/0HDVMPZHh15GX//JdGbVtCFeABoXm2l5/kje6d126ZnLLQPAsttkKRUx/cnCL6N6jmYYyhjRRzlV9UHPyzAuRknWuUhlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IZ5A4q+B; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741872118;
	bh=blt0kl+Vku9s2fLHnbqr5Q/DXjHGkE6FpDm8QKHFrak=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IZ5A4q+BYjQERnYCxLipwUq1oCAgHgUReecqy/9Dd4QKkDovLxYxtZSm9fCJBkUp2
	 VLgad19S+ebu34CjMQgckyVBGeqyMQ6Dni1EfXV1HE62s5yjbaL39WP29fiL/8GbKO
	 MA2vcDjKc5GLH6ACueLinHL/RgqIQkpJIdIqXjMw=
X-QQ-mid: bizesmtpip2t1741872112t7bffzi
X-QQ-Originating-IP: TUT32WwVuTp9QB3wsBJhx//QSn4Ye/tBJ/AN/XIK8iE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Mar 2025 21:21:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 709180910447328715
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com
Subject: Re:[PATCH V4] usb: xhci: Add debugfs support for xHCI port bandwidth
Date: Thu, 13 Mar 2025 21:21:50 +0800
Message-Id: <20250313132150.3004-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MBMXzRsjWyVxo8QzO4BFbVn94IbcP/ZL/vPiuXORr49LyTGyoMFCwZmI
	+7+Mszt0ylgrmLi1zFp+JkWUODG7s5RBDCc1ULwmZEhgYxJKCOQRpqFyHrf/fVwHcvO78To
	hJYFPE2jOhUpyfI+5OUQSxQJF0NJlAVhbzQq60GuNoUC7+GO9ZJ9/XAs40XujsQ2lngDxgl
	wCHUGuJFs5vk3j8eJKJkP34k3P+65rU/UzAQ7UduAnd0vsdp/JTV+vM33Bs+cyssyBHJFm2
	O8NJwbNhDZEbXgT2G0EUH+yygl5zsqluj3Fl8yzOwis1lfbnXZ9zWvavTf6tq3x5FsjZsBu
	WElSembXRH/ZEuTwjtYciguqz3DhSpmc54tM67GptDdbipuabKch6rDnlayr9PfPTavDXwD
	Q6rdz3hVreS49yC2+CaByTI4u24PaNkMWQFgNOTeN6007agzr2qoQXwvOc29yFY0XOIgipZ
	+iWvnPmxG6hGo4+eCikVdZy0kMlOn0XtiCONQs1pup6r5Rm+2MOJ6DaG9ik+XXV5TeNXndK
	tLg1s6fJn3hkkEK3DMZdXZAIlh7lSjfK2XlCBS3wBMaab8jGFXOesbliKg6lr6pita4GGR8
	qf+mkwyYhZAOHWbXVwGiLLCqZOyROAfOf2HW1TD1jCVAlukrukrSuc98BcNurnjSV+o3Hdk
	sb8u+xMBIp7gmtChnOOtw1fPtM7X3sSjfsA6cXpApZhJGjt7uE0vyx33U5cFVAm2XPxyeUc
	3f11o9gCX19WkgNjq6jbk9v+Kb5jOAwi1yRwZZxr9WDOaHSwQmtPBIsxLkGywYpfRq8a+RY
	iAhsLUkXvwRMcNkSEwbvoA/nMPughnwDf1pPgL5oIi3WNS7gBfKnzM5xB/i4UhevAM5uD/7
	LOkpLGdlPpdhS022ae+ro5OPN4ah9rmuU2bVgFUr4mu05GB8+BkRT2vYkNNwIOjcG7iq4eh
	wO3D6Mkt5n8GUhiJ+Kgv2BuPOcf7xya5xdv6/pa9RWRTbT9B8OejxkNyOiPztktyBM53xgW
	e+vRItAHnUb1YFH3J3KG2RTD+cVFFGe9im012qKl0cozuMup+Z68gMt5YRR+QkUDMblhru0
	w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On 2025/3/12 23:32, Mathias Nyman  wrote:

thanks Mathias Nyman,

>xHC might be runtime suspended when this debugfs file is read.
>We should make sure xHC is running here by calling pm_runtime_get() or similar,
>to make sure command can be processed.

This suggestion is very useful. Before reading the bandwidth. Need to make sure 
the device is active 

>I think its better to create a new command structure with context for each time
>we read port bandwidth instead of allocating one shared.
>
>The port bandwidth won't be read at all in most cases, and sharing has
>concurrency issues.
>
>I'd suggest adding support for a new XHCI_CTX_TYPE_PORT_BW context type to
>xhci_alloc_container_ctx(), which allocates and maps 256 bytes, 16byte aligned,
>like xhci->small_streams_pool dma pool.

When obtaining port bandwidth, alloc a new command structure with context for 
each time.This is indeed better for concurrent reading.

In the specific implementation, I created a new dma pool for port bandwidth 
context. I used the new function xhci_alloc_port_bw_ctx to get container_ctx 
instead of still using xhci_alloc_container_ctx. Because xhci_alloc_container_ctx 
allocates space from device_pool, and xhci_free_container_ctx also operates 
on device_pool. So it is more intuitive to use a new function instead of 
adding a new XHCI_CTX_TYPE_PORT_BW context type. I put the code changes on 
patch v5.


thanks,

raoxu

