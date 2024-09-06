Return-Path: <linux-kernel+bounces-318674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF096F190
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58160B21F41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810D1C9EA1;
	Fri,  6 Sep 2024 10:33:50 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213913AD2F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618829; cv=none; b=XqRz94ckWQLxTcXXtKFx/kZ7Ib9/qzaXFMbEmKWSOQtcooDpn1hT5b5xhDW9hEEf3Wsv59I5wdEkAzAjyaVnLg7xvbbjjrXwIfEvHTx3jkfHv57R39yibWJioJFyogxLqRudPD1a2EVshR3+30caog5ISmXefg4uCRUM7ePf65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618829; c=relaxed/simple;
	bh=fknTa8a8xDipkCYrePSsQTLagTPC4FM5VAA/rgPzynU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MKz5cO3mOiJzM0YCP/elgcB59q2BJQdU9ZA428koZdf8IgLvHLRsTLrRq80akO8Nyyi0kANUn0/ySuOZU+TFaWr7YI7jvyDHg5fwqMAVHVTnYYMMVeWFI9hjHBOhrEE3Z31dB4JLWkz0WVeJSjTxdM7imazfpMnUdnAbfdFfbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c57f4dcso451558639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618827; x=1726223627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QhX9JfzOe0jyuZyP+4YKY9K8LKwJP5t7uxyVlFjHVM=;
        b=KxJ6VbnDwq/AcPqqwzLzQOps3Gho5EF0LCKhNfsr9Y98FQVlHGbA+MeJjMVQWKo2Zs
         rLan19uy5IDZqnIuamnEXSwXCJtHVItUsfdw9pgudFmOZNWGQSsdt7W7MNog0i/CZyNk
         Ne0RrVaxqQ6/uVHLmfl9wSSNidTwNvMETS221qiWIO9WFeF8mpXI84UQ/wHzlc+8q8rC
         Q7atrXu8kSOMK0WRKKtkzAu4VoXFFTZCU61YJdGlkxySwu6c0QUDraMaelXaEOIL/yLQ
         Ckl6QOPyHwHqzkF3huA8L8zg1uZzZMiyOyCXdoKTkBzesKQ2QXWVI1stfPq3b4ogIbVR
         d9/Q==
X-Gm-Message-State: AOJu0YxvkCesyl3J9x7T9yKatjRjp+ADcvpDQQ3fUQg0DzVX/G/qsQO5
	YzrfDLrN4SDMsKO35BNUmJcLi27Jr9yhiHhn/SSTJJDtQYfwXnyLOjfY9pT3+P/SzIKZ5SdvYhp
	lREu29TYbNFLIuC2gu2l7IBXn438kuv8VZgALmfpqwFoAKTnZFlIl+DE=
X-Google-Smtp-Source: AGHT+IHAUxkMLkIqOi45B3Ul0a9mMifEgCREFbiiKWQ22AaYhjUdS97cOAa83CZNrDCZbQgPZNCMRWaMs6HGEAnAqoy6nJjIKBij
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4122:b0:4b9:6637:4913 with SMTP id
 8926c6da1cb9f-4d084f961b4mr108186173.3.1725618827446; Fri, 06 Sep 2024
 03:33:47 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:33:47 -0700
In-Reply-To: <0000000000002680930620a0c6b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a652b062170f1fd@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+d2b696e5cb7a92fee831@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

#syz invalid

