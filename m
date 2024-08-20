Return-Path: <linux-kernel+bounces-293095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2569957AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613051F2183D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799321171C;
	Tue, 20 Aug 2024 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/kCvvjJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5478DDAD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115849; cv=none; b=dfTWj768qMIoVklmW5nC5SSfFMCQ74o8xJhGtF9diNnnWjsQyO9LlPvkpCVHG+yDX841Omjg7hXfNK8W4xGkAlhgdt9WaxEIldcg26owNL/On38tfOoKPRqE99V/yE/9Rf0GO1osMXk6f2B6awrLQmj+ZhQ+xkbviKc4qG41gU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115849; c=relaxed/simple;
	bh=rlvDPXnw7XS8R0QQespbZ/XZfErKbFUB0YyUS28SphQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9WqYS1rdxhZ3eGQLBZOPwU4XygUPMeYvpdCy+GjTN3EyoLKlqTfgqEguQKMC5ru2pdFETwi9IrAC6+EQKmwNEdTMVhpemHmYt5KVjc2v4CHZJaFg1dJbaJ6X1i6bmKZO1wMfCGVUXh2MJEJS6hg2HHVWSvG8nTYVQffZOH7ws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/kCvvjJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86464934e3so46038066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724115846; x=1724720646; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UACsmobsUd8Y9iBIYxx+ODamTggideAg91GBgxrKC+4=;
        b=T/kCvvjJcmkOJJQ8ApRLw5fdYX5fuMTuzh7SEHent/oi+eavpUaJ5N72e35OnWmpOv
         /gPbhkC53etC1ixvn31tXH0iIkRJuXbDEZ/2Y9VRhdosddbmYTYOsnwqY/uzxm20PYo/
         43oXd2qHZMjAv340+dT1VwzEkSUQO93e+80REjhdhdJYItTQ33YjahrnEqgvkFx95Asl
         s2W9ut+VNgo97jq97rZpaD60OMeBh6ohQqb2xmpZy2Ma7mUtLaoUamgq6RsUMezZxj16
         b9IBuaUFUvaXTvYkq6ujUtEHU356omMM2Fw8SzDs1ou4cT7T56hn3I5BVcE62md//lDy
         hPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115846; x=1724720646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UACsmobsUd8Y9iBIYxx+ODamTggideAg91GBgxrKC+4=;
        b=Sm1WSirMcXc3zVCllO1/FP2Xc93Gl3rsdTKUZNV6tTBPe414ROwFct+Jw4ZFVpEwrC
         4mN4fpkCgxmkJbRMwKiHVJxltM3CXs3iddD4074L8epg09q/jTMsEc5uSRp9U7YyKM3k
         1qfuWU85Alr36cFahlzkASj0iFLLwMKoqxAJ5VG10gTo72hCC4/5AvDb12oxPs7N5Kve
         lO1qsKUtRFd52ykCN4Dm4uu3xH8SSt/IxsPC0gb3ehWx7VP1RlTunWTiMLxcURqw8smv
         vfGstb4gmceQAYILDZQnmo2VG0sd08fZK9I3kYCMDNdyaz/AFPGI7MCgmcGWvn6729p0
         Z25w==
X-Forwarded-Encrypted: i=1; AJvYcCXdHdbzGPyFlmOcImjlHFgn3juFs3CSI+vFZb7NNGf06kTwCkRqH3f8gpOolO9ywWhvHFxS9LPkNsZm9g2je/tNK3e+YcazVfzTyqLK
X-Gm-Message-State: AOJu0YwOJ0LfDe/YrCSXn3JNwds419way7/zQYlkKhqb5KmeR8YFolSR
	3pfITf24kkks9NAB2Cfnh2edPi0eN2FZ9crvgZRDlitkNJUv9Bic
X-Google-Smtp-Source: AGHT+IFD5aZEqE3cEzDccQnjGQj3peF4UUPSjP3VpAalU8jd/ADbac4NDPAqvijztQCvyiNg3+mzbA==
X-Received: by 2002:a17:907:d854:b0:a77:e55a:9e8c with SMTP id a640c23a62f3a-a83929d37b7mr881022866b.47.1724115845888;
        Mon, 19 Aug 2024 18:04:05 -0700 (PDT)
