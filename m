Return-Path: <linux-kernel+bounces-432884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178C9E517E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55A81664C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB871D5AD3;
	Thu,  5 Dec 2024 09:38:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5018FC70
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391485; cv=none; b=HED3w7VlwoY21OKa6Tty7FiS5eEyDt/0SKd+IkyCRlOcIYg++KFNouySVqlSCoHMRmPE9LtdKxhetpG1n/haOiqBcnlOuNRGaeaE51gQ5H2b34JQ9FMQhmtmTQQS/au+VDICNedOjtCtayD9wts+L5G773+khUcTxuYIXt/492s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391485; c=relaxed/simple;
	bh=4sLIStA28MyjAFYwgEVBda4DzX64I5rhQMDZET9fShg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GsE0EpicL8xKsh7FXmyx0TGjnUZLLqjfItB7CKd5H8qWnLa4ErK6mt19NFstj2HYEgehMqERw8FX++I30UAPKxEt0n1a8sXqOfJHhakyun7VxBEilOvW9Et4cRtaRjc98tPK5sYwi3ZoN0aVQ2qMfRQ2H3rJVcF6HJC2BLHuZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-843faa97bf9so67242739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391483; x=1733996283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqtHx8gilipA4D2l4BfFJBVhwcTJrE6lv5dv3Qdh6DY=;
        b=ZyQVpRrXddqdZCtm/1dg1COvltp4eM3lueql7c0C/jpY9mmNsqH6bYysgiCq+BP98F
         89f38x/tlwtHtiC1+FZLwSB1I7P7FKcsYRN4f074Yowvff1s1OtPruEz0STtwkZG3gSm
         tGDArwthcDnBpPXwcfVoLrJe/p7ylNhv/GNGo0MSYY9IJzEdxznwSaeEwZSqhHj4imn1
         qb0TH7nYw4sNh+vJxQnsI1alAi63CFEN36QifxAYwrD3xyFkqlE2ZmFM06qu5DOQCKO/
         GvpleB06cX0n2S6jfwegihV7hmK5FLwm/rONu3XwI95IImFil4O4HuFfsGis3JxQbDiR
         mkCw==
X-Forwarded-Encrypted: i=1; AJvYcCVn1JRrMPOhPZOe4H7dXlXdk7bOMv7cInPiUyTFD4b6Ec55C6wF+YapbdJM9ql7c/ik70CMgqfM6nmf3qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lHViHZgYGRLc4mBPgsNZpq9pHjWI+FWd19jA1RjnwlH6HWrn
	7ucn7SjNutdqgwy69Kg3fqaWKYj2nDQEuLUh7Rs1RxQGwJougMqsvSGViWZ5C5q2zkUGgcDufUA
	lGbHUh7oHTnE8L29aEwR78KsRdFl2sCRnzOb1VFmw10OvWYtLJxbSuS0=
X-Google-Smtp-Source: AGHT+IEv57GA6xSycu2izzUL+l6Xr9iVf/IeL638k/IBXneToy8FNK5YekBaBAdo5R+iqBei9Mh44lLg/x7JaWu1FgbLlmxTvvIq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1381:b0:3a7:86ab:bebf with SMTP id
 e9e14a558f8ab-3a7f9aa18bamr138209625ab.19.1733391483393; Thu, 05 Dec 2024
 01:38:03 -0800 (PST)
Date: Thu, 05 Dec 2024 01:38:03 -0800
In-Reply-To: <3493dccc-6004-43fe-9ac1-fcf3dacd9875@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751747b.050a0220.17bd51.0097.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: 6751189a.050a0220.17bd51.0084.gae@google.com, linux-kernel@vger.kernel.org, 
	mazin@getstate.dev, syzkaller-bugs@googlegroups.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/mgmt.c
patch: **** unexpected end of file in patch



Tested on:

commit:         4615855e Merge branch '100GbE' of git://git.kernel.org..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b88020580000


