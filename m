Return-Path: <linux-kernel+bounces-524913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA1A3E8AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75DE17EECE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED32676EE;
	Thu, 20 Feb 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l+ErdpT6"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8926389E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094850; cv=none; b=iDtc0g+uoT6YR6wh5l5unyWooOlOwlmcZRhADBoV8BQCvaw5DsZuAdH5ZGsOfXallG+u2l3jvlEdy/t2xrg1E+aVc/gCTzPu3vCPhyfR0/ZaqY+tC6St7Hg1qvs/6MWkn+cFUTmBrqmN/reuMkPIPyrndmsYR5T3Zv4vL46Lrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094850; c=relaxed/simple;
	bh=/eAMc3UR3kjJf3NPEKw2BvpiegPPiUL7zxp0YnBFdPw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ooDMRIHYXyYKP79Nkx0dqTFY8rJOfc+YwuKPp7ya62hdYgxyE2OWXLUYxHLGiv7mV4qcMi9BARpHr+Yl6v18JJEv18Raukv3M/HeOhqf+uCMSZ+eEe+Y43BmcHQyElnPtWS2bZ+YamSAysL5ChqhPzEcutClSm6YJMu9Lj8HRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l+ErdpT6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740094541; bh=VLDA73BVAeJVMPeUhBwuP3jCY55hbvalaLQ/p6JAU/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+ErdpT6uthv/160RYD6sbQ9NAPg2aNgpajEjIUl/gzs4WaxZR8hIfauWuKCVnXaI
	 EzL2AJwrwlgYQikEN51EmsTYtSX8jQsig22HxR1adJRMIJabmZjLflYIebX1j9Rjbd
	 pfEMefwoMlhPVpwA16/7nUT7kCHlJg9h3BdsX4HU=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 74311CC8; Fri, 21 Feb 2025 07:29:03 +0800
X-QQ-mid: xmsmtpt1740094143tmmwp9vzk
Message-ID: <tencent_A5A3A64447B765576B46C09365A369A96605@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zkFhFFlQicchYa4SqsFxX4R3T5UzD3XP93iz/Bj7Lyw5RXtEWcH
	 z0Zd3bDxOgL9B7glOSSOKdDxioh3n/ffLrebm1LFgfCpr0C5CMGW91TuOxNMsoqlY7Bc9RO/Zj/r
	 o9oIkx2BVsl2DM22ngrbIOD3OzOw7OF3JZKaiw7RVM2hVpkkOuM6FHaYxmVMGbHk+8XBjfNWgOPf
	 ivjpyD/TIhfXCp7tup4fo5KZkDH4YrLvLibfWYpKFgeTb19HF/4fgv8o3fRyuyK+q7hZVIeC3DdW
	 +h9CXUzy61u0V4SZ1Yg/KfOIUCRX8tuZ6TQQjkdgDTf2p6jHvTap/fqJYapkdsy/8ZAxpkLNrRAl
	 YtpVMhVfyGo6aA8aNbMkcK1b6FpL1RFNxx9jYhSc2Iv8n93YqXamqTLnQmQRnDhw83RHLKnV8WOK
	 IzO4Q7e4vUDVAZDxXMr8A4hn6XXdpKifJ43omlQKVsQ52t4Dcls4aNNbQjSDKgiC9b+2LuX8oCmv
	 VrUyi6yE+3hkqmimC8XJfmgpIPGsffCfUbbiXlSwVC8Qf22q3rv+K1kcB0jLH/2F9qoo5IrZK/lG
	 ucMh6HzOswdHGXIeniKt4DL7MJ88WwOabxlczAKb2/+wg8S9Ms26q40ltZ4tWsZP3EAheKHYLMCz
	 1Z0i02H/Yl2ZatJd2wh4P2vq1iUqRUW/tFig1zjC3U7cmOl/V/KlTBwCURCac+96Z4r2kh2/irQ/
	 nhBhQp+lNcDVMxT4s3LxspKTCKXZHEZQsA5LLRkp6AQsPa8TbyIKSwz4csH/igV2tY4Q4Mn/CHIo
	 q5rEYePJrv5pqESyvvHcv9EAMb/4/eoD3Rw7qVA9UD7mAO81OJRvdBUzWJwN+0Gy/G4SLmDppPpd
	 V82tT1THDi3/NdsNMIv+0kgElBB176Un87oBnEtWNBq6V4hukZWKxyhlA/bnz8I1NGHrSXVLI0lS
	 MB0KnbxQbXNJDNd/oE1w==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] jfs: Initialized first 8 members of the dinomap when creating imap
Date: Fri, 21 Feb 2025 07:29:02 +0800
X-OQ-MSGID: <20250220232901.2483093-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <4d47e3cc-d1e6-4281-9a7c-463e6fb0af62@oracle.com>
References: <4d47e3cc-d1e6-4281-9a7c-463e6fb0af62@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > syzbot reported a uninit-value in diFree. [1]
> > 
> > When print_hex_dump() is called to print the first 32 bytes of imap, the
> > first 8 members in struct dinomap are the first 32 bytes of imap, because
> > in_numinos, in_numfree, in_diskblock and in_maxag are not initialized when
> > imap is created.
> > 
> > When creating imap, set in_numinos, in_numfree, in_diskblock and in_maxag
> > to 0 to prevent this issue from happening.
> 
> I appreciate the patch, but I'm accepting a different patch to fix the 
> problem:
I am very disappointed with your choice. The design of "KMSAN: uninit-value X"
is used to find improper data usage and defects in the program. If you directly
use functions such as kzmalloc to clear the memory to 0, you will lose a valuable
asset--KMSAN uninit-value.

BR,
Edward


