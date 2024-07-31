Return-Path: <linux-kernel+bounces-269288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498294310F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9494C28457F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3331B1503;
	Wed, 31 Jul 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOJebqyI"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE516C86F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433121; cv=none; b=qCjctcRkSkJO0O8R8l7eoUVmMsVtg2GlcpOfRzpGXbXFtagHGExcGTpgIUmaCSCKwolatWGYv0mn/xiRJbR11LRl/yTc1O4/Tsq+cK7XbRMxsge9UVZIM0kwrMBvbpWTmeRcuaK5bRGV0DQCjjNk9OWxNQSxEdfn4Rm28oprdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433121; c=relaxed/simple;
	bh=lWz4IuNHPvgccwHkCmERzI9FsAIAcvpkr870H2MJCVA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgi15mF2CPV+aczfXpnmqv3Jm/fYot+5k7lX+UWR3J+QrwZJ7iDm2qIo1mmMuhi1oQikvM2nCaxjsu83oqt0l2z8l+aC78hS+8y/xxvZw47s1eMVNTSh1QaswJmbpk2DZrhnSzp6lt3mfyKPkLkbYrFBUUaX5vAnabr04/50clU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOJebqyI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01b8738dso6027214e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722433118; x=1723037918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwpnq5JQONtzTfLThmmi+tZ89yGgnZ0Q1ptTZ8E1mOI=;
        b=YOJebqyIYTmk8WMiLfw+E5EzcZgy7smIKubO0j3UNbHI9OrEx4dwhgaUXLK8AQ4DLf
         alLfGS5orKkRMcpiaCoaly1UJlOuoiWcf2zH1eukujTJp4cYMWPpnYEFJshVq6DhlFwE
         bXL2nIQ5Hh73KyNwpRbHakNuIDPvjoT9gLTbp0/mrtclOqXBanP3i0y0njS3CjWm8t04
         ZJ1I5L0p/IZnrJugtnGD0ypJ6QJwqFfmeFj+fpaVWlFj3HRMhms/6A03ndcTCL6AORXr
         Vw/5tC2UE6tri6xFEigFcPRECI+zwzF62qCV8L7IqA34IFaV8dDVmCuGpUd+nEIDUgon
         XUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433118; x=1723037918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwpnq5JQONtzTfLThmmi+tZ89yGgnZ0Q1ptTZ8E1mOI=;
        b=mUT4xEgwPpSb0PmYB0HkeRgMnEkS37S1HFoBxVexkwP1zwNt7JzWY7+KJd4udnjdXc
         JUPCWms5mGbqkAw/Fl9VSXOCemFHnq+lT0lFLD6n9wdjc+gy91K8DgoC0DrH5EOgA3fI
         7uJ+kimu1f6iehOd6IQxn2p9C8ANvGCSF0sdU0tiXrDULDMgJN/I+GW7uOEiziRSh3CY
         00DsiMmJtJ7BnrDRhE89R/yVqUL6Fep/ShgDAhLlvkLKuHEqHEVLb8qBDld1aMVoWvoX
         6kLnqyu/Nmnz5tVET59rGn1oPgT+o6H6KXOLgifndR1oibTNLtI7JoTEm8sB56mWcqsa
         /0TA==
X-Forwarded-Encrypted: i=1; AJvYcCVk4ZiBGwjJLZaGQfCrRzDHlfynUeLueHNodxtXDBzFzV81b5ca0mBrCluYRUzmF5QZTaEDkDeUdyewOxgLy4Ctqz6Yw8Z0rDzKmvpk
X-Gm-Message-State: AOJu0YyObqBxPPMUF6nRC8DU2EVjz2jwJxu0iaNL3lUtmORGmIHcz0jo
	1XHf11SchT0MrjIPrtI/1ol0MKtLKFJ3hdhYN/isat7wkGxeET7y
X-Google-Smtp-Source: AGHT+IHfkbFd5HARRTjT3miPWSz56ECI7BGqSkqefclGIkCEfxBOwePX/RTR/2e+eH1+X3Za93dcUA==
X-Received: by 2002:a05:6512:48cf:b0:52c:b008:3db8 with SMTP id 2adb3069b0e04-5309b2c2a68mr8829423e87.38.1722433117216;
        Wed, 31 Jul 2024 06:38:37 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0bf6sm2273906e87.67.2024.07.31.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:38:36 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 31 Jul 2024 15:38:33 +0200
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, ahuang12@lenovo.com,
	akpm@linux-foundation.org, andreyknvl@gmail.com, bhe@redhat.com,
	dvyukov@google.com, glider@google.com, hch@infradead.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, sunjw10@lenovo.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of
 KASAN shadow virtual address into one operation
Message-ID: <Zqo-WbpZ9zmYVLA2@pc636>
References: <Zqd9AsI5tWH7AukU@pc636>
 <20240730093630.5603-1-ahuang12@lenovo.com>
 <ZqjQp8NrTYM_ORN1@pc636>
 <CAHKZfL3c2Y91yP6X5+GUDCsN6QAa9L46czzJh+iQ6LhGJcAeqw@mail.gmail.com>
 <ZqkX3mYBPuUf0Gi5@pc636>
 <CAHKZfL1i3D7wgbdLWz3xiK7KkAXAxrsyQjFmFarrM94tJPYh3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHKZfL1i3D7wgbdLWz3xiK7KkAXAxrsyQjFmFarrM94tJPYh3Q@mail.gmail.com>

On Wed, Jul 31, 2024 at 08:39:00AM +0800, Huang Adrian wrote:
> On Wed, Jul 31, 2024 at 12:42 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > Thank you for posting this! So tasklist_lock is not a problem.
> > I assume you have a full output of lock_stat. Could you please
> > paste it for v6.11-rc1 + KASAN?
> 
> Full output: https://gist.github.com/AdrianHuang/2c2c97f533ba467ff32781590279ccc9
> 
I do not see anything obvious. So it means that CSD lock debugging should be done.
But this is another story :)

Thank you for helping!

--
Uladzislau Rezki

