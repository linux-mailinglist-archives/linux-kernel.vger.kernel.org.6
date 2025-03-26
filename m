Return-Path: <linux-kernel+bounces-577083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD67A7182D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A889C188B9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F41F1303;
	Wed, 26 Mar 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoYsjU+a"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10E1E505;
	Wed, 26 Mar 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998304; cv=none; b=Owu4Ajk7j/jNFdnX6b+jD3oTa8LIqsKB59V0ANIkldVDtH68MviavJGDYVQ+eqHcVaNaz9QhBMi9ioyGPAlXoO3oAzRhmBsP/uW/uhjdl0wj7WrUpkMHgI7uDRyLTXoDwSgRspBpgdIEywH6U4d7r85GDIGKhYD6KeM/9nMrEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998304; c=relaxed/simple;
	bh=s6f9kbEJrcHVk1C4n8PlU3JWvNoRMWWc7lpV4Xs/ZFU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LCQz/VSXHuRMjAzSEHE4AvzRByETBsPUUdrmMdGi95e9GlVZH+4lcmkdtpUq6lmnpkSImdpdGngQ9woWLVCGgw8mbSHE5NXTxHDFW7Tlf39Ubye8UCeA6qOIn+Q7osgFnqwTchUQ/DrigreQF5B5vP4Pt8CRYYnuWCpKkOqtvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoYsjU+a; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so1845878a91.1;
        Wed, 26 Mar 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998302; x=1743603102; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn9CeCREC2ry0DlbKdz0wfSVQ0WW3pjZuN5c2VFSAqQ=;
        b=JoYsjU+aBHsuQjLPGWb/V9u3Abb94G1Q+HNAEoZc0l2gjIVpQd+/YnylssvQKgaaKy
         NLcf3xAW3ntZcqrkvU2RaVwQ9jIkHfELaSTJXEM4RzUNyGNEQoAJZnJtvIdxcVoLBhEj
         uCBaqWQQdN9oTDLZ28pOZLIDJKxD99o+G6ZBLU6SpvFEpRK7jQtREio26A6fCe42s0nF
         7TMtMU2OVUNAylxfDnOczHN1vnQOEWa7EHFMIKoX3Nvsrj17SnHmh15d7G9G63+d2hOY
         5AeilBHfUvTszfGwUeBxghkHUzfeJs+6y0PSqxYm0uXQTBIt7bBDeB8s5pI2YxdoD3oR
         3X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998302; x=1743603102;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nn9CeCREC2ry0DlbKdz0wfSVQ0WW3pjZuN5c2VFSAqQ=;
        b=i3jKLPIrlugIB5z3ztWBnbeFF3ekZWAys//j+uQZoLw7fr5i/faDEHGL4lDgG+fVTW
         2bK7lBldq180e8EisD6RosQnLsucaDqs3EmGrkrIs+BiLLPIan1lzaIS5Rgt3wsviHPu
         4+u4iLtrg4zZfBhgADlji0mMVGv8d81DXPzvtM4GfqSSSTzJ9Xv1p35zG7ViXEl1y1FQ
         n6wKm+mACenGLArZeshDZ52FMmYBCrBd2DBdwvx5Mz5awXJJa9347p5+EENtLaB5agaG
         0lrOucKVbzRiNiM/6B2XrbOZAYDIr1yD9Rv0laNTS4AJMWdUW2rSjyhKjwpyIQxWmBEF
         CGDg==
X-Forwarded-Encrypted: i=1; AJvYcCU57XeN8zKJA6XsZm5vp5nXpsVf2MDS+VNqNHo82SexoipeWlLu29XdG1RjkQ++qyJn2qaKJ+7X2NvH44qG@vger.kernel.org, AJvYcCUfCFJ13+4K4Ht7vc34RneK0soWhSDJ3avK8YxmqWUzY6VKwCthzZQ6VP0unumyeszHW2DoN36ihavBtat1VqIQLmVd6A==@vger.kernel.org, AJvYcCUh1MDFJArXqpwmqoa6GcBw6afE3G/Pi7bA17WVyPwAMJl59ajc1ShXhut5Vu45Z2eqNpOnFVpYt3HLew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSKCA/Q+Iuce4cIhJpxc7SiqfzCk/Bbxo7L0r8GKo1jWutJUt
	PNCRJZRdWxTlfENmPTVZZ+L/sqTXtiCnB5NGTO/qYCAPWlLj8Rjh
X-Gm-Gg: ASbGnct/9ZpRSZYMODuf980WLEDx23Y0eWlXw1OYPW3JEW2F/ukD0XodIWsuctwyDy0
	YXv7fKqee2wN6/kXSc/800Omxb+tQcXDMPMfV6he1s6O57xR8VMRWns3KlR6+KtnRcl8M6uLXmY
	Bt4FN5cu7LNjPKpNaEltWmiU9Qmk5tl7pjH3obs4Qu6Da28xjNrwqzF7mTARGn1YX8OyNeZEWfu
	WF+iWdUdSreZ7fD9bdxAkmeMrcI6+ENfjHKQcaNYx88uxrQHEz3kMSAoVwVZF2ilCPNZTz1p1lJ
	VedjeC7+qBRUltPAdbBLdtSjczqRQTfhGmVCRw==
