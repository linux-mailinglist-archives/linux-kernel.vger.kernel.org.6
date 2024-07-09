Return-Path: <linux-kernel+bounces-246097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F5592BDEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6B9B2A1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E019B5BC;
	Tue,  9 Jul 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2c7E2UN"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13F18EFD7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536925; cv=none; b=LHw4HxEN5ITC5TLDjGyPKWdm2Gdyb3XfTUesHU3r2IIdL9nPM+KjVUrX9kYfuvAIqIJyN0p7QaL2N7IYRKUtsG06GlCNRLMAwakboaBCtNkNmgiN7Eslq7VewZwLiSAs3PsoNDRi/ihXxNxzpO1krrnaMVCtD1ibYJnZBs8NGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536925; c=relaxed/simple;
	bh=uO9EIG4GhbTcolIGwl03FCQMs4OnbvCgqTg7E5Skqvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSKqZ1EQPqnGlpLGFOk85haGy8wCBmr3l/eH8t5yLJ8IP+ktlpsODq9ohWZEs1t4stbei9mrOEOQjiU4bzqOeFg4X7dBu5o2sS4X5K7XpVtMouzqCDi2eXKdJJGDlMoRgcMHLdMoUrvTMjVGd0Bcl6erT2uL2G+FIeLkwitZZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2c7E2UN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7594c490b04so3606833a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720536923; x=1721141723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO9EIG4GhbTcolIGwl03FCQMs4OnbvCgqTg7E5Skqvk=;
        b=B2c7E2UN94V34h6ukdjRvb+2CGNbZTs2aXuAM7lpcQVEJ81o3FwoAF7EygHTpthIUD
         6UudT9imtrfDRYpjQ2tmy7neRRdXA0bWpDdSr3isHmtSjGj4Hl6LKo0AHxbojBdsnoVT
         a2ANi3q4WwFyFLk6U0wn9rAiqPePerzmU2mgZ7//SPQg1CoDkpd0t/nCjchfeqVJ4lFr
         eFCw5kXJBgAW4CrCsNEht1+Pv1TgnVS8Ydo4FyKAJ0baOm/uODCkYmxiLoIGqkYF/7xf
         ux1nPEWJwm7KXcaMydX39ZQLwJ7fjoBUUiw8jgQYb98eQUblAnLyXZjp+p6oAiEGxkQ+
         dEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536923; x=1721141723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO9EIG4GhbTcolIGwl03FCQMs4OnbvCgqTg7E5Skqvk=;
        b=It1PzyM5vl0ZCuW7z1XOdiZ3egStG2DLUCwElR53OYZtO6bxWjH9Q0G0w0oXLDrRHn
         oaZjNw/ZL6mv+DlKLxRHJuFyA3oyU5ZYtuPY3+OAeLv9s3TVRAbVHLVq664OQx/UXrZE
         4uJdRL/n38jigcza6UPUKlr1dTQk2nQP/TiIElwa2/RmJtNFBkJXWtb1S2yZJpbXpNIi
         e8GhS3uH6VkIvm+PCYfE9n7K+sUKct5HIt+sqVPhrI5fdHn5Mj3Lcu5oiCmJ59RhUfrV
         b9ntIcOKo2hmwv99wpWkQQ8VafhkocZYuj3W7UJGplj5NXkZHyjXcB7YAtfxo+1rZv+/
         W52g==
X-Forwarded-Encrypted: i=1; AJvYcCVp5xfiQ+bsyoYnRFGHLIMUj0un8xFAlOT7ckuCnjL05feBeFE2pc+4R1poPekks7sSFMWjVshpV8bIBLZUuurQz/sDRQI3xmlvraw2
X-Gm-Message-State: AOJu0YwalVKkdDxf9zM/zzDcpTsADjEGAYgxEeXnpJ9bgyaxdUFphHg5
	wO/J68K7GnpwHER24NKkyBZPBI5SaszGnKDrCeexglvKSht+lEhab5BA7F21L8C1dDY6lj1IgeT
	FFmsn8gNDYo/o0dY6GGcviYw537Y=
X-Google-Smtp-Source: AGHT+IHsDUQ5svxOkh9jn82lXinLUkaZ1FBGzAczjXfNB1RdaGu6BZMgBqlKJpyiWt4gHGDFubY+rOCpx89CmgB4XnU=
X-Received: by 2002:a05:6a20:3d89:b0:1be:f5f2:1c9a with SMTP id
 adf61e73a8af0-1c2981ff81dmr3604003637.13.1720536923642; Tue, 09 Jul 2024
 07:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704034915.2164-5-jiangshanlai@gmail.com> <202407081521.83b627c1-lkp@intel.com>
 <Zows8czlE6ji5Ezw@slm.duckdns.org>
In-Reply-To: <Zows8czlE6ji5Ezw@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 9 Jul 2024 22:55:10 +0800
Message-ID: <CAJhGHyC=5FC1uFt0xzMwk42m=zm-_d9-OxoC4BQmSREAbAQrog@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] workqueue: Put PWQ allocation and WQ enlistment in
 the same lock C.S.
To: Tejun Heo <tj@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jul 9, 2024 at 2:16=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Jul 08, 2024 at 03:54:19PM +0800, kernel test robot wrote:
> ...
> > [ 2.269463][ T1] cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel=
/cpu.c:488)
> > [ 2.273463][ T1] alloc_workqueue (kernel/workqueue.c:5152 kernel/workqu=
eue.c:5730)
> > [ 2.273463][ T1] padata_alloc (kernel/padata.c:1007 (discriminator 1))
> > [ 2.273463][ T1] pcrypt_init_padata (crypto/pcrypt.c:327 (discriminator=
 1))
> > [ 2.277463][ T1] pcrypt_init (crypto/pcrypt.c:353)
> > [ 2.277463][ T1] do_one_initcall (init/main.c:1267)
> > [ 2.281464][ T1] do_initcalls (init/main.c:1328 (discriminator 1) init/=
main.c:1345 (discriminator 1))
> > [ 2.281464][ T1] kernel_init_freeable (init/main.c:1364)
> > [ 2.285464][ T1] kernel_init (init/main.c:1469)
> > [ 2.285464][ T1] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 2.289466][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> > [ 2.289466][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944)

Thanks for the report!

>
> Ah, this is unfortunate, so pcrypt is allocating a workqueue while holdin=
g
> cpus_read_lock(), so workqueue code can't do it again as that can lead to
> deadlocks if down_write starts after the first down_read. Lai, it looks l=
ike
> we'd need to switch to workqueue specific locking so that we don't depend=
 on
> cpus_read_lock from alloc path.
>

I'm working on it. A new wq_online_mask will be added. The new
wq_online_mask mirrors the cpu_online_mask except during hotplugging;
specifically, it differs between the hotplugging stages of
workqueue_offline_cpu() and workqueue_online_cpu(), during which the
transitioning CPU is not represented in the mask.

Thanks
Lai

