Return-Path: <linux-kernel+bounces-187473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E160D8CD24C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E622811D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90DF14532F;
	Thu, 23 May 2024 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sNyCK7im"
Received: from xmbghk7.mail.qq.com (unknown [119.28.226.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71C1E4A0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.28.226.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467589; cv=none; b=gs4EUaI4ZZnt1oawVIgw0YWqN16VMwioZW7rXvq+tEDEd4mdcWx5NVr92vH4dJUdjkDvWFsHCa3a+h79jxbAZyfnx6JeKxl+TF03Kc4H+6b5jGG819q3fbCS0Ymlix5JUC3eSTPSMmg3Axl10zwvhRz62nx1AQecUPOOMiNfLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467589; c=relaxed/simple;
	bh=T2fdgUwDNDMRL50T8zzAADcHikCQSCG8HLFXinXkbTw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kj7Gpw3RADsZi2qEt/jGaOMF4iB05EYtmzUkH7074P1VXsxx0GsDQmSr2+1zvFx9uAWVXrCpLS8hlSxMSUgD4uz+KiBC/qzI5U+RZ8jRu0aIBgFhRr4LHiX+nyaExyotvY45fXJUNcSv0UXrqgujOxIHmQIJdjp7VLgO0dQdrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sNyCK7im; arc=none smtp.client-ip=119.28.226.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716467583; bh=J6sHfn6RH+qDQKb0lsUEg9o/MFFO/EwgtFVr6vda2n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sNyCK7im51Km0H9bEx4LlHXuGIKtB0h5kb/f4QlI+GCsmuzZlmj+E3S4HMJMTp9bX
	 cUeMgf40icsC0EFD1vogkJGkEp/cciGI08HJ4tsGfeSuGH0C3yC3OElfwjO1OLD5ph
	 8HToG/oa5S83T/DeDZS66W47GMMA4by9VOPrc7x0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 8412D8B5; Thu, 23 May 2024 20:33:01 +0800
X-QQ-mid: xmsmtpt1716467581tp7i9fpk3
Message-ID: <tencent_4DA6DD13732376296683B4645AF76CB76205@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxyC+pTlSW8/snb40yqqIuzuhqQ7RHd/ia7LiAK+tUSkkFiQVQBx
	 jcFCwKHRmfmDaDWB0WcnHi40+BmoY+RzJrhLWeqszaQ19ho2v7tGm79sePkTiXcQFUXlN6j5WP18
	 MuUWED/mGj0HgfbMxpzsiakNQC6fGnTovf9qNYl4EfKGY2Al95abTZLPJicFgy3y8wLqbwJ8Rdhc
	 8fxDVDffrJNFJVakdeqWmBzkMMFifCsuLyhP76FOyFH2m1emrfcceSsWOhwQlRKPrePc8C4tEmTN
	 EhWSeiMJ9HMtmj3iMTtoi930efx9rFz6bmzNMfu3GlHDoh3bGzuAVTYkvIdpWRs1nZ/+qLkXsmCN
	 NX62okWRhNbzT/Vwp0yX+/WzrDcqBHFHeKddsf4t9J5T/oWz5I/GdpMyQ+sFSKF0eALibL0PzJlB
	 wlATB1OTBPlJg7Ziw9hq2h2EjOiRBx8bsCRDJknV+qDRXsq5emCDwZeWgXWPSa+CKZ2GhUHcTpva
	 rbrBNkttghfMYciC3FqwC+O/PC9AprPEQON+zyGIOBZOVUTtgntpxYEBiA2Lc1yImXT9AmPb0Xqb
	 ICDoJlgqeHBV28vayGEoBJ2fM7AI+Fdl37C1sNetdF690T1YLMiUae1fs4FYP0AEdXpaXnqs5Y3W
	 AuUZzndy3WQjyoDdUSlWh+x7Vp5PLuLp+pODsILyPKkWLSggb1tkiLDKMSdU+AaxvJ8boNBo1shs
	 x8+3NXE9JCNOqO2vvlxd23pcxVbzPMdmmbxjNUPxVWTcejiMa1iXjS49d+quFEPu/6CirwSpjpLG
	 sjBzvuLGJ8ahE1+M5h98itdqmO5jcQ98d12t58uzxzvz7y7WmnmIzFL50i36JCcA9+oK1qoG3CR7
	 ihLS62jFmilUHml9bc3LH2Xx2qoTBHGG1ilY1gcaIMLRgtDWYEaPDls3vhNNoucXE2b1dBm/0O
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Thu, 23 May 2024 20:33:02 +0800
X-OQ-MSGID: <20240523123301.2556480-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
References: <0000000000002fd2de0618de2e65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr in iter_file_splice_write

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..a38709405e54 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,8 +751,16 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			printk("ret: %ld, nbufs: %d,  buf len: %u, m: %u, t: %u,ring size: %u, t&m: %u, %s\n", 
+				ret, nbufs, buf->len, mask, tail, pipe->ring_size, tail & mask, __func__);
+			n++;
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;


