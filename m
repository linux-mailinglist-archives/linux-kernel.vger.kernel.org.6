Return-Path: <linux-kernel+bounces-175080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA78C1A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD45E1F24217
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475B128373;
	Thu,  9 May 2024 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtYPG1Ts"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CB81741
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715298199; cv=none; b=TsDz9rvge5wVzOYz0C9BZN5zNmZE92QML2Od0kF7pnzhOa2iAZ7JtsgCZA1O+MtK2ISMwHraOpBakHZ0xOFKWjsTrUju+ffLtNxrpv+KxX5LUzen6m0URq5nJvhSy1ARDA/zt6Y2qSy1Gf/5Bg4Jusi2+lcE0XRTB3b/7npyEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715298199; c=relaxed/simple;
	bh=tR7u35z/O3DzUlNxDohM6rNNIcQO7MsfbTygHbV3Iko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO2vVxkVpDzRxC0sVvr8l7BlddZWiiwZPzv8ysfcgmTdWvBlCt0Y89scXhPBKqrIdDGT/IOpRxrDlbOzy3kIPuVPUU7yVSO7N4b/AEyz8fOGhVvMWr8PeiYp73qY15yTvcEQ9XzfAD4OjljdhjuAP0sfEhiDj4BKnibwCWa9y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtYPG1Ts; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so5690025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715298196; x=1715902996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sTIErt9M9JswTN2jkwtlH/RNJOorHYqcXTsUzk8xHA=;
        b=LtYPG1Ts7MAQeN4+DcH+3VjcIDouBkIggf1oNcmllIdc+n3AKeJpsKN8H9d5sqU+Gd
         9YZ+olAIogAhdjL4Q6FmSROU7CAy9gdZqUu5KYJxd6qbRsAhndZAre0ySrE85/jUbqBa
         tviEf5geueHl4eMe0w90XHpqbw4tVSv7mEthPLHfYuhJEqzWLVZg7JgQJReUJOQOKSfR
         OgNCq9RwzAYt/L1ePGgDr4UZYen8gXiigXSgwgvFRnY9lBRqgWOcjSVCy5SkuR8rGGNJ
         2BO1716vY5jINKcWPV0QmKm1L0T74ACTebULUcYsK88+u75xBX/QvyxTR0YoghxiJNoh
         TsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715298196; x=1715902996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sTIErt9M9JswTN2jkwtlH/RNJOorHYqcXTsUzk8xHA=;
        b=Z5N8Fm70qct6kASjJl4D51i9uV4QdtyrPkyT9t7CjV2FaKqIJHzd2cSv3WR77mXObM
         VJwkqEupyBJ4Xm+Gs6AOZiKMazWoMaGDMM6w44kfSkaEPnoErNDS3xYPNkSJlImNOVt4
         VUCSssUWnbyX5S5DU0knuOA5BeSkXcLdIEiUzkvmZGwwuXqE2y5Mq/TvXZ34sjNw6v8+
         GwJe+PJWvbpARUIk8zhMxkgaA+H3GJ/E8UmVnPbonPBw94AyAvsr+GrDtRZ3kPXolzeN
         CbdL5kJDeC0WnnyjGW4O3gNTPDnErKFFgoBYLmVHKQ7sw01GVNxCdsVvj0WLoA9n5oxA
         lFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGRa70o5CEblsTJmNMTLx1Aqo9dn7KzEuBhhre7LOTze77CdMfa4uhvS/Z+YAyB2ST5g/FCbkByORm5ovTtwrG1eHK8RkFirgYBJW6
X-Gm-Message-State: AOJu0YxvzRYwc6GRQElMOeEVhxqoudV/ofoW5MWubmmc2y0K1M6qhq06
	64DvALHS4s2juz4lq+BJF8H+6lUe/ar+Yb842/jMKtViP9xFamaHyK09dg7+tWU=
X-Google-Smtp-Source: AGHT+IG8b+2tz7hbEPlBkghjB5Anfa+zpDUXWfEE8VBKaJO4wF1nKq8GtQCyZaOn+d+NiX1BJAFIug==
X-Received: by 2002:a7b:c412:0:b0:41b:13a3:6183 with SMTP id 5b1f17b1804b1-41feab40c32mr7572955e9.24.1715298196057;
        Thu, 09 May 2024 16:43:16 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25d5sm41222755e9.14.2024.05.09.16.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 16:43:15 -0700 (PDT)
Message-ID: <81a50925-0c38-435c-b423-6c4c97486b2a@linaro.org>
Date: Fri, 10 May 2024 00:43:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] media: venus: Refactor struct
 hfi_session_get_property_pkt
To: Ricardo Ribalda <ribalda@chromium.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-12-7aea262cf065@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240507-cocci-flexarray-v2-12-7aea262cf065@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2024 17:27, Ricardo Ribalda wrote:
> -	u32 num_properties;
> -	u32 data[1];
> +	u32 one;
> +	u32 data;

The conversion of `data[1]` to plain `data` is fine but, the conversion 
of `num_properties` to `one` doesn't fit the naming convention of this 
code which uses `num_something` extensively.

Please retain the name `num_properties` for that reason.

Then add.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

