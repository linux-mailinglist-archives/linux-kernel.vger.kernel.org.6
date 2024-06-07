Return-Path: <linux-kernel+bounces-206441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AA19009C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F3D287E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EE199EA1;
	Fri,  7 Jun 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HniGG5FG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94196194AD1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775965; cv=none; b=cFgw7sZIrdJa72d6HCaxXLdc9ppiXmhc1+pGRoL14tSoSoKOwDBUSoa8z7BxzpzsI5a4or0hk/wcj2Q6C/Od3C4ie4QV89FiYhW+rebeZaNVGHJZ1GdDhfUWUB+1+VW2z3y0i7i1aSzDwD0hXuO3vINCdUiUKNHiYWkC+Z7+kVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775965; c=relaxed/simple;
	bh=gXUt4YFfiuPRDafLm7xloFMmnGXEDO6XI8NlX6N0TuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YUayhomopcG3HWCDW6nwZx4uH/R37cv+EgaW+ouU2CW0o9MX3d0Ppvl9tEgNcrPA+idqoNTtB1OhYmBLIPHSC6WX2B9EfprsX2YXcfQ0TEpiaWPNyS5Bey+f2xpBxUw77y2yQSdRBusRy7dtXXAZiWKoNn1gS3d27O3jm5dd/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HniGG5FG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so674510e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717775961; x=1718380761; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYVQrKDg8pyiWOVvvrQUbElqVQzmxnxSLEHEjPlhImw=;
        b=HniGG5FG1wqS94NsUiIl4bihusdmqvcMwqvZhLG1OfEajP3SpO+Vqsmvu+Qev5iAuu
         u0UCE30bEgv2So5sQdBoyCcCpH0EA3YSnuhZrWdnXSstcqmac2xWXc9nO/edEL4keFha
         4/Ox8WH3dBSzG/9430y3UvMJKimgzVc8pWCuL5f2DEeXZEUkAcp3HaqgvmBdG9EvoAaa
         8t6EVEDo+zCXRMu8jMVEBIvwA8oilbBjaqzzjt/fwshxx+XoN6AXnUW1qJ5MNGeEJTl4
         s0VDbQk4n7h7vxN+C7/QQOzjWBt+wL8INj6KjU062It4D8No4OHUcYY4PfAGuibEGfoA
         ADRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775961; x=1718380761;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYVQrKDg8pyiWOVvvrQUbElqVQzmxnxSLEHEjPlhImw=;
        b=Vbc30rV879zVSgXqSJTu8NXxmTolSJg41v+ggkBVPENUTToWQD7MgB4zctac4Mw5FN
         kWHa5lOIcQWJ9wgjw8INFWxmf/XUg+0T5mIla0QODDMdy52ROAwBddx6XnvvWNPUuj12
         z8L4jStLDR7bwp2hDuhWCKk7xzuGqsigjidooyjjUaFIhoN1N2uqDfrMIW/+KhL6PDPr
         mdSQVNUSTDlZUvpdv39tOQ8NXc4stKTRZi6WeQ+pc8mYWTZ5+6tu43e1+l/IadYmnbWl
         sSHaD3rKBiC2Oje1Lf+2I93TmxJHQPGfOwGkloxaPkRYs8rELvmjP6YsxSZuhCSSs170
         FKfQ==
X-Gm-Message-State: AOJu0YzJaW06MfJsKA7sToLH2/8YcEyB+Edb04zV14bCo9qoTKeSzm0H
	hjGt8xHJHZFvRhgLOmWKQVJJriTYFQ1/V+8now5Ipk6NgwbI3BebVNHEawk=
X-Google-Smtp-Source: AGHT+IEX91X1QaHwkaz6MPvwnsBfCio77WZMiBVDss/yiFoK5nYNJPVkZEvh3D4bo7uZsc+M54G7nQ==
X-Received: by 2002:a05:6512:104e:b0:52b:fb4:1283 with SMTP id 2adb3069b0e04-52bb9f775ccmr3087579e87.15.1717775961012;
        Fri, 07 Jun 2024 08:59:21 -0700 (PDT)
Received: from localhost (host-82-56-13-158.retail.telecomitalia.it. [82.56.13.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581cd9sm267973866b.16.2024.06.07.08.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:59:20 -0700 (PDT)
Date: Fri, 7 Jun 2024 17:59:19 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	Changwoo Min <changwoo@igalia.com>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Himadri Chhaya-Shailesh <himadrispandya@gmail.com>,
	Piotr =?iso-8859-1?Q?G=F3rski?= <lucjan.lucjanov@gmail.com>,
	Peter Jung <admin@ptr1337.dev>,
	Kevin Becker <kevin.becker@canonical.com>
Subject: [CFP] sched_ext Micro-conference at LPC 2024
Message-ID: <ZmMuV6f6nDrJGZAj@gpd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sched_ext [1] is a Linux kernel feature which enables implementing
host-wide, safe kernel thread schedulers in BPF, and dynamically loading
them at runtime. sched_ext enables safe and rapid iterations of
scheduler implementations, thus radically widening the scope of
scheduling strategies that can be experimented with and deployed, even
in massive and complex production environments.

sched_ext was first sent to the upstream list as an RFC patch set [2]
back in November 2022. Since then, the project has evolved a great deal,
both technically, as well as in the significant growth of the community
of sched_ext users and contributors. The latest patch set has now
reached v6 [3].

This MC is the space for the community to discuss the developments of
sched_ext, its impact on the community, and to outline future strategies
aimed at potentially integrating this feature into the Linux kernel and
mainstream Linux distributions.

Ideas of topics to be discussed include (but are not limited to):
 - Challenges and plans to facilitate the upstream merge of sched_ext
 - User-space scheduling (offload part / all of the scheduling from
   kernel to user-space)
 - Scheduling for gaming and latency-sensitive workloads
 - Scheduling & cpufreq integration
 - Distro support

While we anticipate having a schedule with existing talk proposals at
the MC, we invite you to submit proposals for any topic(s) you'd like to
discuss. Time permitting, we are happy to readjust the schedule for
additional topics that are of relevance to the sched_ext community.

*We will consider the submissions until July 12th, AoE.*

This email has a list of people in Bcc, based on a list of sched_ext
authors and contributors. It is far from being complete. So, please
forward this message to the people on your team working on
scheduling-related topics.

[1] https://github.com/sched-ext/scx
[2] https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/
[3] https://lore.kernel.org/lkml/20240501151312.635565-1-tj@kernel.org/

Thanks,
-David and Andrea

