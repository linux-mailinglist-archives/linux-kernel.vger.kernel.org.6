Return-Path: <linux-kernel+bounces-204744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375E58FF30D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E240291A66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C66198A24;
	Thu,  6 Jun 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Y+UiuEJa"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA23224D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692930; cv=none; b=s0h+xwFIwGmhIG+PJ3AkrQiIFwL49E0RQtjmqqrzpKqYgYhaAmfbeq3u4v3ExzzeT+iip61wp6II6Y/s666o6qfDBJ8ndxaPBgM3to2vnnofHC0IIRQ6P40X6/XjKPoSGxmnoQluTo4hkHWi1naeAm2UkHpK81GXezwlGSjlF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692930; c=relaxed/simple;
	bh=KTrUqKBUpH0Mm1aODNcIi8wBFSmZg+Y2PeTVu9TDt5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSkZuIppxvjP3iTPc+FUDgPFzJu6/cjB2ck0HK6wnMrR5dNr/zo8+NhmF4hf7C4SUCxCGw0IMyLmGeV8rVhtC8Y7l9e2ijz+5lCVZvFYXOjN8ANMkOBPixX3b/3xKPBLdH3a5FOjWcqvpktM1cwm0rR68pecE0TESy6thQiX9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Y+UiuEJa; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48bdcecf6efso431711137.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717692928; x=1718297728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUPZxIInBjcxKQlBtN09Qd7ziC4/bG6TE0zIAPn/5Rk=;
        b=Y+UiuEJaCYFaEToMP+XPr3WruoQ4Eoywa2E9lk4QIF16otloJun4HgQlUhYJkyd5uI
         5wdGFCMV4mf+mW+/8RwwFe3Y8t35wJv1BOKMK1AW/Ck1mCSnjUAEJfDEuLfHYjexsZjs
         t28cm2xR22WmMXlmNM1HvRkzm+HenAmf7NuAb0QtZSCTB9CF8CFQLvnBQxVQ72f0tIyV
         OENPau/TbMWiSCqUoe6Jh2mBB0FjsHz5u/RUSgv4zwruGD5PQgdCvsYUkYqx19s8BwR3
         ANZICZFS8xIPVbxKrBB3h2nkXjLy3HJC6ft/EkGF9v9cX87egvRNZXogXc8n3Xp1mSYb
         cToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692928; x=1718297728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUPZxIInBjcxKQlBtN09Qd7ziC4/bG6TE0zIAPn/5Rk=;
        b=eXgnGjdxAyaNfv+/RLOC+ipYPOtv4e0d/5/OTRXOmKpFhgfUhLt3KJ7W3WaUPySR3L
         LUOITVSJhNWHe5fjh4Zzauoaku3bpQ2Bg6M/4kWqHPFxgu0im0XeK2I2Wf4a49ujHJqR
         Qcm4bVi9QZ3SN1QsLUocKblm7He0WTerSKDY2RvV0vp/HRi6nym6wolQju8Y0hc2i/er
         CeySARIB9VoKHNmNoHgSrFmVroXNa7piCUCFODhoSNWig9gEKzNjC9E7Njl5EOzlXlXT
         Odxqy41cv3BR8P6qZhnw1mKALJsAOxNN+AGfgUdrbRJ5QuqVxVXsirsuPuAxUXGb1c6P
         Ev+g==
X-Forwarded-Encrypted: i=1; AJvYcCXTJqkUfhzrFZuF13EGr2q0Fe9gyJPF7l2ghC0BeYTxBP9+/vYhHQArpSYZdTjaalgf2yFZnXddMKWzYISz8B7bcbGfygExP3tpR/ai
X-Gm-Message-State: AOJu0YxHYs+P7vUzSgfx+wsFxpCu6oCLjw5CbGHiZ7KfbZLc88wlrxuI
	mnX46H8ahjmvyiYhW7UxTpVyNAEHGKDPZJCLPnp1hpX62DCPXatzLXNKPF8f/rA=
X-Google-Smtp-Source: AGHT+IGBx3EHtBbeQj5AhyQMHzXZnYKlgnkwCjKTZpsx3juTah/BT8rtvkai98tYmjAh+9vzT2aVhg==
X-Received: by 2002:a67:e316:0:b0:48b:9bf8:9d3d with SMTP id ada2fe7eead31-48c0493d5d4mr6413320137.22.1717692928437;
        Thu, 06 Jun 2024 09:55:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795331d37f4sm76383285a.121.2024.06.06.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:55:28 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:55:27 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 6/6] btrfs: pass reloc_control to
 setup_relocation_extent_mapping
Message-ID: <20240606165527.GD2529118@perftesting>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
 <20240606-reloc-cleanups-v2-6-5172a6926f62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-reloc-cleanups-v2-6-5172a6926f62@kernel.org>

On Thu, Jun 06, 2024 at 10:35:04AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> All parameters passed into setup_relocation_extent_mapping() can be
> derived from 'struct reloc_control', so only pass in a 'struct
> reloc_control'.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

