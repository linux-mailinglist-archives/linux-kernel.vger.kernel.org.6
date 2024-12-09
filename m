Return-Path: <linux-kernel+bounces-436736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797969E8A17
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452E91885540
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7566155C83;
	Mon,  9 Dec 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCTotBxC"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA6320B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717043; cv=none; b=igAM8SZSFEp7GkOid7jZ54lJQRrbgn1qQuTk2if5cn8OtUjvlVVYODLY9lI8HzdFHgXuRXqdexclC6yk4VqnCcMlcULr/FzOwF/81kOyircXGBlwB7v8qqhRWcJTZ5wuziPqEAf4sjnsZEM8z+umQQSlGXiYiWPQL1Waz9y0F9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717043; c=relaxed/simple;
	bh=cETlEE0WzQEHwy8QEzoaAMqjhzhL0tNxzJ0RsFPbUTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRuMgF1LY4jRN1cAo+qPHGoemQd3kOWZu6bdnivdAgt+DSFmlLHjxj6dCgQboG7qvXZQsxK9QylAjvXAQFAcLbCeHQUVSN6PcWcQY1Qvf2EHrD9hGq9iRF7iFlPGSvDw+byXgCa3ADSyk+OgN1lae8m6rzLg1JNsQzwR5XP9bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCTotBxC; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71deb545153so339906a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 20:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733717040; x=1734321840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSueRKS2Dc0oEFrhPvduUyI5vUBlKuQKvD4Db72M8fs=;
        b=aCTotBxC6veSmtoiU3NYRwqPWeFvOyubNoM1ckIbpIu7VRZM6TfFMFASN2wlGvefEu
         HGHMcrQdIKsgoFzsT+7658dhohetRFt8Aq8A/0+gRgFIDwSrgFU9nJyP/ha7zz1YZiPZ
         UQ6ikk/KjKksIcqrCpD7GUMDDO/fY4q/RwrsUf+TlWaJc2buOEiJqjDocRTeXULFjlJp
         X/n2llRQ5zb+VNXJ0UWiFxc3NhJYMcGLIrKKyknPq+hTExchj3xvcXD/ntWt/jg+yw5h
         zY1Ntt0YsL+d8d0B5lhXpZdF3AZaLkN7aql260Jg8OlW2Z0FKuXumvV3czWTsdPJgVsw
         WH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733717040; x=1734321840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSueRKS2Dc0oEFrhPvduUyI5vUBlKuQKvD4Db72M8fs=;
        b=plydCfOZRLdZMGEkG8nwPbHjaSBBoGdRUCUCv+ud3Q4nxWGHvWv+PYRe3OFlbIMfbg
         I05YYv359hux2eHNf4HDNH7KMNc4k2rx/p59qBy2zqRoTOYEz78Qgcoa/yB22wvo6l+d
         MXmbyWBbZJd6dl9L76Hhv2IMHY096PZKqTrdUiYdkpx78Ugp/tfo2ukQarFRw+80HQjQ
         DbON8MVVBwvyKh1JHymkFzHQvjedko4duTZPmrzlFzZ3lwlIAMKnRZYmDp1F4Ugk4U5k
         MKsYN65miNNYMqs3FKg8Gs4ZhvGEpKnslHXqLE19PfIWQgitISu6KmGSzojSDdNrUR4w
         +aYA==
X-Forwarded-Encrypted: i=1; AJvYcCUyD7gIQmoLAJpTKsOaIejKCVDkT7KhENnqIMXeezuMgnFWIpG+YiXcx2Aq/1J9lMN2JpiVHWgDwjZReAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DhyN/GTJ+pGjtO8yM3yZkTD4P/sXARREeb2Ri+/3URpkYP1U
	IfGJh0GxCDxlkl+FoReoP3IDe+QG7pfSQv125Wyq0IYlfVRBBSkuJhDn/dgopQ==
X-Gm-Gg: ASbGncsGEBA9tm1Ct9k/WXx+yG02GbADp0FSRgv6KXz2jz1XYTeMPeFTMDNhxNg/aNn
	DQfVOomEN5+V2zSOEcYoir6Rvz/xRxWzwKF6kODx3xBKOY1lKOEKhlZPdZnaVdKDsBLywouGV2v
	Iy/UieTdVVgsxjG4sLmdGYQY3yKtjNX3FFNHzfZsqR30DNSPS2+xD7FDkWygNZzmwB8aEts7TQ6
	PYrrW+iYjHmSSXiqpcc3NAMEekhGZBjmKO3iwtpK6NfryhRZt6jWlHiblM=
X-Google-Smtp-Source: AGHT+IHU6Xu+n7ZNg85zbpBlEgO5QS7TgqjBuo8IL4KCXkx6Wsj/Pkxh7R3VW7ABG7uDeLGEC57Xcw==
X-Received: by 2002:a05:6830:65c2:b0:71d:ee65:7c38 with SMTP id 46e09a7af769-71dee6581cbmr2249231a34.22.1733717040567;
        Sun, 08 Dec 2024 20:04:00 -0800 (PST)
Received: from thinkpad ([36.255.19.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725da385bfcsm2772546b3a.70.2024.12.08.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 20:04:00 -0800 (PST)
Date: Mon, 9 Dec 2024 09:33:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>,
	Manish Pandey <quic_mapa@quicinc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com
Subject: Re: [PATCH 0/3] scsi: ufs-qcom: Enable Dumping of Hibern8, MCQ, and
 Testbus Registers
Message-ID: <20241209040355.kc4ab6nfp6syw37q@thinkpad>
References: <20241025055054.23170-1-quic_mapa@quicinc.com>
 <20241112075000.vausf7ulr2t5svmg@thinkpad>
 <cb3b0c9c-4589-4b58-90a1-998743803c5a@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb3b0c9c-4589-4b58-90a1-998743803c5a@acm.org>

On Tue, Nov 12, 2024 at 10:10:02AM -0800, Bart Van Assche wrote:
> On 11/11/24 11:50 PM, Manivannan Sadhasivam wrote:
> > On Fri, Oct 25, 2024 at 11:20:51AM +0530, Manish Pandey wrote:
> > > Submitting a series of patches aimed at enhancing the debugging and monitoring capabilities
> > > of the UFS-QCOM driver. These patches introduce new functionalities that will significantly
> > > aid in diagnosing and resolving issues related to hardware and software operations.
> > > 
> > 
> > TBH, the current state of dumping UFSHC registers itself is just annoying as it
> > pollutes the kernel ring buffer. I don't think any peripheral driver in the
> > kernel does this. Please dump only relevant registers, not everything that you
> > feel like dumping.
> 
> I wouldn't mind if the code for dumping  UFSHC registers would be removed.
> 

Instead of removing, I'm planning to move the dump to dev_coredump framework.
But should we move all the error prints also? Like all ufshcd_print_*()
functions?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

