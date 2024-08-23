Return-Path: <linux-kernel+bounces-298556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713D95C8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC4283774
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3414A093;
	Fri, 23 Aug 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLgD7Ve/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA61149C63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403824; cv=none; b=SiSD0F2OFyBnVDigADu6TwzXkFGQqdng5t3m7l31c62vtcMAMtI9uM8ep/sTGAosNiLpdcBK/MUaYwD/ib2/jH6qqNo0hpgRtr/uQ4eHPPBvUJu0MbBuqU8FdCZdJFsCIvW5n7mV1S13A9c29rq8y+DnpXJr4Hxn4bG4xEZWT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403824; c=relaxed/simple;
	bh=6pgSQ39T9Plmpl4AfmQ3YZoIf570bVZ3OiwSjBwhTbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7BGATGPTWLgDR+0ptosKnoOhaatyQSk06I5qxTenz6+xi7jtxL5DdWNDhdV++aAK+dhyR7WIr+bsv+IKQUbdkXWJeC7sHti8eOO9kPUiRMI6haDGSxFCg19vNpGO48dwS9B2BlkBI1GAiU6VMAtMU6IjjL5ZBnCMusTdhgp7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLgD7Ve/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8692bbec79so227299866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724403820; x=1725008620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ch25zyq2s/Kdq5vfRHfbF0eBNHDOnxoEELCgVT5D+gE=;
        b=vLgD7Ve/o/cPnb7cLiXpOQqmPNttBCGV+UeNVDQrDotU+n1ASD00YRi+k/MIdiFPu+
         uuqcBiV16yoj26GoGSQDWiHOzNXqjJmixNolLiUAyTSBGcIEr97nNIk3jCrlyoWy0LC9
         x8i2XHp6C7LUWL4R0ilYpRBZ1F0MwJsljuAWIFFrbOjOOXm1y6oz6p+1R4Zq3Ud5Iexl
         MjzdVcew0NErhMuHvgctJgI+hLbcKkkVDotjSaEqmgu0kfJ4cOGoiab12DUzRZzEQ5OO
         hM9W1YxHcMHNBcNNHSiPbTyW8jE2wJIyrhBrTtTqK+9Y6E+34GmrD5amAjsk91lDJbX0
         S++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403820; x=1725008620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch25zyq2s/Kdq5vfRHfbF0eBNHDOnxoEELCgVT5D+gE=;
        b=oyWvFRwh3g53GAd4MSAR+kkJIsAuhtHl7mSvgC4FVxjtrWfSmPPIdZHwvuiFtLKebW
         6JofYiSXMka1zUjipv1o7PuyNYB8qWXUAmHAp2pu/RQoT5y0G0P8y2K6C6GE9M8Gtzfu
         hcb+9kUpVZUnyQmjCCCfHUdmb8181RD/miTD3JvHNpjywr+GmRO0zBgK8JBthoNEqrDx
         xrpiyPI2s7Q2O3roSFPmtKMVxcH05YsmHUf7BTubSWe2XUmSVPNrZ94SGo+eRY01a/7y
         INqhyN84RctQKa5HTr1vo0b2lpKg17vbwKpyRCMMP0yLmQTh9HZi4RGOI+J9/oVmfLi+
         tmeA==
X-Forwarded-Encrypted: i=1; AJvYcCX6B2Ekxipw4npax1Y+h/zZ8txmjmDqrhKdJ5YfHnwI98S+nfMGRwGe7VUOv2JKoEHtpL3dvInCHxAnG90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBsfe1e3nMtGyGd3J2BwGUq/r+uSyBYFtx/0VhMRiIR3WUMJH
	ohUmaepTUEaNiRWqGsNMsaTKUy6vB03Wa5/YY9avU3S3TLbFVJ8FHXcGH5IQMZkgLXtwWed9z6n
	N
X-Google-Smtp-Source: AGHT+IFL2ahd9iW6kioYgjRY7ywdjB0PoAxv2j34f9YFYNVQDqx3JkjYGC0pnPM8LImqUDl7HFqgZQ==
X-Received: by 2002:a17:907:7f12:b0:a7a:bad3:e5b9 with SMTP id a640c23a62f3a-a86a5168f1cmr93975766b.11.1724403819514;
        Fri, 23 Aug 2024 02:03:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e48e2sm230158366b.89.2024.08.23.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:03:38 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:03:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: benjamin.berg@intel.com, daniel.gabay@intel.com,
	gregory.greenman@intel.com, johannes.berg@intel.com,
	kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
Message-ID: <3a9fc675-9c39-47e1-8735-a9d107b4d0be@stanley.mountain>
References: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
 <20240823030423.1781977-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823030423.1781977-1-make24@iscas.ac.cn>

On Fri, Aug 23, 2024 at 11:04:23AM +0800, Ma Ke wrote:
> Dan Carpenter<dan.carpenter@linaro.org> wrote:
> > The Subject says RESEND but doesn't explain why you are resending.
> > You probably meant v2, but again it needs an explanation.
> > 
> > On Fri, Aug 02, 2024 at 12:27:40PM +0800, Ma Ke wrote:
> > > This error path should return -EINVAL instead of success.
> > 
> > Why do you feel that way?  Have you tested it?  What is the user visible
> > effect of this bug?
> > 
> > I slightly feel hypocritical because I have send lots of commit messages
> > with exactly this commit message.  The difference is that I only send
> > really easy patches where it's obvious what the intent was.  A normal
> > kernel developer wouldn't need to leave their email client or view any
> > outside information to see that my patch is correct.  If a patch is not
> > dead easy, I normally just report it.  (Sometimes I report dead easy
> > bugs as well because I am lazy and maybe it's the end of my work day
> > or whatever).
> > 
> > This patch on the other hand is more subtle and it's not clear why the
> > continue statements changed into returns.
> > 
> > regards,
> > dan carpenter
> Thank you for your response to the vulnerability I submitted. Yes, we 
> believe there is a similar issue. As described in [1], it gets pointers 
> which are handled under the protection mechanism. If the path is error, it 
> should return -EINVAL directly instead of success. The discovery of this 
> problem was confirmed through manual review of the code and compilation 
> testing. And by the way, I resent the patch because I hadn’t received a 
> reply for a long time, so I resent it.
> 
> [1] https://lore.kernel.org/all/MW5PR11MB58102E1897D7437CD8E1DF27A3DDA@MW5PR11MB5810.namprd11.prod.outlook.com/
> 

Oh, huh.  If I understand it correctly, you're copying the logic from my patch.

71b5e40651d8 ("wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()")

That was a different situation:
1) The code was already doing a return instead of a continue, it's just that
   the error code wasn't set.
2) I mentioned in my email that I wasn't sure of the logic, but just copy and
   pasting from similar code.
3) Plus my code is on a WARN_ON() path so it's almost certainly dead code.  That
   means my patch was very safe.

Meanwhile Gregory's code looks deliberate.  If it's causing an issue at runtime
definitely we need to fix that.  Or if we can find a bug in it then sure.  But
don't assume my code is better than his, because it's likely not the case.

regards,
dan carpenter

