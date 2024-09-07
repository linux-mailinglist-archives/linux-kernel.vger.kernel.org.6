Return-Path: <linux-kernel+bounces-319865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48767970334
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C750E1F22264
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3415FA7A;
	Sat,  7 Sep 2024 16:48:40 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70415AD9E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727720; cv=none; b=bTFSQDl9t6e0ZxSnkFon2DJ8QHb60vb2rVCCgaUPYtb5QOK/ptVv6Aot7/3Q4HnkFNHEyWxrnqh15y4SL//J+dr1q7zG6+fj3Xkynklgj/MagZLbWckPvOM+a35tliaYoru2JfzYuzWBkohYMadAOsnJuVnjspJk4OLMWqX/Hsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727720; c=relaxed/simple;
	bh=BN+YADuT7LjdewdR7VFYpiSoJesNP4nVF+nC3O/aXzs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PhvZ+kSxPRS9BseRvFJ0Qc1vCC+87mjhYY0vnjIBHWllwo3D7BybPJts208szJO57zAVpZqBR64O4UO/EhHsjRdA5n1LQNdVdQjkGdmSYz3qIEUqm7Z0XiX1gXCsxK0FRH2bajIrpbUTwhmSh6ZQO1z3NEffn/tSdpyytyR690k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a206312eeso613507139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725727718; x=1726332518;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BN+YADuT7LjdewdR7VFYpiSoJesNP4nVF+nC3O/aXzs=;
        b=wxwZBnlwZn/aDNJQWG4bFi8FjWU1yEwN/uxy+Qyirt/Qe4kYGFXy95Hctr0Olu+/eS
         9sJBKFuugAsPFBGPRWscGQSEKmPEmmWXrs3BKaJBNBRxWu7pfEGrh7Y7hTU+KUnoFgdR
         sySGU1E0O4/E93dBybkDvKijg3jLoS90QSjVOw2AiWh+a7myym+T02tg5srL4bbONOhF
         Kj8+/FQ3UMNxhXgZbmGIInQVw5Rzc8K3foMUdDgCKEZYzmAiKVLAe85k3YD8TPNFX6Ex
         00O/FAvMBPG98+Qfb0fXVdM6W8VTl6GA3lSBdwc1RAf2FrEJvmFi7NirDljh6YwoWAs7
         f8pQ==
X-Gm-Message-State: AOJu0YzvEHUwso11Ct9uVQ+uG/vZfbVM4cJdee8yiDFliLnd0zuD3u5L
	nO7RzFc0U22/wQRRxp+tXz8f/8GBtPvtyU3gMmcLgwK7YwtG8t99W0qghL+dhqyjdqHAdexcYjQ
	rYfIIhSa+RoEhEnelON8k2pUCuvrvcon+qCIugtNh+YtwS3He8Jy37xw=
X-Google-Smtp-Source: AGHT+IGF/D5SX/jd7b6ivgyaTWpeihFa/jz0f2Kk25oGHjn99h7rpldoh/6e649BVxNfZVYD9tIv1j667VUn9U1L672oYSLYwY4t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:376:417e:c2ab with SMTP id
 e9e14a558f8ab-3a04f0fdb1cmr1707965ab.5.1725727718192; Sat, 07 Sep 2024
 09:48:38 -0700 (PDT)
Date: Sat, 07 Sep 2024 09:48:38 -0700
In-Reply-To: <0000000000002f64da061e021fc2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f4a4906218a4b5f@google.com>
Subject: Re: [syzbot] kernel BUG in jfs_unlink
From: syzbot <syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in jfs_unlink
Author: ghanshyam1898@gmail.com

#syz test

