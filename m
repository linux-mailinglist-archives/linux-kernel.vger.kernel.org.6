Return-Path: <linux-kernel+bounces-229908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B29175E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DFE1F21BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17714F62;
	Wed, 26 Jun 2024 01:49:49 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB210958
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366589; cv=none; b=SGbot15bBx7qnaybgyuI+XlP99HXHUdPFD5UgYyghfcFDRoDZwd2xi8VmFG0Pmf5QNg7r1KW/ZAvf3v+hPhO1nNLaYdjDfZM1qHyE1+lTlI76lWVPxxr7kwnrZIk7KkXEaC1nSLPsmnJDu/oAw3EEeJYntC7pTvHeiDnTVpLA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366589; c=relaxed/simple;
	bh=2P9ciSlu7Ek9y6TGFOI752MUh8bHFPb7DN1jU8pmlJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wy1Kv7gBuxKG9KfiIuLnhWB2FXJPHxAfF0GWLc+8+gZRNmLVHAsn0ECfxszF5NCu8b8ZxujhGji0YzWy9r78SmXTDWbbWCMBm/4LhNvMNDEKTuYDScXPpxiW3n78k3hL6NcfRa2bdRv9jjlvX9DE7g9WpdHSCxH6TttQdF79Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3c8b1fee1so118474439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719366587; x=1719971387;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P9ciSlu7Ek9y6TGFOI752MUh8bHFPb7DN1jU8pmlJ8=;
        b=KF5yFXSuVav2dBDhAdLaxoEOZrBNt16/5XDdX6K25B8PUxaZJi8VKEHSTqH2lZfOsi
         lD3EVNIx98jmNkREly5detAs7wCvFzuKY/4O32L9LSlxneKJtdYeTIT8Hio0hoNX0nQ3
         /Ffnu/O6IYRY/ziy1lajbSyAj55YEXeP0dAbS6TGL3awDnrR865BP8x3IOETRd95NO3R
         oqi4X09Js9EQ7I/5FFXG8/gk9flBZ0e6IIlNtrUd+yq3nYwAygmt/lopDR6SDmwQh3wf
         0vz0ocNQWH5Z3pT0qBvWoGSKXfQShS4kgaJJXMeh4Xv7Ul+zmxpfP1KQnDqUB4/FDSca
         bEbQ==
X-Gm-Message-State: AOJu0Yw523EqwiZtO69z3zsZbvO4PrFAXP/NJzj5fdZ7eVzkg7eUf3ML
	cHoy0BJxWUN5nZeJWrylxEk8Am17tLVKObzjfVencjGI40rZJvuYYu59ELsNIVwO5kDakIaCYPg
	SjQUSOUoBz9JheDksS92GQZ+Av0sZiiaYrhZMHZGUTj1CMobcVgCWqzc=
X-Google-Smtp-Source: AGHT+IG0Uq4oxmpX1WtGRAATLbuiYWAFTLgJQXHQqNw1PXi9jBtMVnr1wmIGjy5A1kD3vdQU3r/IqjLZtSx2louOGucGTKa8IACJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8711:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4b9ec62cd7bmr506091173.1.1719366586978; Tue, 25 Jun 2024
 18:49:46 -0700 (PDT)
Date: Tue, 25 Jun 2024 18:49:46 -0700
In-Reply-To: <00000000000085bb82061984e155@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7e4d2061bc13a8d@google.com>
Subject: Re: [syzbot] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in __kvm_gpc_refresh (2)
Author: peili.dev@gmail.com

#syz test

