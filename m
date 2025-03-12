Return-Path: <linux-kernel+bounces-557240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F32A5D583
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7AF3B4AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55A1DE4D5;
	Wed, 12 Mar 2025 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfB6RdKb"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58704F9D6;
	Wed, 12 Mar 2025 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757231; cv=none; b=mbY9e1zo4vHytikpkPmYC9riexF352qG5RAzczsLm/lxWVo4ZNhfYcsnbtT/9TjTp6gzi7H/SArI4yHZ3XBp+qfskkgbwHrIjLNnuCnz8G/1tkp3YoR7Lq4VMsV+ANTVL7UpmCiQMFqVjlesY9DJZH3+6A1VRrUd39Nqm50Tf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757231; c=relaxed/simple;
	bh=7PfWVt83t4RAdiuW2wGWh7jy60sciymYdt/FZ7Oe1n8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OKUjNaqQsjKhDUqQnGsVWTHWofG3UzzOy0dueX8/wJXOtCe6Nl/l1nE4KZmG3HsaYYsd/efO3w90h4Z1UH+WRTuxE1ZewJA0UKXE1X3aezFT5TO83kEyPTr918VjbD9IcgdyI9GNMvHNzRY7vOHu0cU8WeqiArwM8hAvNEibGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfB6RdKb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e609cff9927so4238450276.3;
        Tue, 11 Mar 2025 22:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741757229; x=1742362029; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PfWVt83t4RAdiuW2wGWh7jy60sciymYdt/FZ7Oe1n8=;
        b=XfB6RdKbOF0JwKPTj3c68NLAvh7e9uZ17NiuATkGscuH6+Oo8TTi3TjFh2ihrP1Xsq
         naqqnB4ZJ4SVrzF1/6tJB2pp1tl/w57k+gcFh3lr/ml0BGozMw48XxgCz1/MIGD8YVGN
         JAcFsXinr3ZhWEB/P/VvtkiHZA9Y9sJTd3ApmpHJCZpaZOlKMZod6OlgSZfDqRqnJv3i
         xSjTusy6UBxN9EfC6PUk48ehl2iGWyw8ARqtjlmOe2iBuq1ID+QoxbrHDuMpsidusZdT
         kYcIQ0kU39xF8LU4XVNN6dNNP+tHul4wBDGu+R0E9olUr80s8YclQgEO64BoeShoxKcr
         3dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741757229; x=1742362029;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PfWVt83t4RAdiuW2wGWh7jy60sciymYdt/FZ7Oe1n8=;
        b=kWlEa2MceLNdl2ktjq1aBd8j4aJs3wmzo0ZJyMkGAgFtkOLq4s9H5BgSIE1v+zFNxi
         b0ZEM8nhWMk2pVfJ3mW484OvVZZgX8BRlTXwHjCn9mv35VNxQnh7uvX1wULLge1Z48mV
         +niZBu8pcY9Z7sfZ5OG6SmQeGw+mtF0A+Ya6vdALXqi3u/edQSJC/G7YZRXayDQeE1Vs
         6SS/tV9VsMmfb5bb5ZN53JHukIlIe8ofKujGVQD+X6uvp0Y7hhQ/LzuJ/axm4kUrpyxS
         /kFeO+3YiCXrB1IghGNK2cD+Desl5GN29W7z7Mu9BxquSJgT+W13+fkaqYtv6iT4bO4e
         75Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVPD/+CGKQCCoHd09tFyUBQ6deTaLx721a/w+7YvR7MwR2cklwbtoG0TkKjf0gLjebicB8NU+Cs8Sgk3EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkdUwgR7Ala+8xqzDQScPz+Q/q+y9WwYzALTZ4tWCMiNyeZzq
	uDHhdEZrL5VvbUwi0lWHBNewvl3y1V3oSOuhNM80D/XeYO5dm4QPuYHtrbAG
X-Gm-Gg: ASbGncsbs4P0cZwDka9lkXoOS1ETxldVorHSTu3pMmYgIu+Hr+xBH6gqtVVILss4tfV
	BHF2ICjsezDu7r0b7uHs6sW+21CDpp2j6zPVycu+sdw6i/kMcFlsmFFSgHweuWr3kDH3SFNe8XW
	owDVZiueAx/sx7PdvlrtcbsU3c6ajcxQTWt6eKm42CWpWLMRu+Yc5xBIzBsEfEVus6r9S+bUVA6
	aCeVBDgso7X8HooRS0E14ifJFtD71xRk9vrG4hJtKOy7img6WtZe57h/Fw0npMwtFkDJ8BcRNZG
	FGLUSBKZLu9AFLhc0aAwp4e7SKt8mxZGWtA1
X-Google-Smtp-Source: AGHT+IGKhwON3/Zgqxdc/kOEUQgtrGhgd6v4ae9bjTlOHb4zQxlZDDDcYZTdDZ9t/lUbT6tdpWlRKw==
X-Received: by 2002:a05:6902:a91:b0:e60:a93f:2a86 with SMTP id 3f1490d57ef6-e635c1f4d33mr27926704276.42.1741757229230;
        Tue, 11 Mar 2025 22:27:09 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b8ff7a6sm3037442276.57.2025.03.11.22.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 00:27:06 -0500
Message-Id: <D8E1ENUHLP10.2BBUD2EP7MRGZ@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Dell.Client.Kernel@dell.com>
Subject: Re: [PATCH RFC v2 1/2] platform/x86: wmi: Add
 wmidev_get_acpi_device_uid()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, "Hans de Goede" <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
 <20250309-awcc-uid-v2-1-5338c6380b2f@gmail.com>
 <9c172560-65ee-4468-93f7-ea5c11fe033f@gmx.de>
In-Reply-To: <9c172560-65ee-4468-93f7-ea5c11fe033f@gmx.de>

On Tue Mar 11, 2025 at 2:21 PM -05, Armin Wolf wrote:
> Am 09.03.25 um 06:13 schrieb Kurt Borja:
>
>> Add a non-deprecated version of wmi_get_acpi_device_uid().
>
> Hi,
>
> i can understand you motivation behind this patch, but this is IMHO the w=
rong approach.
> Nothing guarantees us that a given ACPI _UID value will reliably signal t=
he presence of
> WMI methods now or in the future. Because of this i am against this patch=
.

Yes, in the end it is a leap of faith.

I think that it's not very risky as AFAIK AWCC didn't even exist when
devices used the legacy RGB interface. Also as Mario mentioned, only a
handful of devices supported the legacy interface, compared to the large
amount of systems with the AWCC one.

But of course, there is always a possibility of regressions for some
unknown edge case.

>
> The correct way would be to use the BMOF data to check for missing WMI me=
thods. I did
> some work on that which i will announce soon.

Anyways, this is very cool and indeed the correct approach. Hopefully
I'll be able to help a bit, as I spent some time studying Pali's
decoder.

--=20
 ~ Kurt

