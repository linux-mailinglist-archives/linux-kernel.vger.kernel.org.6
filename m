Return-Path: <linux-kernel+bounces-247032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F5092CA24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A54A1C22711
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFD347B4;
	Wed, 10 Jul 2024 05:31:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CCA20
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589491; cv=none; b=b6TMXuTlUXjSDtJgo/9s1Ssljy42VGdxM70zQ4vT04INFok+vzFkZSW4amO/mUIMrdNNg5HITyZkm1Z5p1VLD3m3q1H1jwFIJhET+Wp8hNsYvAoEjqdYzDqpPnP/wsd1azew9iB2I8sTelp0q5fUrNQefanYdTdHCIBGg6vE6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589491; c=relaxed/simple;
	bh=WVFH6uwcMIYyE0zqWdYgh/RIFDJcAYHNlvOWOEQx0Bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M6xy9Jsi4rKTrYWeO0mJ2m1bdtJBmVUFdeqs3PcYxqUXrC5yvFzX42r1W7TD1Gpx/J/q6jRRD4Hool/sHuaLw0WI9adgWpluauiZrmtRIHuF+Q7VyODTfzk7qWSto1c9PWbKMLmeO490sMLA8eUsr6caykhZit60POY4mpK/oLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so300356839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 22:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720589489; x=1721194289;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVFH6uwcMIYyE0zqWdYgh/RIFDJcAYHNlvOWOEQx0Bc=;
        b=jezWYOIZj0tTsWeDUwKGP7Sw16kd0xTCpHETo5mbxtU6VAlnN3mLm7cSaKsyajBn+B
         ZPzsYpfEUOvTff6fp2wZlRXijhkeTZRJr+b0mjDOYwDQkO1vi6u+sBIaOK4fDqdcwkuk
         Ce/jQtRn9TusEW5CMAFg+C01Ogwcf2s/JL6/uKx6pLSmMv/8omtusWD86URIc6xemWyw
         +wEFP3rbORwdn9t3yS/BodbNIOGJw1sozNGYpZ0tPj1hfm8gUwNKPeEbGDSSEz68FVNU
         BiEBk2dl9dXTqZxuI/4LPdqgpe96eJ7PKiLocyL5/88/nCSyeLZVKrKzszE5bx4D9TPV
         qE1Q==
X-Gm-Message-State: AOJu0YyN1GZlIvFvPyiMvDzWg3+aMyl16Np1tBPkPegxfpl44I3DW96D
	0AfI2DAvY/byQt/AFsnttXHhUAvWrHF815OxKpLlizGgp6Ne41TtAYVDaEZVEDtYESSF8D6xxhy
	Bp+viKtrP2ZhxsihbiY787iCZUG9oDCdYwcliXrNbgNwVCpyJgOnYOhs=
X-Google-Smtp-Source: AGHT+IFSmU92G/RH89p0OLL+iVigs5YiJYvfz5qvb+fnvKClvFphj+9zq8erCMcksDW86az69cNmJd5acPohVp25uWClWvrEySZr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d5:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c0b2b331c3mr339191173.4.1720589489347; Tue, 09 Jul 2024
 22:31:29 -0700 (PDT)
Date: Tue, 09 Jul 2024 22:31:29 -0700
In-Reply-To: <000000000000ee4d7c061cd1c21f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000512c62061cddf522@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in bch2_bucket_ref_update
From: syzbot <syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING: suspicious RCU usage in bch2_bucket_ref_update
Author: peili.dev@gmail.com

#syz test

