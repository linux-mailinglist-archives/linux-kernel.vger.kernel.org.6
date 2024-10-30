Return-Path: <linux-kernel+bounces-389755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DD9B70CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D801F21874
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6F21765A;
	Wed, 30 Oct 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV8lvkg0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519641E2835;
	Wed, 30 Oct 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332578; cv=none; b=JylHHjqbo+BVRmNaelCWDCfPvSwmIta+kLRwHp24ptsaT5CQCZtgd8mpnuuG1oTWFFm1SDtDcN0E5ANlne2nGroo4e8B4GNriDKfM+4Vrcs40HHLoqa7HlY5NKbWHja9XPwvkHDDk1B++XlDE153DWvOmWJ1pTNxQGOKZNC4QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332578; c=relaxed/simple;
	bh=YZd8yxN6/W8DDik6ALDHj7dNwBdvkBerKm3l5ucPyLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6619uY3gK08fEu0ft0x6RVIG7k7io8JHzAiwYjcTUTWD8rbAQDwgJ1+rpFEfQCi5/V2lItS0ZXdVWacQRpgwSZbCUzcDwFc1ueR7X29ta2TaBV3zshK0cjCIoQBN6VSqH8axl2qTD5idI+PWaJfRjYwgd3d+61XRLZX2l6GrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV8lvkg0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72097a5ca74so275477b3a.3;
        Wed, 30 Oct 2024 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730332575; x=1730937375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ao4pPL8SAOZKsFfVVTH0KY0VVswUTQ5/Mj2b8J72pJ0=;
        b=kV8lvkg0LOvy/mPs2nbvcuBC6vHyD4pafjeMaH3Lm4cnrGRja6azyF4vEQhzbCL5nI
         0Cie5QaTBC0hD2o4MTBeaUB23CldrXkk1g0HV80dVDmIxjNqpgaKXDiFE2saOKWj74Tl
         IjMCR1n2ToX9b8awmO5nILmkNUTGc2egMQVv/bpoWXtuuUFes04S2J7X4Ju0z5zDEnIT
         pUXZttXu2s3Jvt5yKbpwrpubkw+66/G3G31xc1kJ7bF30WCPpSdC6DRLF/ALnzV699S/
         B0tv5QyFRiKiQBMem0IOOT0VfRD1Y/8gtpBdgDhCxUsRSvFBjeE0RTTdM55R5nI2fath
         fUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730332575; x=1730937375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ao4pPL8SAOZKsFfVVTH0KY0VVswUTQ5/Mj2b8J72pJ0=;
        b=RxE+x/csSVMfpmiq4/rHDV9KUS8h5GpLwiV1JU708XNA+pRL5aJq2AjMTLzgPj36Kh
         bUZcCzMb7aCBTeo9MHIO2baOJpAps7vFfhGn8tbTORlU8km5m5/S+NfwTc+B4G/OcErU
         wGxnY9gkv3NxdbzWj+FcUHYTomAXKa0pTIKUfMP0Zoy2nWiTO2s6CVPl6qXNGaey+pOW
         hn2PeoSNrB5LiS0/AkW5zomOrkhMdAVbaMJ61w5TJ4UH2i0CwJ5qtH9kN3cTXC0c7OHv
         S1y6Q9lsFIbTfhnCsVcdr30zAMvC+5v/9p7/ZUVPtxVEoxDDNl0oHEtln9RpzxayDseo
         C4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUfuywKM61BqeAZVa3GXUWekSApMRPzX4Qx38P9geJ1/jP7mt3bSs+/bZEkoDMUYWJDBhXyVzjSjP7bDlLyx79TbC23Ow==@vger.kernel.org, AJvYcCVIrbFGzFn8eNjBhGhT/XNslIkAA+PSMVOaLyPMZgj9JLWTISOT2eccca2uDQsC9fDkxOqRvW8dJtkZ4MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrMUAhXFJjMsAlDNGTXg+iRx8fx8B00Bj3jK+MRVItFV76zfe
	xx8PfrGLPA/dMf5oo3vZYlYaN2C63VGq9fPFmV2ke/8aIOQYjS7H
X-Google-Smtp-Source: AGHT+IGeGm/RGNMjuWULk/C7mpOh4AmehcxCS0ccoDVRP9Tg6hbfwa+kxPY5ZJEteO2FF2vo2YfRyw==
X-Received: by 2002:a05:6a00:cc7:b0:71e:104d:6316 with SMTP id d2e1a72fcca58-72063068a6bmr24909380b3a.21.1730332575437;
        Wed, 30 Oct 2024 16:56:15 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c4a0bsm205242b3a.118.2024.10.30.16.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 16:56:15 -0700 (PDT)
