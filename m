Return-Path: <linux-kernel+bounces-352750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 150199923BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8060BB22414
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46742AD05;
	Mon,  7 Oct 2024 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJLWc1hf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A94204D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276934; cv=none; b=EmEubcVobq79RcmKftjSwthCGf34snfMWAhpQ4IR4ih0WgIJ1tqCevAkvuW2eaKqa1OvconLR4TNv8RqxJxmTx/ZOk5w9nVS4O1wJwytZmjCmAfBkQ3NT9gYbybaZwR9sgSnFNg0EgCGmg98EOx0nNcI/PQfZ+A9t5crSttDJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276934; c=relaxed/simple;
	bh=Y2bda3mGfiwGlrzgQPpEpMIie5Ls/ev+55m5OE+yNF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcQmk+z9DwPBweYqiqnYE8xETqrfYeyNz+f4EMOW5v25IMNiVDYO98QHq3qcXd6OI7t2HH3GqAkKlQ3vea66T5THVHjdC3OTtMN+uBuc8Zaa4V/xb9gZ+BqctpQH/IBXshIXDtf3XsjuV/JtCJUvJNo2d7i5ha3rGxiR79ldo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJLWc1hf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so4663071e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 21:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728276929; x=1728881729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6xcwrBoXuHmz7DbARIgYbfXwaKZHrTi0jMKEdF4o40=;
        b=VJLWc1hfsmjBxsO0V14wicVv3UxLtIZNwxetwIBLFIZcb4HS5HzzZPFuhd4nqF2OHY
         Ctk/8ERi0/diPo4Br1S5cNbStpEXPfPQyKspW3FRGe86acHAirPwxYz6X8DWeKVePkoi
         OGOm/r2JCFbPW43XeJUC8OP6F7TJ5l1PjBYodpAQGrYNdhUPBO3X+qoygTiUaiTk3l9j
         we1dpRQqb/ZduyeZ87nwfQhmyid2+9ZSvbWq9x/cTRV0TDbZaGuvHkROSmDuw6J0C5eL
         6vwN6eG8IYmBIC6TZUFnOpl3uf69BXqphLhaJ5NW1BKVQvt9v0UuF+HuhHFmN6VofHPr
         Cdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728276929; x=1728881729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6xcwrBoXuHmz7DbARIgYbfXwaKZHrTi0jMKEdF4o40=;
        b=dQAr5oPcAU62r7L1BOnpwmLu5omdAwE6Mv1FJc2PuKO+yrkgSgpG17n2fX7LaYefzo
         bAWP9xhTDYi83vqwovScgo1jVAnIsHiJUgvY7Te22NlQXt8uOZeQB9Epf+SN5FUGeBOR
         lYXqJgFd5/P77COene+BgYYqlx4wzt9AqqUM/B/Rsf9owglDCUrn4MvNed4d282kB7kB
         s1aLU1DFjOeKeJTHSX06saFpxLSDKPMqIoeFkbFyNxzqfsRqD6NIjoDl8lwl5PCbvlhF
         oQVcP3mYju/rVqQGjMyiZGGKIOOgWO1hu20besVPAfiBhjCdn4l9Qpvn8umRakFCOkwD
         8r9A==
X-Forwarded-Encrypted: i=1; AJvYcCU1eB5CWvI+jWyLORZMLZDwkSJE2jp9JscbG9PNKM8QANGnzkmatmjJCFOwiwAGDuItQT2ox51Jhj5SgmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5dBfWsY5TI1wLe07xW/pPkNoandctlA12dZprjVvFsVGT4TH
	Ib5j5cTJzff/vSSUkNXvBxPjKujlDZw3fVqaSUu1CQeboLW2EE/1crpU7CEYZU4=
X-Google-Smtp-Source: AGHT+IGXMAuGqMtBvrWsmOq7ynzzo7ewDWrA4vrd6ryejLcyARqvVHqB/yG3diLj17MPbt7U0IKkfA==
X-Received: by 2002:a05:6512:b90:b0:539:93e8:7ed8 with SMTP id 2adb3069b0e04-539a626a412mr4461045e87.15.1728276929284;
        Sun, 06 Oct 2024 21:55:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d168sm705946e87.142.2024.10.06.21.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 21:55:28 -0700 (PDT)
Date: Mon, 7 Oct 2024 07:55:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jianhua Lu <lujianhua000@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath11k@lists.infradead.org
Subject: Re: [PATCH 2/3]  arm64: dts: qcom: sm8250-xiaomi-elish: Add wifi node
Message-ID: <nxkw7osy3cpd2ts7jeidknd6mgt4wfjaf5pzabzy54aiza5mij@dpbznolilbnf>
References: <20240929112908.99612-1-lujianhua000@gmail.com>
 <20240929112908.99612-2-lujianhua000@gmail.com>
 <p75ivby5ajlmnvebqkn3mq7t5xh6awewjwkwpa5rjiqv2ijijl@aqemqgxveu55>
 <ZwNODSqKNJmkY-l2@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwNODSqKNJmkY-l2@localhost.localdomain>

On Mon, Oct 07, 2024 at 10:57:17AM GMT, Jianhua Lu wrote:
> On Mon, Oct 07, 2024 at 12:02:34AM +0300, Dmitry Baryshkov wrote:
> > On Sun, Sep 29, 2024 at 07:29:07PM GMT, Jianhua Lu wrote:
> > > Add wifi node and this wifi module is connected to pice port.
> > 
> > Could you please add ath11k probe messages to the log? We might need to
> > add an additional node with the calibration variant.
> > 
> Hi, Dmitry. Do you mean that I should add ath11k probe message to the commit message?
> The following is ath11k probe message:
> [   10.285469] ath11k_pci 0000:01:00.0: Adding to iommu group 12
> [   10.285637] ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
> [   10.285699] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [   10.286003] ath11k_pci 0000:01:00.0: MSI vectors: 32
> [   10.286023] ath11k_pci 0000:01:00.0: qca6390 hw2.0
> [   10.652407] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [   10.652429] ath11k_pci 0000:01:00.0: fw_version 0x10121492 fw_build_timestamp 2021-11-04 11:23 fw_build_id
> 
> I'm not sure if it's necessary to add calibration variant because wifi
> works normally on this board without adding calibration variant.

Added ath11k ML and corresponding maintainers to cc. Please cc them in
future revisions of this patchset. If you were to send the next
iteration of the series, please include the quoted log into the commit
message.

The board_id 0xff most likely requires calibration variant. Please
consider adding one and submitting board.elf following the process
specified at [1].

[1] https://wireless.wiki.kernel.org/en/users/drivers/ath10k/boardfiles

-- 
With best wishes
Dmitry

