Return-Path: <linux-kernel+bounces-297712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47B95BCB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24BE1C234AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6621CE70C;
	Thu, 22 Aug 2024 17:04:51 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615981C9ED0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346290; cv=none; b=Y4w/0Lw0/Q7u2BNgxBdyexh8sdQ8dqWeUbWEaKjwCtKjs8dHoAbaO7wEuK4Zo+elw1DUzJPR+QkzgMkrbD/ZdPpTFCarojvFMt0E3WjVWe9cEo7BZXzevR+7s+JmdcgGxLOh/4IP+arvQgtwlPDe5LQr1A/Qo5hSVRhJRhWmdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346290; c=relaxed/simple;
	bh=IAV2vQViYpca7CyT2VHc2hW6/r3DklqpKV681IcaQQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ab6bFHUxays7RcRjfOP2kQvb2xFvxLMK3I3pLvnU7vK+DjCJ+EoYCx8mR686Zq1ta9vvrfIHh4wQUvK8WJogxvhnBLv5gTj+e4h6KIXrhZGrlqrorhqT+f0J7XfnZu6X4VF/9QJA8dOm0639Xr1umznberHrh5Aqbg17TyPKwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d49576404so9683455ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346288; x=1724951088;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAV2vQViYpca7CyT2VHc2hW6/r3DklqpKV681IcaQQA=;
        b=sVxPR/Fgpe7ajMOj8U6yKMEqbhINRFlJnYbLZSOwl4oUIxnHCeG01+N+eEm5lhR7Qw
         aoIMSgpPddFaEu0EIi3jLx1EWg87wM4Z0FcbvmG552AgL1vn2Iucazj61wQa/4utoey1
         7CZNMrnA25YNMWlXhMY3i+EeyLmAKkDvWKIqkzTjK5HP6OEd+4aEA32vKTtNoOqvYIWr
         Gd9F8oqG4UHnP4vLzsJ3uxdqr4xYNqxSNUVdsK+Qf1pF6hO9W3DTGgpu4FsUvUAUGz+F
         tKV+PlycbjnOuzn0yGIB9zlpPrjffqgkCwNM8qlLu27j7wh6/fqzNk0ZmiyBaeAenM1E
         7zRg==
X-Gm-Message-State: AOJu0YxhKMdrRrGLnBc5h1LMvB4JGwnxgKwbgV493inGDRbPPkYuvW3N
	zVUA86dk8eNl1UfLLP7Q+vdQvHTLs84ryI9trTP9ASQdr40FwkgdzoIsDQzk6ZrSBFshI/ub6+y
	jLYk35n4JlX48d5Ti08sInnlNFqweT5qGJk9i0KHMFm5dAJXbQt9Autw=
X-Google-Smtp-Source: AGHT+IH/YKNLfK0cjcdH1iDat3KMdYdgslJsoM61CYgYgDCzJ1eGM74MrQzFoP7R2m3W3sV0K1iDrDtaG05SzQCUHuRWpZhqmBZf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:39d:300f:e911 with SMTP id
 e9e14a558f8ab-39e3a75d260mr233225ab.2.1724346288161; Thu, 22 Aug 2024
 10:04:48 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:04:48 -0700
In-Reply-To: <0000000000001c2dac0619a7e77c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9d79b062048a703@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_flush_nocow_writes_async
From: syzbot <syzbot+917694e2e9db5284865f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_flush_nocow_writes_async
Author: kent.overstreet@linux.dev

#syz invalid

