Return-Path: <linux-kernel+bounces-209596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9599903828
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B302896DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806A1779BD;
	Tue, 11 Jun 2024 09:50:48 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600EE57E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718099447; cv=none; b=RmDDGnN8Bsmh6E93tpQVJmRnYUGxlKo0W+HkYyHlWV6Ux5phbCxXc/1MBZusXwuBFDaaNqikVY7/vBeN+g5Xd4jCTgEADrX08Nc/G4ytxFPaEsCv4y9L2iwtcOPgtNIN3imbd/qXZpyCSSnpXeLzi0NNsBuEJcAjRZIaBrum+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718099447; c=relaxed/simple;
	bh=PTnT7800Zf0dBf4vWv+RMOy353rooukdlsSDSkMJuI0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=goJdqk63gh5QnLH1z+0Cpqzl+KbagTGpGYZgWYrDjAR90otory0X5xil/No1x13H1nMwNaocHG9ixze3oViBf6mpoUHEG8ItFgmabU+2ytadpmMZ2weba1wIjfiQF2jN++tcxTJpUOVPW0eAIOFY4YC0qgCUDxkFNK4dkPr2yfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb61de14bbso448484339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718099445; x=1718704245;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTnT7800Zf0dBf4vWv+RMOy353rooukdlsSDSkMJuI0=;
        b=cvqi0h7OvkYpOhK6Z0XLjpi6MAKFytao/epO8fst0GzdGsqusqaTmty1LcV8S743Es
         QJ8Bh55jk9DytzI07whPLxhaK4i7wKAW7z+NeBFl9X5/nuImWZAxXYTctDgkHjFQEIIj
         cun4CbYo+D5QzsZcKtNu0y3pZh6LFNSBkoLpDV7TvGRe8rLoY5jsdWDCDeC38UK5saWc
         elz5FsyQtwDgHymzB7r/V05tzDglHwbSxeV4uYUWE/JDp74YQMD6a1G2zsOiuup6dn9v
         7LAzw3AMc59v1Dd4EGvljwXDwnYUjyVrqVtgVLzcX8flnJWXKAxo31kHNSHJLzYDRQOB
         fhZQ==
X-Gm-Message-State: AOJu0Yydvbtn8AWTQY/JhyTnZ36AWCrtCxZaKP9VtdWxb50lvkeR0DJ/
	Tr/GkzLPPCBDZQMKSD6rjXTu/S+WYSq9QnzepCDoKdmf7tujvlA6p0J/fwtLhijJWAc1l+DenOc
	aeg85hMMf0roImUEgCg9IAZcQw1xpIcVQ0JYTMABO8IqRtTGkB7ZA2js=
X-Google-Smtp-Source: AGHT+IFIZCb0WPdAXa9CjwZj3aOgmtGjAyphMlWJgvgOaMWZp0hOHjQTMHqrtZ6ubKCfeYOXz6MMZ0AjeQRuVdgWzzF6qCDIZgYZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc1:b0:7eb:7cf2:adb0 with SMTP id
 ca18e2360f4ac-7eb7cf2bca9mr35324039f.4.1718099445587; Tue, 11 Jun 2024
 02:50:45 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:50:45 -0700
In-Reply-To: <0000000000008312ad06163b7225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024acee061a9a33bf@google.com>
Subject: Re: [syzbot] [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_=
percpu_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux f=
2d3b30c96861fc12f905040f9e6cd75dc1a0ade
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

