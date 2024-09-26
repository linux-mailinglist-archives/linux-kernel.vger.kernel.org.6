Return-Path: <linux-kernel+bounces-340001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB8986D20
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F044B24BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F317B4ED;
	Thu, 26 Sep 2024 07:02:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51E139B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334125; cv=none; b=AR/rrJFL68nADnieMCqKqw4mU8QKBF/6u915/q/LM/UPxJqAVwWDtXsHIx5cU53FHmB/ig/teskSYp3ojwY3REAyLeul6L9wF1pYbl5T1Z+rV2Zw7gU4J5TDxWBmlqO49lLdj7dPLkEzjrsHqZyNqWgXEjymdnp9euCRMmGfJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334125; c=relaxed/simple;
	bh=CcL1Wzmx+49fEwwfRotpU+plzYfZsl7YGB/JkIL9asY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XNiGacx5fE2Gg1TxV005+AcXPJvIKzpOeW524rB9dOB74KtTOyNT0TljDvDh+KQHs/WbOrF05F16dKNgdewhgOOAUuCgoMhXAEgkX7B6OUPuBIksk3zaeTL07POpAMG9oUniBjqJ4aZo/y1p//QRkENel6qWN1b6IerJkvAO/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so9063095ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727334123; x=1727938923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAux1zDRI6PDyr3CanqnYb08fie2+EkLS5u75c4S6O4=;
        b=soctjsvsCC9E+0Cx44keVRJxqb/O62VOqsFou+34k4gL0ssfoqg3I9eUpKwDu1GsKg
         o/mBIJwWA2/MLsZpartWD3Bnp0HjG6AH0KEa7fNlMtgulah4dRuGhyx9R2HKSkgLZIrk
         KH/F0uJQpYkxcRHDid3HMbOXPtHhXn9VujW4Kx9+yRIaFc/f1ruwLqygwkfszEUcGApj
         oscAi1XzPugzrMQ54fbj5Cxc8OxmBFSFNuSEkmmSoLVxGbD2DlTYa/Fpz5EN0e99ToK8
         2MhxADzj4KmBdzwYXEJsNjXizPyngxS1UfJgwrSkY/5ndDxmzO76ZlM5oKg7LIfvHRnk
         W6PA==
X-Forwarded-Encrypted: i=1; AJvYcCXTJajdoYC4ByPuVI4GufeypZp9DmWqkqYw9MAMxhwXhIe2n3BhJBWj2rv5RpYjU3mhPyb7pAl1yjt8JGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOP6oMc87Go0bXc8fJROAZesqhE3VrnfxlhvWvAN5oXyx8RS+Z
	Mf46UrnKxlOqBztDG8VlZOjrv3CPkTMMzVHPZdC5OvIJ35MwscBJdv++eWUWDAWVuRLLV+pXtPb
	fPewC+IpkzbQDsjHNCrQEG17j7TPMx6ybRL2iOA3U4gMfce683JV1KdA=
X-Google-Smtp-Source: AGHT+IEmtjMSo4Ky0j83VDs2MpvlErwkWo5i+u9hzLb10jp7NUfSHrchDCEYlykAnPSUEEM5nl5pnjDcQK5nlJP++Vx1nEl25H2s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3a0:90d6:1f39 with SMTP id
 e9e14a558f8ab-3a26d6d9d19mr60054285ab.2.1727334123097; Thu, 26 Sep 2024
 00:02:03 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:02:03 -0700
In-Reply-To: <ZvUCRBN5vKJir_IH@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f506eb.050a0220.211276.003f.GAE@google.com>
Subject: Re: [syzbot] [iommu?] kernel BUG in trace_dma_unmap_sg
From: syzbot <syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com>
To: hch@infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
Tested-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com

Tested on:

commit:         11a299a7 Merge tag 'for-6.12/block-20240925' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1337f907980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=541d4ace1fd6e55b
dashboard link: https://syzkaller.appspot.com/bug?extid=95e4ef83a3024384ec7a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1147f907980000

Note: testing is done by a robot and is best-effort only.

