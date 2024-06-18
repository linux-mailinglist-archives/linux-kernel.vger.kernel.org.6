Return-Path: <linux-kernel+bounces-219729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF790D6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0350F1C23F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6362A02;
	Tue, 18 Jun 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5GUKMkp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436AE2E85E;
	Tue, 18 Jun 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723636; cv=none; b=ndVyMwXIlsvEsZ2E8K5ek8k6MJ1/Ub8v4lH+dpM7e596nQKu0LX/JUrBKLE9Dth4lLCffBhSq37fi/+hTKjZekKE3tOypNVlmgv4DPQPDajssZ55EasqdHcvSQQvM4ME/gjABe8XL9W4nXPyCdtnkAGMlp85qKacV0u613AORDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723636; c=relaxed/simple;
	bh=y7vvC69wYoXFh3sTRtpDlYAeN1SgjDNrUTnRnVw2VE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZgqCoVHnhQaekeAErT36h8BmWfwY1YcfSDmnBsv99zoxjnT3/loLMkk3FK+jvNtXRqUPebIBPANGNwKSJrUa3sMPmkrbyOmJ0xQSEz9nTPqtQLYn3DBCs3wcE/TtKJ1UjHbj6Qyv/o7Iwee5IkbADvpOEdg1LJQlCr4jjv0PRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5GUKMkp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7046211e455so4007409b3a.3;
        Tue, 18 Jun 2024 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718723634; x=1719328434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BatJn/gnplUVEPVXO05g6NGph447Qfn+Qkz47NvoH0M=;
        b=H5GUKMkp5ilt4KjQ1B94zisqyBeu7jN3zkxdHasEuDqvSKL1jkJmUPim2hYVDfx2WF
         zaoiXH8Tn39/8DRUzUbL0ux5S3VeSP44kzcitSpF9JEQX40ZthRE0TjZGyluAQc0cPWB
         YSeVn3HnPxXGN8P0xrYlmOyFIGY3/guc0YLKDCwV/H2Pt1h2Wo81FWqZXdhxwxwPbNWL
         hfIchTvrDx1EIX9hT3GhtrL3iML5a1B+RIUzyN2SjVNobTvRDzwoDI/LPnhLkOBkPVJF
         WL8objvVf30dBaC11sGRmdsRmANUW6lsV8tTvX53tYgnzJshlEFPSMMHOCCLG7GdD7IX
         3erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718723634; x=1719328434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BatJn/gnplUVEPVXO05g6NGph447Qfn+Qkz47NvoH0M=;
        b=YVX7S86QIDRLi+WENKmDj+kXPttstD93YPKKMp73eu47eCdSQ8rqrV14xTXuo/qLcD
         F/U+WfmEdYz0bZVbr/wxXmSwB7UG5j8Ylc4ytAtjPvqKM58QBjWvswS9ctBk6a6XMXLy
         kx+YbD31erdn8cL7owq/MfLtwRrUScZ0TYvJgrAOoXM9U4AYfvYmO9TPcCNllabAOnXD
         ICL1g+Cn2EYjCH7RB9yZK0Gtg252wKBc+6M/ITilLCY5X7otuuGE0fg8ph3wOGOqSunV
         9E+TIqgpxR0iAHLNgHRrEZKunaO4sxijvSWfvoBhOV8lut7hrsAYuTW+MjEaLgau6PKD
         07pg==
X-Forwarded-Encrypted: i=1; AJvYcCUDwqMOdHJoQtmry7P2cLIgE6DTqgpRxqOHXwSiAiB53LmAugGnIT/mtAJ0Mn4JnmmI1N0NH7jJ7kPaagPm8/GoFD+TO1IX3rPf2PL6L5g2UQRk0J/h1Ry6gmtiNgGYGMeYNFaQNl5g1Uqt5S6MGpGsBuk3oUp9lUL2duf/kj97KuDB9bZ9
X-Gm-Message-State: AOJu0YwM9BLTnX2L5JGyBKz3CdvceJU7ygrf0KSVIxeWqCLaSRLc+SLB
	Xlbso0vX2Wc5ERpU3yXJn31t+2z+j6e4z/OaLPqtjxyBFNZXyd5hNWeVRw==
X-Google-Smtp-Source: AGHT+IEAXtFLP/7/Rh/SKpEwtUJtDTtAZEuuIAFrKujlLHqWNnL9ZuhQKY4jFG+HuLTkss9LPHwk8A==
X-Received: by 2002:a05:6a20:7348:b0:1af:e624:b9b1 with SMTP id adf61e73a8af0-1bae7ecefb8mr13622145637.21.1718723634379;
        Tue, 18 Jun 2024 08:13:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf0bef16sm8156304a12.43.2024.06.18.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:13:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 18 Jun 2024 08:13:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: ti,tmp108: document V+ supply,
 add short description
Message-ID: <eec4e16b-912c-4df4-9a7c-4a55e1ea86e5@roeck-us.net>
References: <ZnBmDXfnDQXNXz3k@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBmDXfnDQXNXz3k@standask-GA-A55M-S2HP>

On Mon, Jun 17, 2024 at 06:36:29PM +0200, Stanislav Jakubek wrote:
> TMP108 is powered by its V+ supply, document it. The property is called
> "vcc-supply" since the plus sign (+) is not an expected character.
> While at it, add a short description with a link to its datasheets.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

