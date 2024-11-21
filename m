Return-Path: <linux-kernel+bounces-416744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4D9D4981
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DD91F21110
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4681CC88F;
	Thu, 21 Nov 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw840hTC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103D1CBA01
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179929; cv=none; b=bH2v4p82OQxzaJMyJK2RKohrIR7Zx/S5PUanUcWTffVo+LuVOsiPLXtPwHi+wbco3ivlhdGq0aqeXp29SJINSNgvUbQvM/wLyWmN6xWD62EnMpASiVNHRkx04/bxvHWhcyDrqbN6paqWxeSsmIaexttxh1h+qs4qDbY2/FMUfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179929; c=relaxed/simple;
	bh=Ec0PNPCT7vpIqSyOhlssm4h8cf3lK37nCX8sfZhiKy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piTl5o6u5cogJNiPOCLjR3upvRfozFG8TVzunpwMo20EJxOgH1QjqECdUg88JcKhQ0JsFd3h061oMmxj1WeK2ovM5b+3+5M7IzYyeGUdcMmgfcsz/cqbR84a/SNr8vm44vdLSIyUZ/FQaEvu4C74DeBKaivHH3bWS51ZW4BJwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qw840hTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jT2ebk9bTCy+GMyYLiRI2aU7X3nKaeJdtYR39sry4I=;
	b=Qw840hTC5dbEpDBBe5BfNucJyBO29uo508BVXupusAADihzGsbQ0oSK1ehDnMafshIOZL/
	JTEVgK1hOiq0hHItlmtVgQ94xcovPTowhHB97QaCpxaZEQINUyG8zzDpbtEHQt6RLBNGCg
	6Z8CvoDHtAinst6u5o+dX50dDS2ZM64=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-QKyFBeSSOMaG6BfdVZDaVQ-1; Thu, 21 Nov 2024 04:05:23 -0500
X-MC-Unique: QKyFBeSSOMaG6BfdVZDaVQ-1
X-Mimecast-MFC-AGG-ID: QKyFBeSSOMaG6BfdVZDaVQ
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e388c4bd970so1217521276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179923; x=1732784723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jT2ebk9bTCy+GMyYLiRI2aU7X3nKaeJdtYR39sry4I=;
        b=T9fswXREL5AUmho8L/zASoUfXayYhG5nrpTLxpfsOQNjoH5Fh8DsrHpo6dNEkvhJGa
         2TUJYFQt6kPu0iHOfGuUuO/jnlPTXX9/6E2yiAScnH0JZm0SWNFglKDkPZAvlGeCHo2D
         rZPiX8HDYQMME/hRNwjGuCo+hQ7YaJB9WLNL+nR0gZRKt8aVT23TZosnyqmMurXF4WYw
         9xv65BOfbxEhHhFqySa1lhY8iq/mHbxjSFGiyjZ4JZgTUR4/bwBEHt5ZghPX/MTaKFNs
         KPgeToVnITjj5+CNimrJimtzuULgcPiAGmjpqqB0fGrMj4+rmZMIYP+/n6sz2kkUspuc
         wX7w==
X-Forwarded-Encrypted: i=1; AJvYcCWbGQTadB8xuMrcONaFHhdrPD0bMqeeYlfnBG6hhAcbRXZvrRpDR3wtE3sKmh/4f86e+8EMEoYXlFDVcNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfX7Lo+oU+iPo160KW+5mQX0H+DRYKKB9ffsq0d4d3G70oNVEQ
	6cmfT5pgf1phqwONj4mKO/uI9kAfB2I2xfhtSOswONT3OexfUXvWI8c+HxQuDOvokRuM0+m+CI4
	XQOWrsAKfG24k7d2JzzVEgIkGRTvbbCaL4g0uhw3nhpgf1pCt1OIctlcl4C4iFdgokG9dKQ==
X-Received: by 2002:a05:6902:1610:b0:e38:87bf:8e58 with SMTP id 3f1490d57ef6-e38cb56ba22mr6905582276.13.1732179922917;
        Thu, 21 Nov 2024 01:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgNQGUoxvn+fRAAKmpRVafqPIYLEdd+RINB5HIuZpbv8uIGcrt+3Rzpz8YR7Bx2YLroylcGA==
X-Received: by 2002:a05:6902:1610:b0:e38:87bf:8e58 with SMTP id 3f1490d57ef6-e38cb56ba22mr6905561276.13.1732179922630;
        Thu, 21 Nov 2024 01:05:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46467fd76e2sm19569991cf.12.2024.11.21.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:05:22 -0800 (PST)
Message-ID: <c3856743-344c-46a5-8b42-567ebd7b6796@redhat.com>
Date: Thu, 21 Nov 2024 10:05:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: wwan: Add WWAN sahara port type
To: Jerry Meng <jerry.meng.lk@quectel.com>, ryazanov.s.a@gmail.com,
 loic.poulain@linaro.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 10:39, Jerry Meng wrote:
> Add a Sahara protocol-based interface for downloading ramdump
> from Qualcomm modems in SBL ramdump mode.
> 
> Signed-off-by: Jerry Meng <jerry.meng.lk@quectel.com>

Process note: in the next submissions please include a short changelog
vs the previous revisions after the SoB tag and a '---' separator.

Additionally:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle






