Return-Path: <linux-kernel+bounces-383097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E009B174E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6978B214CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388841D3199;
	Sat, 26 Oct 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv6E9vdE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70171D2B25;
	Sat, 26 Oct 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941133; cv=none; b=P9OlHFQqlr28z+FmezbMHxfJgfsKUzEhRumOJe7UZmPvP+YGq0QZPZiE0heBVshssupGZNhRE/VEH8uP6U1X/htP9UqC8InguR+a5MMBaM7nm0vyGRXMuhKHpEWkuThfEjpt12hfgOVzuJ3k9YjS+7Ed2AvGr+WzdH69hApaSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941133; c=relaxed/simple;
	bh=dTVMEHOuxBlkYVFWfLffxfJe6kGS9POZ8dI2759QaXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqRYeJFoeiNBYKziG7gS1mPYLY8jk0wAOdVL8ct48ea//utUoYckV45i0rDrXQFkOml6eaZXfseleRUmFyIw4S7WNhyQ8C4/8nkOzdju8oKtffU0h/13aShDbY4yuQKSWc6u+4x7ShOve/MA0t287NuTAx2aii2jovRIDdn3BNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv6E9vdE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316cce103dso36441485e9.3;
        Sat, 26 Oct 2024 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729941130; x=1730545930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTVMEHOuxBlkYVFWfLffxfJe6kGS9POZ8dI2759QaXI=;
        b=Mv6E9vdEktH9dJgKVSjWL1E7rREOTZwx9pprfoJpo5cMSBU72/qrpPkbM7BkV5Elhr
         Av8acd12x7KpzAcGa6XeMZVB+C/7F/11J/Sf9Cr3egPzPKvqKWv7IOBhokrhn4U3ODq7
         Xgw7zvz6FMZrtixQM/ry1zibQLoF2IQ4tLxUWP4jmmySpT6tkKrgwPzXmZM+pzrOaUf6
         AlxA//iEJhw2GQQfLvIlPldi6uc+T9bhhcWHQlAWNXuht0ntdQRJoFPnZ+PlkUxZIGfI
         /kcOT4StZ2FkP8i/cnvS9Kr1wrbi3jsdY7g60KXxT3P5rcim3LT1B+JJKnny6VsXyOLm
         jH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729941130; x=1730545930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTVMEHOuxBlkYVFWfLffxfJe6kGS9POZ8dI2759QaXI=;
        b=caduJXOm7HJO0wtM29aI/wZypkTt4e+1LxaywtdZ9T+kH9F2ye+yo6UoFeOBRT9Fx2
         /j4jRt80YgFu3K5Nr4kU7Eh2BMRUaeN181tKtNAHRdppreinbhywjJlgyErsiGkpEDGw
         3DjpcRfnnMBwgyPyT3a3LROEqsmnsdfrkVAyfIj2lVbbISKxSOtcyrmgYe6KqeoAoCN5
         VLNDtlTsSmM+7PFcR1D0+geNsmPTX+/h1hoknwxax2cCxkEgSqMENzzUEoTWWoJGylK6
         bu74G72AA7TO1Nw9FxLW5Ue0wgXWsDFeFoVCOPIQcYd1GuNXNQUJyDk/HAeJyn74CQ/i
         QMnw==
X-Forwarded-Encrypted: i=1; AJvYcCXIt9SDRrpcsrzaNoVC/eVaIynCG8GjHmTy/xHseAeClUqkf8hPdMwNaDnyEdHThCD3AWtVosqMFrCXNMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3EdGoyR3OlLnQ8NrQNcGuQJBPZcmCauhfTmmoXLyDga5ajhL
	C+CnLQCUEE4xr03IBr8kMqc4QSWJdFY8STJQ3yh6/Tt36mbElTvVCfxvVg==
X-Google-Smtp-Source: AGHT+IFwyjDvQXsh8TUXBnH1o8WY4sVfHIW1M7KugmLbgreb34jul3AlpyeX+zYtQuy+1gIk6j6r1Q==
X-Received: by 2002:a05:600c:511c:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-4319ad25c84mr23291075e9.29.1729941129795;
        Sat, 26 Oct 2024 04:12:09 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5707e8sm74692365e9.36.2024.10.26.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 04:12:09 -0700 (PDT)
Date: Sat, 26 Oct 2024 13:12:07 +0200
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
Message-ID: <ZxzOh6ahyOX_SuO3@standask-GA-A55M-S2HP>
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

Hi Srini,

anything preventing this from getting merged?

Stanislav

