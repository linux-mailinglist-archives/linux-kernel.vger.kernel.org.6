Return-Path: <linux-kernel+bounces-328760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252F397886A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45DF1F284E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B713C8EA;
	Fri, 13 Sep 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="iukORuk6"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776E12D758
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254202; cv=none; b=huBsal+26+oDw8Z3kzkGo9vl3FBqurBkvYxAKQNeIQTTxRTIRB6M6FzoIwKGGTYwF4Sx7Hee11YYtouHn6qgpFJ0qm1MjlIm/U0s5eq98PoK7nSqixlFvLUkAhl97uIoj9EGcdgK3z4nVWKYwp3zCX77qlLgO5ZScrsZ7GRKhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254202; c=relaxed/simple;
	bh=DejRZZDbvIwg8LB/2rtU2ayjqdkKF06fnRo4NPmr88I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Nnbhw5ZnTn32wVJgzy4aCKULRmxH8mLOJ3+bwA84UoKjR8xk6FUX0DBGo5REBIQBQZnO2u3IecpVfq8oV6qcgz9WCbuFMEw9/bTq78Ew2raLMQ5A001ZRIHQs75D8Ff4LeH/CsGlfdbKNznHuIjVnJcK4A+C8xrYTGFhv6c5eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=iukORuk6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c2509f4143so327037a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726254199; x=1726858999; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DejRZZDbvIwg8LB/2rtU2ayjqdkKF06fnRo4NPmr88I=;
        b=iukORuk64fW541Mp9zsgDeomRnuhsTpFcq/ir1sfeNzcyRXmCSwR0kSdKKC/HHkTu+
         LT6Ojdfxr6OXh/YSzQjFUAuj1fkUwM+jyKrvXQ2Dl+sC+SskTogiqUa8QDDZlv12VYdZ
         I2CzPcW8O4MOG9/4b8ZSheK37r/qr9EfCFlxs/UASVJYdT4LyLyUICKjQMHhFrWAhEU3
         5eS580x0PegH2Hl07ApL5lipI3gFcEuV2YW0zvmGs/FT5951YdsqesnWPI7VLM/M9NVK
         oeRYgrBtA2k62v6hDUfOgJfjYENr3yvVple/UGCwn4nTCqjgMfsgh/Ug2LS9HBpYrX3n
         PxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254199; x=1726858999;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DejRZZDbvIwg8LB/2rtU2ayjqdkKF06fnRo4NPmr88I=;
        b=KkNtNnkfEK4owbiWlLqpSuTh8PUSz35UYiFT2rIgJw/IYExVcqZdRCOMS4D/XgqF72
         ZZ4Q8SwnanlNprmHD4dT+t+S024oMB8GGtJ3zQMOminM9wZXnfOvzDcoL6FDs7skZxZY
         Ou839pd8tQ3yG2pXAJclaOGSA0SnxHVlHxGgvr83RaNMZRjxCuG2oHRpI8EU3rQm1dgv
         tUdMPMBc85rRwG5jb6W/t6a6HKlUVLWpY6SqWKhozygmviQaJ473ONeVq4eS8l4hLnIQ
         /qFzsmCO8eh/PGDCsk46IdwNBm3W7aSe3e0mj+B0E52Krk7c1bJySDTxzTAWD3ZTVyL7
         9T5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqud5kLPLQ5cmgcAqgL6CiOwszBQ9GZrm+Ztv5gDpGWh/XffoK41oYGcIAJyWRZUH+MS/YTavSJaUio+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwhIu/bNdrUefNthXTe8u8/B44ofaaAV2BfahNvRwKwtqyE6X
	B0kdAiN1L+ghQGnOBzzDqvwUdw1w2a8FyWIVUn/GpBjlBMMguJqLhTSwYEZ8OQhncaOcQFkELWn
	oI0g=
X-Google-Smtp-Source: AGHT+IH+LuJuwmspR6WLDdVMlbayW2LEANHqgFNJEOY9KQxhS5KniRy4B4R6msSK+2h63K+cXq+95Q==
X-Received: by 2002:a17:906:f58a:b0:a80:ed7e:8468 with SMTP id a640c23a62f3a-a902911617bmr307927266b.0.1726254198662;
        Fri, 13 Sep 2024 12:03:18 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:a9d6:6b62:70d5:4ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced201sm893637666b.168.2024.09.13.12.03.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2024 12:03:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
Date: Fri, 13 Sep 2024 21:03:06 +0200
Cc: Nathan Chancellor <nathan@kernel.org>,
 kees@kernel.org,
 gustavoars@kernel.org,
 mcgrof@kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B46D6F09-6F81-45B3-833F-9785BBBC146F@toblux.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X> <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 13. Sep 2024, at 20:40, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Sep 13, 2024 at 09:46:30AM -0700, Nathan Chancellor wrote:
>> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
>>> Add the __counted_by compiler attribute to the flexible array member
>>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>> CONFIG_FORTIFY_SOURCE.
>>>=20
>>> Increment num before adding a new param_attribute to the attrs array =
and
>>> adjust the array index accordingly. Increment num immediately after =
the
>>> first reallocation such that the reallocation for the NULL =
terminator
>>> only needs to add 1 (instead of 2) to mk->mp->num.
>>>=20
>>> Use struct_size() instead of manually calculating the size for the
>>> reallocation.
>>>=20
>>> Use krealloc_array() for the additional NULL terminator.
>=20
>>> /* Fix up all the pointers, since krealloc can move us */
>>> for (i =3D 0; i < mk->mp->num; i++)
>=20
> Shouldn't this for loop and followed by assignment also be -1:ed?

That should be fine as mk->mp->num was already incremented before the
for-loop.=

