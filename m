Return-Path: <linux-kernel+bounces-258091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2393835E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 06:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D81C20A60
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 04:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50B3D71;
	Sun, 21 Jul 2024 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fHOJYcZl"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7791FBA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721537792; cv=none; b=tgsXOp0aDEDEYDEnX6G5Y/hrebpp2bkh30ismRLklZNw4gRpsRG5GELNh93YnQ+ley6uA+mPhpwUGJ5IepzYFfu3bPhjDlY3t0ftw0RmD+cPdRT7pZM9FClF/QQo9sLWSJuAodPJjYvfbybWUTMC1BXBr8vjx8HdSjbzkpHBuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721537792; c=relaxed/simple;
	bh=5SEk/Kdd4/vf2LP7C2oCu8/OqufPctG1C13bcmCFie0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PTUolh24wtPUqRwC7RGNnn6fw2QSj8JEa9e/iOXlKtqsgM+2ikpRE3EeiYYikpN6EpxM3dFI6KtUgKOuDZKve4xif7Mzg0O0Aj/a3PTvaKDG0zkUFwdg1kx56FqzVVBLmYza1C+Folp522hExF8TrGPiPOq3PuA6IQTYzc2IZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fHOJYcZl; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721537785; bh=wj8LB1leJPoTbq2NuDgfi09pA677pBvKP/TSP7gJD3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fHOJYcZlgLVyKqYvB1RdO4mwQ8a/jJSLQ1UdSOnlHhpwry10g5VDoXI4nth/SXpcl
	 fV+HXY4GrbPFhujQT135ExUFMGO792T4blLlnVfZXvSHZVlEKH7Wbor4vIEvA1otDm
	 B+wlj8l6NCHZL96thyE4xgRbxTUweTC3SOfyvwhE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id C8F87435; Sun, 21 Jul 2024 12:50:15 +0800
X-QQ-mid: xmsmtpt1721537415t55iyvuz4
Message-ID: <tencent_9A6EFE8CB8A7FC86C992CAC6744992EED206@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWfHhVPAy5cf+mE8HWmuoGD4QGqwQZ9m0+y7sSNli4tnBkxO6/kOJ
	 siqkZiJVuQlhwKPEa6fuXV/svi0xck4Xi+raOK6hm5mArPx6ABnH4Rj7yotybnyVryFZNal+UlxW
	 RLoBo64IuFhx24E+bucCp4SqtJPyN0Zn3KPTF6TtCANNhHFOw8cNBHXUWrzCJID0EKUzgtCcfXRC
	 IWuZj1b2+KFqXkOg+9j/uGBSV4Qz35HESl3eZhrOO4LWQ/Cc+ogJqSF+kimVycSKNBbI5HZW4leP
	 5PE+n/eprI9rcSOgI8hZ0YDzBCNesWvB421QI/ADtGjF5hjEF4fnvtzZ6E2h3hvQ845lhN7AnMZ5
	 d01QGaQ7LQjroYEYwY/0mz9qnqtARucFTDa4iSkVGTEjl3xOD4j66bvTuuBMdDHjHkYlU1lfLUTm
	 k8AwccTSfhN1P4KxoOnFVYwfXI7DD39C5SoLm5buy0W9Yv37XlUF4G+tiTFLcMQNdvn+RWe8Hjz3
	 772FqI0zMGYUtwLKRgVcJM4hbE00Bg4m7i2LhASbLid59BwaDxDBzi5K0HWNcCuphXdK71+aDXCp
	 dUTC6hWcJQkW7d1Z+sxSeAutKLvK/xCIgo7v/abBOYvVuquT/LiiuC6aVfIiUnAsizecVASnIsvZ
	 qm1HrzJ7FyTp2lDUejggrMBMNXQLtaaKjyQkKZTL6z0BRPd8VY3Jdu2NVNJkkRpwOGNw1fyzJbxI
	 9nmr6bO7y5j0eDUhL+J55x0etCe5Jmdu8+TzQh0lf0DXlImy+ibNjaQkv6eLHALj937Gc7qzsCXN
	 5gOdhHTUOuSifFAN9uVodg/Zxa+6HHvD0dR0Fir4545ZJu+Dl+Gp70syQa5YtJj/5EUBzbs1fjp2
	 I6wpErBECa5aAjlYmuSl955OZ4z8vlymdXqMkhljFB
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference in path_from_stashed
Date: Sun, 21 Jul 2024 12:50:16 +0800
X-OQ-MSGID: <20240721045015.1589206-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cf8462061db0699c@google.com>
References: <000000000000cf8462061db0699c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

time_ns is null ?

#syz test: upstream 5e0497553643

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c9cb14181def..fdae58eb1d98 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -168,6 +168,8 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PIDFD_GET_TIME_NAMESPACE:
 		get_time_ns(nsp->time_ns);
 		ns_common = to_ns_common(nsp->time_ns);
+		if (!nsp->time_ns)
+			return -EINVAL;
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
 		get_time_ns(nsp->time_ns_for_children);


