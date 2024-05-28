Return-Path: <linux-kernel+bounces-192765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF98D21C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21F428971E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75305172BC1;
	Tue, 28 May 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FKd0jzub"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102216F902
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914343; cv=none; b=S+5NhwdNEI3nQZQDl1FcrgrUN4M6MV7jAuvpxJYOTdkv0nh+DBCIEXFwg3RWOkKNjtpxkgW4vcLz6vsUPh7olEztamvTme0h5K3kkhAEMysd+qpCbiAQXIc7W35Xzdu1OH3J3Bh6clMD/wfylVmwiQEx5Czujql6omemSu/QScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914343; c=relaxed/simple;
	bh=Nw71NudQFvADv7Bhi1iggO+PhwrkQU+67xNone5Hy5g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+aMN55yCKQyj/eFaWVITsqvOjTljQSESsOa8qsrEtXzMM0qiqXR0zT51rXli+rowpoVa6hOvXChfT1+dUrHhGZJy/q2hMhRpWnk/kcHaxyY1ZVKwMEKu+s2ox1+MbxMgqSxRdI2psnWoWsVyZ/F7aU89ApwOmLc8H5rv2deqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FKd0jzub; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354be94c874so901107f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716914340; x=1717519140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5tCjk/1mXFG8ICJoXb/9fn8uz0vdilIBJSVF/91XJA=;
        b=FKd0jzub8kIVR3/Z/s1Xpf/2ylEVZ4DMbb8y+jTwQUtFFykMKSuvX7KeM+9MqodSLf
         THgfxgxjTPhw1GIjVeCjN3nvyOrf4ayrrwcto8NFqrsqVn/C5sXBPbuWCn7//cWMVzjY
         K0q5J+88G1/HxivvpJhodn4hcO1ox7r9QF0iLj7kcuhBA1EX8xBUoshdse3qSirYysFj
         jDIsilJbyQ1eGPZAqEKqxFDmo9Oy9KlD1ZGqcBXiR0InM27ItfDs+PQjt/MDPu5tdiqc
         zk77djvbppg5g7aWZnKgn3hPn9mne9b37sJEbD1wiVPFwR02eeJQJLSulrdmd9q/w6mw
         Ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914340; x=1717519140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5tCjk/1mXFG8ICJoXb/9fn8uz0vdilIBJSVF/91XJA=;
        b=BYlr1nV1iU/dnshYZQkmUgR87lsBrI9qPmSQAaCveFJttuTcO5j3EG5eQidya1sGJ3
         Z4j4vDrGow9AvzlQvj5KGtK8PsU8Z7h2jklYoGqoKaPl+qPqk3/ng8XwEA4iR/Dp5xfJ
         HKPa99r6YtWcwyUsKPEzbSoTkp2HVEQXdc14gjkzdA5quAwBbsmHkUe2pSq1kiu0L9IM
         hZKwJo8C+RNEixwBUEPit6DSwk5xNkyarwz8SGw/NaUZSDBA+BOzJZidOFSrLLMwwF5K
         2bTfFQdNgId8CJz5tg6ei1eBsW6DhSGoGiEgojzJMbmsnjqeubK+nuFu8umdTOsAiYYv
         I9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWQi3Zf18WRTfChVPu+pPq1IL455+P4nIowGvAGxAA05Mw2Oq6qo3RD6ShNBU85e4EsqFgBoyAKHA+ae7V8iP5UHl4fF7Iz6yf+KXdQ
X-Gm-Message-State: AOJu0YxvXlSDf6xwN7l4y5lQ0F5H8pNGRYyGqIFcS4jkNG9OFtjvanv9
	vpn/CvdBpMCgHKIOGhzsqmnFZEDvg36GR6lycMAUqzISyaA2/vXbQwSgecSzB2AaqUUocl/4oD2
	1
X-Google-Smtp-Source: AGHT+IF8DHQjXjm4+wKe0ifxlTmxWtxEXH6QUsVsSV1wjDskW/0w+Mv9jPx+FLRiy5/C3+ovHz3OfA==
X-Received: by 2002:adf:f38f:0:b0:354:f536:31d1 with SMTP id ffacd0b85a97d-35526c37b5dmr11901454f8f.25.1716914339930;
        Tue, 28 May 2024 09:38:59 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3579354abd1sm8852837f8f.59.2024.05.28.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:38:59 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 18:38:56 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlYIoPEq7avOkjCW@localhost.localdomain>
References: <0000000000004096100617c58d54@google.com>
 <000000000000f9561b06196ef5b3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f9561b06196ef5b3@google.com>

On Mon, May 27, 2024 at 05:50:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c114aa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17770d72980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10db1592980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

#syz test https://github.com/leberus/linux.git hugetlb-vma_resv-enomem
 

-- 
Oscar Salvador
SUSE Labs

