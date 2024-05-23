Return-Path: <linux-kernel+bounces-186979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6C8CCB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14965B21777
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AA60BBE;
	Thu, 23 May 2024 04:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3BDGhl4"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0B20DF7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439120; cv=none; b=uXMnAJcmAqwwZ89KN7dEdxZe6PcakYNE3dsU0P3DVbEqklUoh/jXM5h1kunZzFIeSPad6iHbOcZcPbl9UFMf3qApDJmXHm6kt5kXNTuJYc1M4ZzklA3Qse1eciJ/O6D7hna0F1BskUvRUVYIpqu7FCrma2O3KMAPw0T92hYqpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439120; c=relaxed/simple;
	bh=sLqwxYRWLi/EknlqTLKKf6eEdx7TZyvIBF8Tl5eh5dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh5OI4vZeh483j9pEpVVgnqp1Jx62yLukzjVLbvj3NsElMeT/02mo3gAxmWnpKowtafVl0oq/Ivb6hnIVnzqiOQ7Y9a2ISQkXmYmgjo5BFwTH/5/PehBJS0tBNth7nDWC8qCy2f01QGiNwtRaqXdZZk8NsZZsJyW6zNf3JjSBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3BDGhl4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso1735346a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716439118; x=1717043918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yx/IyOCYfXpCeY7uF5ICIIriQlpze5QD3ipJLntQuhY=;
        b=z3BDGhl4L7hVgR7A2mvoeqtyAqssNuZAV1chPNZwMwaPOJFZRJVZZjZMlxMcU95vLO
         N+moIEM7chbEf1YcBZ1Rdgb3dO4zt1wZpgTXcax0GvmoTf6/Oa/B0cWCJCbhy0za0dFw
         k6W9eO0nyRwOU0ymjKtTtQgx08eeZe/Qwc++qLVAYH9e6Bmflo8PApREdKdznoLbIy0L
         QOiLlEvWACBkMnnYFUHqtUTvjtjMacduR78lKPpGXtGjFxN0YatKc7RXdhE71Gu9Aeuf
         MnAhEXvI4JfgHGhFk8NmiBgHV59inIzFxIuImKi9YDWI3OdbLXgWyV4N88OTM/yw71Sd
         OjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716439118; x=1717043918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yx/IyOCYfXpCeY7uF5ICIIriQlpze5QD3ipJLntQuhY=;
        b=QuSLNFpNSYYx6K0FFNEUnT1sA+unFz/Wt1eSRMFO1y0WdtfPH+3QW288IIHnIgvFJF
         riABL03QvKz6fjklCiUPcyka4HPRN6bYMe5jknQS708UB74ETVdpsKMjy2zYTqA5U2Jv
         S6FXoStl9PGO63lhSE5GN8w9XSZAWaFQvoD5uHwCXu4zF4sZmqgvzJpdbq/OfJgM+se7
         WkXiSMj+UR6YPdR8/7Q/qZRgQ2AAbftmiHsjojf/iPlFHxgI4VloDR0d/3Q9cmfzmDdp
         yGKq/VWzyLvNBZxRKcB5lsoVkqFW57ekuCPw0LnqUIvzTIoOWnMfJjVS3DJWoaaqZMs3
         brLg==
X-Forwarded-Encrypted: i=1; AJvYcCWISGsmxnwueYsph3It8Cm6H4T/zjkmldxOYMf2JGu60R04XQH/Bg2btq4IMUcuGb6tXUX31qk8C7NHGEpZaFru2A3FPE1L6N2aO8at
X-Gm-Message-State: AOJu0YzqADjbvHPqxFmUsCc+oyV17QShxP2+qAZOsOlALqfe/mHuAX89
	yl1s7WHhLt9n/X0mSlU/6Kzqrr+hcAcHW2bIEeXWuVvMxTKxkiXTGs/NznHU9A==
X-Google-Smtp-Source: AGHT+IGFia7qcvwiNk7C0cFGAA4kfsQWTt46R5waKo9eNbE72+nSC/qxM96B5ZKcnaWLZtd7r5qMFA==
X-Received: by 2002:a17:90b:3545:b0:2bd:ed72:29dd with SMTP id 98e67ed59e1d1-2bded722a42mr183089a91.27.1716439116882;
        Wed, 22 May 2024 21:38:36 -0700 (PDT)
Received: from thinkpad ([120.60.139.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f4c604sm633634a91.41.2024.05.22.21.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:38:36 -0700 (PDT)
Date: Thu, 23 May 2024 10:08:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, quic_cang@quicinc.com,
	quic_nitirawa@quicinc.com, avri.altman@wdc.com, beanhuo@micron.com,
	adrian.hunter@intel.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Stanley Chu <stanley.chu@mediatek.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Po-Wen Kao <powen.kao@mediatek.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] scsi: ufs: core: Support Updating UIC Command
 Timeout
Message-ID: <20240523043828.GA5758@thinkpad>
References: <cover.1716359578.git.quic_nguyenb@quicinc.com>
 <292d7702e946ca513af51236ca9e38bf1b1eb269.1716359578.git.quic_nguyenb@quicinc.com>
 <cb05bc3f-5fb0-45aa-961b-bb9edc007407@acm.org>
 <d4d7ac49-1055-5305-99b5-af8e1428c746@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4d7ac49-1055-5305-99b5-af8e1428c746@quicinc.com>

On Wed, May 22, 2024 at 01:51:06PM -0700, Bao D. Nguyen wrote:
> On 5/22/2024 11:16 AM, Bart Van Assche wrote:
> > On 5/22/24 00:01, Bao D. Nguyen wrote:
> > > interrupt starvations happen occasionally because the uart may
> > > print long debug messages from different modules in the system.
> > 
> > I think that's a bug in the UART driver that should be fixed in the
> > UART driver.
> 
> Thanks Bart.
> I am not familiar with the UART drivers. I looked at some UART code and it
> could be interpreted as their choice of implementation.
> During product development, the UART may be used. However, when the
> development completes, most likely the UART logging is disabled due to
> performance reason.
> 
> This change is to give flexibility to the SoCs to use the UART
> implementation of their choice and to choose the desired UIC command timeout
> without affecting the system stability or the default hardcoded UIC timeout
> value of 500ms that others may be using.
> 

If UART runs in atomic context for 500ms, then it is doomed.

But for increasing the UIC timeout, I agree that the flexibility is acceptable.
In that case, please use a user configurable option like cmdline etc... instead
of hardcoding the value in glue drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

