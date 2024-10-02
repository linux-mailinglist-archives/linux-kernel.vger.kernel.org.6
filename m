Return-Path: <linux-kernel+bounces-347404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2A298D22F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398DE284232
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF321EBFEE;
	Wed,  2 Oct 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJp7kVRu"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82F1E7646
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868342; cv=none; b=bxuN2fblUURI9bR9V4HC0I/hbM5U+8f43C49JFl3Zkg2jJUxxNJD3jsQ8DS/GHZqdXHXKBlqx8AvbGNbSUa8hNPk93mFDW05LiFOk8pBfTIQ6OSMTbtTiQcQq8aGjPEwxYj1Hs7PoKzS7smFuzlNPdKd1jVpaQhOG5PBYKd3j24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868342; c=relaxed/simple;
	bh=+ji33y/UBdQo/trFXUgL/SbYVLsbILvrrYA7MxlKHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxcjZj+zzAul+FqlZ24IlprM1XqfKXW0lizbPywqlnkUYOM+JDlaLihEkD1n2uhwRfwsRGnt03FyoR9DnPtTtc55NueLfFIVNRgCJy6IICikA93/g9YWmg1aOuoZIHAYMcKaEaUPZLecQxxueZDSRGvcKngoENV+ZrgMgdUYMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJp7kVRu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccd81de57so481183f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727868339; x=1728473139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh/Ib6nbjDZdX/dSTD6KdOyTsxvhc9sc4GJADx2Wx10=;
        b=xJp7kVRuO/bVg8QrGMlhM3hEfAHWP9nzanG8lNKu0xrzgOnE+05kLNxAS/+oDPa7+c
         AYwoucM9XKC+8viMqLE8GHuRFQ8gKBfEOjBNyLzGggzY3b+Yx8aWxt1WnVcDcuhdG/le
         AbW00e5vRqkZEcugBb/Q3GvXeRuhdLQAPloC9865IxTI9F9BsFTPC8cz9t+OsnSY03Be
         No9NxOmE7tq4yQuyvq/7w3WunhLRd31R3HFGMDEWv/5+ehqiruT0VIyOb03h5NxUbvpu
         97pz26lWAnTHHLDaa3wkahVEMDI8fHlG1YrWRD/EHYVLj5D8V9eobWZUuHHo+ZSsOhie
         BS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727868339; x=1728473139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh/Ib6nbjDZdX/dSTD6KdOyTsxvhc9sc4GJADx2Wx10=;
        b=o9soNBELDSqKvqs7s/KBLVIiraL4leFzbunZZisU8HWYu7Bi+qiea16AeS2TlDKGGu
         8hW2Tc0Ht04e7r44J9JEMTU1hfvyUbcpneoMbGi4iGmUIlAN51mRNXunAPpXohe8SlPt
         8kkT12piLnt9zbpX9nbRDoiAzvhB4nmMFvEHvADnmKnNMJzHU4bc7SkUJtuTmz0bSo5c
         oo0cqCUSQAEqiDAD625u87D1GBkxsk+J3IYXNFlF8GDdklckzezQqj9VuPh/uXrjqgvD
         8FQ95F6axeiODdYq1oB1HL0Wv3bPRDopaQrGiWIMnPQbWI75GkaHRWF2U0gG3j+jVbmE
         v1BQ==
X-Gm-Message-State: AOJu0Yyjt9RgOBItoCZwvyyBx0BLt++lgfvtP7UAVsTQGZQ237I0MXkq
	eZZc5cQ8zYdNlEMNsQldSK0P43z1FgISb2NwWz8Vr8xtjrDQfDg2W3gCX+yfgQY=
X-Google-Smtp-Source: AGHT+IGHSAfjhltaRCpdcuYThLNf3RBIpXaHC0k14SaD4k7m6OtQWT5Y8bq23oOSq9qN+wlcJZFodw==
X-Received: by 2002:a5d:59ac:0:b0:374:badf:3017 with SMTP id ffacd0b85a97d-37cfba36371mr1270807f8f.33.1727868339227;
        Wed, 02 Oct 2024 04:25:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cfe30a3b4sm1145917f8f.13.2024.10.02.04.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:25:38 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:25:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Kairui Song <kasong@tencent.com>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
Message-ID: <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>
References: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
 <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain>

On Wed, Oct 02, 2024 at 02:24:20PM +0300, Dan Carpenter wrote:
> Let's add Kairui Song to the  CC list.
> 
> One simple thing is that we should add a READ_ONCE() to the comparison.  Naresh,
> could you test the attached diff?  I don't know that it will fix it but it's
> worth checking the easy stuff first.
> 

Actually that's not right.  Let me write a different patch.

regards,
dan carpenter


