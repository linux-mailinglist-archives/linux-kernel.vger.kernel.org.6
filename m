Return-Path: <linux-kernel+bounces-572112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD62A6C699
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744B13BA8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6619F258A;
	Sat, 22 Mar 2025 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef1JJ3uH"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B2AD24;
	Sat, 22 Mar 2025 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602080; cv=none; b=Jn0MaKkFapdOBn8n9pI/I6ZV8uDrnDLvtSz/56fH60vGmWBmxplDe6XjqamlbSuwL4vpeCUD3Qv4CeuUykGU1aDEiC8/OXwQJHa3Y57bjYGdiqaOrwu3ZmifED4QcEhR20S5THo42JSbOfeOE+LtUGcJF3FWkL4ooNza2AzcAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602080; c=relaxed/simple;
	bh=3QKaKPMSJD+/egJfzRapWYRtqycA3II4RLMgHhqVCHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKH+msKvgo+KD57166x/pTR5UeVPh5Z8wAc77qJ6F3ysFzLbvsTAWETDZ0nAxsFk+KRh+oZjWwhngUldAGjELt+KpeljguygRLZGzRQboiBlmkffdYmWWbHry+kUq7HaDt/DK6dtk+TuXBzIzvFUy6s6HObN1AtILo3tawhIdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef1JJ3uH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22409077c06so33755815ad.1;
        Fri, 21 Mar 2025 17:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742602079; x=1743206879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EXV+liqXecF19/95E6X4B8HYwLOUANKAp4Chr+5IZE=;
        b=Ef1JJ3uHz/SCeQr225QUNTYzYikh0wdp/SEkeH//Oa+KMSsO5VcVybqeeJ+bP0zi5R
         nk06PVVWpbtSwQB4UG/OqATtJwNTejQfDydVBD6JL6HOLqVvAXA1DmOW4yYcuhJQBzL0
         iiGc1hNg4GAOHJFTy/tlQYuGioo8TQC8lH5Tz22qevfXHhzMU+WqN1ISnN5FSzsdPGUI
         vX8WH38VRE2qMUCQzAJVqHBqaWMjY44t4at4NaGDblLMb6VFVyMqx5makdAwb4NogQuf
         8ArzEI5GVe5qZN6PIm1FxTkv7pCabU3kzJX9M4tOcrg6j7Z8tqRAFhBElu6SZ95mK7Er
         +h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742602079; x=1743206879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EXV+liqXecF19/95E6X4B8HYwLOUANKAp4Chr+5IZE=;
        b=NpH36C+HuqbCVzc5P0pPzzkeUYtTn+AiDc4pTse8Vf42A890u1nO2vVVe0LXmMyGnB
         FxDshg79odHbIFZ5hGEjzXwoLvUYyzya+7/ejPTKTdBC9KKTD/a5+84phDNWyIKVj5ee
         +ESCQ25boVJ5i91PKrb01FsoQbvSJreyTYjdYt5xTfjNmxot5fWLmB1SV1tPNpoOX/aF
         +OI8eqd22qF6haI/GqD+AhUr240DPuVvcwhaTUzbJudSZoAi+epEIKsGr4PILxxh2Lp6
         zvsBBffLC8uLPG2X2N3WLMdL/PU+J+G9aP4o7hkYVxz3NxdLL2ChMRwb6EWyDcIQH8J3
         vBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1UeQldmJ8WMAMdZk6aD66x4JUiCVm9v4hkB9w6UbcA/UTZphd0FCm632Lw6jBu+7rMNn1Lbt14vrS@vger.kernel.org, AJvYcCWvHpyulqpK9b4bKZn/I3M2mzINxzc5BWyXv/C1kA5p3UoPmZeleSsHCNq677OmINjl4VLGuv8xP1/V+dya@vger.kernel.org, AJvYcCXtzrLtdSlYtKK+3vO0sM3RYd+74OiQxRpk905yC1GGhNL2sJIASX4pUxwxR6GmX+zWyZw6LVO0vFk9P5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2pnbhGbhO9Y4GVgjPFLPvmJxyvak+fOEd9OJQRKkcln3QsZX
	MEffvQCUVxgdv5/HlqonVlUi4qycsv2v1JFRhGGhvmy1WbbL1c4oKXHDAg==
X-Gm-Gg: ASbGncvZa2rnPN6sHqJWyb25t/drquMy7WmI+fUelgevUnD02x/5uYIdUiOtGPY5VCa
	Zhxr93/YJT+HvPIUxkxWRiqwQ2oX4gTkESTbKM62zuTM1vqFBwykLuo4rWLK+GJXwAazjJWaHEk
	GI0ZeBUNzKYsx/I7p4hZdulzMct/11IZeWBn/GtTrnaWQAaXigEUyWEKvdwHJInkKfbjc1MkKFu
	roE1z6oZgNNjMuHz7Vmnw8bycgYvJeHGE4+Ci11CYUmafsyHZszz5OIhDzTeOXHj8+c5YnRGZW/
	TujdbSVoIzDc7vU0DE0Qkarxj3AFtuuwC5MTvJw2trP4Hvqk6wdtXdRc6w==
X-Google-Smtp-Source: AGHT+IFG3IzHoUnF4Irysf7rShLOoFBmDOITsQx3iVCYXu5PXAFkhXgqbngY+idRPjClaq9zGMWhOw==
X-Received: by 2002:a17:903:32c3:b0:224:1774:1ecd with SMTP id d9443c01a7336-22780c5599amr67690555ad.4.1742602078632;
        Fri, 21 Mar 2025 17:07:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bd143sm23906575ad.150.2025.03.21.17.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:07:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Mar 2025 17:07:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 3/3] hwmon: emc2305: Use
 devm_thermal_of_cooling_device_register
Message-ID: <f9982a05-5104-426d-b9ac-de4b5c4d465e@roeck-us.net>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
 <20250321143308.4008623-4-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143308.4008623-4-florin.leotescu@oss.nxp.com>

On Fri, Mar 21, 2025 at 04:33:08PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Prepare the emc2305 driver to use configuration from Device Tree nodes.
> Switch to devm_thermal_of_cooling_device_register to simplify the
> cleanup procedure, allowing the removal of emc2305_unset_tz and
> emc2305_remove, which are no longer needed.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied.

Thanks,
Guenter

