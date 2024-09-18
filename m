Return-Path: <linux-kernel+bounces-332792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF697BEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D049028240C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D211C9843;
	Wed, 18 Sep 2024 15:53:20 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0BE135417
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726674800; cv=none; b=oTiBxYKcHAe1VLNGqBuQUVUrVutB71xWYPZ/bKW5OLs4h/hjxvHheIgyp1FQ2NzGLYbTYyPcfcVXkisjZyOGS2QSPkGkKAbC8SmY88caQaNyQ7J/2ngd0BTwjwf4Wn0IsmpZ5mDpLL7CAUnSdWK1pHuPxGtbH725RGNGCQqniW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726674800; c=relaxed/simple;
	bh=eUkNUaswIa8P7UVmusL8ktZjfYKFFrALf17jGP5Uc7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R6NZWGFhA850ww9wuehY49QofpRkbJcYaNJU6+w08r3TwaVRVZcGndZu8+dsi5pbo76Jut3tUNhmfHQ7xj0ETElnH0Mrmmyk5toAluXK71eylgtYMyfRH/oU9r0ZSec+szPJ31XyjmrMVAbK9I5wt8l37yVl/V0Cj5VPKhH61+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a080ae776eso105166385ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726674798; x=1727279598;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUkNUaswIa8P7UVmusL8ktZjfYKFFrALf17jGP5Uc7c=;
        b=TOM0JJON7aEv3K6cSDaZfyKCmxaejjrTox7pStRD2bv3e/yvoXRoDir8UVk0RJsvQd
         xD/gThoN5htA6hdk4h48OkwqYnoI64ZtW8W5a4LyhcMvCWymgW9TKFUFSSWLAsy2A4vR
         +O9bocj3xiiiekCKpY/Hda/4Lj79UuKyL4T9k8Y06QGLh26iW2MGj+iyFhuMfXZKmUwU
         /O4sFERgxye/O/WzetiZdV3HD/bYZLQ0ZN2EOK9jYm5ZrxwlEY977brSuekbIs4tQ4Kd
         C4TU1mW213w3qaD01CqqhKwjRxSvexTCmdJf/DAl3yCTx5A/ZI2mdUnludXR4kVoLRxk
         BUZw==
X-Gm-Message-State: AOJu0YzrSp/+xMVYzmx+P8LHBAGg0++dyhxTfL7OgsedxR8svWhNwPVV
	Z8S1nayRktoPDbBLQLayfVoxK35ZPWw3kFwcs2Re7idxu2Qm65/vwpDTcxQVnwyeoWwwIQHRlZS
	qGh4PEguOZjrOOPnXJdpgXUoV6IOSosDgAHCMDMT+pWtfeFhkODhrAHE=
X-Google-Smtp-Source: AGHT+IElLY3l1f+0Z6fJM0k6+okkyI0cXoOLHfsc+3TK1yha6AwmW356I9EAzoXZa+S89Nbl/ZVN8uEKcqrijyAvYdjA4N8o2QSa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fec:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a092441aecmr132117785ab.16.1726674798319; Wed, 18 Sep 2024
 08:53:18 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:53:18 -0700
In-Reply-To: <0000000000005ef449062240d69c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff3050062266cd16@google.com>
Subject: Re: [syzbot] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ocfs2_write_cluster_by_desc
Author: pvmohammedanees2003@gmail.com

#syz test

