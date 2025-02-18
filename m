Return-Path: <linux-kernel+bounces-520219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2ACA3A725
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000353AE6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF87267384;
	Tue, 18 Feb 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD2OLZnt"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A11EB5C0;
	Tue, 18 Feb 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905801; cv=none; b=jIX4uYWCoburYNVPfySJy+h5coVWOp2QPZn1kDLTcv1vsmLFils3MHk/SKF4jRq2AqwXv/biymgYBC2PvGjEnxWB2+2PNfFoACiS6KNEJKZEELM+GHKC2vbuZP0QR/ee88Oe3vh8C4WfVscMCHrBblRAW/z2Uh6HiIavTzmsZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905801; c=relaxed/simple;
	bh=lXn4v5JsnT7T3CKTx48NSASkpRG4iPPRkLsp9BEySfY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jo58S78Q9ICTSCvAxqn3htqJDidnEJnd5IoG1o6ltkWobYbEQMuvYM6WaH2EypPTRXvoHeuwfygVzkw+TEZj6R+2lf0i4qqvAWkwtVbMyBnkQ6woiQuaj4maYsq6LeZZazLwoD6Y9xDscPah6zNiq25Ah5s2f+A0UqVB9NPYYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD2OLZnt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-520a473d2adso1890211e0c.2;
        Tue, 18 Feb 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905799; x=1740510599; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXn4v5JsnT7T3CKTx48NSASkpRG4iPPRkLsp9BEySfY=;
        b=LD2OLZnt/9BjEvICMYbhZjAQxIPIDRiGXhsod2Wo+HmtMEpe+hbTqcP8S4IuBEog7K
         rNoTc/RY29mKiuNVOhlLP2Om8v/jH1bzvitL0Rrvo3XUPHVjkgcN70QHIczeGLwBcMyn
         ++gTmWuCBKLZh/OFxwcnD9bp8TtFRH8Job/f/Vbd7YRJql+/FJ6yM/6A20tskoyd42+J
         aiXKvhnPkIfIWT3hf5N3g2cpY3ul5emMXyzmkLZT9GLL0QWWog3yH8KCc51lJm/gZGve
         ST9mnT+p9Oq70TcqMfQSXI2O5mOwkd2qEHWuMhTN4kOoiZ6EWwkk13egUFI8VxYJ+iY0
         0Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905799; x=1740510599;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lXn4v5JsnT7T3CKTx48NSASkpRG4iPPRkLsp9BEySfY=;
        b=c8ArEaCbGe8OooVp3kI2ziZx6H1MZsThzycO81PM2DJy+YeKWRoOJlr8tpJXjih4Bd
         mMNqbcO0BMvctVBz1slv8RWLTzS3yiUqZ0hRqWuTz9L2X9ECTCgBfMbP+L/xBEvRGdzY
         y7mw4nkssWXOLTFluXH5aaVHKVPdwSBQKb9WBNMOnUQsw2JxD21PmRnvKpSzEg48F/Wj
         atWtP/vPs1XZbexsH1nX92+NMGutRfQeG0v8O6HLMqiFjerhbMVzSThKNn1M9F3S4R6A
         ncAYuq5r2/5fpiYYUhkTULXqpOFFNmK32YUqLvgUgZbSytEg02qGjUPEP2lEX47/rF3B
         jrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUy02gdyeafV+PkZotitgMz+nKuUJlUn8Jld7pcYZCPxaH/N6T0JuOJu782kSEdg6VNhPhOkLBVYsNtK7Y=@vger.kernel.org, AJvYcCXHfSIwCJpRGqEnUOblkG1crYt/lGQQyFbHqwir7I9m1PRfOnZ95Hgs0c3qLxMz6LWVTHk8uE9q1OMVTE4H4xhDmpvwbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDiKSpt+gjjoQvMIbjJcctStc6kWLFjmi7Mt+WiHq5/u9iw+p
	DW77OcfrahHh01SDO2aW3dE8EBPAmrBRffHEHCC8JGOCL4Ua6Z2K
X-Gm-Gg: ASbGncvCVl00BmZatOCthyLg5JKic6tOUwZxk5NPaAYUEG9YPSxFXBfKhUJUVW4B5J4
	zcBmi6GG21AMltoEjhFQQiZN1zSXeg7K4w2G9vVCH0l4cj+S9qv4uO1cpLXNbcSESx+/Zhvrnrb
	n3uY+x4ktE04DOliauu3V2Qs4xsDasBfZPfvUg8o5gDV9hraGaQJIJdcYDeX1v++4mCbRXF83/D
	n9BU6MPTZ9Siz4AjXZVXxNp57EmLmwvQ6Vl4n+XzPE9atZMRn/uGbe0a7Js5GZYXuXIKK9XHa5o
	RRZjmCU=
X-Google-Smtp-Source: AGHT+IGhGHn1OSq1/KyiMdFiNJ/FWPMnxHif0EI/0h3HHaJEpRGDOTCue5uNkfKSt2He6QDmbLceGQ==
X-Received: by 2002:a05:6122:1686:b0:520:60c2:3f3 with SMTP id 71dfb90a1353d-521c441d9e3mr497554e0c.4.1739905798992;
        Tue, 18 Feb 2025 11:09:58 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520a3430c00sm1810703e0c.0.2025.02.18.11.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Feb 2025 14:09:56 -0500
Message-Id: <D7VT4O9N3KD3.3DK9CY1TODOMR@gmail.com>
Subject: Re: [PATCH] platform/x86: dell: Use *-y instead of *-objs in
 Makefile
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, <Dell.Client.Kernel@dell.com>, "Matthew Garrett"
 <mjg59@srcf.ucam.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214214535.4947-1-kuurtb@gmail.com>
 <cc0f1964-ae37-4cfb-b5d2-da2e2a97e522@linux.intel.com>
In-Reply-To: <cc0f1964-ae37-4cfb-b5d2-da2e2a97e522@linux.intel.com>

On Mon Feb 17, 2025 at 3:58 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Fri, 14 Feb 2025, Kurt Borja wrote:
>
>> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
>> instead, which is usually used for kernel drivers.
>>=20
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>> Hi all,
>>=20
>> I based this patch on top of the for-next branch.
>>=20
>> Ilpo, if you prefer this patch to be based on top of the fixes branch,
>> let me know. I'd submit two separate patches, one for alienware-wmi, on
>> top of the for-next branch and one for the other drivers, on top of
>> fixes.
>
> Thanks for the fix.
>
> I took this through for-next branch to not make our lives unnecessarily=
=20
> complicated. If there would be only handful of -objs, I might have decide=
=20
> otherwise but this (wrong) pattern is really widespread so removing a few=
=20
> drops from the ocean is not going to sound us the finish line fanfare. Bu=
t=20
> it's still an important step towards the right direction, regardless.
>
> TBH, I didn't know the distinction either until Andy explained it (and=20
> like you, would have just copied the pattern if one was readily=20
> available). But I've never really deep dived into the kernel's build=20
> system anyway.

I will finish the job for this subsystem, so no one copies this pattern
again :p

>
> I wonder why checkpatch doesn't catch it, or does it? At least there are=
=20
> no "objs" strings in its source.

It doesn't actually. Not even with --strict.

--=20
 ~ Kurt

