Return-Path: <linux-kernel+bounces-209592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FDC90381E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522A4B22FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872D178361;
	Tue, 11 Jun 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMTuscMD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DC79C8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718099131; cv=none; b=Bi4n6sJD46UbwA0A9q/3mTI2HIo9g4velCye6OnslPhRUYvRutILfvU5Acq6taKlRiF78i3yN3cX2w5+JVk4z08ji2Cy78ADzzw2Dh5bZLdFi93PWnIXBedXT/2Ju1udYzFcHIT9g1JjrnliD9/jrM+qRHK5K5AU/MJXCf8G+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718099131; c=relaxed/simple;
	bh=fbPWO3YfCn4a8mPc1CLdohG853Qm/IYnmQ0t3FyvGCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP+0uZHiGTLCEkrizGT8cLjyFT2lWn/AGNxt2E6e7xoxQzVWcuiXqdNwYjH1fK5wQHdb2wUoCTQKxOf99GSkvUkBnEz2c8bcaaquiFX9WDhgG0jNJ9de30AMOrF+mOYmg03E3VhsoJl5AslGIbcAY/12a1O6n3wLvQ95S2LhviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMTuscMD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso4077553a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718099129; x=1718703929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIJkK36cZLCR3+8x62O5WUTDL6JbubsX52HQ4wOONjY=;
        b=VMTuscMD/O2sBizR1isvjBHpnHbx91vWs/WaSKyl68Arkf+zCHKas2+P0/ekUBUdYn
         efc86+0y505NsvYy46D3DJPVndyjgKQ+DInqHoLx0HwMQgzuD5vTLmhExyw5sO0LmgZS
         KLNvTfVXYWReMMW2hJKhAdPVYO8lGpjlkdh4giuX7I5K2XDMjA6OJ0RhHRQ1ciMTcLZM
         jtzBsA+1pcWe8yNt04dx3gsFwwPgO4asFOUMp5vBeG/Nvilv+hJtGnI1PoSZGJisDj0y
         DVrTcnPAC8k4MhxsPbJ1CiuLQNxyMasgt+J0R+ERxwJAAnOx0vxRCym89PPe3IeuhGb8
         RoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718099129; x=1718703929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIJkK36cZLCR3+8x62O5WUTDL6JbubsX52HQ4wOONjY=;
        b=Bj3aLZEVaOKTP5l3RpjNR2KW1457UJNPQAezM39ek4QZN2CZz72OJuP/oSpLgLJROA
         2eB9+d7QYvv3R8altJTkT1+yJbw8Y4ibv7/wa6vl4drmgoz9x65qFTDLplgRjfUZWyo/
         NIsq8SK2BVRIN5rEAhuSSc4HMVXb/dI54AolYkWi2IFD5UvWez4QL/kswA7lPvdFdAwx
         AK8YeSv+qxxTeP3PTcoATtol2/v5NdcESEtpsHxfgqcUfHRkGKgDur3lia3PGoBYYtwK
         ijnSSGeIKyZ3Chk5vxSc0kysMsrtUISS24RtXAOy+1+X2SAG4Ef5S7Q9+bjUnTAbvNGp
         mSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOe+B3pqY43KK77E/xrDvgWIi8lrvOYm2nsykeEoB1APhxQEONoBalLM5m9wP9xVH8zKZdos4Z1w9wrIgB0Wby77840C4BGh+OShGu
X-Gm-Message-State: AOJu0Yx6zTntaR7fTqQRi0kxonUwLQMG+Img+ieLuS4Wl8OKSwke2Izh
	tL9DuvlWFvbgiG87Mx0TDBsl6QqsiFY6XfM59oDETQrDNgl6wXu9hMMx3cC1GVI=
X-Google-Smtp-Source: AGHT+IEmsG5w7EV84VzvtaKLkgCKOyPN+sJs7UP3kUKtfjVdo8RcV1PVr5lthNZSAPmr7d7a2PViJA==
X-Received: by 2002:a17:90b:4f90:b0:2bf:8fbf:e4c7 with SMTP id 98e67ed59e1d1-2c2bcafac1bmr11290982a91.16.1718099129480;
        Tue, 11 Jun 2024 02:45:29 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c3092b4bacsm3790663a91.24.2024.06.11.02.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:45:29 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:15:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: "liwei (JK)" <liwei728@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <20240611094526.vcirawlsdefbkuhf@vireshk-i7>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
 <ZmB1qKucR5fXk100@arm.com>
 <20240606072031.lxr7tykl7sdgjwva@vireshk-i7>
 <ZmgbRh+m9MmEaopK@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmgbRh+m9MmEaopK@arm.com>

On 11-06-24, 10:39, Ionela Voinescu wrote:
> Makes sense! But maybe we should no longer update policy->cur to the
> current/hardware frequency once a request comes through from a
> governor, and we have a first actually requested value.

Hmm, not sure I understood that. When the request comes from governor,
we only update policy->cur to the requested frequency and not the
actual hardware frequency. And it is very much required. policy->cur
needs to be up to date all the times, it is an important part of the
entire working of the cpufreq core..

-- 
viresh

