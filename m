Return-Path: <linux-kernel+bounces-285689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F2951155
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417A5B2114E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55BBB662;
	Wed, 14 Aug 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UimQfpOT"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28EA953
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597324; cv=none; b=nDafo+vqcrJp8oyztRfImo9fqK4SoSsHDXMJ2acHAXNnQCCNKfAU3S7Ql7ir7WtbD3+nKYYPxcPvoehxlM90pSamHcYyfN/Gcs8wT1/654lUiQ6rjrCZzEq9m4J3wr0l+oL3xHgiihPKdnJw7XVeLny/Aov//2c6SaIOeAWJsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597324; c=relaxed/simple;
	bh=o1zvuyQHQbhqIbsgFb5goXzprR6YoWbIlH2Qs2aZ4uA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mWbiPBkTecqZ0KJoJGyIrf66mlGEA+4ADpS9PlUxtPsU9fEjzrzGIj/OGz090DtDA/rcN9FO7XQMCChzl+Z313HjNkmg/w+kWELTQbHQZHP6HCwb5TDLO2wU1r1o7khkhYrWyCBMuqSILUY5qEBk5cb3yoPb7Wolxe7IXrAxzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UimQfpOT; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723597311; bh=VxSJGLo3yAH3xdSnAqMQU9UizTBDY+DW2zMwtvtfbco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UimQfpOT6wCmS9zleSn8VHKvg60TPa4HKn6euvLDl4CsT/U223RRx/90sdGL51tnP
	 bYuH8TyK9awLQD3ukbREEx2YpzBq7uTBlSc02q6H3+qQ7B62rRfDsJJ+nEpSf1F9Bn
	 4rw0vaq4bErqzmjMrqtd8+7Q6rUiJ7PWYl65GYOw=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 7119216; Wed, 14 Aug 2024 09:01:49 +0800
X-QQ-mid: xmsmtpt1723597309tqfijnh9n
Message-ID: <tencent_001B304B341B3D2501BAB0BB2733509E6A08@qq.com>
X-QQ-XMAILINFO: MAehWEgsdgwGIgvypYFLTwKqARxrWX6UfNIHc1ZnVRviFwkZ/2xhBZkOKLAXHI
	 nP9izsoqiqrEYjSKumoc1lQ2oGbr4+8jl4facJCwTDMW9/9FjXGi4dGXxU8h/QZ11mMVnh5gFCLM
	 h1aDVS2PXOn7FFVGf9+2mc8tYXoenSnJMX1Jd0MBRmYWfivtLyR+f4HiXMXkl31fzt9LYlWNrnZM
	 NS71nRrdgBxGNStJCnJWyQl52VKp5drAF4Bsmzhj0sNvet6W8zID50FfxDwswXQ9igwCiwbCTHEN
	 C32+M0IwhMDYn1YKCBRDCDD9RasPZGpvfLlkRI+3M7iFuuKSeZhuplcFY/ptDZxh7nVIHnWfCky4
	 5LcVRze06iTi0ruzmaQV3uNiE9Ad/ViGq9+CJDDzikYsJWEdYu1PcSRPyqVxnNsUBT6LKkW16Gx6
	 sUz5aT1GxkxW4sUl3RUATVHE7KSj3l5cIxHLVnpy/oSnsyDLvnVfc3qii9gO4n5ALZssyIGSYWmu
	 SYHwUBaFgF1wykUK/0AihwDvQavQ4UPgyUUc0AmUTVw0UuhQgC3sRtQJMs1kNIs4hJDQeXgxtaqx
	 oq2G+dYPIiKObIBimBLOE3MyQ4PtzlnWoOSc+AlT/JiRofeDl+G5P6BJqpgLGkuWciGSq5F5qyZK
	 JqkYSAOfBmUVMRZWiJ2VTQlxpzDzxV259qP1XGZ5vtRU3GbYSoGa9x4KkEeFceWVj0awWjRCbWQV
	 yNssrWVSN6YRPMukkYsrndIk6ATdllnaC67xbX63TsbN4hsRXzDCriyyZ2DTRXJiwxgpef7RmqJI
	 xmnGS8760cSRe5ALDtHEA+MsY1w2O8x4vWGvo0G0a+xa1NoX4VtqMXZc0P/ooptVrAG6g89V7Lfi
	 lbGecUv0KGZgDmvnWlp7tNXGhWC9vr3xBUmolUhci29J0SlPHRyWiJ/F+yOQ0grfycjYjNW66aDM
	 N/fdIwT3p3zXhmLSFUjg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_commit_atomic_write
Date: Wed, 14 Aug 2024 09:01:50 +0800
X-OQ-MSGID: <20240814010149.515580-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ebae95061f96be85@google.com>
References: <000000000000ebae95061f96be85@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unlock i_gc_rwsem[WRITE] before quiting f2fs_commit_atomic_write

Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com

correct git tree to linux-next

#syz test: linux-next 9e6869691724

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 741e46f9d0fd..a43054ab0cf1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -389,13 +389,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 
 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	/* writeback GCing page of cow_inode */
 	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
 							0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -407,6 +407,7 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	f2fs_unlock_op(sbi);
 
 	filemap_invalidate_unlock(inode->i_mapping);
+out:
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;


