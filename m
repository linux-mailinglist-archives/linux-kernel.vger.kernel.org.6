Return-Path: <linux-kernel+bounces-345049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E805698B169
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA26282DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F528F1;
	Tue,  1 Oct 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="b0LQpM3N"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05D4A06
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742134; cv=none; b=LbAdhLII8+J3YcgJctM5dsoZnnvMSzZDREMyo2+ypmBDA2InNrf1vSxACNX/muM32qyGAoz76siveZRllL6aNUrfM0dbJYc5/dVUQnRpLpzEIufM4xT8Z7PycmyauD++BLgRPu8bmQIfJ3Auw18YRe2cxy5qkMn1q6eSC+5v7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742134; c=relaxed/simple;
	bh=i6qtBHJubMxW+MCswOYEVYPKlwtQLyoLSqKWdIqtOj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCIi3fxPF713x2mILhrPllergUxP0uECtY+W2OpcNgbgknQnyuEVl4DQavn+h8jmSAtrTYhMsqTaFBdD7ZOvCdBx9ay1zoeXyldY8pNxcGmWpo/NG817FJRXr73PJv2giHoiDXMtOgyjhWiduMbKRKXuRUu/5fdld6Sb4dHOWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=b0LQpM3N; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7ac83a98e5eso431569285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727742130; x=1728346930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmEMUmiLlB6m/T/P5xBRLncvNWoi4hp4LZTs+dQITMo=;
        b=b0LQpM3NXsxmmRoAIDKUmGJm/SzgoFkkzOQbNj1VxxQb69IJ3/Yf00sk+kXXhbDkg2
         HOlBd1KbjYvEO7xa7P4Y+3ogeGBogvWAg6vz5CgX1qj6lytVcX01EVKl9I3rihGeMt9E
         S0/Sx7riPWmlxjq9z0vCWr8IiPH1tb8BkjvydKHsO9Hms73K0gxu63QHh0rfxe6ktRmn
         QBsyxYfj4jgj6A/OPx4fU6B0yGVXdHoDvOgW65HhuwHIQWDPDcVrkkwrDziFy1dukaFO
         kCxvq7i1AhFCkjpgFxFwEoMugYIgzkCwjFWGjseYIgaR3UHc12OKX/xQl/4VOPnF+hn7
         D+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727742130; x=1728346930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmEMUmiLlB6m/T/P5xBRLncvNWoi4hp4LZTs+dQITMo=;
        b=rad8n2MaNVUKJVmnVVvkkoFsa05R5q4yuRovllxOdaB/TyA7qzCkpVbnhZs1hyg/cT
         O2otatSYPw40W/fhhZ9hWoyG0Vkfoc1jAI5VI8AYMxfCPMFEA7wHP0fkvznHQ/mpSsNO
         tjG4kJ8T9LSdN4Hujr6QOB6Cj2d0KvKFldKSdt7yhwr5CJcPNmj7B0+DEzphjRrjUZrI
         /FdigEK/o4OsTfATkMMXItJb9e3Xq/aFNRnFZPVbwhU249kcSlMpXGqOidEL7pgXnNNF
         x4GkBQrMB8rrXvtgSo7F62ajdbEzV8JxpQr7LKg5BMqn4FAyBiirmiOjcni4vdcidoSf
         /bYA==
X-Gm-Message-State: AOJu0Yyjr2cUK7urGx/1sYicsH4ID6Nbh2Wp4TQYOBIIqkXj0IU1h1WX
	dKigZ5a+XpaTVnYrKaFSCgZj2U6etmgx/jxTa/TgfGrmInZVBWntniopxS9VALc=
X-Google-Smtp-Source: AGHT+IH00sGjApfw8Q08fLdU6Khjgn27dLqCwr8RPVTJIvXjW9eQUAC/pBFTI7E7vu7z7LywpcOfWA==
X-Received: by 2002:a05:620a:25d0:b0:7a9:c0f3:6425 with SMTP id af79cd13be357-7ae5b7f92acmr294180285a.3.1727742129803;
        Mon, 30 Sep 2024 17:22:09 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d8699sm455524285a.40.2024.09.30.17.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 17:22:08 -0700 (PDT)
Date: Mon, 30 Sep 2024 20:22:07 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org,
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com
Subject: Re: [PATCH v9 4/7] mm: Change count_objcg_event() to
 count_objcg_events() for batch event updates.
Message-ID: <20241001002207.GA1349@cmpxchg.org>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-5-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930221221.6981-5-kanchana.p.sridhar@intel.com>

On Mon, Sep 30, 2024 at 03:12:18PM -0700, Kanchana P Sridhar wrote:
> With the introduction of zswap_store() swapping out large folios,
> we need to efficiently update the objcg's memcg events once per
> successfully stored folio. For instance, the 'ZSWPOUT' event needs
> to be incremented by folio_nr_pages().
> 
> To facilitate this, the existing count_objcg_event() API is modified
> to be count_objcg_events() that additionally accepts a count parameter.
> The only existing calls to count_objcg_event() are in zswap.c - these
> have been modified to call count_objcg_events() with a count of 1.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

