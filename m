Return-Path: <linux-kernel+bounces-231924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EDD91A066
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1BB21896
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB8E4D8CF;
	Thu, 27 Jun 2024 07:28:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A313D3BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473287; cv=none; b=fx5SSmb6W2ue7jWSXh9R73LbRDCAIrbMALfe89LO77nqLChZvSZw1OfLuvm0Q2QvlOJwD0UcRBxrTqPtS+sJeKNp53Ie9iBd458CnAo5kYex1rlfYDDY8ANfwQixV0e3Bxp8qtFoznWFUhCdMy86bu6+0JQ6Oqh4//qcbGxX4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473287; c=relaxed/simple;
	bh=svKxf7FJgdzdlh6fn7ki7H4RpvUux9HDC1zEo0LNoOI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IjI11TDGKgZiL/Wpkg6NDuKIs3cd3i8UuHyZ41DeUpDqSQNdojVh0O6a1BB9QNm13G5CbwCEJrLCaJifYqa0PqHImbnlInl0vCx5M4OwANiV56q+Ux8FY/SiFGnBL3tKY/+9Sd+MTk4qCkrJcg90vUIl7qSaHtE3vlWOtfzV370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37714b7f378so32784395ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719473285; x=1720078085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba6truMrOKahOpdSNSzFVFXsBzSHTgUl1tcx+NYcVHk=;
        b=Q11JCiY2PhBdUV2brqUPM/C72oup/xcqSG3ZHN+Up0k3lVBVzGtW/GO/3ukrrkuWwl
         HHryMn1Vw1yLZnGRavqw/4E2Sl5ClB53kpFGh3xHn3+WF/zagrIekNgAXsla9A7VM3x8
         Kbp3Pznz5+AOTZFEKR9HqiWOMMV6jAGaYY4p4AqBAyQawlGDHlUZexUPqMyL92wZ69IE
         drKk7z81PLS+xfiQwa6A7Sp22dgBZOP+KQA5QEait8hc6qISROuoE0VfJV3vth7CGu1R
         msDjGuhjYX7p9ncfymWMtdSH1inttMXJlG2byzD4BXTuEA5iD8nXPckKDz4zDEIFu2e9
         vxRQ==
X-Gm-Message-State: AOJu0Yyq8uhjZSausIeE7yXKRIRLwNhSoNLvkiV0QP8HVhSes4y1ajXl
	5rN4MekadETG7Ud+V6DrZgnLX2/SuXXyEmhpkNo0/GQfIHAi25tzzsrfL2yiRgTWTN8XzGZfGbz
	l1I2gUqrCh+HqPAa6VAgsbJ//0zuF/8lKu+r0qYPjLec4S4RUhmNLSAQ=
X-Google-Smtp-Source: AGHT+IHRSmruvXfxnQubDL/UBxiK1YpkLXaat1QZwNCDZ3XOvqEWx2MT5PQhvQ1Xxunsyqsk5Axf8+cGd7NxURXjISoWIs1ngvk8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca2:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-3763f70a5ccmr13228895ab.4.1719473284878; Thu, 27 Jun 2024
 00:28:04 -0700 (PDT)
Date: Thu, 27 Jun 2024 00:28:04 -0700
In-Reply-To: <CAMc0M-8hvnC=kNF8FtXqxCTrzjkG3q-BhmAckaME48iNJVHQvQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058ae72061bda12fd@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com

Tested on:

commit:         afcd4813 Merge tag 'mm-hotfixes-stable-2024-06-26-17-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1427e301980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e40800950091403a
dashboard link: https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13838f3e980000

Note: testing is done by a robot and is best-effort only.