Received: from hostname ([2a02:c7c:6696:8300:44d8:63fa:6beb:ff38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d7c0sm691572066b.213.2024.08.19.18.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:04:05 -0700 (PDT)
Date: Tue, 20 Aug 2024 02:03:42 +0100
From: qasdev <qasdev00@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Heming Zhao <heming.zhao@suse.com>, mark@fasheh.com,
	jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
Message-ID: <ZsPrbmbnAgGRgqLw@hostname>
References: <Zr9XJJlZ+RzkLK/M@hostname>
 <cbd30b80-d213-4997-b447-10e455f20196@suse.com>
 <e5fb0013-ea4e-4da7-89e5-6b2b0879ecc9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5fb0013-ea4e-4da7-89e5-6b2b0879ecc9@linux.alibaba.com>

On Mon, Aug 19, 2024 at 10:52:29AM +0800, Joseph Qi wrote:
> 
> 
> On 8/18/24 7:43 PM, Heming Zhao wrote:
> > On 8/16/24 21:41, qasdev wrote:
> >>  From ad1ca2fd2ecf4eb7ec2c76fcbbf34639f0ad87ca Mon Sep 17 00:00:00 2001
> >> From: Qasim Ijaz <qasdev00@gmail.com>
> >> Date: Fri, 16 Aug 2024 02:30:25 +0100
> >> Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
> >>   ocfs2_verify_volume()
> >>
> 
> The above should be eliminated from patch body. 
> 
> >> This patch addresses a shift-out-of-bounds error in the
> >> ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered
> >> by an invalid s_clustersize_bits value (e.g., 1548), which caused the
> >> expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)"
> >> to exceed the limits of a 32-bit integer,
> >> leading to an out-of-bounds shift.
> >>
> >> Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
> >> Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
> >> Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
> >> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> >> ---
> >>   fs/ocfs2/super.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> >> index afee70125ae3..1e43cdca7f40 100644
> >> --- a/fs/ocfs2/super.c
> >> +++ b/fs/ocfs2/super.c
> >> @@ -2357,8 +2357,12 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
> >>                    (unsigned long long)bh->b_blocknr);
> >>           } else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
> >>                   le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
> >> -            mlog(ML_ERROR, "bad cluster size found: %u\n",
> >> -                 1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> >> +            if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 32)
> >> +                mlog(ML_ERROR, "bad cluster size found: %u\n",
> >> +                     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> >> +            else
> >> +                mlog(ML_ERROR, "invalid cluster size bit value: %u\n",
> >> +                     le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> > 
> > I prefer to use concise code to fix the error.
> > Do you like below code?
> > -        mlog(ML_ERROR, "bad cluster size found: %u\n",
> > -                 1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> > +        mlog(ML_ERROR, "bad cluster size bit found: %u\n",
> > +                 le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> > 
> 
> Agree. qasdev, Could you please update and send v2?
> 
> Thanks,
> Joseph

Thanks for the feedback. After considering the input, I've refined the patch 
to make it more concise. I've updated the patch and included it below:


This patch addresses a shift-out-of-bounds error in the 
ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered 
by an invalid s_clustersize_bits value (e.g., 1548), which caused the 
expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)" 
to exceed the limits of a 32-bit integer, 
leading to an out-of-bounds shift.

Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/ocfs2/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index afee70125ae3..b704983b2112 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2357,8 +2357,8 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
                     (unsigned long long)bh->b_blocknr);
             } else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
                     le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
-                   mlog(ML_ERROR, "bad cluster size found: %u\n",
-                        1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
+                   mlog(ML_ERROR, "bad cluster size bit found: %u\n",
+                        le32_to_cpu(di->id2.i_super.s_clustersize_bits));
             } else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {
                     mlog(ML_ERROR, "bad root_blkno: 0\n");
             } else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno)) {
-- 
2.30.2