Date: Wed, 30 Oct 2024 20:56:11 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Dell AWCC platform_profile support
Message-ID: <czxn66wpaigpyje3i3ruzcrj2j57gwlh3x2qfivoy6pnzafwj3@5jpsfs6kr7et>
References: <20241030000904.7205-2-kuurtb@gmail.com>
 <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com>
 <2e9fb24e-9652-4087-963e-cbcf3b1f2c56@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e9fb24e-9652-4087-963e-cbcf3b1f2c56@gmx.de>

On Wed, Oct 30, 2024 at 08:54:37PM +0100, Armin Wolf wrote:
> Am 30.10.24 um 13:10 schrieb Ilpo Järvinen:
> 
> > On Tue, 29 Oct 2024, Kurt Borja wrote:
> > 
> > > This patch adds platform_profile support for Dell devices which implement
> > > WMAX thermal interface, that are meant to be controlled by Alienware Command
> > > Center (AWCC). These devices may include newer Alienware M-Series, Alienware
> > > X-Series and Dell's G-Series.
> > > 
> > > Tested on an Alienware x15 R1.
> > > ---
> > > v11:
> > >   - Minor changes on patch 4/5
> > > v10:
> > >   - `thermal` and `gmode` quirks are now manually selected because some
> > >     models with the WMAX interface don't have the necessary thermal
> > >     methods.
> > >   - Added force_platform_profile and force_gmode patch for a better user
> > >     experience
> > > v9:
> > >   - Minor changes on patch 3/4
> > > v8:
> > >   - Aesthetic and readibility fixes on patch 3/4
> > >   - Better commit message for patch 3/4
> > > v7:
> > >   - Platform profile implementation refactored in order to efficently
> > >     autodetect available thermal profiles
> > >   - Added GameShiftStatus method to documentation
> > >   - Implemented GameShiftStatus switch for devices that support it
> > > v6:
> > >   - Removed quirk thermal_ustt.
> > >   - Now quirk thermal can take canonical thermal profile _tables_ defined
> > >     in enum WMAX_THERMAL_TABLES
> > >   - Added autodetect_thermal_profile
> > >   - Proper removal of thermal profile
> > > v5:
> > >   - Better commit messages
> > >   - insize renamed to in_size in alienware_wmax_command() to match other
> > >     arguments.
> > >   - Kudos in documentation now at the end of the file
> > > v4:
> > >   - Fixed indentation on previous code
> > >   - Removed unnecessary (acpi_size) and (u32 *) casts
> > >   - Return -EIO on ACPI_FAILURE
> > >   - Appropiate prefixes given to macros
> > >   - 0xFFFFFFFF named WMAX_FAILURE_CODE
> > >   - Added support for a new set of thermal codes. Old ones now have USTT
> > >     in their names
> > >   - A new quirk has been added to differantiate between the two sets.
> > >     thermal and thermal_ustt are mutually exclusive
> > >   - Added documentation for WMAX interface
> > > v3:
> > >   - Removed extra empty line
> > >   - 0x0B named WMAX_ARG_GET_CURRENT_PROF
> > >   - Removed casts to the same type on functions added in this patch
> > >   - Thermal profile to WMAX argument is now an static function and makes
> > >     use of in-built kernel macros
> > >   - Platform profile is now removed only if it was created first
> > >   - create_platform_profile is now create_thermal_profile to avoid
> > >     confusion
> > >   - profile_get and profile_set functions renamed too to match the above
> > > v2:
> > >   - Moved functionality to alienware-wmi driver
> > >   - Added thermal and gmode quirks to add support based on dmi match
> > >   - Performance profile is now GMODE for devices that support it
> > >   - alienware_wmax_command now is insize agnostic to support new thermal
> > >     methods
> > > 
> > > Kurt Borja (5):
> > >    alienware-wmi: fixed indentation and clean up
> > >    alienware-wmi: alienware_wmax_command() is now input size agnostic
> > >    alienware-wmi: added platform profile support
> > >    alienware-wmi: added force module parameters
> > >    alienware-wmi: WMAX interface documentation
> > > 
> > >   Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++
> > >   MAINTAINERS                                 |   1 +
> > >   drivers/platform/x86/dell/Kconfig           |   1 +
> > >   drivers/platform/x86/dell/alienware-wmi.c   | 477 ++++++++++++++++----
> > >   4 files changed, 791 insertions(+), 76 deletions(-)
> > >   create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
> > Huge thanks to you both Kurt and Armin for all the work done to improve
> > this series! :-)
> > 
> > I've applied this series to the review-ilpo branch now.
> 
> Nice.
> 
> Would it be possible to apply a small fixup to patch 4?
> Because pr_warn("force_gmode requieres platform profile support") seems to be missing a newline.

Should I send a new patch with that fixup or v12? 

Kurt.

> 
> Thanks,
> Armin Wolf
> 

