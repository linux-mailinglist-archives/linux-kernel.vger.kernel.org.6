Return-Path: <linux-kernel+bounces-514482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12ABA3578E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D493AC1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B980614A4CC;
	Fri, 14 Feb 2025 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVXza/pq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8D127E18
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516697; cv=none; b=KZFqZHR5WkCRqlUJiNz4jif+H8Bbq6n3rBX2ryxECMwBe8girz9rDQse1OExASu9pbYfgC7ipS5VlngWr8KUHTk4e8HPx2Q5fF2A3jxVGQT/HWUlytwDBNYhgnagdwwO9WAAsDZxpo30pKtwMY1UVzKeBRnNmlIkyh5YzKRUFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516697; c=relaxed/simple;
	bh=inoYxAUSZL0MSsh61jRPAz7Xi/ChSIhVE59oDoIvQIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUBdGSyYp+2nXJh0hnPG15UEAJB1v56D+bJG2UrBZBCT6Q+kz6RBT996R3MEyfXEd/a8SCtPcwPXutvo7dZiI0y9KQtlFq5CG65R4FoLhUPYlc9FNFzBKLhKV/OvcMY3IcydGtH3dBaP4lEUsiYIV2E6+fQwad+Be2XE86YfVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sVXza/pq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220ec47991aso7181145ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739516695; x=1740121495; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P0N0X3RdIUpKTp5bovKhP0i6D22WIPGqOlaqXbJdgtw=;
        b=sVXza/pqbI+UVLxjlslCjCdoQ40KT3F5oDRhgB4yLRWP8+V9E1bYA/3pn0yN16l/sO
         X1H215pgmEV5lKp5DMCXJyhf1PzpLEUtSFYsMrTgH2ro+xIjSuleSbFaLdVyRZa3zQTz
         yj2V6ytUeL5HiptcsaM3irYrJo+0uw/ruuLez8/R4RTREpcmOwQ1UWsOvlN13Os2xQNB
         X7F0RmzQXK+zUvN3FoXtJfeSW9uFPT4cBuQC8hAqNClihALjpSWFc0ERhzKA54ezlmDx
         MqsJLUl6leQqYPtKHyJWrR3iG8QPRKwWAsJyJ7lzqrHkFU0DHMqpymeQiVPodn/nlews
         3Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739516695; x=1740121495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0N0X3RdIUpKTp5bovKhP0i6D22WIPGqOlaqXbJdgtw=;
        b=gaVwpZaeMtfdo/oHj7lHpFhuK+cbAki4ZCK0W07sKBiGV+Y/txV3FLgoOcg5sfru3J
         AoZ72LmVCZNC9s6Is4P05juVHDlSsCoTij/m+Z3r3mLHIZDuZRlxDw7spL7YSnY8Dyzo
         NDCVGjhkkmXBV6dd2OxFLyIt1YemjEylyJi3Z/ghRtW6Onzv7If5IDzEww/nV5ivbCfq
         q18gm3BzfLpt/hknCwWMcAf7TJlms1YYqQbPUqLmmlVocyjhY45pO7rT+bFgGMkj2VnP
         9VZlMFqrxlczlwPxYGHQzEQE23jMENBDPapbl0ecLVOeBWSxZfFHRe8E0MHL2aL3lj9M
         onZw==
X-Forwarded-Encrypted: i=1; AJvYcCVu2EaIxgHy/5w7wEoGjxYUSVIIct8mKUzKzkbW8kitFTOHi3XIAe7GwjpK2WyOj3/t916sJ60Y5Euz3LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdG8ptVxnllH67XqvgzU52cLlErTdWFgySqRki4qRiFqIGlmON
	juEbl/o2AyMLxzNP5+EinhArDmC8XQShyNXXaRkLW40rBRM/ava+kN7QLn7Fmg==
