Return-Path: <linux-kernel+bounces-407101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F19C68D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147C5282ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377517837A;
	Wed, 13 Nov 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8wYN5xJ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192391714CB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476608; cv=none; b=asi/gWcCi+Fw/bajcTuG1ca5cbEMrFyWjexIv+8NtqpoJ2M8xKbQh6eSdpmnKpMk/6J/2RKCT7ovMmw/fHzQFHQvcpDl+bi2GgDnULTHdiyUsfzecoPgSdHBCA5bPpbWpB2JgO+t9liMOuN/N1rO9gr+2CZnjHo3lYwAtQQ9q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476608; c=relaxed/simple;
	bh=qfk1W0G4btZgNu2/jWoIENaOgqxz+HG7iiYJQahdguE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Irv0ZdsM50Pxbz3aZfd2aCbtf2DM++xYKl5xd4z0KQ3TBvq8eAIHXmaAfBqXmYLPK2iuHWgbtrUOkNSlO8QFh+PO+jwotb+2UoWRZguH+OK5IpSYdEuBVy0ZjHXySkESPMAgwLzlq6K5YDjCg92fk/IJUUdYw3QR2XM4vQqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8wYN5xJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so55473501fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731476604; x=1732081404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rDIdcymWASYRjAzFg8MHUqlCL9IqZxCW77N1LbzUcM=;
        b=J8wYN5xJRUKaJyWXjNJXPV5I+GVlVC3TMKlOZjQnXwH2BK0MGIgxhr2H8ebkqHyWrD
         142OgiZUh8Lp7jXTHXc6WbFqYuBqShFDyGA+Wai7ZXNOf8tLx3vSgbLF/Z3EDkMwSggw
         u+gKEyXOmmIKGVuSO5bFzQ8YfY5zFH3i7bdTYlxvxEQAu0Kv1NT7JtpIw6+g604zVKP2
         TgJXG3VwuNFhNSOPl1P36POix5tKqAYtlNxHV+ixJ3gicW/A2GYE34naUUNHLfDKk93g
         bcEN+alAHi99RLaSQAyhQOMZ9LvlHnL0TvVDmxp7YxGr9+YUcMjVIgXP15HAd7vELTxy
         qJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476604; x=1732081404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rDIdcymWASYRjAzFg8MHUqlCL9IqZxCW77N1LbzUcM=;
        b=Se/RZT60VDPLaQYIz02KQJSr2VNwoWDxW8yQ93y2vYmhKmBuQqbUEDouAjdT2z9vfE
         mdzoYlnsnJfgSFfvM3V/SkKYJKneh6FT8a5b1mR4TYbtJvAjOXj+uOg7kDDTUHpXUdlc
         ZSJAuyI9EBJdXAcoMSR5GoA9QDmikxqb49rPvwcjskS7oQgmPDtdvOpmQanKB5fsG5Nv
         oYIVqZYrDjzWM27xwXCebk0MWj1jP5FtKZEdaS99P1keIwPOr87+tx5z85Qt2ZvbVdns
         a4W4uCQLprutRNpd/Un+zFBZ2mUFOYg8wBi265eTs4ZFFmgtwk4RK/3nHY8BQzK7P+bU
         FTOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdMUHm1XdFP2Kt185ejUHOwYIv7CODJzR3kb3xSerIsN1xBQXQvCjZLKTFxv3s+5TCyHpYsz0cwoJ1zRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqND5sKT//vjMErdEDaWWsvLQLTLBgFFVd83VTTXKTYvC73Xfy
	Jl6KkprojTsBYid3J8+uhr+/0PVFi77YWopNY1IEX2RXZjHpSnogmfkFyrGnIco=
X-Google-Smtp-Source: AGHT+IEnyVMVMVovD1SpLXlITpOz9B+vw+4OVj2eErOENJuaMQDX6+YxMtNJWzrTNlQPhyr22K3vdw==
X-Received: by 2002:a2e:82c9:0:b0:2fb:5504:7966 with SMTP id 38308e7fff4ca-2ff202e134fmr74057081fa.30.1731476604048;
        Tue, 12 Nov 2024 21:43:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d43f2sm22795291fa.95.2024.11.12.21.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:43:22 -0800 (PST)
Date: Wed, 13 Nov 2024 07:43:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	srinivas.kandagatla@linaro.org, quic_bkumar@quicinc.com, quic_chennak@quicinc.com
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Make ADSP a secure fastrpc
 domain
Message-ID: <5oqzxppquoeppt6xnjfm2rdwm23hbui5k3caz5v5ffqzizepob@dz5ikvzgbd4x>
References: <20241113050042.181028-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113050042.181028-1-quic_ekangupt@quicinc.com>

On Wed, Nov 13, 2024 at 10:30:42AM +0530, Ekansh Gupta wrote:
> FastRPC framework treats ADSP as a secure domain on sc7280 SoC
> which means that only secure fastrpc device node should be
> created for ADSP remoteproc. Remove the non-secure-domain
> property from ADSP fastrpc node.

If this prevents the non-secure devices from being created, isn't that a
regression from the userspace point of view?

> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 3d8410683402..c633926c0f33 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3852,7 +3852,6 @@ fastrpc {
>  					compatible = "qcom,fastrpc";
>  					qcom,glink-channels = "fastrpcglink-apps-dsp";
>  					label = "adsp";
> -					qcom,non-secure-domain;
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

