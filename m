Return-Path: <linux-kernel+bounces-388922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC249B662E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722401C208ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0831EF93E;
	Wed, 30 Oct 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpaBYszs"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC6B672;
	Wed, 30 Oct 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299290; cv=none; b=AzlWqi7J7i5Ib248OPgo8NyNp1/B58xMv8wGdrhLrURCx4cGKZjS58OJzba8w/ioLUrVHmiKkLreKrpfNnVytOcV6+upUsOU+Ucga6p67vl/K9I0ePEXeAiw222q0NED2Dm8hY16kIw7/T5DcwbLXWmQ9/+IEetlzzRTHzPtSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299290; c=relaxed/simple;
	bh=cMntFuay/+OuCHddp1vPDruFIwvBjcus6L1u3WPvA34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSoeeVajW4So8rxTbcgXdrXG8Gco6n97RD6UT25emNrcf+qVDnr/kIoYIRKe6ylWSD61XREwQ446IoWCqS1gpwb5KfstkZy2E0mMybR4CqK5ZPXF2Vgeaf9FeRAAzhoopoemARsHlfPfmxCJ7PzdGWX0XEEulJx7TJhSQgvkuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpaBYszs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so2431640a12.2;
        Wed, 30 Oct 2024 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730299288; x=1730904088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VqINzm/Uq9ITTZ9RS871UPqEpz7DSchwIIh/S/Jb1NU=;
        b=EpaBYszsOlr2uUg+H0llsfIoJ6xmNV0IP+cNV8XQ04uFsOkbqYWIIrI4YXGLUSE9ZL
         PNkiDWatxYKb+NgIMrPULxLTsbWi/Z0f9ssrPLA2wu/fWCRTvKwq9lQ6/TghFZZOt1We
         fGDqAHmhOHncp3pLhJiGWPhBBBY5t2w2Tnn6hlW15gPQwNqLj6j169R8ordVy9cp1eES
         Ii7tQW8fXjeEEJ58vRHUObuYqr2XeXfgJIt86rmgZWkoBBKHOjnnXQNDGFyf2+kjxUky
         PdWIjmVs6oFfqHKIB5eRWiiu1v4xkUJVZa+duatXUQMyp953Z5hbQVSA+VoFa8DrsCMy
         1jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299288; x=1730904088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqINzm/Uq9ITTZ9RS871UPqEpz7DSchwIIh/S/Jb1NU=;
        b=nZdgxDChl2OMAqkSqZpe0l6kjO6rcHQcwT2wHqiHXqbNZlEOQOoRl3tCyTpx7jqGf5
         PHdQXmPih2QXRotdaE6y6rVm+ktFwLoxT7/qYJZNQ2URQdH4DwocO4csTOiiFeCsKPUW
         N69vDC/XOil08nIXDNmF2Ascze70F6PyprEhkbLS99rUAzv5EZgP49xnh7LEYJjKHwV1
         R3MuK4HJjtEIv+x16ITV5MXiwAWLLVLaJBJSZDmBa7VevN8oKYB5JbOpT8l29WkY+T47
         Al/y9RFuKTjaED51ZsbhCSNCLxyva/WLxXMc80LtVcnnB35q09O10MT/cpVTDGAGymzU
         oEJA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ilwl2YFI5EPrkx4OVatJltZCxnOrTacNsaexdE6VPJJ95wkK0EEkYWfuHgAI7KoVZlB9eeR/Xl1eQlbembrMKAehsQ==@vger.kernel.org, AJvYcCXf3pCGUK5qoPxOSL2JQ7KeNnHKAGgDhKdCWFDiR5HaDwfiqgrgI2gOSoVeTwpHkGu28R0sfp+R/0+ZkDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxR5c2POhhVODPKFYyoDzMoZfcqiWsh8wLu1qRZsVbv5bsAEGy
	4lIruJTLNOUF+pXDuCZ2+22IbN+W6jrZaXAgrR+clX8myz3LOofwbPWvjw==
X-Google-Smtp-Source: AGHT+IEd98Viu8Exlkn5qwqv5xTZzZAEGmGXHxNMd06bUge0Zgu09Af5vy6BPe1aYOgIC4425YYRNg==
X-Received: by 2002:a05:6a21:680d:b0:1d5:10c1:49c1 with SMTP id adf61e73a8af0-1d9a83a3dabmr20522814637.9.1730299287692;
        Wed, 30 Oct 2024 07:41:27 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057950457sm9593155b3a.95.2024.10.30.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:41:27 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:41:24 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Dell AWCC platform_profile support
