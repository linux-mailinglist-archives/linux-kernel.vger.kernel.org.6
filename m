Return-Path: <linux-kernel+bounces-362502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31C99B5AF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85A2283A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE91993B2;
	Sat, 12 Oct 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="jAjJQ033"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2F11CA0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745307; cv=none; b=LcbvsDpKgSuU2c+pTsRsx8xkQRGkg47JquJWuhyc/zq/fNofg3Q07nFfeRkAnrD2s4w80rm9CGtUQKWc2UOC4uRvqZexpd8zmrRQZzI8+/qL+IzUFIUne+h7hZrA1Ja8/fIbA1TWfTvtp7VEXnPOlxheIo0KYB+jV7ac7n98k9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745307; c=relaxed/simple;
	bh=YEUiLePNhVMbKwvX2/m9CkKVvHhoTjLH1YmL3oWgE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFN7g4W2tUrKPGa5J3sx24bjVv7RpES5UAB2xeweE68N1NOkZX/4sL+BU6xCEaN+ammKWAHNNJH5If8kO96youuXTyoNZVPaG2CmuYnWl7lAZsFw3tBj7b8KNzh2hlmP172lyVmV/2peyfJtBv85ZB33g0VKj3bUv4SzB+UNoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=jAjJQ033; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b113cd6d0aso281271785a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728745305; x=1729350105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fULnjWwi2MGgq4W+ABLt5PjumaBI5IxDnjqyHYbxMeg=;
        b=jAjJQ033EritCoCn1qTFcwBMk3tg1piqHQxSuptJ/vEiUcX4inLLibvNVPbaMcslKD
         G84JhVZwq/BA7qGRjZOIAEVv5BalAmU43YADdFRsG7G91Cvzt8Dvdr15npvBwNVF5LjK
         ZmL3gaHmdgWxcyl4vz+MYkSg+scwdU7Txr/+Apc5Hxpknb0dICYEXG4sOBdf1WSey92V
         nQ98g2LnCKGsAeIJHOxGXVZEUVVlMaEexf+p9QEuQbWEHpNu2G7OWaWfe6GLFfkn4R32
         me+8WYiqjOAU2J+oGHUK1xh+zUJqh1KaJw799rJriw4hSraJ0WfOrx+cgiUuzWLhISAV
         oGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728745305; x=1729350105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fULnjWwi2MGgq4W+ABLt5PjumaBI5IxDnjqyHYbxMeg=;
        b=R9jJohQbmfuJAoRAbWapluoT4XWqsyB4nI80r+Ztvl5l586gxRPIVwX3pnc1X5uITA
         Pc2CxPpOvKzUNSVnxd45G9j0twkVIMm/swONZandVK9CgLS3AahgEOHEVd0mkjD/kPFu
         HlzVk3BAd4FUws6Ls28W3OXmS/VMRP2ZRGF3fY7OwvkucklKprHj1f1fgZYnQsLTRM37
         LiU6LcybzeYJcwfNnWp5iXw2Of2SHbwHqtwl1S2KPuo0YKwQSjx1xk3OdiHfYpJTdyKC
         60NOfx3mqsmDvhdDs2X8M4DJHGXjzu2yA4n7UFIrBLCj4UFOoeHJOv3x+J9+Eny4Ah37
         oXHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbKnnwnlU4vRGMqmOZAvZuXHvWc7QewBuilLaz3mT2ElBFwRoW0OPAxscVvZWcosSjqNcigG5YNywdmyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7l/ImYGlwLpBJTOS9G9DRHMpGDCpcaO2pmM9F1tIXfGbdNZHv
	rWdtG/U0IXL5UMr1L6jDwekJmxM+LkRsrjqKEnkaDtHMyIGSCgbvawZNM09gZw==
X-Google-Smtp-Source: AGHT+IFZ44eikmmCXWv8LRBqrW7MgjO6XTiGmN1ju3tLIO7fZe2VBcJDJ75S1jcffahvgCejBOJiGg==
X-Received: by 2002:a05:620a:4547:b0:7ae:d2cf:aef4 with SMTP id af79cd13be357-7b11a36608amr790084185a.29.1728745305056;
        Sat, 12 Oct 2024 08:01:45 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::31c2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148de0acsm227769785a.39.2024.10.12.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:01:44 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:01:41 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	stanley_chang@realtek.com, tj@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <74848334-7cd7-4ce1-ad96-5dd29d70d3bb@rowland.harvard.edu>
References: <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
 <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
 <0ad92e8fef2f07672aa8e97bc04f20657469ac6e.camel@kylinos.cn>
 <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
 <f27bcdb6c5ddd4e91a1dc9f86b4f0c55c50671a8.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f27bcdb6c5ddd4e91a1dc9f86b4f0c55c50671a8.camel@kylinos.cn>

On Sat, Oct 12, 2024 at 05:51:41PM +0800, duanchenghao wrote:
> 
> Hi Alan,
> 
> The V3 patch has been sent. Please review it to check if it aligns with
> the solution you described.

Yes, that is what I meant.

Have you and all the other people at kylinos.cn tested the patch to make 
sure that it fixes the problem?

Alan Stern

