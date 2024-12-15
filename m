Return-Path: <linux-kernel+bounces-446257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CB9F21E9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F766165D05
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B957483;
	Sun, 15 Dec 2024 02:34:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780371114
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734230048; cv=none; b=hOr43HU4TyMSz/7ONXvjC+RtTbiQDK6awLAWCUrVBkLtNcO9++vIOBue3LVVuFdWoQDDgbNfAO3TGHICQZ9YEMtqAF7E7Ucr9lKbfPG8m1bU73Xg4D2uvCz9R+tG4KAak6q3bdkt2Yr5c3V7DhCvSkYf8iRiezHqL4EzbN5lB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734230048; c=relaxed/simple;
	bh=jmOfGx8i6WqW/9e9eV0esQhvVw6dNrC2SZ1/lyEA2QA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jztGDINwg0mbiaKcHyVGvrpd+l7WZR7jaQEK5RPjZQcqqza2vcVLrr3+bfvTbikiCHiofzZpJ/LOoNxquJpERgNewiRh6pLDvoOD1VjOjF8TCFA0b47jjRmO/4g/QR55Ph5vKTDWpCAavyIh9VDU+HNQ/BSO3JT2g0EcXxVUTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so30849855ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734230045; x=1734834845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bicnoxgy/OVG1OfhR8q3/VJAcXZClP4+JgLbGeU2LYg=;
        b=ck5nJGFn0sOGGZqnIdR3AdX63kQoc+1hB3RiNVcfuXLGGD9FzXFzxPb50MLmLD990B
         ZUdeGcKLjSO1zX9fVHFu3YGQmYPsQEi1MAl1Uj/IN988HBZdsV2ZVM3cQitqgnxfVS6A
         Qgq2euRD1oRpSJSzBxGys7afbMMuThO2fqXqt3/OHkAnQ4VNpfbcHLHxRawuQQNeATI6
         0cc8CF6t1L99YOI0LxYGXPWZqQ+1uynwiHoJ2eU0mxsETI8n1T6IdOlqUBpg7HMkpRJT
         EZVAh1P3iwuEA2GmZiBPrNu0xxxPB297URvD/ufUFJwT2NWREm9d338oTYlmQuEqGV/t
         lGXQ==
X-Gm-Message-State: AOJu0Ywy1y8IvqaIrfE1moFc69OxigujU0NTsxmdGbHNABNcDXmfjzSo
	tE52K8Qh+H80R3f0La0JQnP09ljK/smSWQCwsnS6oZEDRvhcs+H8aufxVZOVQiFmLXB2hzgEBmA
	1gIlE6uQROo78YPrLJZitvk10QTZMvOhkn9HO62KlUHyaLyaEmLpmR1c=
X-Google-Smtp-Source: AGHT+IH/tVugaRnnptJJCS7A3u/uxxM6MdvQqP+L6+52aUHj8eu861LuGCP8XY2VS4ZmrJQC6JCaALwulgM2OcHODL9Wm9N1/Ez0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3aff470f9d8mr67221455ab.2.1734230045679; Sat, 14 Dec 2024
 18:34:05 -0800 (PST)
Date: Sat, 14 Dec 2024 18:34:05 -0800
In-Reply-To: <67409854.050a0220.363a1b.013f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e401d.050a0220.37aaf.00e6.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: mazin@getstate.dev

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

