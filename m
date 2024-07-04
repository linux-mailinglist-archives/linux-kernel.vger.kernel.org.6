Return-Path: <linux-kernel+bounces-241588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E181927CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B71C22500
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BC773476;
	Thu,  4 Jul 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIWnlJzG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916249659
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117009; cv=none; b=Y45NOM6fBTpMVKK3KGjREy3rpSlx0WyTHDFIUsTAM1lJ2htMv7vLTQC/fKSpEzKSoRkPsckQrI1qMAyIBNMLX4kWXqqqb4C327BvWVGzW+jqJhjLx+dc/IKpvu8JSNs9ylvSruW8bxU3ws4SxCMRwOltNmxXc9KA9cwij5tkGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117009; c=relaxed/simple;
	bh=K1T6ZawzBlBnfgQGA6b/NDi26XjCQM/zwcbsfUJHPo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrJDkPONp3canXqXrylVJqqQMwcW3MIoogrW6Ea2f1IHBOgZnumxcXrea9vUON2V82R8A+RNwHPj0ro6TIIhHtLkKFdHM/cvqGjyugKz5C73XN3mwrjIpDevLRnf8L7QxBTdkbA8Io0UGzQFVkImvJn95ymw/rdIr5AgKyeYNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIWnlJzG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720117006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/tL4EMiXTDJKBrPbp1fE5+l3HieNY6sEKsGtIXGNJU=;
	b=KIWnlJzGcXpiwe74WKNP6XHOcxrK+dfl2V2rC/Ypd0IEcjzwzk4sExNgU4/r/CIYbhCLtO
	mcE1xNONty+cdM180JZerLevMcUvX8EWdw80vfUCElHGgiUbZzQ5BxMYerUW3LzjQwn7XL
	6CZlWr7J0T+epHrkFnLdjfsPNmv17jo=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-qzt0tcpkNDecvsuJ0ZLOTw-1; Thu, 04 Jul 2024 14:16:45 -0400
X-MC-Unique: qzt0tcpkNDecvsuJ0ZLOTw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-48a33435f58so523750137.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720117005; x=1720721805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/tL4EMiXTDJKBrPbp1fE5+l3HieNY6sEKsGtIXGNJU=;
        b=ILcFPQoLZRvNUqNF3rV3zZx+zLaE9kYykBOQVma06k1bnKETv/3ObBKhNjblOUUGKx
         7Am3RmKybNIjjPkLiluXw1mIcMQs/QYYLwjvLgNjWmES3L3xPPrglck+Q1H+v0HMChYG
         I4id1v+xzLUJqLb3qHGjG6E9bYZyv9RcNgdDvRnVYOTP1V3R3atd8aSIq2WH/nS+UMue
         yl4jdadn4Sy9yERPDmM5tRQ89X8tTdKg0W/WIOKPgh2junRGpCnbigsjTKNOblBg6FBw
         ekvYfwhPom7DzB43ktyBhSz3JghK99PzUZJMHOWQjtli9MQJVBokc4kwS2Xft036ODby
         B4mw==
X-Forwarded-Encrypted: i=1; AJvYcCXG2khhXkJE+Tb2gyZVn5w6YW6S2/6qxLsBuhhAAoHDI3QjO1GHiw4b6MoRyplFbhjH1LDjvjMse6P0npBFlzcEw26TAzJY6mZqPvKe
X-Gm-Message-State: AOJu0YzCrh2AwOk8GTRviHADRAn+EwElOHAq6ygSUo8dZ/iXe+O9iBFh
	9O3/e+tqXRbPQkrLQh6o6g+u8LGwcWrec7CKF0eh++TKp70gF+SzcStfnnd5qTN+oFV7nfP6A70
	ZRqKFe79/HEnZD9SelKXaOg4IZ+yrdcPFQUnO23JekNwVbvQooBpjvSAqipx8LQ==
X-Received: by 2002:a67:ff14:0:b0:48f:90f8:efda with SMTP id ada2fe7eead31-48fee91a190mr2269673137.32.1720117005057;
        Thu, 04 Jul 2024 11:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwugEbb61NqUslFCARGx4L7HhqAn7ddwElVnvoUUZKyi49wHMTutsymkPb2xLcooJsvWfxgQ==
X-Received: by 2002:a67:ff14:0:b0:48f:90f8:efda with SMTP id ada2fe7eead31-48fee91a190mr2269653137.32.1720117004755;
        Thu, 04 Jul 2024 11:16:44 -0700 (PDT)
Received: from optiplex-fbsd (c-174-169-122-120.hsd1.nh.comcast.net. [174.169.122.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514cdd81sm61539511cf.97.2024.07.04.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:16:44 -0700 (PDT)
Date: Thu, 4 Jul 2024 14:16:41 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 2/2] kbuild: rpm-pkg: introduce a simple changelog section
 for kernel.spec
Message-ID: <ZobnCTZl0qWL93YY@optiplex-fbsd>
References: <CAK7LNATxSePzOrHaQvS1MQo4mpAwdfwrDu3iuUsYZ+RL=LiirA@mail.gmail.com>
 <20240611211123.959459-3-aquini@redhat.com>
 <CAK7LNAQba5CDetpwevSoaOLJ21s1tO9ZHh=7gJpPCNK0AnHfJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQba5CDetpwevSoaOLJ21s1tO9ZHh=7gJpPCNK0AnHfJw@mail.gmail.com>

On Fri, Jul 05, 2024 at 12:52:41AM +0900, Masahiro Yamada wrote:
[...]
> Using 'git config' is OK, but git is optional for 'make binrpm-pkg'.
>
> So, you need to add fallback defaults in case git is not available.
> (this code is available in scripts/package/mkdebian)
>
Alright, that's a fair point. I was originally under the impression 
that check-git would always run on Makefile.package target calls, 
but I see where/why I was mistaken, now. 
I'll get it done in scripts/package/mkspec, as suggested. 

Thank you!
-- Rafael


