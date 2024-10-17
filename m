Return-Path: <linux-kernel+bounces-370713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E989A3128
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45725B22718
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB91F4271;
	Thu, 17 Oct 2024 23:09:45 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB01F4269
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206585; cv=none; b=rhV/Hw/IYXKUrIACwQ0HkQLLszT1ZL44Yk2lEso7aG7vsDMq6/q9ge2MDUuV1g+Nzmvrk/mH3yfEqlQjNXR2dDAkblRz+20/TzcBZSDo5p7F7jufi3nYWxQwouAXZRz5NwHhYOGoXLoFtSilt02MqKR4/cqLY9fGg4kf4WRwZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206585; c=relaxed/simple;
	bh=TQiIEXNFBhfxFbtyIzx4fJr8iobuFC0g4dUqZ2k3S6c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k54nCUIjHbsBfyEE0g8wO8j1Ki+TnBTFVLFepoBthtm27ASGipJ6ojojAvuQwEXv/W4PKCIEPrykqqU3K2KsJrMDQmvU9Qxbv6RqS/y9d32eydxpAcofD+lPPtkCQKZGKM0Km92n0Agkk75/gQAAZNZLKqcGtG+YnQlWa2oi/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so16139275ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729206583; x=1729811383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQiIEXNFBhfxFbtyIzx4fJr8iobuFC0g4dUqZ2k3S6c=;
        b=g29zqRLj45rB6rWEal5KhDy9CbaKoIoxaJNvcnL7TAdmFd75HaNkGIxZ7QCfblD3HH
         WJEh0WWJdYDOfx/pg/D4ruR4scWdK5DV2xNUZeJAtRRHE/q6BRw1MJ3MupBwnc+s4bmw
         vggxDoOMR8Dt6Q0TBR9QXp46DMe9XZ4tNa32ThJVRo9/oMmvl8Zbg5DoPPzzAJzQT6PZ
         HuIdXJKPQcqP1sU5eCZj6QMDqb0xE4VzhbYBcOJ15Qz//8KcWu6GnLB0YlO6+gT6QRMK
         oKlyYH6CYNTCD/F7r0QNrEPc1KnnIW3FiUEJPGTlNL8uWf3XFER6Wy2ydh0/a3ITTR6J
         DeYA==
X-Gm-Message-State: AOJu0YwyBMNmYz0pnpk2LPeUcF4HJqmKAKgO0jbp7L902FvAPjpYpSeK
	ozklisdPVzMLcJfPBWFChcM1NmPz/FzzY3p0WcGTyCFbqR1j+SES+GuBTkYyH7OJlm6CLb9bvaq
	wbW5xlxvoGE+4bxJpIudDT2NYViStgNWlX2y4EyLLUi7FgY8LF3K+GuA=
X-Google-Smtp-Source: AGHT+IF2CUz5HqLNvE7dr3SK88Nz4orjPg1OlYIjv53rpMOvrzadyDjxdO6Oy5eSxqh9LCNpXtfDoWom8O8fOjKHMut3XpvxpfUi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a3f40cc571mr4156805ab.26.1729206582902; Thu, 17 Oct 2024
 16:09:42 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:09:42 -0700
In-Reply-To: <66f057eb.050a0220.a27de.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67119936.050a0220.1e4b4d.0005.GAE@google.com>
Subject: Re: [syzbot] KMSAN: please work
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: please work
Author: danielyangkang@gmail.com

#syz test

