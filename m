Return-Path: <linux-kernel+bounces-429512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87B9E1D24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22D0165040
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD581EF082;
	Tue,  3 Dec 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzfxKmuY"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F91EF087
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231341; cv=none; b=lkWT0B2arGKC4/ItQnQT7NFbo1S3IurV6nIM01LdcSRatZcL7n2g2Wx8vQYv6kk3TyL70xQdLVIlIUE1Y5vRP0Mzk9+xOc5Iic8AcxqB8jfP09X3//MjRpOiHF0EJ/BCbw/6C+YHc0SdBX2uV7/vqMXNkmtVQBzsTpkYksxOB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231341; c=relaxed/simple;
	bh=WoMHRJb0tkxTD9vjf51l2F+vHsZpZpKuGhGA2Oq1gss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCiXpXsmhsqAb0Qoz4HyfizK8696dm/PpQF5Z9MNXyttdYzXTMM5ZoOCrl7Pb7Scc7p3iqs0JJeckvwcY5XTC3wkpPZ2zSQNzDwLhF9hKNJ0zZnZ4lzHPP4EWqnSiVXRy91VqdDddPRmYTi/IhfOOEeiGoHoMlTLUb35dGS8Bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzfxKmuY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3001490ba93so1154951fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733231338; x=1733836138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/lL5pAiR2kE/Mua5K3k92X0rB9806Pb8dHr6N7ntE4=;
        b=wzfxKmuYk5ozemAQGpcNecfNwB1VoPsCN0nT8udbJgCnd4C128IpW7bfZ7EmHeHFfb
         geQgPtClkssTwkbCqtfQU3Zo/VfMBZy+J9enEoSYswfL0FPFvnwKtBSuvCbna8fld9Z/
         88FyWdMGgHSp8Jv/uEKMnoBGJZl2fwCht80Ustv9gMstEyZA91OfbZpZidEekDR/lymH
         GYSFQRr2Xr6xJzKRxedoIMW7CgRDn9PtY1XJ/NVzKg0+MVTX7uJC17i4mNm+91aUxMKo
         X3jiuJa5hSZyXMviaywgKgzI+akl/s9cBFZF2qczSp15ktgGYgwf5v5P9fuymPaNlzjb
         Ml6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231338; x=1733836138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/lL5pAiR2kE/Mua5K3k92X0rB9806Pb8dHr6N7ntE4=;
        b=S9QW21yH/AAm9cac1fmHUOmQtCXN4Mx08/lANKsD3TGtaI9k7vFh+de9zJkVAlp+T7
         iGEE/pcht/gR6equdUpUUpICUd2HlNwpCS8kWSDEwN284Uyje0u19WmsETLgQNUzxNsf
         WwLIYJitMYH5ewJ3qHMFnETaVmF3ZmwuBsKXTx9kTOmHqr/5K6NESFVafGoGo1/d9Ojd
         lFEuN500pBv3+aKEfg6EGzx/dbePXg4VRGKguOJQJlXnr2jbnzcqK1lc4MJt4WuDv+rb
         eu9I398Y1uoFMyaPAh6MGTNIVHjmu6ASKN7VcJ4lLoSQnU1vVtkjLSSL6ChRpVRPJQQ3
         CK/A==
X-Forwarded-Encrypted: i=1; AJvYcCUgzpqHW0rC19m7iMZ9SjPcJ/hH1DZ3DOu1kEYVDAz5WOSnHp/422janTL+NnXqUDlCQnpdwTVDSc431cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0E0OPBEchkXlu0xnW7zAI19MekhnJ5RonuQxFn/HHPW4+S5i
	NW6M80JiSo/fvwUMyAUBQCRRN5rR6VD8hx2zeO5rHzbBPts0rJcVuUOoHcV9At0=
X-Gm-Gg: ASbGncusG8AyIQhvLA17yBddQUj1aVbFtCdOopCzNgdhcy0wHfyF43IzvyY8YlrX9jb
	t7cPewITYgukIeA+FSj99uiCde1A51pdqP9PdrgtnfmO86gLg7qFOdkpz0py/OHeB1FGElkXmIv
	sG33bL19vRfENh3ChmGNebGBL1d9c/zL5wFE6+DLvs+SgA7vuijZkn2OpojfmmUh3hrHGQieY9p
	3miWOLYirwlPANyW0vzjILZ+8bJNSp/1f75jcHRM/kqd2TJ2BfJK8kDjRHNfToUbfmyrRUQLiiV
	U00sqOLkT/RCfIm3QDQTCe63aZfQaQ==
X-Google-Smtp-Source: AGHT+IFThbwM7lX3Y2ipfgIhRvnqePc6hLDMc8QwYoeSkbRqOQTvnGXT+2fwk+HTyaWcY0FW9Hg0Cw==
X-Received: by 2002:a05:651c:503:b0:2ff:c349:8d08 with SMTP id 38308e7fff4ca-30009c73a30mr17954081fa.8.1733231338062;
        Tue, 03 Dec 2024 05:08:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3000a3fb991sm1970151fa.70.2024.12.03.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:08:56 -0800 (PST)
Date: Tue, 3 Dec 2024 15:08:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, agross@kernel.org, 
	ath11k@lists.infradead.org, konradybcio@kernel.org, kvalo@kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, quic_jjohnson@quicinc.com, 
	quic_miaoqing@quicinc.com, quic_vgarodia@quicinc.com, stanimir.k.varbanov@gmail.com, 
	quic_jiaymao@quicinc.com
Subject: Re: [PATCH v3] arm64: dts: qcom: qcs615: add WiFi/BT nodes
Message-ID: <vpnvycgbjtksjbktiksaltb73w34ogdxt5satz7cpmel63j3mm@aqvih2idpdfw>
References: <20241203060318.1750927-1-quic_yuzha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203060318.1750927-1-quic_yuzha@quicinc.com>

On Tue, Dec 03, 2024 at 02:03:18PM +0800, Yu Zhang(Yuriy) wrote:
> Add a node for the PMU module of the WCN6855 present on the qcs615
> board. Assign its LDO power outputs to the existing WiFi/BT module.
> 
> This patch depends on below patch series:
> - base
> https://lore.kernel.org/all/20241104-add_initial_support_for_qcs615-v5-0-9dde8d7b80b0@quicinc.com/
> - pmic
> https://lore.kernel.org/all/20241202-adds-spmi-pmic-peripherals-for-qcs615-v6-0-bdd306b4940d@quicinc.com/
> - pci
> https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/

This doesn't belong to the commit message. The list of dependncies makes
no sense once they land upstream. Please switch to the b4 tool, use b4
prep --edit-cover to list such info (it will be automatically added to a
non-commit part of the email) and b4 prep --edit-deps to list
dependncies in a machine-readable format.

The patch itself looks good to me.

> 
> Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
> 
> 

-- 
With best wishes
Dmitry

