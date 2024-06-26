Return-Path: <linux-kernel+bounces-231445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F499198D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0426C1F2241C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB81192B69;
	Wed, 26 Jun 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Scr18s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52E155749
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432964; cv=none; b=clpjD4oFpb6e2yfOtkhEtjO5A1ZJqCQkN+uj5rH+hHMFyqQbTdjVTdrv0N6wYPiEPzlydtHcklJKPR797UB/SUWTtZxMagbLZtVs+GcWyQzJVRTi/MRD6LCziGQu460uWsfFB3mIev/8lo7LXUIGVCqmkDvYsR1W4vvqNA12CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432964; c=relaxed/simple;
	bh=Edk9KaveOFb77WSFKm9P132fNZq9OZCsMRe+lxtXnNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5n0YAIEACJUSSK8Ifg0Gx3aq7HFUNyxzsV273EBxJpXTdGvHsIWHdXQ+pWLFLHRCUJO9VWJbH5us6GAwDWh2BkjA085VecTU3jyDJ1gNaa+ALJ+rBx+b0/i5N//0nhPWVNqoaPWoeyqpmmkzzzVvmCuMaTdHyKtGLyXH92G1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1Scr18s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719432960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZX2AGcRMmoaPmdp0U9TEIQ7B80WrvLquACg08mJmXsI=;
	b=C1Scr18skJn/tkxXY2x+n1vXwXosY7VJjm72GKM/K8F2qKgfqW25vY85ub5vjrN4DKK7DM
	HsL4Jh+XEDSr0U3oMrvJI5cqkvm74PSbA2OxQCBuShzXLNyRDHSPJB+wdvOzS+Ubz4KrBH
	4NpyhoVnuffY7yOcDK7VorNOYZgWZ+s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-W1-MZ9W5PFOcG3ctAhqMXQ-1; Wed, 26 Jun 2024 16:15:59 -0400
X-MC-Unique: W1-MZ9W5PFOcG3ctAhqMXQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b51db044edso114827586d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432958; x=1720037758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX2AGcRMmoaPmdp0U9TEIQ7B80WrvLquACg08mJmXsI=;
        b=kpjyEfeshZ2seETudAxjZewoMC7rKMwfe9ACjg8s2K6TwFIHtoYuYip96zioethhIe
         UT+gURc+Qn7PT7RMu0Kq5G8JV8GL3syo5JeMIScp8BRKoGu4XsjaSoV7PlAq/Qxr4yBE
         shgWFptQzNLQZiV7M6qzN8i5/Wr/276bGbn0FOaBSzdFq7rX+xlWWPG6svQz0SMi/lyZ
         X46Vl0JiWM0qg19cQIGXwg1nHmoCUYYAjWUiewx6eUKI7vyeNtPQ5vf9f+hPdyAURjJP
         YHmSinHcMZ7IdcHGzCSAanZoKCaV7lg6GqQz5tD++gSo93uqcZOREf2PKAbAuDVab7c3
         CpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRxq6Bedk3bhu/jjYSXorD11teYGc25JIu/gqE6KlclxloYZX94VPRDSd1Tm6KJsN8lWWcvv4OshqeFh/hVPR7j3ZwJqIwX3zryH52
X-Gm-Message-State: AOJu0YzqG2mPuxPKk8LjuEo5h4m1uDStGZCoSkhYg31IE0dOXynteAH1
	UTY0/gnAnGCWav171vYbX8Ojc/UfZoMGt9k0P0uA9yrmCtLA3MuLWig5GxlJHx/G5UjDXwRMylA
	MDUwKc0QO8W9SzLIjHEq0YEFNNvy5qFGuFIdgd1lrfNUFyRGl2K6j7/si2ucgHw==
X-Received: by 2002:a05:6214:18c5:b0:6b0:910a:8c1e with SMTP id 6a1803df08f44-6b5409f4631mr106503496d6.36.1719432958646;
        Wed, 26 Jun 2024 13:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZqOsqHTw4VypxWFI1V8GoYqGEwdbd8AMzxpFaZTVNMdtx8iar2ZPTbvrWpJUZAg/Mc3/Zw==
X-Received: by 2002:a05:6214:18c5:b0:6b0:910a:8c1e with SMTP id 6a1803df08f44-6b5409f4631mr106503336d6.36.1719432958350;
        Wed, 26 Jun 2024 13:15:58 -0700 (PDT)
Received: from localhost.localdomain ([174.91.39.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfef30sm57710316d6.17.2024.06.26.13.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:15:58 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: raven@themaw.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: [RFC v3 0/1] fs/namespace: defer RCU sync for MNT_DETACH umount 
Date: Wed, 26 Jun 2024 16:07:48 -0400
Message-ID: <20240626201129.272750-2-lkarpins@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,                                            
                                                   
Attached is v3 of the umount optimization. Please take a look at v1 for
the original introduction to the problem. Al made it clear in the
RFC v1 that if a filesystem is shut down by umount(2), that the
shut down needs to be completed before the return from the syscall. In 
the RFC v2, it was pointed out that call_rcu can block within an 
interrupt context. This RFC v3 addresses both that and removes 
unneccesary code by taking advantage of mntput for the cleanup of lazy 
umounts.                                           
                                                   
Lucas                                              
                                                   
v3:                                                
- Removed unneeded code for lazy umount case.      
- Don't block within interrupt context.            
v2:                                                
- Only defer releasing umount'ed filesystems for lazy umounts
v1:                                                
https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

Lucas Karpinski (1):
  fs/namespace: remove RCU sync for MNT_DETACH umount

 fs/namespace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.45.2


