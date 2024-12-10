Return-Path: <linux-kernel+bounces-439935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7849EB663
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CDA2821FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777F1BD9D3;
	Tue, 10 Dec 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hf66nXEd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A023DEAD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848130; cv=none; b=pGoQmGFsHr/79I9YplQR41dEXPICCuPr62lBRNDLDSUQK/IobzNVYTRaHqYAZGEcAQtJGKoCY5u4vI7XrYUV+HEA7M0bp+umaSjKfvO3e6Qq1OAOJ2dt3DUOduyw3LfVvtrT3sAxRrjRQsWzwEzCKtMhpJQntPucopIt7TIY9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848130; c=relaxed/simple;
	bh=L8zZS+5vpYxW5QotLbpQWWWL3HA8cKGK24qRz6jBPBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDUjs6aXVNIer1QHSfXCbm2Qdop/GrVrq6c9gVGXpkRLyLndsrPZZ/yd2hPWcC5T5k96IoOyKGDrbtk/71SRXKE3GjrXJTEN8+9a1TKbBe3qgW3MONVNYLWUP6v3JZ3EOUVuf6M3q1oqA1LKhv+sw5iliCHJWKVu2SQva1Hhwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hf66nXEd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21675fd60feso10937245ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733848129; x=1734452929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj4MHdnpYsp681nq+qrKAbIFA8R/Y7sxbnd8+ouUZPs=;
        b=hf66nXEd/Jcz+r6C+YJWjGWiPoooFgvLyS2fuXgbyllAdotF828LhTavSiacbv+4Hn
         yCYwdwJ1I2YcAETkD6GxcXBlMtAW2Zlw7fbOps+DfeqD8Aqb9zyO023/O0cqPjnmu2Dr
         H0gidyX5yFL3g0GD1eJqBPrNFeTZEHF3h0g7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848129; x=1734452929;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mj4MHdnpYsp681nq+qrKAbIFA8R/Y7sxbnd8+ouUZPs=;
        b=lEJwZMzwJ24VnmN7QOK/i2v8xC5/6RwASx5TzyxETPEVF5A30PaswEwp8LxNUd+Ggu
         5oI3BsblAxizD7P9nGHDX8W0b0d+/1BzkyQazQ9xL8BeRSkuK5WA8h7c/vzpTrLcbKcg
         hoPtGSFSadZLPNyRhtPyW8n6neYJZf2XN9jo/16B56D3Pma14q84zL4d9u0SnPgK0Dli
         nZ1crEdZbYKMOmjRaEFe4/0g6fHLhMGDbBpNqsXBWbfwz+PiEStRwvfyjBQsKKv0dMsM
         jQ57qNQVGAnzN2X/bJc9evq7hp+PeGumirwFK3AaAmTvpEnDWXclW8j/ZnR8af5abU8A
         Hd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlxkLstP+N4MuXndXGtbyEqx07BniY1F4I/zg2btOy+l0INrYNPBNs6BaxZXj5ZdAMEE5cMLsKUUzXJFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kdvZ9G/6iUuTMMSilbgDx7nxHd/K+ji2WIBXe1wd8TNE80e2
	kfPec8ayDst350VkIS126R+D6oTmDp1S31XfWXQ//vmdOrpDmUJgSunZmg8B1Rc=
X-Gm-Gg: ASbGncskicHSsewdAF6Q11PXV1ziS64LWm8AV/OxsiSFcLy/q+VLCEmsnsNUUl+0qWd
	U7bpWoNiUvUE2BrN0sl8RjhoCbBS2KdZrBl5Kq34bZ6WWF4VcIE3AZ5k/80q7pRyKyA6m+y8k05
	bhWH1LijiisXfkoMJYIK7mW94sW5UWQwNggBbDlwVC6XbFqBg1NlzDL09EcVcxQDRQw4nLEY3QJ
	TS/1nBsA/maG/X/Ok8ENGFxlGQyYG8lnDsymb7aphGbRchPE2V4F7QOxdTeQGRjYX7HbcixOQOT
	kr7aUIo4bw3LpVZ3t06w
X-Google-Smtp-Source: AGHT+IEtgwyNJx3QaHHEzPTwoCjXsg8GMUEN+CgmtihyPC+PN4MzAUpVMRw/PLiYKbMt3qlJgKKa+w==
X-Received: by 2002:a17:902:c412:b0:216:725c:a12c with SMTP id d9443c01a7336-216725ca3bfmr41703775ad.9.1733848128663;
        Tue, 10 Dec 2024 08:28:48 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21632b2b26csm55443055ad.98.2024.12.10.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:28:48 -0800 (PST)
Date: Tue, 10 Dec 2024 08:28:45 -0800
From: Joe Damato <jdamato@fastly.com>
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@aculab.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z1hsPdG3ITuDlWnT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Frederik Deweerdt <deweerdt.lkml@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@aculab.com,
	stable@vger.kernel.org
References: <Z1fMaHkRf8cfubuE@xiberoa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>

On Mon, Dec 09, 2024 at 09:06:48PM -0800, Frederik Deweerdt wrote:
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
> 
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
> 
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> ---
>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Joe Damato <jdamato@fastly.com>

