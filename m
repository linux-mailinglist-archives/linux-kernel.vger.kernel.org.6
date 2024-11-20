Return-Path: <linux-kernel+bounces-415184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E242E9D3271
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8109DB23F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378B15666A;
	Wed, 20 Nov 2024 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hvi3dn/X"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02691547D8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072536; cv=none; b=jwxiflGAOcXiqDhGeoBQW31qz8Co4nSjP8mRkbAfRcgcK18gD7a4RBoJZspIR+MQxcPr+t2XnY4dnjRWikzUGCVZSTLaVfoQ/1UrKOl1EPR3OatQ69noKOMwVE5FhWuNrnmIP+91gosl0qxByiTh6SIoi7oah5qLs7aqYnxsWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072536; c=relaxed/simple;
	bh=QYBilDzkSkb1abEzANyeRxgYDytG7KjEI9bskxW5MZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUtw4OgoLlFsBdi2S/GfkVvQqDounRxnfzLFHIRg7FSnmuQmE4RlViJA/SfEgi9zQGIskBv9HrmuQ9eBJTwvlKwUqhWZL5JkCPRfbJdhnLVixN6e0fUgXahC/iQ3DCmg8Bg4cgfvF9VujDQSX34XGcbtRXozwElQY8fMLp9Trak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hvi3dn/X; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720c2db824eso1672067b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732072534; x=1732677334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSva+QoTVrzF7+bpQWC+3EfbJTYWWaNpUIOffyDhLA=;
        b=Hvi3dn/XAmTNYe+8vH8ukkVnKxZT+d7BMrNIDTK4D8c7NBzlf8uu38QD5vNpd6mKql
         wBStoRmb4ecEwfHJIr8A+3k+MwmShhyELPnycSNN1vsvLo4otjzWmmYZumO5xpMLku2F
         nopBWMSjiXKqyY383d/IXcllHMqh4ktEdrZfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732072534; x=1732677334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZSva+QoTVrzF7+bpQWC+3EfbJTYWWaNpUIOffyDhLA=;
        b=GWRpY3fQ1K2JlmDosbyNFFsaELlHKCbBUJOWxAAf7zGH5Fo1xMBV+EMhP2FRUB7G/s
         VBmGcGmqCTk11O0ZWDHMCaWeAMI8Wwvt9qWscLQ75gzzfvjbiVGPtR+rasUQY3b1nVG5
         JPi+iWQdEasTlcslgsZjIDKjtOtE0gpJVf4eHhMMpcHP+lQxtfJn2JfsKEz2V+gOXOm6
         Ayl1vmL9ZaBUHE5r02ZqYoFRYhRJRmMRZ3pxCApWow3kC1O/rrYuHcDVW3iWPLYG2bzo
         jUBB7XN4Gridy7kvYsi3sWwxqLhv5tGJlqtVq4tb8Cffw6PMSHIPyygGFHqe2BvBjHvH
         r3fw==
X-Forwarded-Encrypted: i=1; AJvYcCW3aTcUkdo0mLa+HPJDA4GWmImJ7ZSciQXAgSSxDxHLwml18CJTpbAEXc3Au+NKpkpzmItFc/qg0C1SvZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztE6bSZfW5OS75jR+uzc9sG9zh26yS+4SMfiVerQVHCI28kabH
	Cje9pFN+LQxTwf40f/3iKe1o20g9e3unZ3vUIh5WjH+1nczWFSRUsdGidvGekA==
X-Google-Smtp-Source: AGHT+IFoBDOvjfjxm45eiDb4JEPWT0CGtuUdJ+ZNfMLgP5G2wdqCKEPQK923zWmyBPd4CEQnJkbjkg==
X-Received: by 2002:a17:902:fc8e:b0:212:3f13:d4d5 with SMTP id d9443c01a7336-2126c11226amr11032255ad.27.1732072534058;
        Tue, 19 Nov 2024 19:15:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21232eabc04sm37897005ad.155.2024.11.19.19.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 19:15:33 -0800 (PST)
Date: Wed, 20 Nov 2024 12:15:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
	terrelln@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v1 0/3] zram: introduce crypto-backend api
Message-ID: <20241120031529.GD2668855@google.com>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119122713.3294173-1-avromanov@salutedevices.com>

On (24/11/19 15:27), Alexey Romanov wrote:
> Since we use custom backend implementation, we remove the ability
> for users to use algorithms from crypto backend. This breaks
> backward compatibility, user doesn't necessarily use one of the
> algorithms from "custom" backends defined in zram folder.

Sorry, no, we are not adding this for a hypothetical scenario.

> For example, he can use some driver with hardware compression support.

Such as?  Pretty much all H/W compression modules (I'm aware of)
that people use with zram are out-of-tree.

