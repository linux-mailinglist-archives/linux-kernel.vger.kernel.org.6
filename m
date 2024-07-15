Return-Path: <linux-kernel+bounces-252313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94115931179
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B841C22133
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B8187321;
	Mon, 15 Jul 2024 09:41:57 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC9186E34
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036517; cv=none; b=U0hye81AxKayiaKksmkBGgjFKU5g5cqKl/J67a/+XoNAKtZAcRdMzuNpRpGZ5D2kSXynCajAb8LXNiDbckWgoa+ZulREVggYEvdpq+1zNI5DiJj1gmRxv9AKcG6GLJ0qcnNTQoVgsOSRzsO/unFBidNWsuswqsvl54/Chnit74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036517; c=relaxed/simple;
	bh=u790Nfbb5z1algfNSgo1IX29v4SAcFuAiOcGP0GKQEU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UESHYuqQrTiNqPskpb2S0I5r7MsoKX0beRMgimfnAt8fkgNdrukvRs+K9RBIaiOG9V53db+JiUaJaNWgaQ1QcmNkijbNeWeLR+vW3ALk4GSgvcqIjOV6lPXx1D2bswh0nHLG5hcFKd9Rw/mGw2kP/eMqgUBc0oNKg1FslBxcxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-383643cac9cso43656365ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036515; x=1721641315;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u790Nfbb5z1algfNSgo1IX29v4SAcFuAiOcGP0GKQEU=;
        b=Xo1N+9fdzOnheXL9SIZ8Uo2wz3NSvfhaHpuw/Y/Djlu1ywNhjn+otdOlpdxQ6KtXJ0
         X/L5a0+KOTzR9IGke9eqS3sa+9ftcFXuTCNbaGi8jBBhJnC8iaXINqx4wMfnswAxNRW5
         04pJ/yCXnf0SOu8txr9JUX6W4U4O8h7vQ6SNT67wBldyKz+loLyZMTmU9E2H1DTT7b4W
         6ni9OQDLHN+sjTdem7VMAIiGckLD5cTGvRnJ6VjtjICpCi0JGojW42LP2bigAfgBA750
         p5+3PptzgTrH5Uw7btFXsc9PTisf1IcCoEjAuLFMpV7Gs0vJlOnmapCmLTdPUiD1YtNA
         qclw==
X-Gm-Message-State: AOJu0YwoBOgI1cfIIyVmC7LrjWLlj7AdWWFaRr2D6GG0K2re9m1rDKkF
	6nJRaCAhUHluDnH2FaoFUul7jYePKGLd4JmoQfjB9jWs2sHumKX04vLkDt2SKe8fcL6T/pK7fTE
	j+1zqm7EydLN0AO3aElZaMJi7fWFOnZPDBJFgYBlwzRY0i7uop4pN1j8=
X-Google-Smtp-Source: AGHT+IGSHMni09NePEwAlK9w33LQPzP3x1Qq2sWgiaOsnj4QR2ZW11qYEGb//STtpAdb1ELYGPg0m7EdN1fO1DJo/rTnUmqaP4Px
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d581:0:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-38a5b9aec76mr4489095ab.5.1721036515221; Mon, 15 Jul 2024
 02:41:55 -0700 (PDT)
Date: Mon, 15 Jul 2024 02:41:55 -0700
In-Reply-To: <000000000000be9914061763f17a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022b2ce061d460a81@google.com>
Subject: Re: [syzbot] unable to handle kernel NULL pointer dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: unable to handle kernel NULL pointer dereference in attr_make_nonresident
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

