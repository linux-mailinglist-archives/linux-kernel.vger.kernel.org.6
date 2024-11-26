Return-Path: <linux-kernel+bounces-422051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C419D93DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F42866E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09FD1B0F30;
	Tue, 26 Nov 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1YD4CUE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629E18F2DA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612347; cv=none; b=qUWGO0avZ4NUomLETQqYAgQDIOVn4hT0lXHYfFWe587pdtwZlxMomD4fx+CfaIN33pXbqvciv4TDhMROy/R334XO70CoE6L/Bi5mVPbxMbN+qE4TQDTaUyZg6tGKJmEIMSl27EFjsuz9Q1gHbaZeRN1+CxWqVIV0T7wFwwncU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612347; c=relaxed/simple;
	bh=CsbZ28X3tP4QJFN3nurdyAAkbNcTudhsz38xFjwoTBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLh5chIb6V2mQqmh6r9hS5SGz2Iroe7VaVDTYowSdxAtcL4hodnDZyFormJdFmb3iLz5aM0HSZ+rqMCnnO0CGUOq6gOT94NVmynX05uqi+iI9sPphXC3YO0v+BmaFr16lU04u213DHyAtlSGqjl6qaSbm44wEjNgpImYBmp3t3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1YD4CUE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732612344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V99pFvhNgiMUcl2l0eAcTsg6ck1zEiuF3RXoVuVQE9o=;
	b=W1YD4CUEZuHGLqUNh+O4Sd/PkXDT//uShhYRHyU6DOKN6snNqCJweiKku/HwB+aTKoJwSc
	VCuB1andWM6PBAl/9UULW3kLpCl0KsBdnuxussFqF6heGRSXE2GONcXENlziQaOV1xURVb
	vaXj++Np7M/l1vP1SNA4wWPeHyNcCgU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-t-gbUQ3jO4CE-yLhzeTTdg-1; Tue, 26 Nov 2024 04:12:22 -0500
X-MC-Unique: t-gbUQ3jO4CE-yLhzeTTdg-1
X-Mimecast-MFC-AGG-ID: t-gbUQ3jO4CE-yLhzeTTdg
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53daaf10af1so4205341e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612341; x=1733217141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V99pFvhNgiMUcl2l0eAcTsg6ck1zEiuF3RXoVuVQE9o=;
        b=dJVbVt8fbahn5H4C2UVmkcvNuZbr2tU1ol9EK6DipcKOVU3iUxmv4A0oMQw4aKE643
         yaPgRdzctCbQBQdLa8PKM2TzSnrAoo4fSnrbyr6E4G8XUTSi4p6vkcYN9glhzybflzKy
         zFDWxBCmPOS4wFcs+GEjB2xH39/f52WjIh56teMbOi4guR2Ft61CnzTnWXimqCH9M05N
         wpL2J0PpstFLrhYoUhL1r0oY1LqBnuO1zS30/bUJlsTJW4OcccpYBM08qsHCmUlvZdod
         segCEcDp69kBu0INj8qZ2ajdu165Ku8W/2gVU/6EC+a3CgV3Gf01QtTiKcVV8KkawPnH
         E26g==
X-Forwarded-Encrypted: i=1; AJvYcCU+V4jjag/IQbnntRAzs19VVj90rYfENyy4IB5zF/eakZrcm5v9zpoUOuc0gCy3iCGlfElGdODb2Ux060I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVyjipZ8h/Gwwy+nxUBRGm1jhRp0pG5gx2q0oN7hgYf+C1EhJ
	U6kUTZvVDXRrM5LQitOlj7O0Lx0mhKlDpLaeBh5FYiLp+QoPC0597gncihB4KcHkNyOzvHhufxc
	spfNvB0YzuN4i4tbFvpJms7CBIqb/WNs8V1MLrZ7Es9xDjrQHpa+mr9VrbG9J/A==
X-Gm-Gg: ASbGncsUTmuy1Y4+j8wOWGzRWn/YRbYod2fdP2Lp9XyxHB6zeXJpm1FthleEVFgof4h
	w1QhJ8/ox6SolPtI4zxJwEgJr6RzNehPTxrYDA9yBz6FCwUpuFtDdC/DJTKzg+CHjgUYwRbxsvZ
	Jbr4/JZp04nuF86T7LRyjnw+p2lks5HI5uKkdYIQ6vE4F5szwXvh38/WBYOtpwDTdSHjgbllUhm
	6BP5HNXLIZX7p1yQjBg7Iq//HZ89cwU5+AFTY2m6iReyHvC5/VM62jr5dfTxyjSKO9E0Ikn7tpB
X-Received: by 2002:ac2:4e09:0:b0:53d:e544:3fd6 with SMTP id 2adb3069b0e04-53de54441a9mr3348085e87.56.1732612340816;
        Tue, 26 Nov 2024 01:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5HwldS99O3ZAEDUq+f4MJDYeNU8gBLmyj9eZdMjoxwaKTjy/KM0iGuvHYmTrG1iI5aRzXhA==
X-Received: by 2002:ac2:4e09:0:b0:53d:e544:3fd6 with SMTP id 2adb3069b0e04-53de54441a9mr3348066e87.56.1732612340420;
        Tue, 26 Nov 2024 01:12:20 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad60b8sm12654879f8f.17.2024.11.26.01.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:12:19 -0800 (PST)
Message-ID: <29d8c41d-ea21-4c35-9ec7-e7d5ef8aa55c@redhat.com>
Date: Tue, 26 Nov 2024 10:12:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/3] rtase: Corrects error handling of the
 rtase_check_mac_version_valid()
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 michal.kubiak@intel.com, pkshih@realtek.com, larry.chiu@realtek.com
References: <20241120075624.499464-1-justinlai0215@realtek.com>
 <20241120075624.499464-4-justinlai0215@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120075624.499464-4-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 08:56, Justin Lai wrote:
> Previously, when the hardware version ID was determined to be invalid,
> only an error message was printed without any further handling. Therefore,
> this patch makes the necessary corrections to address this.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Note that you should have retained the Acked-by tag provided by Andrew
on v3.

No need to repost, I'm applying the series, but please keep in mind for
the next submission.

Thanks,

Paolo


