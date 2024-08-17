Return-Path: <linux-kernel+bounces-290507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2C9554CA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A0E283323
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B979CC;
	Sat, 17 Aug 2024 02:08:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6967B646
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860485; cv=none; b=cz1YzSx7uWVkHc1rG6nnYvdNwEfnt+tmEHRb8Fvk/t9MZB7yqp8CdGjz5GJ0zzI7ODCTzyY84utuueInCbk/WPmZe3ddHvauamFwEsqvpyg5XrzTdWLdLxZCTm5Xlz/w7Prh01A7CTJhlOE8ek0JBlTE1UbukLCO1AJ8G4ZTdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860485; c=relaxed/simple;
	bh=X9CaxlIWkeCMfXlThQaLzoJEci4dG8llLNh0lSd9In4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gJdd5wyfLaingvHadM8XacfsUkLJkN1zAt2hF0rbItbNN/jcNR4+YtsMiExyBTatNiKqzqMDO0rvMd5nG2BVwLdc34+BWmTod3yWiGDAvHmXkwopmOS6gMIB3pEpkoaL+VSduwMo0sAZfCmdoNpYK2H/JCl3lbZuIADLPYczJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8489097eso258324139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 19:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723860482; x=1724465282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36qUNdacCBVoukJz75e4MoGoBcwNpqAPuvHATEv8K6o=;
        b=k3QJUOa1DMnxzsldbMkQwH3H6M2qs1yRZIQ7yIAdZpnCNXzrchmzPqPJMyAON/vLdV
         HoW4dZG7gw3pbmbhTv1E8CtSqalFD9OGTJJGkWoS4gqXJhEGlho+vWTI/xGkW+4+WgTJ
         KFcWuATUBFC3mfuDLSqIcah3kpymyA794fCUInoFMKkBEf8aqlVUJkiL7HOdoGXosP/t
         LWFmCrDb5Zv2nUGdWuyBiYe2hbrxjHdF5LQE0Y10NIEJ8lgdusmHeWke+aNklnFV2f/L
         gqZsMlY2KPsdEkyYW3x8dixXXDnI8jWAVQ7F1iRBWNa8sXLLI4USxeLInS4FA7HTE63K
         Wtmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlFKqEoNiGATpu+hA6oNIA10pjd93IhZC5Oedrf6cEjWVXjg40FFQMUBq6P10wRwpenfriURpO4WnK3g/AKS5U1FnGHt0UHQ09vcMP
X-Gm-Message-State: AOJu0YxKUJofJDkoKukqZDBIm0DDzxzBNhdVvyfw9WcCWhJ8bPxQUHZI
	dbT1hb0rtywY9LsbYfCkbZVavBpSnCrNfbppcLr001B+2+kjcpx/PNibIeTnH6TSwx3iz/IyGME
	20nMiSCRG3MJPomL+wzvfF9qGGjRwElKKgHrfSiz9bPJV9r0MAxwTrVs=
X-Google-Smtp-Source: AGHT+IEtk1KWCqV1aJthDdZ3rBZb6yUKU5DC/wU1d0Glaa9dWaoqmLA4qVVEnpxhuJTI6+H/ewZKaTaao5TKSDr81GZHTFHON+dg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3710:b0:4c1:4388:46bb with SMTP id
 8926c6da1cb9f-4cce13e2f13mr258826173.0.1723860482032; Fri, 16 Aug 2024
 19:08:02 -0700 (PDT)
Date: Fri, 16 Aug 2024 19:08:02 -0700
In-Reply-To: <tencent_656E089498E91AEFC2CFEC78566F042E410A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac9545061fd78b1e@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbFreeBits
From: syzbot <syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Tested-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com

Tested on:

commit:         e5fa841a Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dabbd9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=3c010e21296f33a5dc16
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ca698d980000

Note: testing is done by a robot and is best-effort only.

