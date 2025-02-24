Return-Path: <linux-kernel+bounces-528010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFD7A41277
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C410C17016F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7F101F2;
	Mon, 24 Feb 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EK/Tzhxb"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16131D540
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740356355; cv=none; b=qs46z7FAxhq80okdAz8OJHFptf1WInftxzn6r+qlCtep25+10Gz0LgnAbiFK20ZdNNmCSo59cIgjrKQJXphU96OD5xjbVRTsY1NafOuKzwGDf1/VMdmYkaWs0CZM4JU6GVQmZnZa7zxBo9eZD/lpSexL+rHomDgSfPqs9dOO5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740356355; c=relaxed/simple;
	bh=TvIMU489tU78+Iqy04G/wuH4oWe4j+s+mPGK7k5dEH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egj+GlBs+l5klECMd29KwsrThGEApLPB6aQ+o+sL7waOZ8LAxJiwnm1vI3r4ITP1loHATxKjiV3ofZR+0Ri9GENZOGQugYE8tA2ujcrpusNmmn+a3QYSkwxe7FlDCDT67qiwG6zIS8h72FS/DsH34FzxP+QqjaEGEmmistMKeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EK/Tzhxb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54622940ef7so4395605e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740356352; x=1740961152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFHN1wB7hAg3BDNRXM4so5q/WzeCPLIz2eBiXH9F1QM=;
        b=EK/TzhxbYtAsKJY3tSqvhgqzZ6rU+4c0mfvY54KhUR/jrEjs32WJ1XvEqyls1W2xBu
         fwqA0kgy2vaFCSPVTHPvzRaftiQHJ1ncDiTS5d92d/EX+Axl7iLoBuTWlhxZPLCxtREo
         mriiwxAa675vD5kgbzr49Q6trTTyjW4IF0QOgnJBi0NWFs/QkTUG7CA+F4JxlkvrWpgs
         pXY+xqnROVn7Mcc4RryRzGVtq5GwkoK3eN9KJRbNwGIRjvXqufabRG9DuHwFm26Rt5n1
         x9vrntVIYzBfelXkgvBjmwSQ7eg0h+Qx2qM9QhCEksLCGGgfpK4uAADhvrknBfDAGWZm
         DbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740356352; x=1740961152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFHN1wB7hAg3BDNRXM4so5q/WzeCPLIz2eBiXH9F1QM=;
        b=YF2qka8pLhMSnDoQOy/ufMToaY6V5rLVaHt8huV7adSvxwP6V0L5r5JbnAt3CHRpm/
         9AFuEv20iE9XZap/KYQ7kox/2yFX75KGL2HNOOzw4GX6XLp9cUZ+lbTx+wRkRNAeeXn2
         pgVFCJLB9ELhbV1QROzLF+41OUs/+aWRp9IMGT/Ht7r2EuRnqRCtLHr9W6dM5GPIFlpz
         HQPxxhlCtqAmPagnIRlotCoblwdPw48UgTd71bm13mXJkX4Uc6ISZKO6fVfEDrDQcNNj
         T6upbh11ZBC1c9ZnciVGIcYHYaxHl8SYgJms9JZsXGCcf5R/wAsyc4QBfnsSBlWgwtzh
         xODQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDD/DqtRYzo61rS4IKjBz6FXnOo9vw2Bl29oC4xhJrpexlPE9/Ksj6G0J1xZHblawvISOQGHzTi3yIq8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSarfTf1yK9+BcfvdflShbV0dJ9z42+n1lTBNzwD2/cTw58EMz
	95ejjzmEHbMg5v03eX0iCuwgA056P95lbM3ZgU4ZlX1h+33fILawvTbxLS4nmEw=
X-Gm-Gg: ASbGnct4zkn+8R6uictnQ38aifetIoPfI2l3qQR6muOzFwz0ssarIL/ojaRRzN0l9G/
	QqMzAJDUAH73XK0PyXRVdO34/IjYjr44neKga/CLdPTPSYsHWglesrc7W3kt6wKtjQrpDzlbNFH
	6DWdCIEW6zUh2KukRWEJB703IfszMdLloeE9LX5rb+D4XP9zDgPKJ6rj1bs7lwEktaXGkPyyn+M
	IoFKrAkF1ABh+xAVWZabTuFHUndgBLcsHbK8Ntf6iydtqgvQBUrieEJZWIFFTlYIx1RVq63Ok/+
	XOdUceBOIjQnNBLHNBa2FijzP2aq53tVV1U9izZJJpbwR/9IXkrZCeQZpbittwLCIHCdcEoccqB
	0hGQFUw==
X-Google-Smtp-Source: AGHT+IEt89JxR/uYuIfY1ZBQGBkgrhGrFGK4rZ9JZp9Dr7u/koPyxNo3xVk8Uth1LpOxlXP3HFhAIg==
X-Received: by 2002:a05:6512:2252:b0:545:3032:5fd4 with SMTP id 2adb3069b0e04-54838edd854mr5253178e87.11.1740356351934;
        Sun, 23 Feb 2025 16:19:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2e03ef65sm23787381fa.73.2025.02.23.16.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 16:19:10 -0800 (PST)
Date: Mon, 24 Feb 2025 02:19:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sdm632-fairphone-fp3: Move status
 properties last
Message-ID: <qgxtu6quxz2ca7old7mau7rjk3kbhwth4ic4mov6r2fefmpq7w@avznusgv2f3p>
References: <20250222-fp3-remoteprocs-firmware-v1-0-237ed21c334a@lucaweiss.eu>
 <20250222-fp3-remoteprocs-firmware-v1-1-237ed21c334a@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-fp3-remoteprocs-firmware-v1-1-237ed21c334a@lucaweiss.eu>

On Sat, Feb 22, 2025 at 02:00:47PM +0100, Luca Weiss wrote:
> As is common style nowadays, move the status properties to be the last
> property of a node.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

