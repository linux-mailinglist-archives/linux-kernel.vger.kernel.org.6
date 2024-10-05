Return-Path: <linux-kernel+bounces-351829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1709916A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963471F22F0D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF0D14D2AC;
	Sat,  5 Oct 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXZu8WbO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8314C5AE;
	Sat,  5 Oct 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728129871; cv=none; b=PANDdUWuSCpXlgn4B5mLfqaGvWskCPapiETdVILOPa1YsezW+DIt3y5faABRFKVz9FZs+x87dinZS/6R7ePujJGROmjwhGpmmHqOrPqR0jgiwVREJUhSmcLnSmnCt9X75oNNf6nJFdwVKA4RWV9QDvK745Qm2fPdzhQHUkPTm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728129871; c=relaxed/simple;
	bh=2TAaj1YLgz3mxmfQkMCYlqJkYPgfxM99Z1z+9Du73cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrchPEuWjSRqq+y0CZTFUrNnMmRab5t4d/PqnUmLsUKQmLauwjx9Ksg6jq5u55saEZkJ5l484erUrAkMTO1YMAfS2gIRycMCjjgAFoWZjrz961WsBSk8rDvuzeq8IR95QFeiF6JuF4vc75O975OF20I/EY4xYtE1+9pirIy6qBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXZu8WbO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e5e758093so25033055e9.1;
        Sat, 05 Oct 2024 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728129868; x=1728734668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2TAaj1YLgz3mxmfQkMCYlqJkYPgfxM99Z1z+9Du73cA=;
        b=OXZu8WbOrzQ51QEGBrp6nY3BG4O3KqBTnEui5w8pEL1GqtgZwyDQ9BDVETWz8DwXYF
         j6tx3xOcV5DQu0YhmftOlZpHBBXtbgRIMj2AQ6DoSaavpk0ALh3Onhl17cFwmlIckfg3
         egFdHnX++vgKe9Ta4aB+JHjH25LqvSIULRUVTIMiUXKEYbyG6QMpqCS7HDNEupj3bqpi
         UKCzo7KPrWrx/jCmJNWgbVShzwZp16LjhHJpfjzBP6uRzOTIQOX8w07oPSdKJbzUeLnU
         w0NdW5Tivf3ZqyH7LV/9VOaeuTRX7BdxmEj38EARIcgznOKlX9PPBQc6gsD62lTo4tHC
         I6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728129868; x=1728734668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TAaj1YLgz3mxmfQkMCYlqJkYPgfxM99Z1z+9Du73cA=;
        b=GAKDObIVY/6cjJhPjYHn7flRreenEVq/XnrRYYwAP2ztoMGqK29or4/N3m1SZ+wqRj
         csLTazW6q74dawayYEgaomR7lQEWPQFidbCi5DpmDgkWyW5lmgBG/b0lAHSSv86L24as
         BZAZGI96Oqt0ogva2fttB1z5Q5QSvQZs00BzbWWHYHPETaoSOzHQbJGKEYJn9zTYqJtn
         F6ifpNiF4o4YWgwoa685yxjFI8TAdhubD2jCP0ihKiFCCi9gnYb0wdEg2LuYBI90O100
         tWJYQjsFVCSWbI/NP0qjGHeS3jKMbz7H3ZWAYlJpHbCXR+/VBn8z16sV5vkJ1rjMhThx
         xtWA==
X-Forwarded-Encrypted: i=1; AJvYcCX+hmcb4nABkkyFTesdpZ8fDkjUTWdeqTFt/KDllppphRRWNxCmDS+/BLZ+XATQAS2mMAnLTy8pUH4gUb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BzisDN3nFyASf8rxsvznygjb9L6mdNcT3S7Slvp+IusomdXt
	HJGNI83CMfGRSz2MTjnygKFz9nNhsN4XAouD6tvQKFWVrQSnJ+vX
X-Google-Smtp-Source: AGHT+IFlbyTm+8NckJvUfF1ruPrA4q2PYxQGobPnRDCKz0h74KHrV91HWZEjbKYMipL4r6CBjrH6Zw==
X-Received: by 2002:a05:600c:1d2a:b0:42f:7ed4:4c25 with SMTP id 5b1f17b1804b1-42f85ab5db4mr43127545e9.14.1728129867892;
        Sat, 05 Oct 2024 05:04:27 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed9d4bsm20948325e9.42.2024.10.05.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:04:27 -0700 (PDT)
Date: Sat, 5 Oct 2024 14:04:25 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Yanxin Huang <yanxin.huang@unisoc.com>,
	huang yanxin <yanxin.huang07@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: sprd,sc2731-efuse: convert to
 YAML
Message-ID: <ZwErSQIKWLdOjmcc@standask-GA-A55M-S2HP>
References: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>

Gentle reminder about this series.
It's been sitting on the mailing list for ~2 months.

Stanislav

