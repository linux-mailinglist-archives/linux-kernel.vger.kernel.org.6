Return-Path: <linux-kernel+bounces-267916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F77B941B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF850282482
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4A184549;
	Tue, 30 Jul 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Cx+wfKnP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117D18801A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358575; cv=none; b=HOLvpm/Yc3MlNf4VeuIVRFSmz3liKeu3RWHYLvoLZKnvm6l6Az7GIkTgwvsyawYPY8SLl9l8XROwJ3euj7hpJZnADZOaZ9coTuH33vNHRFyqfn0wMHAmY8t+HtSN4AUhCetjgiGptcsSr8eNlU+CvOi0DWnmJwR0rh8uzaHr8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358575; c=relaxed/simple;
	bh=hm25pYgs464Ixmhmvvyc8Gq1HWeX5HdgeR2KgGzZUDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUPRfe35uYgARMJm7oUi8lPVZC+Ewr3pW7VSEHk+qZ7EGJdnqCpWyrHW653W4yJZZEWlLzVRjMqUpXznyFTvxfUFjDnqmluk85KRH3pztQvY5tDPvsGgeInE1JCPxoE8vtWuEOLi7qQQ92AQoRMRX36Ildi5GoPlFSKJgdMwr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Cx+wfKnP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66493332ebfso32870117b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722358571; x=1722963371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=242jaByKPfn8Y8xWsCYwJvr/0nFEia3sgGdcNttEbXY=;
        b=Cx+wfKnPeVaeybYoGzmugEqsCJmtSM7Gv7NcFxInzVMEji13psBQ+IGvAbJI28oTTg
         hDuIilboSKSaqovILBPEhRKE35juGES2kTk+/1bStPGNBsF+g50Ck97ITzWRYKR8HHIy
         ivrfMSAra7u9cH2GOwwCTzFgMENR+invgD5C1hpws0sgiJ3+CNWpsbF2KkHXYDKylXNe
         45a6IQDgvvmzc6w6j99hb5G68xmACXHZoPmJhjsvpVTJkp/Xkgy67d/vbGGaEG7KOw4q
         hQlbiATdd9C3fDTyu/dXDr+bB+Ga/NwGCS+8flDvzZ0LJvfLYHnd2WCHOEeSLofsf3wn
         iS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358572; x=1722963372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=242jaByKPfn8Y8xWsCYwJvr/0nFEia3sgGdcNttEbXY=;
        b=aCqyVnWMzBVdG/t4h++btQBajSIEFfoF2KSXbcChgpvwr+D9Vy3K/TDcwZmkOf9njw
         jSbmuuPOyhFeXZ/rIHqvPP3+cQI82wUyqTv12BP4lZ4XB8Rm0OkW0DgFXZBYcwXn2Uft
         Gtm3pLuCWGRJY1mi4KBkCorPocM9ArR8TBZaA20gGeK+M+hkZapOT+oELXNdQSqVYnNY
         r1+F4pxHmwjEhRgWpEEpTMbTTR77L9TY6TppMUG00HYiBbbGfwtOS5x8nw9UFDOFFiMd
         958axd6wsIAJTZuCPN0VLycHr2PZKd1sLWUcirxSm0wnvgiknjMipBgoWB504pQo8L8d
         hGJw==
X-Forwarded-Encrypted: i=1; AJvYcCU4V8IUMxb0IsrW4OR+WSXZVzg6zGzf5TfO9US+DX1o//r5h0tDo8FTYgVtCQ57cWpRyyJvBWqiT5wVdXzPEj3B+KncL6ktkOIIh/kG
X-Gm-Message-State: AOJu0Ywov+hItIzgue68Apn8rg4DTbMySpiowFdwyDuuRM9jWLsYvM4Z
	/c2StmKqjAN/DksMylBoHqW98n6bXo2HF8MYy40ZNlO0bye1Jb7t31qIM70/CGI=
X-Google-Smtp-Source: AGHT+IEtVH3jrcsnmwnTqzQKJIiPWPoU26jH2qk9/VMRrXXucUEoicVRBFzUGjQwdElc9aL4PVDOsw==
X-Received: by 2002:a05:690c:d92:b0:652:5838:54ef with SMTP id 00721157ae682-67a0a9ea615mr196342597b3.37.1722358571653;
        Tue, 30 Jul 2024 09:56:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44d4b4sm25749997b3.142.2024.07.30.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:56:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:56:10 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Johannes Thumshirn <jthumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
Message-ID: <20240730165610.GB3828363@perftesting>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>

On Tue, Jul 30, 2024 at 12:33:13PM +0200, Johannes Thumshirn wrote:
> When doing relocation on RST backed filesystems, there is a possibility of
> a scatter-gather list corruption.
> 
> See patch 4 for details.
> 
> CI Link: https://github.com/btrfs/linux/actions/runs/10143804038
> 
> ---
> Changes in v2:
> - Change RST lookup error message to debug
> - Link to v1: https://lore.kernel.org/r/20240729-debug-v1-0-f0b3d78d9438@kernel.org
> 
> ---
> Johannes Thumshirn (5):

You'll have to rebase this because there's some fuzzy application with the folio
stuff merged, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

