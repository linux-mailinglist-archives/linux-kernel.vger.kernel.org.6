Return-Path: <linux-kernel+bounces-214861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B4908B37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3401F2409B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E9195F00;
	Fri, 14 Jun 2024 12:04:14 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C5811FE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366653; cv=none; b=eJAAsbpqs5Epq9b7Le20cEviZawU63DMPk0wE3v/pwJGPBe65wFXvLh2I9yBB2O0gzBMRsn0TAbWLxitWJWUJG6NY26XuFGq/4SeQpLzEwFLZlfKA1T9mvi5VFIeyOaKsdi0LDilDHpNo26pdji3zrUEIkHRilv1GJs++EOHH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366653; c=relaxed/simple;
	bh=8LD7JHw0nscG+5crQvdy8UsMURDt5w/6x1ja8am4PNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oUZ04YtHgLcyT0DnlasU+dB8tlQ1lGYTVBV7LXD6EnvBm3hKl8EvBsH7n8+YG2z5M6afr47tEuM1i6dVQzvmkDndnxsTvYB+bcPMEWj5VIMrtVw9QrrcU3h6rn/cjYXVr4rJFPR11hPiyb7P4fmmVdZ+eHDrvge26XhzDqTC7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375da994725so15880525ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366651; x=1718971451;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjzYF+pku4mMqLZwtKqFo3l0rogQaCCzgAI0BPSsJDg=;
        b=wvzfWpLgTj+cUUNTNKtohKBx6K+5K4/1tl0LLAPvYeqH2OmP6PtQhcyMbIi+qbK1oC
         UgP1hnzcYRLVvpPp+IgrXDkgaKpktK1Iie0wX7f8taiVyrlcl8uf+ug6VBV8CMkQQU2k
         vZFEUt9p4VCkhlgs98PCpSrc+rcHqReZ2Dc0LjtALs4Pjt3FUeubUPNAVQ2n/8FIvpN4
         6SoEiPGX230VAnfuGDbR241V7jzV4wnIaB8nzHa6yJKQByGpSZydEdfk/rcZtQdvG+gZ
         GnKVFbBWv7G6JDoSWoxGw/a0MTBmdRavXn6rkG1W5RTHCYwOG56zDIEV07amCX9lx5Km
         2Saw==
X-Gm-Message-State: AOJu0Yyk1f2s7tJi2UlGBfsXzWvSpiFs/L6pSL9FjxB9XN8tdMOMHh4s
	lVMYDnRn7rXq0hWjZ8RXxHoGp9xPrJIxLI2XbasGrKC0D2hKMCX0Y9LkZqK4Vhp15xfjybaaarT
	gMpj97QiX7cY2lvXv/liUBE4b7Zz+mlUpd8y2F+zDGHBjP0AyzZAcc1Y=
X-Google-Smtp-Source: AGHT+IH0YChV+KtYew19vvL8Gknkm/M/Vcww3FVUashlSGLBSTHMO+xmcnLJ9c1nU2ZwbnhGHL4SI4sa92Nv0nZNM/Qt/gGoWyKc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:ae17:a2aa with SMTP id
 e9e14a558f8ab-375e0e9fc29mr1855855ab.3.1718366651388; Fri, 14 Jun 2024
 05:04:11 -0700 (PDT)
Date: Fri, 14 Jun 2024 05:04:11 -0700
In-Reply-To: <000000000000be1f530615efc5ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9a6fa061ad8691a@google.com>
Subject: Re: [syzbot] [PATCH] [syzbot] [bpf?] [net?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] [syzbot] [bpf?] [net?] KMSAN: uninit-value in sock_hash_delete_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux 90302a82de094e0a51a2f51935ce27c4f1fe8dc4 