Message-ID: <nx53tryrtpewjlxvckrcsnormfr6toy27fsj55kr7zxus6onsm@jojeyg22clgp>
References: <20241030000904.7205-2-kuurtb@gmail.com>
 <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com>

On Wed, Oct 30, 2024 at 02:10:24PM +0200, Ilpo Järvinen wrote:
> On Tue, 29 Oct 2024, Kurt Borja wrote:
> 
> > This patch adds platform_profile support for Dell devices which implement
> > WMAX thermal interface, that are meant to be controlled by Alienware Command
> > Center (AWCC). These devices may include newer Alienware M-Series, Alienware
> > X-Series and Dell's G-Series.
> > 
> > Tested on an Alienware x15 R1.
> > ---
> > v11:
> >  - Minor changes on patch 4/5
> > v10:
> >  - `thermal` and `gmode` quirks are now manually selected because some
> >    models with the WMAX interface don't have the necessary thermal
> >    methods.
> >  - Added force_platform_profile and force_gmode patch for a better user
> >    experience
> > v9:
> >  - Minor changes on patch 3/4
> > v8:
> >  - Aesthetic and readibility fixes on patch 3/4
> >  - Better commit message for patch 3/4
> > v7:
> >  - Platform profile implementation refactored in order to efficently
> >    autodetect available thermal profiles
> >  - Added GameShiftStatus method to documentation
> >  - Implemented GameShiftStatus switch for devices that support it 
> > v6:
> >  - Removed quirk thermal_ustt.
> >  - Now quirk thermal can take canonical thermal profile _tables_ defined
> >    in enum WMAX_THERMAL_TABLES
> >  - Added autodetect_thermal_profile
> >  - Proper removal of thermal profile
> > v5:
> >  - Better commit messages
> >  - insize renamed to in_size in alienware_wmax_command() to match other
> >    arguments.
> >  - Kudos in documentation now at the end of the file
> > v4:
> >  - Fixed indentation on previous code
> >  - Removed unnecessary (acpi_size) and (u32 *) casts
> >  - Return -EIO on ACPI_FAILURE
> >  - Appropiate prefixes given to macros
> >  - 0xFFFFFFFF named WMAX_FAILURE_CODE
> >  - Added support for a new set of thermal codes. Old ones now have USTT
> >    in their names
> >  - A new quirk has been added to differantiate between the two sets.
> >    thermal and thermal_ustt are mutually exclusive
> >  - Added documentation for WMAX interface
> > v3:
> >  - Removed extra empty line
> >  - 0x0B named WMAX_ARG_GET_CURRENT_PROF
> >  - Removed casts to the same type on functions added in this patch
> >  - Thermal profile to WMAX argument is now an static function and makes
> >    use of in-built kernel macros
> >  - Platform profile is now removed only if it was created first
> >  - create_platform_profile is now create_thermal_profile to avoid
> >    confusion
> >  - profile_get and profile_set functions renamed too to match the above
> > v2:
> >  - Moved functionality to alienware-wmi driver
> >  - Added thermal and gmode quirks to add support based on dmi match
> >  - Performance profile is now GMODE for devices that support it
> >  - alienware_wmax_command now is insize agnostic to support new thermal
> >    methods
> > 
> > Kurt Borja (5):
> >   alienware-wmi: fixed indentation and clean up
> >   alienware-wmi: alienware_wmax_command() is now input size agnostic
> >   alienware-wmi: added platform profile support
> >   alienware-wmi: added force module parameters
> >   alienware-wmi: WMAX interface documentation
> > 
> >  Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++
> >  MAINTAINERS                                 |   1 +
> >  drivers/platform/x86/dell/Kconfig           |   1 +
> >  drivers/platform/x86/dell/alienware-wmi.c   | 477 ++++++++++++++++----
> >  4 files changed, 791 insertions(+), 76 deletions(-)
> >  create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
> 
> Huge thanks to you both Kurt and Armin for all the work done to improve 
> this series! :-)
> 
> I've applied this series to the review-ilpo branch now.
> 
> -- 
>  i.

Huge thanks to you both :). I learnt a lot.

Regards,
Kurt

> 

