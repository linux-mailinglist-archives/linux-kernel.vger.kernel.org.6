Return-Path: <linux-kernel+bounces-239528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F59261B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992B01F23C53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D642D17A5A9;
	Wed,  3 Jul 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyvWpIyC"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFD173336
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012999; cv=none; b=g/fZOCUvQHTxmKKjzopNiCLFt+QDuMkFsn5zKoPZJHtmS6wGyXI9LPasb73wmgpyeUKz0i3MgK30YjbkqZZgRiBwS+kqBDI0GMQk2mqgGsWV69UI6L4ebNvhYljtXwyqJehyU1wBuLYdktbalGw4s0gI4+loIXwfaOtiwcGOjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012999; c=relaxed/simple;
	bh=XkZ36YVkSCYdsa2PZ9dd8KTKzlgKsyNmSOvBW6fXlRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGvI4yRSyzhDi3Jfi8lE3rWjNlGcgxzmDCgPlBCW5XJ/aTKiFSBUBtF84ZyJ+F4OKJyqc/vxRod3opfvM6CRoXP+NLtzjq1cvupGD8dIHQ6La0b3GdnVib23FODuBWyRhx0Q2rRiH3QQ+e5k3Hi1deOnKd+JXa/WXeYiVtiFyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyvWpIyC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c47cc12ddfso89914eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720012997; x=1720617797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5g2d7cGxt5LUhs3Ln8D9odUoDF0lLXQxROOlmlLiFA=;
        b=jyvWpIyCy7LZmxcm0VigiCYObo4vP6KKgFIJP14jAx1STjvEpVVu4EFbjizRTrZhiq
         36s9BNUCMBkaJYKiUDa/hh7nTOxl5ncSqMctElJBGjoCf78Gii6n2utEBESmrAy9uyYa
         uWHVDJ/XlpZImKDq6cn1lJeEooCvpC4pQcj8K6YbwK72/vAdeHaJWd5LGYaSXavaeipd
         hroDJvYzU15B+K84zHRMvzQ0iVUJb7PohuX/q66qI1gJ6O0aAbdnAcKQDeoH50mC7Cce
         NGdgXeEvKsPgDQwLeHUIXOY3zpNhKeR1k4/BGbkwYJYOKHMlE6DNILdRJVNUXXxz7nh+
         P8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720012997; x=1720617797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5g2d7cGxt5LUhs3Ln8D9odUoDF0lLXQxROOlmlLiFA=;
        b=uWEBsgMmTNls3yqpOkyP0cRhoziA21psLlsSL94suBjJqK2G0kjGJivHLZKo0jX1/1
         Hn34Ou+WKPuzBosw75jFAB1ZvM84eq61ySu5q9NlrxWaJc+QDWjP22wp998aXiN3PXBl
         +Hb7sT+0INf9gPhyXuD/FXrcxd3g4V+17SjKMTr5VUOZCY94mIq9VMmIoJf9mkxR5v5J
         imtMQDynjOiXCopCdQTEHPWilKiOjOvIQFnZooILBFovWyuozmXrX83vduHy4larvfNb
         yfOlZzZ3kO6EUQiYZs2K/othhog+Kg3JNTlbos1YH0imqE9ir036q74BE1VzXs86dhmA
         BKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsDIDJdC7Cbttk11LnrLeUDeVjGf3dBLWlWOPT+fQWX1LJYMpuxrAYgL9Z0dZXxYT6idjKwZMDusvib8fxQJX1IIcleDf04rMRA6sH
X-Gm-Message-State: AOJu0Yx9e+CnAVC+miDNom8xuUcgJtcm4LWCSma+2T7mFgmLMHZwaCL1
	VIVU59VQVr14v02tIjvGWhFa3WkHmkQTehKyuX0MHfcg3Sy/4vIHrsB4IC6OXqE=
X-Google-Smtp-Source: AGHT+IGplWSy9vOCLJA/qnz+gTqhZnkdj7xlESE8azCcFRv+VtomZcElQ/dKFnO84Qfq84NOw3z4Hw==
X-Received: by 2002:a4a:4884:0:b0:5c4:fc6:c7f5 with SMTP id 006d021491bc7-5c4390512d7mr11084414eaf.5.1720012996656;
        Wed, 03 Jul 2024 06:23:16 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:a6f1:b7be:4c8c:bf62])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c46ae49decsm327881eaf.24.2024.07.03.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:23:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:23:14 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Su Hui <suhui@nfschina.com>, Kalle Valo <kvalo@kernel.org>,
	johannes.berg@intel.com, kees@kernel.org, a@bayrepo.ru,
	marcan@marcan.st, quic_alokad@quicinc.com, zyytlz.wz@163.com,
	petr.tesarik.ext@huawei.com, duoming@zju.edu.cn,
	colin.i.king@gmail.com, frankyl@broadcom.com, meuleman@broadcom.com,
	phaber@broadcom.com, linville@tuxdriver.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless 1/9] wifi: cfg80211: avoid garbage value of
 'io_type' in brcmf_cfg80211_attach()
Message-ID: <3f7bcda7-092f-4d94-80c7-2015e860fbe2@suswa.mountain>
References: <36cef2a8-10a3-928a-d962-3599333d9ac8@nfschina.com>
 <19076e6bec0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19076e6bec0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>

On Wed, Jul 03, 2024 at 06:42:32AM +0200, Arend Van Spriel wrote:
> On July 3, 2024 3:42:18 AM Su Hui <suhui@nfschina.com> wrote:
> 
> > On 2024/7/2 23:39, Arend Van Spriel wrote:
> > > On July 2, 2024 5:29:27 PM Kalle Valo <kvalo@kernel.org> wrote:
> > > 
> > > > Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
> > > > 
> > > > > On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org>
> > > > > wrote:
> > > > > 
> > > > > > On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
> > > > > > > brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
> > > > > > > brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage
> > > > > > > value.
> > > > > > 
> > > > > > Since you're going to be resending anyway, please delete the space
> > > > > > char
> > > > > > from the start of the line.
> > > > > > 
> > > > > > It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
> > > > > > It looks like it just goes to great lengths to preserve the original
> > > > > > data in io_type...  So it likely is harmless enough but still a
> > > > > > strange
> > > > > > and complicated way write a no-op.
> > > > > 
> > > > > Not sure if it helps, but I tried to explain the reason in response to
> > > > > patch 0 (cover letter).
> > > > 
> > > > Would it make more sense to have just one patch? It's the same issue
> > > > anyway.
> > > 
> > > Yes, but I would solve it in brcmf_fil_* functions (fwil.[ch]).
> > It seems you will send a new patch to solve this issue.
> > And I guess there is no need for me to resend a v2 patchset or just one
> > patch.
> 
> I am not entirely sure. If both gcc and clang would warn about using
> uninitialized data I would be fine with these patches rolled into one.

We should definitely fix this, it's just a matter of how.  UBSan will
also detect these at run time.  And honestly, it's not clear to me where
these eventually do get copied to?  Is it to the firmware?  In that case
it might be that we'd treat these as a CVE.

regards,
dan carpenter

