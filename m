Return-Path: <linux-kernel+bounces-403531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537869C36EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704EE1C20A09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AC14A4FB;
	Mon, 11 Nov 2024 03:14:02 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C713E022
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294841; cv=none; b=CXc7+ows57MfSge3UF+NmCo5911VLbSkyQFGWv2PrHi06HQMk91fIZtWrQdINIBQy7btsmRxkxFH5ZjGPpV6q13VtTNX3s8WgjwAv2XIV4rv299FQib71DlsdlgxsQnW67mpzHy71pCqOgrlDdv+Xo+b7mW1aFcyuSxwx/V4/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294841; c=relaxed/simple;
	bh=UhssTmMglKEm1kU5/VExx9EJoqtXywc3Vm88Yw6mPFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XXANRdmOdLAqsQWLozdjQhEeKSdM4fSEwyUKG4nCs6KsIMi5e2M9XQrXPH6T9CXtzxX5wMM7lDMz4lCEloiL+lv1EIXe0w80j4uz91qZfnWlDyJs74zeMZxX2lNFw8iqMJhx/c2t6lj74YbQMmpt9i+EHuGDlpiusgJGA8GGWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aa6bcd7b3so519370739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731294839; x=1731899639;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVjHQeZBOohVWnRwDVquQabZVTjq6Bi4sdd24BJ+Bfk=;
        b=O9cFsFcqx8QhQi0+HitCGLs9UN3zkX3UNWnH+sMX3IhFgqEoFkGnGnmycLKtJHOsts
         gkGWAf6mi0C1tM8RoQUPPfEAjVW4i4p8lJcAXIz77Fk8XXdiKPAx++1gweC/Ewo3YDm2
         lGNO7e5lZAqUMAIksb9y2IuW38xD7LeMcxL+GUYWdPk/VzFsqd+HagkkMlPryuodTVGa
         3JS8mdke48l8xDYs5rB3I+w7DYvAIe3mV+WtaY4IuV6bmrYNpDBIOz8K7WjNFL2SwsVt
         UwfIYLSRbRxsXW9rea5TDp8HruC9EyGFoXP5Ef1aROvJyiQ3vufInN6gX8wGk9A81W19
         ZM+Q==
X-Gm-Message-State: AOJu0Yx71b2zam0wHroYT7dMGHYYVIupx2lYW+o6Vgw5aQWA+XxJptKg
	wiXV/dzUvlVQuPaqL8b/8qFvtscY9jsFKs2+g15GUAkOWl7HlH59KfcFHbVJsi3LgS8p0lvAa44
	+SZxTRoGUXamYCC8q254vtVtgcQNy9OKuvU/MO66PaY17QYCbrGgTock=
X-Google-Smtp-Source: AGHT+IFSpUYDPBFrvcKh2Z8rJbkARmMd+G26vWhxpeVpo4L10EobxYq9UI4bKaasm3q/fsBjiHoWL8IeCsy/8MbH9swgS5xvsLPu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a6f19f0a12mr112624545ab.9.1731294839284; Sun, 10 Nov 2024
 19:13:59 -0800 (PST)
Date: Sun, 10 Nov 2024 19:13:59 -0800
In-Reply-To: <672f8322.050a0220.320e73.0316.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67317677.050a0220.1fb99c.013e.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+19c1a30221401d741bc2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix assertion pop in topology repair

