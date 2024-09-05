Return-Path: <linux-kernel+bounces-317288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BF96DBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FC1B24F62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377A1754B;
	Thu,  5 Sep 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JL9yec2W"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F714F70
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546979; cv=none; b=gfARRlHBLF271P7GTnE/i+HoDt4zjlLAk5fYJlvMnrbogGrqBcg1EbYvwFVlwsIn/DExzrCT/jQt7onGOeoD6cl3ljV95uQCtR6i4k0S3jHiSaOtk7/+WUpZuNDsck0xIxbUYvKYp6DbUvKVFdUx6q8M7Gh9sWerbApMdCbAgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546979; c=relaxed/simple;
	bh=TwzZDNn6/aIcaL2PjkHTFAjQESUAevaKccoYFmhzLqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTJhHc3qgxGStGTL/adXMFOc/SGZK9Iqn4feKV5P3AJdYYZRSshmDFaxuPr3wkN8vD9tGsYiHh/hO9YgpuGS7hgJxAK2U9t/0zvC9AVSOH4wPTLYR8rHA1Elcy1MrlJ0Co7ITY3ubifbD8zcZok2cTY3taila3GRp2bmzu8YiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JL9yec2W; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a95efbaf49so57854685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1725546975; x=1726151775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWxVb8xmVQro36nM9UApq5w3HXM89CSYWT91rgSRYNc=;
        b=JL9yec2WFgqE17OWURqDQgDMDsBnf2MQ1fcFCOASIsQUHqu0nPBR9Cuzdop/0HKRLP
         frso3HuKq8r8XaEnohxL8CCbJjH0cqSiqBMjkZCkwn/slHyIonw5foMg4I7VLm0thjYy
         ZlGuQZPq9cQoPY1ay3/2aZS4nULee+F3OMVlwqWLCJGllNekXckP4xxmEmQ1DMpwnMBB
         TABRCkqzc4/vMEkoQnukQg1qCufI7MkR9/3A2tySCsTvDIETb79oA2sFoOxzUVB6yd/Y
         X+tQ41l1T3IHE5zgb6KG9SDO2OUc1mfU7LZnPvt8Td/gVJ109o/WtrT0hPPh7w43HPbJ
         +Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725546975; x=1726151775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWxVb8xmVQro36nM9UApq5w3HXM89CSYWT91rgSRYNc=;
        b=SsQmnuRFNggQ8vUrUpSw/R9ClYSrxC382YX7ENuXidyoDR5QTUG6xcdqCSlgP1nFou
         gzFE6D2HtRd2hyvUzhFTrs7BQHsCXNQjwRTPlaz9R9QKS2zDYrlQOCZbFurzocJVjEBY
         8kgX4tyt9ZddeaYSKG1R66Si4bl3KjkkizDHquxYLgGD7nQOJX4XXnBDhGJvwKidXRbh
         g2jkCDiLVWz7QZqwEMQk407EGl4T8BkPw2hds7jp1nN4fvLQzSFaZe5QmEmpfDiLIegr
         imwCXixpWyCWVbh3AeIFxOFzkfZocd0mGzGold/pgIwmU+YlgLJBYO8mbl6NJ4w2rmVQ
         8fCA==
X-Forwarded-Encrypted: i=1; AJvYcCWlrjJUJjnPIIfeBHUNydMHmuNXndeC1CkKjWoChUd9Ti4XxRjylTSVNiCWtTpK7/zqF5KwmeLgOkPHecE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbPQQtgZ+rstquDD2QzSeL+BtDptg2ksi/QazQrX9hwdIANy/
	WODtAo58PYG7wSSo7yidHwOWOLoTFmFzros1PGVlR5AUt59hUeviuFBLo73Dhw==
X-Google-Smtp-Source: AGHT+IGk+3ykQ2QjEZNrEmT/yy5VNBtFb/T2Cip/VtzeQc5hEjftvAO2PICsvQ3ETT+i54wNlwP71w==
X-Received: by 2002:a05:620a:468f:b0:79d:7cfb:884e with SMTP id af79cd13be357-7a9787eab8fmr1234542585a.4.1725546975295;
        Thu, 05 Sep 2024 07:36:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::24a8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f00fe8csm79339085a.125.2024.09.05.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:36:14 -0700 (PDT)
Date: Thu, 5 Sep 2024 10:36:12 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+ab28cee83cdcfd7f87ca@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in __mod_timer (5)
Message-ID: <bd966ef1-feb3-4ada-b133-e3c865a1e6f9@rowland.harvard.edu>
References: <0000000000008cec8b0619e97267@google.com>
 <0000000000001dc6ed062153467b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001dc6ed062153467b@google.com>

On Wed, Sep 04, 2024 at 04:10:02PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 22f00812862564b314784167a89f27b444f82a46
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Fri Jun 14 01:30:43 2024 +0000
> 
>     USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eb4cab980000
> start commit:   e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
> dashboard link: https://syzkaller.appspot.com/bug?extid=ab28cee83cdcfd7f87ca
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126531d6980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b27be6980000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

