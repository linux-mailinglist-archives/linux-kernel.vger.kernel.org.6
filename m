Return-Path: <linux-kernel+bounces-217979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293B90B73E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8444281C89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AA168482;
	Mon, 17 Jun 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxC9qhVJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F33166306
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643595; cv=none; b=ClxuMbkbDZpj86btlDKpBImWdfxhzDh2HbA2EBBifuxkq0KDhg14+OZSEPOsbB97sICB1PFQU/tiTRI1keOJQC9nt55jehvrTzqNftwMiUfrBpkybw+XIopXEQ9jg0B+XuKuV32AVZYAYw3BHYn1LM0DTY6dufAu0qBiFu+pmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643595; c=relaxed/simple;
	bh=9bd+nL5Qo2BdVE2faxqfZ9C8XrEg65OcZZiq9C2Spf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdAtMOr4spjL9VRqLLF7XbpZU0/JwRaJr+FHJ+GtlncizSe7c0smawDYvD4ZoFqfs8HQtC61jIEKMfxqdTB2Sh+Gy393K142WpdpROesU+c8GFCbsmvx2RSgcJa/mgXxwQFkXIm7E/O9sCzwRtWth/wJ34aQFqVpuHh+dtY7bDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxC9qhVJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70413de08c7so3271198b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718643593; x=1719248393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz7h6S7CY33xNf+Mf+d3dXD+GMd4vrHEwzJ+6/NbRPc=;
        b=DxC9qhVJcpUtWSckg0qt8PN9NpBe/WNx/LhAqZRBJrmnlxBySUtcmu8zq7485EPN3S
         ZD+SA0aEIbaPFHlPlgAeH1Xd0xg0BapmNG5BAPDvasZZsuDAi38VGXJ/c85o3HiKNySr
         uT0JckqV5qwpnDxGXJUcM2KoB1bDCxVHibKOI/bTz2AqUITxeTt1phX0chfHzKvACdM0
         esSu9TqaZY19M5nNQTNIOLuvO7LmxDyWuH6dEEcCXq4jFFiuDIsSDWGoE706QM7ebSWI
         NVZK2PSAuSaN+JZP2nzi3KPIXnlIVvDl1AYfNZfzqe7fh1ytqm4r+jsL8RPFE+CUTjpM
         lPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643593; x=1719248393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz7h6S7CY33xNf+Mf+d3dXD+GMd4vrHEwzJ+6/NbRPc=;
        b=UaVjlbZnb04PfYXpTQWuA3heEqn6INv87tNpRhC2EZ3VJxK4985FdNKjJZtIQUjC2q
         JZlYVD5z1EEps6vqxkmVchUMqGzGM4MtFkaHNn81ddCnf2cLZ2jnBHGBL9XlsU3DMCdW
         bRLpmoZVS0L7fOgclJ5apsFIhUq5NLBgGI9lGY/7tFpMplvyAKtfDGxaLfyQlNqse4ed
         +lED6tuObmhgFpGmdo1gc8iPk36Eqq0Y49Lb9bRmKYMwTAQei1VfkH1D9yTti9ceRWOO
         YILYut955/RiHmg5LiHf7jnxLp/oqvkyE2XLrsdBxaAwaDlnJMjtv++HQUoa3RfEk2+6
         ZdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNKwCd7wu4m+/CHl+2Z/KMNNmEdYy8r+Gx69qvktpT9+znqab8aUyY8M8Ggl1I3LUxZqD3djLJiynqjva2wyI473Y3eSSwJLFLFI9u
X-Gm-Message-State: AOJu0Yzrm/ZL1yuaByxNZr3/zjTUfmSBMZr4k6y52/GzFHorcAv+wNCa
	xPrGWopipUhGH4pXFG29eR2FVc/EDMwUt5EEXnYHX3hT2SK0P+J3
X-Google-Smtp-Source: AGHT+IEVDLF22+KVbDDCRk+q+Z6pxruF61ha6vbfUbnX9IZGegvbIWt7yO77Vtm/3m8BA5T2A2SMTQ==
X-Received: by 2002:a05:6a00:cc5:b0:705:a18a:6863 with SMTP id d2e1a72fcca58-705d7112674mr12256175b3a.4.1718643593066;
        Mon, 17 Jun 2024 09:59:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3bf1csm7510722b3a.137.2024.06.17.09.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:59:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Jun 2024 09:59:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>

Hi Mark,

On Mon, Jun 17, 2024 at 04:08:08PM +0100, Mark Brown wrote:
> On Mon, Jun 17, 2024 at 07:20:28AM -0700, Guenter Roeck wrote:
> 
> >         .window_start     = 0,
> >         .window_len       = SPD5118_PAGE_SIZE,			// 128
> >         .range_min        = 0,
> >         .range_max        = SPD5118_PAGE_SIZE - 1,		// 127
> 
> 
> >         .window_start     = SPD5118_PAGE_SIZE,			// 128
> >         .window_len       = SPD5118_PAGE_SIZE,			// 128
> >         .range_min        = SPD5118_PAGE_SIZE,			// 128
> >         .range_max        = 9 * SPD5118_PAGE_SIZE - 1,		// 0x47f
> 
> You appear to be trying to define ranges that overlap with the windows
> that you're trying to expose.  I can't understand what that's trying to
> represent or how that would work.  The window is the physical registers
> that the host can actually see, the range is the virtual addresses which
> users of the region should use to access registers behind the window.
> This should be a range of register values which don't physically exist
> on the device.  I really can't understand what a sensible handling of an

Can you point me to an example ? All examples I can find have overlapping
values for .range_min/.range_max and .window_start/.window_len, and pretty
much all of them start range_min with 0.

> overlap would be, any attempt to access the window should recursively
> trigger selection of the range so no actual register should work.  I
> can't tell what it's trying to model.
> 

page 0: 0x00-0x7f	Volatile registers, page selector at 0x0b
	0x80-0xff	page 0 of non-volatile memory
page 1:	0x0b		page selector register	<-- this is what trips the check
	0x80-0xff	page 1 of non-volatile memory
...
page 7:	0x0b		page selector register
	0x80-0xff	page 7 of non-volatile memory

> This configuration would also be rejected by the next test which
> verifies that the window does not overlap with the range.
> 

No, it isn't. The windows in the two ranges don't overlap, and neither
do the ranges. The only overlap is the selector register. The check you
refer to explicitly does not apply to a single range.

> > This works just fine if I comment out the select register validation in
> > the regmap core (the one which generates the error). Is there a reason
> > for having this restriction, or would it be possible to drop it ?
> 
> I'm very surprised this does anything useful TBH, possibly that's a bug
> of some kind.  A configuration with the selector within the range is
> nonsensical as far as I can see since the range can't be accessed
> without programming the selector, the range should be purely virtual
> registers and the selector must be a physical register.

Pretty much all drivers I looked at start the range with 0, having
the selector register within the range is explicitly accepted by the
regmap code, and pretty much all drivers using regmap for page
selection do that. The difference here is that the page selector
register is in the first range and visible from all pages, but the
other volatile registers are only visible in page 0.
Yes, I would agree that this doesn't make much sense, but it is what
the spd5118 standard calls for, and at least the Renesas/IDT spd5188
chip implements it that way.

Anyway, how should I model this ?

Thanks,
Guenter

