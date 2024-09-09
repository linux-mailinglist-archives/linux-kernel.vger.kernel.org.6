Return-Path: <linux-kernel+bounces-321930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16697215E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CE31C223FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0F17A586;
	Mon,  9 Sep 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzG6OhS3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42B4C74
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904365; cv=none; b=FJcLW0kOYhEa7GgTFhz/DOsCC/cC58G537zC7EO80zFxHmrbfdg3wIAn9UmIXizffBmqa+BB5FOzIYjpbo3vgUBAklrua817NsrOSSsAgw0xlZMuL0ru4oZKBQqtPaU/BUuBXl3hIOlt681CKQXmY2EwaNnQhGQjgU6v9AWiy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904365; c=relaxed/simple;
	bh=XEMYZ7zylliE1DrdQwwkhySnNG7R9QcscC/tec9svwY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Mw4YkL+A5nL52mwN4IHO8DBQO5jpBAv6KhXhYyjqGU6oFfoeHc6wBBNstan985XpVeExgd8kOZPLHc8PA8ebYhIfjXW2YWnOhQlsE0N71XrmfmHNH/HoqjOOJCHEXiNsuArrIHP+U0KIPw+RvI86n0XyABAsRByBokFhzc4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzG6OhS3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5344ab30508so5244775e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725904362; x=1726509162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e60WACr5wMaV0x8+q92ApCB8ruX2ciph8OpfU82ymdM=;
        b=CzG6OhS3gk6J6jeHmcqVJs4TOt0anfbyLXNhmpDzU3D1sIxqICcu75+sU0KdhNIEux
         NPt8FRDTpiIklsM5TZuWiibxrM+b6MfjYN61gpQUN47ikxFGB4NjC7nDgqguJyaNa6wQ
         NHtTodo0GcK6vwcTu9X/cvdyBlquY4a+SpM18I0W+ZD3p+8fnAO3aKJ3ZbZMiiKqn/bC
         k7qqoAUcq5hUGR6UyYBiK+YUiApxBfXTZM3ahzthRdRnReABC6mm6buD5PNJT88+xaKc
         eF1lwm+SPEicffhik+89iVWjj8HfRRIfPVCV1EzUUrTrb6DVQV9hInTb7BuUW/9udtjU
         k1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904362; x=1726509162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e60WACr5wMaV0x8+q92ApCB8ruX2ciph8OpfU82ymdM=;
        b=KWrEPjMbG0rdQLtG0MLGGmrpt3nr3/DNJ7X6lUtWi8riAqMW2NDhxK7kiT+c/eJGRF
         uvrVVnl1eaSDE1UzrwgFwtFtqUXYwu8KGNDz/13mKHO7L6la41UfQnjqXfzTGel+J/kc
         AWzpKNyGY9KjnE0wsqvNbRsgSNsUpSwf0CWkGAU4nR2cbo60X1bihKzk3N+OQCZx5BT3
         tJjhrCkn3a5tAeEz7DGnRyAa9Zg3tIpnSn2RF4o1gfutuFHMATk0svjkWzXwe9s3o2+Q
         hzIcGET9r+3jPg9moQhksHZEVDFS/GtN2vMZonvc/8haXbhDioIsezGSuxLYPpPGeej7
         ewmw==
X-Forwarded-Encrypted: i=1; AJvYcCVR5+GyoDzJa+iiQDB47SA1V2W5DrixENugeFtEutQnPyjk+JoC8Yoox5+hV2vdIc8a6zducoLEG61MnHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyY1Ssq+eGUR1LlYAWge1MNzrnT0xj3TxBOrrghCRajUj2idS
	9ft7xQy14BF8nM/0vVYk6EOHQ1X/xbxkVAKSlvQVCExRwSzi6B8G
X-Google-Smtp-Source: AGHT+IFDtaMKlVLzoxah6gErN8HAi0f6takSCdF35p37nokYdMt91P2R76XNsN+Oi17v+r4RvxaxDQ==
X-Received: by 2002:a05:6512:3051:b0:52f:441:bdd6 with SMTP id 2adb3069b0e04-5366b7d4cdcmr168105e87.0.1725904360823;
        Mon, 09 Sep 2024 10:52:40 -0700 (PDT)
Received: from pc636 (host-90-235-20-248.mobileonline.telia.com. [90.235.20.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f914008sm845371e87.304.2024.09.09.10.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:52:40 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 9 Sep 2024 19:52:37 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm/vmalloc.c: Use "high-order" in description non
 0-order pages
Message-ID: <Zt815f8dHOKdAeiY@pc636>
References: <20240906095049.3486-1-urezki@gmail.com>
 <Zt5j+c/SUNvCMY/+@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt5j+c/SUNvCMY/+@MiWiFi-R3L-srv>

On Mon, Sep 09, 2024 at 10:56:57AM +0800, Baoquan He wrote:
> On 09/06/24 at 11:50am, Uladzislau Rezki (Sony) wrote:
> > In many places, in the comments, we use both "higher-order" and
> > "high-order" to describe the non 0-order pages. That is confusing,
> > because a "higher-order" statement does not reflect what it is
> > compared with.
> > 
> > Suggested-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This looks good to me, thanks.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> By the way, do you plan to clean up the rest of them in other places?
> 
urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher include/linux/vmalloc.h 
urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher mm/vmalloc.c
493:     * nr is a running index into the array which helps higher level
urezki@pc638:~/data/raid0/coding/linux-next.git$

What am i missing? Didn't i do it?

--
Uladzislau Rezki

