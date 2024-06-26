Return-Path: <linux-kernel+bounces-230148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39EF917917
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013B41C22F00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ED015216A;
	Wed, 26 Jun 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD8uZLf9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A510F4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383853; cv=none; b=J2e/wA9IRCNcicx+ZjNTM2HYBKM0qQuz8lztzZmnH6IRNpFpvyKU+3TQu0ldFhpEfggasTVRjXI36t8ZkkCNJ4y7GQHUvUKMIVhr+LvZ1FwTXF4+YT46C9DHmpFMLbZ6qOkG/xfc/Q/Sflt/9oc6XPlVv02X3izg2AV/xd6W0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383853; c=relaxed/simple;
	bh=WjHIinQIPpgmVadzaOYL2FN1a05qHYAYurKuBSI9Ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAOXV6u5j1kKLLIFrGOnacv1yLrQuVD6pzmdZKkSxfFwRUMUhwrWCH4dgFONAzFeLwwqE559tTK+mBHcKnfCn3lODgW9TToRsKwwhg8UCWAUU13L+EsDSJvaxUdgjOEl4uAYZzMHX9iSTPt6oRjr/pgR56ZQGoV2zUeLIpuy6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RD8uZLf9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa2782a8ccso24230825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719383851; x=1719988651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WmbxbHO00C4vKFOsHsy0MXpWKHaZIqKhcPiT++FQA4=;
        b=RD8uZLf9JrxlCSwyUBYwrU9F6qMHxqWHvW+eQd7TqoAIkZCq3Y1evjLDuekBOa6/+O
         WFhHODjMkNadaHSEYzrDXIA2BY51tVkiZvcd2iupsueVxwm+1qR5Trcqo1JuRZ1aA7Ua
         EgAT5sVR6LcgfHeFNbM+6GJhpP1sKYi8RRCSEP0v9+L5scU85scoEjCYYNPj2TDZRpHJ
         UURgqU9IhYHy73+nZ1fkMzVK+/O3FqmmI7kgJqYQZ4WRK/mknGeWbxpeN8iq1Jna2M3K
         k8zm1QnKNpr5vBDEZcO71BKgaBX+wmZJLGGFGd/2wG7dBu8T20Swlj5Lu6pABlYsJ/BG
         i02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383851; x=1719988651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WmbxbHO00C4vKFOsHsy0MXpWKHaZIqKhcPiT++FQA4=;
        b=gdMTHy3VS3stRqqYXcrLVNqQMvbD9XcPpc9Cj7SmwtdStzH/EkECzA66wya1V3Wvv3
         CqdUsNNutXbTtShHaA6mpaT4LNPw7soejB/FP7YJh4hevB7/6wb/iLRUSfIvUKtgHdad
         RWRYo9fXQhR/WwGfpl40qQHVrSDMHho5zBezV3gbRcrVXhC3T/ivtd75hEcrcUheY2hZ
         5NyCU4n+hIiFVMDw1i0geUgVXWSCjuZq28dUPJcJy7INgLa681kSzz0KxFr4bunEzys3
         aSz/xTCyBmCp5MMmbkxfm2E7dZkB7Ttf1ors8P0Nded6qUN1EMIOyYWhMqvVsn8g158I
         Q7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUgyml3eqo/FGBAGOOdhglNWH6My0CooYYAmvqvBlS663Io15oy6xPO6jTxbb1zVSG76N0BAATycEmc55DkBXCN9skCgSNGA65b8M6c
X-Gm-Message-State: AOJu0YxdI5z1BJqc2oOG3x8WONZe1QydJu8OIly4F1LMteVo2gZi/ete
	wgDzpKqDRLqNAFj/sn31j7Qvaj/i1WVJjtFxm4UOX9Ahse/GkXUoEFMFpeVSvWk=
X-Google-Smtp-Source: AGHT+IHPZ/M9X+i2/I7Go5isNU7nO2ti8PIKw/zBI0W44C0AvL2ALmu8+bSPbMXV8uPWpintZOHa7w==
X-Received: by 2002:a17:903:2290:b0:1f6:d81e:d0e with SMTP id d9443c01a7336-1fa23bdc4b0mr110254425ad.5.1719383848988;
        Tue, 25 Jun 2024 23:37:28 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa57a205b7sm38302105ad.112.2024.06.25.23.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:37:28 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:07:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] OPP/pmdomain: Set the required_dev for a required
 OPP during genpd attach
Message-ID: <20240626063726.zsnj7iasl4y7ic2d@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-7-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140849.368580-7-ulf.hansson@linaro.org>

On 19-06-24, 16:08, Ulf Hansson wrote:
> @@ -2393,8 +2392,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>  			const char * const *names, struct device ***virt_devs)

I was expecting that we can get rid of this routine completely and OPP
core won't be required to handle this anymore.

-- 
viresh

