Return-Path: <linux-kernel+bounces-252773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C093180A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD601C21625
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA917758;
	Mon, 15 Jul 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdNie1Xh"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF58EAD5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059402; cv=none; b=ogKfvcxo2gvXEYGlWyV2+1B888WmXO0UWdIOYCOtB1x5zpWY6CvJ2wSddajPoyAKFlBqasw1hFmOP5ILcBDZ/VtoM4ZkoQUUY6Wipz9DR99I6PGuwODAYnoxSNs2rkTEeTseE2jKS3s698wVVWBlI7NLcymYmc8NdE+JhsdbBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059402; c=relaxed/simple;
	bh=yO+qmCjhJNITh4axvM6RdKgt9MZF15nCma7QKbyMBd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly56v0yVramtFRJvSQdA8nv5JKN8eLqTPXS4sjeVqOQScPCKgm8L+X7sSLEfhx2c7pdFUZG2eoFXrowYOlf+KofbBXUsitXI7DQLnagInlo/Ne78mXQIfgxTNo952sgwFycXa/rEXGFnTcV3Fldo/nr4HXNTVcEEk6V0UrLYJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdNie1Xh; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-793a3a79a83so558476a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721059401; x=1721664201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Bxrf/DKpAK2B/TsaT/F2XEK4iJqHxONRsU36V81tY=;
        b=RdNie1XhUCACrmMN5yRkVW84BTV9BVZxvcCrXxiynlOcMqkd1r0jmANN1Q01TjDmpf
         /45yuX+0zRTovceDFOIcxIxluQucUfdyCWIraKsXXhk5Trx2vJK3x3c9yDakopjQ8kz1
         7RTWYuW4OsiMD32rhyiK1GmNZudx2XB/Yu16Yq+s2abye677a1DfzwjX8bW0YKTDRcbj
         E/jZkBkSXnEIBzgchZvP6Je/ent86RKbez0KHLXaFzrhfA8d8hxvuz3DcS4ucLugrEsC
         lDBLzFndqvyVbv4pjx7SEbBjoLU+RBNz/wQveKeriKs/eUoKDVBmHg7RywE4hDpDtWXK
         7kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059401; x=1721664201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5Bxrf/DKpAK2B/TsaT/F2XEK4iJqHxONRsU36V81tY=;
        b=cz5rPSMgJ5KYBrmsITuZxjafJzhgEpjow3Joesx5DFiA5T9rIiCdiLbu4bKOKNDvtw
         DxZeo36P702fgusqGb/IosdAEpfSvsLg7Vuxs3kHkzGRsBfwC/Jr02hHabkCg83ml+6O
         ZBq20ljOqp6H4KRW5WeWYwQZKnaVlp7ouWKhignxDX7qZhjt04A4gLhSwxQSdvMFNEJA
         /jSUJ0IULt3d2xpAEz0oaW4fy40nTohdY8JZOoraDcghtC18Wkx2D0eSySWJt6NaJ6oG
         v7krdoZJGulb9w4PID7k7Ft3BiSjNKn6kegcI4eLXmQp0SB+DLcbo3BK2O8LUKlBVCoP
         lbNA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6hmn31jzxh+omHhv5a1zLPIHaUKJLxZTblE3J7SYvh8XMmz+1TZ40+cO/1P1ToDsTaw/0vwFQMvCa2+KOOgLVIfvjlSoPMWO2Hsh
X-Gm-Message-State: AOJu0YzaHXnixvDnmuvzvh5YVgWoA5D6UjB68w3K2qSnR+d0PtYmPBjw
	1QzG2x2MmKqrBDxOqwE8ZLN/+pNc19d/pVSDWhpbELt9v7b1edLmT/EYlYQjPn3eOUbytWk+gUu
	HR61GzyGswqC1U3s5XVDk2IYaWmA=
X-Google-Smtp-Source: AGHT+IGtNKdbuCSkUDpJRGkAZfMRt46ZDJA5IoLCCKriKWDvv2m/wVYmjvzXrAJNKH/dUU59N9+4YdEMW2iXoLAEEfQ=
X-Received: by 2002:a17:90b:1947:b0:2ca:5ec8:576c with SMTP id
 98e67ed59e1d1-2ca5ec85cbbmr14312951a91.5.1721059400793; Mon, 15 Jul 2024
 09:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
In-Reply-To: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 16 Jul 2024 00:03:09 +0800
Message-ID: <CAJhGHyBMeUXoV9UaNJp8zgFiPaAVVnU-zBOFH_-BD8zre4=QUA@mail.gmail.com>
Subject: Re: [GIT PULL] workqueue: Changes for v6.11
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Mon, Jul 15, 2024 at 12:43=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:

> Lai Jiangshan (20):
>       workqueue: Avoid nr_active manipulation in grabbing inactive items
>       workqueue: Reap workers via kthread_stop() and remove detach_comple=
tion
>       workqueue: Don't bind the rescuer in the last working cpu
>       workqueue: Detach workers directly in idle_cull_fn()
>       workqueue: Remove useless pool->dying_workers
>       workqueue: Update cpumasks after only applying it successfully
>       workqueue: Simplify goto statement
>       workqueue: Register sysfs after the whole creation of the new wq
>       workqueue: Make rescuer initialization as the last step of the crea=
tion of a new wq
>       workqueue: Move kthread_flush_worker() out of alloc_and_link_pwqs()
>       workqueue: Put PWQ allocation and WQ enlistment in the same lock C.=
S.
>       workqueue: Init rescuer's affinities as the wq's effective cpumask
>       workqueue: Add wq_online_cpumask
>       workqueue: Simplify wq_calc_pod_cpumask() with wq_online_cpumask

>       workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()

Sorry about it.

I'm writing a fix to fix this change reported by
https://lore.kernel.org/lkml/202407141846.665c0446-lkp@intel.com/
to remove the unneeded lockdep_assert_cpus_held().

thanks
Lai

