Return-Path: <linux-kernel+bounces-375300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386DB9A9462
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF56F1F23054
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A51E6DFE;
	Mon, 21 Oct 2024 23:47:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125610A3E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729554430; cv=none; b=lCshVjJc7F0iJImMjTijuQAzZ3FhVEJNhnya/jRbU1xvu9b9Uwzn23+BZWmLOdL/5wSxS766hAaNF/FGc1y7jmvCEEoEFynLnxP4rBmoPr1XkKG5oJ5yzHm+xMHBp/ZjqSO7rNHOso3f/jjDgAFNR0bMwZ90t340e7NoDHgRFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729554430; c=relaxed/simple;
	bh=NozUlYNWVVY69UHyf2ZmgXbQwHoJfzdmSjRDHo/h90U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JpJev4cGVwfeDOX7aTR17OtRTvIM0fgN1DgIxr519iq98BEmJQvRvZnUbNTPX/78tMqwsFb7bdmsYDggRZPMhLwb04bJ5WXCAUIcjBu0dmvz2kZiVMsbwCBeGkDcEAuuAylkPPhypqJK/MOI0D9bmBU62g2jt/tLaV2CrRlX4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so494333239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729554428; x=1730159228;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NozUlYNWVVY69UHyf2ZmgXbQwHoJfzdmSjRDHo/h90U=;
        b=EnI5rAcMLR0wAeQXbqsPqWOgXqjii2aUwrrOBCBwBqozYrVvu+TwBTS8HzaRMKDcH0
         WpVuodR2CUtS/XsSfQS/afuUGUBCCzets95jCb+kimCN5tvAZCEUa4hy415dA6pOQSS+
         R6fOSnnayKkN5LGfr+oHTJE6wzxxjI76ehqO6VcrANyPpJP0eITcZrPClNHrue2Um6Kf
         jGyvCir6g9bmY9rla2rKnE+FjjxTc8k5aZQ1qaKMdaaZhNbBQJUjV1BotygoprMnZLzZ
         rIo1mNLIJj4wwU1Z2x9iov3k9XZpgHULCqfGqbUDhHGB2zZI0HMthOy5SyMxg7gUK6Kl
         Lyog==
X-Gm-Message-State: AOJu0YznHVguNvFj8NOTsUIeAGEapa5vtey+4Cejb29ZMJAuV6k+8I7n
	UxfgZ77SR9Ea+6WEW5kUFy4Sl/JGHF5CBuxFaCShaKZlOW/P1DLlBOl/7j9Cj2sXmKq8+7FDsAV
	Wt6zszgrnSp7Crh55adNXK9BcHOi7yoBJtuUJN0NstOJvtFVvgMkDejc=
X-Google-Smtp-Source: AGHT+IEMKaudX1MdQ3ht8IKE/btIw4tGjk8coSr7XV3Z2xJ4OIvLAHqzgnHhcvVmSDFPlcmhz5WH62Tf2EW+KGEhrSCS36PyNCSU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3a1:a243:c7a6 with SMTP id
 e9e14a558f8ab-3a3f40531c5mr115406215ab.10.1729554428242; Mon, 21 Oct 2024
 16:47:08 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:47:08 -0700
In-Reply-To: <66eefd0c.050a0220.3195df.0061.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716e7fc.050a0220.1e4b4d.0065.GAE@google.com>
Subject: Re: [syzbot] retest repro if bug still valid
From: syzbot <syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: retest repro if bug still valid
Author: gianf.trad@gmail.com

#syz test

