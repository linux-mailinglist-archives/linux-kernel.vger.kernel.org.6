Return-Path: <linux-kernel+bounces-415698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904C9D39F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3091F249AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F21A2574;
	Wed, 20 Nov 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJ0TGcz5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541219E7E0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103553; cv=none; b=BdUJgfeGtaGQZaEt//ehJSojXyZsQ6RfH7xsgEUdN5yhpReTyQHSpXWaBhAxj1crLt6jf+SgjEvA3pqjr03dkl14AhfuHM01T70ryC3NdcmlT6iRPoLKVQBF2EoEILtx2LQ6qTbHXps8FhjTpiLoxyYJhIG21Oq8JUHEpYLtAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103553; c=relaxed/simple;
	bh=R9P/mSKOsQgDZHYSnA6xvbU0oyS2tzJ046K4Aghxd2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L581DerjPoqz8u3ttdUsXxO38VBksK3iPdK+cfz5vFYO8sQIYGadN3/Gwb+Mb/bFNp4DasM2P08BHJRamQNcU2PQWg0zeDmasad9i3cNluN0UO/AuAKqlDHp+Nlql+5VzxaQMmrC/rE+aQhy7HdaN2kv3KjD2GUBmEFd9jqLtkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJ0TGcz5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so2560953e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103550; x=1732708350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ym6sQ4jNg6NAz3DL4w4A1dXlDy5B9Kp9zG6VDr3BqNw=;
        b=BJ0TGcz5q1jVGUYMzP+XIjLQOP5iJgCE/qcWyxHCxuiPmQj8baB2jtWRcpPcDRvkJW
         BcHDPVA1Ov1VVJDkM9oqMu7NlMFRCekw/5s2QnRtYIjjxbI76yZgc9dLTFAUDv+usfeJ
         nE5ItDcdKc4bIpvR/c3x2jShnI8HLtJ1Q+EbzL54Zi6LaYbJRrmJQR+uj7o9shmlQk0v
         ZoWOILwYkjcyE8T1MyfumZQlHKU9Wef+XwC9VAzRRDGV7iJtwZQZWNLw1kGGxJc60Zuc
         gUlz7zky2fZvMzcY7xYF6q7tZHa3PGzx4zIzUsB1tX5+XxxjQ7cv2q3RhWkZFh+pxj4a
         92+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103550; x=1732708350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym6sQ4jNg6NAz3DL4w4A1dXlDy5B9Kp9zG6VDr3BqNw=;
        b=m+8SvnDtj7w7OgOt7dS8ymfMvT67NmACgg8/ciTdlVZnVjOnSW87drksASpiF6Gh2Y
         WRcfM2zK1hkaJaX76oa51OjvhdSuB2IVqTD0nbxBdlCcVi/g3wjCGMHRYw5XeA4Z2FZf
         8l1xDp2NzMBX7XCqKiXOpn/zCDyuGbYefc+jVrYp2asZhUt/7MeZO7vFXXbwhepK2+EL
         okan9cr3UF85rmmHCm7crlbKF8B4/XbhPTP3Nuo53HJL5UdhvEQNXwh7o2A7xiIz3hFP
         aqTLB6IMxWEEiQ+LKsgjZwJ3+JWMMCtYmIHhDkWxGHrpfCGP3Eiq03sZ3sE88re0OahK
         hGIA==
X-Forwarded-Encrypted: i=1; AJvYcCViupaMMTqRV8jerm6zNVjkXQcNFa5O6MwUOowNOZ5YKaf9uCZcK/T7j4I3fbG+IP0VKSSbmNKvlXWmuaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgdz245KZnmsLml7Qu9Gl39MWL+EM0uJVoGwU0OtLI7Mnje6G
	RpYMIzwWVEIaxQ9dVqnRwN15cpBNuC3p2BDaFM6rsCK4C2zQV39UuEv+YMnW/5lD6NDcM2B+2ox
	B
X-Google-Smtp-Source: AGHT+IH796j7yJ4hJd+DY4Ty2sJK0Q3wclTgxvZXjdfjeBOoVzy4zpbN0pmY5gJ/fhN9fzUW7ncZOw==
X-Received: by 2002:a05:6512:3da0:b0:539:920a:f886 with SMTP id 2adb3069b0e04-53dc1372f70mr1037471e87.50.1732103550487;
        Wed, 20 Nov 2024 03:52:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd478304sm613468e87.233.2024.11.20.03.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:52:30 -0800 (PST)
Date: Wed, 20 Nov 2024 13:52:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add support for QCS9075 Ride &
 Ride-r3
Message-ID: <5oavwg33c7jj227df7fvuw3j7l5t4m72gkf7a6qpfjej57kotj@u6ze5am4tx77>
References: <20241119174954.1219002-1-quic_wasimn@quicinc.com>
 <20241119174954.1219002-6-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119174954.1219002-6-quic_wasimn@quicinc.com>

On Tue, Nov 19, 2024 at 11:19:54PM +0530, Wasim Nazir wrote:
> Add device tree support for QCS9075 Ride & Ride-r3 boards.
> QCS9075 Ride & Ride-r3 are similar to QCS9100 Ride and Ride-r3
> boards but without safety monitoring feature of SAfety-IsLand
> subsystem.
> 
> Difference between ride and ride-r3 is the ethernet phy.
> Ride uses 1G ethernet phy while ride-r3 uses 2.5G ethernet phy.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

