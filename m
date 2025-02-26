Return-Path: <linux-kernel+bounces-534487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDEA4674F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5403AF575
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6E223329;
	Wed, 26 Feb 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ewGg9k3z"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893021CFF6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589329; cv=none; b=CPJwWLyw3b9h4Fu+bc5YJ5k0toNEqQAgKVVGIZYDLPwgPAuOBeNdJlN+zk04VAH/p+YaYaLUCZx24RhgengcVDz/xcFJNYAnsQNtN7elyjtZzcNFE9oOiwwCthChalzX5rlKlT7GdJHsBpn0gJ8R2Q2UB+g4MDyHDudGQDXDnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589329; c=relaxed/simple;
	bh=e5NiXp9FYAQo8RmgI6NQ6gPt2AVfMiz6r0xfJUYuKrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q67km/AjG7Az4zhqCPYApsOOqbtnhGCAnlVav6HFw8QQaVC+EEnsH2F2xnKebNOOmXg8dUv2rFM2Snq5IMUbq2zseF961HtSQIlMCKnAINdjLbw7lvaukPqKU0+LGxaB6BIhCzomXETDvQKcRQn9MR28+BqVWKvZhAQtg6Wia2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ewGg9k3z; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0ac2f439eso2358985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740589326; x=1741194126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6gDpJWiIqmqRiAR05CBdJHy9M1E970vBLzOxyspapRA=;
        b=ewGg9k3z5si26WBJQSk2PhTrDtlkW4iM0Ye+lFWaKhfbAFyfQ+Nd0FdVkOOQP3QU0i
         36560fSkSvDlCZs9aLLAKiZkPCO95S7CLE45qui7e+LwnSXiaP9si7Ha2wWzbeUEqZv3
         4sDCec61zt9v9MUQT2N3hlmbbPJzJDblDCzl9V1xwv70zDHzDpgz58quD3+LC1aETmcU
         dY+bGCMAHCtPOl6krW3/0i8ni+pf4InMqjIbb9vTasQcFArOJLsKrYoS+eW3lawHrTRW
         TsQSN4GSE6F6tU2DxR4YV9MQdPgc4Jlblvp+W3NEb+A072KEckBEmEgfdsdYBfGbDO/d
         3E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589326; x=1741194126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gDpJWiIqmqRiAR05CBdJHy9M1E970vBLzOxyspapRA=;
        b=LSTOOqGlbEg5d5flk46BElzfAwQN4iTKT/6eN3rEW4+cH5mHpfVmmiz5ktw6m3G7Uq
         O9KBddpPIjdQBUFSGQXUQyDwSAtUUCGu/jk90/8qx54IcOU/RuogF1kj+FivSXODzQ3O
         naRmEXjWstCp5qvLAZ6a65o984YsdMnIWRQbMq/2y3+npV39eFt8WMjh7QW8EsemuihS
         3EU4C8jMxFSdh3l1ADm7Zv3l0g7+Dn1Lk6Qfm54TaPi2IPGXpvzpTdBMO3cMNurClHvK
         hG7NHwHyp31mgAp6W56588snXw1ZQI7y0AegPRJcea4dbjeNQ/OHwbrf2kBYMcmYBp6E
         wejg==
X-Forwarded-Encrypted: i=1; AJvYcCXe8TVLc9mmhZUuJwVD99T/z9y06WshdwZgfMP3Giq1a364o3Fvxc8lVBtxGKUWMRKiiI92pScahhGOVDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nMKKTWgpD9GzoguPfA59rMJMdwXdl6ZFwlLqXhwmm8glHOgt
	zgS8uzyE/fDXfzjE6QPHIeVE4MCOxO09eIL4bvqjO/Zk8HS+4zN/Fyj2tammEQ==
X-Gm-Gg: ASbGncvB9UeyIE1fg7QBenGIy6xj+Xt4LwyUgfPJfGa2t/ZJ9F8/EWw9/T1rpJxWjdH
	my7na3QEGkHh/2zrSYHs+VhXBWzFNAKNf12RWyHYYe/jGHwc0Hyiwe20A0kNLty5wdlKedLAai2
	4CGQrMtMiyrpTBBBwSwU7HOrdiaculo5t1xgVJ7JlleZzutsbXLH7aa3Lhssutsj8W59OaBk+ty
	K3zcrNsNMAegKMkkgIaWouJiIw/KiE/GAi0cMA74KMoFheCsjWlMdqitw2VD78dplHrI7fvQ4HG
	SHtdDdvPEihNgoMsjL3IfXuQhLtfY+6MYukgo3RpFwqKGACNf9cs2k/uwd9tI/6jeG8aNHkatw9
	dKBzr2t9ps6f1P5bfkIY=
X-Google-Smtp-Source: AGHT+IGV/gWuJnQclFU8ZteMOSQCELX/mpo4Tyj2Sn/PZ7XKzflnRkNxcemJufnJWgcG73GfCcYYUQ==
X-Received: by 2002:a05:620a:1b8f:b0:7c0:b368:5d8b with SMTP id af79cd13be357-7c0ceee5f8fmr2639224985a.11.1740589326574;
        Wed, 26 Feb 2025 09:02:06 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c34f633sm269044585a.117.2025.02.26.09.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:02:05 -0800 (PST)
Date: Wed, 26 Feb 2025 12:02:02 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: j.ne@posteo.net
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] usb: storage: Mark various arrays as const
Message-ID: <ea5c2735-cfb3-4e5f-a7f9-40d4493bd05a@rowland.harvard.edu>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>

On Wed, Feb 26, 2025 at 03:17:22PM +0100, 'Jonathan Neuschäfer via B4 Relay' via USB Mass Storage on Linux wrote:
> While reading code, I noticed that some arrays in USB mass storage
> drivers are declared static but not const, even though they are not
> modified. This patchset marks them const.
> 
> All patches were compile-tested.
> 
> Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
> ---
> Changes in v2:
> - Add new patches 2-9
> - Use consistent authorship information
> - Link to v1: https://lore.kernel.org/r/20250225-misc-const-v1-1-121ff3b86437@posteo.net

The patches themselves look good, but I still think you should explain 
in the patch descriptions why declaring these arrays const is worth 
doing.

Merely saying _what_ you are doing isn't good enough.  We can tell what 
a patch does just by reading it.  What we can't always tell is _why_ you 
would want to do it.  That is what needs to be explained.

The explanation doesn't have to be terribly long or detailed, but you 
should not omit it entirely.

Alan Stern

