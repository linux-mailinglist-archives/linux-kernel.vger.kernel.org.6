Return-Path: <linux-kernel+bounces-258784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DED938C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686F02825CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D716D9C3;
	Mon, 22 Jul 2024 09:48:17 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DB14F9E7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641697; cv=none; b=bq0NVrUA44RJeOmLq2D+h5KMwho0jL6Lnv2SkHrZqrRVVoTyugwPyEZORhLeKG3RyFc+NLFEHMbOUbDb6yo0Dogi4XyppE4r9zE0UgT3sJdj/uYKDLOxSO9DiCyX1JixC1DEzhVGm4axtJqimm9g60Jkw3zYqrrGFjfeVbCpVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641697; c=relaxed/simple;
	bh=2YwLNxddluGjrA4vtlMadoo1UAoVBHINyeJOH2vP+ng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FpDELbJv16JhIf4uHPRq/MHZhB1l7W1ZMdwGRNlIHftiKIPgPsnDTdzF88ppaN324PIypmhBfMSRAy9MrWg4YCLO28RRzOx45nh/6hCJnTmKUA+WjA/ezCciOrQlERgSgIT6AicuuXPzFOIA0OV3zlLN5GtuNoC24GoUtCYur/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-800e520a01dso681202239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641695; x=1722246495;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YwLNxddluGjrA4vtlMadoo1UAoVBHINyeJOH2vP+ng=;
        b=J4ifJrhhUbbLCyGcgKhlDJpVbHH5jPdKyiNfalKFAamyykwDolx9bwrLlQIb8flQ96
         VuIZdgdgJtdSva/bhG4JJUXkfSlkDt449iUxQbUsq3+3/L78pnoIIt+idh2cV4Gky7n4
         FLh/lr4Nzey7mQSi8zl0jmrXhME/MWnZ8B1UeVOnQ2zZINnWnbCCPHwo/s3/+a0bogEZ
         jjN+XbLU/YdIP+n5sGJyLpZm7kLheO+yqV49MxCMivyXtZPYPGSuNFyRnd6nQT0cDMiY
         arX5ua/xF74scE55/0jn3ypT4l65CEgiq/fk5AxZM6VTuy0VwQ3FvBQYSld2c+qEBB5a
         bHeg==
X-Gm-Message-State: AOJu0YxG9S5iKzvlVBLXzwEIk5DHcHJEH63aeozXT4t9Q+OGBS9nMb4+
	DZI5596eiE7EUt1af9Fjh9ebmxqzheP/Vpwb2LczdyKQkS+qmF3u0ccRquCxKRrtbuGhv5zCIi2
	i/rMno2d8oNKJONhnCC06aJm/I/E3uGaW1tiMVGgRDjbPYbh6ucT9Na8=
X-Google-Smtp-Source: AGHT+IFDwrcp4FJs+sDtHNsjb3MU/aEwN7iW3niXw3LA6Tbhy/GcZviG/i6og95dUe6HOA5lSA1ph2P07krmA7SIl9zMoCrTwzH7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4129:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c23ffe1588mr467929173.4.1721641695020; Mon, 22 Jul 2024
 02:48:15 -0700 (PDT)
Date: Mon, 22 Jul 2024 02:48:15 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a99e4b061dd2f199@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 605c96997d89c01c11bbddb4db820ede570581c7

