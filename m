Return-Path: <linux-kernel+bounces-265651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846E93F40A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E6EB22186
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4043146A60;
	Mon, 29 Jul 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMzRsiR2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F7145B27
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252554; cv=none; b=EkQy2ccLxwd+VXgDU10Au71XwQMvwuQIVoHsom18aaiqlknzl/bDtn00L9yg5zJkpV7gio5AeQoc0WbTIhuedWwUTAjjge4G75ziUaOcF6zhvwlOTTtUWDO5P0wTYYO5+7/Uoft+79jvT9e+k4uRmHOuPfE2Qis7i+j5FwULJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252554; c=relaxed/simple;
	bh=5mVSTGPWM1pxOn5OxWB003wz92z4p2dE4iAtQ6nDjbI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTDNnB7YZSVdYGgdXdOcNcHtXMxGk3BXhbA8b3zgQP5ms1H+20V1JRjspxQN9ZRXE0D6inZPVUvVfwcv5wPPu5DxoVvUaqoc7lyPtS8KrStjxZ8DcbgaWJb82KYSHWS3LAIx7RFbC7qNVBZ8wQGg+02z260PlDweplVjgxKgu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMzRsiR2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efa16aad9so4920807e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722252551; x=1722857351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylub7aafKxlZMuv2JYZ4S/MrGVU3Si7xKcH11JwBeGE=;
        b=kMzRsiR2lD9goyVhtFmvKYGkmg07T8ODQaTG7EcSeB9tWCZnq84UwFPbfuJHH5v1VN
         A2HFsQlPYaKIZ93Jvr46r0T37zQFuEy/y0GxCq/EWe82Rb/MvcssWodorfXnTSDqYFfn
         wwKo81vccKjlfiu3Sw/RXb6PlOxMAEl1rqvb3sb4mvdzOaKARiCF/FL/FjaTQT/VHxoL
         QWgmcsACl7/xlgFUN8d6AMwVIdgXN0R9JmCPMI0X/GtDYtukDSKgIcySRKI7NTxf81jU
         FiV2UiQZnSvZKrttE1B/BjuQXwsEHc/kncVyAVm9mFNa2+G69HFfBz8jOxH+YwNtpgq6
         skTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252551; x=1722857351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ylub7aafKxlZMuv2JYZ4S/MrGVU3Si7xKcH11JwBeGE=;
        b=uHWtIlMyH5N6kSq8FnjpsvqZSpwhR18WLGutW5dXGriZ5wgJJObJVhzY4OGcW/6nXe
         OAlK8yrwK/uoiC+tZty5h4ogfV85GVdosWVFDaEzBhXvAkNiGSv2cKj08RjFzWzVfztY
         dB5tcHJ4bRCRIrFBXTslz1dBUl0QlsZ1BQjR8ek6kAwoHn0B0TBfpnVsgKR2dB9+LgvD
         2+c0YfUBim++2KJcqOrXU192hOLswMSklyZOjHfEhCPjuQo8EJXxoefyfQWpTslpOMQL
         mAJNw36w7h6jX+k51YwsOsZyh7IY8tPUFw+3DPdZPSqEt4alEXlnB6gk4CQbUCrOHXnq
         qaYw==
X-Forwarded-Encrypted: i=1; AJvYcCVgUm1N+96a68iT/6As7lvs21bDtmW1EXLa2upgNdSb03aNY7VAh6s6kH0ELtiDz3bIvCJp/ysUspt5kzmNvl7Mmz+7dkOejhuDZ9os
X-Gm-Message-State: AOJu0Yzan4ZdBK5uR4Nd5dfCfxrW2PZaQM5XDrinLoIbXn/NhGyat6gH
	6oJPmz3JZDOduntWhhMH1hNSM1Hf2N71v6UEXg1dorxihUTybRdN
X-Google-Smtp-Source: AGHT+IFVOTeTU5baFFhEMY0+WQeweKFqWyH8B35A61wPJ4+iHPqo/tiUA64k0mdt2DgG77BFvW1rbQ==
X-Received: by 2002:a19:8c58:0:b0:52c:f12a:d0e0 with SMTP id 2adb3069b0e04-5309b27a656mr4548211e87.28.1722252550544;
        Mon, 29 Jul 2024 04:29:10 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd11f0sm1452561e87.80.2024.07.29.04.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:29:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 29 Jul 2024 13:29:06 +0200
To: Andrew Morton <akpm@linux-foundation.org>,
	Adrian Huang <adrianhuang0701@gmail.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, Baoquan He <bhe@redhat.com>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of
 KASAN shadow virtual address into one operation
Message-ID: <Zqd9AsI5tWH7AukU@pc636>
References: <20240726165246.31326-1-ahuang12@lenovo.com>
 <20240728141851.aece5581f6e13fb6d6280bc4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728141851.aece5581f6e13fb6d6280bc4@linux-foundation.org>

On Sun, Jul 28, 2024 at 02:18:51PM -0700, Andrew Morton wrote:
> On Sat, 27 Jul 2024 00:52:46 +0800 Adrian Huang <adrianhuang0701@gmail.com> wrote:
> 
> > From: Adrian Huang <ahuang12@lenovo.com>
> > 
> > When compiling kernel source 'make -j $(nproc)' with the up-and-running
> > KASAN-enabled kernel on a 256-core machine, the following soft lockup
> > is shown:
> > 
> > ...
> >
> >         # CPU  DURATION                  FUNCTION CALLS
> >         # |     |   |                     |   |   |   |
> >           76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
> >
> > ...
> >
> >      # CPU  DURATION                  FUNCTION CALLS
> >      # |     |   |                     |   |   |   |
> >        23) $ 1074942 us  |    } /* __purge_vmap_area_lazy */
> >        23) $ 1074950 us  |  } /* drain_vmap_area_work */
> > 
> >   The worst execution time of drain_vmap_area_work() is about 1 second.
> 
> Cool, thanks.
> 
> But that's still pretty dreadful and I bet there are other workloads
> which will trigger the lockup detector in this path?
> 
> (And "avoiding lockup detector warnings" isn't the objective here - the
> detector is merely a tool for identifying issues)
> 
As for 1 sec execution and worst case. I did some analysis with enabling
CONFIG_LOCK_STAT to see some waiting statistics across different locks:

See it here: https://lore.kernel.org/linux-mm/ZogS_04dP5LlRlXN@pc636/T/#m5d57f11d9f69aef5313f4efbe25415b3bae4c818

It would be really good if Adrian could run the "compiling workload" on
his big system and post the statistics here.

For example:
  a) v6.11-rc1 + KASAN.
  b) v6.11-rc1 + KASAN + patch. 

Thanks!

--
Uladzislau Rezki

