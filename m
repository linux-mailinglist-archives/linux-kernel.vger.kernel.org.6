Return-Path: <linux-kernel+bounces-349441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2898F657
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F291C20BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF71AB53A;
	Thu,  3 Oct 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XNhVgTjL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053851A705E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980791; cv=none; b=t5QNL3bBcBKchBoG0+z3k4c5Kwx8i5/emKZgfKIpYdxVcfzwMi1TIE5WhmY/K8TBU0aFM8MbaKHXVdrz63nxDQBddV00z1cdlRew8O+Rlwofgx7esKYc6epnTr+XvULRDsHe8l/FPOW8iKfYM2JSWA9OhgPHAXJUplYwIx7muGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980791; c=relaxed/simple;
	bh=DhOoRBLHjJo6iKb0pokJEyuf1Q43DOLSfMfmpPXYJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbiBhfuwSlhfcKj38oPTruqO3+CNZx76LQDMr7R6F0U9ftDXpqRFjYiic0dgUIV8Nwept9H3/+3hPz0GRuau2/1J7BPnxgzHF02w0wVOjJVYOG7Yq/GyvxUUv9xFRTUu20GgrNCB/5119zbilb2SZCguJsvjAATlh6B5Lf61Jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XNhVgTjL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b833f9b35so11718995ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727980789; x=1728585589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NOfF+iASIgN1enWQgY9wUU6upF2RxXXkbqZYau3r2Q=;
        b=XNhVgTjL/MD24AMoimalZIIxSyRbDfj8HXs5w8MVirHEh8EFO6wPMmctsXDYVzzaqF
         TPAkKml+5QcJGfw9Z+n9Ukvifv8Gu55uG5+0zIOd0pdFDWxQ4QMBdWA0LgNq8ki4Je6w
         5lLa65sGi6X26LzwfdjEcKYvzuvJDZmvESL4VvL+MUjduzfO3UsDOP5Xy56kas8aP5CG
         veiStkFRAK3/COF/xr1d3OVaoJw+G+6vRUxQgRPH86ywNEN1Lua4HjlJ1QcYTLdm4gPE
         ANin45X62pmbx0Lj9o+WsrxoFDVQj8kAAuzGWgd7gkq0Ua+KDv8kAL/tz2bboMI8VCVG
         xHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980789; x=1728585589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NOfF+iASIgN1enWQgY9wUU6upF2RxXXkbqZYau3r2Q=;
        b=ISYLSCvhv8E+P03w4ao4Re/mEUdxiTeD8lfoGzQCj1MiL12wg3KDTFHTwx64GiVSi4
         KFJpMLOjJuLZ/MYSjDOfNB4YSbU057I3u0llQ7UAQEcMlPRye2Pkbo0fPqyA11kSzRcZ
         TZ2I7Euc82LWp+Eeglt3okCsMelEsQbhRd52zZlYa6tLNjfFVcSD1fJQLIB795tsOz8I
         yAbsqBiyryqJ/np+m5nreroFAY4gtwREU5LZI/7ESFSI7n48HEtnKs3yXpJFAgyforug
         FymJ+q0wdqdpvs2By5e7RQxxYCrp3+6T4GUwI93FeANOka+fjW8Fg+hIbXjmav/k7lFf
         dStw==
X-Forwarded-Encrypted: i=1; AJvYcCVeDXMVtfJmpEG5LJPuZW7iKIMHwtSrCO4wV387TTQPNeeycUU2JKaCTXQLMzRUZZFDpXZxvzRyx2k2+D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8+wY5LX1KVyCAERQYAd/TgIn4uQIgi4IDyZEcTAnZL/tOOI0
	EHVAIwHgd9Y7chio6f365gk5zJ1Tk+GM2ssdKSmw0bEB1hvT/6mVfDnjQFrBkto=
X-Google-Smtp-Source: AGHT+IGIHsGZj7FRyxDSBw/wKYL5XsHu8ck09mUVeMUbnS/YK8RyE1dWDEsQDtAZooeWNUfv2dlAew==
X-Received: by 2002:a17:902:e881:b0:205:5dfe:7be with SMTP id d9443c01a7336-20bfdfeb5b4mr1953015ad.26.1727980789435;
        Thu, 03 Oct 2024 11:39:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2256sm12086035ad.91.2024.10.03.11.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 11:39:49 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:39:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org,
 James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
Message-ID: <20241003113947.6e605b8c@hermes.local>
In-Reply-To: <e5cb1a17-72e1-529c-0f46-404dcdb3e5f3@gmail.com>
References: <20241001193352.151102-1-yyyynoom@gmail.com>
	<CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
	<CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
	<CAAjsZQxEKLZd-fQdRiu68uX6Kg4opW4wsQRaLcKyfnQ+UyO+vw@mail.gmail.com>
	<CANn89i+hNfRjhvpRR+WXqD72ko4_-N+Tj3CqmJTBGyi3SpQ+Og@mail.gmail.com>
	<CAAjsZQxkH8nmHchtFFPm5VouLEaViR5HTRCCnrP0d9jSF2pGAQ@mail.gmail.com>
	<e5cb1a17-72e1-529c-0f46-404dcdb3e5f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 17:11:26 +0100
Edward Cree <ecree.xilinx@gmail.com> wrote:

> On 03/10/2024 16:33, Moon Yeounsu wrote:
> > On 03/10/2024 15:19, Eric Dumazet wrote:  
> >> It also does not know about conditional locking, it is quite useless.  
> > So... What do you think about who wants to send the patch to silence
> > the Sparse's warning message, nevertheless?  

In my experience, conditional locking is often a cause of bugs.

