Return-Path: <linux-kernel+bounces-299242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B279895D1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F653283884
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B169F1885AF;
	Fri, 23 Aug 2024 15:43:20 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7818BB94
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427800; cv=none; b=pq1zMBcrKNavf8BFHj4PkrmsueGyEQ+mdJEUS8tzrWNqFdK7AVfQp+zma1vcHr6/5jTzJt/28G0/HOZLbt62haeF/8czhDE0nMzlmJFwzx+8p86WTnt0W9olBCKH3cBIPhwl2+uOLy4Q/5HnJHDwzcLg19m7LDNfDuJ0AGeCFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427800; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=UEJsnIJB/vTjLiaLr5XiqM7sOjSyC3yzYPWUAXolaybKhS0L/P/GpDBLDtcu8g2ojgi3HHO34lSYk0s4OriLwN5yL4/K4vDyXQKi+ULTFVdfMXUjB2ss6wWnXrqQehGdYXAhiOyAMsP0P7fd74er2qAzgglta2UWvo2Xvenr4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8278114d3a5so146627939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427798; x=1725032598;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=KOuIJLjOoaLpbzi5HGjJLAUzMx3sTGVDA/CzctNyK6WAEc6RU3MOSG86Ttq5agwW86
         BLZfilh3rhCwWzIpKjFr9TBMBy+GVl0It1Bj2ztt0NGu/tHKbYXSYFc7lV/wQbh9lm4w
         81mKAQ2ZVRkPaz70dOnNpKSPpPysE7Vw9IkWCiS85ii0ph5c0umSD1UHd160Xb7teRzF
         JZnLV6xkhwATgqeODYV1ENxnIzD7Uy5TPLfoDraRyfePwcPJ3txwU3G3pzcIp/mcZh7c
         7HuTUmNSnU84moV8lOv6qLEjujTtG9T054IrZ6qcRzeThpp8bcTFeatQm6Htdm4FxmUb
         pGBg==
X-Forwarded-Encrypted: i=1; AJvYcCWQvre1V28uyXbOptp4hmJQFq0KXHeL1h+wG7GfTJ9O5bOxWgH42cO0Z79teAeF4WWI4F4ZC6hJfU7ilzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdqrCpJU+6gG4T48VmKd1H02WSeROeO6Wp7xLa92YLfIYbZir
	TEcK/6IwCiWauEOtVS51ZzUk8arIA1O4fg/Qf42q4VNkCmNuQy/rP8Ct0ZeMkhcUeps4MPd7jXN
	iYLEHk8G60mQME0Uo820hVdhBFf5ASBqZb9Q/pf3vQbOzMOOcuNM9r2s=
X-Google-Smtp-Source: AGHT+IE8lRrP6Z2fji3cQAhNEaTRge83TNuB4ivaOtx3GeNrpuSVxKd5ZOvOt9wU+idfcm4EC4Rw0+j2NVAKnPowtRkIgRUTOmVC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1485:b0:4c0:a8a5:81df with SMTP id
 8926c6da1cb9f-4ce82b2b3famr94729173.4.1724427798071; Fri, 23 Aug 2024
 08:43:18 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:43:18 -0700
In-Reply-To: <8aa4362f846548b3b8106adf9f7968b6@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005859b606205ba2dc@google.com>
Subject: Re: possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

