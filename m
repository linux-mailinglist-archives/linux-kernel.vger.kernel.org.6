Return-Path: <linux-kernel+bounces-259490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3F939715
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02471B21841
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0C61FD7;
	Mon, 22 Jul 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="tkiZi2KM"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6C4C619
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691909; cv=none; b=iHfGt4e01QgUKuMnUxgDhDjqX4x4gLnK9taLkeuspV+HLNTFzV5GlxDQJ970DzcqmQefP5XiK9snEJSWQQRql1ad2vB8id5gG/yF1OQDHqaKaCGCBKlQ1v+Q8eqzudWhg8VuZEnOl5TmGu7BOIErbnb4bvZl3Jx58hetd2U2tJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691909; c=relaxed/simple;
	bh=Q4uQn6rOt+DZv1Fh/vUKmlRj3UOh0BqDniXWgA4TeeI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=BcSiDyluDlp3Qz4MvEPKkUDXaMNlbLK7oGW3obSMyfml1UE5Beh9PRI3MadFtMGg5k43RJJlTzlZDtYUC9pI9ymsXsRrYr/Yor/ld1DIn9mLKnNOHdmaxWjoM5xK8tsklOeHh+JnYZPWcAIb6XmN+e895OFwfDf3ROY0+Qp/J20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=tkiZi2KM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso131387a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1721691906; x=1722296706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WS54cfGPwjnguy/LYntCPaN1wfikny/NE+IC80tzPG8=;
        b=tkiZi2KMRExkY9cSX8uMZ6oHnijgCeEKrvdULHN3Vt7lVRnx8u4WEZd0u/uaggBUNb
         dYfVOi4AvU+/fMfkRArTVmQsfmOIpV89mQPcAgxyKvnslR927ZYMNpvgmUDI9Jx/xddP
         TdXau/nZAQtxlprlgaI9J7xcFI7VN4lCDdtwq5GQsCr3S5bEg7am+1Xn+JMISnk5puqJ
         PvLv2+jJ55qrfVWadXtizwyUsFvKH/NYUGPyj9uzafALcbuZ6H0KhhQ3zzu67G1+wWgi
         3C3DCazSm7ad5AWQe+ntqM81aQgo+NltPrasNzIdsAphHXSBSMnn8E4B3AwXv0eBm6bg
         PRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691906; x=1722296706;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS54cfGPwjnguy/LYntCPaN1wfikny/NE+IC80tzPG8=;
        b=h+Gvdpdvty+EWGNxmgINE6QBkNyO7/WIyhlODLRiMFhkyRhJ+EQ/6vv5zUP6EnAlpy
         vnLJorP1vw//jQdCCgi3Tngn0L3WzmFlB4wEJ9GX49HJhu7be4uTOkcpf0Cybh4MKjhu
         1puE7jb8Bb2daOvCFqOYbRasdQGiUbSfm3VR+7ruvYbCdMWhCcRBBRJYoCgdgrfstG3D
         oCdSDXfWfTqJICuwhbELvTrdb4xBO91DDR/V7QwvqyGLQU7EhQW6OmNUcK4gMPhVc8if
         augga9ySbHpeHpTdUAkI/W85SYebkx7WLYh2+OhcFgsGW+RrMSV62QxFgkt09g13qz8v
         1cZg==
X-Forwarded-Encrypted: i=1; AJvYcCV4pYp32PgNl2IzS88gJPGVmZeAw6yqX85KitI18ZFkuPLQMP3rH7+cDnirIHSmljeqJ5jFGJaKr/Dch4bIU4LGcM4wf7MGs+TPthaC
X-Gm-Message-State: AOJu0YykV9MFkNVsplebusgs4yjUUW02+RlaTBNrlavzsv5osmjZ3HQ2
	8SfwwRkH12OnC6ThuLriNQsWGi6qb7qm0tjqtoP46e9KLtVcqy1rEXWPGXdOny4=
X-Google-Smtp-Source: AGHT+IHnxLF4xLdZqey/laXc/DP9xei64k/97GkyJAteGm1AHYh2UY/F6zpbCncn+XJoIWUIKa4z1A==
X-Received: by 2002:a05:6a20:7f8e:b0:1c3:b47d:d53f with SMTP id adf61e73a8af0-1c44f86b19cmr1622859637.25.1721691906539;
        Mon, 22 Jul 2024 16:45:06 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2958a0sm60893425ad.102.2024.07.22.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:45:05 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:45:05 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2024 16:45:03 PDT (-0700)
Subject:     Re: [PATCH v3 0/4] riscv: Separate vendor extensions from standard extensions
In-Reply-To: <Zp6/1CzztAOT51yU@ghost>
CC: ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>,
  andy.chiu@sifive.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  peterlin@andestech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-fa5b8aa8-375c-4780-a90d-64511f76ab07@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 22 Jul 2024 13:23:48 PDT (-0700), Charlie Jenkins wrote:
> On Mon, Jul 22, 2024 at 02:32:49PM -0500, Andrew Jones wrote:
>> On Fri, Jul 19, 2024 at 09:15:17AM GMT, Charlie Jenkins wrote:
>> > All extensions, both standard and vendor, live in one struct
>> > "riscv_isa_ext". There is currently one vendor extension, xandespmu, but
>> > it is likely that more vendor extensions will be added to the kernel in
>> > the future. As more vendor extensions (and standard extensions) are
>> > added, riscv_isa_ext will become more bloated with a mix of vendor and
>> > standard extensions.
>>
>> But the mix doesn't hurt and with everything in one place it makes it easy
>> to know where to look.
>>
>> >
>> > This also allows each vendor to be conditionally enabled through
>> > Kconfig.
>>
>> We can do that anyway by adding an extension menu for each vendor. If we
>> don't want a vendor's extensions bloating the array then we just need
>> some #ifdefs, e.g.
>>
>> @@ -405,7 +405,9 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>>         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>> +#ifdef RISCV_ISA_VENDOR_EXT_ANDES
>>         __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
>> +#endif
>>  };
>>
>>
>> So, I'm not convinced we want the additional complexity of vendor
>> extension arrays, but maybe I'm missing something.
>>
>> Thanks,
>> drew
>
> Vendor extensions are non-standard behavior, so this is largely an
> organizational effort. A benefit this provides is to delegate
> maintainership of vendor extensions to the vendor. Additionally, this
> separation of vendor extensions prevents changes to vendor extensions
> from affecting standard extensions and vice versa.
>
> Another motivation for this is that I expect vendor extensions to be
> temporary fixes in a lot of cases. A good example is xtheadvector where
> a previous version of the ratified vector spec was implemented. Another
> case is vendors creating vendor extensions while waiting for RVI
> ratification. This will cause these eventually-to-be-deprecated
> extensions to pollute the namespace and require shuffling around of the
> standard isa lists. When it's an internal structure it is less relevant,
> but it is a bigger risk when it comes to hwprobe. Allowing these kinds
> of vendor extensions into hwprobe runs the risk of causing a sparse key
> space. We may end up with many dead bits for deprecated vendor
> extensions that will never be able to be removed to maintain backward
> compatibility. Having the vendor extensions split across vendors
> streamlines the hwprobe implementation.

IIRC this came up a few times.  I think it's hard to tell which will end 
up cleaner, but it's just an internal interface and it's already written 
this way.  So I'm fine going with this as-is, if it gets clunky we can 
always change later -- at a certain point trying to predict 
endor-specific stuff just leads to insanity, I'm sure some vendor will 
figure out something crazy enough regardless of what we do...

So I've got this on staging, assuming it builds it'll end up on for-next 
soon.

Thanks!

>
> - Charlie

