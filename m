Return-Path: <linux-kernel+bounces-267683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E83941447
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D1EB24B85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5021A254F;
	Tue, 30 Jul 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3FjUfHE"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56A1A2542
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349529; cv=none; b=XMqEIBc3fm0eOTMpj0K/VReV3AsUsHE7OVXot5QzkoK/Pm3IyVBo/vAgbXxfufB1Bg6th9bBu3X+9KNVNJAmFNCyPInb97dvqqXh/eqTFtmdCzbzTyTfmZq5XFZR1UBXCqEuU/Txnlp7FYQqkg3fsMsIdq+QLB5iItGTAMzW2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349529; c=relaxed/simple;
	bh=LKBgNmvMBmaSWBO8oyVt1qd2hjc2mHIWU3Qo7jCMNYI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lETA2c5xhrhQ34sJOEUpF3EWBmf3m2CfSossqu5fzOeTJr/pHD2cUib0La37EofeN3q+4YNMgskiXbaKVnNX1dZfJcI8dnC2FN2JeuPC/KiT9smlSHpgGZ97C8lhCIZq896tTY/NL20d8QOUZ/gdVhy5Cum6m1TcOsEM2SPqhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3FjUfHE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04c29588so8386009e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722349526; x=1722954326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VQEznJg84i5ZK7eGARok4l5wc3m0IWj/uMPsa8F98w=;
        b=d3FjUfHETMM4Qf3eHSNUYvTfGY/6W7jpEbTYKFXgnjJwt7HAbwRxb5AEELbZGSv2gr
         LljKO4ZYj/pL/Dryy63Mpi7VsnsfwVbd5ZEenZrxhyKHQlWPDoaMlH9VWfKvFUQhLbaK
         Lz9bapxs0F03a8vnfn2fK0bH84OGCn9TG/SKdAE+jawp77OYTsBzp93tDiXk8Z/x9LuC
         gAp7KinrYpI7BBvMiCW/bhmapKdyG9XUyc2Hva7ktlepwuFsyBXBv7D0svPINGWKuemW
         mYiHG0zpvqTRoB7PSSnbQ1DyhlKGIFsRncKVRvKR2k0iILjPfTFeNxBM5/BgzzBNbfgl
         p2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722349526; x=1722954326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VQEznJg84i5ZK7eGARok4l5wc3m0IWj/uMPsa8F98w=;
        b=Ii8Se7LXTs7F3sl70a/jX9hasJvmeMh3R507vr33E5e8U86fiBZESx5Qs4X7wyzfzL
         mUstD7B702DAA/6wswIwGa1OFckDKk3V/Sj7g+4kDa72WXtZPh6tXY1IY9p1NwNOqjFq
         2e0tZ8CYwFGM/O+ZXExf2XhTGiq/TiTj+A0d71NiRDB3W5SkjhgnwSeoJlM9gc9lECsv
         DOaDnS8qi3lnodm5dSuAf2YpS0yVbo7iB8D5tBjR994/dKQGLYszCTyV4lRDe5z4jZ4e
         MlMqkU9LX57eWIONZloecD3c+OcTKf1nIjQWideAaF+7bd7ASIrfh4LrqvRV2TXQ/Sc5
         B3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXhavQ1GUJf8WgWrAAOc7m/0Tcn5v1/LCp/LlNE2mkBt1ITIGcClfwSz0aGCvw0qMv4zHBUooNVJGEKQELP23cjdWwWylVr5xVmZFJ0
X-Gm-Message-State: AOJu0YzotA4+SQszgXAwTUrOF3W4V+pSuM+pMXzxKlPZrailQRo/sW8A
	BZ+7WUd5jwvALqVcrs4Lsmigm+A8VXf87W4izsmYfjDksfYRcgBQ
X-Google-Smtp-Source: AGHT+IFLzRCIQWexgX1O+QPShiRIrQ7VfY/StVijR9lRPcUIwz14qenunSfvdTmdWPtO571hiS57iQ==
X-Received: by 2002:a05:6512:480a:b0:52e:be1f:bf7f with SMTP id 2adb3069b0e04-5309b27b283mr6293800e87.27.1722349526121;
        Tue, 30 Jul 2024 07:25:26 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd15d2sm1868898e87.112.2024.07.30.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:25:25 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 30 Jul 2024 16:25:24 +0200
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ff2407cef5068e202465@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in kcov_ioctl (2)
Message-ID: <Zqj31Kf9_Nb01GYR@pc638.lan>
References: <0000000000000f67c9061e649949@google.com>
 <20240729143112.3d713abe2bde51d718c7db93@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729143112.3d713abe2bde51d718c7db93@linux-foundation.org>

On Mon, Jul 29, 2024 at 02:31:12PM -0700, Andrew Morton wrote:
> On Mon, 29 Jul 2024 08:34:33 -0700 syzbot <syzbot+ff2407cef5068e202465@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    3a7e02c040b1 minmax: avoid overly complicated constant exp..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=132e32bd980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=381b8eb3d35e3ad9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ff2407cef5068e202465
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/198814da854c/disk-3a7e02c0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/868e99275bc0/vmlinux-3a7e02c0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ce63033f3708/bzImage-3a7e02c0.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ff2407cef5068e202465@syzkaller.appspotmail.com
> 
> Thanks.  Possibly kcov_ioctl(KCOV_INIT_TRACE) was passed a crazily huge
> size.  Perhaps some more realistic checking should be applied there?
> 
> Also, vmalloc() shouldn't be doing this even if asked to allocate a
> crazily huge size.
> 
<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bc21d821d506..450c6b10a357 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3783,7 +3783,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	if (WARN_ON_ONCE(!size))
 		return NULL;
 
-	if ((size >> PAGE_SHIFT) > totalram_pages()) {
+	if ((size >> PAGE_SHIFT) > totalram_pages() || size > INT32_MAX) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, exceeds total pages",
 			real_size);
<snip>

We can limit it to ~2GB or add a special threshold which will control
the maximum allocation size.

Any thoughts?

--
Uladzislau Rezki

