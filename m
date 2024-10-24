Return-Path: <linux-kernel+bounces-380175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D9E9AE9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784651C243FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDD1EC01B;
	Thu, 24 Oct 2024 15:06:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580B1EC004
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782366; cv=none; b=SUzjBXMMCBMh9uD9PlhaQhCNFvF84arrwTz/Q3eBNvduOuUloPZyKF72OSdwvNNd7ro38ZE4F3q2/4ap1I2Xm+2LRq8t699DRAxHIKSdWVMp3yOJtR4RRd8ZoFotA5HQcM3vfFStyl/WlDn2HnL1WKHt7QZR+pBHSd+HZ1x9/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782366; c=relaxed/simple;
	bh=PWoGdqID6KiuMK1KJeV+vjPp4LrB3iwX3lBjr3MGceQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kr9VPB2bjuv1QiaXh982tr/PHl0rFzwT7o9iyvZ6b1THZJqwpVSFA2ArX7zLC4eowQWqJji1F7IMIzkt9LGaQmpCw+qN9ac6sFp69oNHPCqvdqlPCyqo0ILFIEdwFd5Rj8x16YMnqBWuyyoU/M/xlXVrNauzANHarQqSOZoMaIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so11648925ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782364; x=1730387164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGPVnfUtXgXUYA6cm8dmZtkuJfkWOXIMMMk1/Ufhcp0=;
        b=fWgYjxodEIcbP48l55uBrdiRaS9lDP5N4pYgpbzHht1EiUjjowfJhIE8FN5fLp6SdS
         haTYhNAAiJ6PnyQ6BpFAJBlBD/M03uBbdT5tpL6jXXMiVY2XLy87QoI2Nqn9jX3o7fB5
         4oEajWcjaIxFGipABMs8r51aGz/cxqnChDGsPmC6QCHliqoRTaXqz3XYtEgzDltJQCS7
         /E1poZFHJUz4RYpjNNaXl75rHt41EAKB2bX/cA2s3NUNG5sNJtO18JnUNrxG48LE4U7g
         r6ER+Q1wPJkssbIMtrGDw7f4vqUj3j0sWOQ19r+YKITLqjeGqRNjMjSGwuHLkKtIazQq
         WNew==
X-Forwarded-Encrypted: i=1; AJvYcCUPDmu5xkGZ9JwwyYtvhMeY3CrwNs+uQWtFS1a1jnMrG/aSckRt+mcpE68gjGUnlIDUTKoSv2sAx3RSnwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9M/7IOmLwIYtyD4DSmRU+1NnYZ9gBRpiCf+Dno7VyFYZD0tm
	YcZcnbyvFhGyTfkVrzA65Bw+K1HzwvxIxhYemjaW7AgqbabP35EO1r2pbt2zWzJEv/FVVs3aU8P
	TFxGwIsl4vsQh+my7oXokBLR09KWVkVkgQdtC3k0WweLtBLU+DdlAw+A=
X-Google-Smtp-Source: AGHT+IGUvgCZS2big3UVIJxVRCuv0R8qD9O26rt1XkTDNMy3uFlm8sV9KD423AW9sV6wJ8Es9RytyCeO9j+dPVAMeYwz3HvIUc7F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:3a3:c4c9:8 with SMTP id
 e9e14a558f8ab-3a4de7b236emr28421675ab.13.1729782363809; Thu, 24 Oct 2024
 08:06:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 08:06:03 -0700
In-Reply-To: <64173c36-6da0-4982-a812-f7dcd4d481b8@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a625b.050a0220.10f4f4.01f2.GAE@google.com>
Subject: Re: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/wireless/ath/ath9k/htc_hst.c
patch: **** unexpected end of file in patch



Tested on:

commit:         eaed5fc0 mac80211: Remove NOP call to ieee80211_hw_con..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170fc8a7980000


