Return-Path: <linux-kernel+bounces-308454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BB965D22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1161F21BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712C17A589;
	Fri, 30 Aug 2024 09:39:46 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB21428E2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010785; cv=none; b=iF0WaEnMqyIMMEYhluPs2079WqtbvTmvfAkx2jPJ2nhb0sEyrb3RTukt7cu4qloLM5dwhczEQkGbqT+mqyYcwP6SN0UzL2UrSHilU5Gb5dmRjgd3dpntiRUMXDgRZNueRRG99iHfZQihjtoG752F0zHPsYsihQFYTDDSxL9b0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010785; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Re5yqTJ/gpjF6axor6XIN0j5giAR4bErvczA2tqsou1FaTOiPvS2r4rG7i3IMj9QaZA9MAbdn8rQV/HE6Ral/5l7DwWFLlHEBgQFf1S0tutCnNdxnbzKa0Za8nQEKzpA0HgN2psKG5ELiP4ML3YiLVALCyP4lPQcEMfx30UCyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a2723a5aeso53474939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010783; x=1725615583;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=vOi8VFqUjaflk4VvzhzUeA9vYMK6YjWD9Id6PE//5+JgJCIZ4y+QQzWCAynN054j6/
         /kkfvNnO+7VCTCHfGiz0eA+gFtOI+M1G55ZkFqmjiPOQYEQgO/T8zaeMl8BXq5hh08iN
         IzzTZhbfXnEvPDm+LiKDiPuvNCCJr6cc0i1XFJK3AdN/hz+iwRaXc1wQl1AUdU50LV5L
         UXtRxIy87Aire3CcZ8pz/7sNTPnZYLMyyJHUj43SQjLGC8B2ASJPCPtCzGYUQDJC3z/e
         43ndniEfaFY526l0FwcnW3QUHDiakPJ/Rd9+x16fZS7S9ptOs1aqDyuhgmYM7wlPjrhU
         tfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY79PSwMlzVAXS4PtlrrqGFU6e1SprQWghYz29N15Qe27ODv04P0S68Fb6pRE6Qb3a0ITMgJGbnplDH1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZYlVxpftHWeOhRizY1oGrZ6QSsxbByVR1FqRmFX162zp53Fh
	DFjPtOmt7m73UTWZV0jzfPtVItqPG6sJMG7ImLX42PBKLExFUd3JvZnSjKJiOmx2sam/jkyBbLp
	cOpXe2ZgjTucTEhJzN/VxQpzmkNWx71EToRa1qA2QdqsdaTE5C9Ve8iE=
X-Google-Smtp-Source: AGHT+IE+8vcK482ksPdr2S3cq571+SISrzfra5xDCpTzAPln10mLPsgm22zB47bjdTx76XcKpDFbaqhLoqe6LmDioreScin9Ifg1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4d017e6f688mr49757173.3.1725010783444; Fri, 30 Aug 2024
 02:39:43 -0700 (PDT)
Date: Fri, 30 Aug 2024 02:39:43 -0700
In-Reply-To: <f388d965-84f4-44ac-b95d-26b2ecc4b1d9@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb32120620e35e0f@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in lzo1x_1_do_compress (3)
From: syzbot <syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com>
To: zhaomengmeng@kylinos.cn
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zhaomengmeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


