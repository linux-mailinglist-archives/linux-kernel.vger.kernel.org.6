Return-Path: <linux-kernel+bounces-442283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A09EDA30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4A283E69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FC1F4E2B;
	Wed, 11 Dec 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nplhLgUr"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BE1F3D42;
	Wed, 11 Dec 2024 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956409; cv=none; b=VJUZP7ub9qVGNT6EOHUHWYHtModXB+6bzx51qWj5+zVlfed4ZUjwVNZXjUqVVIUIfxaBjHrVOYXfOvKMdSHSXJQ8HKQ/w54iy2pHXEaUZSOSWaZCwR0c3yT+zyM/pA+V4NewsjfsbOJKxGyjeMrtjD0zBhvo5XGn8CnHSsG5Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956409; c=relaxed/simple;
	bh=hJzLzUCdutP40QODZOuWNWc476NWXbIFA8vEAw6MtLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl5CcwljOQYzTtiLZuFtllNkHcr8rTwcP8UJ7S/x05DPXvjMq7/2nsLRSarmLO3/z0lSonF8CaFf4E0umg+c9UlSxzRChODBovw+mYRRK2yMjkx3wWMqdc5z0n+gRcN8STPk+BZfYpZlZOeI8bAHsjK/QV2vSU9RgPrjt12G0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nplhLgUr; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3982e9278bso6142088276.2;
        Wed, 11 Dec 2024 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733956405; x=1734561205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OesgqZoKOnUmsMZ0y45VbDn9q4aedLqh2tLJxCl9AN8=;
        b=nplhLgUrHyoZRv00/2A0T2FYK+28H1kA9+3ajiPm/9C+fv2o2ym0hGSa2DeJwwW0ip
         XCEV2tiXsmAeSRj+DuAkrbzhE+zVLHnd91uoaeJv/tOtmrpdFNb90APsYhJBBB5Xqy5+
         2sd03ac2ubiZ2dsGHtg7NuIiS+X673pq97pn6pZGz5kH0oh0NEBhbhR+ig7liIBTaEZh
         8RjHuuuJw2yXBvzFCPioT4pBXw1VMFq0U505O7gRL0ec8p1ttFAB9vw3n10oX1h07svG
         lLmq6Cm/hKfnWSUrxc0hDvvOdmYn3lBufQwWQnbjzl66+ulh1M1BlqDT6EcsbH+Lscye
         n6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956405; x=1734561205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OesgqZoKOnUmsMZ0y45VbDn9q4aedLqh2tLJxCl9AN8=;
        b=vM/zRgkCRG9/RhUUIvu8ogahVgPrbE6Jovbl32CfkKmM+PJf2V5vFSAjxZqW1+oU1j
         2OwK8Wlg/TbiRa60Ui3doZDl3I26T2qN33TCr8Gf34fbjyU98IxkbzVoZlyzV2MlmEgM
         aDZ4bXcapBzVjasmBk/igAldpNXBK/1ELPodvZtTT3mxXPzO7GK2P1+PU9gqxaEzwSt4
         JHJcXW5fkAbqSqQ8COF9XHzAYtPNwA+bnTWnZcbzefzkdsk7StKdoMN9Rtq3mwyUN4/g
         cxDMRKaiXc9xN1vGqzn0dZNWD3s9Qf+G4dpxvIlI0YE/HdOiAej6L+m0cuTiQEUXqjk3
         ZG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwo+vQh1GT9UVk7hE2sRGJ8PBkGQUCRCwD0ygQhFSL3fUAc1RHLTC9LTtzP5TKTqhBMK+wj9JbYqAHZcE=@vger.kernel.org, AJvYcCXWr1hkNkA5vV9nkhZbF7+xxvV7Xiz/WFf47giXMwYusNG6iyLQ7Ws//OaQiltdgU01nN4dlCE/NnV4@vger.kernel.org
X-Gm-Message-State: AOJu0YwxT1oM3Bt3ULg8390YE+DLIFioELQ4FTjw7vTfek0CfjzgfjNi
	s6zREHnAT8CqnXjdvaokuYgD6HwABgP8SrnZ6ef6WKRaW1+W+RbVSKLam10SePvJFQ==
