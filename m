Return-Path: <linux-kernel+bounces-180402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4F8C6DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44675283EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13315B571;
	Wed, 15 May 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="JB6aB5bk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6315B558
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809740; cv=none; b=BJ8BSBlmeWWPtZI96VXIY8/ts32uGNoAPWOjgGoFwo96GlYcjAsO46QfriXNnjdhA6UonAyLOGlQ/mNRc+ceQRye9zTt+dUwQ0cQjmoLlwFVZvisXU3hFCmj+RyLcEsMgGyTmXEMOvRjpmuqOwTCVeIJ9o5O0wcNsgkwgV5N1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809740; c=relaxed/simple;
	bh=dYxBvXIkkIPnkxqSbj9IyfDH5umyBNzNhJPJzCi/wu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjINlkWg2BYLxU6pTbfHOfxq4joqR7PnA19ORn7HFKkqMno2miUw8JmLOC1+KGFuufWoqpfOC0Gh7haeYJTLXPoOYGK7m82wFnfj6rd3+fPNrLTu+3zE7zndIZWxqcDvjTi53ex/zAa/m6JPIylvDLOhjtBEmeE/deQOFQnRH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=JB6aB5bk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f60817e34so72207e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1715809737; x=1716414537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbHxK0tJj+d8ac7+efgFv40pBbo32UT05hThpFtt0Dk=;
        b=JB6aB5bkYA53KgfXnlusszz1aNBPGiRfCO01n6ELYVxY+h2UfUA47v5Hg4KsYaZfm5
         1ezkLibqogfhP1/hAQvsbMRGeGQfJIbwqRONpUXEwzL0iTHRmLd025ahh26Rep3wBGOs
         l6jMnZkJKBdvqmCQ7gESQHk6F0td0MMWqZfKliXLazBLsaxU5LCVF1vAr2EmUtDqbHgU
         dfmEMMB6sdKpZqjCiGDtQYr7J8mfdkhaifKuuMLkNcev5seUzebg2TVQUzPTyQheVT6Q
         2Vc3a8o0dr4apMS2RRVgEbxZE/sGpwu5aweQvhr9asBTPJHb1DPS3z6vHliiBVRiwdVZ
         ePeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809737; x=1716414537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbHxK0tJj+d8ac7+efgFv40pBbo32UT05hThpFtt0Dk=;
        b=U3EiZAIRz+nPpGI5xPcUcPMsp0QhXuc2R/RW04LwfEQk8Qzf/L36k33D2L0EeKtcva
         uXQVSK3PdTiRsnbytpHD66Vg6yEgNopc25RnjgEzWfBzVyQOtcD8UMERDigd2aom5unF
         m8OxG5EYmWQMeKY4t+kB2J8MSQaMzecFSBxd6OvbAIXFumlhzhPz5lvyDuOL/Z3gBkFz
         VAhigWYkuxkx9Xnm1X05DA3UdxsMGj0Is/ZHUne86mDYOJ1Zj4bKOwgPjOPagWgIes1Q
         pnNJlzsQAatj+xCxYZcWglem5MV4GIFlQLAILTUwCWnXkFKjc3h9+o83uNeF3HIzWMoH
         8sQA==
X-Forwarded-Encrypted: i=1; AJvYcCWpq0NwWz0vX+K4Er7u1M4o2V5seAw+8RPTYQBvAGUA1KZWp5DWntQdUAQw1gpMWapM6in0jexI2bbsXQdleouxh+SHow7yI3pLbgsw
X-Gm-Message-State: AOJu0YxYIdDAojs8Gn4/ZHtZ3efv7v5oKHS3PCxjunEYaUsLC46LD10l
	5W/Mq88BEh/lBPpCkUv8xVIzll/kb+8rKA/zZ+79uaY5RwSJI6mjWFwse2begVA=
X-Google-Smtp-Source: AGHT+IFVo+jBTASsbcknHoB6KxnDq74BPVXn3gknwHhVlO4HPpwL5hatGD02RQSDY6ts4L0JE+ESqg==
X-Received: by 2002:ac2:494a:0:b0:51c:dffc:41f2 with SMTP id 2adb3069b0e04-5220fa71c21mr10626186e87.1.1715809737520;
        Wed, 15 May 2024 14:48:57 -0700 (PDT)
Received: from minibuilder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523ba138259sm26690e87.269.2024.05.15.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:48:57 -0700 (PDT)
Date: Wed, 15 May 2024 23:48:55 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, Pier.Beruto@onsemi.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <ZkUtx1Pj6alRhYd6@minibuilder>
References: <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder>
 <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>

On Tue, May 14, 2024 at 04:46:58AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> >> Is it doing this in an endless cycle?
> > 
> > Exactly, so what I'm seeing is when the driver livelocks the macphy is
> > periodically pulling the irq pin low, the driver clears the interrupt
> > and repeat.
> If I understand correctly, you are keep on getting interrupt without 
> indicating anything in the footer?. Are you using LAN8650 Rev.B0 or B1?. 
> If it is B0 then can you try with Rev.B1 once?
> 

I'll check the footer content, thanks for the tip!

All testing has bee done with Rev.B0, we've located a set of B1 chips.
So we'll get on resoldering and rerunning the test scenario.

R

