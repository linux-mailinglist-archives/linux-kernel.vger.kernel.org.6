Return-Path: <linux-kernel+bounces-170129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C051F8BD233
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B598EB22213
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D35155A59;
	Mon,  6 May 2024 16:13:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FF155A52
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011990; cv=none; b=fIISapdg5JQuvlz27Su0q6nbpgW6FSySQq1Wmt3R8rjtslSGXqlXmKjrHK5QDtUpEsQ+26PHphG21vsMpo76LuWBO3cOlOVEhlEQRBxn+6JLyRqF4mgvRBsGBC7J91hjtv6F/G4oXZlMcm+l0xsSbtI/XCEMgwdi2Lb08CHlr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011990; c=relaxed/simple;
	bh=ZDuc0bd7d2esyW0N0xgu6X4mLxxg42OU+AYdnX8ztC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WCOqZDnqmUwq32fqqFmqwzMpm2wPvtN1sjToAdVGPv7vPGzeuTSH6xIWvkoyyNHZbWlV5iy5Szb6YjnORW7zFpPFYRWaE/3UirAUpJDdi2qdQ0HTqu5xVR3LXIyfsmgE3JUTbmAmOeNaT9Dj81/W+qeDiLPdhWn9GF1mfyajn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da4360bbacso274374239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011989; x=1715616789;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzW/d3ZqkQk8J/YaIz3cVJ91ezIDBpLnkIAi9wdOK30=;
        b=btTDvHC7zHRMtF9U2Kslr8AC4QpP0A5hP6RwXhqLD0l2i+Tee7DjxHocEz4ylmrQTI
         gTt9VvnRcK1DMstjwhLHUHEkh5ZvJpYuD09jAJV8pcllCiyflS+x1DPN/nl55Rgk0Beo
         o8Od9toM21hz7EYLxnuRf78pNwafHDbTcnW6w7AepkIyV4Rs0daTEssVfMvBvPjbUGEI
         YH3Oe+bEo1xW22i4IuKZYlxSo3X2yKzRr4LLJKRyFYiM08Yqzyq4tRIbkGscEwyElE+5
         4HJe38llbPOU/Sa+A917wTAIbV4DFj4SLyPiNrc40iBc3JaEdd2T3pujLdnNM4GvGo0J
         te4A==
X-Forwarded-Encrypted: i=1; AJvYcCWakb2l5DabsTM1ve6btZI9fLfjo5eznFu7ijMDwRglECnbGcgXsHQsQ/Gui//89WPRbAx6SHR+hLxDGTQTHvdaAjSTgYrRa2inHyEb
X-Gm-Message-State: AOJu0Yzxd0rxr2ogJVuiHDdQ6YoOLlqqmionW/aobd/BGO+Zh6Z0bOpC
	fQx5zBSNjQUL8qjgiU+BK0yNIJz203tH3WTlFMfmeTjPoBZODjZmTOYZes39n1TvXAmgtpLnGos
	tGmxx3sVIRxBMdv760W/taTX2X+hTPhG2ybrZamUO8EK8lx76YISDLmQ=
X-Google-Smtp-Source: AGHT+IFELdI7ElEUrZpuXFZ2wrxRdaC0IB3Akz9+WKZboJ88RJE3880HwZQgtxZ6ObuUo1fDxcN3K0jY0nG5kQxLtpPr9ZGk8Uh3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8309:b0:488:cb5c:7044 with SMTP id
 io9-20020a056638830900b00488cb5c7044mr7957jab.6.1715011983899; Mon, 06 May
 2024 09:13:03 -0700 (PDT)
Date: Mon, 06 May 2024 09:13:03 -0700
In-Reply-To: <ZjjlLcjHuQoV-7gh@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001623740617cb58a7@google.com>
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING in __mod_memcg_lruvec_state
From: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/rmap.c:1444:25: error: incompatible pointer types passing 'struct folio *' to parameter of type 'struct pglist_data *' [-Werror,-Wincompatible-pointer-types]


Tested on:

commit:         2b84edef Add linux-next specific files for 20240506
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1655a590980000


