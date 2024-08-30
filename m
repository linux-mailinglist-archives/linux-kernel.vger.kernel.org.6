Return-Path: <linux-kernel+bounces-309438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F6966A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CFA1C224D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EA1B5304;
	Fri, 30 Aug 2024 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVcCbJGx"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354441BC9FB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049744; cv=none; b=R+SahXzzs37E5rsmJlq/7Mo8Tgi6pJcBBF2TDg2sCVdam96TuRZhYpnB/q7pa7m2lgf8fvmvNumZY59bPWmuHUZz03K4G/RHuumSm3OdBZmj+TiyzMmmLZrAo76lYchXoLOOaCkNgvmyIpHxHveQ1Eh7nglGJX9I+i7iFLyX8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049744; c=relaxed/simple;
	bh=2HUmKC2ZHgCTGOQoAR41n8vo2kMn0KAnS3FLq+SPSzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrxLE0dp56nzFg27ZKxxc05uIZhfX7ndlYDm8tCR+o++Za5JJkAVu6dvp1nmdv0Vd83T9IsnVRxGu+VfVM2Z7hhYp7rO0gyyGe93GJgrit/rdDII68+d/jJVO8lSvL6V2ocfY+m/701ecRuHdRAjYoIbMssP/3euMO1aIBHjMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVcCbJGx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a868d7f92feso266529366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049741; x=1725654541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qO/XIjtOZ23hnWGRe9FmwyP4O2dlveeYrHKTMaUtoU4=;
        b=IVcCbJGxbBSUHyohUsINQmXmGw/8zG4RLFImdf36fRzGqcD9hAAkdbFnyLauM4Ikgg
         N5xKNEoonIhuceuJSZGCgZbV//eaK/FCBhOJ6wB3DING8bGPCd6W9VQFthjH0povQR6C
         TcbQLRO0OhlcbHhn8Yk3wYle4Hafr0heD3NL2VL489F3SryPadCB/Bd6FAHI5VltAxc4
         0DUZN5ZGJ6d2eGesq15kNVuAGFbcCvX+KXNluONsOBL0Rf3yPr3PJyhZtM/iFJAgkhpt
         6hNIx//EQOezkw4sh3U47lOGsw8St/fH9Aj2zTWSUXH+XtTukmczDEhbOoh0Ond9IeIN
         fYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049741; x=1725654541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO/XIjtOZ23hnWGRe9FmwyP4O2dlveeYrHKTMaUtoU4=;
        b=OZTkUqzBlIYCDLBLp6boB9Bm1OUSpgP2rr/ON6aF4p/vkmwF74my4K9wai/WTU/VKk
         qyZm1FAvSDP35+lQ7kwwNhfJkx8koJZMFGbczQ1e91Fb5Gf6X+ZLlEt9Z17MbhpwwoV3
         7jOLQgNP/6eH9inrvTKtLKYC+zI+BHipcK4UTgUrTI5LnW30DO0YuTAwlVY3kJCxd8Ul
         UU5InNveS/UmkA6xVclLDpBmnEIodswhvjEOrBcGiRHVs9Eb55FF01/dtw6cUJ0xG3eY
         +DBK3CMJQJP8I8ScPpfiUviu85ZSkrrOCSjNBTEDqvwoACD57kuPVS8zcAy7IQJwEcPo
         lcLA==
X-Forwarded-Encrypted: i=1; AJvYcCW4/40CWOTQCetdZSJLpTkQCM98UGUeWSnsIOixdZ6HfVtJaeIylZKEdTJIufbR2Fo87rn6HoSbAulf/fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+kY+/opmLD0Cr3VjpoC15T4vkr43mCTlFORL/IwxpyG8NW3vL
	+JepyxrHDfRgMpYpsRE45Z5EjSSnHrDD8gJhq8GIMbS+TWW/8K8B
X-Google-Smtp-Source: AGHT+IE6Qkzw/FjiSHh9MnXtw1FKkJ8r71p6iNoG8PKJEo7u/17Qerp1WLp4BygsCfR+iNL5ADP+LQ==
X-Received: by 2002:a17:907:7ea1:b0:a88:f826:3792 with SMTP id a640c23a62f3a-a897fad2923mr592595366b.56.1725049741274;
        Fri, 30 Aug 2024 13:29:01 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989022ac4sm250324766b.59.2024.08.30.13.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:28:59 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CD106BE2EE7; Fri, 30 Aug 2024 22:28:58 +0200 (CEST)
Date: Fri, 30 Aug 2024 22:28:58 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: REJECTED: CVE-2022-48936: gso: do not skip outer ip header in
 case of ipip and net_failover
Message-ID: <ZtIritQik7Gt1t2J@eldamar.lan>
References: <2024083059-REJECTED-7912@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024083059-REJECTED-7912@gregkh>

Hi Greg,

On Fri, Aug 30, 2024 at 12:43:58PM +0200, Greg Kroah-Hartman wrote:
> 
> CVE-2022-48936 has now been rejected and is no longer a valid CVE.

While the CVE was alrady announced and the commit present in the
vuln.s git repository for the rejection, it looks that
https://www.cve.org/CVERecord?id=CVE-2022-48936 is still valid.

Do you happen to know if this is only a temporary hickup on cve.org or
is there still something missing for pushing it?

Regards,
Salvatore

