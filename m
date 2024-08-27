Return-Path: <linux-kernel+bounces-302551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B996001F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFAF283855
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A128689;
	Tue, 27 Aug 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8BDWyz8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665B1BF54;
	Tue, 27 Aug 2024 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731067; cv=none; b=IS5v+YolyAyyGxs2kac+yAiijOBkrsTP93NaUZ4+lRuklaoskE3t77jdvJezzT7xdcuVDqF2ExcrFOiunraD5MN2SR6rh9woJ0m9MZIue4Mqnk5gaqakOk7xUlniDn0iHf3M85RxFZPzeFBe197bDJaLwyG1KqhgeBbUG9jjut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731067; c=relaxed/simple;
	bh=V4KA0qCWwuHsJGy+dV+XDeFg4+YnHn7VoEO9mNL3Fio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIZ/l0A12VFOy8t2oqW5muqQ8CMXdXSrWFSyHzsSTT7yfLeXacEdhwmSMNfZ2kE+tOJ2YGcVOWFs+de2fi8Gw1cgEx9Ai4YChVzvzYXXeCvma+X44ujfNXA4GV0RiRF5MY3Z2bSE/n7TvnK1zBtjDUMIvJFsTXKyIj0fFZutE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8BDWyz8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7142e002aceso4118175b3a.2;
        Mon, 26 Aug 2024 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724731065; x=1725335865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvFJtcM+v3khweWKsEPgAj7/isvtIOpyMUSbR7OC/Gs=;
        b=N8BDWyz8bCWU9HooOlcREGT07Fgu0zDEudBbCzwU9JPWDvEpHxJlwsBjEpTPoXMSmJ
         s9TvpYJlZrpWQw+1eimobdaVFgWP75luHpM/dLWT4AREr5hZU1sx7Qc807aWEB5+IlX7
         9t8a/jYAk3O8ThtfLCsa8fVOSMh9saIMQaiCZHtDJ9XBEnYOU6zvVQiLOh6R5Akhpmii
         vHTIPiPS5k6Ir6rOavh41q1kgRBZjqZFRyDyRrxG0BlDob1up64W1j10rhpIrbjYy9Bo
         2V0JG9bdlIwcnDeYYBtw+rYuFfTYSt2qb0gnN8Dk7j5Uef5rMV2dRfVTB5ZaX7cRSl5O
         YbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724731065; x=1725335865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvFJtcM+v3khweWKsEPgAj7/isvtIOpyMUSbR7OC/Gs=;
        b=cxK8QYJmUZV+t0cBAGWVUrH8FCztjuqoAZItViBCY/FjR1BJWXmBCc52afP50GN13O
         DR8cLXTeBSXBvqnMg7ZvQFcgCYpku9D1KxUBKCbwVJsMXByLbryLc8tRh3QEvMSW6UJ/
         3Q+bhltCz0ERQqbSYcTcnNUZJ+g8i7q1zPXk8av0LhwOIeqngf9qfCXkoSpIT2zCNtai
         1FzoEzB409YqVnBMRI8F/Z8wa8BGWwZg3o7wF0YYW8kYwA9UCyacu0GT5fNy2zgNcOBj
         f92D6o7z8xwhFkxwRVFu2TjAyT5FOkYyxRfhFmelYcXSILryb2m7EP2ewoypNmp3XgpV
         +VbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbmeoEylMCfkYpbqY2meNaVAdXOfkpJsnonzKhlrPvo3XDILFOWGn7VARY0ZiFV3NG4XO6RstttMtbeQ==@vger.kernel.org, AJvYcCW9pymo3NsVSSEv1nm6Wahm99e5GBuetchiKIWn5OPt/LcbFODyYpYajF12FHuJ0jRfyQ4+dJu4VRJsI6v7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpc7bsp+t2WaS6yrT43/7O/YM4py47ebxtswLu5Nk9GkA0uQBF
	lvrUJuSoIG66mIO+SOSbLkaOrkcAnY3gFDMf2Uh4a3ukNyiSjT7b
X-Google-Smtp-Source: AGHT+IHKeG+X41QjOhxRG7XUJOhCmh1p0J3EVy2P6AWEkBKROThc1cC16fFlmLPwzcKwB6/OgVh/Kg==
X-Received: by 2002:a05:6a20:9c8f:b0:1c4:bbb8:4d02 with SMTP id adf61e73a8af0-1ccc099746bmr1740473637.37.1724731064882;
        Mon, 26 Aug 2024 20:57:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c612sm74006085ad.218.2024.08.26.20.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:57:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 20:57:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mario Limonciello <superm1@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] hwmon: (k10temp): Use cpu_feature_enabled() for
 detecting zen
Message-ID: <bf33403f-cfd9-4ee6-ac0b-eacc0772c11c@roeck-us.net>
References: <20240820053558.1052853-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820053558.1052853-1-superm1@kernel.org>

On Tue, Aug 20, 2024 at 12:35:57AM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> This removes some boilerplate from the code and will allow adding
> future CPUs by just device IDs.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied.

Thanks,
Guenter

