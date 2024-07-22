Return-Path: <linux-kernel+bounces-258872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F27938D89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C099281D02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB6016A94F;
	Mon, 22 Jul 2024 10:31:46 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B90149DF4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644306; cv=none; b=Gn8f1GJBba9F7HDWLB+2uJ6yUC4trtpefzZ/uvxA1PWrCmbDBtsVa0i8gqnsKcgKKMFVP8e1qwyC3Y7kKv6m/SKWpVXLOllp5dyXyQFtdVvPhk8gV3u23XjG/hUVaiRx6HeisVztDSuTZPoxiyPI9bVSkR7s0seFfoUOAJc6qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644306; c=relaxed/simple;
	bh=vXCvBXLrJT6r1SPCz9VzEwjr+qTwbg1kTtXEKaScPm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ko4t9Z42y4W/hsYQgHSNNNBlSkdbCfE4WGsLZ8W/1dS6lKmKJLWjjiyVKCIHpdqGr+7fuTzOdM35q5LxwfOa6FVX/0INr6CgwsCAU+UeihdxFBfbq8PTKLvjj+C8l/KBTthcRUxyhpRuiE8V1qZN27j0nYM806RCk4JrWNjxzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso737259839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644304; x=1722249104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXCvBXLrJT6r1SPCz9VzEwjr+qTwbg1kTtXEKaScPm8=;
        b=XlsRLlaOMVQudwjnWmsS1ZyJzxsEBIG08fZ7xutSqMbFbODwKxQod8pDCsKTYnaqUS
         3WoPJWSd87Nsw/bEXSEWoM+nBh80ALpXKASg8pM5fu+WUxLj3WNvMLGGEXjLCl001nAb
         jfpACv09dOl1Oz8OYSpf+JTXZCgXs49CBOIgVGg90RqyNJfplYollKDlIaO/oyeQJ84K
         fYvUQcn4jPMEJY0CwdMx7k9OYqQeKeDtLb6hFBmcCqQXljXjVqUYk3HZ2jHpQYQ4jkN9
         1CQLjqifwvM6LpmuqUC39aSOsQZRbtuTH7L7Mfn+zwfUpZaoywumg2OlxAMuPMpZwYaF
         gPhQ==
X-Gm-Message-State: AOJu0Yw1WOWEe5VdoLpO6IlpgbWpoRTBXzhQ/3/V9rjhrWSjdL36cuwR
	je2q6JA7HxzolTC7bvgHgsXva++dTvZ2vk7VTGulIziNjWlTja7+jYCQRiDQvQ9WzBB3oKfEw96
	EXP5QpO68VSZSJTEs9FmZ7HRdPDMtZyHqMpBqzJroRk1S/nbbR/NnzNY=
X-Google-Smtp-Source: AGHT+IFIVYCtuko0E/pl8OvfFZZN+oKp+cSmzjnBa6xgDgHvSmiCbYXFZx7M28IFVwc0w0rUcucgLDwqBWy1iUGOjOBoN9E5x1al
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8429:b0:4c0:73d0:3d77 with SMTP id
 8926c6da1cb9f-4c23fe071fdmr500683173.5.1721644304628; Mon, 22 Jul 2024
 03:31:44 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:31:44 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035104c061dd38da6@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

