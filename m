Return-Path: <linux-kernel+bounces-570756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7419A6B439
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221F417E9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD311C5F1B;
	Fri, 21 Mar 2025 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qd8dj05E"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8DD22611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536913; cv=none; b=GvIsK0rFCkiO2CvRwBVnBjZCWjiu146xLOnPOCa0YYW6B3Um8MulIEMf0C9jmeHTZim3BjcJGgb7cBEp3tc0XIa+1waeBno58l93SaKlDiCTytNVLlpDYJ/lQbZkbMfkeAb32UAlSpegJ7X/vgJDOiEbNYZcbb7y6ZSE2iEDMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536913; c=relaxed/simple;
	bh=+RAqoCETRsOOC9URTvVVr4hpHwTaKDmnHI/bW0iosXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2FOcTpQXImNDdCmH3kC3Q5dkBGAIu0XC9UYqSqthuCpn+VTXVxYiAIniECp9TUyVSSDyhfIhmvpmipOC7EZWvJtd5saH5TtKSvrTsAq++plJCZzOf5/gFIQ5SdW/mzx+JhOv09Au6lBdG6lVRni0OxigBKIGOzcRgslWHudlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qd8dj05E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso26700645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742536911; x=1743141711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmB3zEarsAJrwCcZCi/AJVx4uS/XYfMGLk5IAPZ3kC0=;
        b=qd8dj05EbFr4OG29YIQKkXgH6/f2fX4oJrCVT/BNMVCcnSvnCuCscQhBcDQm901f3Q
         RQChsPsa+YDKj2jlC5enGJ3/HQUVgyy4yoq4UqRJ7IPretxJ9E7hXCZVinudbyX4o79X
         M25+MlbwHsHpHtwuyI29sB7WhcYox7++oxqApjW5+NWWeAr1Z5qFJGAZPpqc8HuqAfyN
         cFTyGZDVWMY7dIl1fx3VusTBqr8VT42kEWfNOVlqF48QO9y6vxTw9YRTEEd93kaqBMeq
         p7PCKfLVvsbx6/Nyc15y1oFen57pEnw4S5o9mJHF3kQUT1dn4wQRoFFr0doz6tVk9fGl
         ZdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742536911; x=1743141711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmB3zEarsAJrwCcZCi/AJVx4uS/XYfMGLk5IAPZ3kC0=;
        b=YGe4IDkGwgbF5REyIDxennhkiFz8GXd0coJXO9zi/Pqd1et7hNnCdt6OJHZLGrq/la
         m0MjB6Nky2/O8uPpDko+IM3j0LHewgPCPigpB9KaRNvDPhVuZydEDzjexvTpTzggXbx5
         wsVEIOVPuFKoV3tgRCLEJT9c5Nuwcot+BzqolZNAOYEzjqHL6WmP5MeZ17uCX5Jk3+UG
         L7W8AcgzJ7NSPLZmiTa8BIp1VioNpvJVSsw78iPxPZjmbHOVr6V/VffPK4V4gZsFyDEs
         VXle0lA/YiqYkcRaqHaX5iwJveRAx5qj42iG+rWcBNwFD24nYcq7uM9N8MELZ7kAp4x2
         8R0w==
X-Forwarded-Encrypted: i=1; AJvYcCVD3YxVyHFCssWUV0lIu01splH6KRrHKF0iccN/xSkoiGZtp+ANPHtr3iyqbbCZcKj+zXTSk+A8idpL8TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdheuADE4JfboS0Z/+aGEKxe3WKGzUybQfUrzGCY2pD0Q8Fud
	BdOssL3VX0rCAadiyJOPuCnAGGa+yMONQCo6pmJvPNajGCY/wZnt9cEM7gtlj58=
X-Gm-Gg: ASbGncsHApFd3AIsa+COUk7lEnF0McPquyZPNIQ57dlXszGJEsFRzGp3X3tzvchyDIC
	he877sldGFfbr9YCVes5H1dICUJnHsyv7ZV8FbwviQ4MlO3OVsCtlqajLVcMGAZ76letZA69+oK
	krb7QPUPBCGsGrLcNsQi6PXNQMwrSBYRYnKd/D+f4yHsrYtxDMeuT622wvdkj53UfvJJ6rcj9qm
	u1TG+OuwJJGh5NYiUxWQBhWFNvRdBOjYwW2qy0l2Sk8tT/usLk2y0epBmp/358v5jHyTpRRJ1J6
	hMeNpqdxHwEm856xAcTgMGtyrJHLhl8RMlYlen29IHkveeIJh5p17Grf
X-Google-Smtp-Source: AGHT+IFtVqF1ORKmDSsfR3TArM9faGSxKWG+5TBHlY+RPgM/7ilFPFIlu4kDkXwHLe/srNdTiQnoFw==
X-Received: by 2002:a17:902:ceca:b0:215:58be:334e with SMTP id d9443c01a7336-227806b8e47mr42530375ad.10.1742536911081;
        Thu, 20 Mar 2025 23:01:51 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da89csm8204645ad.193.2025.03.20.23.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 23:01:50 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:31:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>

On 21-03-25, 05:32, Chun-Jen Tseng (曾俊仁) wrote:
> I add a global lock related to the CCI driver.
> 
> This is because the CCI needs to obtain the frequencies of policy-0 and
> policy-6 to determine its own frequency.
> 
> If policy-0 and policy-6 are set simultaneously, it may cause the CCI
> to select the wrong frequency.
> 
> Therefore, I hope to change the setting flow to the following:
>    policy-0 or policy-6 -> set frequency -> CCI receives notification -
> set CCI frequency

Can you please point to the code where this race exists ? I am not
sure I fully understand it as of now. If the race is present in
another driver, CCI ?, then shouldn't it be fixed there instead ?

-- 
viresh

