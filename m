Return-Path: <linux-kernel+bounces-283952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7F94FB01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4499B1F22BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB066AAD;
	Tue, 13 Aug 2024 01:22:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017FED8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512124; cv=none; b=aFNQ8MrTUXEPswGOArgxHYCppC+5vZ1Ynzq6jLxPGu3at7d3nPwmA/Ii7BYv9T4oEoPVuaQsCVxJzXExk/JnNsG489V7ljHh7Ex92onTB3ee1bNrIHVHqAK9wtWjVTl5JwI21JuVfGy+gzXJ3wJSf9ERDbZ17sJPxtx5BYMuZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512124; c=relaxed/simple;
	bh=VjDBU5FDehkC55/UV0CdINts99nzTa4AsaGUl3AlD9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WYPsXKjRcg3OsttLFkZDKaz1cXtwIBM9tg7a9QexkB1xaugDneHJlVfcJeqsGg29VSGGXxp2NTYvWghWGhUqlNA37TBKLkMkH3j18rJa+lYOKBT6rtH5qQKv2yH/M3q/ESffinT5F/SkftidWF3zctngpnHJ3k83n4oEg8eVC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso580038939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723512122; x=1724116922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26j5yIqPlIZJRUP+P8Qy3XeguoppMyAIFt0U2Rjq3EY=;
        b=Hdb1qNEd3IDaZenP6n1u2ie8PwUDch/758ZQ+MtopsIh+ZhKbQQiZYV2hjnN/Du+EI
         QLiK8mkrGTMlFp+Y2MM2sbFKrKupyt/KRyE6fopHaD+rDEjT0YjFszFWiTOjCL/xRgV9
         nYYK99LIMsIt612IBnWHBX8leLwBWt3zup1FlMFD8IKUBRRlzUhdW+VbF9BmKt8POXmf
         n7lflvuQTg4krEIyQXPLIkh5Eqt8j+vXt0mlri41lF4+09JegKatzrm2VI7BIz++YAOG
         PM8O6rFQh48cdU/KewWekTY+rZGkNNHuT/pAPEAT5uQu9InpDFPCf1DtD1f5frsZ7RRn
         9zzA==
X-Forwarded-Encrypted: i=1; AJvYcCXZaAObTqa9ZgH0S7UlzbRrklE8GyPP2Enm3fDuTdcmWQLV3BlNpNxxv5+dHUHIjkc6T4R0EAJ4sh3GBkg2btefAsetg9bz8o/bRN99
X-Gm-Message-State: AOJu0YxQNX2ciI/fkbM9xWdohbgYA0SbrXHWcrTiiVUv4cK+rzL0AKN6
	x1zvQYLiWAzIXAvyCkOmCe0IWjbPhW+BARAo8lbaE3CuJMeMn1Hfnarms0uVQtUIiJjcwe8mO25
	rdvQfPSJZPl9Id5toldaf5FW3wf0j43neg2j+Mq0D7rkhwGBKpW73ZK4=
X-Google-Smtp-Source: AGHT+IE3er3lxckhPNvo1u0TDNiSuQAYUYZ0NJVKkGVE3Qt/aJ2Jdzx4QOpzYYeuYLZavDrYO21xF950izuePRIfbQEUNhQYnYaN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c7:b0:809:b914:a53a with SMTP id
 ca18e2360f4ac-824c96f027bmr2511839f.0.1723512122580; Mon, 12 Aug 2024
 18:22:02 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:22:02 -0700
In-Reply-To: <150BE896-1707-44C5-B741-C9F42F712269@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d531b9061f866fd1@google.com>
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc.h
patch: **** malformed patch at line 6: diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c




Tested on:

commit:         d74da846 Merge tag 'platform-drivers-x86-v6.11-3' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6f4e2cb79bdcd45
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171c9d13980000


