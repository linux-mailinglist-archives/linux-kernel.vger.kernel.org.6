Return-Path: <linux-kernel+bounces-201829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0818FC411
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EA71C24A11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB9169381;
	Wed,  5 Jun 2024 07:01:56 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558A42AA5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570916; cv=none; b=bUl0vcm0mbaLBLWQ06bq3XRHjJ1xMYGI29ZJr9TdBhlES5LlWiMvm0t6Cpica3JkDrS5xhcnM7My+ErIdPTffklyV4I0QBIL1zrRjgwZsTSvGYWREbcXSdijPvOQK9g6h+3+FXBk/qYLL3RrGqo+b7NhG6G/fel00OfMQHPsMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570916; c=relaxed/simple;
	bh=GhK3veeHCCCJdOlmsN1tDxlb+GTy7vH6Czb7tCJsevo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nhzGcuBPTacsIscZ34fbDzidOAF6WCOi/AYZOCk1SGlyYrdMO1oc/RaE4Yn575O8l3LDjvzOkqU5SNxwYfX/1c269WoljhfLAeNQiYQYYNEg1eRvdMJtT9w/wWsIlshTmAaMg39iQHW9LAAwPR7GCZuNjGbCrGD6Fpo7NVHzbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso782292239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570914; x=1718175714;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhK3veeHCCCJdOlmsN1tDxlb+GTy7vH6Czb7tCJsevo=;
        b=J5o86LXxyJp+M5qouC9bNYI/ThLHTzVB1m/7ggAoXJAOewvH7nf4+G7Os9H4ldmtQ0
         hPvEMsDaO1JBVdRo8Cs8PfDWsr0ybJF9dXtFTATOehqHroZPzaybxomNL7G0xs+tAY+e
         hv1A6Tb5r0Z2MGpSezH8/WTEXLFqgO69Ou1wL/p2svP+grd/XqWGbvAS5crMIj/AMdBn
         o1VpjlIwig4pfEmBMiHTCdzHtaDXuIh7bGiFraAsaphqz1NM2+2VCtitobZCPl39kJFN
         /hh9AWILX/Pd8QFytcUBt4+vFQI+xmL1VmH1cXOSouSkwsDgpYj7ag33Z0poWuUoUN1V
         g4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVANHjR1NKOH38ND/9hRJdffo0839bT9hLJ8xwBQaPKjQ89UFf2jsOWP/xObzOR2PWry2HPN6ilLg2sQickEJWuxqNUe4J4EE6pXmXP
X-Gm-Message-State: AOJu0YxRRhCLiUvy9xPuOP9xmuR292vgjT5s4zngebdwBNAnA/kJpbPI
	/Ju8NC0z+0LdUhPV7Dpwu46fimbsyV6ku3eFT5waB5us7YSFkyVPP7LWoLt1lM4kiV+8Dlx8LQn
	MGWJhu/Wl+WCK+nI2FSag08sMH+bXb27CiMWXk+8zx4GZdA7B5t1cNpo=
X-Google-Smtp-Source: AGHT+IFTrb3FQxxwAaBcNCn9i1/+C44NBRbF9gWm1DOzq3AI8fAr/Gblb89gRe2cF7oFTkYfKSQCx5K4NiEHVoORMxH6G9qtdkBA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851f:b0:488:7a00:9343 with SMTP id
 8926c6da1cb9f-4b6371f7e0emr42895173.0.1717570914405; Wed, 05 Jun 2024
 00:01:54 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:01:54 -0700
In-Reply-To: <PN2PR01MB48919AA3535C02A1D620B981FCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ae27e061a1f24c7@google.com>
Subject: Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux<=
https://linux.googlesource.com/linux/kernel/git/torvalds/linux>
>
> e377d803b65ee4130213b3c041fc25fdfec1bd90
>
> ________________________________
> From: Wojciech Gladysz
> Sent: Wednesday, June 5, 2024 08:58
> To: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com <syzbot+9d95beb=
2a3c260622518@syzkaller.appspotmail.com>
> Subject: 000000000000fcfa6406141cc8ac@google.com
>
>
> #syz test e377d803b65ee4130213b3c041fc25fdfec1bd90
>
>
> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

Command #1:
want either no args or 2 args (repo, branch), got 1

Command #2:
want either no args or 2 args (repo, branch), got 1


