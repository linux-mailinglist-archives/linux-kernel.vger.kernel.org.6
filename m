Return-Path: <linux-kernel+bounces-258734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A60938C35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24F7B21176
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC416CD3E;
	Mon, 22 Jul 2024 09:43:37 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3516C871
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641417; cv=none; b=kYc0L0bXYAl7m/CtBF7Txb8OtQhNKnyjHzHTv8PdYBn/38XAZM2wm0a77NKjx+LU+RFrIzLb9QnQfvLs96vUqO4MVKkmGqoAshH2VmFoeXxR2jubuWXNhtIMgQkVKSlzLE1UvKb+511GTMhA7h9XOZ5aSStsmZSrKFDEFpBoWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641417; c=relaxed/simple;
	bh=98CcH8h5Uo+K2h5F4B2X26KoGsGXunfhDi3v1e25Ig8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y137gZfTyY2E+zrLdbkA5BccGQNLN6teR50EW9eA/+ZHO17nWf3MIsA4r2NvGZgAAMRc5A5DXPP4lYMKbSp9zlZZuxPsZenb45603bvW7wy8RrF0kfWCAScbogF4jhGRsFU6n6sPgLuQ2wc5HrOZYgvv+MzLCIAkebscTAikEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81258697716so723767139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641415; x=1722246215;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98CcH8h5Uo+K2h5F4B2X26KoGsGXunfhDi3v1e25Ig8=;
        b=UFT22pmWcdU4fkIo5WVvHPJjL9msKHTppVV0VMsRhnE7LVYwgXLoFGpb1/CqQaG/zj
         VyReS5ofWrOspSwDbnDf8s1hCNrK88V295sqKDvnh51EIICCz9+nihHO5toYY27G2Wjl
         Ki/5bdAGV3zJrlDUxvSOjx75db47i+HERp5yIpbbiGZ3Sr6wJgzKPkez52abv95JY83K
         lba2eyOdTiEmhay+KwWMa3t/w4V/4+YzDNTJRpYcJ7PL0J3zB1vl/Op56nah6cMF1nSO
         ft+nu1Tt8W/dtxjKTflKuomJB5yMmZNqj468/9qIQqBzUB7sioP6eK1PzD1/yxBSPRh9
         DhSQ==
X-Gm-Message-State: AOJu0YxZ6wfMEf5iL1MWDQMoYVC8Z8mCTmns/BswNrWFoUPePi1EC+b4
	bu491ixxnnyEhJpzVew9DN7TuEihf3ONjSmJxP3IkAznLYRuigCKvSoZXO5wUHMS8ZMCvfFGB1N
	OZBh6u88CVD69T7OyS7wWUvru6/Td1O0dzVGvpbSSAR1ciBdKm/N0SZU=
X-Google-Smtp-Source: AGHT+IFbZu6pB39qo4OnK1ioS5641BzI4gpa8GMuOMDE+jGd5YjjvxMPWZUdnrpsyPgncy17AcM0skfJFENMB4pDvPj+tQaPgWKu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8323:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c23fe4534amr510241173.5.1721641415245; Mon, 22 Jul 2024
 02:43:35 -0700 (PDT)
Date: Mon, 22 Jul 2024 02:43:35 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc968a061dd2e004@google.com>
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3b2aef99221d395ce37efa426d7b50e7dcd621d6a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69

