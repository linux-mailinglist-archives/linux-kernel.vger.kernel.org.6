Return-Path: <linux-kernel+bounces-253486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802899321FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF51F21683
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5917CA12;
	Tue, 16 Jul 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jz/6Cp04"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B293FB3B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119126; cv=none; b=i11EtgUG03rO6Vu/6B7KN5YN8RMR+4VD3wFEoCqttvHYVcfcr7mLM873bg/wtnvUwcMWGmihoJuUeTcHsh5i8yYShy1ciTA1Zi00iBOBq63gXdPpVTssugoXV7L2/7RjP2ttmYzn/Fy994xTxIk4q+0rjQ+10kYC8T1XLSIdgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119126; c=relaxed/simple;
	bh=0h7QW3c4NgxtfsQNd1VETKl3N3wRohM0ajwml5QXbOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWy16JvUAAsoDdKyYUI38UQbwsKp0Tk1fjPsdjdOZSh7QhVNg3WrbL1O/u0zhBCO0VLPgYXOy1hINdpK8WSPuI3se7AGc+TezozVn5iU50MPjBqulB2deuLd/UVO+TZhmavBXXs2AiMguH8LBIzdbmwvcpslpNeYokegDrhkAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jz/6Cp04; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso6287152a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721119122; x=1721723922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7uH+X/kXufVOwwqdWmlv4iHyPanTfww+ZGvsG9tFG8=;
        b=Jz/6Cp04YHXPvT1TO8Js/lMEtqUWJRyuvUi5XpvjT16WIm4CX6LXJjw/Iyf4pyTVta
         M71CM8PiKnE13r4phoiix0cN79bhHvQIbMkY9NfWIUtmxQ1F1tOmm2zN2w9U7OIeTs6k
         32MOfbTOK9b7Q3uOdYNvcta+cfWGj5APdoGKpERRwsZLnCvvvCirBch94HknswOldzTz
         F7F/wVvC66dTKEcF7En5kXfF1Hzamcd++nKiKAfbz3pyNFo9jSg5RUx/a5sokohhWqci
         pipJldQJ8lq0VDJojQKZ3Er36Sfw6uygcOAc3Ea/2V8EU73aXF3PqSJTmSBMayyGra8b
         svXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721119122; x=1721723922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7uH+X/kXufVOwwqdWmlv4iHyPanTfww+ZGvsG9tFG8=;
        b=LGX0ioC7oFWdJsBQoBfmG9EQBQgZa/P1GZ6C8vgEuc38d/gCWrcOEw4AFu7/1OssEl
         Hkhusb4voTwXzMkoGiva6UOCeSN7woHPz0MXjMV+bbaVUeEjr8Fgh918QsV/FzFMlnMG
         mEh+/DuqAm4RF41Kdz2P5iUpoSLLbbIzZ4dPrA3sPiodrKAVTEy0qE64gBU4EZCIA9iG
         AfE01eTwWQBtl42J8Avyl1gLj8CjVCLmoonNHQRt36zgsLZhzQdHpgOk6uaKt7qW9Nz6
         K5pmOpWytsozdX/ez1fP+E9vb7lLTtdb4Pay/j8pL4BuVGDu/8Ruva7ER2gPogZ1IDHM
         xrcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpsu7lski6JgLEK4MhirN+NRriCRxoFiXmGkS8NMnQ26//u5/GyhoaeeRK5EypZCRJtP+TdiX2ja5tyQy2s+kIFY1JoZ/k2ZKc7PRH
X-Gm-Message-State: AOJu0YzSCtEHQTNd30azmF6/SjTMPvI4dGXdUeMDUwzJZVpa2SOnCvpO
	EZXLX+tHJo1SK5ZswuxQTlZsUwdxoqoeSNDA0s8Tar6RLZr3lMnSC7AStmiatRM=
X-Google-Smtp-Source: AGHT+IHK3WhdLwyoATR7rg7aAkU5WgoIseDDBHwrGI8juwQQ2tOm31BysCr6fu6ZI61YUKWTDUucTg==
X-Received: by 2002:a17:906:a399:b0:a72:40b4:c845 with SMTP id a640c23a62f3a-a79ea9342f9mr105809766b.51.1721119122566;
        Tue, 16 Jul 2024 01:38:42 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7ef5sm286159466b.82.2024.07.16.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:38:42 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:38:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, nao.horiguchi@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
Message-ID: <ZpYxkH1EFB65tEzt@tiehlicka>
References: <20240716033516.606582-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716033516.606582-1-linmiaohe@huawei.com>

On Tue 16-07-24 11:35:16, Miaohe Lin wrote:
> When hwpoison_inject module is removed, hwpoison_filter_* parameters
> should be reset. Otherwise these parameters will have non-default values
> at next insmod time.

There is a clear layering broken here. We have mm/memory-failure.c using
values and mm/hwpoison-inject.c defining the values. Both with a
potentially different life time. Shouldn't that be fix instead?
-- 
Michal Hocko
SUSE Labs

