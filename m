Return-Path: <linux-kernel+bounces-417339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09479D52CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6119F281CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAC19FA93;
	Thu, 21 Nov 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnlRvgmv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B2139597
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215044; cv=none; b=YgT0euUE/OGwABpzWEZnny8LPEHCw2RZgbQBRwLP1zc3pytAZnqwXDNbSEiHzx2Y7z/+rgoXBzcwyoefzpIkrqAouABB0kqF3YoxMXJsqYzfIjso0zjA7ZeWZG0WbE7YIkJNNNBFUC0dnxSKePVKlmBMXi10Kok3e8YOJ44vH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215044; c=relaxed/simple;
	bh=QxhytElEQlV9KEcf1qGU/kHOFBrKLIqmqeobJDMIfdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwhXoCoOOCBHHRdXR8WQaTMPCnZB8Teu0sscxzChxIKQvH0cTJsweZf3304acRj2tsYLpVK9N9cJf27HtiDY000L0rNp6SmQ6oncSJucsak+/JivwiZXG+BS3G22HS4FK1vtFNLS99hVlGdoOOI4qNglle4auIkxCGLjkR8S71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PnlRvgmv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb49510250so15446871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732215039; x=1732819839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VdCN1lqNouTv5fI9/HnXjA5jG6LjBgxZhTU1QtUgLk=;
        b=PnlRvgmvCPuMVcKIkdZTjiPJNyc180LEGahDtSeOFiMDGFrcvQERw0izX2vOFpaDl8
         kcUW4FtCMPjx2I/1EeNHEp/N3ZABp8XggM+vvEJIsUYj9xAfLabKVDqqiLRyl5aMnMQK
         BbeZX7qs+lfUsAmLNDCH7jkDTbxDJTTzl17z6TdFKHe0eVy1XBI4wFJlUbGILGC5Oery
         LoNz1+/RjNSubQTZFOashrXT0QPZkjBPfQOxRyV/n3+QCtoOy1NPGaRNRl5Joo4CLdQu
         AJ61zVTANoOWxR/sLuNm6IgP5Pp0AqDhR3lRS/C2HGCBiCJelVRrjL0St+KX0S5+UQwb
         OgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215039; x=1732819839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VdCN1lqNouTv5fI9/HnXjA5jG6LjBgxZhTU1QtUgLk=;
        b=tm1t5+3VMjEuB80xhFKZbhTk4NLqtw9Pe/fgvGxfW2KOd5ThHg6X5v081j7l+gsb5A
         1AEyM98+9dEKrulLu7jW7MWSEQB1Zg7Rd/aEKVAg7e8pPwWphv+ZJs/xwZg1DmoTpqGx
         IAqjW2iOxkukmerKcMBT+GOXl39onQc6WQ5+yJk+bDyzXi0LECYFaqr1N3q+HdlypqOc
         hjounrCjHAp8eOXeTMCnHQtmV2uC6u8xCg+PDBG9LNm6/SwHS36BUntKoOqycwuaT982
         DoSg+p27sCjDCp53gnf2s7qEDTJPLa/te2AX0sya0k4RPVSKWHt2muihyfBIWdzfATG4
         +ZoA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Lo1nnSz5/4Tl6RkF8ivLKFlVsrTF/zBbhVlJBeaEsC6MQYFnIPEHkm7pOtGe2WP8i25iYYgRcp6Fqes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzwwMLV1rTVpe/a2B/zLLs6O5oEDzG60dJo1/SjqMIS9XnfiJ
	diF8MZDYpjxniuLKnJTbM9uvwdOGHCLEBqLwVZDW40HGalSt3BX8Cp0AbV+FiiY=
X-Gm-Gg: ASbGncteYBOB7cvfg6Q3ghX6GsUSplQ3lSlGWCRHXMhuPMGCO72P/+L3q5sl05ye8Af
	BwsR2U8MOVYXAE7YqAnbMc2uvIY/sObnVXSTYpe3y00FJCO2pcP733bfdAkljkmd3t4WEDhe/qM
	pZiJu3Z1i3p6pb6/84OYQ0JM2rYiX9cJgY4CffArBRelKuYuchCXvwf5IPdkWjfUZk+dSkTM283
	wUZGg5Hi2gcEYqqUlCZI3VJF8w2AIXypjTfAzaJTxXSBxAGCA9SXDlzRfWO93rdm1Q+sw9EUQLF
	9JaBh8JSeuPwEihDz0oGaXrkBkIyJA==
