Return-Path: <linux-kernel+bounces-323523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19C973E44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A58B281D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1EB1A4AAA;
	Tue, 10 Sep 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctAIDv1E"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1531A254B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988182; cv=none; b=FlNTNRYmXUCk/AK+KNutO+uLCFQi2aO/TWjA3L5cmSPhyxp1x0Avt3ICk44fZesZ9VqbwUPy+Upxn0Iw2Bt1ftnvDEmwylop7KyhXuUvfYD5n+PV9M6fWprBk02/XBzFDzpZm9XTbp6jeT+/HX/XcRAxVDwXd2IJb0HfaQW1PV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988182; c=relaxed/simple;
	bh=Q6auIC+lfOrkaQD7rvLfX0p7Yv5KiBmeXvQVux4a+iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+DtaX+wWMDPDCOXHDAkDmTeKvdca2EkFCxNRYBoBl+ZmKVHfSddHIwiSGBnTABky8QcpFbHOhtW4VlvIFzMQ2DNdyaRcxr64Kw85J+Lx97SAgX490EnFVltbrRKzTA4N4O6TfzoL54OVtTDk24xh+ZQhIIJFrsGCU8kbK/U3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctAIDv1E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so9686285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725988179; x=1726592979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utLbwR6IroeB0AEHzwu823rdkJ+TU7LsinBibL/Tkok=;
        b=ctAIDv1E9oAlclLTqGyubQX7lIaWDn9B6Twk818IzEs7X9DpT4IUWJKnt1UNquNlnI
         1TWH0M3L6LK6jeBPUAApG9uolxkQJd2hRllXX7GHYrfh6R21E6nRtZocZYXDdpb7iSOc
         1vepBq2Pe4W/j7qG4KFxmHAE3/W1GX9yvkflOBszKSfeZw2IVL5FPlWP0FLv8WJ/EwtV
         CpGJrBivWySanTlRJM4YTdJXdFLEmeyLJ8USh6BnBm8e/BCmkecrlv4mEJmVKJwtlM2c
         yx8xfh6NLtEyHdnrUHO8PHEUKnKAfzsw0mNGGUL7Pcg6p04OtnNUwTEmDjaLsE0MkCHp
         O3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988179; x=1726592979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utLbwR6IroeB0AEHzwu823rdkJ+TU7LsinBibL/Tkok=;
        b=G+AhdJdnS0uXoYitvaKtOXDOCfMtRMx6qAkxs1KTsb98l5ekuPKVSJ3oh7x1oz3vhr
         LSdBikEpXq7f28t5nmr7ZpjJsD9w6ZCy1mAmn47FFGcCbjUobP+YnWT8vsKB5KnUItOf
         +hXGEKrXBW4qFo7tx7hYC7meW9vKa9ULh1LxHyMM7lUBYcLyqufz2BjAOcsQCFpO2u5A
         ++iAY1TJ/bTuSxmz9UAji8GBSfySTNsZ2GmStVj8Js2Sdi9V1N+75c15O1uApl9qXzSO
         8lKrynh/dzRJYCGGNgfY0YvgxFcMel/O7SngZoSHK+zQre2gYvJk325T+bHq/o+QH1ng
         CXLg==
X-Forwarded-Encrypted: i=1; AJvYcCWsIxeAoQp3EkQp74wrHtvEgY1IIMXYilHBlv0/OnmGTBgYQLSk4N7Mj203Z2eILCMSbE/M4xdi2U5HXjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8t9ysG5jRwaLLubp2DNwh72SLcBYVNKkelY5OqCQtqS244ZX/
	z9yl5lFKMsIq33PLCUrXxdBAE8YLHdeQs6DbNEIQIHfxgVXJe440AmSZ1CaMUDU=
X-Google-Smtp-Source: AGHT+IF/QsQfgvnlDNwRI/26MNhGa5Ilm/ivjQU/jiSisbtZcTQW622/yOPDugknPq9MM5U+7aE9Qg==
X-Received: by 2002:a05:600c:4fc5:b0:42c:acb0:ddbd with SMTP id 5b1f17b1804b1-42ccd30c1e2mr3015145e9.7.1725988178642;
        Tue, 10 Sep 2024 10:09:38 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653d1sm9391066f8f.33.2024.09.10.10.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:09:38 -0700 (PDT)
Date: Tue, 10 Sep 2024 18:09:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Cedric Xing <cedric.xing@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	suzuki.poulose@arm.com, sami.mujawar@arm.com
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <20240910170959.GA213064@myrica>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>

Hi Cedric,

On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
> Patch 2 introduces event log support for RTMRs, addressing the fact that the
> standalone values of RTMRs, which represent the cumulative digests of
> sequential events, are not fully informative on their own.

Would each event_log include the events that firmware wrote before Linux?
I'm wondering how this coexists with /sys/firmware/acpi/tables/data/CCEL.
Maybe something like: CCEL only contains pre-Linux events. The TSM driver
parses CCEL (using a format specific to the arch, for example TCG2),
separates the events by MR and produces event_log files in
/sys/kernel/tsm/, possibly in a different format like CEL-TLV. Is that
what you envision for TDX?

I ask because I've been looking into this interface for Arm CCA, and
having unified event logs available somewhere in /sys/kernel/confg/tsm
would be very convenient for users (avoids having to parse and convert
different /sys/firmware interfaces along with Linux event logs). I would
have put a single event_log in /sys/kernel/config/tsm/report/ but
splitting it by MR should work too.

As Alex I believe we need more similarity between the interfaces of static
and runtime measurements, because verifiers may benefit from an event log
of static measurements. For example Arm could have a configuration like
this:

  struct tsm_measurement_register arm_cca_mrs[] = {
	{ MR_(rim) | TSM_MR_F_R | TSM_MR_F_LOG, HA },
  	{ MR_(rem0) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
  	...
  	{ MR_(rem3) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
  };

Here rim is a static measurement of the initial VM state, impossible to
extend but could have an event log. rem0-3 are runtime measurements,
extensible by firmware and then Linux. None of the digests can be written
directly, only extended and read with calls to the upper layer. The tree
would be:

  /sys/kernel/config/tsm/
  ├── rim
  │   ├── digest
  │   ├── event_log
  │   └── hash_algo
  ├── rem0
  │   ├── digest
  │   ├── append_event
  │   ├── event_log
  │   └── hash_algo
  ... 
  ├── rem3
  │   ├── digest
  │   ├── append_event
  │   ├── event_log
  │   └── hash_algo
  └── report/$name
      ├── inblob
      └── outblob

Thanks,
Jean


