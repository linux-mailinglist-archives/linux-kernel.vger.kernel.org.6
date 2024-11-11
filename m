Return-Path: <linux-kernel+bounces-404758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE39C47FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD27B39CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897142AEE0;
	Mon, 11 Nov 2024 21:03:19 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6A1B4F13
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358999; cv=none; b=ncSJ3JtercI+mZSuaCn5ObWNJHK/nre8pGNol4ewbO/VAI5J/GPEwPiUiKGVp8yYlJx+XXabNCk2QZJoB92PO0fip0lrV9OTw5wzMgv/VEX8PwifgIIeobLCMek28zzhwRGOWGXUwcBttg+U6V/iZ6CwPZ1VXZpRG/whYkjAR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358999; c=relaxed/simple;
	bh=JgRjkxQaeN2DCes4xN3ICx4uV/BM4zFc/D+mhp7jMc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbTB8+KB8xrAOLKp9mnsfgpkMSdXTgsr+0U+ZMjWe1y9AZ37saOgK41QQze0QOZR6JOrkKnVfW/mS+XjzZfHf9Q9Sl8KWLhX/kDX/8/txKWqUP1k7+42szhTrwbBdFrIy7tG1ozEXsaZqhj8H1065B7p/qTmKIZ9uTLzg8qK69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf68e7f0so514765239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358997; x=1731963797;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Plmoa1gWK3bYaaJOVMdhVpnPxQd1rc75KDWhk3Rf5js=;
        b=vvRDFrC8ugtiWrdyPKTtLGowk+5kXqVjLQXAhumH6R6eutausNxvi3mOQ90FvHq7NZ
         e7vNgPSvIcYVm2cUrzwT8Za+LDjr71nhzEkydQ5qKpfoj57MXyqoENO+jaYwz7npjjkj
         1SxMGGyfTpnZjmwdlV/qzQNZXrWbQbRtLPXQvWY/v/b3TCa0HV+yiGFe8hufn5s0T0cP
         UshjcqfD1ziYZbu9EFcCI7oN2lOHh/EiXQmlIwvxHRkjbiSFp2ohgXyZjJc9eb1QvTE7
         TbsQbWFWtCmjxOMQ3GJynOiU0k1dA2vJXWw3gszOT+XTZf2EO6hKWFGZSaBcHyqilOGX
         t/2w==
X-Gm-Message-State: AOJu0YyBMxDwSH+CzkBt6gDiZrRY/bk+5FeojfprtuAOPp5MBZBGPPy8
	/ZpBkwB9OGWt9w6Avaus7v7ZCmxptr62UVOu1v3Cv7+hfEWEcXZ9eNQhGaoBFeBOLPfFypcZmuO
	BVYdTWg6tWfTAiLIJ59onQUjNjUq6QqpU1yZuxIqsAbX3GdWH+jEFVuQ=
X-Google-Smtp-Source: AGHT+IHHbbaVUrdBIV05665elWQWo7uKJAQ/78X6/YDlqwQdQX1LNvd6TjstPDRsOPHEUez/PpYGtrrsVxjy9YIao+yRWhyLar26
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2205:b0:3a6:c4c1:e732 with SMTP id
 e9e14a558f8ab-3a6f1a256d4mr153771025ab.18.1731358995485; Mon, 11 Nov 2024
 13:03:15 -0800 (PST)
Date: Mon, 11 Nov 2024 13:03:15 -0800
In-Reply-To: <000000000000b2c0fc061e6cb26b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67327113.050a0220.1fb99c.0158.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix journal_entry_dev_usage_to_text() overrun