X-Gm-Gg: ASbGnctgR6s8nUqDzfqLphGfGw3xQTL4pW8wzL9dd1NMnBzThDxW8h5zKJZ1LDmg+Em
	AkOGl3HHVDbYAzopx7eZdfpflzeUYsPaG//4bOMMjY5y6xS4WdUv3CcgH1T4HUXDwD3kXdIqgV5
	yaYeFdxM3UmdnfzdEAAA8/mbtqi8BjHMHpAWkS6/b1kyHUScAtoDAVZVQqQVMRZH3ODnzkpZR4E
	6WiQ6LN5GoVTPJ+JYkKibn5QinSnOXrgueIXE+Eg5BbN+vv38yTyR8S8oQrSNnTXkGUflktiB7e
	wdbvU36KOsSVhhaavC+xX3CKSQPJySo=
X-Google-Smtp-Source: AGHT+IGuqMZgZlagRCyTIKxDvOSsuvPGqcUxE8dosYx3w84r1nGN21q6LfaA+OlbApLZ3lRcHCSUbA==
X-Received: by 2002:a17:903:950:b0:220:e63c:5b08 with SMTP id d9443c01a7336-220e63c5e07mr59800745ad.11.1739516694826;
        Thu, 13 Feb 2025 23:04:54 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537ca99sm22711205ad.106.2025.02.13.23.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 23:04:54 -0800 (PST)
Date: Fri, 14 Feb 2025 12:34:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	kernel@collabora.com, ath11k@lists.infradead.org,
	jjohnson@kernel.org
Subject: Re: [BUG REPORT] MHI's resume from hibernate is broken
Message-ID: <20250214070447.scs6lpytjtecz3ko@thinkpad>
References: <59c036b6-a3d6-403b-8bb0-566a17f72abc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c036b6-a3d6-403b-8bb0-566a17f72abc@collabora.com>

Hi,

+ ath11k list and Jeff

On Tue, Feb 11, 2025 at 01:15:55PM +0500, Muhammad Usama Anjum wrote:
> Hi,
> 
> I've been digging in the MHI code to find the reason behind broken
> resume from hibernation for MHI. The same resume function is used
> for both resume from suspend and resume from hibernation. The resume
> from suspend works fine because at resume time the state of MHI is 
> MHI_STATE_M3. On the other hand, the state is MHI_STATE_RESET when
> we resume from hibernation.
> 
> It seems resume from MHI_STATE_RESET state isn't correctly supported.
> The channel state is MHI_CH_STATE_ENABLED at this point. We get error
> while switching channel state from MHI_CH_STATE_ENABLE to
> MHI_CH_STATE_RUNNING. Hence, channel state change fails and later mhi
> resume fails as well. 
> 
> I've put some debug prints to understand the issue. These may be
> helpful:
> 
> [  669.032683] mhi_update_channel_state: switch to MHI_CH_STATE_TYPE_START[2] channel state not possible cuzof channel current state[1]. mhi state: [0] Return -EINVAL
> [  669.032685] mhi_prepare_channel: mhi_update_channel_state to MHI_CH_STATE_TYPE_START[2] returned -22
> [  669.032693] qcom_mhi_qrtr mhi0_IPCR: failed to prepare for autoqueue transfer -22
> 

Thanks for the report!

Could you please enable the MHI and ath11k debug logs and share the full dmesg
to help us understand the issue better?

> This same error has been reported on some fix patches [1] [2]. Are there
> any patches which I should test? 
> 
> Is officially hibernation use case supported at all?
> 

Yes. The hibernation support was tested with x86 host machine for both MHI
modems and WLAN chipsets (especially ath11k devices).

> In my view, this path may not have gotten tested and can be fixed easily
> as we need to perform, more or less the same steps which were performed
> at init time. But I've not found much documentation around MHI protocol
> and its state machine, how is mhi state related to mhi channels support.
> 

During hibernation, the power to the device could be lost. But it should be
handled by the ath11k driver. Maybe the debug logs could help us know what is
going wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

