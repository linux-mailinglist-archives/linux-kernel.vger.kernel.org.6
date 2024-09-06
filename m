Return-Path: <linux-kernel+bounces-318685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C4596F1A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E6DB2272F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552AE1C9EC1;
	Fri,  6 Sep 2024 10:37:50 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C681C8FD8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619070; cv=none; b=MT3JnasoHC9Y0zQMOybIdEhg4O6NG7dijB0WpkJmS3UTypiTts5N+fMjc48YIikG8pZfEDC5qUTPp/REsFYKqUN6qTY3D1fYxgfNMrc7b9Aky1T9EuKn6gwHdvRef9x4HDQW5fG+eZ2M5iEakj4fQlfo/sf3SFMzLgEYSs5540Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619070; c=relaxed/simple;
	bh=fknTa8a8xDipkCYrePSsQTLagTPC4FM5VAA/rgPzynU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dQD99C9KMvwVlxArqomW9IkvfuKXm7dx1NVZoGSdjzhbszZaIX+cph7ISuCALcu3rjCZmTd9LDk/cuoUq9eq5yNJWDFt0gNaMKTapnAQKQys7ahfBn4xKEUQe4iiBRwMURmuQohpB4gwUWJTRPpbWnCTXaMsDdishhAnK6SaS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a3754a02bso461928239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725619068; x=1726223868;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QhX9JfzOe0jyuZyP+4YKY9K8LKwJP5t7uxyVlFjHVM=;
        b=MW1FLkdpFDZUYYoVBefYZ25ajecSnfrvLdJ+kX7sq+pCER2soBpbSBysq7QExoRN7h
         CxDFjznb98ecn0A2gdVRKT38qrVxhTVRyT3m6pmNup4f3JgLPty9/Z2NhQTj81mh5bhy
         LUzTd76IAvj0KHr5JqgG3CdGq5MPrNEFFK70Umhze4s9DZKXnDag7FHzNcgKuapi/pjN
         tCdO/Mf/Ncs6EiUneawrP0IuaucU5T9riAavhNUl1J5v1pwT2rqD4MrtitwDTf2FPTTZ
         GxaaxBkboymgkX4RbhcAx8kn53Wn6zZKpPNm/M4BDGO8eXLWRimN9aJUXi96glXG9EWU
         l5BQ==
X-Gm-Message-State: AOJu0Yz0M3ehQvKXR5q6S+95F89mId/k71AonQWNX5vrYr3yKKV5CTmf
	DU+ReA5mzn16b5fy6AwtiqWF5/Ce4G9Cns8mKZencYJKQ3W8Jyr3ERETc/0E+g+e2d3bnm8rXYN
	sfB8pWHs5rQyinsTuwLGCH10e73MvtDIpW1gjrReGDH1PmFvSTn3/yws=
X-Google-Smtp-Source: AGHT+IFZPmaSzZKRtKVmu2DibVhGcPaPiauepWzZuejKR9rX/N0ytk5nTqEJoWG+fcIZZyoYtSqaE+RLgJ1M3xyAmfaT2KE41M9q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:3a0:4aa5:5235 with SMTP id
 e9e14a558f8ab-3a04f10a955mr837715ab.4.1725619067768; Fri, 06 Sep 2024
 03:37:47 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:37:47 -0700
In-Reply-To: <0000000000009cd5bc060a430d80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d6b15062170ff96@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

#syz invalid

