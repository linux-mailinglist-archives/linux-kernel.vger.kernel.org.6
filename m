Return-Path: <linux-kernel+bounces-275640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1CC9487E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEB284991
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CAB58ABC;
	Tue,  6 Aug 2024 03:26:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81893184D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914788; cv=none; b=ejm5l4WdVG6tQU6t7z9GM0tkjdOFCTl2RBWYNjjG0WzTDGsNjtwb+GbXIBcGVmDu422Nhec2KAh5MQfqZhNlJcfUwGgH2Qbo/O1SpIZR/mmwroyl/NBcJpYa3wVOLd+n7GA/K8ktJFkyBs8K6BKwZ16p0WbkMLHNHSCjare55pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914788; c=relaxed/simple;
	bh=Y0MbgVd8q2mIoRcko+GgWB3F0UrqvEp+5ZgftDAQTEY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QXyXfPRyTFAC6ZNZEHeaFwfS/Q0QmrZgGgJawhR2a9HVFjLCiPNFkPywM1r90cGdvwNnWfUAOyVICOV02xL09hi4VHP7+awihUo4AuWiuLyIUS60NFYC1yzeYf8xOCi8y0PdcLMtN+jTik2I7aLa6+WVLjNS5BL/BohqoPF/2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso3266865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722914786; x=1723519586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0MbgVd8q2mIoRcko+GgWB3F0UrqvEp+5ZgftDAQTEY=;
        b=p9EYion+E2NUOC2yjajrt4fgb3P1ssRGAmkxva8iCUu81Xf+LWXOTLyELYLNruiVNQ
         6simp0bw7nmZE7DC3+J4+rDDUWv+v3dwiv5U09ppbo6pfXidZXvrG4UQntofd3IqQ5DH
         133s1HZQOVI7wgvGJh+L3M50cBLF+kZkFzeD3ccobACB5iUNaAgAP7tOlDqGOQhyEWA8
         dJ/9t00/dNR4NfGsAupR6jBhKzd+qTWIUO2aWZ/qALPOVyHtgFbZEK+o2pEPBRy2yntK
         5EmnE2xYEQpWOa8x3aa+ocMsvDNIEX06sxkjNhH9DQBgCVQwKMXSFLlgVu1RnAqeKik8
         fDAA==
X-Gm-Message-State: AOJu0YxRL7BoRDlYE4N9XJzyKvsYbQfcVSOOFXlCmwJgdK/tnIHJ/x54
	WE1JSSJrqPKOBX1BGejMTOBuCAGItfOPMUjSkQu9FCLzHD0cNIXT7ayInm91Ft9B+cZR9Dmosnb
	z/EFgCSaDDnAjZurL7C2FJuRUYZ76bzoWaDldg5PdZsI6OPu2h3KvS1A=
X-Google-Smtp-Source: AGHT+IECOGR7pTUehzqC593vmI8e9d3C3Vg3xluUc0FH15f1hEE5vxOAi3b5+f1xzYOwybsDJCmsl0J+mFmI9+fh331X4DuWhS1U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:39a:e9f5:5ed5 with SMTP id
 e9e14a558f8ab-39b1f7abcc0mr11870545ab.0.1722914786646; Mon, 05 Aug 2024
 20:26:26 -0700 (PDT)
Date: Mon, 05 Aug 2024 20:26:26 -0700
In-Reply-To: <000000000000fa6583061ccb8e3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d636f0061efb5bdf@google.com>
Subject: Re: [syzbot] WARNING in __hci_cmd_sync_sk
From: syzbot <syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in __hci_cmd_sync_sk
Author: djahchankoike@gmail.com

#syz test
hci_dev_cmd calls sync functions without holding the
appropriate lock.

