Return-Path: <linux-kernel+bounces-182917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E48C91AC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9209FB212DB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B145028;
	Sat, 18 May 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkEikk6Q"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80585380F
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051274; cv=none; b=W7o1uKBih9eCIwus+VM5NDr0o5y7d4UAvMNmRCs/f/sqRRIX1s4gG5G3S0byCYbNg1aXuAmp768mCZQdmr4p+YLlbABd2IwARgqhyoF2YrVPfgxXDNmknIw9DbuhOveLwvQ614FpwpH58uZyooZe7YrvYunsHbQcpdteHSJG6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051274; c=relaxed/simple;
	bh=Cy6QgkzIvtwsksNyfer6Kzitx6I6rlqiDcesoICXdK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7MzJihWvzJRIAUV4ugQaIRyDi6a5ruYZwfU4S0cUhLa21bDxhD9Xe12EKFgNxTgilnlkNSi3M6BZL4ideSSvfipvrbtXX5dKM7A+xbNwT3gDbOvoSorOJTQxIK4chZjUwEnRElCH3XfVnqwwAeVKjHVq7ClXjxOchB0S/TPM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkEikk6Q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-523b017a5c6so4520813e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716051271; x=1716656071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy6QgkzIvtwsksNyfer6Kzitx6I6rlqiDcesoICXdK0=;
        b=HkEikk6QlWpDqyAzvbLR5eEgMqXn/9BOPckhVKAOOBF+hy50fhjlK18fcGJDfk/2mj
         7wFWFmj9mxWOhfwueN6V/TdPxHJDc3k+lE/73tCbjzeMrG6QfeNE82/816NjzoksdZNz
         NWqfI1VAW3B5Qej5lgD2PxvoeD4Hps+iF13IIBhVHkHgLL0gCPKltPsnl2GDYad7FQjs
         RwROp/+FAvTau11RwyR0VM6Y2kdTqY1WyYDwqi/rWvZhEGdkp1W2CwpKbirp08lz0+lN
         x0xI0Y8pkN5nt2HUKNqwrqiWnmbz5WtlHtm/qxW0XDdqndE2LuJbcnejojvTqiFz69n3
         sxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716051271; x=1716656071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy6QgkzIvtwsksNyfer6Kzitx6I6rlqiDcesoICXdK0=;
        b=wXcfecHScAmpn7AvdPNyaaVYQLJsZiptU/R91A5pRpiF4Jgd6AHfkrRFg4bM7jrzYN
         tENvWUJTK2W9MOq2YT1jyRX9Rsbro59L8MBqqgJ6huyqowIKb22dMVkEU3RIeG7ZCnJe
         aOT3adQyZTf3o3tq1l/QKnkT3gsNXdKAQEa1reA9+L9MoQRnHvuPL7Y2RZBsHarx3FWC
         YAlFPm2qc3E0qfjMrq0CobyXWgKaAFnkY4iRRdLxYGmSYnWAsybZaBoezz+9gXRLqS6B
         4Ku7L3Bt4qlU+ewrOVVe06dOXcliMxpWIxrMpkH8YRfBE8rA4FTYGnTDQ8Kw5I1zHQ7q
         CDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURinM5z5Wl62AMnWiUiVDpM+Ikl02ReCBO01163XV45CrGFyNPxt30rtIh3D7El6AW5zlu5kZb0xQuLj7TiA4G63eWORuwcvZzWd//
X-Gm-Message-State: AOJu0YxbiecSkrFsNyJHqDFBbY0pUzvUN5uwS5pPSKbQwz3g87j7TIFt
	DiTD+kXiWjtKXdMFdmv+RmRUw92qvTy7uqqk+rUgMsi8xpdS3LIo+DC/lG6AOQ==
X-Google-Smtp-Source: AGHT+IEj9PS4XH++4fkHqJu7SFk+C3GRcYiC3Omjx7f7BObd1OIJALWJ4dwiSMIoyRyBJbodRxH4sw==
X-Received: by 2002:ac2:4181:0:b0:51f:36ed:ee43 with SMTP id 2adb3069b0e04-5220fe797bcmr18519511e87.31.1716051270699;
        Sat, 18 May 2024 09:54:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:8b68:8208:4316:d53b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad4basm3605671e87.59.2024.05.18.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 09:54:30 -0700 (PDT)
Date: Sat, 18 May 2024 18:54:26 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v2] Add a trie to map quickly from address range to
 compilation unit.
Message-ID: <ZkjdQqN1dPsZDDRA@google.com>
References: <20240518165315.3963142-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518165315.3963142-1-sesse@google.com>

On Sat, May 18, 2024 at 06:53:11PM +0200, Steinar H. Gunderson wrote:
> When using perf to profile large binaries, _bfd_dwarf2_find_nearest_line()
> becomes a hotspot, as perf wants to get line number information
> (for inline-detection purposes) for each and every sample. In Chromium
> in particular (the content_shell binary), this entails going through
> 475k address ranges, which takes a long time when done repeatedly.

I accidentally sent out an ancient patch anew; sorry, please ignore.

/* Steinar */