X-Google-Smtp-Source: AGHT+IGawGN4JuBpuedSADFiEa8NGYWZ3m0+/DjVOzB7JMih6J9Gx73uzRw29DICHWEIBPvcPjyc5Q==
X-Received: by 2002:a05:6512:457:b0:53c:761c:2a14 with SMTP id 2adb3069b0e04-53dc133b17cmr2947245e87.29.1732215039560;
        Thu, 21 Nov 2024 10:50:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd249998asm45033e87.264.2024.11.21.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:50:38 -0800 (PST)
Date: Thu, 21 Nov 2024 20:50:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Bjorn Andersson <bjorn.andersson@example.com>, Konrad Dybcio <konrad.dybcio@example.com>, 
	Rob Herring <rob.herring@example.com>, Krzysztof Kozlowski <krzysztof.kozlowski@example.com>, 
	Conor Dooley <conor.dooley@example.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_tengfan@quicinc.com, quic_shashim@quicinc.com, 
	quic_kbajaj@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs9100: Update memory map for QCS9100
 Ride and QCS9100 Ride Rev3
Message-ID: <lg5fszrlw7x6yamlyr2vck5ribdfddkjwi47t35qlxamrxd4nc@orwj6vafpnng>
References: <20241119092501.31111-1-quic_pbrahma@quicinc.com>
 <30fda0e2-f314-49b8-8c1c-bf4fac87050d@quicinc.com>
 <rnrxb5e7xcgnjp4y4id5m5dyswii6xipry3bvtpit2f4c3iqfy@qghr42jz6oze>
 <f123a993-0cd5-4747-80fb-88acb2434880@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f123a993-0cd5-4747-80fb-88acb2434880@quicinc.com>

On Thu, Nov 21, 2024 at 05:08:22PM +0530, Pratyush Brahma wrote:
> 
> On 11/20/2024 5:24 PM, Dmitry Baryshkov wrote:
> > On Wed, Nov 20, 2024 at 01:41:03AM +0530, Kuldeep Singh wrote:
> > > 
> > > On 11/19/2024 2:55 PM, Pratyush Brahma wrote:
> > > > This patch series is based on Tengfei Fan's patches [1] which adds support
> > > > for QCS9100 Ride and QCS9100 Ride Rev3 boards.
> > > > 
> > > > Some new carveouts (viz. gunyah_md and a few pil dtb carveouts) have been
> > > > introduced and the size and base addresses have been updated for
> > > > a few of existing carveouts compared to SA8775P. Also, tz_ffi_mem carveout
> > > > and its corresponding scm reference has been removed as it is not required
> > > > for these boards. Incorporate these changes in the updated memory map
> > > > for QCS9100 Ride and QCS9100 Rev3 boards.
> > > > 
> > > > [1] https://lore.kernel.org/all/20240911-add_qcs9100_support-v2-4-e43a71ceb017@quicinc.com/
> > > > 
> > > > Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
> > > The memory map for qcs9100-ride-r3 and qcs9100-ride is exactly same.
> > > A good churn you are first deleting(based on sa8775p) and then re-adding
> > > for qcs9100-ride*.
> > > 
> > > I think it's better to move common qcs9100-ride* to a common file ex:
> > > qcs9100-ride.dtsi and keep specifics further to .dts files?
> > > 
> > > This will ensure common entities are present at same place with no
> > > duplicates.
> > I'd second this proposal.
> Ok then, I see that there are some thermal and gpu enablement changes as
> well in the pipeline to be posted.

What kind of changes? It's really hard to make a judgement if you don't
describe what is happening.

> Having a common dtsi file for these iot socs would help in reducing the
> duplication at board
> dts file level for all these changes. In that regard, does naming it
> "sa8775-iot.dtsi" sound good? The board files can include this dtsi.

qcs9100.dtsi?

-- 
With best wishes
Dmitry

