Return-Path: <linux-kernel+bounces-408844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5E9C843A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384B0B248F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601981F584D;
	Thu, 14 Nov 2024 07:48:17 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C221F7544
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570497; cv=none; b=Wt051GAMurt9+LgT3NETmTN8OlJ7gGVmycIhO0HyxL63tADaiacJSr85ose5L+fsRw7dbvwP33g51qTdJAbnzmPkCJtfYxHCfl9X/LK3vpHgHpqlea+rZ5pHfot+Hy9i6HB9LETy89UnyEl0GiDZFfzINBm/OsqmAswHmfRnV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570497; c=relaxed/simple;
	bh=7vO5VppK8mbJzogWj4XWKvUgXVA0mHLTXmLcvJlyqpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XZN/EyBfEFH8fbXgPGZxUlGw7vlLOqgIXbiijGUxAmaSAYtwXbzM+AxmY1AuFtqa4t1SPBlnDJKz8JKxQNnVz47U6WBWOLI9AUTIES3sK+zrPZkChxKuEDMMrIIaaF3f7bQnsa38pvEQ0XiyU/790YC9t7SILS+tCgwoD/TylZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71ea159acso5198095ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731570495; x=1732175295;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vO5VppK8mbJzogWj4XWKvUgXVA0mHLTXmLcvJlyqpk=;
        b=bM/IoskKqj7IqCdGPfUE3pwl+ZMiPYt3RnY/OGPMzJf6/WjCISJfe7v0vsVaFsB5rq
         hlWN4DCjku6quA1nLBFQiL9amBe0ZQeWdTkcSAcGpioJnxOpIaARczd4T1/y7qScK8Y0
         lZvvnAXlSRFsI0NxAbck3Orh1kpObf9K/Oz/s447SA37jaLPXYuQowmlB8K0haoyrZm1
         fzRD6Z3Og5ZgxQvTR56dwkIAIc9fcTc196qxkT8UPxJJZhA0+t59M0oEL8iIDeExR+up
         Op2T37CzqfUEI3/4WzJXc8OKca2PVp2e1aiYhQwG59EPDhznXsEodfGD688guXp3WVl0
         ub3w==
X-Forwarded-Encrypted: i=1; AJvYcCUftBdPUA26HL7ueApcC6GRa2Rm/a+nvenORoL13i93t6mpBiVFlp1j5nf/VuKbW4nkp/03sa0uOkwZtMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsyhPj78jXkFr024biroHnfGt3fpMEpo/SIpn4ldIs856Ezgo
	K1xbXKiItxQWqjUOcFdk6j4UU2JBuP16VRXcA3XVS+cXm+vTnTE6sTdqwmKWgayNZVEbCKwQYyd
	LxHEYjvC0qXyFELzWjprcJS1lWpr3skzdGZSH42YT6LkPMxCe3cKiuYU=
X-Google-Smtp-Source: AGHT+IE2j7G4fe6UYc4sGoZ8nsKR64vTwa5GIHuM1BD8LElZpFh4qb/q/SZfqP80IeOcwM51DO65AY94Tz0bdJMRFKBpH1QCHrRK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:de10:0:b0:3a6:bafd:5650 with SMTP id
 e9e14a558f8ab-3a71dec4245mr28819435ab.10.1731570494795; Wed, 13 Nov 2024
 23:48:14 -0800 (PST)
Date: Wed, 13 Nov 2024 23:48:14 -0800
In-Reply-To: <CABuj9FfS3VA8m4QPwsJmECYZqumHY3H8_GcVdGa9UG1SEBY6Lw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735ab3e.050a0220.1324f8.0091.GAE@google.com>
Subject: Re: mm/slub: fix a memory leak in sysfs_slab_add()
From: syzbot <syzbot+d0bd96b4696c1ef67991@syzkaller.appspotmail.com>
To: sudhirdumbhare@gmail.com
Cc: sudhirdumbhare@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 1

> master
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 4148235ba554..d10c4fbf8c84 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5653,7 +5653,7 @@ static int sysfs_slab_add(struct kmem_cache *s)
> s->kobj.kset = kset;
> err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s",
> name);
> if (err) {
> - kobject_put(&s->kobj);
> + kfree_const(&s->kobj.name);
> goto out;
> }

