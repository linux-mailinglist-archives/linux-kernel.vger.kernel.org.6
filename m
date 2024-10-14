Return-Path: <linux-kernel+bounces-364584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89999D681
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4765F1C24377
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60D1C3024;
	Mon, 14 Oct 2024 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="NO6v8epN"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F5231C95
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930682; cv=none; b=N5bMNSR7URU1fEm2cUkZLnp5xwC9IvHHLRWgamB0nZwRke8qOZWMBd27Cegalw6rUuxTBdUD1qih2xX+PDB2sYpXCFWoC4hlYxRwWY4zkkfeazmMkucmNvswF38nLJWfLwRvxsXdJCxDqN3w0AUauNiZ1Ufda3J0X8VkAaCC9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930682; c=relaxed/simple;
	bh=BVCog69Q4l8JS2GopUh/ab2dVE4NY90TvoxcFw3heN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBTLZ4C1c6gH24irs3a+0OrD+UGkBrqdUGaPryGH98DG2BYJxO7dSxY580GU8drik1ovR8tzaJVPotg7sdN8oti9rxwmtgtoNZhtfSizrxSEb1ZCxaLtwHJ6ZdRT6FYHVCNbTrlDcBbtFnwwK0l/LAIA2UMDSAPHZzS5Zc2sPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=NO6v8epN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso1075493a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728930681; x=1729535481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MyJPIjDdd4bcdgmP54xCCeoGcfgAF5sEjDPcoIG7eQ=;
        b=NO6v8epNKdfvDPgrhVZcdSUZUi9Dr8Dzo/h/qTU4nyVypRDGEWowjJN/1VX3k+Wvdg
         wljot5z9eZiqAuJ3LngDDBdh17s7jJlh5zcU+HgvVnALrzDM5CoVOOXwrCXbYFIKY+Fj
         0Hd8RcJyIT/zBY7Y+9ECvV3/mHxjYvTOBOZhg0UXYFhQcvJ1ns2/ez3Y4Dhb8bfKPrqt
         tld9OWl5XDQELj9P7YtqAc7m+sBrepI7rDdQ0n9MKmMbpE5nB1fhFSCqjqp9o5EZkgpA
         Ee0o3sSgS40YnBmLMPeglzjaUNGkM5cNbotHEPwuz9Mia3PxXOJQfRhMpKKidtoJsVma
         w9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930681; x=1729535481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MyJPIjDdd4bcdgmP54xCCeoGcfgAF5sEjDPcoIG7eQ=;
        b=iFXktL6u4DA45SgNjdwcQyKVSimkEwAIqk5WJEh+qJjeXVC7t7vCc+Iubz7gCUU+5Y
         s/b72QHfW1QKSm9L2KxVvbvm8+YOJcGxb05daOxzmOo2BHaCSC8rvj8qAJ3jY3Awfdsw
         CQ6GeLmkvvWRzUYajk+1aSwW8acuBTscueb2eA/cQG7KITseXqPQ5XhvqBRlM+9W72CN
         6v8gEqm4EobJtMFBjD/nBdafdoAIkEaDNBOsVIgqelkOi2GHcXDDfHVChBV9WGDEn0aw
         XUk40VsWLWtyzArUbfypuxPbXVqtX8eAAZz1FaC7Ohp/blopTUIbKY23WraUSVeLJy0G
         tF+g==
X-Forwarded-Encrypted: i=1; AJvYcCWgz+9mAcckGen8fWGVVOiL/Uj8YgR28+leNYyb3j3yXM3Va+6Ec4f8XHE502qYJkDMiga6GdVr9B30//U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qWMo9PyzLqNce4fWT/a/Sx9AinjZF5wOcoo/x8CAsWA3Uefr
	B4XsWnXRNynkmI9hKIHHKApkleq7L//87iSXJWVZWj+3SWAKnSKxURrNxczDYE4=
X-Google-Smtp-Source: AGHT+IFEc80xxdqhyMjTS/P2wRAr0IT5/jeoMI8YNDGJsBDXkjZ1ppm37ofoh2IW/bQMBmQHWGHjVw==
X-Received: by 2002:a05:6a20:e18a:b0:1d8:abf3:58bd with SMTP id adf61e73a8af0-1d8bc85cb97mr18051071637.13.1728930680726;
        Mon, 14 Oct 2024 11:31:20 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e6818a0e2sm2143534b3a.31.2024.10.14.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:31:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:31:18 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Introduce support for T-head TH1520 Mailbox
Message-ID: <Zw1jdl64f5l8N+Km@x1>
References: <CGME20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee@eucas1p2.samsung.com>
 <20241014123314.1231517-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014123314.1231517-1-m.wilczynski@samsung.com>

On Mon, Oct 14, 2024 at 02:33:11PM +0200, Michal Wilczynski wrote:
> The T-head TH1520 SoC supports a hardware mailbox that enables two cores
> within the SoC to communicate and coordinate [1]. One example of such
> coordination would be cooperation with the T-Head E902 core, which is
> responsible for power, clock, and resource management. For example, in
> the specific case of the BXM-4-64 GPU, it needs to be powered on by the
> E902 core, and the kernel running on the E910 needs to 'ask' the
> firmware running on the E902 core to enable power to the GPU island.
> Given recent advancements in work on the upstream GPU driver [2], there
> is an emerging need to get this code in the mainline kernel.
> 
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
> Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/1 [2]
> 
> Thanks, Krzysztof and Rob, for your review! Since this series is gaining
> some interest, I've dropped the RFC prefix with the v3 update.

I've applied this series and booted okay. I see the driver loaded:

 /sys/devices/platform/soc/ffffc38000.mailbox/driver points to
 /sys/bus/platform/drivers/th1520-mbox

How do you test that the communication with the E902 is working
correctly?

Thanks,
Drew

