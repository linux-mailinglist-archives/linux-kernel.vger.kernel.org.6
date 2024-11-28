Return-Path: <linux-kernel+bounces-424593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D79DB66F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D768163CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C42197A92;
	Thu, 28 Nov 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDrB7OT4"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82213A868
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792974; cv=none; b=IjFsU13wZy14kOzJNFBRNnVacsxhd9s2QcxvL+fleE5bHl33ExNWyBMtWZ5+hgKhRtHNzphgU533/zU0hb31WTVg5zWmpbBQ6hqp4Xgfc7hfsZwyK9U4xuUQh0PO1kJAUq9T6Dm9HFasBWA82zfR2oRgaT2xm1TomERJ7XvJV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792974; c=relaxed/simple;
	bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhwOgc5z31jy25sLeDK3raS1pBSsrcwJB4LUYa+ySiav5r1GCfTYWAnITSs6+bvZ9cgTtM1AkBcsquODlUnNaUj8EAqIybNoyQCzoN7DIMhf6hG+I2gT0rEnQL7VWckpXmcgJ3TXBO+SU+uaPQfvpgo+jVXDuHxohmIWPhD0Cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oDrB7OT4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so597715a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792973; x=1733397773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
        b=oDrB7OT4QTXjwXMLO3vsChNb/aR8LxQYNtJ0RXEmS7r93D7TvK+0j4RlB9EJiwzWUy
         gffrqlzRsxAPuLSEUJybAvVcAR9hZm19rG9m2MbSKqywK6Lo7T6C6WSvGTmDhV2UBLGy
         /+kpQZAOIcBBklEQ1IZCo+hvSgTkV7Z6pnir0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792973; x=1733397773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
        b=qpNaEhIEnVPiGFrDh9xIkXeFh87K/cJSt74epqx8S9oM94gtTJ7IHLehnJyvu3We8K
         yMxW5Rr/8hCJl/0uFsh2nzzITI1QSy1rMF28TxmWiOw5pPLK5dTdaZQEJoDGUR3MslEc
         tri+A8mm8r7ute4lza/ZChI68yHVnzxSIQKImeOP3I1QA8H4Uixl1DA3KE4syMnuOOEW
         /r3hN3cM0WFGlDvwNHnKszEi+wcRqb89aPz6pA6yS9vEXCRMmM2sixIEWb4yHv2SdhII
         SeLTgMXmuS2uo38eBD22wWHtW0HnB2h8hCiI9MpDEdiPcKuAUDmJEAGkB4zps7fwKvp1
         SXBg==
X-Forwarded-Encrypted: i=1; AJvYcCVN5QHjTtydXhsRKXfdOIVH5M72gj9s7dDeRGrB8AWUkAh3dLgokFOC/YDaD8bFuB5OOX7DiNjFwdayDpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPRFsJmdpdfx0WW18fKw7Vkj69Zb/RDXctvPiNsWl3qjRsT/0
	IICQwLRoWpSbfq1Lm5T8tRo9Xnhu1RwfeWZRWCak/7wUD9pid7V85FJLRK8w9g==
X-Gm-Gg: ASbGncuIsv6I5GVfnkKMhUeQqyGc3zFG9AFz3Or+AAMPmZ2bPqZRiNoXaUzPQbduiQi
	RCq4XPIbIZG9BF4V6h4fUR/bf0aF3C7mD4Tj1J4nt1iR9E5jJwAAx2xo4tp6QJ3svP3Rb3xVyvL
	Ym6Zt04y3AwavpsZt6olFfJPdsjJezJRg5v0H3V/anS7NrM3oZqqtQv3gMrVouBd20BPv41eGl8
	+lLgp5EZ2v7cBqm20VpldCiVb1S20eW/7IZ7VHFA+keSHShO1FwyQ==
X-Google-Smtp-Source: AGHT+IGSK/XvZKOFB2ex4RHOYZmrSnGwNNSIjBIo7jknMLWkQqro0Oiu2YcbIKyXVIhkOWowiR133Q==
X-Received: by 2002:a05:6a21:33a7:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e0e0aada5fmr8200732637.3.1732792973006;
        Thu, 28 Nov 2024 03:22:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm4336945ad.52.2024.11.28.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:22:52 -0800 (PST)
Date: Thu, 28 Nov 2024 20:22:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
Message-ID: <20241128112246.GF10431@google.com>
References: <20241128111844.GE10431@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128111844.GE10431@google.com>

On (24/11/28 20:18), Sergey Senozhatsky wrote:
> > Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
> > MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
> > to the initial-count register (APIC_TMICT) which is ignored in
> > TSC-deadline mode.

Upstream commit ffd95846c6ec6cf1f93da411ea10d504036cab42 (forgot
to mention)

