Return-Path: <linux-kernel+bounces-259403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1F93955D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E021F221E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89869381AF;
	Mon, 22 Jul 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K18hSOpP"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F071CD37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683302; cv=none; b=EQQDnLYgfq6JvzgvUW5v4fWCduWhRDFxXW+uz/rxg6E0/fJ/EktyYPwj5YYI0ZMKIMEd7qoHWaP52B60EwoXF2q49L8lELVskT0Ni7XzjKs+F5Cy1tII7L85DDJhsDUfhJHhI/gJS1u86iEY97phqWX+J7NYDWKVTrko8tk7H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683302; c=relaxed/simple;
	bh=0lpQd8qI5204hNQEXIF/V5SDukSCRny4FbkhxxRFDVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwXHuWRgUrtd5PDqrGTGTKbVSB568cU9uCx9dPC6BJetW3LhOBBqMKm8KHY106sx2Wr4/kxlmOV4AobsdQYGGcshpOCWxbhHSEZdZ/VzTiXiy48ReybZtONPJGYXdbqEbKdhFbvkKirxNm7ZHniEIVgQTEj1CjSCn5X3ULR5mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K18hSOpP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6510c0c8e29so46284157b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721683300; x=1722288100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqSoKvFiBiJxHeJhy5s7HFegZkcCFesRNlWHvZMNH1I=;
        b=K18hSOpPpilKps67RNy/YQSmjDRLNt/kidfgh8aKZMKCo2+eEsY0/GamQjvE1ludr6
         0VItPjOkZDTaZT2rSz5+zRca+hxVlZ4Yn3HKZErLHJThnwZlzzCGyKkMxOsxcY1VJ11K
         /arr656jSNum90DKferAWu0J3RCUbuVHNz9dqCq+CLTlSq55MuL161neohOvH5d9SEJD
         lQMV8GhEMSXUC+bvSVT2kXbgnaayyByTR3h+MuVU0SEe0o4LIrYB/TvX/zUrRUMuqfMn
         mMW2x6MAUJTbCux3h7K4L+pqE/iXlVYUAOVck7HPVvhAuY96vUJIC6YaLSrGZ6px03en
         Zuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683300; x=1722288100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqSoKvFiBiJxHeJhy5s7HFegZkcCFesRNlWHvZMNH1I=;
        b=COtIO6+0kwt+mryAPgTny67ssVZKaHcJk15OIBhmaJnEnxS6QaBNLW/mMfVzhB1R7i
         9KPGU2/Xj4BwHdF9VH5+0JH9tgYGjqM4c4rl1WGCaF68wFcumADrl2ygrPSNxqP9XFsO
         TwPWaQaHMQR4wmfzqvWC0UZSClnz9qCjJ6Lnlv11KwS+qhfR3jv458UdQTdCSDPrDuPM
         Mx7gRJsgEAgZaRZLtkva0K8drrOAIdB7fiqSMw1xHpze7ViujTXwrdbEFCygeSiSDqO/
         mPOEdaA5l5nPXJDFjBaIbrkmWN9/ROQhqyCU7r+TP3ZM4BR9nVZfTwXgn+O4rKtq149Z
         EkCg==
X-Forwarded-Encrypted: i=1; AJvYcCWCvfi+3ts93M1FinDYPw4krsdH2ioMW6RPr6hwXUe/uI641j7TocjPLOcXKRNHdN2ZxPV7LUkQPEjnJpnz+y/YciJmbsVPkrMpQ1GQ
X-Gm-Message-State: AOJu0YwvH1cjjsc/gzekjz1gHpJwREcuLulECYC611FFx45LsoVE2j0F
	zBFm20mRIae20N5paako3OjLMkw9Urf706bEbRVnRN9HGtXTFBgflveXD0JnIOU=
X-Google-Smtp-Source: AGHT+IGUW01TO929BIzL3yzqV8bnWCQFvaquNG1dCHNmvJwdldWO0GlecujW79LoSol4O0vtRMmUzw==
X-Received: by 2002:a05:690c:660f:b0:644:ffb2:5b19 with SMTP id 00721157ae682-66e4b7ecf18mr14047497b3.9.1721683300197;
        Mon, 22 Jul 2024 14:21:40 -0700 (PDT)
Received: from devbig133.nha1.facebook.com (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66953ae08adsm17874337b3.98.2024.07.22.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:21:39 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:21:38 -0700
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jerome Glisse <jglisse@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and
 migrate_pages()
Message-ID: <Zp7NYoBGrwTnJtrc@devbig133.nha1.facebook.com>
References: <20240720173543.897972-1-jglisse@google.com>
 <Zpv6KNYjZcBuQfEk@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpv6KNYjZcBuQfEk@casper.infradead.org>

On Sat, Jul 20, 2024 at 06:55:52PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 20, 2024 at 10:35:43AM -0700, Jerome Glisse wrote:
> > You can tested with any of the three program below:
> 
> Do we really need three programs in the commit message, for a total of
> 287 lines for a one-line change?

Better yet - why not a ktest / LTP contribution?

~Gregory

