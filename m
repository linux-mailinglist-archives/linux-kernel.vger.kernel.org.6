Return-Path: <linux-kernel+bounces-392393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AA9B938F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE8A28336E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EAA1AAE10;
	Fri,  1 Nov 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+IulWqz"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1581A7273;
	Fri,  1 Nov 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472301; cv=none; b=A42dIjEoVHEbiSdYRPwonM9yYwNxt/wQjzJy+tuTj/ZEtmHzu1/pAo9tTuYLHAcHUvzD+M/tmW3uyf51KsXIIPRLg77sPiGL77Vv81dPl23ztTYuHhhVoQTAtfkv4H2K9SrfUUtdCdkXBbcueV8F/Vg4H5KvqhHllqXseaBl7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472301; c=relaxed/simple;
	bh=XrPLkYhc9KMv8mJsqXJQNqryPfxpatNX1XegManFB6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4plnAaepV2AAcudNrK2zbjcUPjaJCnC1zYVzJp9esDSvVj04nFyZoogU5F1sJwUJErE+lVn/lkonQ3m6Ej1mMPSdSIxPqy9HwRx2bDu6ntPkNBfkhVr2T/RhV/2opldw8ZtRBpgls3x3I+fowhh44zt4JOfeXPAncJqs6DCXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+IulWqz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1815444b3a.3;
        Fri, 01 Nov 2024 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730472299; x=1731077099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFB9X8+bXdjRMgra+BnrPwuOPpZev8yICCAZV0Ubx6Y=;
        b=b+IulWqz4PsD2BjLWEnMbMkVjEUtlb8ln8ZbWkQxOkwN71Yvvnj5vVLGVju0EZBzLe
         K3KVstRcczho8m3+Vynmc3B+uBpYC4WslRN9yIteJBgCZ8dEZXgjM4wbeUyAdpYkbHf4
         NtpNrDtr0K/094819MP4SsKdmernRD/4rlM2qBdc/SLkyx+vjrgCDLYp/zfoLlJ4WKv4
         LaD9fkY8WBhhE7zyvOjtU3E/hdbR+oq0lG7CKzqp+XwOnjuy+Q+CZCpCpLxS8RQNlSL+
         kL/nFskBI8LekMqNWWzhRDWwUBCFrov3uMtN9SSNbZr31RHZBHLY7HI/mTzFFt63HW09
         pWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472299; x=1731077099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFB9X8+bXdjRMgra+BnrPwuOPpZev8yICCAZV0Ubx6Y=;
        b=dO3Tg5Pw2fQDd/AWoM6brFvjChwcI2afx6IQ7TqCI+hDG87FTDiAbuRX9e3fKAFN/t
         u7ANx7zy6zzeXGA+OY1xvpU7vhNO0wHvK+XFfJXQQ013fVUr1qpIaWkkz44duaLEeySI
         cuqTNEIqsfiLPiQW9iSkcKQ0Sk2l2+vfb0SF+sNXqTVlq1+sczkNMb4vfYtQ9liFIPKn
         +BL4MsQmP0krE8vm4g/nb85YjrFkCj8JNEFAwku7zzx4x41Hmo3XEp8afF+Fpb/GugTC
         Olvepemf91fSaUNRXYp3HosgvyljxuwH+glh4N9FQXV8rU5ilCk8GrOStj/HCRAXUSle
         DykA==
X-Forwarded-Encrypted: i=1; AJvYcCUES1bW6HBUfTbuwvPeVv3ZHS/VNenadiW7ciYlLsEaBV/ld0WuPrlYl/irutK4y+5yCHJpc5OdOrcvinGq@vger.kernel.org, AJvYcCVB6UOYHJV9uaOpmp1K/17vlwYWwNSbAq87S/9mYbuzO2HFJJpAFljGxx4UWAnxR8F8RrEe8OGd96IejAc=@vger.kernel.org, AJvYcCW7HKE50iHlRumLvdL9wrMxwyjClMK5kKwxQ2kLVoJ4qjdyXsCDn3742Yj4zoAUnLctnSqMTigZnGSm@vger.kernel.org, AJvYcCWvTpoTtMuuh4SpkBP2nvSRoqpbxz3ZCkmNwFxEcxUc2MBWRAd1AfyCxwt+FJvtaCsYvP0NKA40+XT9@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDaZnc6mABbZNnL7whElhJqVYBR5oVBFhLAxQiqYM18Qdz3Oa
	vjB+maHrQQH5YKrZimAKG6SJUBx5j4eIBDPWcnz/R6CLsaMJ3fXHOV11lw==
X-Google-Smtp-Source: AGHT+IFZY3czgShWLwMr8vZLa84ReNl80JQc2dqSAqMUDR9vtbY6B9GhV3hjeKXgXWBUnMGYXjB86w==
X-Received: by 2002:a05:6a20:d493:b0:1d9:111f:4b46 with SMTP id adf61e73a8af0-1db91d86c41mr9750731637.12.1730472299120;
        Fri, 01 Nov 2024 07:44:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5625sm2693424b3a.53.2024.11.01.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:44:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Nov 2024 07:44:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: baneric926@gmail.com
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com, Rob Herring <robh@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Message-ID: <9435b7e9-abac-4d02-9969-b35a50fb538b@roeck-us.net>
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
 <20241022052905.4062682-2-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022052905.4062682-2-kcfeng0@nuvoton.com>

On Tue, Oct 22, 2024 at 01:29:04PM +0800, baneric926@gmail.com wrote:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> Add bindings for the Nuvoton NCT7363Y Fan Controller
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>

Applied.

Thanks,
Guenter

