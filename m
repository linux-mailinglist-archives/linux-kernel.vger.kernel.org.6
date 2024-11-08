Return-Path: <linux-kernel+bounces-401090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2A29C15D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015F6282DFC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15480C0C;
	Fri,  8 Nov 2024 05:02:15 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBD1BD9D8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042135; cv=none; b=YgFetJpFx5e6IIDkbxzOuK7bG0GSV4U8I2Co+yPVReQ2AWUtiRzeC5u/nw6a2qIhfmd1zBzUlg0j710E78Ged1+cLJ0Xq6RvnHBYV+8V3Gu+FcqZwjIuI7q/CubKZI5FPXyYCOnran+1cSjIwHJD6Npx1OOBmzXOLYlteUZMjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042135; c=relaxed/simple;
	bh=vA7q3ey9IQDXsNVyxtJna/mpocsRlqsi6kDe717NzEo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RI/FMVAixUTDLrMVgrnsnMlM6ds21xrwZb/8Ach8JLBXOIfcVNVLt4PpoG78zD6OGzutZ5A7S4Mp1ZSxPtiu6wMcKcmbD6twb7XmHj/SUnkBqhDcpGp25OPEhQhdy2NPGfEveL87Lo8iW9ZdkjJwpmblI2yP8jgcUnrGt6RZssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so19855465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042133; x=1731646933;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHED95VNotAf9X/S/Kyf5Ay24kyu2cHoFcBFo1owXBs=;
        b=R2jRedOZmWuBRhG/t3CVo7po32esKKYC3PBLNdCkG/ofTg0OAbJdK4yNP70oipFSzH
         EZ58n8htUUSUamv1JNDZVifwqlYC+CI6mF2W3MK9noV8PgPsVaQAcc2gyhwu6W0m/wmh
         pRA19r8E4aEmS2HxVKVx56aOe0fJ+xDXsaLCPT7MSkGT2UzephdpqMPrfkqOPM9jo8aL
         wyWw6rOu4xNr+7asBMzmWqH6s83DTpC1WI9wtpitfyxJbCtB2QOl+yHRepKy7CfRZKzX
         2wSpN2KLxBctEDJyV/3h401qrELIKvKbAC+8pRWn5Ou5ihLQ/ujnrsaRHy3FHpLyM+FH
         alPw==
X-Gm-Message-State: AOJu0YwU5zihH5QlSuwZHHbLMioyOngX9sNhnZnMRPQLSgsFRkfxZr2h
	n/AAkuhfAX4O8Gdsb57zqdrWV6tdTQ1GtPPAdhQryv9k3pe9mX2B1so0+Hw1RM+/fCYIs8Jpm+a
	gFz7JP/5nin+70aPw0+ai8li6X7pO9aA+gSNcmO/GAZA+WDDpH0PWiM0=
X-Google-Smtp-Source: AGHT+IFkHmSCKpdADyBh2fXvli8pYLAm9nqSkk5+fbMU/fL8vvlHeQpHkKPxwDOX/Xy/3LSS6CiHQ3A7qx8rf1rWLDsf4hUiHi3N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3a4:e9b3:2293 with SMTP id
 e9e14a558f8ab-3a6f19090aamr22334185ab.0.1731042133303; Thu, 07 Nov 2024
 21:02:13 -0800 (PST)
Date: Thu, 07 Nov 2024 21:02:13 -0800
In-Reply-To: <67226139.050a0220.35b515.0070.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d9b55.050a0220.0db4.01bd.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+4d722d3c539d77c7bc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix validate_bset() repair path

