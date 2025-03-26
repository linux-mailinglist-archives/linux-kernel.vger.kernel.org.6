Return-Path: <linux-kernel+bounces-576649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84EA71270
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5EB3B0C52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD3171C9;
	Wed, 26 Mar 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLbEm329"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8341A3031
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976934; cv=none; b=p2Qi3KKF446sRqwcmCdWDLdYAZFH9byKaXXlFECP9cZlwOx1pLNKlls2Y3gGlXEUNrW5qwADCtt9g0Km3XghbybwdTBBRtosOjk3SBG6u2QuSVnIO4SrCVrROOGHAuxkdoOOLxY94YnLSJdSeGzzB+DFmVkBLXkT+6RtEpUqWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976934; c=relaxed/simple;
	bh=Vfft/mDTRsDLbVS2/jhoaxOyfbKEi1IQm43o7JQHGOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhYznxezaR3wVeUFE47fxTSBWOm4eLk7GUShRN2PSTcKSAXAUgq6UIU+r7cdoPZO30e+Z7u4vm+nPQ5VyIDTmd2NET5YDaPkHlcIyPiKJtmKspSh5M7G8wuiBdmW2X7Jvg9/UocqpxbkaZJT+smuRdx6HzRYs0py5gj4pzmLuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jLbEm329; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224191d92e4so127880845ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742976932; x=1743581732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSh6sM4CX/uhAGdApCocRs0NvZVWU4cH5JZibTSCcnc=;
        b=jLbEm329dd5pssChtes6eyxQnE78M0L4bVdbZFOi5IXnLtYKcfpw5HdKUjZMMWLq+X
         QMLTR/2dEtkXi9JryDi7VGN5+qJMMXzIhQZU5SqQZWKfKlF3SZMxVOKwPLQiO0zPfNZL
         TunCg8DbcgmexKJIJ9e20skZ2EexdpdD+Z+BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976932; x=1743581732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSh6sM4CX/uhAGdApCocRs0NvZVWU4cH5JZibTSCcnc=;
        b=d89tvcTgo5OuFTorAvjrCc0LYeCc+1Ka714Cd5ZjtS25v87oPMYhra4qZZpXUp5QuT
         d2rVmVfHBfKORrzaebEHS4VkfUj9yzRq12E1wKPyTSteqVtVCdq4qb8JrrG11YugK1Wb
         7FKBokk8XfVn0rRlen1w5/uJf7xdlDCqdjj4spLhyqu4bhkuzTmjHprOb+K/g0cStHEz
         JPoJm5N53oNOx3ZJfnLwhoLA+DuMjtGHe0b0Njy6dfAHiIbjBTRlFguinSN/VrAO1U4e
         2x+/3hGkiWvqmKIEmMFqJD0lGpUx602bnQuOyfQGnk2lc5M0xPXLtAPX+/IJRdqtBvMC
         EVag==
X-Forwarded-Encrypted: i=1; AJvYcCUN7JjVuNw57ikpajNhZr55lHa6Cdc3SJWB1dZ5Skl8E4dyVDrqh+7viRMFZyWKUV5V2Iva2OhbF1l6rac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jXn8IIbLaIRio8QU3cZfrhYF/wnhId/nV/e3Mm9hNIhST41n
	9jr3e8VDTXETY2J/oLT7dpMmkF5YQz5dfJAM59NQ616yhPshI0OZ6LPTVqW0Ug==
X-Gm-Gg: ASbGncuIflCZwz/3vfCcBPbjudppFx4X6QXI6e6CaU00lmNm53F50JD8vicJ1HWmF8M
	n/H6psp9NeekRg5fYJiU0JlqWkStFBf5QNNyEFQWWyMHRCOccTqvi99TSnazxDjuO3WQloAvjOd
	NbzIkzYM6cU4DDDfxZj9vsadNeXmR0L71n8137dZxJhZ2qJdNTeKzBwBAyR0JGo1V+vd16M90D4
	bbdEAT67pxIG1TLsUwiJN7U6f9SX+AqUGh7fMEMOpMMKqBihx/kh/qCDz7kaCdA8+bdmM8mCOG3
	vRjvOSaGsrKwaT8tZ5CzK6+fDQZLNGEOGzOJPUlxFlMeVXWu
X-Google-Smtp-Source: AGHT+IGOv3alwV8l9bo+hxjOymPr4w7YqrWTqAkXtFg9QaujLrKdH8qg4kX+8sK6BddXg6ApRBa3rA==
X-Received: by 2002:a05:6a20:12d5:b0:1f5:8dea:bb93 with SMTP id adf61e73a8af0-1fe42f3118bmr37362288637.7.1742976932485;
        Wed, 26 Mar 2025 01:15:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d343:29c5:4565:9d95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab52csm11536233b3a.20.2025.03.26.01.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:15:32 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:15:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: modernize writeback interface
Message-ID: <iiav3vvvvu7lzcl3e2rzfh4kyz6kwymqurncjdsv62wvlge63k@ewgbdmzdnb2p>
References: <20250325034210.3337080-1-senozhatsky@chromium.org>
 <Z-MlsM2Gmxdvl_1D@google.com>
 <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>
 <5l4pjqlgu4afndn3ysa7ynecjmvepkfjlh56ycm5jt5e4mioqm@dujakwaomhlk>
 <CALC_0q9hRAX=46Zd+qh5Pq1myXx+=9gSTT5hu7t1s_Ko4xd_Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALC_0q9hRAX=46Zd+qh5Pq1myXx+=9gSTT5hu7t1s_Ko4xd_Og@mail.gmail.com>

On (25/03/26 15:07), Richard Chang wrote:
> I am just counting how many pages we could writeback per syscall.
> In a worst case, page_index_range with several two-adjacent indices:
> Assume PAGE_SIZE is 4k and index range is around 10000,
> 
> page_index_range allows 272 pages per syscall:
> page_index_range=10000-10001 page_index_range=10003-10004...
> 
> List_range allows 678 pages per syscall:
> page_index_range=10000-10001,10003-10004...

Page index can be u32, much longer than 10000.  With really high
indices you'd probably waste more space on "N-N+1" alone than on
page_index=N.  I'd say index-range should be used when there is
a range to begin with.

[..]
> Another alternative thought, how about page_index supporting both
> single instance and ranges?
> The key is shorter and the parser is relatively simpler.
> Eg: page_index=500 page_index=10000-10001

I probably can look into it.

