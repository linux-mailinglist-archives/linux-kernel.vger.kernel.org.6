Return-Path: <linux-kernel+bounces-225154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B40912CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8624D1F265C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128716A935;
	Fri, 21 Jun 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cD5wxEsr"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778313D521
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992636; cv=none; b=WDpE+WdvoCEWe8io+D1At4db3wv4+vPIhxIKUenW5pQYrLzUc/UaNTWvhsF11dPiGAZZOg2eChqjq+p9trdqHTM+jRJZvIuSVy6WXFz8GD4n+SktQVS+dMG7J3dTCspJQsYEP98nzH3DZb9Fi3EtDRv9yn8H2VUHa1KnbhcGTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992636; c=relaxed/simple;
	bh=huiiGge3N5NRabnHhvGTRpLAvVUJYtR2Isze4gc0Iyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6EH1cWiIoKWZCxW2j0h1vNBwf8vISCBv6dYysvQMseqSVbX4bKG2WsDQWdTQHX+BBMVRL8cqy4ClshHZeyzy6EuFPQXniuGOpS6hU1wkMexTlv1qQMRjvQND1j6darzBxdSSwWajfApdZG2Hdv0TqQXd85bgF2uDisjDAsw8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cD5wxEsr; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d22323a3ccso130641b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718992633; x=1719597433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2uqp7TElEavi/tTlIJQ2pRjgF4RKNZn5WN+PGY/J3c=;
        b=cD5wxEsrGUsk9P88rSupFociznSs3d59o3z5E7zbGRE0CsVLBLnls5xUtJ0wSbfBMz
         UXd9Ndcz+LRitcDj2j7k53Emgx0c/BHhDyJHMzsDX5H6XTqrbTZqjo8Cl5aRGYDMJj0M
         SmsgI0nMob2lqc/vmji2rZIvGbmMYZWQuXStWqffmxzpbWt30eQqvCZecvb4XDrM2keI
         u7qN6z4OZ/c6WHvZZvb3xyjld2032TDG+rn5BUgp3a4MDCJaOi+Pa7klEf7dyfu83iwM
         sTGCkQdpXLOn4wlPBn2sQm05u4G1xVYfEb7mUC5E33bFH3zE/LzCCYoTfnFBmDmW+dao
         Urfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718992633; x=1719597433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2uqp7TElEavi/tTlIJQ2pRjgF4RKNZn5WN+PGY/J3c=;
        b=ZEe6UrKr/w/UYMPbxh231GTUB6RtrDuw0SlVjpqFvKEg5TvQMJuxDY+PCA8NSH8mrS
         xqWXs0/TIPeVF8Ic/H44hVXSjB2ZaQf3RSc5EabiLUH++P3ltQ6jNTYM4Py1uzxLpAAf
         l7UVXjvbKTAgV7cSGaurBBLsOTprA2rqYWo9wh3ufMpnTBUsKpF2/FfGcwn0bc3THMNd
         oeEkJng3akDLfMdPxoO9VZtU9Gx4+cdEa83tdlWNtzshLiRDLIS/7LQk1i9PNlcidl3U
         zJ5uJZbWXdmemuUq1GJ8wikccfCJ32FDPYx3+VAwMnp64o3vz4jjl7WJQ/O+UkwMmb9W
         4QNA==
X-Gm-Message-State: AOJu0YxZzXMOO9BfYLrTnsTXAMrR32qZlQgmhZe/KVUgX06TpxPc3fyf
	w+alc3J3keMZKYSy4+g4ywe1YjH3cLdK1hk04N1Zj3x3TBND1R1LWL2qnHsDO7g=
X-Google-Smtp-Source: AGHT+IGi0WX+0vM76rlJSCntcANXU1jeQRrj9IofAe0fvrLTEz82eLwYCIjJ+BpSxkmkMO/qy/bddg==
X-Received: by 2002:a05:6808:150f:b0:3d2:2356:d271 with SMTP id 5614622812f47-3d51b9654ebmr11015214b6e.1.1718992633179;
        Fri, 21 Jun 2024 10:57:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d53451bd94sm389075b6e.33.2024.06.21.10.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 10:57:12 -0700 (PDT)
Message-ID: <b765d200-4e0f-48b1-a962-7dfa1c4aef9c@kernel.dk>
Date: Fri, 21 Jun 2024 11:57:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the block tree
To: John Garry <john.g.garry@oracle.com>, Mark Brown <broonie@kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <ZnWe6sXMxm4RXBcM@sirena.org.uk>
 <670625c0-a288-4166-9209-2eccc5ee97c3@kernel.dk>
 <b098bd2d-f308-4383-b348-98f9904ca28a@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b098bd2d-f308-4383-b348-98f9904ca28a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 11:02 AM, John Garry wrote:
> Sure, but I think that we can also use the following, since both are unsigned int:
>     if (WARN_ON_ONCE(chunk_sectors % boundary_sectors))
> 
> I'll send a fix.

Good point, yeah that's better as it's just 32-bit types regardless.

-- 
Jens Axboe


