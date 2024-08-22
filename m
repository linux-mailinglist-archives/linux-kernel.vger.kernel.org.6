Return-Path: <linux-kernel+bounces-297720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58ED95BCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9C1F23C89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C31CF280;
	Thu, 22 Aug 2024 17:06:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0E1CEAAC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346391; cv=none; b=ZHqrrnV5MIunezCtiF9CSgNFCSqx6dVWtEF0KlRKlzv0nvD7Xa2mgtxMk3lcUc/xBLl1oa1EUF+8BKW99KAD7W7ETV5mpsC6lmhEfbcbG1evbLaxDkvSvSLXhci8//QoNr5TpbyTZMuOFQjbVKz3IviAsfIfhkbgaJcG9PlYbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346391; c=relaxed/simple;
	bh=7yIkU31S1LdrIOj+b/X+/HzYy5XSkla/QpsSZ1JxhS8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s1m2Egxs8VVwdz3JMli9X/wgyXw7iCzRf5p5GmycmEutbL8TZxugcMt0OpojdQQJVtEX6uuxtoOQy1tjjrUv4rZBQNeNlqmg2duBIbbePCGenOhVZIDtPTMAl/i66jhmNojv6sTUkKk6t0xWgkAIc/91qxe8PxEgBB0ERTGo5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824d69be8f7so104281939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346389; x=1724951189;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yIkU31S1LdrIOj+b/X+/HzYy5XSkla/QpsSZ1JxhS8=;
        b=cEA5F1ZAyQENr7tVFBxkcYqZyi2ThCjZcB2IJpM5Hkj3ovvoI+9HW/OoUxaWpnaOcp
         nqYJxU2KS/4bLxd9pJ63zKZ7YGZOvrvfL5m7HPkFjz3vKlgovmi28Kmon0jJuDf6hetC
         vv239wDuCN+1MLibMh0ljkEWEz7mhI6rhskfbHDqtuOHA2wAGTY34O8azpiBbFhmy9RF
         lOr3ndDE7McF4VOGZFfQ8zY6fsW5kD0iVweIx/jrkmee57jqxb9mCgtz9HGPcRetXVMB
         TCl3QsVXnqo1PZTkC7HDnqgw3TpSxB37qge2mtThSJz1EXbvi2bxM7upHq9wO+PuPhQh
         jSjw==
X-Gm-Message-State: AOJu0YzSVy1njVMpvYR8SCqQZ+CvqLtIWxFYSIURCnhVvn1fgbrjL8bR
	2Zjr8/90HLSDN0BaDWSQEB8kV5lbofyzNeAhrqjjkotqUP9/07WnTfBGOC6epuQzHqZJATXoxPs
	QlCpNQUI5JoknAaLdbhvMA1wSyL/tWjhKTXjEAXs6FSLHwz1aa6pe0xw=
X-Google-Smtp-Source: AGHT+IEuC0S5I0/OrAXRMoZBjyPsxs0tiRr1B8k5Hec+unlUC2KOzcxsirvZB2Hl8TKM6qbb6Dfcjd+JwfgI8N/B14fa5L5yk7nd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8609:b0:4ce:54dc:fa44 with SMTP id
 8926c6da1cb9f-4ce7f3cca92mr32456173.1.1724346389364; Thu, 22 Aug 2024
 10:06:29 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:06:29 -0700
In-Reply-To: <000000000000b4d66d06192d22d4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000211f1062048aea7@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_lookup_trans
From: syzbot <syzbot+b09b7a89937134dc8f93@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_lookup_trans
Author: kent.overstreet@linux.dev

#syz invalid

