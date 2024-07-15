Return-Path: <linux-kernel+bounces-252936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF27931A11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6564A283399
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9586E5FD;
	Mon, 15 Jul 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0oLfcub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A953364
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067280; cv=none; b=GTqgErJRUG3qd8WtSr7abrL0O7j6Zudmeehw5AUrpPMEi5hMipiuPGXlP6fCV/rXA0eCHROKHZ28GnB6rLjwDy/hfbWnDtaBQtYFWs4pTYQFRl2K9j4PiLp6R/Hrh6isfoaUcpxHGeeiXX4nfpP9Jvx11Grn8rRn0EPldcb45Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067280; c=relaxed/simple;
	bh=kOPIQAFY0C9jKf9GWSFbVnvhzxm8W7Mj1wAmn5+Ju2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oet8UA/nAVKUH/Zx2aj59z2yijr+EeLriWq4wg0brh0z3SAe86Hkt8c2r88w3P2w1lzXSlEHpd+O29W4MajcNkXj4aR6qxb41DqLhV98s09lOhJKV/THJw9Cj2KLVVMOnmZaOPPbf1EZhf+VZepT/gsGie2YM5jzc8x1J8v3rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0oLfcub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721067277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h65hcyq2faj4hpcGQ58xMuNAhidSbVZfT6CrANnVJxc=;
	b=V0oLfcubL8+zXpCUJzWzXlL6mnOLYB/JQPhIagl4KFSHAe8idQVDGQrxaqk+Rcmoyzr7yu
	gppBMrWoUNn3LX1Ns1Pyvs/PFDW2MAHUtepgN1gCEgdEc37K1lzZ85OI4up45z9LdZZMA1
	RpjSPwM5VdrPQhfU0XrTz8iJNfS/xH8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-WXLncDz6M1SEWzyqSeWj9g-1; Mon, 15 Jul 2024 14:14:36 -0400
X-MC-Unique: WXLncDz6M1SEWzyqSeWj9g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a16375187aso290804385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067275; x=1721672075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h65hcyq2faj4hpcGQ58xMuNAhidSbVZfT6CrANnVJxc=;
        b=SoFua+rLz+dLSGcd1TCZICHl7QFGdUpVS6/VL1wcw351K/9sKxdSb0vmhsG1BUKG4k
         S0YuiXj6xGPNoF1QFgmHS2VteCvqGMpbUlfQF9shffE0+MRmSJ7ZvDC9OVwsHD/p+bnN
         /wN3Zeh2W3MZZ5n/1dgl/AIMGZOBfmFBg16OP2ClAUIZKDW2Cp8EQjq5u0fjXW5L7NBj
         FTXmVdfQRH3ZSjxCJG3Ia+czKqYY5fZo7wYbRvMp3+3rHOcjhKsr2RXPHKL7BHszh3el
         6/j3Lm/I5Ogo2BjLQCyAaB4S/IWMvT1lWu5A4COeNYOHw5En+hZs6dysxTYYYku7PJJw
         5X/A==
X-Forwarded-Encrypted: i=1; AJvYcCUwbI6kG/NlccYxRneHC7wmarwH56FgnEtQY2x0MyhKHMSAvV3c9/LCfA9l8zhFoYsjlTqvM9xd5C59WprH4N+JVsbVEHtAyFnOLXmA
X-Gm-Message-State: AOJu0Yz2RFqL6a6a0AjA2X5GzHxrjxlYQ1LSH2OlflkEmqlVI1Rzyxbd
	c9Ep7dE1wGplp4gxfEY5d2Ft/Px8f0BuyZiDycKgUVDj1RXG0z/hW/P9IAb2e3vTJgElRoWRX3I
	xg0uSyD8XUGODmndBH5Yu/TK5YOidFYKEioNxcLjfk4HUrmD+tR5TJFuXsCPywA==
X-Received: by 2002:a05:620a:4724:b0:7a1:456b:fd43 with SMTP id af79cd13be357-7a179f424b7mr61726685a.37.1721067275555;
        Mon, 15 Jul 2024 11:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsG+WJZFOfNJsOhrGBT5TVXdo70BHb+PnBtQCyI63G5MKuUpxlC51GnL/HJ/4WDSEQ3Myk0w==
X-Received: by 2002:a05:620a:4724:b0:7a1:456b:fd43 with SMTP id af79cd13be357-7a179f424b7mr61724885a.37.1721067275255;
        Mon, 15 Jul 2024 11:14:35 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbe7f9sm222498485a.43.2024.07.15.11.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 11:14:34 -0700 (PDT)
Date: Mon, 15 Jul 2024 13:14:32 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: Mark APPS and PCIE SMMUs as
 DMA coherent
Message-ID: <nulprwjd52j2iq7cpx5nq733cbi6ccdpemq6a7ocglv4ep5jmh@jvs6zof5u535>
References: <20240715071649.25738-1-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715071649.25738-1-quic_qqzhou@quicinc.com>

On Mon, Jul 15, 2024 at 12:46:49PM GMT, Qingqing Zhou wrote:
> The SMMUs on sa8775p are cache-coherent. GPU SMMU is marked as such,
> mark the APPS and PCIE ones as well.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>

I think this deserves a Fixes tag as well, not treating it as
dma-coherent is a bug and can lead to difficult to debug errors based on
a quick search through lkml.

Thanks,
Andrew


