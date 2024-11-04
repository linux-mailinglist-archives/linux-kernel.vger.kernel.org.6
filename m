Return-Path: <linux-kernel+bounces-395482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE09BBE8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD335282733
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8D1D358B;
	Mon,  4 Nov 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMD1HTDz"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963D1CBA1E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750762; cv=none; b=qMR7e0S1B8xaUKgywdTLOhzeObYTtOzl71ctpBTb59rxB+dq5yJmpIvdLZ+tP4S2iDyb5bIafDLfrazn0Zw6UBy2dJiNmALEeYWcZrH8+rnPZUskq0IkYM+rNokbzf3HoicHX9c/6A7s03A5Qt0+3iUjWkep0wSe7KA55SbcwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750762; c=relaxed/simple;
	bh=f+XZ1Y+CjJHrhebqOVBgbpEDD6o/5wFQSB3aZaSCQMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9ic7tmDHHrhwXnPCdKVZzuwNDjFED7RHFUhBth94fNGpKgkSL+01nvwveV28HSwnjLTKpeYS3N8sbrb+UiSKZ+W44zYIi9Z1gvMl6P4lYkPG84t7r/cVcK4qCc3Uh55bFtcUCroUGAgoGLAtpNjgE8FrEfdkLz7+OPj1J/nLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMD1HTDz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c803787abso36296805ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730750760; x=1731355560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ8OOnc6yQZnIOFXXUZbfk9SsgcVAjoUt3lrFfZpVik=;
        b=VMD1HTDzWW4SLfwadihkZmyvspoyKps+i5AbMh0IEJs4ox9t2/MRoOxunh9SA/HCRr
         cfSfTW/FQOVby9MGoPNCD6vPHo4jGZOrx6PCfMiQex2iaXoYbifFrJrE2ICJ5DoQ2Go+
         QCOZAJp9QYL7DHTWHSuJjrbd21aIJFvN6UoKOPcQFiEacCyCGjTk/AmhK/sPdk2VDvJs
         XJnJhBGN+hittzfxFnTxFlU3ZBTJ2N+15AVB/GUXifgKW7F8MwvS2PBMIiF2pBHcdNQ6
         g4BR07kX5u7GNHcKLOVZo+z/iyUhVY6RtoeiltofWYt4om6M7clpsGrLTgvYr3yv9LJU
         V+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750760; x=1731355560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ8OOnc6yQZnIOFXXUZbfk9SsgcVAjoUt3lrFfZpVik=;
        b=qUtiUKRT/p3vHQs1c0QCTMQZQxnIxL32z/IN6s5/s3febN/UFqZmktcd3pOpuXKY3j
         sYE+3F5LDm6ZarhRgJfubd4KYyg6Ihy7GATGzpe/Dis/0qPQt1kwjYpAHzXLWWYE2mkE
         2CnTU+LIDkku1LWDbLodjJsCqoqpwlaFsH//fk9BziSDAI6YfdxtBWZ2mUTsWIqyv8Gl
         30RG3oqlh8rWUsHFGnb0E42R77GH27cyX4S4uPEvQFI40GiCltpnW/emH0NcvV2Brnsf
         jp9vsJlpSFDvsQR+X64Q+QmYOZ/E6qcp9wwDABAYuQdVn6OSfAUYw9oXspkzIIv2/uMC
         fk+A==
X-Gm-Message-State: AOJu0YynbbX+Rpgw8y+U87cRfL0pf+7AtmJQ2S7swBT1zGFuT1YHExU6
	iKAIjd0HIiMIxtZPl5+feaOky1zxIc3Xz9ddgOPI6CQrUZd73cOcHwbP8A==
X-Google-Smtp-Source: AGHT+IEEPzTSVB8CWAqgQyQLYQc1MFhoE/gxApK6J0+lSyNkkhsC/V0Fu3A2nFGWXKLYqDkGUw0/HQ==
X-Received: by 2002:a17:902:e5d0:b0:20e:5a79:b97 with SMTP id d9443c01a7336-2111942b5d1mr204230695ad.15.1730750760173;
        Mon, 04 Nov 2024 12:06:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21131c64226sm41717865ad.150.2024.11.04.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:05:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 4 Nov 2024 12:05:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc6
Message-ID: <d8195fa3-0593-439c-bbae-563d077813fe@roeck-us.net>
References: <CAHk-=whORbp07SkmAUbXTRtjk7imEgWXReGMaeteMg-gAFU_cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whORbp07SkmAUbXTRtjk7imEgWXReGMaeteMg-gAFU_cA@mail.gmail.com>

On Sun, Nov 03, 2024 at 02:19:42PM -1000, Linus Torvalds wrote:
> Another week, another rc. Nothing odd or special seems to be going on
> - this may be a bit on the bigger side for an rc6, but not hugely so,
> and nothing stands out.
> 
> We've got about 40% of the diff being drivers (networking, gpu, clx,
> sound, iio..) with the rest being a mix of a bit of everything:
> tooling, documentation, core MM and networking, filesystems (bcachefs,
> xfs, btrfs, afs) and some tiny arch fixes.
> 
> Shortlog appended in case you need to read something to fall asleep to.
> 
> For rc6, boring is good.
> 

Test results, at least mine, are just as boring.

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 549 pass: 549 fail: 0
Unit test results:
	pass: 460983 fail: 0

Guenter

