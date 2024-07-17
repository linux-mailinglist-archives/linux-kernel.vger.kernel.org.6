Return-Path: <linux-kernel+bounces-254878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E96B9338D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE51C232B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EF22F1C;
	Wed, 17 Jul 2024 08:19:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB21BF2A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204351; cv=none; b=PHQNy9JJoFqS9ZObwxXHSQj9TWoH+ESC37vzc+qH9E+G2mHytMONdd4o70UBeF6vDveKlfyFob00XAGmbmUISiZZXkshiI/z62pajMKsBfkHp/pcoIDsZdBVjlwThymdu7JBR0nu/xzru7/SFX38a2zpBqR4ApRlww+5gyHPfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204351; c=relaxed/simple;
	bh=29G9hoceOwrcIy2xHIhg6Dco5WfLFrgm8SmW7ltX4zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X9CSjYBCJguB7KdieouqweWHhiNd1HLjMvoLf3MslPuLBjAVZmVokWtxTV5gb531jrtKwVHDgv7aMJpoHyAQT/r0G/MOU49AaOsuTXkAb94owsBbhx8YE0D+dgqT4M04RHOZaxrP0iauXTWb4pZNOf1n7Xmaz1YbZMZGupyy3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3835285561fso9895165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721204349; x=1721809149;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ+WPRs/WztFcXd3EtNe7sV+o1Fg5Y9anQbQoY3dLUw=;
        b=oLnAnihq9Kp5iu/inDe13s8guw+ItPiJjAFaJlXUs1GI3bmjUXZCvFjzDqh6Ae3R5N
         5+b3ov/itfLS6Yo+my+bsV9j1d82UcKpJKWFhtoE6PGTYC9J3ug5jg61Zi0MSXoMJDLI
         oFKUydfS0jX/xPkf/Gcj9wNg985P/lxZKV+2jxAmSp7/VVXCzsVK3+RyqNgk56wOkkaV
         yE/OpeGfEhCyGpM4VnhWr+k76Hq4HsT3H6TBybTDvH90OWVc5HlxkISpVlKIJeZSRhim
         b8fD/e/EHeZvfsvykNkK2E8/yRa9VTpayogbNxIhwxsm4dJVWIkPDh4UBIujYvu1M5z6
         npjQ==
X-Gm-Message-State: AOJu0YzYVRmstPnr5LMYmkp+ewae4TaDEi0Dxg6HeElpnZjz8cxghNKU
	X2k7vmNF/vD7YxXEhZida3HZPW+spaIFyJdSYRdMUbxt39NYFk5Uerx4//GmuusMnftNLuToZ4t
	vGgLS5al8qDvzUO/oPdvz3uqRhq1b3KS1YUQdf21yyWaraSQMd+qkzMY=
X-Google-Smtp-Source: AGHT+IEGJlwr14eD4BdL4lYf54l1sQKnEtX4ysDH58+dMMSIf8fqlBRcTTFG9GWT1WmS/Abgm+HjQj1Fm5tzrXUoJ7+v/3W3by/4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:381:7075:6911 with SMTP id
 e9e14a558f8ab-3955523de17mr947405ab.1.1721204349219; Wed, 17 Jul 2024
 01:19:09 -0700 (PDT)
Date: Wed, 17 Jul 2024 01:19:09 -0700
In-Reply-To: <000000000000ea9fef05eb3621b6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d24781061d6d1d29@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
d57431c6f511bf020e474026d9f3123d7bfbea8c





