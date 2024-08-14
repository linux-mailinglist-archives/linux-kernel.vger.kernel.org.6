Return-Path: <linux-kernel+bounces-285926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76738951459
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89F61C22579
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35B139CEC;
	Wed, 14 Aug 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YQzcg8K1"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BFD131E2D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616130; cv=none; b=sPbXVCKbPxJU4dtfEJhW69q7ZZFPC6QSeq4Up/nrRFlTwJuJm3bxmQIgnaY9aqOoP2sTfRhhX5w1EmDiHUiuEOqtTCYo+JISdW7vMrSrOgUFRcgz1Nc8kGmpn5QRnMhq25BAQzJBRSwSUhCQ2n4QyZK9LOaBkAzWxpsVH1k/uhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616130; c=relaxed/simple;
	bh=RmCkPq2QwE3sY1sXnCJo/x3ZDa73TDQW3Qpdb88iclU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HpcfpYhy4itdtHiiz1uvlGxZKeFQlYH8hqftBVM20ykaD/Uxs+hTRCV1uc/AwlxUSfbMS45Ze9rhs+Fai4jPuEZBD5GQfsYkr+0B6SZQGm6KSBDoHKlGqwiDlqBycSJe2yef7fXebJDJTq0Jj2dpbjlkclbSfwRkLVLNKLRbH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YQzcg8K1; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723616126; bh=Vd36r7lQbv6nYXOkYc6WOC+IDipSdZw8rVIbaVDIHpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQzcg8K15BFaQAXOgba4xMrMbTvvfM37gNhZXdVuQwbeqYNSeK4Nc37clQHgPn6WO
	 85TDjN+I1EZ04OXI19jhw3QrEMnnua4aL3hQ6gQVIy04BllItt6II0Pa6pDog4pEYi
	 68M2bmMZBdVBJv0tDXP2AMxhEthKtYl99mWQL6d4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 78A8E64; Wed, 14 Aug 2024 14:01:56 +0800
X-QQ-mid: xmsmtpt1723615316tx6efirj6
Message-ID: <tencent_F748BAE7BB0A33E19E051BFF4B4D1BE72508@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjJIdlgdGWbpRtNP3ugXQhEvNeaN9QPTyTN8cb+fx+IOB34H/ROc
	 zNf+xUHBe5NnK2nthP6uOo+g7aXn2ZQQ0Eb0Rey4qyGiFLanTuj530cxyXrqFqIccQj7O0GE5+qV
	 eNPWckBmY3B27TBLPx1JQYxfd3r91v9sSfOpnuPpCHtoxyuKJOqLTaEZOcDSS897QumBSgTA/c2O
	 w68cL38m98y3SlAEDatJRK96S0TSrcD1kjWjwlH89OKw1Lxwi1WEoyOeTlFd1nJD5QUKGoFC0qwR
	 j1bh3sdgHaDFkcZZDNkYhNDNhsSOLkPp7b4AKnW/bg9OANbYHKKd8Vi8KJtI1lnh30qpfQBY2/MC
	 7d1Q5yux+sifwQIf/TCUoegXVlUefRaL+ahHhz400z7QMkfJCEI9w8hw1fEQzB/UdZCqapGRL/J7
	 L3GqMG8TEiJk8SRId+JHL5d6ygOQ3o1j4wlTqaSJT2tiXX1TcXC8pSIEqxB42SQz/WPUNy2C4vW6
	 K3ldM4ri3LiuCy16nMBk1Jv4UVYrYmqUcuXvk5i3sCNnx+pXyn7huvG/3q8ziPQXdeER5wDKmxSp
	 NbUzQigGpQ9L3nd4vu5L4qDTt2kOTadi13t6c+wnPtR/AtdMsd/tsxsOmmvDxq//qQcGsfVin/pq
	 4MWqaM3VNb4ANuoTiZzdaTzcc2NINk52M/UH+zTBRKkFvLxVcS9ZMkoi4hJ7pzW7onPZpdX75RJz
	 Bmu5oVWGdhUBqp/sD9TqiyyS2kbMsovbr2jL6cFFOC8ml/+4GU0pe95D1hZRI2URXlx9Z5oVJfda
	 MA9e8M+oRjvmBikd/pq4+FRYEEk0hJTkxBhSbPLxxpuGK2kCGBz9k+Qs+yHoy+DqZ9Ca7HLlqjB7
	 fiwoLsI7DGP2kRGA7YmOqinvvQnAIsvYOvzUKj3ChMe7Jt9/zrmJJpwS9IaXJvwU8MYT8xIiiYEN
	 QxxlrupjItoRid4sZFOm6RyvzPECKVbCxEQbnxvCAGQt33exPNnoUWwsbKdjMRrkHxrELtRZkWmz
	 KYYf9zVw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: chao@kernel.org
Cc: eadavis@qq.com,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+78ff2855f26377625419@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_commit_atomic_write
Date: Wed, 14 Aug 2024 14:01:57 +0800
X-OQ-MSGID: <20240814060156.827415-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <02214d48-6aee-40f7-9a40-60b4091b5bfa@kernel.org>
References: <02214d48-6aee-40f7-9a40-60b4091b5bfa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 11:33:32 +0800, Chao Yu wrote:
> > unlock i_gc_rwsem[WRITE] before quiting f2fs_commit_atomic_write
> >
> > Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
> 
> Since original patch has not been merged, if you don't mind, I'd like to
> fix this issue in original patch.
Okay, it's a small matter.
> 
> Thanks,
> 
> > Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com


