Return-Path: <linux-kernel+bounces-189531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DE8CF152
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38AD4B20EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E76127B6A;
	Sat, 25 May 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyLuhf1Z"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3C83CBA
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716668207; cv=none; b=O2wDstxrFqOOPbnjCSBzrk1lwtdcVwgElEc4B6TXgG9bUpVV4ibXXn+nrNdlpV0wLHmrmnGpR1bdmu36cnXRY7wfZNsg9B1tHb9HmJIFBlEe1eFnHTEFYXekJ0WaBZKddBGzfEtafUlLU9K7OZcvpa8QJ56UCeIAZK2L8+YJrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716668207; c=relaxed/simple;
	bh=2HHhiCt8GLLLa8Gr8o58I0NCI8HzVXKCVVmS/vYl6jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF6tq3ARa79pqgA4AjnnjWdyBLXz6VWNN8UAkXOyuRNd663p1DKCpkKQ4DB4bS8F05TvJIw+l5DPWhJZwzBGr7mOcIDxR1LeJezXB2hv74mvYrNWB/XLWhM8xE1u5j0Jx5JciCk92+gH2lVwVqsZs+0dMCvdI6AEbq7x9mgi/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iyLuhf1Z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e72b8931caso80157681fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716668203; x=1717273003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxSNjzTuJf4atAWp41vejpcFG0wlQeaP+5dXZqy6R+0=;
        b=iyLuhf1Z6c2i08uFYfcGoxKDkZnElnVmtX6Rlcg25Odhw5mC7SvLZXvYIWD3Q/HWCq
         Z5iL441LviOVASqAqYTNIA5f2Zen+XTE4pwB7GR9sdHLWdvbuPuM807+faNepgZHD0JA
         CAtomdSqfQei0PLkV1gc9WUott/skesHrSYhOypIodDjCPA2dZ9DlK/Jfpsj2plXcVdR
         x1EEJi67HkzpAfRFG0DyqPvoNsN4KSAljdMB25VdSPhApwpiZJkPP/Uo9d+xF1q/v68D
         U8sTlGuoOvGDyCnElWLPDeUM+BbUQzdt8+TATlh/CgW2kZ6oVepn2H0/49SYyTDIPNjJ
         B+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716668203; x=1717273003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxSNjzTuJf4atAWp41vejpcFG0wlQeaP+5dXZqy6R+0=;
        b=d8LEoH/WHjMgjXYDb1soQOCoWdKzBKB0+i67CPyVBm62du8xzf6hCKwnndeESy6+IM
         jqZabf1m6KO/w0jJoM0oHZ+ty2YjD9wZ5/E7lg58RsSdXhAnapYvuAKxvAP8DDXcmXDn
         vo0F73Fwk2GzpvkJeRTDT6yNsgk9Ol/FZrWcDfjO3P0ijrDOuoYCA0jpjCZNxrqnDlJD
         uEh85FrsMYEKAok0Cm8+KBPe4ZC4A2mNV7zX3f2FIEj1dMKCCDStsXrSiFpVQ35xb9je
         ul1Wch0iaKLGPh7f27KYlEeGc3VoiTX0HcRWXxrenD8Y7Qjiy7+1NJxCzJnUGhaBybwi
         yB7A==
X-Forwarded-Encrypted: i=1; AJvYcCWw8NbVOzp4V4XE+rt0Kp9mWCHOyC1j7dR9Pb7ReJ2c2VwDjamqsPsivAf01nQ4lVxW29eCpgjg4Ll8qyeX7Qrk8XLdMLUQt9/gArKk
X-Gm-Message-State: AOJu0YwEBS2Z6QTCim9cFSyg0MKP+9pnnZcT3uO91Op/xcT8isuudLWL
	IGbJX1sBPMp8QJXX7BSCreMe2wGXshNcsoUPS87I54fLqsvk1WkvixNb8zAupMk=
X-Google-Smtp-Source: AGHT+IGqRSHwvMo1bs7rJRPMNeOrxq/sWSDnSnLjjibtRkPVSgOa8OApgnvVYNKAuqZszWWcJU2yVQ==
X-Received: by 2002:a2e:3e0e:0:b0:2df:b63:a8 with SMTP id 38308e7fff4ca-2e95b278708mr30593201fa.50.1716668203490;
        Sat, 25 May 2024 13:16:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdd1517sm8813861fa.82.2024.05.25.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 13:16:43 -0700 (PDT)
Date: Sat, 25 May 2024 23:16:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-usb@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 09/10] arm64: dts: qcom: sc8180x-primus: Enable the two
 MP USB ports
Message-ID: <yqpnfhh5cdi3uxzg5ii5677lsjrt7nothm2neysf32mjce22fk@erbpp5lhmqrq>
References: <20240525-sc8180x-usb-mp-v1-0-60a904392438@quicinc.com>
 <20240525-sc8180x-usb-mp-v1-9-60a904392438@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-usb-mp-v1-9-60a904392438@quicinc.com>

On Sat, May 25, 2024 at 11:04:02AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The SC8180X Primus comes with an AUX card with two USB ports, fed by the
> two multiport ports.
> 
> Enable the involved nodes and define two always-on regulators to enable
> VBUS for these ports.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

