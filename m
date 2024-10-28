Return-Path: <linux-kernel+bounces-385490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C869B37C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CA1C214C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221E1DF745;
	Mon, 28 Oct 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx9xPNZ6"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEA1DF276
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137088; cv=none; b=U9jhuV5q8U/qb7/jZjY+j+PzEbxH+/MplSC7agWWyGv7eTjU2duIOzQnHbUfMxXNH+S0e2LPX3tG0VTorQcQTno5wLYd5ldmkuZ8ZpHdQBD70SUliBUNvg+pDagBoUG+IyKoi6BpDUuc5rkiZc6QJarhBzKCxImzDCWYSIruaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137088; c=relaxed/simple;
	bh=QW1SyG2ix8by2v3hNzLlUF86S37l6N+ffXJoRpiyZFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMjONbVhwLL4N+aoAvRhVaR+lWINmXOE60VZzePGX/7+lRx3COSo5JChmIjJ3xYYN7L82Rvc7ZYQz1oMT8pulIiiTSfdpsannZ8KKPgIRPto1xDbs4inG2Y4TNbWdUwRvJ+Rq2Wup2JWGSF+Rh/pNujlBRk8I7vR1fXjr5tSjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx9xPNZ6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbe90c7c95so34870846d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730137085; x=1730741885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sk2ia99hGmQg8Q8TlCIMrxoTE3W8eoeS+30VC7vlqc=;
        b=fx9xPNZ6QCWv4ICyZJoUFkNCGydhf3pl4Qb3HGbS2rUhM14RpPVeLpkFLpXLtVcnSI
         oU6G/FBvUL+U5xrK42hG0Bm62PqXzB59AWV6nHmjEApxzsJHBXBCIG5pClUXBa3EYIk/
         sAm3EgrQy/kODSEnO8tDMF3VQjVRpyOCE1GdeLx3d48XVvKaWeKS7qcoBI+coI6w2a2d
         ArI/RUzOzHugYLYegIuokCM/BpWDhrr09ZaD7D5fgmamjjfZYtyAsQFpazx7i3mCMrvu
         V+TQ9ovgHG4N5UDe5YPvYuVxm361WjQc2ttkKowm1xGo4W4qDfxSdPUti0/CM8zjVVgc
         A3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137085; x=1730741885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sk2ia99hGmQg8Q8TlCIMrxoTE3W8eoeS+30VC7vlqc=;
        b=BDw6D0b/d8RsWh1fy83Iv2isNQJNtiXKF7GWKKzvLSpZhnMQW4XzwI+WbAxNDXrTww
         HqwjB5PPsa9jwdSZdisQRFedt4K8o6LS96FI+s3fBikuGMcq0dc35g+fRVcLFS0HxBq3
         fCv8ZjV4ASJASU/f5GxCMqI+8t1ZtigNsb64f5afP97JFCTY5GlpYHr997MbbGeQCc1d
         jdDtmC0rTQX4KZ161saWG6VaKx0bkfP3ffP63tCWH246FRv65MulAEkCUULlsG9i6+rN
         bkiwuu4ClpDsSojqDtg7NKt2omCKoobT8EtIfN+Bdf2YMVB97Buj3okS4NzsRkCBnHKi
         VyHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+jsze+tyFwePVhrT7hgP863VRhjzF6+rPbWtANxtQv4S4xJVA2S6Kg8LprLzlpHEd8NFOx0uv7/wSuzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2SlCD7/wriCwj7ySHd2QB6FjJ9ADYNU/ATXtjlqWE9U5CILK
	KGgiMksyg3up/Icqg6lL+Dem/TdPDsKCpgfjF+fhxsoDom0cQ2WE
X-Google-Smtp-Source: AGHT+IE4c+RpWU4Hlk0VIwuVZrGnO8t/azEa0vyyl3qEwdubWM7PkzQrerStQ+H9ukAxxx7w0uo9Jw==
X-Received: by 2002:a05:6214:540f:b0:6cb:ecb1:e6c1 with SMTP id 6a1803df08f44-6d1856c3ce0mr134351636d6.17.1730137085251;
        Mon, 28 Oct 2024 10:38:05 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17973e182sm34537866d6.19.2024.10.28.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:38:04 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66A0B1200069;
	Mon, 28 Oct 2024 13:38:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Oct 2024 13:38:04 -0400
X-ME-Sender: <xms:_MsfZwSx9VuTe3coPqM27C2jAtY8wVliyQcdfk6rBEbIeK4BI2gEbA>
    <xme:_MsfZ9wSTNTVGMkZU3-_vxe2qtB8qLKg_8mCFfJGST0aE5VJNtXfICG9pvVXTpl3n
    -kdMUeKGsS7kL58tQ>
X-ME-Received: <xmr:_MsfZ90Hht_Kngr7EaI7n-4W_6w7DGdOXLtGB2Ys4x1rEI_Dp-l8BnfMEd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hthhhorhhsthgvnhdrsghluhhmsehtohgslhhugidrtghomhdprhgtphhtthhopehpvght
    vghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhh
    grthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirghpvghn
    ghdrtghhohhngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopegsoh
    hquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_MsfZ0BTwcE_07B7gvEXp9ColMdPCuTu5rYKQqEDXAvrxACjIZjnsw>
    <xmx:_MsfZ5i2X6ue6oq-U1rU1iju6CWqcGg5dHgJIt06g1EKuIQAi6vxxw>
    <xmx:_MsfZwrr05rc7njj3JDldGKTt8ZwFkRJEaWsM2E5c8RrUaIQ_4XjJw>
    <xmx:_MsfZ8igOx2cX6uy1ALG2ixJn1s78ykmShF5kEePq7dF35mvudDlDQ>
    <xmx:_MsfZwTy57X6XDO6yFHHpE_tTpADg8Nz9Y3iLaHHyF9u2ncNoGnVCyAN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 13:38:03 -0400 (EDT)
Date: Mon, 28 Oct 2024 10:38:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [RESEND PATCH] locking/ww_mutex/test: Use swap() macro
Message-ID: <Zx_L-jcRKFPBVukg@Boquns-Mac-mini.local>
References: <20240731135850.81018-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731135850.81018-2-thorsten.blum@toblux.com>

On Wed, Jul 31, 2024 at 03:58:51PM +0200, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
> 
>   WARNING opportunity for swap()
> 
> Compile-tested only.
> 
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Queued into lockdep-for-tip, with additional tags from:

	https://lore.kernel.org/r/20241025081455.55089-1-jiapeng.chong@linux.alibaba.com

Thanks!

Regards,
Boqun

> ---
>  kernel/locking/test-ww_mutex.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 78719e1ef1b1..252bef786aef 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -402,7 +402,7 @@ static inline u32 prandom_u32_below(u32 ceil)
>  static int *get_random_order(int count)
>  {
>  	int *order;
> -	int n, r, tmp;
> +	int n, r;
>  
>  	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
>  	if (!order)
> @@ -413,11 +413,8 @@ static int *get_random_order(int count)
>  
>  	for (n = count - 1; n > 1; n--) {
>  		r = prandom_u32_below(n + 1);
> -		if (r != n) {
> -			tmp = order[n];
> -			order[n] = order[r];
> -			order[r] = tmp;
> -		}
> +		if (r != n)
> +			swap(order[n], order[r]);
>  	}
>  
>  	return order;
> -- 
> 2.45.2
> 

