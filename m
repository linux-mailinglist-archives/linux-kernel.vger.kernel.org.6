Return-Path: <linux-kernel+bounces-257850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC147937FBE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4971C21586
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478891C68E;
	Sat, 20 Jul 2024 07:43:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D3F9F0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461414; cv=none; b=lQrhs8aeefPcKD4U7eRvH5Ow+EeSOkH16k1aJZuzR+vCswryASQ1YIsexzJBN1fyIuofOXNwybNQy+jPIFn+x4Ojn40uxgFSZ+eJVJi5Da4c6cdM2AmRUDbRu7TfVPpg+nm2ldxYMB8p5wsR63YH17o9wNZB8iFG2JVr2aokVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461414; c=relaxed/simple;
	bh=xJghMIDSFZMQwcT/bSxKpvABpwSoalmPwzGjPqwQMIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aZWYi55amNSqv380T/pEH6H7XqAQXvEop1KUylnRpvCtNbFXYJDFsImj43z9vQLbdF5Nb0Njwwt24UgWdkMXES9Pv7UaBg06gE0B5yMullB6oW+rcF5WcQ6AnAQnVuPRzYJO4ISPNWbSrNFyE7+fF1mnDDN5nbYSIonUaDCi438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8179585c68cso421253939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461412; x=1722066212;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0Nn3s13nczj2fIBPcpMuDTEigrtwN2HthLoUAG4F7w=;
        b=ouULFKDdEn1bh02MBs8nuUc0PDikLh5a7V7E1PvJXlaMtMqF40Oc8Z/gV1GIljneqF
         6biUJo13ZqqUzJ6b3jZ4kAO1sqJCPNOPV5el8QbePOKmZFovdaYdPuWvioOHqfW8vWqH
         XbkDx91qzFSv3CY7VDgUhnNb/olaBeyP7VxrwEKxDq1MG1dBWZ3dA70Y2hYmlc6oICf0
         4Tft9/6X+yyV0P+DBhTZnj5QROSUt43VVhX9TCc8nnKYsP8gZbhBuBy+p7GhsjkDG+rk
         yNZqEg/gIuqoX4Qg5wUaB1sAKvbmpK9SjbuRTt9I8Gc48OXEV0HrTOVvjV0pCvqaewyf
         wLlA==
X-Gm-Message-State: AOJu0YwjFinG83XW0xbZxdI406OKXajLQ0aAevgNk1NOsiyEfIcGSvqA
	yP1gxA5DVAoiV4iournMIMaTce8XMCz52b4yIStlmfb79vbPgbnH0g/jwKHVOBKZcgD3hVPvFwK
	ycOyiB+ljwLjKtx2VQCc07t8Y4IZAzDbNxbvCYvfOAAKAUyIf2cxd86U=
X-Google-Smtp-Source: AGHT+IFMU9NWNw9q9cLH4nZf2oDT4BhG9HTa/YDC79XA3nMbgFI2W59AumDTc97Y1RNJ+jU+8FAGNqbv4u3dek/CH6Z+dqYfRpxw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2596:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4c23fce0f35mr144691173.2.1721461412624; Sat, 20 Jul 2024
 00:43:32 -0700 (PDT)
Date: Sat, 20 Jul 2024 00:43:32 -0700
In-Reply-To: <000000000000e2102c05eeaf9113@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe8619061da8f76b@google.com>
Subject: Re: [syzbot] possible fix
From: syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
d57431c6f511bf020e474026d9f3123d7bfbea8c







