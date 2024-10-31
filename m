Return-Path: <linux-kernel+bounces-390608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF89B7C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33A0B214FF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242419F121;
	Thu, 31 Oct 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WztWiuBH"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540319C56F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382749; cv=none; b=MobyRD82jmgBAzM3/NELzM3W8rkRPdNDAd9xohAQ9ttdghc8lYJC4H67By3CgP2Ektr5W0NWzhpqyIMGJ+9B83RViRZRAUcjdbwAPhmdo1KUIy3/AD/ByEHGBAje/KPAHALKW0OayIdMdHO8Rp/Bdae2ume04HHrYBcdwZNa0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382749; c=relaxed/simple;
	bh=d9bo/leiWKK4Lfz75XOlp2LHJUWRf54pTjS8GJ/2bHw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qWD5w6R3lzdsqU2kT0Pzdv+6lwCqAyPoZaoqvHb7uziOiZN+uY7LEoShsmqRax1EzCPFa72pqjUgrjFOxashaEBIDrZEpXSrtTGU6hrFd+YJkT3qAQ0SpR2Al4B0vPXEkfo2qdZH2M2roMZjsu0FxGnQLm67emtiPLCt7kLBxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WztWiuBH; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730382438; bh=UBhWuve9CH3xygtxH+PeUxeCPzY0HUG0tzHXpaHjDNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WztWiuBHmmNw2ON4jmW4rJbcpYz0mGd2C7vA+YCd+8FoZHjkUWPR8bBGu0Np9c3vR
	 10HFcE+c1WWUnNJQP4p1iaQDvri6KtidL/6r1fLYv5ulmRC8q9fCr1thz5+Dao6ong
	 FZJnhkYG+wRKBImErpKshU8WY2QMT6O6rNVA1k2U=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id BD024E80; Thu, 31 Oct 2024 21:47:16 +0800
X-QQ-mid: xmsmtpt1730382436t7266ubf0
Message-ID: <tencent_63962A37B84AAC7481767167DE3C67373009@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7Xb8RikqmNW552OB7LOglQchpNESHQtldo69rHNIfeUHyZM6ud9s
	 9Af58zrZDuolhhBEOFS4V+nHGJbsaShV85THm8O40DennruScAgUqvxI6wYRCWjD368DzGQeBxJn
	 mUKYiHXDNXtK9eF31Dpv19FsB4PIgADoP4XdRfPvajkWKUeqmwHF7fh4Z7NLxR+l5di2kL/mKhDJ
	 VPL2OUtvd6JtBVgrXGCmOy7Oe3Cvj+Vv+JdpcLyoo/JiX4l1/68MnWvwd49avI+OWAqDbNPz6txv
	 mHUUiZ/1SIPHKRusiYUWMBYV8wk6BDPe4+SHUgmadJoZ279Pa+W+8svmScTwjp6q5nhw7SEXvckI
	 bnNKUDbKpHYB37xH2WIBz13E/vR0Nqe/4OuTh80TVm9YqJng0WRz0XPYKCQQZ5kL0jcO2uaxHl+e
	 3UfjBlBEVzW66HAtQbI2P5pDmBKK8imnikODztur+kyPq0spT35qaSBkhG50QtGrWwx1IdZtX4zr
	 nAQ3HalWSVxpnrL1Bm9MorelZYjLz3LvxOaZuhp7xIYCuISJOG61bccsUXyyrAOPPhQmZn66Q/fp
	 qiLXn51R9FVK6c3sd/PV0gkzzhs8xDodGb1Ujvf2dIcqC0ynHJeBpQwYobvFR4aTPEhbLb1M+W/X
	 GKohqTN/Lop9+DgjDAtPHDn2hKEuhB945pP8W4XloGOvieu8qjEoTXd7lI6e1jBXGgH29z06ajoQ
	 8JH4k9Dev9/5rxicaGNJK/rSyl87BlwBUElF65v/xpRelgHaOfRfQi6ybi6FLijXHS3uQgDsIOqZ
	 KFHqiPflnwK0lK77yF4y8jJYQyatmmnHYSwNwnsl6XxwWRIw0WqKJaNsOBQNqNjuBXBJ5Qjnb6bq
	 /dpXxMQ+djQc2Z37HeMPQ51/v9VKja7zGmAI1S9Bl5wlA10uoo52/e4fQ3BfMM4IrZv4N1eev4
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41ebd857f013384237a9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KMSAN: kernel-infoleak in pipe_read
Date: Thu, 31 Oct 2024 21:47:17 +0800
X-OQ-MSGID: <20241031134716.3906258-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67234aeb.050a0220.35b515.015a.GAE@google.com>
References: <67234aeb.050a0220.35b515.015a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1abb32c0da50..59832f73a4f2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -478,6 +478,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		}
 
 		p = kmap_atomic(page) + offset;
+		memset(p, 0, n);
 		n = __copy_from_iter(p, n, i);
 		kunmap_atomic(p);
 		copied += n;


