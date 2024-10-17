Return-Path: <linux-kernel+bounces-370085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FA9A271F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7036D1F2154B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448A1DED74;
	Thu, 17 Oct 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK1GpDXt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B81DED51
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179744; cv=none; b=ZVAizmj7Y3BD9ty6Uu0Yoa5YOn8JQ4deYPNEI5q1EHW2CiiZcz0C83J9IFMVBmuJvS6AFs7lK/llJtLoCsvqO1wA0ElxU2TF7ehmswrZTUBcxVL20Lt4yukvnsyn46bM2D4sb4T8qej0x9smybaWYwzSQ9PysR/XLED3mXdk9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179744; c=relaxed/simple;
	bh=Q5AtdPEm1PuN3XeHZLXsinD5ecrZzps7l04Ib81p5f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzF0+xqdplLzjw4s7dbbMUThtizCOFhEjid5ZQRHDYvLdKO1DoxCt9CxV486sc1EViL8GBOfQQ0hj+11mO1ADegG5QT/92/+Wm8TBkNIIEXJybmSQ8sijfrRN5RpEO4WU/fOG/U3OiuqwM6j+DmOwcbLe32zhlWpuoc06TRn0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK1GpDXt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729179741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7nlaMmwkDWBlLKSYgZgz6rCQ7wh+bD5wdO571q/O5s=;
	b=UK1GpDXtXi4DM1brUWnN5Fg0MjyRK9DlsSNnIG1n4AgyPT5BUBJqV7pGtku3wK8lRex7qU
	EqLa1Dl2tsPq28JaOP4BcYZBViwc/gZTUinTpXA5JVo6L/T4OIpSau3gnB9vRidWhS7gyv
	R1ULMnLfx1Zj3COl1DoM9NQp5TFXsk8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-WYpYVFq8OOuDyxc4_3hYCw-1; Thu, 17 Oct 2024 11:42:20 -0400
X-MC-Unique: WYpYVFq8OOuDyxc4_3hYCw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2889e4e9a62so1241953fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729179739; x=1729784539;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7nlaMmwkDWBlLKSYgZgz6rCQ7wh+bD5wdO571q/O5s=;
        b=l6ohYKzdfnIMpgaLmV/UjUwXLI/NWhss+HuNggTbv9+VqGlff4OXiX98W/oXlT7WAt
         JZzgLUkF/CNnFQCH++vQwA6WvIUzQfaIKVPEwzFn/ggqupJOV2IcBDEd8oiVct90o0sp
         22KMNBUKq79cwHgbD+tYxuzNpz/yp9GEE8nN31F3bYQJgreXATmOJsKY92Ex0TynZCbU
         33D8MPKBb13Q2DapShFgxkLD2xMK5FWcptAArGm7kAlBbO8dAT/8fEUUdYoy5sP/aqLF
         vKwITtV2Lj5zZjZjoXLSvRY7ueOPSEN30ZZFh/EQhYKv4xB0VCslnk/6S1b1aGJk1wpm
         wC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOxFtSCtGxGn+P6PheVY+IwkJ7oVny3hUfBZqNZfq8RPMP6CsOkr9gq+BGHxCkkcTM1A5AfUogH7R4TBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHyMdjGqoI1NxAkqfZelohW0lNQiVDTYkkw7qW0NIhsTq3MVS0
	AJBtSLulQo1xzFqhHgYgU+Ny30C9lOS7dSziv2K3EKOHnczhF8L9EiDv9mbFc9hz6ohoMy4nPtF
	RUDKTF6zsID8nYCnL6RMrdISuYxr/KsYKnjZjmy5nMqtsn/djj7Q21f1kMN199Ta67wT7Xg==
X-Received: by 2002:a05:6870:4691:b0:287:3fa2:8978 with SMTP id 586e51a60fabf-2886de2fa6dmr17557326fac.27.1729179739049;
        Thu, 17 Oct 2024 08:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHTiDT+m1aEWffgqxEy8Wl41c5Qgk4pCN7PTXVak99nDs/BXI21P+GiCClP6rUO/EGE5gecg==
X-Received: by 2002:a05:6870:4691:b0:287:3fa2:8978 with SMTP id 586e51a60fabf-2886de2fa6dmr17557306fac.27.1729179738733;
        Thu, 17 Oct 2024 08:42:18 -0700 (PDT)
Received: from x1 ([2600:381:fc16:a0d2:12c4:d014:b458:d7ae])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-288dac77a49sm1383337fac.29.2024.10.17.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:42:17 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:42:13 -0400
From: Brian Masney <bmasney@redhat.com>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8775p: Add CPU OPP tables to
 scale DDR/L3
Message-ID: <ZxEwVShJuMH4J1Hp@x1>
References: <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-0-074e0fb80b33@quicinc.com>
 <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-2-074e0fb80b33@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-2-074e0fb80b33@quicinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Oct 17, 2024 at 02:58:31PM +0530, Jagadeesh Kona wrote:
> +	cpu0_opp_table: opp-table-cpu0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu0_opp_1267mhz: opp-1267200000 {
> +			opp-hz = /bits/ 64 <1267200000>;
> +			opp-peak-kBps = <6220800 29491200>;
> +		};
> +
> +		cpu0_opp_1363mhz: opp-1363200000 {
> +			opp-hz = /bits/ 64 <1363200000>;
> +			opp-peak-kBps = <6220800 29491200>;
> +		};

[snip]

> +	cpu4_opp_table: opp-table-cpu4 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu4_opp_1267mhz: opp-1267200000 {
> +			opp-hz = /bits/ 64 <1267200000>;
> +			opp-peak-kBps = <6220800 29491200>;
> +		};
> +
> +		cpu4_opp_1363mhz: opp-1363200000 {
> +			opp-hz = /bits/ 64 <1363200000>;
> +			opp-peak-kBps = <6220800 29491200>;
> +		};

There's no functional differences in the cpu0 and cpu4 opp tables. Can
a single table be used?

This aligns with my recollection that this particular SoC only has the
gold cores.

Brian



