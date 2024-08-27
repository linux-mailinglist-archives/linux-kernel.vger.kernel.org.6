Return-Path: <linux-kernel+bounces-302779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B796032C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B163C1C22294
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C9156887;
	Tue, 27 Aug 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MkcmwAPp"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0853156F53
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743950; cv=none; b=l31N0EjmvKVjuErWGzl3E/3sok1K6na+Zq/bW+KzwH52xkUPX54BVTMry9170V8tFiPHSqjLzXq5/21wGhahg3JITHDn+5fBvupQJBPwf0tEoOYoUjgDNyG1qvab0V6nci+z4hYIIpit9J29zDsTF3ObRC2TwZLHRTvdE/2SOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743950; c=relaxed/simple;
	bh=pMFMozzUZ5zBXpmPi5bdGsMbcBmWfnDsPgUJzUJ2E00=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=s5nSEPa1AUz3QDkMSfMyaQQe72Z+F/T7SeMxX2TUO4rPYG67BfymjZ8t6JZbXEXi/9RDnAQt3mZAzL6PVM44BoKDaS9lOGR35XMFdyqL2UAY86zg7VTrGjYYiw1dqBO6PZeLpCUG0RGP51KZJUPAiPuXu29alY9OyIL/6vhR3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MkcmwAPp; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724743641; bh=pMFMozzUZ5zBXpmPi5bdGsMbcBmWfnDsPgUJzUJ2E00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MkcmwAPpBYElgjjI9N1Jgkn9ste+qkhf+KTvXjmBXgE6ZBAyw4FyAp7NLZvvm4GZy
	 pAOZMKdf0WFYiv0HQNwssW2x3pbPpO1zWqIbjOSc3Nc1Ko1yjFQyg5eNAw1aLBAKml
	 EJiAAN7CMDJbjriXN9QNxEmzXQHDgoSfg/TUxMIo=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 6D39A8CD; Tue, 27 Aug 2024 15:27:19 +0800
X-QQ-mid: xmsmtpt1724743639t2n551mkc
Message-ID: <tencent_FFC8C6DF52FCC65AC992EECBAECD0CA1A706@qq.com>
X-QQ-XMAILINFO: MQErePhmk1iSCZD+FEvM334IkZW6EbrrLeyGaISM4PXKtvScpSb3r6GKyjyQ4M
	 MFRDE5H1ldnAl+xcsYQ/d3S392H0Ps9r3ZRMclmca+PnMw3UF/L4fsk4DyGZiSTS0v+IVkBdGSla
	 6nvVo16UY7e5KDW//nAx9vfenQ/yPGNYaP9qLk57Wzqnb5X8G4XKIso/hFEsW3TucR0NngvHIPpX
	 diJLZXbK6fAYR92dZTQkdbTFv7k6HXe+oj3qeps1HCriKBdVEGxWa8jyHbnFQ1BzTRJKhzu1XYoG
	 uA2vtqollJ4mZe3x/vWXJLJN+YrtACyR4Iz6+BuwbrV9RYMMmGbLvQaP/V8w6oahyp926jsCXtoh
	 Qlw4VmCVUndE8w2PTckb67/J6u9ZbhxMpr+AZhIBLwhgRgclE3hH3xtUQtCG7Gpp7IH3hExagoKR
	 KsjRBgJciHPfNCnD/5qfLlotCZRg2h0sTgRAyNxhnHQAgljNgm0PtcNqQWawS7qGGceXG53k2ehl
	 7sNV1yODojR95FMyYkBGIFSN4toOOtyRrIsDYOfV+RoNUj0jNlRWbppOAN5ipAmp5DzuzxAPZNxd
	 wP/oSNJRQYYJIejlQF1czYrlTBLV8P5Y72Y6QQgMkzH8wxqnojzGkEa9jl7BlmKL6Pa9fcz2LcsU
	 6iaNB/eeVuqutqInzZdnaf7I5AKK0q1NCFKzPUuhZhIqqqcSopbs2fus4xwaTnYkZhHbSMlAtdMA
	 8K5qa9fTx4mbOkfb+4WU2w2yQ+L2UhIe8eCXJO/jvZKLsECp3gUVToVfgaqVv961xVCM1utwoQ+D
	 EjVg5btp1xTi7A+MYwtcCruEU3Jnla9dNERIoZM/0lFHqEg5zFd1rmWn3wa/bFz0HULPjTbYmU/D
	 LrEc1JygHAbRqLKQx4CKnbCJ+r6ozV1w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
Date: Tue, 27 Aug 2024 15:27:20 +0800
X-OQ-MSGID: <20240827072719.3284216-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000acfa76061fcca330@google.com>
References: <000000000000acfa76061fcca330@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream master


