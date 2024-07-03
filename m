Return-Path: <linux-kernel+bounces-238780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40947924FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14AD282442
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80B17BA5;
	Wed,  3 Jul 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij0byUZG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D5179BC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977924; cv=none; b=hOouvXhIYKRhWAcEX2+TO7ZVUJ9qQ4v3wUVEkdn78tnE+QDX+ochpeZCQiF84bz3Cahlpo63fnvMMUWbavnWf2krOhBKnlUV21TLWyhGy6uCM/EFl/6HZqsxK6tR0fYq5aBeF+9nKJWZQznc4yte3tgwCEsYmbxozI6rRtLxQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977924; c=relaxed/simple;
	bh=7E0L3ayeoehe14VRvUWttkG+EMVCsLOVxsjrEwxDQVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZbf5/4jgvGb3VxKjfc0eviSjpkg+GV0ou1jQPbT0juKDppw4cDaF8avZtDSCieGQg5zWyFHE7Ez+7nBCRtYcIoyuRaWkxdU9Rchfbicmvdk/0icIDOlumE0Tkw17/OZlBkfpLweq7L03WmUtomPXso9ZilBl1dRXHRgX9u9i1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij0byUZG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706683e5249so3348601b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977923; x=1720582723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFeNnk9qT4L6sojA/V2elbWNieJhTkbP7b0DlBRhIUI=;
        b=Ij0byUZGT3uv/GyRkeX1HrenGeFZo9vkzH0dJg4UwLO/AtAQ5Ty3MjN6dIh7j3iloM
         HZ9yX8pkMBJvIeYWBmCplQ9kUJ369Dj2kwG8CvHf9imJdOR2uFAY56BR72gZQBbgH0ch
         rbc8VNYpcuVZEAdzb+Nz3uNNjMs3th0Gza4If8udOEFqtpa/09r6Wfz8y75ZvOxsMCFC
         6jVVIynFMZfV0Q6EkQdHFipgHNBtrQXCP5A0K8JsY/6QD56lGSINAGocH0fPYVxQTr0f
         sZGpZPs9ZFOuutrVnKDnKfZLXhu7XyIZbaeRHtZEznbeMhglq9xFbY+gUg6zCva9hJdD
         J7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977923; x=1720582723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFeNnk9qT4L6sojA/V2elbWNieJhTkbP7b0DlBRhIUI=;
        b=kvB+1S7+KZJ5uCj8ZO0ba2ArLFa5hFZp3jnmDOqs64BBzOR7lky3va8DvMPn3BSnxf
         T0oeZxie0ACSvPrXlU3OczhSUSFEpAShrHLKnMt3bWYXuqEPLXMBNs3wGRqzsKRV7dQd
         H6hGmt3KeBWRaYiVFvby/37NUTU7cC1vXv2ArxU7pBocveoJ0eIr/YhoJ+jUnIfvrww4
         pcHsEw1H7LVFbWDVoX7HXerOAHiXo0qxPFa+N+uPeAZZKOAb3MtmVdKaQgSqV7fzQSs7
         Ka7fvJwvi5PKNJkcXzhPt+yhDlftaKi75M/LzG06kZ6/BFDU7GX8ulnY9oZ2x5qOHF2N
         ReFw==
X-Forwarded-Encrypted: i=1; AJvYcCUNlq6DUubXroQn2V1RZXTfErotrZoz1P93wVntSPuSyha0T7ooIVzRXXCVQTPy6TzAsrZRCLZqpzn5uAkY0LzpbJpelq6lLMOLPiKq
X-Gm-Message-State: AOJu0YzXYrdL6TrJbsVnsFL0SHcOCicF3s2D52AylyEQK/0k8loCW5Ec
	1oxikxo1h7tr4AJ2Oi4Unzv3oMSFP/Urq6uYR23eNj6YLJbxK9uYFB+ccuVwzN5TnEVbudSuKIc
	K7C9WJTz5rKyrvA2nBeZoDtV+vDlQ6pTk
X-Google-Smtp-Source: AGHT+IHCTFQ21MLy8F4gh2j+EE39qFrRvqnxbUsXOgEM1RbEtVu69eXKJ/eHWsd78WNudCzdSPgbUi3xZlFZvlXHm9s=
X-Received: by 2002:a05:6a20:ce45:b0:1bd:4bb8:6509 with SMTP id
 adf61e73a8af0-1bef6224c5amr9852606637.55.1719977922504; Tue, 02 Jul 2024
 20:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604085401.14733-1-qiang.zhang1211@gmail.com> <202406051045.FpU0Oi69-lkp@intel.com>
In-Reply-To: <202406051045.FpU0Oi69-lkp@intel.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 3 Jul 2024 11:38:30 +0800
Message-ID: <CALm+0cXzhGBa6v4d=Ky2QWJbfD_9neQJQWPGOp9USAaf=ghsWQ@mail.gmail.com>
Subject: Re: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
To: kernel test robot <lkp@intel.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi Zqiang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on paulmck-rcu/dev]
> [also build test WARNING on linus/master v6.10-rc2 next-20240604]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-F=
ix-access-non-existent-percpu-rtpcp-variable-in-rcu_tasks_need_gpcb/2024060=
4-165702
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu=
.git dev
> patch link:    https://lore.kernel.org/r/20240604085401.14733-1-qiang.zha=
ng1211%40gmail.com
> patch subject: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp=
 variable in rcu_tasks_need_gpcb()
> config: loongarch-defconfig (https://download.01.org/0day-ci/archive/2024=
0605/202406051045.FpU0Oi69-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240605/202406051045.FpU0Oi69-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406051045.FpU0Oi69-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):

Hi, Huacai

I don=E2=80=99t know why the following warning appears when compiling with
loongarch64-linux-gcc.

>
> >> kernel/rcu/update.o: warning: objtool: unexpected relocation symbol ty=
pe in .rela.discard.unreachable

A similar problem also occurred at this link:
https://lore.kernel.org/oe-kbuild-all/202406211339.BCuCbD2g-lkp@intel.com/

Is there a patch fix for this warning?

Looking forward to your reply :) .

Thanks
Zqiang

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

