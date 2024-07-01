Return-Path: <linux-kernel+bounces-236984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97391E969
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CE51C22882
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A5B16F903;
	Mon,  1 Jul 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnd0B/Yb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E916DC09
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865030; cv=none; b=PHH+diMMNJbnZe1aKVQXNsgA1RfwrV7WeKRmib6AOiH6j2mVboQXduRbilpN2yDB5NsyLKEDWoLWF4ychcaSGk6OEpLuvGNd3eq/ueJUilBJbHYGY2PLRsjUpSsAybBOJbWszMln+BoxFnoSF139uieW/S9GUTwne/21SQ27n8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865030; c=relaxed/simple;
	bh=9WtcZBMJXubPgPMkr8XA9l+MS8Fxyy2wp3MuResS2dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpC21Uh0lS4KsIIxSVSbgSptJHagFbU50luyp0BJt6VR0N/0OxIocZTHDtbiuPkRrfdTZI2Lm3Lkir2JSnSqQmNqA74uYZfzXnPkfM5L3u1PrrH4ho4bteAfOB4g6Ae7QuwqBQ4X99qlcdZQQfcRu1FG6FxF7cGdAsVO/z69+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnd0B/Yb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4c7b022f8so24912825ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719865029; x=1720469829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FFTICpPIkIBdKGgtA5+7smT1E0OW9XyPseCm5bYDkY=;
        b=nnd0B/YbnweyxCCGKsUDY9lvCpLmY+aTEhpZjXApkLhOR4vb2ZZChJb3fex95XUJS1
         BuXvXR6L3jP14EcqE0Hq2T4IXuH+qsG2bHxjkDnyiwQQ/eH58HtQOkRV/UOx5m0UuJBV
         rmqHvB7lrDSXZOUtMRcYEMgxZx7TZiv9pE8HG0+EVvCZvOD7nZcrTL5nI2qtDqsETh13
         GCqTY282Vi1tkHvWBXJCxKFpIWQTVKn+V3pMCpmubIUUQGCqMKcnl045rMRZMTRnpPMb
         AaCD9rFzscnCIG5C8MGeksvGoanXxVyQ79huSHiqF73lsYCQV9SIzYJNDIFhD7rJjEhb
         3Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865029; x=1720469829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FFTICpPIkIBdKGgtA5+7smT1E0OW9XyPseCm5bYDkY=;
        b=grGkaQ1oYJdGO46vmIt+6Vo38gO++OdfMA/AiqyjH1vk5MKtzs/wFXgCb/QDqDr0EO
         aNQ8YFd0/BypzTBfAvIGVbXCbIMIXmIPi7/DnOix85diIh+JbpVgv5zwbo4C5PfXcyKk
         gSw/OBbWuUs+DiwOx0sf3efkf9yZd368hBTiVjOsYQGI3xr8dAS32MIjyAVZWZeyUK+n
         G1DQm99H0mUg84y45V8MsU9Ym8+gS7mXIxHnvvKCJnS8KPrpzwIE9Uy2s9c5YoH3HGKb
         mQ/Irgv3aYgfORhJRJERUMizv6u2SbKFNRgpd9p4kFu16aRwyi5lOT0OucpXrHTN8LcZ
         Aerg==
X-Forwarded-Encrypted: i=1; AJvYcCVcW2Is2w1gALDow7UUbYE5DDiImnqMIRC9a6Wv5htWYGHgO6+FFolOALn4LtwBJDU4wlgjMLDhFsJ4h6JKWGeCf7kDOJsD5MjrzXR8
X-Gm-Message-State: AOJu0YzByVzKtwl2C2YOm9/czqSuNdbD7ZFiwVfakw+DkY2UwHFcp4is
	l7fVVdFvSRNXhkEp6ZljSg+ShNJkgoF7XNwK+GEpwvfeSB2PhdXg
X-Google-Smtp-Source: AGHT+IERlfmn9aa4EX3JvBUAcuLhAHi52io95Gz5BQo1xMmnX/571Xy/1gDdRlef/wZpWbSfjnU2rQ==
X-Received: by 2002:a17:902:f685:b0:1f7:1017:b2b3 with SMTP id d9443c01a7336-1fadbce7bfbmr56514555ad.42.1719865028595;
        Mon, 01 Jul 2024 13:17:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596657sm69180565ad.255.2024.07.01.13.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:17:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 10:17:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/53] Let create*_workqueue() accept a printf-style
 format string
Message-ID: <ZoMOwkiLx2KHYHWa@slm.duckdns.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <ZoMF1ZydZUusxRcf@slm.duckdns.org>
 <63917f94-d9ed-4d43-b0a8-50ae4afcf1ee@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63917f94-d9ed-4d43-b0a8-50ae4afcf1ee@acm.org>

Hello, Bart.

On Mon, Jul 01, 2024 at 01:13:57PM -0700, Bart Van Assche wrote:
> The create*_workqueue() macros are used about 270 times in the Linux
> kernel (the macro names also occur in some comments):
> 
> $ git grep -nHEw
> 'create_workqueue|create_freezable_workqueue|create_singlethread_workqueue'
> | grep -Ev 'Documentation/|include/linux/workqueue' | wc -l
>     271
> 
> That's too much for a single patch series. I can start with converting
> the SCSI workqueue creation code.

Yeah, it's been on the to-do list for a long time. Starting with SCSI sounds
great.

Thank you.

-- 
tejun

