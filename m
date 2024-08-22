Return-Path: <linux-kernel+bounces-296741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D495AE65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C831F21319
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7C1537C8;
	Thu, 22 Aug 2024 07:04:02 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0014EC5C;
	Thu, 22 Aug 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310241; cv=none; b=kwo145rMXsx+BkLHJ+il9SKm+KgvLxfkkqA18ZmiUk4r9+04o7WJBzl41739h+9qTfdbCJupg37p2x6Kz5R4xnGCJXTGX017UgQz9VHqHLXjBG9/jyql40MnTk6oafZUIHK4ifJ5cZ08/AWJR0pxVQDWBI4lockuL2UoWaJV5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310241; c=relaxed/simple;
	bh=0OUiYBTYz4oLdID1hp1Q3hqIxxyDAqx40ZxJ4IV9yfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGKhVnzTJBQYKIk1bxNQP6DY8GVgEQ3KR/zqoIIn4nYz5C/l1NPGrHoVS8RP8p208ojtkHwoAP41czqdwg4cBuGNMUHgH8Xxxhs07BDSCCXtZd2TX93WaZ6HQRwxD2QX6kaYO9oHjCi66K9QL96FIIUcYydGylMP5qP1F9FOimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42816ca797fso2967445e9.2;
        Thu, 22 Aug 2024 00:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310238; x=1724915038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Khx5nzpT3raBy31D8+7UGnIXzDyOjDeoWckOKCUba4=;
        b=QQKfQB7cU9ajtXNkXR3ggxR8s7r777aMtf8sJqScvWDAQbehUsofCFkC/3vPVTERLn
         LK5JQtH5rh1URaYGe++oFktWTZJj8Xiq3+kFipwHE6jkYggq3JLMX/nx2J5xPIG+U8n7
         +Rt3TzKShZaRU19G79C6lGU4GjrEMBbVN7fDd9bYGWGY8IZ/Ex7l6NzQr9GxX7qtJuYB
         onfzXnerZ+l6z1wenlfAdcNcom1l7HYFOwe9IcXBJ5uhCv9CBKKH9f+pBKwF26xaSnHO
         uwOd56t51b/HuRwriZsDTsx/bs2i9xGrt3R28Kqy5Ax+Of6/xprWk1yThhuJZCLeFXET
         Zp3g==
X-Forwarded-Encrypted: i=1; AJvYcCW5kZRPPexQe54+NDt3uAdJF9LBBo8Kmi4xCrhJse/9Bv2mlmXiLjBtvU3G7cck+SRaLKQVgywixVAmD8LL@vger.kernel.org, AJvYcCXb3ct07f+DLzDVPK0jQbf5W+EHLObucoOjDvuENvmBn80W/ryLs6Gc9eovMLKHpNAHBVOLMKRjUsCK@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVbEAL37I4UU0YNAkD+pz3RFuiRlY/q78kvHeOS756+LLeeQC
	3dAUOPIduoMVTRN/McoexIkT5riAQVgINCv4gW+OPRktHY7wu2XW
X-Google-Smtp-Source: AGHT+IEXXiHDWi5aTgV0Or64b+LypSubUzhwenYosJv1sTe/V8fBea7ezUv8rGMBVQcOqUpIkp4nAw==
X-Received: by 2002:a05:600c:358f:b0:427:9922:4526 with SMTP id 5b1f17b1804b1-42abd11218fmr28255955e9.7.1724310237850;
        Thu, 22 Aug 2024 00:03:57 -0700 (PDT)
Received: from krzk-bin ([178.197.222.82])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac5162505sm13749665e9.28.2024.08.22.00.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:03:57 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:03:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER" <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/1] dt-bindings: extcon: ptn5150: add child node port
Message-ID: <dbgv5ovohwlfoamgt2zm6ynorzxh63355m2vtxvnpt2gsa2xcp@ou5tvz2ajd7g>
References: <20240820143911.444048-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820143911.444048-1-Frank.Li@nxp.com>

On Tue, Aug 20, 2024 at 10:39:11AM -0400, Frank Li wrote:
> Add child node 'port' to allow connect to usb controller to do role-switch
> if id pin of ptn5150 have not connected to chip's usb ID function pin.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


