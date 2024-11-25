Return-Path: <linux-kernel+bounces-421424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E29D8B19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A187128AE82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE71B6D18;
	Mon, 25 Nov 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsAmEwPf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388F1B4F02
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554817; cv=none; b=ifUkzcGYBgKmTuOyCxPRE6JphfybV6LsH0yhWENET+bFm8MsbDhlYfhdHfSVGKtVWEFdV65W/7v87bVBz90e7169jIJBMkgQqFbJJjPJGPc74OlR9/7/O0lnJjepHnxaKgHhcxu2oLIEJkvXD/8O/ekD11fh9eodokxqljGhHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554817; c=relaxed/simple;
	bh=kKsQpij4jZI2KVIjzLMycUY/7rp7CVKdYWqXVcfjWlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn4DMMqZRPTlKTZublbACPUAQI7tdnpd0MkQvEerpKz5XAuSWwxSZN2821CBd7pzswwLDI1Y9iBYm11zVCC6tV2kd9OZyxF/krmc8Ffk42pcoaK5dvJJ2Xo21+TD49j2xr1LVMB7xVCNpkSkvtVIFLH8SGNgLEeZ2vZ99JXLW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsAmEwPf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732554815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEb6gaWCrzE/Irjhm5GCFZNnja0bRlV2q230f84ZaX0=;
	b=bsAmEwPf1CmnknhoBBg5gIlfZNrdYCjmG+Etdaln1YJjg8++lgg4+ajzD7O8y2f5gSeEaZ
	vFY4A0WoWPvHzfaCssGkSzy/BR96Cwb80O8BgcdeW2+fn1n4TU3cfpok7bd6fdW5RsfaYj
	OAGM28H+vVd84jpQfkJ4shD8rQChsIM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-Z4drDW4TPKOfrhp-_fsGYA-1; Mon, 25 Nov 2024 12:13:32 -0500
X-MC-Unique: Z4drDW4TPKOfrhp-_fsGYA-1
X-Mimecast-MFC-AGG-ID: Z4drDW4TPKOfrhp-_fsGYA
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841a4a82311so82705739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554812; x=1733159612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEb6gaWCrzE/Irjhm5GCFZNnja0bRlV2q230f84ZaX0=;
        b=qDPLEj64Z4qBTcmIjOETJk9esp9ViCTEIoZjcQaYvu2sSHA0RTcvY/Bm6SdTMvaxaD
         tb3P2bcCARG3ZZjSMw2PcTIP/lE67cPewY0Ls8OFrE2A/gFUzmkOtnowkzsi0k31CukE
         biuBzcOZcgBjWnYfBXEolwGY+WUFfowOJkn7QNebrbViCp5LqPOEBSdimxZYdF2TJp0r
         Ijn1aX59MrXgNRmNZSg8dN7YczJuK6E38pBbzcqjtQeo7GyTaL9TyzTtKAsfFiaZ9URG
         81Hixf24DoFe5IzEamoUoTz0ASIdWfN0UZherVOs3uZiZjFhoVuuFBnTR+t9+3LWVkgt
         KmRQ==
X-Gm-Message-State: AOJu0YyZVDyX3mnP26Zuiw1DqoAmx8fKyV/jW/CvP9neqIdGyAsBAHbm
	fwymH1fJf7zsFVX7Hup1+U6FFN9AQVPUV0LgEZo/64orFHDaPxXySRZnVj9Dd2l9NFzfnd9b+iX
	R4tTuZ76p4kg4XSNL9h7yLws32L5T4khFdwPqRCslOugJoEDiEBAYhHK41QUIzw==
X-Gm-Gg: ASbGnctWeqbjRLsTM0EZRWMLJ3k0IAkrp1QzRh2I4Q45kbjDBfxsUj1unL97upiXnT/
	GMQvAxeNhKdVc+/5yaCcVpAu815BfU8UAtaK30arFYAnD1sFVGQBwfq53IioYCr5ntDEWFHqTKl
	bJVerQ6yXz0q61py21Jec66FxNCJPQKNcMcNnDOelWcXZ5ZwQObOf4dG2N7ImZxBX19/B5L/hnW
	zqaBz07JfXR6WJJ+hc7aN9Eq1HuhRrsMjot41n+K9AX/Zf4j9upoeJ2CHcy39VmXVguXzB7Q1PN
	BJlmZsCl1QY=
X-Received: by 2002:a05:6602:15cc:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83ecdd15ec7mr1518615139f.12.1732554811944;
        Mon, 25 Nov 2024 09:13:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Oyjuo8C/kxBFAqIWRUearFI+rpWvOHYS4KNZ+Gu6kNqbbyz4pDVBFMuTvNt/uRuWkKllcw==
X-Received: by 2002:a05:6602:15cc:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83ecdd15ec7mr1518611739f.12.1732554811574;
        Mon, 25 Nov 2024 09:13:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ecd14208fsm181305139f.10.2024.11.25.09.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:13:30 -0800 (PST)
Date: Mon, 25 Nov 2024 12:13:28 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0SwOILi4R4g9JBa@x1n>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n>
 <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n>
 <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>

On Mon, Nov 25, 2024 at 08:07:34PM +0300, stsp wrote:
> 25.11.2024 19:58, Peter Xu пишет:
> > On Mon, Nov 25, 2024 at 07:15:10PM +0300, stsp wrote:
> > > Man page clearly talks about
> > > "the userfaultfd object" (one object)
> > > when mandating the "two-step handshake".
> > > I spent hours of head-scratching
> > > before went looking into the sources,
> > > and even then I was confident the man
> > > page is right: people should always assume
> > > documentation is correct, code is buggy.
> > Hmm yes.  I didn't pay much attention initially, but then after I read the
> > latest man-pages/, especially "UFFDIO_API(2const)" I found it looks indeed
> > wrong in the doc.
> > 
> > In this case we can't change the code because we need to keep it working
> > like before to not break ABI.  We may still update the doc.
> I wonder if some non-ABI-breaker
> is possible, like eg keep the current
> behavior of "features=0", but allow
> to (optionally) override that by a
> non-0 request? Yes, I've seen kselftests
> are trying to double-register after 0,
> but IIRC they tried to register wrong
> options, which would fail anyway.

Old kernels will fail with -EINVAL, new will succeed.  It's already an ABI
violation, IMHO.

Not to mention I'm not sure what could happen if uffd feature flags can
change on the fly.  Your proposal means it can happen when anon missing
trap is enabled at least.  That's probably unwanted, and unnecessary
complexity to maintain to the kernel.

Thanks,

-- 
Peter Xu


