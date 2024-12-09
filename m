Return-Path: <linux-kernel+bounces-437268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5D9E9110
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5565B281A55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991CF216E24;
	Mon,  9 Dec 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9sTKXLi"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462C216614
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741819; cv=none; b=n7zExcOISrGPjDKJ/evhR/Y94MDnkXjRRqutM2IG3YX857nGAym4t1xIOl1tGxCccXuUu476m3PNAoPIXrHYuNKAq0p9RMyI5EEvghd6T+TJDTnNMP9VTW8JJbvH8Tk5tKtIAFiGiIn1bpIuI4cFzGqg3gDOs0+Qluylj3b8MzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741819; c=relaxed/simple;
	bh=+hIqe/S4QmDOQhbBqmZWXMgHf/K5HX6ZKx4rNqDaI+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCBvAA3CTQSdTCqlzOK95X6QBuiLyXD/hT47TsSUUHlkjnc9Jjy2AEg6+ylV6FLr54k8ZTnnVFYEtLcwf8BpfxsavHHAe+TGpXvS85DHipvUVF4oRo09Uy6lzmrVvpCqA1SGIXTBv1MfI8UbaiIKbsabAx1BRTWq54vU+5i/r+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9sTKXLi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso46896371fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741815; x=1734346615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujaAnVbj3AWarK9qtUD67P4FOEUURSL/PjGWuchpTYY=;
        b=o9sTKXLiYAY9D6gd+tBUC/DKVB1LSXHY77IFItaRz3YQACOwIi8PWrunjfnC4ZzISG
         baEpaAf7xWvTWqvKrCL3FNgDrrKuhKDBfqP+6QGy159jkX0qMSGuZ+pWWrCNhIYytPPA
         0inDWB6cDBbCv3gtF4nMXuE43+ZExKoWfY/h+vNJr64y0nv/4qm1ufJyT3T4tfE8Miac
         AaJ/YCvR2BJDPfibUmjlEt22horOEswtwINrJJCoWkmyHRcH2ioA8Gfhwx/AWjJbAk+h
         kJlCU4Kn2opYnLVqs8pQK4mljVLLHcGigNgdFQgp/nP5S5woZRkYW1T0r60HvymGWo0I
         EqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741815; x=1734346615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujaAnVbj3AWarK9qtUD67P4FOEUURSL/PjGWuchpTYY=;
        b=cqpnYDHLiHjxA9p3gaoEyWVgzruaP+p9l8gNRtcqnikM+eEoPFzM6ZsFB3ROuFP8un
         siSAF70uBrWdhQ8lJvVFwkhFqRrr3ku0f9uBdYvTGGQ3mPckdnEftb4g1Y/2f9a6K6RD
         GQAURsjf2ClLSTnt545bpGMRa3IQwUXG1p7EBO5uDENJksJ3UDQmsKxEG2llf9x4GJ+R
         z4to0qHMq625tDT75NXGFTPCGAH15hF7tBknoEDLTKL1q31QvXLJcY4x4rsWcNujkezx
         +6yrtAWhyjULfsCc+ektWN5N1fjBpOBVXshUh96vosjNGLuFCw/RV/lBTSr6DakUEefR
         +mmA==
X-Forwarded-Encrypted: i=1; AJvYcCXXFzQvmEXaPAA89M/EXt6vMQCZMUZEEjTKIiVBZezarqUIHu6Spbed548HphzNo9y5+rtX6zDymfgC69Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfewHS9CwO3rRCJlWSW0wNd2L4lLwGxAXkCc+IMYoWiEM1ZxXh
	aaaIS+ODBnpGxZO1jUy3pLEVMfPQhFVrBjepn9oOekVG9iIzGuj+YhcGGgtyG24=
X-Gm-Gg: ASbGncv/jjxBBiK/OY5yHzFEo0pIWTrptfHaTeH94BzdgkLZLgpbFO4rcR4uDJWA4Wc
	xBWZuPR/FdqPYIIBaaEehD3rjTSbRbzKM9dYnW7Foi9Wh/I5FIkqXnNnnHwJ2QGhjm1SFCi/ePM
	ZWUZWUr4cc+cfp/qyspHRKXguU6Wgszn+aj/f/jN78BFfgt3vv/v/JzJRBS12/6ksmGe5hcX7Ss
	QEdyVgKYMAJFtj/oT7lVEXCJQAcXwgS7f+LEAUEcho/4IjJBexS54Hb867uTN4x3dtTVcX56vxt
	j/K8H02krGpXYb3OQoco5uD1+rZWKw==
X-Google-Smtp-Source: AGHT+IEe3E3bVz43C381ijw4BD9zV4cmUVA4lOxfc676Po+XiC+s2QUjs8LbA4yvZYwgljPHeTSG/A==
X-Received: by 2002:a05:6512:b15:b0:540:1ca7:4fe9 with SMTP id 2adb3069b0e04-540240c97b4mr13875e87.22.1733741814988;
        Mon, 09 Dec 2024 02:56:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54020269fdasm214549e87.182.2024.12.09.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:56:53 -0800 (PST)
Date: Mon, 9 Dec 2024 12:56:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/4] Bluetooth: hci_qca: use the power sequencer for
 wcn6750
Message-ID: <heyjpkzb4cxomosg4v5rzco3gi5d32vyecuyfgu2au22p5utat@2db4a3mxtblg>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <20241209103455.9675-4-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209103455.9675-4-quic_janathot@quicinc.com>

On Mon, Dec 09, 2024 at 04:04:54PM +0530, Janaki Ramaiah Thota wrote:
> Older boards are having entry "enable-gpios" in dts, we can safely assume
> latest boards which are supporting PMU node enrty will support power
> sequencer.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