X-Gm-Gg: ASbGncunWZyWP0s8TavLX8xOIzGhdJZbwnpUWvj/nQ8JHctHtfDbjRpyo2BHn31c4eA
	l/092iPrKi8jnYo49KBrOjVk06tj18pKfQyH8/lq0DPm8JZigkFYUsB3UZpSSwaJiIhQ3smi+6U
	LBFObjoI4w4IiW5ZsXLz4Bag5wdU5Wx/vW9Jg0O6RG3sTF9mTX1Fn9lXEFr0oxpdtcjniHVUdjp
	wnhBF0aSyZlunIUHM+6c4wOKGqfUFR2veRGD7/xgZUGCXC28KKT
X-Google-Smtp-Source: AGHT+IHIBeSIkgzah4X8/DMcrST/Vu4XTiKeBjmK1CaaT4Xbdhtb+WmG+sDiueAMysqzRffOiRZvJA==
X-Received: by 2002:a05:6902:70b:b0:e38:a637:7824 with SMTP id 3f1490d57ef6-e3d90230563mr1113451276.16.1733956405498;
        Wed, 11 Dec 2024 14:33:25 -0800 (PST)
Received: from x13 ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3c94b7b09asm508191276.60.2024.12.11.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:33:24 -0800 (PST)
Date: Wed, 11 Dec 2024 17:33:23 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, rbm@suse.com,
	skhan@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] lib/math: Add int_sqrt test suite
Message-ID: <Z1oTM-ZW7u0_TML7@x13>
References: <20241211203425.26136-1-luis.hernandez093@gmail.com>
 <ad95d09e-ddbe-4d43-bf22-00c2008823d8@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad95d09e-ddbe-4d43-bf22-00c2008823d8@rowland.harvard.edu>

On Wed, Dec 11, 2024 at 03:42:33PM -0500, Alan Stern wrote:
Hi Alan,

Thank you for the review and feedback. I apologize about my previous
patch, particularly CC'ing the linux-usb list unnecessarily and the
spelling errors.

I'll address your suggestions in a subsequent revision of this patch.

> I don't know why you CC'ed linux-usb for this patch.  But as long as you 
> did...
This was mas my mistake, I must've pulled it from my bash history of a
previous patch I created with git format-patch. I will be more thorough
and ensure I use b4 in new patches to help generate the recipients list.

>> +     { 3, 1, "non-perfect square: sqaure root of 3" },
> s/sqau/squa/
>> +     { 5, 2, "non-perfect square: square  root of 5" },
> s/square  root/square root/
I failed to run checkpatch with --strict --codespell, it could've
easily caught this. I'll update my post-commit hook to prevent missing
this step in the future.
I'll update these accoridngly:
{ 3, 1, "non-perfect square: square root of 3" },
...
{ 5, 2, "non-perfect square: square root of 5" },

> For the higher numbers (16, 81, etc.), you should test N-1 (and maybe 
> also N+1) as well as N.

Good point, I'm assuming this will help ensure the test suite validates
int_sqrt() behavior around the boundaries of a perfect square.

I'll add the following test cases as per your suggestion:
{ 15, 3, "non-perfect square: square root of 15 (N-1 from 16)" },
{ 16, 4, "perfect square: square root of 16" },
{ 17, 4, "non-perfect square: square root of 17 (N+1 from 16)" },
{ 80, 8, "non-perfect square: square root of 80 (N-1 from 81)" },
{ 81, 9, "perfect square: square root of 81" },
{ 82, 9, "non-perfect square: square root of 82 (N+1 from 81)" },
{ 255, 15, "non-perfect square: square root of 255 (N-1 from 256)" },
{ 256, 16, "perfect square: square root of 256" },
{ 257, 16, "non-perfect square: square root of 257 (N+1 from 256)" },

Thank you for your time Alan, and again I apologize to you and the
linux-usb mailing list.

Best,

Felipe

