Return-Path: <linux-kernel+bounces-336838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F46698419B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329CD287266
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560C16F0F0;
	Tue, 24 Sep 2024 09:04:12 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C014D28C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168652; cv=none; b=EQCrvYkmdYsZCHwpHT0gMAVRI7iOPiwu9Z/2KuKj96ZQYrmtOCSd/S+nJ2HeccyCI3KL2+VvILO0WoPUx3wN3U/MZxt5BpNhY5ZdRlPBeFgn/MQsnTjCyo6IQMbXzgXF9u3b/QP/Wb4mpsRlHqQdD781V297wJi7vr48JNh6rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168652; c=relaxed/simple;
	bh=ZuDa8PgCetHZz3azjtXB+wao/HQzxIr2s70KrXIXXdQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eYDfXF6CP6cmu+q2Lfv8wq+k9DlFEl/haumlZbRePHeLsYmdg7TquMnN9C8jTFqHL7kbbKl88mRbWx7Mltq7xMQycepY3/AT0rI62p5IcmKPnC6lWyRcShaK1JkXeyDt40o2msLdoH6jf48onOFHIZUXBhThA/4FA4PtXy3K8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-831e873e4e4so505411139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168650; x=1727773450;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuDa8PgCetHZz3azjtXB+wao/HQzxIr2s70KrXIXXdQ=;
        b=u+MDNWJUeI+fP+3YPG4uiJGJ4c0sMj0whsYyJCUhsMFyjFcHyUa4amlF86k40W+Vfs
         /qYnevFLGjYPOJJHcYIVJql+G9nQvHmRBQqEBhCj2gCdyJhh4LN/3kw+uFPQ6YqiRmMm
         Xiv46CbkAvFzs5UPI5sowDxzW0ajmHBm1IXgOnqqMvVta7zYCJDivtTXyQLVIeT0sr6h
         FTcPKl/d4GWHnsD9U8QTCym8cfsbE81Quq6++GuFsIhS1Rs9ptCCsaSfbHubB9QWk5UO
         vxXsFMCWl5gEi4I7+jtRUfc6tPVB47/Xi3+Y9FCV8jajxzPaKcavNk3tZ26Jd+uSsA+i
         LeNA==
X-Gm-Message-State: AOJu0YyA/jg6IfMfuIAGT7QZivfT72Y7t1psL+v1AImm2QPcPYch6cYr
	CBo+oPJSrLaORP+sXynBk6o9ME9kvLjLYEw6dbqAzI/7JnTlGM0oS7AN4se6K1BUnZHmQBF19Xr
	Pb6HD4n/lslbrbg0CQU06uMV6LY3DapWmFq+CP0J54b6F0v5z0EVpyZY=
X-Google-Smtp-Source: AGHT+IEw6Ty7ZUHeNbVxII+8J09l8fpQh0jSNEwEs32FwEPdBj/c08hRJvhoVnoL5zXGLEA5DaXqmf2kKNhhb+1UiQmj2z+FykRf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a0c9cd0b0dmr126058895ab.1.1727168650044; Tue, 24 Sep 2024
 02:04:10 -0700 (PDT)
Date: Tue, 24 Sep 2024 02:04:10 -0700
In-Reply-To: <000000000000e28810061fb68dd0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2808a.050a0220.3eed3.0026.GAE@google.com>
Subject: Re: [syzbot] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: possible deadlock in ocfs2_get_system_file_inode
Author: pvmohammedanees2003@gmail.com

#syz test