X-Google-Smtp-Source: AGHT+IEy1LFInOX/PuskLuvPaKjlDPucXAb7MH0QA60Wl2zBfVZVL5upjQJ122F9ZhqKss7fCJ4Urw==
X-Received: by 2002:a05:6a21:101a:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-1fe9389e62cmr6045583637.10.1742998301727;
        Wed, 26 Mar 2025 07:11:41 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a23c31sm10945425a12.54.2025.03.26.07.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 07:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Mar 2025 11:11:37 -0300
Message-Id: <D8Q9BVX71OXS.3LT6V7AR5EGR5@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Armin Wolf" <W_Armin@gmx.de>, "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 "LKML" <linux-kernel@vger.kernel.org>, "Guenter Roeck"
 <linux@roeck-us.net>, "Jean Delvare" <jdelvare@suse.com>,
 <linux-hwmon@vger.kernel.org>, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 00/12] platform/x86: alienware-wmi-wmax: HWMON
 support + DebugFS + Improvements
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
 <D8PMFDWIJJUB.196935MS2OZ7J@gmail.com>
 <32a05292-aaa0-15f0-8bdf-dae645b452f3@linux.intel.com>
In-Reply-To: <32a05292-aaa0-15f0-8bdf-dae645b452f3@linux.intel.com>

On Wed Mar 26, 2025 at 5:34 AM -03, Ilpo J=C3=A4rvinen wrote:
> On Tue, 25 Mar 2025, Kurt Borja wrote:
>> On Thu Mar 13, 2025 at 11:29 AM -03, Kurt Borja wrote:
>> > Hi all,
>> >
>> > This set mainly adds hwmon and manual fan control support (patches 7-8=
)
>> > to the alienware-wmi driver, after some improvements.
>> >
>> > Thank you for your feedback :)
>> >
>> > ---
>> > Changes in v6:
>> >
>> > [08/12]
>> >   - Define dev_pm_ops statically (kernel test robot)
>> >
>> > Link to v5: https://lore.kernel.org/r/20250312-hwm-v5-0-deb15ff8f3c6@g=
mail.com
>> >
>> > ---
>> > Kurt Borja (12):
>> >       platform/x86: alienware-wmi-wmax: Rename thermal related symbols
>> >       platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode(=
)
>> >       platform/x86: alienware-wmi-wmax: Improve internal AWCC API
>> >       platform/x86: alienware-wmi-wmax: Modify supported_thermal_profi=
les[]
>> >       platform/x86: alienware-wmi-wmax: Improve platform profile probe
>> >       platform/x86: alienware-wmi-wmax: Add support for the "custom" t=
hermal profile
>> >       platform/x86: alienware-wmi-wmax: Add HWMON support
>> >       platform/x86: alienware-wmi-wmax: Add support for manual fan con=
trol
>> >       platform/x86: alienware-wmi-wmax: Add a DebugFS interface
>> >       Documentation: wmi: Improve and update alienware-wmi documentati=
on
>> >       Documentation: admin-guide: laptops: Add documentation for alien=
ware-wmi
>> >       Documentation: ABI: Add sysfs platform and debugfs ABI documenta=
tion for alienware-wmi
>> >
>> >  Documentation/ABI/testing/debugfs-alienware-wmi    |   44 +
>> >  .../ABI/testing/sysfs-platform-alienware-wmi       |   14 +
>> >  .../admin-guide/laptops/alienware-wmi.rst          |  128 +++
>> >  Documentation/admin-guide/laptops/index.rst        |    1 +
>> >  Documentation/wmi/devices/alienware-wmi.rst        |  383 +++-----
>> >  MAINTAINERS                                        |    3 +
>> >  drivers/platform/x86/dell/Kconfig                  |    1 +
>> >  drivers/platform/x86/dell/alienware-wmi-wmax.c     | 1023 +++++++++++=
++++++---
>> >  8 files changed, 1187 insertions(+), 410 deletions(-)
>> > ---
>> > base-commit: f895f2493098b862f1ada0568aba278e49bf05b4
>> > change-id: 20250305-hwm-f7bd91902b57
>> >
>> > Best regards,
>>=20
>> Hi Ilpo,
>>=20
>> Is there still a chance for this to go into v6.15? or are you planning
>> to review it on the next cycle?
>
> Hi,
>
> I'm almost there to make the main PR for 6.15 from what's in for-next=20
> currently, so no, this won't be part of it.
>
> In general, I don't usually take large series after -rc6 timeframe to giv=
e=20
> time for things to settle and problems to be brought to surface.
> Especially if the series is interfacing with other subsystems which is=20
> prone to lack of select/depends on clauses, etc. so more likely to break=
=20
> the build than changes that seem immune to the .config variations.

Oh - I'll keep in mind this in the future. Thank you!

--=20
 ~ Kurt

