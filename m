Return-Path: <linux-kernel+bounces-297089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA695B2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EA21F23A35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA0717E91A;
	Thu, 22 Aug 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHOivAle"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A017A588
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322415; cv=none; b=C+7bw9yEjvmtVmIhqrHOapWE31sTfIEyLaQDPIUj3bM1vdhDqccDHXITZ+fgKYdqSaGuGMTbwG8w6tCuje3WjAbve/CcHRXNz6ZZSDAG9Cs9khARUOOv+cv01I6sPjdTGCrEmefjwhEvfjDmJk18e5gZODPq/wKTKl2wmt3lWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322415; c=relaxed/simple;
	bh=5sMWJThp26wDreVaoeR9jA5bw/h5/FWfrOF3yil5OCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMu9eBu11D8j/XH+g0Idiy8R59Dtk6mvv91OI88oBGDjSp3tOMLWMWCIs0BNHXiEYBaMfV8u/1nCvvqtrzbWfKU1ptpBypsltAQHzHOFVp3k/rDDzjWuc1+a8CT+0+2RX/zDiQi6h9cVORFk2r7du3OE+fi6qLYRQuoNPi48t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHOivAle; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7143ae1b560so165586b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724322413; x=1724927213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkgWkpeBkrdzZNye7cw+skshRUg4zQU+vkmgeHcGQnQ=;
        b=eHOivAle56wro/aAZJ+YTuM/7O4wOGDIfHRmhrUsy/5HLC1yc62hGtPYqX/WDAMBqZ
         RuZaHlM+b8fsgyQM9Xtq8hR5o1LoF3bYBkTbZ9OloGpP7dJI34ElIvFfzlBtmco8Y7LS
         fiX2HsTXthrmtU/o94Wwl5d1olC+4SM6+WScfUK0wDmjoOtjTn3xLStRuRGd0qYLaOsF
         YF/2lzk35T7INRW2pXA1ghiGntHgRZw5f7Pwe0OVF+Sd0zTOfdvDeNHkhxmNA68J7Pkw
         u5KjSRSNKlZZWmCMNNGu3YsjkzCusiDgRHqKcqcy3k2yf+/YlOKqrq4vfgeBd1UufSy9
         uNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322413; x=1724927213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkgWkpeBkrdzZNye7cw+skshRUg4zQU+vkmgeHcGQnQ=;
        b=IiPui+mNNh5z7A3gQQ8SJlAMmwoJ/s4xN+bFUXn+A61i5d6U+7bMLn/law8au8bU9a
         oIMXJmiT7+1M7jDG1ZpAgh2ABTM4EQ+IgOTABHD4YLrJlkC4YIDBtLvAl74vOtcQXGcl
         gHxLJyOfwpxbGoDNzLQjTH6c1ibGPIaMJT17rBGIrF9PCsb7509PqSTRtlKVKE0kcqMW
         xxWCTUKbz3onwGtVyYLA9Adus/JT5A3uItpaGY2of/s9pEGxNee8lVq/ttWoA1bE4sqm
         9NV1Blguo1O1AL6gWRjYlu+ZRxAE7N/kWNu1/AGVGS+hAbACupE5cfEHNKBCT/uCfUGM
         cNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXY9Kvdw4D0OtAFxJm69GK10skXLgmurjYPwrv6/pZoST6mJJoOatiMJKl4yHBCRydPzpNKN9FKt7nK/Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwfOrmM/i0uljYjgNfjSfx9QluQVNEfaulfcQusHXg5l59Yqz
	aUMaE0hq4jvfn/je3yyUiCxsczJBS1kZgGNz6MIsiwr3ZXzdpybs5AkylkIeUFE=
X-Google-Smtp-Source: AGHT+IHbhXpWGnJmwtPx/rVZeorsOnX4oc5FmeJaVnEbCyXlh/hgOUHhnN41bK3/6XIkKpjH1DuD9Q==
X-Received: by 2002:a05:6a00:1788:b0:70e:91ca:32ab with SMTP id d2e1a72fcca58-71423462dcemr5800057b3a.6.1724322413185;
        Thu, 22 Aug 2024 03:26:53 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09e0sm1062861b3a.105.2024.08.22.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:26:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 18:26:50 +0800
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Minor memory size optimization in debugobjects
Message-ID: <20240822102650.GA50561@dev>
References: <20240821230539.168107-1-woodyzhang666@gmail.com>
 <874j7difg3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j7difg3.ffs@tglx>

On Thu, Aug 22, 2024 at 02:11:56AM +0200, Thomas Gleixner wrote:
>On Thu, Aug 22 2024 at 07:05, Woody Zhang wrote:
>> As of now, debugobjects framework uses hlist_head and separate spinlock
>> as a hash table bucket. We have hlist_bl_head APIs which embeds a
>> bit_spinlock in head pointer and thus no separate spinlock is required.
>>
>> This patchset first wraps irq variant API for bit_spinlock as well as
>> hlist_bl_lock and several other APIs and macros. Lastly, It replaces
>> hlist APIs with hlist_bl counterparts.
>
>You are telling _what_ your changes are doing, but not _why_ and neither
>_what_ they are trying to achieve.
>
>Aside of that you are failing to explain how replacing a spinlock by a
>hlist bitlock is equivalent to a lockdep covered locking primitive.
>
>It is NOT.
>
>And you have to come up with a convincing argument why this makes sense
>aside of saving an unspecified amount of memory, which you haven't even
>bothered to document. Neither in the changelogs nor in the cover letter.
>
>You also completely fail to provide an analysis why converting the debug
>object locking from a fair and sensible locking implementation to a
>known to be unscalable locking implementation makes sense for a debug
>facility which is used in a lot of hotpaths.
>
>Any attempt to substitute a spinlock with a hlist_bl locking scheme
>needs to come with a proper analysis to demonstrate that:
>
>   1) this is a completely equivalent locking scheme
>
>   2) the resulting loss of lockdep coverage is justified
>
>   3) there is an actual performance benefit
>
>   4) the actual memory savings
>
>Just handwaving about an unspecified amount of memory savings (probably
>in the range of 2 bytes or such) without any of #1 -#3 above is not
>cutting it at all.

All right. I will post a v2 to address these issues and try to give a more
detailed explanation.

BR
Woody

>
>Try again.
>
>Thanks,
>
>        tglx

