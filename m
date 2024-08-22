Return-Path: <linux-kernel+bounces-297744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8495BD00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C201F221F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B781CEAC0;
	Thu, 22 Aug 2024 17:21:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D811CBEB2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347284; cv=none; b=tFReu/OIKlbBTD087ohf7iYhuWoRnRh1EpVP77PUW7KztLewrA6Q9ZwIlqisREIYF9hox9xGp3kKULE8R2X2203KLyYu5xGaCpJodVGsQ0WtMYSbtqXfuTyS13LvQ5cM2+l9DraXsiSiYmstotybZshLhk9r9ThA0+Kjy49NFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347284; c=relaxed/simple;
	bh=uiZy9fU2qRX3mN/Jy9QBg3y8MozeGEjV9lm9CsT2cCc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DdC8r3QtOGMJs7cU5BRP81qCHWgyDfd0dqko3R2HNJv/0KaZlF3KLh0mGJBjYANI/XuNNuK6qbM/8pSTci6zxYAtmpsdcx1vwhTTS+GhdY9/sRVTsy/BDXhta/JLSvbWFNWXk58zzhhkcSpKccqi81j7uxWwTwEVJ2y9Zh3n2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8489097eso101680839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347282; x=1724952082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiZy9fU2qRX3mN/Jy9QBg3y8MozeGEjV9lm9CsT2cCc=;
        b=lz53aR23WtYor7eOmcKbp7McTmfIqbzG8Whi7C3Oqw3tifQ4iyowAs8U4u+nVK3jWG
         wJU5b3j9BdKiTmUWK2C27VwzNl/7rbdTKgFWItkGMgvjCxUiLBTHK8W3u7WHDLUvviuT
         lqYwnhcZSAIxm3irvn2Prvb53vtLNAa4jERxiPmVYpa4bWGCApIaAmfy/PguNh4YHHU8
         GziPf3rGbOQqutVUBgyzWx5FiKDvmcUBX5ojJWJ0DGp/wnN26Upw7eTTOdgDOudtm8yW
         EkiB08X9i/v9kys/dT36/Otr9qk3al/a65vpu3OhS4vfa9Qk6hoDZMkZvbn+oSsf1Rfs
         oxBQ==
X-Gm-Message-State: AOJu0YxXvlpBC/HMoVdRXJZmOpblCssGKPeTlGSjKohEE+fyd4TSBxuB
	nfjQa2cuuA/p499/1XPh6wFYumrH1wWcV8SPQ2AOO/JhrMObrQJvrdDeR9y7ukgZBqf0klBKJ4Q
	NTrRoGeahwpKMivxtL+tbJbCrp24JuYKKxEivkWY+WPtuczlrWqtTJCA=
X-Google-Smtp-Source: AGHT+IHk3FUg4eOZG7xu7x8T5BoYvkInKuS1jP08gumsIzJMACHPSzs6ddSjcrKfaw7QxGSFdKU62wJrK40DLqW894aayapq6cKs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:39a:e9f5:5ed5 with SMTP id
 e9e14a558f8ab-39e3a5dfc12mr279165ab.0.1724347281953; Thu, 22 Aug 2024
 10:21:21 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:21:21 -0700
In-Reply-To: <00000000000096a88206196a8f03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035eabe062048e38d@google.com>
Subject: Re: [syzbot] KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
From: syzbot <syzbot+8cb7ea0ddb1cdc8a21fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix shutdown ordering

