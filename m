Return-Path: <linux-kernel+bounces-548021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7CA53EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F860188BBB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A6EC0;
	Thu,  6 Mar 2025 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kmyXbeke"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B136D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219749; cv=none; b=cD1S+8/Icm/MkG8xNAuZFmZoy3TsLK9KU9RyJo/xZpdpJLPg20m2sBT/WeGBnVUX8cuZxrwVBSp4UZoB3l1WDYPc0tEsFK0MV5Sw/q1jaNGNMUUgIWyJOfS3LN20JcirjN7E2+fXRuq3buIcGbYdnwLGdUEN9iPsQn8h47yCoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219749; c=relaxed/simple;
	bh=/PL/yCTjIRpzVCj9p4+Qh3kC17MW74dAnh1pilULjIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goWO7JuQkTgT99wOEUM1o1by9PB48RoEk691gD56Dw/fuIP68Cj78umagNcEiP7WjWOXtv7rUWkbL9+D6uB/g7SgYXq7nG5FdJ/zCKCQUj3BKUchG9emZOnXzZgrWIymfBR+SfuIXr3pWdbDzKkUbBDZDUNw/FZlYPKjeswIHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kmyXbeke; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3d9cdb0ccso14378685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741219746; x=1741824546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7n30QZh5MqHhg61ngoUpNHMLZG6JDNKypDXU8n1zfY=;
        b=kmyXbekeOYkv2JlANgMiGQmghxn5r31kP3BnYzrog1g6ADPZhsPtIULpfEQfZwzBg1
         9h3tdvqViS0UKv8IOn+EB8sF3Plag1qARXHOFFAce55ZOTtDe0h9AEHbMC8jfGK1+0Fa
         Qq63vk0Y0kH70PmSlRwCrgYc7IMfy0/gqozN6W6Gos9srdC4M7QfkhOuJG64BLqi5CJH
         OW6Nqukg03pZrJfWq01Kl8JsMVai7aCdhSPIt4h+PSIbe4XvpAZFZvt+2f+2TgKkOnid
         y/Yi7ZwYc5OSQVQkprIFzkg8jO6hdNkfKBesGAXE/RWu5B+65Flw/pCP6VtGyi0BZKZM
         LvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219746; x=1741824546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7n30QZh5MqHhg61ngoUpNHMLZG6JDNKypDXU8n1zfY=;
        b=N3JxU74QLFPx3JEpU3cfHIapJRdJ1KrAssAg7Kiahz5SdGEqV5zPnaw3fhoBsP5Udj
         +5pso0TqPTK/JEEb8U0aJwUiQISVOycr+gw/E9/rdCGsx9DePVD07rklQzT+Ou2p1nbS
         8RN/XCqudjs2huuZJuviLRPmQ8VObefC4Z4ctsg8eDrSdvYHI/8UkEODjK1DbjwLd52P
         U6BVlahpvbNjQDmzv8ST4JWwEBV2ItEntO9zs2rkHh3L800czJG36ejGllnoXZ5ahCnb
         A3UA4md+DYy491Xo7RrhnehjOfxR/PtO7lBJw4YIiYQmXM8h1T6XQRTo3rii94yt0N5a
         XWBw==
X-Forwarded-Encrypted: i=1; AJvYcCWDZfX8HSMhTFTB42pEO6ZnJU7yXpm8frwOP+slABNEfxzjlDp3XUO1kyQvtNzRrMn1s/7aaSzpS6LCA9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlnMaE06xjnI7jS6Dn67+5bE1WYjiaZRLC/jRLtUM+if2MthQ
	nJky8jZfxUK4UqVM05hwmHtN4vFxyNjfizm3gRo2b84CZmqTBTz2v6uoNg1oDto=
X-Gm-Gg: ASbGnctlpT81kIUOY0qui5YFqWxwFN77pay9t+EUHijzrz7U8oB0rvYN5bCLBGO6s8m
	tGDLkAwPmCr4P7YWRM045NPD2e6A6u74sKlsYmmFxpaMpu6Kcb/Xh89QnSLLkLaVKLO3jEoIgg1
	tIAq82y1h7tJ17KANXMWRnvL8YqeEvmdRwUJGGqhzXXuQAifQJR98hqrrDPP4AlvzWtYTh1MW22
	eq3xfxbStcIz6ikOcCXCftaUWo1VacghOdj5pqYRvghLEtjPVQttN/JSW4jCJPlgggfx54oDQip
	/nYYFQH/tw3rn+EsTjH4UyQCQnSQLZ0d+vzNuxK+l+VCzIHbhFE09NgK7pUrsSweWKMKvvgMwjX
	eESi1orP3dRCTxIzV7nkfcFij9MY=
X-Google-Smtp-Source: AGHT+IFFxLUQ+KkgPN4iyQlqlwI1Rw/OwtnKQnaDZ4DimWoqed71Ad0cB0V3qblwvHmUbeOh65lMNg==
X-Received: by 2002:a05:620a:2841:b0:7c3:cde7:a685 with SMTP id af79cd13be357-7c3d8de96d9mr870869585a.13.1741219746455;
        Wed, 05 Mar 2025 16:09:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534e915sm11780685a.46.2025.03.05.16.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:09:05 -0800 (PST)
Date: Wed, 5 Mar 2025 19:09:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8jnnn7OLa6rwkG1@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <04e77063-5676-4435-854c-9488075114c5@intel.com>
 <Z8jfigfHaTVR4bLj@gourry-fedora-PF4VCD3F>
 <d34016a1-e834-417c-ba2a-028e4e0e9573@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34016a1-e834-417c-ba2a-028e4e0e9573@intel.com>

On Wed, Mar 05, 2025 at 04:41:05PM -0700, Dave Jiang wrote:
> I can help write it if there's no great urgency. I'll try to find some time creating a draft and send it your way.
>

No major urgency, this is a best-attempt at background info before LSF.

My goal at LSF is to simply talk about some of the rough edges and
misunderstandings and subtleties associated with "bringing up CXL
memory in XYZ ways". (e.g. what set of constraints you're actually
agreeing to when you bring up CXL in ZONE_MOVABLE or ZONE_NORMAL).

On the back half, I imagine re-working this whole thing.  The structure
here is getting a bit unwieldly - which is to be expected, lots of
moving parts from boot to bash :P

Maybe we can look at converting this into a set of driver docs or
something - though i've been careful not to aggressively define
driver-internal operation since it's fluid.

~Gregory

