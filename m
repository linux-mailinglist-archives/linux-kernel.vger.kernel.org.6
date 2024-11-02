Return-Path: <linux-kernel+bounces-393920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FE9BA772
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB1B281DE0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47F14B94F;
	Sun,  3 Nov 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbg00DDY"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAAF4F1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730659143; cv=none; b=uLWwWtvYcM/M87ijIB0O9Zr+9omeFDcSfR+T+N17ZFkIKyCR8z7gLilF6XO+hLBd0nXaXJObICj5415H7OETaFY/974nnktdnnSjJFogHGZswwnD57Wpg3ILIA9UeQYKkJiwsC8Pg3UdZF53bexjuYaf5gsrxfzl2crYYEt3FGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730659143; c=relaxed/simple;
	bh=xeMn7Kw+jzhdqsxkIxzanCn6HNL84jvYb7LwyPq2UZo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+lYz5EE90mEkOuyFR65NiSCIy9rDkxGld1gIF6VkCcaUHqZALEijBI5wIAbZjuEzAlcklHHDP8ApId8IVXvpe6uLSWnFe5juYjzyogro/JlncIuhpUxrNwRmONwXY/JF0i9JtBaF75p7Rj6Q8eO/yAjff+5zvhyWnnL65pfwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbg00DDY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a156513a1so613306366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 10:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730659140; x=1731263940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BbN3riJbdbjGNLrdo1JOwS2z+UaEn1CqM288uO88t7Y=;
        b=Pbg00DDYoSWkAU4sLI5XD3OTUqGrX+XgLHST+XRU+9GLDJBWg0ybTqDwjk5/xzRZmh
         XAl5Q4JZlpU7wXQrV30q+5DdiyUu1YGoBJccqRnmZOmEHYlJiu8lfPNlq1QBZn9BpvLH
         uRq1Pr49nw/rQb7vHSIbvmVZ+6ThxYYmP/Ipwvm+0SFeCqgvGecgWD+QQmbukqg1aHSB
         H9GwNJ+8tKbXnwzZdtmG381BZXNAJvpQ7oC8qihPPoU1xd9mTBWiOq97ZDyz+apDY0A5
         Xy3qrsgf6iWcLgBRZ/lCYlPIpJCbZTjffWdnIMH6/lki17XRpWHgVGaFM4BA/dSWOBI8
         bAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730659140; x=1731263940;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbN3riJbdbjGNLrdo1JOwS2z+UaEn1CqM288uO88t7Y=;
        b=fkz+gc1OZMpOphJcYvc9wlvUFB16fizkf0ENvZidnls5VF1JsSzgLZwm2eW4kFNqB9
         xptrFRydqzAgybCFmeHtFRH4p2JAw3WZI3Ydv1V58dbpN2opBHbWuHalnHxr4ivfrE8a
         EtJRWmXyPjMjNtyJaHt823AMftB11kSW40BBBVM44Y/0oeqn0jloCHJaCdHR7rtEAGp/
         cBv7nfefWxLk3Hfn15XFLFkKYdVGkdUqz5+vL8GX6G+V36T49UsjWTXoa+oRTCTeULte
         A2r+TvjOHtdosgi24FYsX+6eSyvOIuOwb5gSP9ggZUaeRrhmzLc9mWg3L+n4Lvk0/VRK
         tTRg==
X-Gm-Message-State: AOJu0YwBZ7luzCn1bzTOEvl3ObFI/UvRAouO8ZSKg3tHLsTpt6k1HV6g
	bkOQv+J1Zh28isztK/hah89cAejsPXscXFnITFSD0s7kiYpPlZg5
X-Google-Smtp-Source: AGHT+IE43ZQda5kgk9KSYgspGv/D7DNNEssGIO9fHQidGmKF336IspgK9Tokv3ubIemVMtBd6lGd3Q==
X-Received: by 2002:a17:907:7da2:b0:a9a:6752:ba80 with SMTP id a640c23a62f3a-a9de5d6e1dcmr3070180866b.5.1730659140471;
        Sun, 03 Nov 2024 10:39:00 -0800 (PST)
Received: from akanner-r14. ([79.140.150.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f12sm448436266b.55.2024.11.03.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 10:39:00 -0800 (PST)
Message-ID: <6727c344.170a0220.19c3a5.d62b@mx.google.com>
X-Google-Original-Message-ID: <ZyZWg+OcUibe8M1C@akanner-r14.>
Date: Sat, 2 Nov 2024 17:42:43 +0100
From: Andrew Kanner <andrew.kanner@gmail.com>
To: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] general protection fault in [v2]
 ocfs2_xa_block_wipe_namevalue
References: <67215651.a70a0220.31b018.c8d7@mx.google.com>
 <67215ae3.050a0220.24951d.0078.GAE@google.com>
 <6727c20d.170a0220.292362.d5e3@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6727c20d.170a0220.292362.d5e3@mx.google.com>

please, ignore this

-- 
Andrew Kanner

