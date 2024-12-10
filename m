Return-Path: <linux-kernel+bounces-439081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236A9EAA95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54294188A64D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4C23098A;
	Tue, 10 Dec 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYRAo0o6"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC62230981
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819139; cv=none; b=AVbanIXRR0t7A8Zv+/oq6UH8M4GeLDdb44dN3lM5XvY0SEzMMWex5S2L8sxbZITQhDPPGC0xpcPfgrqr/7pcFfWdu47RV4t1Y70fPDnEeJCVHaWFOf3mm9VmUTrAKV3I9lt0XdY2+tP47m3adMR97MLOCdiu/E9ZRNtGi9NCYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819139; c=relaxed/simple;
	bh=Aat58HQ6zWrd5CswpKxWlkheZjFt8yTkkHKsfeZ+9zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYqcHRDhirakPSEfajdMCmLeQ66fEdF4cGvoNYMZzUfV5Jd20HMrBuhea5Ozl1wZHA2sSodycqZUJlZm+x2ve0oG3I4LelCfOL1by9AqrgUHCwteiil6iHuBeWS6eFR+G4JmkZ0kR+XXCh4c4rqkip1AKJGlfDAKZZbLf9etq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYRAo0o6; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so6921933a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733819135; x=1734423935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HuQWUnaBEntG+4q8CpLCOSV8pyx41H5nC9C794rG3dM=;
        b=tYRAo0o6RPv1rrvdlV9PscX61aHy+wNKX8dZS0axrHGarM7D3WN3yh/AC6x6zYYyy9
         S/vn8g1hRLWBVodhqOKwAGaLH+Yu4+TlTTSrwl+km6eSEwb85V/2/xtxSlXkdqrBbzgR
         25Z2OsZtDkeHDjCu1Q7GHEebN5pPgRp+qzBHZpB+SXwfRsU8c4OZioC0jJMgI9O9fvIN
         cbSJ5//ec6aDzXe2CfJbEPCsKpjDjbuD8Y2Q6KWtMJ7kKpvjIlnGHiRiYwsM5+sqj6Ao
         TY6usdrdbG3AI768hEJxd5qx5oiv7m9UPvyaSlM1UtxaAOA18KG+1XY0IcgsHprxFr1O
         7Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819135; x=1734423935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuQWUnaBEntG+4q8CpLCOSV8pyx41H5nC9C794rG3dM=;
        b=u3rICz6cTEchrt0t/p6DJRvdSXjZVawoUok0iTTPoAQXFZL424d412JVU4KmdfPA1L
         8EX/o33exmQ+WatnlEDnw3bATenvtTdO1+A13/GNEXPVgwd5OFfCfkbbgIM397Djes3P
         Px/1w7RKrVTNGwM35f7c9XCzxdNVftp+NNnAQj1HF3Ex+TmHpyvdZlLTOnMv9ZhxKimm
         Dijfljuhdqy12x37ETYtGz4TlNCfMlqWX/kixp7TEs89mb61VArPi+giNvu8CHOzUwZU
         VcyrUIsmWr9zk9kKwPzYJ5Cq23zqsAPvBNgtuejE5tFejfga64Oi7Ikj3QxE4nq9gEGA
         Zbkw==
X-Forwarded-Encrypted: i=1; AJvYcCXhhyihLgUG6X3ohH0JxMufoY52xQ+pzEllF+yVttp5N2fDEBMo/gH6qAS3tiaXVP4Y5QvQ6veEow8BIwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEi0iRROuB4HLIASxwraYU1JYb9UD4nX+XYPHaBl8hywzZFmOi
	1S4LImN0TRLceobQZjNUdr0WUFj0QksHy4J4TMOwSfLm9H8dhCowAcLxjS3ydOA=
X-Gm-Gg: ASbGncv7bp0LB2BKxC3z5KsYkP1jcyXCHosCxdMYur/vTAFG0GtZQ9km+Up2MVPWEDm
	sOjkO3GLCnilstfaXM5mFVXcWiIncyW23v35fQO2gSnOjFMIqLyhOLtYGOMPNV0Tyxke2vcpmFQ
	fNbfawxm/W4ML2e+3rfIjIl3rRs793kJ0OBHfq6Mb8bmENzIXxktMLrYDt4j51Vhq7Jri0fXM+l
	uGKSVPdJVBNlrE98N43VrNC73OskyRnqiEt+GIdRGFOTR6Yt5CHG87HTn4jb4EWZg==
X-Google-Smtp-Source: AGHT+IFPjnoPDqBWxqnWDU/N/e35ObWn19I59FifQGbgV4N+RARB17TMYTb6ZkIT5SxPDFHD1DTUFw==
X-Received: by 2002:a05:6402:51c9:b0:5d0:d84c:abb3 with SMTP id 4fb4d7f45d1cf-5d418613125mr4286623a12.26.1733819134964;
        Tue, 10 Dec 2024 00:25:34 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:53d9:8daa:420f:c0d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e4a87ba4sm4433468a12.2.2024.12.10.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:25:34 -0800 (PST)
Date: Tue, 10 Dec 2024 09:25:28 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-pmics: Enable all SMB2360
 separately
Message-ID: <Z1f6-G5fXr-383IK@linaro.org>
References: <20241203-x1e80100-disable-smb2360-v1-1-80942b7f73da@linaro.org>
 <01d0b807-6201-43fb-8286-df04d722610f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01d0b807-6201-43fb-8286-df04d722610f@quicinc.com>

On Sat, Dec 07, 2024 at 11:57:54PM +0800, Aiqun Yu (Maria) wrote:
> On 12/4/2024 12:27 AM, Stephan Gerhold wrote:
> > At the moment, x1e80100-pmics.dtsi enables two of the SMB2360 PMICs by
> > default and only leaves the third disabled. This was introduced in commit
> 
> One correction: it’s not only the third PMIC that is disabled. Both the
> third (smb2360_2) and fourth (smb2360_3) are disabled. This information
> is verified from link[1]:
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> 

You're right, I didn't realize there can be a fourth SMB2360 at all. :-)

It doesn't change anything for the patch itself, but I'll fix the commit
message in v2 just to avoid any confusion.

Thanks,
Stephan

