Return-Path: <linux-kernel+bounces-222070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC590FC71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C1BB23DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE373BBCF;
	Thu, 20 Jun 2024 05:58:56 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE139FD8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863136; cv=none; b=BgCKKxTVwafkVnSPgTzBxpGydr0luZdi7r/3m5Y0pXywoFnyd3h75CPH3LhpwEMY6AHJrVcWwJwwIRtouUcncGsGT7Sq5EqMHJKjXxyJnXteMYDVtsG8SAme1NI9PkWWJHolt5po/YJcVlw3z9ON2TBFFm2VpYkUlrDb26OoELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863136; c=relaxed/simple;
	bh=0zQ+nBlGQ1lY+Gri1x+Ok8Lh/nFqFkd/+7G9UuP1fko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lf4hPgkxT9olCgP+vooxXukrD0esuVO9Vu3KMaXIukLQ1dztcF61MtfUeZG46eMCVv8EmiLbudXGFPj7Y0mOYyl2SqhhFzNtAFyBAypGYVALF63NmnVWMs1n+pfGwckEpWYxDThW74AK3Bq1kYq0gBqChvBayYat1vN0q8qs75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375beb12e67so4817715ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863134; x=1719467934;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zQ+nBlGQ1lY+Gri1x+Ok8Lh/nFqFkd/+7G9UuP1fko=;
        b=FNSl+3zhI5ETc86mCixIVtYxyKzno2FZ8nG+aSxmdupX/i9/ZbNUZ2LFyKxUoiAvy3
         wpdY7SWtMichJipzcupnGYyx5zuc+hyqT4anNRMu7y4NmWyFMIgfMqRG2JrqbGNamt2N
         bhXxscCpMlV7xNBsN0z1P3LBjyLf/njQaku2IcrE73Ac+hpa2dVQsTnNuSybrIKYlmDT
         gpeDTzNTh8a+9tBqsNpRCY/X1OkCXCq2hrpdDN4Bj6eKVEuW9jn/KhiFc0yQX3afO7f9
         VKrUck3RE00Ysb/35TXgro+4Bet9fgmBdMzWgg1n5A17j8jq/GFXN5hXRQWPiRDOdLXN
         0R3Q==
X-Gm-Message-State: AOJu0YySqxgTX5pREeD1jMWvW6CR78ac0GPqWPSBCLRTrtQiKx0H05t4
	SUePpLHovm4lxnFY3CsvbO7jXG2BcDw1y9GE7Nar7jlxhqFOyrOcxLcSMKtr9xqvZTx6Mhs7dH+
	kQvj/AdGRNtWmb34IQ11/FYjZDotjfoGwBOpRwXrvQuy8tJPqtxeRshk=
X-Google-Smtp-Source: AGHT+IHrSIGRgzASmdZYo4Tb+lqab6/DpXEJwXryKKQLqhUW2RcpC/CQH6pNRLwetHtu3YCgGdZe7LK79kRct58AbN687U2fhS/x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:375:8af5:8d15 with SMTP id
 e9e14a558f8ab-3761d77485cmr2521275ab.5.1718863134274; Wed, 19 Jun 2024
 22:58:54 -0700 (PDT)
Date: Wed, 19 Jun 2024 22:58:54 -0700
In-Reply-To: <000000000000be1f530615efc5ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000894783061b4c0231@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in sock_hash_delete_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux 0=
daa6e5ed1ccdeb65e07d4884961a8bb288a0f54
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

