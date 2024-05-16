Return-Path: <linux-kernel+bounces-181181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E38C7895
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F621C20CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5014B971;
	Thu, 16 May 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQc2NPRe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF911487E1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870682; cv=none; b=GDDAU7HGPQyDSV3fCFjwxb5GZjIDKqnKzBzfY06FLiu4U9N+KJfANcn1amMYXfmfSMKV2CCDQhRU5lZKUEZttKkBbfj2MFHdbNGAh1yh+fQhcza2vIZrudbjjvYA6OY/h+cjGldGUY74AI6LPI7Ne4XO1YpyNo27c0ADNNhN1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870682; c=relaxed/simple;
	bh=FOX+t8adatt0Fg9qcP0RK6OJQbGabs/91S6NaXleRyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1VvCON2ma9h6KFGyOA4uryw1Jz3brgPFRr55n70pjPpq1oT4DwBXhx/IfrcG5Pjf1vGOBcPC4u4b3TKBvMOWV3rKVQ0pgEFM3oTF4dR0FS+EvS01hgPr2Eg/uX5ZFfWuxr2D13YBQ31Gfyv7gH5S+MshiEvAvRHO1JVayqx4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQc2NPRe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso58058a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715870679; x=1716475479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3hdsUIbiqGpCUujcTMdexhf6+/d30GyMrIklWzNZiKA=;
        b=ZQc2NPReWj9V53F2qysxIJzaQdOAQQsx2htl03eqiBQX9yl7K1Q1BgtXlU4iblZNQz
         FuIdfBP9HG0ry2iC0oOS+z8cTgc35d0nA4qepgKf4qAL/M662mgr5a+mZnv3WTdNuet3
         BR8j66hMEPSmL+CFCbi7hWnUzhdz4O45/GGZHG2c01SJQ6ijmjl5ZJoAszRppqPG1Faw
         WvyOkauBjPek0ji9YSQzI8RIiWdcsxIsnaVOLcF8qd2+qOgWBEa8bMfnkh1a5UmsnVdP
         QqHclK1fv32xoHvUjM/MBIHlHMmVxtlJeh+wG1Bq2B9xz6gCyKX8Dw9kSB0Mi9P3Oeo1
         ZaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715870679; x=1716475479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hdsUIbiqGpCUujcTMdexhf6+/d30GyMrIklWzNZiKA=;
        b=igHMpkA3O01xsxp7YD6w8J90rLEjHUN0FAlc9Ja6TRP+QD74O7BJOCLPIJarNRChOM
         ZBMQZBK1gijRB6izeJ3YXJJCQ6KHSyizdVkNdovfGcIC7Z0qM+j87bpa4qHHx//l8Bts
         HjD3G5277CMnNk99r1fLlzb6gAdp7XAAZYUBpfDabEbLogTbsvbwXSEVc2+kSOKZxlj8
         B8NbG9YVauFOsYuLCu52N+OlgU0Z0z3uX3RFb1qPXFDRplEu5sEdlru1Ne1IQ8VwXfjk
         Rm+DL+8rXYlQdrFaQE6Je1kmbohmQl/sCOczft/N40ERvc3Gu7W56028UmvWIdzDJe3u
         EndA==
X-Forwarded-Encrypted: i=1; AJvYcCWF6I0OOPiF6fh4SIJN+MTGStCQtcVoOxBS0W3TZ8k8CjUXgWGDyZ+3Ezpw8YJq+xy3sGCfdj0HiPk6jfsTKCoHZ4CJS9oIxRjj1NWU
X-Gm-Message-State: AOJu0YzeeN/EMiygBYe1aTgKz2gr8/hzZyMC42qXLyt/AdEJjtnNziqv
	SEEMQi7IQk4XyDcbnQLRDT5xiOkBb7abFI3aIEiBFrmQOqXGPAj+qC+cdNTF2SWKujd9QvoS0MM
	+lDH/dAW05RxI8Y6nKzl7ydTmoUmZcBTmzviy
X-Google-Smtp-Source: AGHT+IEvvbEVz6M4H+a2BOT7mzVYWga6hAWzCS+HTj2StATG72GaAp+eVZOoe7oU40zg4yX5OVpzwnUE/hJelBSCPWw=
X-Received: by 2002:a05:6402:2695:b0:575:1005:fa93 with SMTP id
 4fb4d7f45d1cf-5751005fb40mr81171a12.6.1715870678677; Thu, 16 May 2024
 07:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5B9F0C1F-C804-4A9C-8597-4E1A7D16B983@gmail.com>
 <20240515224932.GA202157@mit.edu> <2184C9DB-DDC2-484B-A1B2-A1E312B62D54@gmail.com>
 <20240516135821.GA272071@mit.edu>
In-Reply-To: <20240516135821.GA272071@mit.edu>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 May 2024 16:44:26 +0200
Message-ID: <CACT4Y+a3Tvh5eQuuCcrFuBfzAPQMVwEh0o5jLtASB_xVnKt_cg@mail.gmail.com>
Subject: Re: KASAN: use-after-free in ext4_find_extent in v6.9
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Shuangpeng Bai <shuangpengbai@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 15:58, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, May 15, 2024 at 08:33:33PM -0400, Shuangpeng Bai wrote:
> >
> > You are right. I disabled CONFIG_BLK_DEV_WRITE_MOUNTED and found
> > this bug can not be triggered anymore.
> >
> > I am wondering if there is any suggested way for me to check whether
> > a bug is reproduced under a reasonable environment (such as
> > compiling config) or not? If so, that would be very helpful.
>
> As I mentioned, the upstream syzkaller always forces the
> CONFIG_BLK_DEV_WRITE_MOUNTED to be disabled.  That's the best way to
> check whether the bug is reproducible under a reasonable environment,
> and to do it in an automated way.

FWIW we provide configs used by syzbot here (upstream-*):
https://github.com/google/syzkaller/tree/master/dashboard/config/linux

+ a bunch of configs fragments with explanations why things are
enabled/disabled:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/maintained.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/base.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/debug.yml

