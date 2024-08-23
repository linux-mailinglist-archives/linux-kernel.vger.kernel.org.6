Return-Path: <linux-kernel+bounces-299287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB295D259
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D12825C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB618A6CB;
	Fri, 23 Aug 2024 16:04:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C218593A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429046; cv=none; b=cdgargQmIEYUff8rNrts6IMILj84hfGfKikRqZEbOI5E2PQ0UwHVJEaBlhGegqfxhytXZIf9oqapbrMjnCS0hfhGSr0d8ZHWw99FAHzhDas8w3JELlUhjg2CYbHFpG/nOPk0KaELYdeeDtLhNmWl9yhgw96e2n+dAxEtUXCCfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429046; c=relaxed/simple;
	bh=1WoV6AHnU6O+LPM9TN3fREM+oMHhMlQfRWVuyB4FP1M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hj1+OIZTPb//7Wv1EogZN9GV1d3yQwkF9UBpC1JuqGPibhy0EwOdyu/sYmzYmNfq5c6MpKTaLxd0VaOzD3Slfwlz6G/GzTrEMmc1JSc8IIcOGjgYfV/9OO9REeqdd5BaCXptGJf2KwtULjyZ+Ue2ckGvi9ayzJH8QIb4hd4ZnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f99189f5fso221184839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429044; x=1725033844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WoV6AHnU6O+LPM9TN3fREM+oMHhMlQfRWVuyB4FP1M=;
        b=kGsVk4q0Tw5AFcDZ84t9YYePN7hJOTyYFHwUiMl6PU01KamIO3z7mwXzdH01fov9ju
         +wqPMdeZL3ZjTg8cIHZhfroAHvPeM2D6b6fzWF2qDWFoW8DHjRwxLogGGdoF/ZKLpksZ
         JfshAshGpS7txQUDuALih2g7BM1kuiHlDlFNYED5MwBw7NrsRJpck7lmR+lJ70OkkoP0
         F5R2OCCJmt9W7WbCoe3JRv4mhmbCZpmQdK2h8Ix+GtuyyroxTaOJ6VEh947zOfVEC2EQ
         RDiYGGBn7UNUm8iXd3awMyoG1osS/MfwMQux8YIZRDu58b/CEvuXdWBeOogf2/6inL7R
         VXVg==
X-Gm-Message-State: AOJu0YxIZYY24y7LW8sbTssIoN9YUpcb+iau+SKnpSNKNoqFZwID5ZSu
	LZ98cLlbYT+QNV636rC3qlxoL5e9egCk4l1d8H4LvVBiVqddbzA5Vy7oyPFjGcd17hRxg+K2y8z
	HmSC+NaEfk5ms5YrSEnNaIoOvVxUMG2dWwJ3YpPRJJtNthS0gyOo5YMc=
X-Google-Smtp-Source: AGHT+IE5OOWkRu1+t0Dx42ROI2M0VYp7/TCZGZBCpvmXiRNl/29gxHz6kSMzKY62hkQPRkt7qHLkYM+Me/ix6POySCaTUn5da7Gw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3404:b0:81f:7e75:4040 with SMTP id
 ca18e2360f4ac-827873744a5mr3515039f.3.1724429044090; Fri, 23 Aug 2024
 09:04:04 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:04:04 -0700
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d17e306205bec7a@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in chrdev_open
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


