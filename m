Return-Path: <linux-kernel+bounces-565495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B35AA66987
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69712188C541
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134B1DD88F;
	Tue, 18 Mar 2025 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLl9v818"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C21D6DBC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276328; cv=none; b=DB44PlirgEZCEMlyuMHuvTig6CRhEE9VsTT4afUB3wQcNMOvkmsHi6+bJ+EQUAqN3diI3pV4GVAl7s+7h/qUrmyB34Fonr0VpgamjiaQO12LBJ9R1B7+R3/WAA+pwHHSIJa6TdzfwZTs6KlmlpXS5iRI+bOs7Zg8ejdFV8mXBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276328; c=relaxed/simple;
	bh=P5iM0uabpaJ1AbJIJnKcL+VevuH5PXzgqzzKXmVjFEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSQ5ZTm1cJxAV1GYxrsu/5O1vJ1bp6WGg/KGeNrh04MpyVbknoFW9A+1ZMG7RnyJfT2Qi1W+lvlT4X6l/720xScVvG46f7lEIgCQjdsBQwhYQ2/drIn9w98mhUlyX2GLJLRSAedEbBKEeUropqzoZFAzIyFqRIPqLeH/kanOSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLl9v818; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225b5448519so96542255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742276325; x=1742881125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdaqatqISFRYNU0Pl5hfD9x9pMSiXYmVb+XBgyOMwkY=;
        b=QLl9v818V12gQj0t843raaAQ3YRcjybkx4tqoaoX3tZumoohYu9dBHxkiDImCIi9ph
         1gu9zg1gsV6DkAKiPqxbY0qB7FTbIRi7JTNuY/6dZoJQOn1ZmsUSMyA1IrcqlI2Pbzfc
         zTP5K4yzt5B8Lwsr6rklRmZzSCy9L/nUKT3/j+i1x5C9hVaoTe3TocaHt1zFkJHhwxnG
         0vkxGZVGJ36SFYvaoaUhq8bRUQxEq8+08AkBGEb3CDGExn/+uK7QSynrwTUi4inXOLOr
         9LW5/MFph9JSqbTfHHNfXWQjex+Ce59aZnyEICG4NIW2KOCxQKpGyXntw7d1RT9OEFJt
         VWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276325; x=1742881125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdaqatqISFRYNU0Pl5hfD9x9pMSiXYmVb+XBgyOMwkY=;
        b=LK01F+TielyFn8U84HgbICBtUjIp1hSNTKY6rT8GeBej+/DY9rN3DWz5+upud43Q5y
         DvNqNKw79zmn4N1/u8Ki7fwtXdgg+h6I1/jHVu3ezaY7XJD//ZmGuC7xKxkQyRl23a2N
         eqfJ91AUtKg16dgYAp9RP8YoQm/pvWiq2naraRNH0ajNu7f6vnMO8C5gjpaUq7LAVcOq
         QgcJYK0uQnlxFtuMrHpZVvfuq7h49NtUHMmGtyyPcnBvPz7P93Rn3A8Ib/qNvRWlkCD1
         n10uuUI/fpqg1oWon2VdaKQuDAInFNkZPP+iey/mY22eKxnqkMCx4zhy18YghSON05gD
         aCNA==
X-Forwarded-Encrypted: i=1; AJvYcCUDZ/As402hv52jGafFZHLy8UKylmIfl74lvw+kA0Vp60IzXfCty5o5hxidY5uRlN7ClX8yYjWFNcUVKUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwljLT2p7q/3vDBD7ugGNTVMOOQ20WSquuIgpd0zOPQyK4Qzj
	jfBH9u4kMx9D9ReG6JFrSIXdjvYhRebL2gJNQJNXExt+p3vsoMQK6Qgbuyz7Ig==
X-Gm-Gg: ASbGncuakXc+j5VOoAuFPj8wjlJG+eoTYIq+3tQlnYwn8xuvZ6fk5i8Xcs/GD3kOReN
	u1Uy90bKBp2wIM6TB3MHQe7pAl13Fmc1vlhv5ynRQUh391sIyA+gEDFCSBSkleeVrPNlUV5a27Q
	UshbkIR1zol6AiaVEi4J4sVELMkl+CphCFUfq8FRX++mx+XyTQ4wKhOtSKtwWjlThgV7YeqKEeX
	/u7xrHQ9lFyw8F1195VEFuhCo2Uc79eZiS+uCOVZWsWgIFI0YV/P2GYMZ3jBak4ScusOGFCfEqC
	kJdDvZgSMSrur+wQPQZza4+hJWP7A3PshXK/EgtolOEGnVvwOC6CNZOFMwWltpxMGqQ=
X-Google-Smtp-Source: AGHT+IGtKPupstxaJ9l2OYhRXppRqOSSephtsRZM9k0tdvFT4Iz+eKcqIdvaN6lvgoSbh8+SItbTKA==
X-Received: by 2002:a05:6a00:464f:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-737223fd0ecmr16558503b3a.22.1742276324825;
        Mon, 17 Mar 2025 22:38:44 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1024sm8604240b3a.168.2025.03.17.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:38:44 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:08:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com,
	johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 4/8] PCI: qcom: Add QCS8300 PCIe support
Message-ID: <20250318053836.tievnd5ohzl7bmox@thinkpad>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-5-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310063103.3924525-5-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:30:59PM +0800, Ziyue Zhang wrote:
> Add support for QCS8300 SoC that uses controller version 5.90 so reusing
> the 1.34.0 config.

This is not a valid argument. You should mention that the controller is of
version <Qcom IP version>, but compatible with version 1.34.0 controllers and
hence reusing that ops.

5.90 is the synopsys IP version, not Qcom one. You should mention both.

> 

Please add more info about the controller like link speed, max lane count,
etc...

Moreover, cfg_1_34_0 has the 'override_no_snoop' bit set to override read/write
no snoop attributes. Are they applicable to this controller also?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

