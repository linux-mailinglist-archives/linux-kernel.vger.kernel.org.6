Return-Path: <linux-kernel+bounces-330703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230ED97A2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B1AB21EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF2157466;
	Mon, 16 Sep 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJruGBeU"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45715667B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493328; cv=none; b=Tw9csavLb+nfDeaB4qCGZFH4KdolbOZ9lOSz3Z74vS2l6PgvpI1GVGyyZCMyBZym5WUoUOZtJsAe7dlXKmXN3vdxm34vRmdihhZXkSfMmHtGx158Rzs11T59UbZ0WRDOfy2B+uDL0bRk+SwT1PdefGwIoGl7khNhuyd4LLSTWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493328; c=relaxed/simple;
	bh=GPcvs/fhmU2oKwOCZ+3saQOItGhnAIyYGtqrRz2Ei3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX+zTi2W3DJFA73I6USwUF92LxsrN+XNG3L2p/op+/YxdmphwttWV/eTzTaAsxurV/Y53dXOTrBJbpOclILCupLFGR4tL6aTXrwxgQOX3zn2QHmAe/igHAPs2QqcnJv2kI6U/xa43+e5miLW9RGE7cP7Xh+2QzyTspBAMyA8IS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJruGBeU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f7529203ddso48981131fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726493325; x=1727098125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuhlXIHiV1y6DrCHqiUoVd4G+jZthi/0Gn7DNqQTDJ8=;
        b=vJruGBeUcpuCsLnVoeCFokDmgUmD2pEr+cLvY0I8L5rHWamqAmGR714l9ueaYB0I//
         67r+fm09OMYqYC9ewWsdICJxVF6e+RDVvXlYtf+QTpqJjo6o0o2GxOpD9pK/w9h/qwzI
         UA678t+7rsaPDn7BBThTCGiCSWEbvx4inkJe5dcz3fWp9Y3Vq9kvaVz3YZInzXjzehZy
         +gPwRqx/JZMIsyMywB4bo1/kyRhiEhFBoscGtTVkbbcthOD9fK9h4Cu88t5zBbIOtwKp
         nwJ+PYW26CU6OiU5CpFh2Az/F9zn5LRSoDmo5ZPFiL1wC5IfpqjmU7lu39eXhUcqMmZv
         Z0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726493325; x=1727098125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuhlXIHiV1y6DrCHqiUoVd4G+jZthi/0Gn7DNqQTDJ8=;
        b=LYKiqvMekPHi96hU9za/vvtcc1duLL9IimKKIufJhFoJ5CmoXdINiWQ5Fi3/ZEeiVJ
         RMk/w4WiQOBg3LejvNdAvhti8ezeAWhilL2+8SllHYCBPJHEgOMAxZl+IlpmczMSnNXm
         l+ffhOaiKixlY+SV3/cTpC2VM05IaYIXNTsWcfV34aY6g4efDgzIvr/tQOJkR8RB9dZy
         +8RR0J28F/gciPougdegLJwBM18GaOceSbEYI0KLyOKI76iabWhsYfyZVy3idhwEzbxz
         JDPkyZi9qtIwfNwSD9X/yMD4M4gBX105XExraBGPlsoUPemaLGryAXHOt5wMW4GutF3h
         SdSg==
X-Forwarded-Encrypted: i=1; AJvYcCUekIUN5d8vB0JUpL6RuaFTC2SguNg/lvfuNo4+9sDXrWaZwGNrU114V5BNLGjYOuIHlCpvp91Gl4ibpWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFng4EUWSdeX23vamNJEZoV03RExjWn5WmWE6vr+bmUo7KgkGn
	7KKeno+Uu3BaAi50yljzfL3o+1fsLwJBnGT9jDlsKFVH2FsAYTUylfse3q2m4dCr89TbZ6y44q9
	0wV1tcllHWSH4N/aYsek9Ul1fQSALK1RTK1yx
X-Google-Smtp-Source: AGHT+IE2C3eS+spZ/KG4/n+8zkx1UVRoq/fSlzz3s0t36e0LvRq8KdjGj/md7/RrKELeF9E5xCn6e+M+QCIVq3r8OgI=
X-Received: by 2002:a2e:a545:0:b0:2f3:aac3:c2a5 with SMTP id
 38308e7fff4ca-2f787d061d0mr49204681fa.17.1726493324366; Mon, 16 Sep 2024
 06:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000039fb2d05f3c7d0ed@google.com> <8e13233a-2eb6-6d92-e94f-b94db8b518ed@acm.org>
In-Reply-To: <8e13233a-2eb6-6d92-e94f-b94db8b518ed@acm.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 15:28:33 +0200
Message-ID: <CACT4Y+ZvEjpX8a9VW4tS1YSP8RE6xjb8C9ae6PcSa0rr-q+62g@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
To: Bart Van Assche <bvanassche@acm.org>
Cc: syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, alim.akhtar@samsung.com, avri.altman@wdc.com, 
	beanhuo@micron.com, hdanton@sina.com, jejb@linux.ibm.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	wsa+renesas@sang-engineering.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Feb 2023 at 19:11, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/3/23 00:53, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 82ede9c19839079e7953a47895729852a440080c
> > Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Date:   Tue Jun 21 14:46:53 2022 +0000
> >
> >      scsi: ufs: core: Fix typos in error messages
>
> To the syzbot maintainers: I think this is a good example of a bisection
> result that is wrong. It is unlikely that fixing typos in kernel
> messages would affect whether or not the kernel hangs. Additionally, as
> far as I know, the systems used by syzbot (Google Compute Engine virtual
> machines) do trigger any code in the UFS driver.

Hi Bart,

syzbot has logic to detect commits that don't affect builds.
It hashes SHF_ALLOC vmlinux sections to check if the commit actually
has any effect on the binary:
https://github.com/google/syzkaller/blob/c673ca06b23cea94091ab496ef62c3513e434585/pkg/build/linux.go#L253-L286

Bug CONFIG_UFS_FS is enabled on syzbot, it has some coverage for it,
and strings affect the binary (can actually be the root cause for
bugs). So I don't see what else can be done here automatically.

