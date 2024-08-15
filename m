Return-Path: <linux-kernel+bounces-287940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B63952E63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F8DB21184
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9414884B;
	Thu, 15 Aug 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ervPDhk8"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6C60B96
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725423; cv=none; b=U5omIaE+dYA/pDBhWb7PcEIhhI2OnG7n+HDTuVZtpKNpSQs6UL+VCSd8p9Z+PRkkgXvflLP26D7vOK2id586nAfG9gO772pWB1/EO2oC6by3uLirurxGOtQ3aZrye1IrRHYzCWZZwgPgU458AdLA0Io5vhFxnFdbAHXZv4Ih9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725423; c=relaxed/simple;
	bh=NS6q424zO7FscwxFWdgMShaWvsF8IGf1p5nneAfiDas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE8i0LKABmFgXdCLBkYRZjDSJOCCXC1TLH+mvKeyyhv8NOGIM9QtDnQW8992Ug0oeQzlqw1ysTNacnS5bBUIL/GSM+CYAC+PrWPnBy9AkwFqwEz2mHMfmvhbf/jZzuXkrqYsKVITONTi52csYvNGV1zMn9WAgvJAkmBkQdTAJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ervPDhk8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso467572f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723725418; x=1724330218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gb4V01q4sny8As1O2rChFyvwv7yAOmXjNlhHJpN4eAw=;
        b=ervPDhk83nVvi1QltmOWIdQVdK9Enjvif7cHa4PvW3yqLzeAnbJ1LTg6LNfLLM8XmQ
         jBfHlT22J/ICuCG/Zg50fL9hNftu86JvZdl2esJ9ZxgNPdwrfUQM0H3RPqMpvvLiP3vF
         MylTNqs2JWxRSkqNY49RLMzNNAofcj5WCwXIqCYaA7zuENeYPWRehGO/LKVzZa5kFDyW
         +KLxQSEe84FCcmWCTzd2VX3pmtCbgZYtmYKEV2Iss+E0yXyeFxj/Qxp3SBIX/uWcenIK
         TAOoJ5TiyHuRBhXN6aRf5XPFm4L2pSMdwZri7+5tCtD+BRpMai/nrzrlKfgnF6Hjp1bX
         S0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725418; x=1724330218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb4V01q4sny8As1O2rChFyvwv7yAOmXjNlhHJpN4eAw=;
        b=TyY8rTAJqFx3jtno4C652QL2uzXFaO+3OnwnNq5BFjQXnjJs0JjF1WAylsHOieDSHe
         KLoxDiTwpJLaJ4H8cLtJZq8z7908o/HBjpSZ8izMj2g5CXAXY0xTPAScDVCLrpe9RFmo
         lyrcrsuSsUwgJbIDAIUa4kY9bG7e9yDJ+qugCK5F20G720EOBQKZM+BMADeExdG8XzTY
         qg+hnJg/sjnAt/K84xbmGcZBblbytiXlNv4mSGzNg/Ui2d3oJ66BooCpWp9piY3lQFzE
         O7tCkYfLNZKzENJ6vctfdj9/mpgA0miCgo5LMNfNIxPuBNkFsLkn4RtNiWVJqaxoKQUr
         +ABQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNlzT/7VLqhoTpuya2A0AiN3XdBUals23vNvAxUT7F0/z2eKHVujC2R35a6qTJJO96M4Yzr5x33bZS9DnXwuVGuMe8HDVB1JgcPDT7
X-Gm-Message-State: AOJu0YyA9bznqkSL6k2p78fiH5QVqCtSe2zuroeVkEPJQHU9qqUxTwHV
	f/l/abVgP4AabcEnjt7UH0MkHyo5sdzePjg05TGAFxAddXHx3A2Ktc/8Ds4LxYQ=
X-Google-Smtp-Source: AGHT+IHcLDt9IoOFHX1Ggjkc+pHg819sFLwh88mJRPXfyUtVcXrq7jTkTm5cpMdGh5Xwbwbif9PGmw==
X-Received: by 2002:adf:ec52:0:b0:368:5e34:4b4b with SMTP id ffacd0b85a97d-37177768ef1mr3617632f8f.6.1723725418092;
        Thu, 15 Aug 2024 05:36:58 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1c46fsm18353045e9.39.2024.08.15.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:36:56 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:36:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Feng zhou <zhoufeng.zf@bytedance.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bigeasy@linutronix.de, lorenzo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH] net: Don't allow to attach xdp if bond slave device's
 upper already has a program
Message-ID: <Zr32ZZ8e4RhYN1xd@nanopsycho.orion>
References: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
 <fd30815f-cf2b-42a0-9911-4f71e4e4dd14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd30815f-cf2b-42a0-9911-4f71e4e4dd14@redhat.com>

Thu, Aug 15, 2024 at 01:18:33PM CEST, pabeni@redhat.com wrote:
>On 8/14/24 11:08, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>> 
>> Cannot attach when an upper device already has a program, This
>> restriction is only for bond's slave devices, and should not be
>> accidentally injured for devices like eth0 and vxlan0.
>> 
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   net/core/dev.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 6ea1d20676fb..e1f87662376a 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9501,10 +9501,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>   	}
>>   	/* don't allow if an upper device already has a program */
>> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> -		if (dev_xdp_prog_count(upper) > 0) {
>> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> -			return -EEXIST;
>> +	if (netif_is_bond_slave(dev)) {
>
>I think we want to consider even team port devices.

netif_is_lag_port()


>
>Thanks,
>
>Paolo
>

