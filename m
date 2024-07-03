Return-Path: <linux-kernel+bounces-238946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77F79253C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BB61F24E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4941311B5;
	Wed,  3 Jul 2024 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmgxWEzl"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A938DE0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988522; cv=none; b=MFjpAL/F2HnO1FmlkFhE3DVb7K3kIJ5ROGcRIuLVFoV5SYd2qQsDO8P7ZGtX4nGZJloEyWMcKrvb9M9M0pYKnSQT5OP3n6E0i3mU6oYfegNJylomdMOFb9aqkxKrWOAmQfCM+KoofRikDLd3l1vCMsVLN8v9Mr51Afl5PJVKN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988522; c=relaxed/simple;
	bh=tT2PNV5mIIJM8n+lJZtS6m5bAXNCcAvJvAqQv5Azako=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjOmwq3qQp1nsYRPEQ99P8e4GMpAlUC2h8yRh6cYlQitF9pPShXafdH3WMkOT4vFs1pgz+1rAz6IZUNMtZpQMySC3DICjfKUQbMhTnAOrhONLfTq/oTFU3gK/ELf998y21loGOpLJsY8zRrmgZn9rqkZyGySH3qtkxJvQHqGI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmgxWEzl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d55e2e0327so2629726b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719988520; x=1720593320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEJYHncpw1XAexoBXGrUYV7ZeFGCexGspe/6zDPbhBg=;
        b=bmgxWEzlW4UCN6fb3MEyWugXEl6FBszoALUJKq72BvJDmYwpgGgNZU4YkCHYrnvUfY
         9/fz9Lcqswps9XYhqIOMh7Oc45t/DCWBvccp5fVnIVgEap4tifp3WPm8VQNDRj6WlLKW
         BkIi5veeqBfonnK/yKzpdDPBgjmVh94gMrEXjCDiSb9R72PVgcCtG5PtUhAipeWVfhU/
         SqalTbib1QvVzhTpq5zXsm5c1H23pKQbbm1Z1Sfetd9tVhLscOcMx+1p3Uop7riYfkNv
         FwceXbvGtnPDPEMiAWX8NAIIz+WdInCj2ZggMkgYQ2BufdviYQZQCk8YRpDH+M9/1ynL
         0hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988520; x=1720593320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEJYHncpw1XAexoBXGrUYV7ZeFGCexGspe/6zDPbhBg=;
        b=suvdX2okZDcTlT+eiliZU25mwJiDqD03tALC93dbVODUiWomt61PmiBS08MzqUfTDd
         OESbst3lT7vzogmIwkXmzz+cmlbcqXBOvhYOzWxCWO+hGDdmuJVgoktS7oUUo8RpmZFm
         fUNKDnpyuhdCgqR1eDrlLOCb9NQfTFqPbyEnm4+cxG/g9RyLd4WKIdBWlclH3MmtYQLy
         6vmilKn8yHijHXOIqavgYINL3PxZhkIH/Hf0/7v6OsNN8rscLBvKsqT9mx3Uk6v0TUc4
         vSPd3fMQMD7SygEjy2WGTxxyrRIbVyldfj6Skog8dlhiTJAZCb7/KPeuQfvhm5FVzUKq
         rFVg==
X-Forwarded-Encrypted: i=1; AJvYcCU9vjBK0vhjXvjmxoQ1SSdIPbLMOxKHE88vFOOvpp+3J55FHVfDXxgXuGqkhHhsbArzBQXZl1CkQvw00JVAh64/IeKOe6f4nNhISQG/
X-Gm-Message-State: AOJu0Yzyec/H3OCvKHvxl0WXA04sxStCeJDzwdtfSm/T/b9foIpbOVdb
	i8iZyM2iludaBha0pld0Z+Mxbu3+GkMfNxwwOdLl1c7OJ0tbwpizxaEMWXOZl6m9N8iVJo4cIB0
	UZQvLJY0jr/YjqlNAlxHSD7oiky8=
X-Google-Smtp-Source: AGHT+IHkd16vhF4pJnMHEOP6LLZOXApnHSbqLZIWIZtuumB45E9FE6Xlxt3wM4/BdqC86SG56mR2N6Z95cmLbZmamT4=
X-Received: by 2002:a05:6808:200b:b0:3d6:838b:8286 with SMTP id
 5614622812f47-3d6b2d19c2emr13789397b6e.16.1719988519945; Tue, 02 Jul 2024
 23:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604085401.14733-1-qiang.zhang1211@gmail.com>
 <202406051045.FpU0Oi69-lkp@intel.com> <CALm+0cXzhGBa6v4d=Ky2QWJbfD_9neQJQWPGOp9USAaf=ghsWQ@mail.gmail.com>
In-Reply-To: <CALm+0cXzhGBa6v4d=Ky2QWJbfD_9neQJQWPGOp9USAaf=ghsWQ@mail.gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 3 Jul 2024 14:35:08 +0800
Message-ID: <CALm+0cWRKsFThLzMS_AL16SVJJba0W-iCvgF4_P019LYs1cmEw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
To: kernel test robot <lkp@intel.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC: objtool maintainers

On Wed, Jul 3, 2024 at 11:38=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> >
> > Hi Zqiang,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on paulmck-rcu/dev]
> > [also build test WARNING on linus/master v6.10-rc2 next-20240604]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks=
-Fix-access-non-existent-percpu-rtpcp-variable-in-rcu_tasks_need_gpcb/20240=
604-165702
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-r=
cu.git dev
> > patch link:    https://lore.kernel.org/r/20240604085401.14733-1-qiang.z=
hang1211%40gmail.com
> > patch subject: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtp=
cp variable in rcu_tasks_need_gpcb()
> > config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20=
240605/202406051045.FpU0Oi69-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240605/202406051045.FpU0Oi69-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406051045.FpU0Oi69-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
>
> Hi, Huacai
>
> I don=E2=80=99t know why the following warning appears when compiling wit=
h
> loongarch64-linux-gcc.
>
> >
> > >> kernel/rcu/update.o: warning: objtool: unexpected relocation symbol =
type in .rela.discard.unreachable
>
> A similar problem also occurred at this link:
> https://lore.kernel.org/oe-kbuild-all/202406211339.BCuCbD2g-lkp@intel.com=
/
>
> Is there a patch fix for this warning?
>
> Looking forward to your reply :) .
>
> Thanks
> Zqiang
>
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki

