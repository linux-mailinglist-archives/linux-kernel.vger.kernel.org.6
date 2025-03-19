Return-Path: <linux-kernel+bounces-567690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB155A6890C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CA6189AFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DEC2512DA;
	Wed, 19 Mar 2025 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k52VKG88"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF811F4CBE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378779; cv=none; b=MU2daxmVbL71Tm71lXnDyVri2F3UREc1yQfAprGpw1UX44Ae/ueE3W3pDnKVSxeSohDJI2Ajbx9PT9MuSkD7cVwaduqPfWm6ExXGiYDZIZ5d+kx3r7bPFhEuJEqxi+d7EUMQFRmz42DPPb/157WgadiqhfmFBLn6/zJ777eayOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378779; c=relaxed/simple;
	bh=4vaJuEvzjXdXBSh6/Y5a0hdOgg6StyNQc0yWT2KFVcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei5ZW3xpEQC7fSGPFhjYFIOIcPQv24JyWg9s9vO24IfzIQ8I8OGOyRslnqdwmn6k0qDtXz43ort0rLMnj5zQgl2TGiPKdaYCIkJD1ZYf5hnp77LxiKd1jRZgvQ8zKxaWtD8JkdmUtZwwOx7cR+o8mHV504R8UZaCaBrTLoOsGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k52VKG88; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2963dc379so1130779666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742378776; x=1742983576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkmCrBTQNmjyJ9LfpOQNHoaOW35hiIjttNIV6ARHzg4=;
        b=k52VKG88FULWXgzPiUQvZPZL9mFkBQkFUUiI8JmRafVV03hfGtDyxdEN7F34lWCp6D
         AStue904vYYMUxhMkYvFMDrj8i5IlenM60mu7rM3BHqBLmhzcqmdFMU9RkqKWi2i0qk4
         yUamj2yisqm/1plPGc/R8ZYS7YhDc2FhptyAoDzMuLIQZeAsms/Ruecey0an34c5AM8J
         gMmFzwcKnzV5jk5e8Gzv+/VYswHU2IEQmTC02EIEpVecn0Z1lc9yUkY3OTW2Nbk9HEn4
         iAxqKWUH6ha6OQCO85GkER7My7GApyByPKJ66BuZReLm/+18kndVuotf9ari4y6aYdSB
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742378776; x=1742983576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkmCrBTQNmjyJ9LfpOQNHoaOW35hiIjttNIV6ARHzg4=;
        b=NazyvGMMcgx3bps97RusQJbkXcmvQbL7Oxji3q3lK1v/DPpsjBwqFY7c8blgspx4q8
         csBso56tGug8QeaSnMiqO4Lchopd3Z62+Hnozf0CgqNHsXZdzYFmGS69S1zxfTqGLaI+
         LWuaMptHDCQQdnWTewyiyn5c2tziDpg6xRSqU0H8HdRBPLz4jtps0ygTOaoPz7kD8NOh
         FppUW5oV5qo243VpqpkFbP8Pmx1b75d+q03vp4dQjWlNnNf+l9ANDNaBeaUA4xcYUeyt
         1OZGUopCgKAj7kYqa7WBDl9H3gfVCunOk1LZORoO96y/C99Nc0rlrpEs6JNx5oq9BIPR
         ovYw==
X-Forwarded-Encrypted: i=1; AJvYcCX8XhVzgsj1tI5nB8GJaU/oW/KtsvHAhAsbW6iQP8a0t3GC7eaelPQB/i5+BtAAn1PVKa6UtTiNXihvcqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtptF4HHzO0mXLjOQRGLWk5ymkg5niE5/jUUp8YGzhpPj2/iQ6
	WdPhNBDA9L48Vli/l3aYaeIC0SEe4HUx7l/LvX/GCVQNIQ02hYexLCWxj7jjpbM=
X-Gm-Gg: ASbGncv9gq8BpkpppeFnMMs0SpcHqm0VpnqslsWIkW+K3dvUA4gd6UXUpG0Dg3aeCAA
	bDYT1/ygLDZJ2FijWLum4d+MKwXVMxWqc3vCwrOg6RdS8pmW7jHmsbzemxvpWBdd3IKC2ZiGhZY
	CGvlxLr/YhkKo7rDkgZCECDcnLkmpctfPrgY7a/zg8uq9dfJr9dxxK9ccwraocPb7x6oNMlNQ9H
	FpLAKxR8zxNIXaloHsOGlkLmdopeVOzGyb5t2QHXQ+rcGaMuY9oYWDwBCN2b5EP/g+Xv10IJ3QM
	0k31+8wsl5cas0Z6FC6g7x7eH3UjqoKx9pMTT/MG2ExKQbaWB3n0NA2E
X-Google-Smtp-Source: AGHT+IFI9YoiP3I0niuCpSgGRcKt34Gyjun9cAeLDdB4irqA7sbsTU6nGtTRm3pLUmCGA+WVV222Cw==
X-Received: by 2002:a17:907:d9f:b0:ac2:9841:3085 with SMTP id a640c23a62f3a-ac3b7dc20a7mr204929866b.30.1742378776366;
        Wed, 19 Mar 2025 03:06:16 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:1274:3124:56cf:f607])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm998578466b.93.2025.03.19.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:06:16 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:06:12 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: bjorn.andersson@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-dell-xps13-9345: Disable
 PM8010
Message-ID: <Z9qXFLmnae86_GT9@linaro.org>
References: <20250318-xps13-no-pm8010-v1-1-c46236d96428@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-xps13-no-pm8010-v1-1-c46236d96428@oss.qualcomm.com>

On Tue, Mar 18, 2025 at 10:17:02PM -0500, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> The Qualcomm X Elite reference design uses the PM8010 PMIC for camera
> use cases, but the Dell XPS13 doesn't. Disable this PMIC to avoid the
> error in the kernel log caused by an attempt to access it during boot.
> 
> Fixes: f5b788d0e8cd ("arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Usually we do the opposite: disable nodes by default that may or may not
be there and enable them where needed. E.g. for the 4 SMB2360 instances
in x1e80100-pmics.dtsi.

I think the same approach would also be preferable here. You shouldn't
get an error in the log just because you didn't go through all of your
DT includes and checked if you really have all of the components listed
there. I think it's okay to enable PMICs that are more or less
guaranteed to be there, but clearly this is not the case for PM8010.

Thanks,
Stephan

