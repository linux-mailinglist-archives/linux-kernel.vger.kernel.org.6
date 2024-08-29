Return-Path: <linux-kernel+bounces-306773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0298F96435F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9427EB28113
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF331922E1;
	Thu, 29 Aug 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRmL0zuq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8A1917FB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931807; cv=none; b=EmW5s+G7mVq4AoYpW91Nykl/a1qus7vbOi1PvW8YFZpbh4WY5F+yUd48ffCl0wcn4WqHhDhXE3teXNBwHrRhnWKNdTdoQa16UYVsFOVVBaedS1qAuv7kJNjg/VEI/xEcWnjZxFXBTnc7HQdgXMxY9uIvv86CAr7q3bP1CFH3zqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931807; c=relaxed/simple;
	bh=s63R0yEtD2lzGTkJnFSMLaCXpECL6SDh0c4ddUidQTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQEtCFPz3olrXKyoT2kgehnAxqD098TmlzdvY7fyVdHzog7iSvMoNo9j0t2ZhzTYKjO/dSBrg/+BAEmGJ5JWCE+r9OMhKwdS44iyO5vNXRZoa5VA1prumVUWV60MEdG9T761lvTtIIavyJHKLEV+6CqsqjuljJNzjJOLNEOsDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRmL0zuq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3719f0758c6so371827f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724931804; x=1725536604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKJ044DJ6shbS65781+Yi0H+JjJTteS86fL5N3lWl+k=;
        b=eRmL0zuqvqHE+6jMMd7XaqHcHpUy8Tzta7cK/n9wTu89h8Iv+UJNiyxHrxIMC0tWHJ
         NAyGlOcTtPVfa+y9TPHuwKs/UgWv1yy6BGsmk9nvNRXJ20y68d/Yzs3uKTX5i9qw3ZeY
         W1kkiYWQ1y5MhJqEie4mYsrVL8fmEcncDVSz8fAG2r1drVqhzErHIUhPBaQRNOh16qFO
         aXW1fg/ZreFXtphrQYiOKbf8J/n6BdjGNEdkvijn9A9sUCLpkt4mFGiGt3krBpyyH5jk
         a9JDl3scMa0wy75PPo0PdLSZHKR66MXd8vBZQwlvApcJImHHinfLpwsO7zoQ6RHlexFv
         cpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931804; x=1725536604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKJ044DJ6shbS65781+Yi0H+JjJTteS86fL5N3lWl+k=;
        b=dRh4gU4wJ6PoL07jibxCYU9tPTB3seafK1Ba/ZBkrcZU0DS7DhhZngMjLpRks8IDZ+
         YKwJ/ZpEULPBKtlZ7U0evaTv6IxJDxBg7d6JRT/AMJycXLCWge0DgVtY15M7O+6H1Q83
         T5gci7uJjG4vJKUFVGmG5IJHRbiJ1gQIDx05urlgWer1FKTJWwrJKZjLT/7qTXgrh+zS
         BOeYaCFKzGizvRfER2rAo68h72VcUPFqW/LrABXay1h8n1a68wry3pGl7cogGG3QucfG
         i3ja4Wuc5UDeIEV0SdD7/eEg7xo9E7XcoVFat4DcQInZcFRDhquxV6mygoNT03qcF/Rm
         K72Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc7+k1fRC671OoyhT0Au8hReIVt59gIXk2C+tmUmhfrptrut3PZaGPirY5rjSELTkWnRUvox3cVFkjMrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxst3nbigxDLzLvbWUk0fmzJR6mP9Pxon/QFAP8R1Z3tKSEN0s7
	GNU//dD4KXja5+ucD1A4o7LBAVDWm7cNuvdTUlVIHakbCkb8z5yw+YUn4oE9FRA=
X-Google-Smtp-Source: AGHT+IFOdw9ujiuwiSBHFU9+4OjvZIDBUCRu48fmW/IwaVfF6faEydvSR/mrTCHm1bmjK7UKGK5Yfw==
X-Received: by 2002:adf:e508:0:b0:368:7a04:7f5b with SMTP id ffacd0b85a97d-3749b581bd6mr1613589f8f.40.1724931803624;
        Thu, 29 Aug 2024 04:43:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee7171esm1202801f8f.37.2024.08.29.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:43:23 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:43:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alien Wesley <alienwesley51@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in
 rtl_wx.c:681
Message-ID: <9c1dc3e4-18fa-4a09-9be9-f0f3c9b4fb43@stanley.mountain>
References: <20240825161335.21737-1-alienwesley51@gmail.com>
 <2024082916-savings-upstage-9606@gregkh>
 <8c1960d3-8f0b-4505-99aa-8af55685bbb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1960d3-8f0b-4505-99aa-8af55685bbb3@gmail.com>

On Thu, Aug 29, 2024 at 08:33:41AM -0300, Alien Wesley wrote:
> On 8/29/24 06:52, Greg KH wrote:
> > On Sun, Aug 25, 2024 at 01:13:35PM -0300, Alien Wesley wrote:
> > > Separated assignments for pairwise_key_type and group_key_type
> > > in order to silence the following checkpatch warning.
> > > 
> > > CHECK: Assignment operator '=' should be on the previous line.
> > > 
> > > Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> > Please do not put line numbers in the subject line.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Should I fix up the subject and resend it as v2?

Yes.

regards,
dan carpenter


