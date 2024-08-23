Return-Path: <linux-kernel+bounces-298549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8C95C8B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271A81C23D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BF149C4C;
	Fri, 23 Aug 2024 09:00:13 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0A139D00
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403613; cv=none; b=mkfHYAY7yeIdkElFkZ3Oct8i7NDptCBm+RMAH3C8aoO7AZLbAk99e+EempnDWg5duxHSrd/SITW7Humdag/Hd5Ty8+UGpYA6L35/sTAyzUbjGDBLNfaDYucV7VdqQnAFKhr01IGSF16UZtwpezgw6Z8+XwnHgFgydfVq9FsL01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403613; c=relaxed/simple;
	bh=FOLBRG5MQ1PUJWpIwb7bqObzLGJKFa5JBtGNWMD1IeU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ACR1JL7ixF/Pw2kZ2IWCzl9HtsfJNWRVNrdXW3MurspxOlpZAeByetL+CObdAw9WIAlE62uWZ/m71x0DWHFs5b0jPljOfWbob2C5rjaUwQnE9xnMFX4rHjjGZsmOWH5UsiEy2kXfel7NNnToIZkoUI/fpeEJ1j4v7SAa0v7NTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d3061c2b5so17788745ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403611; x=1725008411;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOLBRG5MQ1PUJWpIwb7bqObzLGJKFa5JBtGNWMD1IeU=;
        b=R74LLzXJw3seFeaHdflqIMN3IYI4KZu1cZ8aGGSrpRoinsYr2VRcbBu5yUmNxMo12V
         NYwc9yj5JV/FcHLuh4LjiUMyB5iia+9iBfjv6uEK4OBHDYGI49cokgYsoh/sITRTTwFN
         QQnXDT0MurW0H6oi1gJj3FLQsJp4aq6ePwTohM09RmJVYM4cirgztCJKip4P0ZvqGR7W
         IBdpoJp7I9WtIftZtPX26KTlEh9TLD6qJ323zhGa0HgtnRDNecHJJgoI44Rma3S0mRpo
         LG8bH3uwzhTGl4Vnv7pcmaPZrfC9GPrZadeFbuD4cdU3T8KMPpqrOd/fZDsVMqBYc4Ly
         GUTw==
X-Gm-Message-State: AOJu0YyYog31Nr/LhbOHOEnbwlues9UiEafhNyqjg1iGQ3anPEJsEDCB
	LxGVWcDwwxFdLnUyQ9hDccWNQlnQhgSHyBFhawzv+3/6+v7VLdYWYaB9vd5kaqeUWSGJuHC/DEz
	34Gw9RyJWEvEYiK+jn55J6wkT9xFFZlUWfCtRnBitGrijXBrQ1vRpgKI=
X-Google-Smtp-Source: AGHT+IEc/9xSDIZB7fcKnsSiImtAmenvJVJCrcbgOo61ZbRK8H4/ojmKGgKH9dawgkEw9+SBKS2rbj8LlEE3xHqLA5a418xa9xIb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:397:fa4e:3df0 with SMTP id
 e9e14a558f8ab-39e3c9e7c0cmr950345ab.3.1724403611220; Fri, 23 Aug 2024
 02:00:11 -0700 (PDT)
Date: Fri, 23 Aug 2024 02:00:11 -0700
In-Reply-To: <0000000000009262af0612faed28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b24e660620560018@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in wnd_init (linux-ntfs3.git/master)
From: syzbot <syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING: kmalloc bug in wnd_init (linux-ntfs3.git/master)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master




