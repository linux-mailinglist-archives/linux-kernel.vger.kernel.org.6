Return-Path: <linux-kernel+bounces-299283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3A95D252
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EBD283A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF41898E6;
	Fri, 23 Aug 2024 16:03:17 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0218951B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428996; cv=none; b=NZGba2cNziDAFIRXOCUu8HQLPCsP9KP/LJ5hJjpktfmg0fAOYT+tmfHg5zQ38LfKrkJEqAg7QpLOPcZEUwNU3v4tZebmmkMJEbbIsDPYlgADUqaSMXjHq6nrg4B1t8NCeyYtx6xXnHjCPDxkYVKh4/WyxA3Hpghn6UFfT+XcrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428996; c=relaxed/simple;
	bh=kLANef1xnMoOWRzluybli1dfyntwTcum5JDY89gGthA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c89c4c6KXFdYJwcpzAdyLMxejRgbVzrv32teJjNDOV/O3OUodyDMJXg16ssR4GISA8wgUpFcHeNLauNihycFovR8zm2F3guMRz/nEi+jZbYimcUaZW0RS/lXGE9yO4KfIug9ALGBduOaZ5aLH2yGT0NbbY9KWMWfkQsfy0eSHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d32a4f301so27134355ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428994; x=1725033794;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLANef1xnMoOWRzluybli1dfyntwTcum5JDY89gGthA=;
        b=M44GDEz9/vDeB27iUZtJyHffgzbI2A18LxG+ysPW3Bwvx5s+LoGO+3JO/y7ktXFV4P
         DF1MJlzyUQJsif79nSqUCpwCb6h7qGsedwq6jZ/6ct8pDXBzRxcrI7bhHl5wzIAsAMnd
         qiLBlsMRQm54jXkRpR2d/XBJ8NKPrrCh/HSX/E2lIEXnUpNVdsQv4AS8mjghEscYeIF6
         5KqR4SYLop1sPrcOR3AJ/Ia4EiQma/iOIbWiXXJrb/sCmq1L4wb+ik9xrxrdbLy4QVBk
         FUYse1AhIZTm3NnxALN+HotK5BqI58MGGqAumPA4AtUDVbcf+n65psMEhM9g256fkHt5
         fApw==
X-Gm-Message-State: AOJu0YzSk5W/2MUKJoS6/+8IkHcc1VZLxnVWtuBrWtZJLDBTibKm/cgd
	fERIS/8vbm/qh/YWDrboaaSEaJW8b9arTT/r59rNHlIg64RsGRG623XR1Lgy38PK43UoUmnMxjJ
	TQovlnnEcW0ZO82L6uu6mcRxRDBQgaJX56DLX38poiBTD8u3ZLT/+ovQ=
X-Google-Smtp-Source: AGHT+IFLDUl4vJRQOgrmoA+1juaCY1KNXejkCSSdXw/ZPLb0jRLM2MsXxywD5G7Lss7EQ351tf6R8btZSXCuWbAMoo98qVmzj7XI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39e3be3b9c8mr2052115ab.2.1724428994313; Fri, 23 Aug 2024
 09:03:14 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:03:14 -0700
In-Reply-To: <0000000000000fc50405eb48a1be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5932306205be923@google.com>
Subject: Re: [syzbot] possible deadlock in ni_fiemap
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in ni_fiemap
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


