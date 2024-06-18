Return-Path: <linux-kernel+bounces-220023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEB90DB90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0C1F233CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883413D50B;
	Tue, 18 Jun 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="izFFSTog"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FEF15E5DC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735408; cv=none; b=KDZWNALHZ4lfLC95e5TE2f0aQahhovZ2vUSQeLC63ckLsc/KJfOEGk4zaLnUZ6vstHFFRiIAaTkhodzLnyCGrHJFhM7gZP2g0G9s5fudd44zDCeGYfmr3bK99pI6xst/y7gGwAg89+hTdP2NGGpnvwLelzM8HVlnlJP+W5DOYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735408; c=relaxed/simple;
	bh=RbUj7YnGoY0hmCjZnaaNuFTp3lL/ckTgWn8Mt2zGzno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6zIvwvX3OSy5IW3Swj5wz91/1zsWhsabLNeT2e8CeOPMUYDnmUzcBsBvvY9uaIZ/OggeJM063kG4YCYC9Y6PABIJYz+uiDiOPBoHwLKNCaszPtzPNaadPpWEOoa0jN3NcxmA9jHX8db+hEVuIKXqLszWyHb4RCSzdw9uh03VtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=izFFSTog; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-7ebe019b9cdso186876839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718735406; x=1719340206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyO8jjK5Vx3n7QlCTiUf7qwKHCXenr2vDYIC8Apx6M0=;
        b=izFFSTogk96UTpglToo32FbB463T7mVKJ/B3NcPqsx29Owb4DQwgmtnsqCAiYUp6gB
         MyVXUK9pvM8K/dNd3jwwymF/Nthi4y8B9BjfcQrM6gGv1aDiRGf8QeFGd/GAig7mLPSI
         tPKHR0fPiicuI5effGZ0VbXDBADdoWr5eEYRilbF1afBPviI+nQvIWlZ4QqfCbtHAAdr
         fUjcTNY3DwIhpi47oRitCKUGq3SzY7LY+55SHQNtvux6qpyfZRwHK611dkNWVHhmfzEc
         W9KSb0qqOEpc41hb03hGR8lFCaJV4tFL7HQS5xjDzCmPmvK0iLSSzG172MtB0Qum0E3p
         Y8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718735406; x=1719340206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyO8jjK5Vx3n7QlCTiUf7qwKHCXenr2vDYIC8Apx6M0=;
        b=LmdQweF6wB2+8ajqiuxUbOI8w9Utls/uBTFMttTJt9fKq603gxvElHU+X3iXBokxPU
         gee3xWYeCgViAzIbrywhDhRZHNKFGfqAeZeHrRrLa0dBGNa5MAocYgxMkZ78paGRGpDy
         GOrggGXByq4zyeWd/iJEG+pysCzFpMZKSGHFUajP9LtfunnhPKl0B53IfYuUTCCTRKwc
         cIGXOBT0agmQhFG/wMknlgkvVpJuBf0HwplaUYDY4YSQ8UkLQFaPZ8gTyYrQqLwujwNr
         CRB8nlStjC2SnZqcfjMtLjVaUfQTNR1N63uPLW5+05oedx0aLib3uOjTmirbz/vQdU2T
         i2rw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6E9ETjHFpBA/7jFy2zDpeguBjvR8l+ysyy5A/G98K1CJxVF7DDPeD2kT62gnvwFMLYg++YBvk6i8UtFikVwSA73RKKbAxNIwVtH/
X-Gm-Message-State: AOJu0YwqQDNFDtSCOwIL/HhK4FpbhB/QpSA1/5/iv+mMkruc26Ex9PFV
	Ds1u860/yC8TP/ghaYl7FADW9AfvsDbXMpWYJEJbE+PDNz7KpPrkA/v0T6AAS4A=
X-Google-Smtp-Source: AGHT+IF0icxSe74O6RCAPKxXCwaSwIU0zUDrbZT+AVM1VDUZdEm1EKxUuJJEWzguA5Y8GgkHjAN7Xw==
X-Received: by 2002:a05:6602:6c15:b0:7eb:6cbc:8856 with SMTP id ca18e2360f4ac-7f13edb1690mr76350439f.2.1718735405750;
        Tue, 18 Jun 2024 11:30:05 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdbaca62esm283635839f.36.2024.06.18.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:30:05 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:30:02 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: mario.limonciello@amd.com
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnHSKiaYf2tIQo58@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>

On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
> On 6/17/2024 21:54, Aaron Rainbolt wrote:
> > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > 
> > The _OSC is supposed to contain a bit indicating whether the hardware
> > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > be considered absent. This results in severe single-core performance
> > issues with the EEVDF scheduler.
> > 
> > To work around this, provide a new kernel parameter,
> > "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
> > CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
> > properly detected even if not "enabled" by _OSC, allowing users with
> > problematic hardware to obtain decent single-core performance.
> > 
> > Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> > Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> 
> This sounds like a platform bug and if we do accept a patch like this I
> think we need a lot more documentation about the situation.

It is a platform bug, yes. See my previous email,                      
https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
(I meant to send this email as a reply to that one, but failed to do so.)

> Can you please share more information about your hardware:
> 1) Manufacturer?

Carbon Systems, models Iridium 14 and Iridium 16.

> 2) CPU?

Intel Core i5-13500H.

> 3) Manufacturer firmware version?

The systems use an AMI BIOS with version N.1.10CAR01 according to
dmidecode. This is the latest BIOS available from the manufacturer.

> 4) If it's AMD what's the AGESA version?

Both affected systems are Intel-based and use heterogenous cores, not AMD.

> And most importantly do you have the latest system firmware version from
> your manufacturer?  If not; please upgrade that first.

We are using the latest firmware. (We're trying to work with the ODM to
potentially get a firmware update, but since this affects more than just
us and a firmware update may not be possible for everyone, this would
likely be worth providing a kernel-level workaround for.)

I can easily provide more detailed information - would the full output of
'dmidecode' and 'acpidump' be useful?

