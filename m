Return-Path: <linux-kernel+bounces-212344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D9905EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065FBB22BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41A12C482;
	Wed, 12 Jun 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtaB1vl/"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634F28385
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232921; cv=none; b=DnRbNNu1bqDykSXeeANtidMgcqt7+i0XSUrVMYV8M0uwcawuJDbITmjE94pl8OHEuee5NntPtQtawex7JVN/fmPh+gG91j2QK7xUK4fATL5hB8A5kWhSHElorMJxCMENlgMIpBMvtmvWaQpr3U88KNdha4hV9kbcOEpp0LC+LJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232921; c=relaxed/simple;
	bh=z3tDDj89rfmINXLMcGNLsdLB8zuhZpOsRvntGzdiYrg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V47ang+dqEV2khBtOVaPyKuwpDKqhFVlTWXYqB+E8JwNrmPK4SLxc2gcmBhrRIaxyJlG4CiwVuPyABdiicWRmO+4dz8M5Wy2Fa24LpKWhS3hrDtZunL1ocwTTTPIXaeR1f2tpGzducGUT/LoAVMrEyHHKAgKse3Gs8bufFDN+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtaB1vl/; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso234229a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718232918; x=1718837718; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+z8cRZiNQCnctDH6K7s1jA+oKJEoOHKff33HnBHJMQ4=;
        b=gtaB1vl/A2zQBgGo1xApo2MKrURJRIICOBi2wJ+P26fobSFX39uzgyWVADlCUNDOHo
         ySHBFZJlB2VXNAuUa4KeuRtE699luLM2w5yLxA59pNGmCFTa7k8RMGWZpQztrp7tev98
         aQ1zYuPzsKd4dRRf+xClQ1zhbtNWoAmAJgyOo+ng9GZ1cfdBezXuGfx6keyhopWHyb3M
         vSacf9suiztPaunmRxKHoWxDxYwQd5y7XngdldLQdU/LRRCvQlaB5/TsmZF0fqOb7A2w
         f2r/XAjlUtpwrrQ82NPFdgr4OmdhVzqovJzsO5lJJ4KAA0BmnZKyG6lNcJurCce9Alkl
         V4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232918; x=1718837718;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+z8cRZiNQCnctDH6K7s1jA+oKJEoOHKff33HnBHJMQ4=;
        b=t89tG58EplBk/3Qp2AhTPI1Lsk6aSYDntpGXqaMJR2Al8Drpz5QvYdSm6eIFa1kema
         knqskjSYFnExVnVCxnUq+/ziIOG73Rkt1FuqIkTAFsLyHcL1JTpeerpblXbWPHncEuLJ
         jbG6j7GmdCSy9bK71hEYuUs1v2QieqPpPjUQM81O2mXnqk2YKWuCZsdMeoXv89lpQeNz
         UykZ4gE8iqKzZoGy1h0CfG6x5ISg/ypa0KZqmK78GoxEC8xFoVL16kdEhDif9p1/e3Tr
         Ls2toqO0+tDY2UYQ/0JOz6KJvUI01LzEWen+60/qre62m1x+7v2p7+dbiHaJJ0htgo4G
         hD0A==
X-Gm-Message-State: AOJu0YxmLXZcPUwLwpeaybMK02dh4Gqo4yir72cQo16Z8yR8Ky4kKbnb
	NFjLVe5phVPKIEg8mA1BCdEU57rzFAmLdgUpA7vn2mBqBWmboU6DWVplkFu31XH6z7hKfBXg300
	XVmxiRVkjkQIqInnKezHwMX32Q6KakzMosccn/NL+
X-Google-Smtp-Source: AGHT+IE90+6n9IVKxvz9kiCU5LH4M/Bhiiz08Ttd8EB0jju6bTB7B9qwXJaJ3ioR0L62+0YkA/Sz4nr+zIKq626h8RA=
X-Received: by 2002:a50:cd42:0:b0:57a:2400:6fb9 with SMTP id
 4fb4d7f45d1cf-57ca977baddmr2483051a12.20.1718232917661; Wed, 12 Jun 2024
 15:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mitch conner <mitchconner291@gmail.com>
Date: Wed, 12 Jun 2024 15:55:07 -0700
Message-ID: <CA+gwC3Xz2gqTBW97GAVZ8ZRz8+zdzRnwZT4MxY1tvcj4gx65Bg@mail.gmail.com>
Subject: linux high mem mode? module/s?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

i dont know kernel programming and space too well so bear with me lol =/

this is how much ram im using with fedora 40, spotify, and firefox

total        used        free      shared  buff/cache   available
Mem:          128492        4426      120359          55        4863      124066
Swap:           8191           0        8191

which is cool, everythings snappy, fast, well rendered in nvidia

but if there can be an option in the kernel or a module that can do stuff like

dynamically cache libraries and binaries into memory or gpu space
(could lead to upwards of 10% speed boost with speedy ram, maybe the
entire /usr/!/bin dir)
dynamically cache files and file system stuff into ram
possibly provide an interface to storing large portions of data into
the kernel (would be nice for video editing i think)
maybe some kind of organization for memory for a speed boost (like defragging?)
maybe some kind of paralellization for ram reads? could be a little
speed boost (ie instead of *mem = *alloc(); you can do *mem = alloc()
? range0 : range1, or thread everyhing or something, could save
possibly an instruction by spending some time)

this is the best i can do.. looking forward to messing with 2.6 to
learn about kernel programming in a vm

