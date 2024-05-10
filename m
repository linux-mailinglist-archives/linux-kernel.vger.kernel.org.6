Return-Path: <linux-kernel+bounces-175278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352508C1D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F0283A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727614EC57;
	Fri, 10 May 2024 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/GsW2st"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA09148FF2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715316236; cv=none; b=HX6GJQKHwh/bNL3YnrLjAIPLcMh56TFCV5qUJ8Ap+Ue0+jjXfj7u554+OLURV0pAvoqJWlPYjK5PtI0ynnpjGIx3OezwcVIHu42Z6K3smRVrDM5L1keUV3u/j6NLGwJlcZrZTa9J62rIuO6eMvm13gfg9X+4xQnb2XFrWRrcvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715316236; c=relaxed/simple;
	bh=z4P8poNID1QixqleCdlEz4j1Zi5VUgmbCvuKBT0R4ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqBsdTJHDR2Jzgrdc4mGIoxi+P7qq8o0UjkTXckcZ5GC2qkqvosfgzWbX0Jv8vRAjkp7kDhuZzxIrSgSU3f1b+Zj5Aly7G03a2PILGcVwOeafjX4ynErO0VO3TyWJGlJk0gjVnrasksonuc45U4tLzc7WpKyXn3r6o3P5ArgcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B/GsW2st; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44390e328so1539268b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715316233; x=1715921033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu3HPM/W0RS8LZ8fQfn9wykBlJaEHYXothWbxQj42GI=;
        b=B/GsW2stMrB5N8Rh9Ja/zp9UC2rx8TSiNRsOpZSXnRJrAs3wVljGzjFQUTkbd7MDpH
         6BqbQ+GF7EUFbvMP0TN35IkKxqWZb3z/a53tK+B3xWBbRuXlyjUHeU89CxA/uy3sU17i
         XtARgMI9FDhJ5k2nWj1LKxWL9wsP9BMxAcZBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715316233; x=1715921033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu3HPM/W0RS8LZ8fQfn9wykBlJaEHYXothWbxQj42GI=;
        b=vCZQs/pKQyAb/ABJO2hd/vCfsomYkJr/yl+xCj7LiXRZIqeWq9PkjhEneI1fNE2pzu
         qsiXnsTphfGgftpPDUyHJJj8ixwQzg/L9GYtjwLHJvtUASZODWFnozdQswRtFYRW3HAx
         wHkttjZODywpnLSPqk2CyBVy9AcDrSh4mAIpzKtKQzGH/mzzdd4WyHQz3fTfaycWAGTG
         wJEBcGpmE3vnpMaBdk1HPxCJ0wlC/XLb9AunRCmEUS5pVKC0RsHjMZDZcgPS9oJqUjzn
         txKOIXcIuXFNk/WKH4eQaO+O1ZtjympSOHFCt5Z7o9VWvy3qfa1Bkedc7UlOjwZ39Zqx
         zedQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoUqvkki7djly2cqwE5oqkWamyQBLZEshL7sgif4AanRipljokWE7blBC3bp3esf1cbGP096v/9bSubxKERKlYH3pOc+PT5odwhFSF
X-Gm-Message-State: AOJu0YzgiWCMp2eZ76TI8u95imFlsF6o+tf+e3qDfZTZbSD0BIp9C8Xu
	bmvvn9mzOIEj120GrbABJxC4Ase3G+6FJTJ/Czokbc9I/Y8Oz80Z4Ja/+5ORuw==
X-Google-Smtp-Source: AGHT+IG9paMfNeMGyt7l4SrK42bMcIO2btSx/oYAt/Ksr7aEaKMP5XAI4AxSZ0vspBbwncjhvS+E4w==
X-Received: by 2002:a05:6a21:81af:b0:1ad:999b:de34 with SMTP id adf61e73a8af0-1afde197857mr2011928637.38.1715316233419;
        Thu, 09 May 2024 21:43:53 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5109sm4192104a91.38.2024.05.09.21.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:43:52 -0700 (PDT)
Date: Fri, 10 May 2024 13:43:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3 08/19] zram: add 842 compression backend support
Message-ID: <20240510044349.GH8623@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <20240508074223.652784-9-senozhatsky@chromium.org>
 <ZjzEnbHGO_hYQN11@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzEnbHGO_hYQN11@infradead.org>

On (24/05/09 05:42), Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 04:42:01PM +0900, Sergey Senozhatsky wrote:
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Not a very useful commit message, made worse by the magic '842'
> name.  How is anyone stumbling over git-blame or looking at git
> logs supposed to make sense of this?

I can probably add something to the commit message:

	This adds s/w 842 compression support

Not sure if that's significantly more informative, but maybe.

