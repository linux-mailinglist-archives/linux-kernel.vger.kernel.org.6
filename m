Return-Path: <linux-kernel+bounces-574573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC4A6E6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277F6171587
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25251F0E4B;
	Mon, 24 Mar 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="R5ZQXgFH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740B1EFFA2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856708; cv=none; b=fN7y/9kgaR92D70hq7vRV0xFaX21Np5YSracQgmAiZGXIgWTUu+BJGXpJev3M+hAr5Zs1jeTDMX8LU6UCRH8JIAyd4q3I5kulzlzR0gwCZ6vkicsB5z3ANsL1XITOcxYgnjFQnN3Kea+d+XG6hhWaOv0lDVAd9gMKYdE9Bwel34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856708; c=relaxed/simple;
	bh=sINURG8TPjWTJ6BG4UIC+MEa4u8qbkJLpUIbNvmW9/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh55mCUx2AslHDRNSglcfadyThkc4BarYGue0ImPBOLkdm6sEABuFrW+AXbGd3xbmE3wZkwCvz1SJEnUwkE/xtjg9MCkrA5jLCUnUB8u+xiNHwaAciSY6YbRryaAWbShacbKKd1v/F+/MGXi1xnfzzNm0rvp4mSqaC65DdgfiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=R5ZQXgFH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso81627895ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742856706; x=1743461506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNZIAuzYTTeAort3nrknmAePklLNuzFFtDGjptmIzOM=;
        b=R5ZQXgFH/IDyjy3UBj0w19mK5ZDC+DjlVjMwDSIHJyS6F4GLejnOuNfJ1SZn0Iwe5T
         GaAOHiiP2uu/0y7hhQOqecYdko/krtPlGRXY/xCuhiZ1JYdgLq7GH40kJtJql6Tqt1Lx
         96wdRclw007Mg07QOD4qOZk0jmp59eIa6DpNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856706; x=1743461506;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNZIAuzYTTeAort3nrknmAePklLNuzFFtDGjptmIzOM=;
        b=L51ZmtjmgQrG9OpOtGQGZbh1zfXe3q12xVj0LYvhDjkV2PSV7lsx1ERkpV2iYiKsxb
         70vLmcIdNfIOMtcIm4vZZCctYk7FRw2wqK0vzZmla+7dGcsGE4ynbEZJwIOGPMiF6bMV
         qeEvLyCEkeORIoOWj/Yuczh/ySSkq520zZ6yVdadJH4BPZ3fBuM05Zw8kYuPPvmETltx
         +56Zk45+zqjIQIs9vdBx0Pr1eQ3NNZxj7/xSbyMYjw9Ut2hO8VyX94IbptF7Xr9dHHmR
         +XIukqxyMdSEy3BtvKnfJfR4mTJO0sKXFe/5/9saxZEvepgHXJRGXt9a8z7eeUIpMMIA
         J5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDYvoerL3EUNbQfKvOjGEl4yF7JdVwkEl7Be8CAY+lB2p2YiXsyj2jNk2+aYSAGiraSazc54UaM1Pm3G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV764mMCZPdrv4j8EwdpUcOL1E81u30WViAgEf+34XUIpamTjR
	Q9upOi55v6L5xx0czcNTlQMXlf6DViATq1Mctie915pQ7Ml0QKyOejYLApuRgLE=
X-Gm-Gg: ASbGncsKpPxSAvFt1PmYCsv1paMotLS5MWZQnI7A1ehlbba16E/Z/57lIHvpp3pJhzJ
	SYXHbC+GwLXSGt/S7alJ9sbKZ7u+slWV/o9v4PCwxvxg2jo0ZR1hJKnmuIa7iD2Bc0KDYnYzgL+
	BID8XAfUOPiINHC2YkFzlVE6Dz+ol7DzK+mznlMMB9CS8ko4x0WPxcqigSzfeqKYmC968VMGSJC
	PCZWeYfkfIrvaVYhuwGMQdkwG7DnOlrnBsQNCkhyYmnfwFfSbrw28ajvSYrfVxXTfc92MP+NyX0
	cKlOcoD25/SHskrzxldLubFkueCmKfcWD47x/4lRntY4nwFgtG7n797JGhy6L9aeXNypy6CX6U5
	s4lBCnqlJplRRXsKp
X-Google-Smtp-Source: AGHT+IGqXWgEabyAByCjIRB2NF7rK0U6Sarr7ZTc0iSTwNsAGyxmm1uJ7rzIH0GnCtZReoLi/YLCHg==
X-Received: by 2002:a17:903:41d2:b0:223:607c:1d99 with SMTP id d9443c01a7336-227805b73d3mr264042385ad.0.1742856705650;
        Mon, 24 Mar 2025 15:51:45 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4597csm77237325ad.75.2025.03.24.15.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:51:45 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:51:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, hch@infradead.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/for-next 0/3] Move splice_to_socket to net/socket.c
Message-ID: <Z-Hh_rUT1LgBbzZ8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
	hch@infradead.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
	open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <80835395-d43d-46de-8ed6-2cc5c2268b19@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80835395-d43d-46de-8ed6-2cc5c2268b19@kernel.dk>

On Mon, Mar 24, 2025 at 04:14:06PM -0600, Jens Axboe wrote:
> On 3/22/25 2:35 PM, Joe Damato wrote:
> > Greetings:
> > 
> > While reading through the splice and socket code I noticed that some
> > splice helpers (like sock_splice_read and sock_splice_eof) live in
> > net/socket.c, but splice_to_socket does not.
> > 
> > I am not sure if there is a reason for this, but it seems like moving
> > this code provides some advantages:
> >   - Eliminates the #ifdef CONFIG_NET from fs/splice.c
> >   - Keeps the socket related splice helpers together in net/socket.c
> >     where it seems (IMHO) more logical for them to live
> 
> Not sure I think this is a good idea. Always nice to get rid of some
> ifdefs, but the code really should be where it's mostly related to, and
> the socket splice helpers have very little to do with the networking
> code, it's mostly just pure splice code.

OK, if you prefer not to merge this I totally understand.

I am not aware of the history behind it all and I can definitely see
the argument for leaving it as is because the code might be more
"splice-related" than networking.

In which case: sorry for the noise.

