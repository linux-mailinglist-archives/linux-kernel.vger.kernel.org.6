Return-Path: <linux-kernel+bounces-296539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83195ABDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFFD1F2399E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FA4204D;
	Thu, 22 Aug 2024 03:25:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600983BBC0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297134; cv=none; b=oN47mDF6D8XnJIffFs7Ef9BhnmLGw6oUsNHiqZqRt11rToZCWKBesSJZaVljfTwocuKJ6zkmxEqPMNbznZTGVYw/y8LOwluwWKOA0+RL/DRJMI55H45h34UcYwEYPEDf5zmLt5D3Qw55VE/6Lqu+MLMatbiaZYdv0kCkruT1oVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297134; c=relaxed/simple;
	bh=BBtDffAp/upHQsfCJey4JBGId6GezCemtHx1dhm85w4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QHwxMIUhHZ+hKrzcGnnV5vPTl/ohMJCY6QPX/mY6KNsHxT5eUOHcpZjNF3CyTKvoKMsXSzByYQTlc4nwDb81Cux3qQOaE+T4yZaQBq4ZJK7EcGrSIwBfsFtKXuX2GJ31Y+BFxCXCOZvjUCy5s9LHR6wBSKGWhcgeq6dKMAw+k3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f968e53b0so36687039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724297132; x=1724901932;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBtDffAp/upHQsfCJey4JBGId6GezCemtHx1dhm85w4=;
        b=q7VQ0qkU+0zsXqQXWWtWAtXHxDybX2meJOGHKhQ1Lykw6uaWPOWQMEP1Y5kyrXd9FZ
         yXTlyt5xT3laDxsGeWMVcxHxyvUEjnQ4LudbmVKITqy9ElbuUrQMjjmtTf6FTN//yg2Y
         ZME6+YxR0aNO2LxFCz3bEh2Pu5yKrLhgT5N6f1Wb8gVaHrPBG0lErm8GLOk5fPet3GZ1
         bREILTC1QGUFJQOLTAPfPbS3guGQDYnG4N1asjSc740/puTjBNVx0gDgiHDocAAL5L3H
         vC1zkDE5hQsFjemOHosgjT9nXje9lDFV/vXHiSkR+wREEaGQzIm04GwSD8zqifBB9Crn
         5ykA==
X-Forwarded-Encrypted: i=1; AJvYcCVCPrIFludXwWzrFDfe/ChF8ikvz7KuibHNdIkdyU14xDHb1wSFNUZPCiEbwSEWVIVhLO8Es/S9EjYdNFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAT1clataKG2dHbLsnAYmRR5i/t7IJ1DnSoQOyertP1ROl7Spy
	LyWrXxYWGjQZXoUto25GjKasBo0WaZmOO3idz+z9uLltka5NQ1ePpmk4Uliaj3ceKwPwTorI6WS
	1EEVM4Gvv3r9qtr/Y5TIujryur0Cstn7PhzzV4h6tLIIxPgf1zT/xIMc=
X-Google-Smtp-Source: AGHT+IFnoT6l8i2CbqPbH6xMd8vfTD/8eAmWnHHar4aX1UhcResVBX1ROIZQIvsvFeyWjejeFSUbXR9g7KkqPXsAygczWSx2Tmmg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6209:b0:805:caf8:4e1c with SMTP id
 ca18e2360f4ac-8252f4ec328mr6150239f.4.1724297132405; Wed, 21 Aug 2024
 20:25:32 -0700 (PDT)
Date: Wed, 21 Aug 2024 20:25:32 -0700
In-Reply-To: <fmgmxhirocusm3zmnki4m7miyqemwgxyjybjr4wvq7u2xupjyg@qwqjonwarhcl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000108bb406203d368d@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in percpu_ref_put
From: syzbot <syzbot+9e0404b505e604f67e41@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz bcachefs: Fix refcounting in discard path

unknown command "bcachefs:"


